import os
import sys
import asyncio
import httpx
import re

# Add backend directory to sys.path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from api.database import SessionLocal
from api.models import CardSet, Printing, ReferenceImage, PrintingEmbedding
from api.vision import get_image_embedding

API_URL = "https://api.tcgdex.net/v2/en"

async def fetch_card_details(client, sem, card_id):
    async with sem:
        try:
            resp = await client.get(f"{API_URL}/cards/{card_id}")
            resp.raise_for_status()
            return resp.json()
        except Exception as e:
            print(f"Failed to fetch details for card {card_id}: {e}")
            return None

async def main():
    db = SessionLocal()
    
    # 1. Loop All Sets
    all_local_sets = db.query(CardSet).all()
    print(f"Found {len(all_local_sets)} sets in the local database to process.")

    # Shared semaphore for concurrent deep fetching
    sem = asyncio.Semaphore(20)

    # We can reuse the same client across the entire script
    async with httpx.AsyncClient(timeout=30.0) as client:
        
        for local_set in all_local_sets:
            print(f"\n--- Processing Set: {local_set.name} ({local_set.id}) ---")
            
            # 2. Fetch Card List for the Set
            try:
                resp = await client.get(f"{API_URL}/sets/{local_set.id}")
                resp.raise_for_status()
                set_data = resp.json()
                basic_cards = set_data.get("cards", [])
            except Exception as e:
                print(f"Failed to fetch basic card list for set {local_set.id}: {e}")
                continue
                
            if not basic_cards:
                print(f"No cards found for set {local_set.id}. Skipping.")
                continue
                
            print(f"Found {len(basic_cards)} cards. Deep fetching details...")

            # 3. Deep Fetching (Async)
            tasks = [fetch_card_details(client, sem, c["id"]) for c in basic_cards]
            detailed_cards = await asyncio.gather(*tasks)
            detailed_cards = [c for c in detailed_cards if c is not None]

            # 4. Upsert Printings & Images/Embeddings Pipeline
            stats_matched = 0
            stats_inserted = 0
            stats_embeddings = 0
            stats_failed_img = 0

            # Pre-load existing printings for this set to avoid N+1 queries
            existing_printings = {p.id: p for p in db.query(Printing).filter(Printing.set_id == local_set.id).all()}
            
            for card in detailed_cards:
                c_id = card["id"]
                c_name = card.get("name", "Unknown")
                c_clean_name = re.sub(r'[^a-zA-Z0-9]', '', c_name).lower()
                c_num = card.get("localId")
                c_rarity = card.get("rarity")
                c_hp = card.get("hp")
                c_artist = card.get("illustrator")
                c_base_image = card.get("image")

                # Upsert Printing
                printing = existing_printings.get(c_id)
                if printing:
                    # Update
                    printing.name = c_name
                    printing.clean_name = c_clean_name
                    printing.card_number = c_num
                    printing.rarity = c_rarity
                    printing.hp = c_hp
                    printing.artist = c_artist
                    stats_matched += 1
                else:
                    # Insert
                    printing = Printing(
                        id=c_id,
                        set_id=local_set.id,
                        name=c_name,
                        clean_name=c_clean_name,
                        card_number=c_num,
                        rarity=c_rarity,
                        hp=c_hp,
                        artist=c_artist
                    )
                    db.add(printing)
                    stats_inserted += 1

                # Flush so the printing has an active DB identity before checking embeddings
                db.flush()

                # Images & Embeddings Pipeline
                if not c_base_image:
                    print(f"  [{c_id}] Skipped embedding: No image URL provided.")
                    continue
                    
                img_url = f"{c_base_image}/high.webp"
                
                # Check if embedding exists
                existing_embedding = db.query(PrintingEmbedding).filter(PrintingEmbedding.printing_id == c_id).first()
                if existing_embedding:
                    # Patch version if it was null from old tests
                    existing_embedding.embedding_version = "1.0"
                    continue

                print(f"  [{c_id}] Missing embedding. Fetching {img_url} ...")
                try:
                    # Fetch image synchronously in the async loop (httpx sync client or async await)
                    # We will use the async client to download the image file
                    img_resp = await client.get(img_url, timeout=30.0)
                    img_resp.raise_for_status()
                    img_bytes = img_resp.content

                    # Generate embedding (this is CPU intensive but we execute sequentially)
                    embedding_vector = get_image_embedding(img_bytes)

                    # Upsert ReferenceImage
                    ref_img = db.query(ReferenceImage).filter(ReferenceImage.printing_id == c_id).first()
                    if not ref_img:
                        ref_img = ReferenceImage(
                            printing_id=c_id,
                            image_url=img_url,
                            source_name="tcgdex"
                        )
                        db.add(ref_img)
                        db.flush()
                    else:
                        ref_img.image_url = img_url

                    # Create PrintingEmbedding
                    new_emb = PrintingEmbedding(
                        printing_id=c_id,
                        reference_image_id=ref_img.id,
                        embedding=embedding_vector,
                        model_name="clip-ViT-B-32",
                        preprocessing_version="v2-pad-square",
                        embedding_version="1.0"
                    )
                    db.add(new_emb)
                    stats_embeddings += 1
                    
                except Exception as e:
                    print(f"  [{c_id}] Failed image/embedding pipeline: {e}")
                    stats_failed_img += 1

            # 5. Commit per Set
            try:
                db.commit()
                print(f"-> Set '{local_set.name}' Committed: {stats_inserted} Inserted, {stats_matched} Updated, {stats_embeddings} Embeddings Built ({stats_failed_img} Errors).")
            except Exception as e:
                db.rollback()
                print(f"-> Failed to commit set '{local_set.name}': {e}")

    print("\n--- MASTER SEEDER FINISHED ---")

if __name__ == "__main__":
    asyncio.run(main())
