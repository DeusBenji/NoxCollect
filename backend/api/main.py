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
    x_request_id: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    t_start = time.time()
    req_id = x_request_id or "unknown"
    
    image_bytes = await file.read()
    size_bytes = len(image_bytes)
    logger.info(f"[{req_id}] Received POST /recognize: size={size_bytes} bytes | OCR: name={ocr_name}, number={ocr_number}")
    
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
        
        sim_score = max(0.0, 1.0 - distance) # Cosine distance to similarity
        
        logger.info(f"[{req_id}] #{rank} ID: {print_record.id} | {print_record.name} | {print_record.card_number} | Cos: {distance:.4f} | Sim: {sim_score:.4f}")
        
        candidates.append({
            "id": print_record.id,
            "name": print_record.name,
            "localName": print_record.local_name,
            "language": print_record.language,
            "region": print_record.region,
            "cardNumber": print_record.card_number,
            "setCode": card_set.set_code if card_set else None,
            "distance": distance,
            "similarity": sim_score,
            "referenceImageId": emb_record.reference_image_id
        })
        
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
