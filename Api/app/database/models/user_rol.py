from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class UserRol(Base):
    __tablename__ = "user_rol"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False, unique=True)
    
    users = relationship("User", back_populates="rol")
    approval_steps = relationship("ApprovalFlowStep", back_populates="rol")