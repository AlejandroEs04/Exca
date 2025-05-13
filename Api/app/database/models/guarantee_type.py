from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class GuaranteeType(Base):
    __tablename__ = "guarantee_type"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    descripcion = Column(String, nullable=True)
    
    lease_requests = relationship("LeaseRequest", back_populates="guarantee_type")
    