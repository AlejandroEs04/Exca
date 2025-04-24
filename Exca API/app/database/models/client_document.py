from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ClientDocument(Base):
    __tablename__ = "client_document"
    
    client_id = Column(Integer, primary_key=True, index=True)
    document_id = Column(Integer, nullable=False)