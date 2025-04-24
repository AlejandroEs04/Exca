from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Individual(Base):
    __tablename__ = "individual"
    
    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String, nullable=False)
    tax_id = Column(String, nullable=True)
    address = Column(String, nullable=True)
    
    documents = relationship("IndividualDocument", back_populates="individual")
    lease_requests = relationship("LeaseRequest", back_populates="guarantee")