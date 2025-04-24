from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class IndividualDocument(Base):
    __tablename__ = "individual_document"
    
    individual_id = Column(Integer, ForeignKey("individual.id"), nullable=False)
    document_id = Column(Integer, ForeignKey("document.id"), nullable=False)
    
    individual = relationship("Individual", back_populates="documents")
    document = relationship("Document", back_populates="individual_documents")