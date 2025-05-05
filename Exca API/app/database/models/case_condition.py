from sqlalchemy import Column, Integer, ForeignKey, String, Boolean
from sqlalchemy.orm import relationship
from app.database.connection import Base

class CaseCondition(Base):
    __tablename__ = "case_condition"
    
    id = Column(Integer, primary_key=True, index=True)
    condition_id = Column(Integer, ForeignKey("condition.id"), nullable=False)
    case_id = Column(Integer, ForeignKey("case.id"), nullable=False)
    value = Column(String, nullable=False)
    is_active = Column(Boolean, nullable=False)
    
    condition = relationship("Condition", back_populates="cases")
    case = relationship("Case", back_populates="conditions")
    
    