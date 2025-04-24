from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Document(Base):
    __tablename__ = "document"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    entities = relationship("DocumentEntity", back_populates="document")
    individual_documents = relationship("IndividualDocument", back_populates="document")