from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Area(Base):
    __tablename__ = "area"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False, unique=True)
    
    users = relationship("User", back_populates="area")
    approval_steps = relationship("ApprovalFlowStep", back_populates="area")