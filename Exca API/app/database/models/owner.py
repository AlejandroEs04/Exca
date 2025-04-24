from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Owner(Base):
    __tablename__ = "owner"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    lease_requests = relationship("LeaseRequest", back_populates="owner")