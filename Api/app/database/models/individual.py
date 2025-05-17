from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Individual(Base):
    __tablename__ = "individual"
    
    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String, nullable=False)
    tax_id = Column(String, nullable=True)
    address_id = Column(Integer, ForeignKey("client_address.id"), nullable=True)
    client_id = Column(Integer, ForeignKey("client.id"), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    
    address = relationship("ClientAddress", back_populates="individual_address")
    documents = relationship("IndividualDocument", back_populates="individual")
    lease_requests = relationship("LeaseRequest", back_populates="guarantee")
    client = relationship("Client", back_populates="individuals")