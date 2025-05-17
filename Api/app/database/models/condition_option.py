from sqlalchemy import Column, String, Integer, ForeignKey, Boolean
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ConditionOption(Base):
    __tablename__ = "condition_option"
    
    id = Column(Integer, primary_key=True, index=True)
    condition_id = Column(Integer, ForeignKey("condition.id"), nullable=False)
    option_value = Column(String, nullable=False)
    display_order = Column(Integer, nullable=False)
    is_active = Column(Boolean, nullable=False)
    
    condition = relationship("Condition", back_populates="options")
    lease_request_conditions = relationship("LeaseRequestCondition", back_populates="option")
    case_conditions = relationship("CaseCondition", back_populates="option")