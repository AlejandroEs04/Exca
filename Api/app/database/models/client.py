from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Client(Base):
    __tablename__ = "client"
    
    id = Column(Integer, primary_key=True, index=True)
    business_name = Column(String, nullable=False)
    email = Column(String, nullable=True)
    phone_number = Column(String, nullable=True)
    tax_id = Column(String, nullable=True)
    type_id = Column(Integer, ForeignKey("client_type.id"), nullable=False)
    turn_id = Column(Integer, ForeignKey("business_turn.id"), nullable=True)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    
    client_type = relationship("ClientType", back_populates="clients")
    brands = relationship("Brand", back_populates="client")
    turn = relationship("BusinessTurn", back_populates="clients")
    address = relationship("ClientAddress", back_populates="client")
    documents = relationship("ClientDocument", back_populates="client")