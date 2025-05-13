from sqlalchemy import Column, Integer, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class TechnicalCase(Base):
    __tablename__ = "technical_case"
    
    id = Column(Integer, primary_key=True, index=True)
    project_id = Column(Integer, ForeignKey("project.id"), nullable=False)
    originator_id = Column(Integer, ForeignKey("user.id"), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    sended_at = Column(DateTime, nullable=True)
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    
    conditions = relationship("TechnicalCaseCondition", back_populates="technical_case")
    project = relationship("Project", back_populates="technical_case")
    originator = relationship("User", back_populates="technical_requests")