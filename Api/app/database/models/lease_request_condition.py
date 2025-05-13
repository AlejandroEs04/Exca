from sqlalchemy import Column, Integer, String, Boolean, ForeignKey, Float, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class LeaseRequestCondition(Base):
    __tablename__ = "lease_request_condition"
    
    id = Column(Integer, primary_key=True, index=True)
    lease_request_id = Column(Integer, ForeignKey("lease_request.id"), nullable=False)
    condition_id = Column(Integer, ForeignKey("condition.id"), nullable=False)
    text_value = Column(String, nullable=True)
    number_value = Column(Float, nullable=True)
    date_value = Column(DateTime, nullable=True)
    boolean_value = Column(Boolean, nullable=True)
    option_id = Column(Integer, ForeignKey("condition_option.id"), nullable=False)
    is_active = Column(Boolean, nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    
    lease_request = relationship("LeaseRequest", back_populates="conditions")
    condition = relationship("Condition", back_populates="request_conditions")
    option = relationship("ConditionOption", back_populates="lease_request_conditions")