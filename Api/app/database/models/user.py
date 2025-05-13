from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class User(Base):
    __tablename__ = "user"
    
    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String, nullable=False)
    email = Column(String, nullable=False, unique=True)
    rol_id = Column(Integer, ForeignKey("user_rol.id"), nullable=False)
    area_id = Column(Integer, ForeignKey("area.id"), nullable=False)
    hashed_password = Column(String, nullable=False)
    
    projects = relationship("Project", back_populates="originator")
    area = relationship("Area", back_populates="users")
    rol = relationship("UserRol", back_populates="users")
    requests = relationship("ApprovalRequest", back_populates="user")
    lease_requests = relationship("LeaseRequest", back_populates="creator")
    approval_steps = relationship("ApprovalStep", back_populates="signator")
    technical_requests = relationship("TechnicalCase", back_populates="originator")