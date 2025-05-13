from sqlalchemy import Column, Integer, String, Boolean
from sqlalchemy.orm import relationship

from app.database.connection import Base

class ApprovalFlow(Base):
    __tablename__ = "approval_flow"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(String, nullable=True)
    is_active = Column(Boolean, nullable=False)
    
    steps = relationship("ApprovalFlowStep", back_populates="flow")