import logging
import time
from contextlib import asynccontextmanager
from fastapi import FastAPI, File, UploadFile, Depends, HTTPException, Header, Form
from sqlalchemy.orm import Session
from sqlalchemy import text
from typing import List, Dict, Any, Optional

from .database import get_db, engine, Base
from . import models
from .vision import get_embedding_from_image, decode_image, warmup, MODEL_NAME, PREPROCESSING_VERSION, model

# Create tables and extension
with engine.connect() as conn:
    conn.execute(text("CREATE EXTENSION IF NOT EXISTS vector"))
    conn.execute(text("CREATE EXTENSION IF NOT EXISTS pg_trgm"))
    conn.commit()
models.Base.metadata.create_all(bind=engine)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Load model and warm up ONCE on startup
    warmup()
    yield
    # Shutdown

app = FastAPI(title="NoxCollect Recognition Backend", lifespan=lifespan)

@app.get("/health")
def health_check():
    return {
        "status": "ok" if model is not None else "loading",
        "model": MODEL_NAME
    }

@app.post("/recognize")
async def recognize_card(
    file: UploadFile = File(...),
    ocr_name: Optional[str] = Form(None),
    ocr_number: Optional[str] = Form(None),
    ocr_set_code: Optional[str] = Form(None),
    x_request_id: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    t_start = time.time()
    req_id = x_request_id or "unknown"
    
    image_bytes = await file.read()
    size_bytes = len(image_bytes)
    logger.info(f"[{req_id}] Received POST /recognize: size={size_bytes} bytes | OCR: name={ocr_name}, number={ocr_number}, set={ocr_set_code}")
    
    # 1. Decode / Preprocess
    t_decode_start = time.time()
    try:
        img = decode_image(image_bytes)
    except Exception as e:
        logger.error(f"[{req_id}] Image decode failed: {e}")
        raise HTTPException(status_code=400, detail=f"Image decoding failed: {str(e)}")
    t_decode = time.time() - t_decode_start
    
    # 2. Inference
    t_infer_start = time.time()
    try:
        query_embedding = get_embedding_from_image(img)
    except Exception as e:
        logger.error(f"[{req_id}] Embedding failed: {e}")
        raise HTTPException(status_code=500, detail=f"Inference failed: {str(e)}")
    t_infer = time.time() - t_infer_start
    
    # 3. Query pgvector for Top-K with OCR Filtering
    t_pgvector_start = time.time()
    top_k = 10
    
    results = []
    
    # Base query joined with embeddings
    base_query = db.query(
        models.PrintingEmbedding, 
        models.Printing,
        models.PrintingEmbedding.embedding.cosine_distance(query_embedding).label('distance')
    ).join(
        models.Printing, models.PrintingEmbedding.printing_id == models.Printing.id
    ).filter(
        models.Printing.is_active == True
    )

    if ocr_number or ocr_name:
        query = base_query
        # Attempt 1: OCR Filtering
        if ocr_number and ocr_number.strip():
            # Exact or highly similar number match
            query = query.filter(models.Printing.card_number.ilike(ocr_number.strip()))
            
            if ocr_name and ocr_name.strip():
                # Fuzzy name match with pg_trgm (similarity > 0.1 allows OCR typos)
                # op('<->') is distance (1 - similarity), so < 0.9 means similarity > 0.1
                query = query.filter(models.Printing.name.op('<->')(ocr_name.strip()) < 0.9)
                
        elif ocr_name and ocr_name.strip():
            # Promo Fallback: Name only using pg_trgm fuzzy match
            query = query.filter(models.Printing.name.op('<->')(ocr_name.strip()) < 0.8) # Stricter similarity > 0.2
            
        results = query.order_by('distance').limit(top_k).all()

    # Attempt 2: Visual Fallback (If OCR yielded nothing or no OCR provided)
    if not results:
        logger.info(f"[{req_id}] OCR filter yielded 0 results or was missing. Falling back to pure visual search.")
        results = base_query.order_by('distance').limit(top_k).all()
        
    t_pgvector = time.time() - t_pgvector_start
    
    # 4. Serialization
    t_serial_start = time.time()
    candidates = []
    logger.info(f"[{req_id}] Returning Top-{len(results)} results:")
    for rank, (emb_record, print_record, distance) in enumerate(results, 1):
        card_set = db.query(models.CardSet).filter(models.CardSet.id == print_record.set_id).first()
        ref_img = db.query(models.ReferenceImage).filter(models.ReferenceImage.id == emb_record.reference_image_id).first()
        
        sim_score = max(0.0, 1.0 - distance) # Cosine distance to similarity
        
        if ocr_set_code and ocr_set_code.strip() and card_set and card_set.set_code:
            if ocr_set_code.strip().lower() == card_set.set_code.lower():
                sim_score *= 1.15
                logger.info(f"[{req_id}] Boosting {print_record.id} score by 1.15x for Set Code match ({card_set.set_code})")
        
        logger.info(f"[{req_id}] #{rank} ID: {print_record.id} | {print_record.name} | {print_record.card_number} | Cos: {distance:.4f} | Sim: {sim_score:.4f}")
        
        candidates.append({
            "id": print_record.id,
            "name": print_record.name,
            "localName": print_record.local_name,
            "language": print_record.language,
            "region": print_record.region,
            "cardNumber": print_record.card_number,
            "setCode": card_set.set_code if card_set else None,
            "setSymbolUrl": card_set.symbol_url if card_set and card_set.symbol_url else (
                "https://images.pokemontcg.io/base1/symbol.png" if card_set and card_set.set_code == 'PFL' else None
            ),
            "rarity": print_record.rarity,
            "imageUrl": ref_img.image_url if ref_img else None,
            "distance": distance,
            "similarity": sim_score,
            "referenceImageId": emb_record.reference_image_id
        })
        
    # Sort descending by updated similarity
    candidates.sort(key=lambda x: x["similarity"], reverse=True)
        
    t_serial = time.time() - t_serial_start
    t_total = time.time() - t_start
    
    logger.info(f"[{req_id}] Endpoint trace: decode={t_decode*1000:.1f}ms infer={t_infer*1000:.1f}ms pgvector={t_pgvector*1000:.1f}ms serial={t_serial*1000:.1f}ms total={t_total*1000:.1f}ms")
    
    return {
        "status": "success",
        "requestId": req_id,
        "model": MODEL_NAME,
        "preprocessing": PREPROCESSING_VERSION,
        "metrics": {
            "decode_ms": t_decode * 1000,
            "infer_ms": t_infer * 1000,
            "pgvector_ms": t_pgvector * 1000,
            "serial_ms": t_serial * 1000,
            "total_ms": t_total * 1000
        },
        "candidates": candidates
    }

@app.get("/search")
def search_cards(q: str, db: Session = Depends(get_db)):
    """Search for cards by name and optionally number (e.g. 'Gourgeist 041' or 'Charizard')"""
    if not q or not q.strip():
        return {"results": []}
        
    query_parts = q.strip().split()
    
    # Base query joined with ReferenceImage and CardSet
    query = db.query(models.Printing, models.ReferenceImage, models.CardSet).outerjoin(
        models.ReferenceImage, models.Printing.id == models.ReferenceImage.printing_id
    ).outerjoin(
        models.CardSet, models.Printing.set_id == models.CardSet.id
    ).filter(models.Printing.is_active == True)
    
    if len(query_parts) == 1:
        # Single word, assume it's a name
        search_term = query_parts[0]
        query = query.filter(models.Printing.name.ilike(f"%{search_term}%"))
    else:
        # Multiple words. Assume the last part might be a number
        possible_num = query_parts[-1]
        name_part = " ".join(query_parts[:-1])
        
        # We try to match: name ILIKE name_part AND (card_number ILIKE possible_num OR number_clean == possible_num)
        # OR just name ILIKE full_query if the last part wasn't a number
        from sqlalchemy import or_, and_
        query = query.filter(
            or_(
                and_(
                    models.Printing.name.ilike(f"%{name_part}%"),
                    or_(
                        models.Printing.card_number.ilike(f"%{possible_num}%"),
                        models.Printing.number_clean == "".join(filter(str.isdigit, possible_num))
                    )
                ),
                models.Printing.name.ilike(f"%{q}%")
            )
        )
        
    # Execute query, limit 50
    results = query.limit(50).all()
    
    # Serialize
    serialized = []
    for print_record, ref_img, card_set in results:
        serialized.append({
            "id": print_record.id,
            "name": print_record.name,
            "setId": print_record.set_id,
            "setCode": card_set.set_code if card_set else None,
            "setSymbolUrl": card_set.symbol_url if card_set and card_set.symbol_url else (
                "https://images.pokemontcg.io/base1/symbol.png" if card_set and card_set.set_code == 'PFL' else None
            ),
            "cardNumber": print_record.card_number,
            "rarity": print_record.rarity,
            "imageUrl": ref_img.image_url if ref_img else None
        })
        
    return {"results": serialized}
