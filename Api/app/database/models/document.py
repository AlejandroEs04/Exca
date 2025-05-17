from sqlalchemy import Column, Integer, String, Boolean
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Document(Base):
    __tablename__ = "document"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    individual_documents = relationship("IndividualDocument", back_populates="document")
    usages = relationship("DocumentUsage", back_populates="document")
    client_documents = relationship("ClientDocument", back_populates="document")