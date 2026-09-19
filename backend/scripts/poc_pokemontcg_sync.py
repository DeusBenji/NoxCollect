import os
import sys
import httpx
import urllib.parse
import re

# Add backend directory to sys.path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from api.database import SessionLocal
from api.models import CardSet, Printing, ReferenceImage, PrintingEmbedding
from api.vision import get_image_embedding

API_URL = "https://api.pokemontcg.io/v2"
TARGET_SET_ID = "sv10"

def run_poc():
    db = SessionLocal()
    
    # 1. Fetch Cards from PokémonTCG.io to get Set Info AND Cards
    print(f"Fetching cards for set '{TARGET_SET_ID}' from PokémonTCG.io...")
    query = urllib.parse.quote(f'set.id:{TARGET_SET_ID}')
    
    page = 1
    has_more = True
    all_ptcg_cards = []
    
    while has_more:
        url = f"{API_URL}/cards?q={query}&page={page}&pageSize=250"
        resp = httpx.get(url, timeout=20.0)
        resp.raise_for_status()
        cards_data = resp.json()
        
        page_cards = cards_data.get("data", [])
        all_ptcg_cards.extend(page_cards)
        
        total_count = cards_data.get("totalCount", 0)
        if len(all_ptcg_cards) >= total_count or not page_cards:
            has_more = False
        else:
            page += 1

    if not all_ptcg_cards:
        print(f"Could not find any cards matching set '{TARGET_SET_ID}' on PokémonTCG.io. Exiting.")
        return

    # Extract Set Info from the first card
    ptcg_set = all_ptcg_cards[0].get("set", {})
    ptcg_set_id = ptcg_set.get("id")
    ptcg_set_name = ptcg_set.get("name")
    ptcg_set_code = ptcg_set.get("ptcgoCode") or ptcg_set_id
    printed_code = ptcg_set.get("ptcgoCode")
    symbol_url = ptcg_set.get("images", {}).get("symbol", "")
    
    print(f"Matched Set: {ptcg_set_name} (ID: {ptcg_set_id})")

    # 2. Check if set exists in local database, create if not
    local_set = db.query(CardSet).filter((CardSet.name.ilike(ptcg_set_name)) | (CardSet.id == ptcg_set_id)).first()
    if local_set:
        print(f"Local Set found: {local_set.name} (ID: {local_set.id})")
        set_db_id = local_set.id
        # Patch missing printed_code
        local_set.printed_code = printed_code
    else:
        set_db_id = ptcg_set_id
        print(f"Local Set NOT found. Creating new CardSet with ID: {set_db_id}")
        new_set = CardSet(
            id=set_db_id,
            name=ptcg_set_name,
            set_code=ptcg_set_code,
            printed_code=printed_code,
            language="en",
            symbol_url=symbol_url
        )
        db.add(new_set)
        db.commit()

    print(f"Processing all {len(all_ptcg_cards)} cards...")

    stats_matched = 0
    stats_inserted = 0
    stats_embeddings = 0

    local_cards = db.query(Printing).filter(Printing.set_id == set_db_id).all()
    
    for card in all_ptcg_cards:
        c_id = card.get("id")
        c_name = card.get("name")
        c_num = card.get("number")
        c_rarity = card.get("rarity")
        c_hp = card.get("hp")
        c_artist = card.get("artist")
        c_image = card.get("images", {}).get("large") or card.get("images", {}).get("small")

        if not c_name:
            print(f"Skipping card {c_id}: Missing name.")
            continue
            
        c_clean_name = re.sub(r'[^a-zA-Z0-9]', '', c_name).lower()

        # Match local printing by name OR card_number
        matched_printing = None
        for lc in local_cards:
            if (lc.name == c_name) or (c_num and lc.card_number == c_num):
                matched_printing = lc
                break

        if matched_printing:
            print(f"  [MATCHED] Local ID: {matched_printing.id} | Name: {c_name}")
            matched_printing.clean_name = c_clean_name
            matched_printing.rarity = c_rarity or matched_printing.rarity
            matched_printing.hp = c_hp or matched_printing.hp
            matched_printing.artist = c_artist or matched_printing.artist
            matched_printing.card_number = c_num or matched_printing.card_number
            
            stats_matched += 1
            printing_id = matched_printing.id
        else:
            print(f"  [INSERTED] New Card: {c_id} | Name: {c_name}")
            new_printing = Printing(
                id=c_id,
                set_id=set_db_id,
                name=c_name,
                clean_name=c_clean_name,
                card_number=c_num,
                rarity=c_rarity,
                hp=c_hp,
                artist=c_artist
            )
            db.add(new_printing)
            db.flush()
            
            # Add to local_cards so subsequent matches don't duplicate
            local_cards.append(new_printing)
            
            stats_inserted += 1
            printing_id = c_id

        # 4. Images & Embeddings Pipeline
        existing_embedding = db.query(PrintingEmbedding).filter(PrintingEmbedding.printing_id == printing_id).first()
        
        if not existing_embedding and c_image:
            print(f"    -> Missing embedding for {printing_id}. Fetching image...")
            try:
                img_resp = httpx.get(c_image, timeout=30.0)
                img_resp.raise_for_status()
                img_bytes = img_resp.content
                
                # Get Embedding
                embedding_vector = get_image_embedding(img_bytes)
                
                # Create Reference Image
                ref_img = db.query(ReferenceImage).filter(ReferenceImage.printing_id == printing_id).first()
                if not ref_img:
                    ref_img = ReferenceImage(
                        printing_id=printing_id, 
                        image_url=c_image,
                        source_name="pokemontcg.io"
                    )
                    db.add(ref_img)
                    db.flush()
                else:
                    ref_img.image_url = c_image
                
                # Create Embedding
                new_emb = PrintingEmbedding(
                    printing_id=printing_id,
                    reference_image_id=ref_img.id,
                    embedding=embedding_vector,
                    model_name="clip-ViT-B-32",
                    preprocessing_version="v2-pad-square",
                    embedding_version="1.0"
                )
                db.add(new_emb)
                stats_embeddings += 1
                print(f"    -> Successfully embedded & saved!")
            except Exception as e:
                print(f"    -> Failed to generate embedding for {printing_id}: {e}")
        elif existing_embedding:
            existing_embedding.embedding_version = "1.0"
            print(f"    -> Embedding already exists for {printing_id}. Patched version.")
        elif not c_image:
            print(f"    -> No image URL available for {printing_id}.")

    db.commit()
    print("\n--- POKÉMONTCG.IO SYNC SUMMARY ---")
    print(f"Matched & Updated: {stats_matched}")
    print(f"Newly Inserted: {stats_inserted}")
    print(f"Embeddings Generated: {stats_embeddings}")
    print("Done!")

if __name__ == "__main__":
    run_poc()
