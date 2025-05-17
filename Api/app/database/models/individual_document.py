from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class IndividualDocument(Base):
    __tablename__ = "individual_document"
    
    id = Column(Integer, primary_key=True, index=True)
    individual_id = Column(Integer, ForeignKey("individual.id"), nullable=False)
    document_id = Column(Integer, ForeignKey("document.id"), nullable=False)
    file_path = Column(String, nullable=False)
    uploaded_at = Column(DateTime, nullable=False, server_default=func.now())

    
    individual = relationship("Individual", back_populates="documents")
    document = relationship("Document", back_populates="individual_documents")