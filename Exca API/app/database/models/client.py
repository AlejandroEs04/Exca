from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Client(Base):
    __tablename__ = "client"
    
    id = Column(Integer, primary_key=True, index=True)
    business_name = Column(String, nullable=False)
    email = Column(String, nullable=True)
    phone_number = Column(String, nullable=True)
    tax_id = Column(String, nullable=True)
    address = Column(String, nullable=True)
    type_id = Column(Integer, ForeignKey("client_type.id"), nullable=False)
    turn_id = Column(Integer, ForeignKey("business_turn.id"), nullable=True)
    
    client_type = relationship("ClientType", back_populates="clients")
    brands = relationship("Brand", back_populates="client")
    turn = relationship("BusinessTurn", back_populates="clients")