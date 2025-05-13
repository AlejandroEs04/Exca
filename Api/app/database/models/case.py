from sqlalchemy import Column, Integer, DateTime, func, ForeignKey, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Case(Base):
    __tablename__ = "case"
    
    id = Column(Integer, primary_key=True, index=True)
    project_id = Column(Integer, nullable=False)
    case_type_id = Column(Integer, ForeignKey("case_type.id"), nullable=False)
    title = Column(String, nullable=False)
    description = Column(String, nullable=True)
    originator_id = Column(Integer, nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    sended_at = Column(DateTime, nullable=True)
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    status_id = Column(Integer, nullable=False)
    
    type = relationship("CaseType", back_populates="cases")
    status = relationship("Status", back_populates="cases")
    conditions = relationship("CaseCondition", back_populates="case")
    