from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship

from app.database.connection import Base

class ApprovalFlow(Base):
    __tablename__ = "approval_flow"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    steps = relationship("ApprovalStep", back_populates="flow")