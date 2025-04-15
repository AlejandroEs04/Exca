from sqlalchemy import Column, Integer, String
from app.database.connection import Base
from sqlalchemy.orm import relationship

class BusinessTurn(Base):
    __tablename__ = "BusinessTurn"
    
    id = Column(Integer, primary_key=True, index=True)
    description = Column(String(100), nullable=False)
    
    clients = relationship("Client", back_populates="business_turn")