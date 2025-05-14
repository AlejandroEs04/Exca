from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ClientAddress(Base):
    __tablename__ = "client_address"
    
    id = Column(Integer, primary_key=True, index=True)
    client_id = Column(Integer, ForeignKey("client.id"), nullable=False)
    street = Column(String, nullable=False)
    city = Column(String, nullable=False)
    state = Column(String, nullable=False)
    postal_code = Column(String, nullable=False)
    country = Column(String, nullable=False)
    is_primary = Column(Boolean, nullable=False)
    
    client = relationship("Client", back_populates="address")
    individual_address = relationship("Individual", back_populates="address")