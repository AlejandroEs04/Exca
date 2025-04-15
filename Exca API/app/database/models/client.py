from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Client(Base):
    __tablename__ = "Client"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    email = Column(String(150), nullable=True)
    turnId = Column(Integer, ForeignKey("BusinessTurn.id"), nullable=False)
    
    business_turn = relationship("BusinessTurn", back_populates="clients")