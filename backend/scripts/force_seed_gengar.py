import os
import sys
import urllib.request

sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from api.models import CardSet, Printing, ReferenceImage, PrintingEmbedding
from api.database import SessionLocal
from api.vision import get_image_embedding, MODEL_NAME, PREPROCESSING_VERSION

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
    print("Forcing Mega Gengar EX Promo into database...")
    db = SessionLocal()
    
    set_id = "promo-mep"
    card_id = "promo-mep-073"
    name = "Mega Gengar ex"
    number = "073"
    img_url = "https://limitlesstcg.nyc3.cdn.digitaloceanspaces.com/tpci/MEP/MEP_073_R_EN_LG.png"
    
    # Upsert Set
    db_set = db.query(CardSet).filter(CardSet.id == set_id).first()
    if not db_set:
        db_set = CardSet(id=set_id, name="Mega Evolution Promo", set_code="MEP", series="Mega Evolution")
        db.add(db_set)
    db.commit()
    
    # Upsert Printing
    db_printing = db.query(Printing).filter(Printing.id == card_id).first()
    if not db_printing:
        db_printing = Printing(id=card_id, set_id=set_id)
        db.add(db_printing)
    db_printing.name = name
    db_printing.clean_name = "megagengarex"
    db_printing.card_number = number
    db_printing.number_clean = "073"
    db_printing.rarity = "Promo"
    db_printing.is_active = True
    db.commit()
    
    # Upsert Image
    ref_img = db.query(ReferenceImage).filter(ReferenceImage.printing_id == card_id).first()
    if not ref_img:
        ref_img = ReferenceImage(printing_id=card_id)
        db.add(ref_img)
    ref_img.image_url = img_url
    ref_img.source_name = "Manual Override"
    db.commit()
    
    # Generate Embedding
    existing_emb = db.query(PrintingEmbedding).filter(PrintingEmbedding.printing_id == card_id).first()
    if not existing_emb:
        print("Downloading image to generate CLIP vector...")
        img_bytes = download_image(img_url)
        if img_bytes:
            print("Running PyTorch CLIP model...")
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
            print("Successfully saved CLIP embedding!")
        else:
            print("Failed to download image.")
    else:
        print("CLIP embedding already exists.")
        
    print("Done! Restart your FastAPI server.")

if __name__ == "__main__":
    main()
