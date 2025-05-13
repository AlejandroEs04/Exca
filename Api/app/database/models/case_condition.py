from sqlalchemy import Column, Integer, ForeignKey, String, Boolean, DateTime, Float
from sqlalchemy.orm import relationship
from app.database.connection import Base

class CaseCondition(Base):
    __tablename__ = "case_condition"
    
    id = Column(Integer, primary_key=True, index=True)
    case_id = Column(Integer, ForeignKey("case.id"), nullable=False)
    condition_id = Column(Integer, ForeignKey("condition.id"), nullable=False)
    text_value = Column(String, nullable=True)
    number_value = Column(Float, nullable=True)
    date_value = Column(DateTime, nullable=True)
    boolean_value = Column(Boolean, nullable=True)
    option_id = Column(Integer, ForeignKey("condition_option.id"), nullable=False)
    is_active = Column(Boolean, nullable=False)
    
    case = relationship("Case", back_populates="conditions")
    condition = relationship("Condition", back_populates="case_conditions")
    option = relationship("ConditionOption", back_populates="case_conditions")