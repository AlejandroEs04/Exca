from sqlalchemy import Column, Integer, ForeignKey, func, DateTime
from sqlalchemy.orm import relationship
from app.database.connection import Base

class LeaseRequest(Base):
    __tablename__ = "lease_request"
    
    id = Column(Integer, primary_key=True, index=True)
    project_id = Column(Integer, ForeignKey("project.id"), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    status_id = Column(Integer, ForeignKey("status.id"), nullable=False)
    
    project = relationship("Project", back_populates="lease_request")
    status = relationship("Status", back_populates="lease_requests")
    conditions = relationship("LeaseRequestCondition", back_populates="lease_request")