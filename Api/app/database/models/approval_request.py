from sqlalchemy import Column, Integer, Boolean, String, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ApprovalRequest(Base):
    __tablename__ = "approval_request"
    
    id = Column(Integer, primary_key=True, index=True)
    flow_step_id = Column(Integer, ForeignKey("approval_step.id"), nullable=False)
    item_id = Column(String, nullable=False)
    requested_by = Column(Integer, ForeignKey("user.id"), nullable=False)
    requested_at = Column(DateTime, nullable=False, server_default=func.now())
    responsed_at = Column(DateTime, nullable=True, server_default=func.now())
    response = Column(Boolean, nullable=True)
    comments = Column(String, nullable=True)
    
    user = relationship("User", back_populates="requests")
    step = relationship("ApprovalFlowStep", back_populates="requests")