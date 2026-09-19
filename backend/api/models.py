from sqlalchemy import Column, String, Integer, DateTime, ForeignKey, Float, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from pgvector.sqlalchemy import Vector
from .database import Base

class SystemMetadata(Base):
    __tablename__ = "system_metadata"
    key = Column(String, primary_key=True, index=True)
    value = Column(String)

class CardSet(Base):
    __tablename__ = "sets"
    id = Column(String, primary_key=True, index=True)
    name = Column(String, nullable=False)
    local_name = Column(String)
    set_code = Column(String)
    language = Column(String, default='en')
    region = Column(String, default='US')
    release_date = Column(String)
    total_printed = Column(Integer)
    symbol_url = Column(String)
    printings = relationship("Printing", back_populates="card_set")

class Printing(Base):
    __tablename__ = "printings"
    id = Column(String, primary_key=True, index=True)
    set_id = Column(String, ForeignKey("sets.id"))
    name = Column(String, nullable=False)
    local_name = Column(String)
    clean_name = Column(String)
    language = Column(String, default='en')
    region = Column(String, default='US')
    card_number = Column(String)
    number_clean = Column(String)
    rarity = Column(String)
    hp = Column(String)
    artist = Column(String)
    is_active = Column(Boolean, default=True)
    
    card_set = relationship("CardSet", back_populates="printings")
    reference_images = relationship("ReferenceImage", back_populates="printing")
    embeddings = relationship("PrintingEmbedding", back_populates="printing")

class ReferenceImage(Base):
    __tablename__ = "reference_images"
    id = Column(Integer, primary_key=True, autoincrement=True)
    printing_id = Column(String, ForeignKey("printings.id"))
    image_url = Column(String)
    source_name = Column(String) # e.g. "pokemontcg.io API", "local_fixture"
    
    printing = relationship("Printing", back_populates="reference_images")
    embeddings = relationship("PrintingEmbedding", back_populates="reference_image")

class PrintingEmbedding(Base):
    __tablename__ = "printing_embeddings"
    id = Column(Integer, primary_key=True, autoincrement=True)
    printing_id = Column(String, ForeignKey("printings.id"))
    reference_image_id = Column(Integer, ForeignKey("reference_images.id"))
    embedding_version = Column(String)
    model_name = Column(String)
    preprocessing_version = Column(String)
    embedding = Column(Vector(512)) # pgvector type
    
    printing = relationship("Printing", back_populates="embeddings")
    reference_image = relationship("ReferenceImage", back_populates="embeddings")
