from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class TechnicalCaseCondition(Base):
    __tablename__ = "technical_case_conditions"
    
    id = Column(Integer, primary_key=True, index=True)
    technical_case_id = Column(Integer, ForeignKey("technical_case.id"), nullable=False)
    condition_id = Column(Integer, ForeignKey("condition.id"), nullable=False)
    value = Column(String, nullable=True)
    is_active = Column(Boolean, nullable=False)
    
    technical_case = relationship("TechnicalCase", back_populates="conditions")
    condition = relationship("Condition", back_populates="technical_case_conditions")