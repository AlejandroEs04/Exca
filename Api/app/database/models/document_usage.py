from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class DocumentUsage(Base):
    __tablename__ = "document_usage"
    
    id = Column(Integer, primary_key=True, index=True)
    document_id = Column(Integer, ForeignKey("document.id"), nullable=True)
    usage_type = Column(Integer, nullable=True)
    
    document = relationship("Document", back_populates="usages")