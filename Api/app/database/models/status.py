from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Status(Base):
    __tablename__ = "status"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(String, nullable=True)
    
    lease_requests = relationship("LeaseRequest", back_populates="status")
    projects = relationship("Project", back_populates="status")
    cases = relationship("Case", back_populates="status")