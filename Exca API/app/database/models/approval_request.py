from sqlalchemy import Column, Integer, Boolean, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ApprovalRequest(Base):
    __tablename__ = "approval_request"
    
    id = Column(Integer, primary_key=True, index=True)
    response = Column(Boolean, nullable=True)
    item_id = Column(String, nullable=False)
    step_id = Column(Integer, ForeignKey("approval_step.id"), nullable=False)
    
    step = relationship("ApprovalStep", back_populates="requests")