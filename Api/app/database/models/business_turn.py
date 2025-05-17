from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class BusinessTurn(Base):
    __tablename__ = "business_turn"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    clients = relationship("Client", back_populates="turn")