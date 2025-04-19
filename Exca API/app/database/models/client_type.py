from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ClientType(Base):
    __tablename__ = "client_type"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    clients = relationship("Client", back_populates="client_type")