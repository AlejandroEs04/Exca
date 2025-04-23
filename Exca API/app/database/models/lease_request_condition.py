from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class LeaseRequestCondition(Base):
    __tablename__ = "lease_request_condition"
    
    id = Column(Integer, primary_key=True, index=True)
    condition_id = Column(Integer, ForeignKey("condition.id"), nullable=False)
    lease_request_id = Column(Integer, ForeignKey("lease_request.id"), nullable=False)
    value = Column(String, nullable=False)
    is_active = Column(Boolean, nullable=False)
    
    lease_request = relationship("LeaseRequest", back_populates="conditions")
    condition = relationship("Condition", back_populates="request_conditions")