from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship

from app.database.connection import Base

class ApprovalStep(Base):
    __tablename__ = "approval_step"
    
    id = Column(Integer, primary_key=True, index=True)
    next_step_id = Column(Integer, ForeignKey("approval_step.id"), nullable=True)
    flow_id = Column(Integer, ForeignKey("approval_flow.id"), nullable=False)
    signator_id = Column(Integer, ForeignKey("user.id"), nullable=False)
    
    signator = relationship("User", back_populates="approval_steps")
    flow = relationship("ApprovalFlow", back_populates="steps")
    next_step = relationship(
        "ApprovalStep",
        remote_side=[id],
        backref="previous_step",
        uselist=False
    )
    
    requests = relationship("ApprovalRequest", back_populates="step")