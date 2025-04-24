from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class DocumentEntity(Base):
    __tablename__ = "document_entity"
    
    document_type_id = Column(Integer, ForeignKey("document_type.id"), primary_key=True)
    document_id = Column(Integer, ForeignKey("document.id"), primary_key=True)
    
    type = relationship("DocumentType", back_populates="entities")
    document = relationship("Document", back_populates="entities")