from sqlalchemy import Column, String, Integer, ForeignKey, DateTime, func, Boolean
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Condition(Base):
    __tablename__ = "condition"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(String, nullable=True)
    type_id = Column(Integer, ForeignKey("condition_type.id"), nullable=False)
    category_id = Column(Integer, ForeignKey("condition_category.id"), nullable=False)
    is_active = Column(Boolean, nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())

    category = relationship("ConditionCategory", back_populates="conditions")
    type = relationship("ConditionType", back_populates="conditions")
    options = relationship("ConditionOption", back_populates="condition")
    request_conditions = relationship("LeaseRequestCondition", back_populates="condition")
    technical_case_conditions = relationship("TechnicalCaseCondition", back_populates="condition")
    case_conditions = relationship("CaseCondition", back_populates="condition")