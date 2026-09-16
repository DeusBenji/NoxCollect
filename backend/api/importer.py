import urllib.request
import logging
from sqlalchemy.orm import Session
from .database import engine, Base, SessionLocal
from . import models
from .vision import get_image_embedding, MODEL_NAME, PREPROCESSING_VERSION

logger = logging.getLogger(__name__)

# Sample Data
SETS = [
    {"id": "xy4", "name": "Phantom Forces", "set_code": "PHF", "language": "en", "region": "US"},
    {"id": "ja-m1l", "name": "Mega Brave", "local_name": "メガブレイブ", "set_code": "M1L", "language": "ja", "region": "JP"},
    {"id": "promo-mep", "name": "Promo MEP", "set_code": "MEP", "language": "en", "region": "US"}
]

PRINTINGS = [
    {
        "id": "xy4-41", "set_id": "xy4", "name": "Gourgeist ex", 
        "clean_name": "gourgeistex", "card_number": "041/086", "number_clean": "041",
        "image_url": "https://images.pokemontcg.io/xy4/41_hires.png"
    },
    {
        "id": "ja-m1l-078", "set_id": "ja-m1l", "name": "Mega Lucario ex",
        "local_name": "メガルカリオex", "clean_name": "megalucarioex",
        "card_number": "078/063", "number_clean": "078",
        "language": "ja", "region": "JP",
        # Using an arbitrary english proxy image for visual testing of the pipeline
        "image_url": "https://images.pokemontcg.io/xy3/55_hires.png"
    },
    {
        "id": "promo-mep-073", "set_id": "promo-mep", "name": "Mega Gengar ex",
        "clean_name": "megagengarex", "card_number": "MEP 073", "number_clean": "mep073",
        "image_url": "https://images.pokemontcg.io/xy4/120_hires.png",
        "is_active": False
    }
]

def run_import():
    # Enable pgvector first
    from sqlalchemy import text
    with engine.connect() as conn:
        conn.execute(text("CREATE EXTENSION IF NOT EXISTS vector"))
        conn.commit()
    # Ensure tables exist
    models.Base.metadata.drop_all(bind=engine)
    models.Base.metadata.create_all(bind=engine)
    db = SessionLocal()
    try:
        # Create sets
        for s in SETS:
            if not db.query(models.CardSet).filter_by(id=s["id"]).first():
                db.add(models.CardSet(**s))
        db.commit()

        # Create printings and embeddings
        for p in PRINTINGS:
            image_url = p.pop("image_url")
            print_obj = db.query(models.Printing).filter_by(id=p["id"]).first()
            if not print_obj:
                print_obj = models.Printing(**p)
                db.add(print_obj)
                db.commit()
                db.refresh(print_obj)
            
            # Check if embedding exists
            if not db.query(models.PrintingEmbedding).filter_by(printing_id=print_obj.id).first():
                print(f"Downloading reference image for {print_obj.name}...")
                req = urllib.request.Request(image_url, headers={'User-Agent': 'Mozilla/5.0'})
                with urllib.request.urlopen(req) as response:
                    img_bytes = response.read()
                
                print(f"Generating embedding for {print_obj.name}...")
                embedding = get_image_embedding(img_bytes)
                
                ref_img = models.ReferenceImage(
                    printing_id=print_obj.id,
                    image_url=image_url,
                    source_name="pokemontcg.io API (benchmark proxy)"
                )
                db.add(ref_img)
                db.commit()
                db.refresh(ref_img)
                
                emb = models.PrintingEmbedding(
                    printing_id=print_obj.id,
                    reference_image_id=ref_img.id,
                    embedding_version="1.0",
                    model_name=MODEL_NAME,
                    preprocessing_version=PREPROCESSING_VERSION,
                    embedding=embedding
                )
                db.add(emb)
                db.commit()
                print(f"Imported {print_obj.name} successfully.")
    finally:
        db.close()

if __name__ == "__main__":
    run_import()
