import os
import sys
import httpx

# Add backend directory to sys.path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from api.database import SessionLocal
from api.models import CardSet, Printing, ReferenceImage, PrintingEmbedding
from api.vision import get_image_embedding

API_URL = "https://api.pokewallet.io"
API_KEY = "INSERT_API_KEY_HERE"
HEADERS = {"X-API-Key": API_KEY}
TARGET_SET_NAME = "Destined Rivals"
TARGET_SET_CODE = "DRI"

def run_poc():
    db = SessionLocal()
    
    # 1. Fetch Sets to find matching Pokewallet Set
    print("Fetching sets from Pokéwallet to find match...")
    resp = httpx.get(f"{API_URL}/sets", headers=HEADERS)
    resp.raise_for_status()
    pw_sets_data = resp.json()
    pw_sets = pw_sets_data.get("data", pw_sets_data) if isinstance(pw_sets_data, dict) else pw_sets_data

    pw_set = None
    pw_set_code = None
    for s in pw_sets:
        code = s.get("setCode") or s.get("set_code") or s.get("set_id")
        name = s.get("name", "")
        if name.lower() == TARGET_SET_NAME.lower() or (code and code.lower() == TARGET_SET_CODE.lower()):
            pw_set = s
            pw_set_code = code
            break
            
    if not pw_set:
        print(f"Could not find a set on Pokéwallet API matching '{TARGET_SET_NAME}' or '{TARGET_SET_CODE}'. Exiting.")
        return

    print(f"Matched Pokéwallet Set: {pw_set.get('name')} (Code: {pw_set_code})")

    # 2. Check if set exists in local database, create if not
    local_set = db.query(CardSet).filter((CardSet.name.ilike(pw_set.get('name'))) | (CardSet.set_code.ilike(pw_set_code))).first()
    if local_set:
        print(f"Local Set found: {local_set.name} (ID: {local_set.id})")
        set_db_id = local_set.id
    else:
        set_db_id = pw_set.get("id", pw_set_code)
        print(f"Local Set NOT found. Creating new CardSet with ID: {set_db_id}")
        new_set = CardSet(
            id=set_db_id,
            name=pw_set.get("name"),
            set_code=pw_set_code,
            language="en",
            symbol_url=f"{API_URL}/sets/{pw_set_code}/image"
        )
        db.add(new_set)
        db.commit()

    # 3. Fetch Cards for the Set (Handling Pagination)
    print(f"Fetching cards for set '{pw_set_code}'...")
    page = 1
    has_more = True
    all_pw_cards = []
    
    while has_more:
        url = f"{API_URL}/sets/{pw_set_code}"
        if page > 1:
            url += f"?page={page}"
            
        resp = httpx.get(url, headers=HEADERS, timeout=20.0)
        resp.raise_for_status()
        cards_data = resp.json()
        
        if isinstance(cards_data, dict):
            page_cards = cards_data.get("data", cards_data.get("cards", []))
            total_pages = cards_data.get("total_pages", 1)
            has_more = page < total_pages
        else:
            page_cards = cards_data
            has_more = False
            
        all_pw_cards.extend(page_cards)
        page += 1
    
    print(f"Processing all {len(all_pw_cards)} cards...")

    stats_matched = 0
    stats_inserted = 0
    stats_embeddings = 0

    local_cards = db.query(Printing).filter(Printing.set_id == set_db_id).all()
    
    for card in all_pw_cards:
        pw_card_id = card.get("id")
        # CRITICAL FIX: Extract from card_info
        card_info = card.get("card_info", {})
        
        c_name = card_info.get("name")
        c_clean_name = card_info.get("clean_name") or card_info.get("cleanName")
        c_num = card_info.get("cardNumber") or card_info.get("card_number")
        c_rarity = card_info.get("rarity")
        c_image = card.get("imageUrl") or card_info.get("imageUrl") or card_info.get("image_url")

        if not c_name:
            print(f"Skipping card {pw_card_id}: Missing name in card_info.")
            continue

        # Match local printing
        matched_printing = None
        for lc in local_cards:
            if (lc.name == c_name) or (c_clean_name and lc.clean_name == c_clean_name) or (c_num and lc.card_number == c_num):
                matched_printing = lc
                break

        if matched_printing:
            print(f"  [MATCHED] Local ID: {matched_printing.id} | Name: {c_name}")
            matched_printing.rarity = c_rarity or matched_printing.rarity
            stats_matched += 1
            printing_id = matched_printing.id
        else:
            print(f"  [INSERTED] New Card: {pw_card_id} | Name: {c_name}")
            new_printing = Printing(
                id=pw_card_id,
                set_id=set_db_id,
                name=c_name,
                clean_name=c_clean_name,
                card_number=c_num,
                rarity=c_rarity
            )
            db.add(new_printing)
            db.flush()
            
            # Add to local_cards so subsequent matches (like duplicates in same set) don't duplicate
            local_cards.append(new_printing)
            
            stats_inserted += 1
            printing_id = pw_card_id

        # 4. Images & Embeddings Pipeline
        existing_embedding = db.query(PrintingEmbedding).filter(PrintingEmbedding.printing_id == printing_id).first()
        
        if not existing_embedding:
            print(f"    -> Missing embedding for {printing_id}. Fetching image...")
            try:
                img_resp = httpx.get(f"{API_URL}/images/{pw_card_id}?size=high", headers=HEADERS, timeout=20.0)
                img_resp.raise_for_status()
                img_bytes = img_resp.content
                
                # Get Embedding
                embedding_vector = get_image_embedding(img_bytes)
                
                # Create Reference Image
                ref_img = db.query(ReferenceImage).filter(ReferenceImage.printing_id == printing_id).first()
                if not ref_img:
                    ref_img = ReferenceImage(
                        printing_id=printing_id, 
                        image_url=c_image or f"{API_URL}/images/{pw_card_id}?size=high",
                        source_name="pokewallet"
                    )
                    db.add(ref_img)
                    db.flush()
                else:
                    ref_img.image_url = c_image or ref_img.image_url
                
                # Create Embedding
                new_emb = PrintingEmbedding(
                    printing_id=printing_id,
                    reference_image_id=ref_img.id,
                    embedding=embedding_vector,
                    model_name="clip-vit-base-patch32",
                    embedding_version="1.0"
                )
                db.add(new_emb)
                stats_embeddings += 1
                print(f"    -> Successfully embedded & saved!")
            except Exception as e:
                print(f"    -> Failed to generate embedding for {printing_id}: {e}")
        else:
            print(f"    -> Embedding already exists for {printing_id}.")

    db.commit()
    print("\n--- POC SYNC SUMMARY ---")
    print(f"Matched & Updated: {stats_matched}")
    print(f"Newly Inserted: {stats_inserted}")
    print(f"Embeddings Generated: {stats_embeddings}")
    print("Done!")

if __name__ == "__main__":
    run_poc()
