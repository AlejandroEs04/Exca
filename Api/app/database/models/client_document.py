from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ClientDocument(Base):
    __tablename__ = "client_document"
    
    id = Column(Integer, primary_key=True, index=True)
    client_id = Column(Integer, ForeignKey("client.id"), nullable=False)
    document_id = Column(Integer, ForeignKey("document.id"), nullable=False)
    file_path = Column(String, nullable=False)
    uploaded_at = Column(DateTime, nullable=False, server_default=func.now())
    
    client = relationship("Client", back_populates="documents")
    document = relationship("Document", back_populates="client_documents")