from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class DocumentType(Base):
    __tablename__ = "document_type"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    entities = relationship("DocumentEntity", back_populates="type")