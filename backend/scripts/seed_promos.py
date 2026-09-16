import os
import sys
import time
import urllib.request
import urllib.parse
import json

# Add parent directory to path so we can import api.models
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from api.models import CardSet, Printing, ReferenceImage, PrintingEmbedding
from api.database import SessionLocal
from api.vision import get_image_embedding, MODEL_NAME, PREPROCESSING_VERSION
from pgvector.sqlalchemy import Vector

API_SETS_URL = "https://api.pokemontcg.io/v2/sets"
API_CARDS_URL = "https://api.pokemontcg.io/v2/cards"

# Fetching all major Promo sets to ensure visual engine has embeddings for all Promos
TARGET_SETS = [
    "XY Black Star Promos",
    "Sword & Shield Black Star Promos",
    "Sun & Moon Black Star Promos",
    "Scarlet & Violet Black Star Promos",
    "SM Black Star Promos",
    "SWSH Black Star Promos",
    "SVP Black Star Promos"
]

def fetch_json(url):
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    try:
        with urllib.request.urlopen(req) as response:
            if response.status == 200:
                return json.loads(response.read().decode())
    except urllib.error.HTTPError as e:
        if e.code == 429:
            print("    -> Rate limited! Sleeping for 5s...")
            time.sleep(5)
            return fetch_json(url)
        print(f"HTTP Error {e.code} on {url}")
    except Exception as e:
        print(f"Error fetching {url}: {e}")
    return None

def download_image(url):
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    try:
        with urllib.request.urlopen(req) as response:
            if response.status == 200:
                return response.read()
    except Exception as e:
        print(f"Error downloading image from {url}: {e}")
    return None

def main():
    print("Starting Promo sets seeder...")
    db = SessionLocal()
    
    # 1. Bypass broken API sets endpoint and hardcode the MEP set
    matched_sets = [
        {"id": "mep", "name": "Mega Evolution Black Star Promos", "series": "Mega Evolution"}
    ]
    
    print(f"Found {len(matched_sets)} sets: {[s['name'] for s in matched_sets]}")
    
    for api_set in matched_sets:
        set_id = api_set["id"]
        set_name = api_set["name"]
        print(f"\n--- Processing Promo Set: {set_name} ({set_id}) ---")
        
        # Upsert CardSet
        db_set = db.query(CardSet).filter(CardSet.id == set_id).first()
        if not db_set:
            db_set = CardSet(id=set_id)
            db.add(db_set)
            
        db_set.name = set_name
        db_set.set_code = api_set.get("ptcgoCode") or api_set.get("series") # using series as fallback if no ptcgoCode
        db_set.series = api_set.get("series")
        db_set.release_date = api_set.get("releaseDate")
        db_set.total_printed = api_set.get("printedTotal")
        db_set.symbol_url = api_set.get("images", {}).get("symbol")
        db_set.logo_url = api_set.get("images", {}).get("logo")
        db.commit()
        
        # 2. Fetch all cards for this set
        print(f"Fetching cards for {set_name}...")
        page = 1
        all_cards = []
        while True:
            cards_url = f"{API_CARDS_URL}?q=set.id:{set_id}&page={page}"
            cards_data = fetch_json(cards_url)
            if not cards_data or "data" not in cards_data:
                break
                
            page_cards = cards_data["data"]
            if not page_cards:
                break
                
            all_cards.extend(page_cards)
            page += 1
            time.sleep(1) # rate limit prevention
            
        print(f"Found {len(all_cards)} Promo cards in {set_name}.")
        
        for api_card in all_cards:
            card_id = api_card["id"]
            name = api_card["name"]
            number = api_card["number"]
            print(f"  -> Processing {card_id}: {name} #{number}")
            
            # Upsert Printing
            db_printing = db.query(Printing).filter(Printing.id == card_id).first()
            if not db_printing:
                db_printing = Printing(id=card_id, set_id=set_id)
                db.add(db_printing)
                
            db_printing.name = name
            db_printing.clean_name = name.lower().replace(" ", "").replace("-", "")
            db_printing.card_number = number
            db_printing.number_clean = "".join(filter(str.isdigit, number))
            db_printing.rarity = api_card.get("rarity")
            db_printing.hp = api_card.get("hp")
            db_printing.artist = api_card.get("artist")
            db_printing.is_active = True
            db.commit()
            
            # 3. Upsert ReferenceImage
            img_url = api_card.get("images", {}).get("large")
            if not img_url:
                img_url = api_card.get("images", {}).get("small")
                
            if img_url:
                ref_img = db.query(ReferenceImage).filter(ReferenceImage.printing_id == card_id).first()
                if not ref_img:
                    ref_img = ReferenceImage(printing_id=card_id)
                    db.add(ref_img)
                
                ref_img.image_url = img_url
                ref_img.source_name = "pokemontcg.io API (Promo Seeder)"
                db.commit()
                
                # 4. Generate and save CLIP embedding
                existing_emb = db.query(PrintingEmbedding).filter(
                    PrintingEmbedding.printing_id == card_id,
                    PrintingEmbedding.model_name == MODEL_NAME,
                    PrintingEmbedding.preprocessing_version == PREPROCESSING_VERSION
                ).first()
                
                if not existing_emb:
                    print(f"     Downloading image for CLIP embedding...")
                    img_bytes = download_image(img_url)
                    if img_bytes:
                        try:
                            print(f"     Generating CLIP vector...")
                            embedding_vector = get_image_embedding(img_bytes)
                            
                            new_emb = PrintingEmbedding(
                                printing_id=card_id,
                                reference_image_id=ref_img.id,
                                embedding_version="1.0",
                                model_name=MODEL_NAME,
                                preprocessing_version=PREPROCESSING_VERSION,
                                embedding=embedding_vector
                            )
                            db.add(new_emb)
                            db.commit()
                            print(f"     Saved embedding for {card_id}.")
                        except Exception as e:
                            print(f"     Error generating embedding: {e}")
                            db.rollback()
                    time.sleep(0.5) # small delay after image download
            
    print("\nPromo Seeding complete!")

if __name__ == "__main__":
    main()
