from sqlalchemy import Column, Integer, ForeignKey, func, DateTime, Boolean, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class LeaseRequest(Base):
    __tablename__ = "lease_request"
    
    id = Column(Integer, primary_key=True, index=True)
    project_id = Column(Integer, ForeignKey("project.id"), nullable=False)
    guarantee_id = Column(Integer, ForeignKey("individual.id"), nullable=False)
    guarantee_type_id = Column(Integer, ForeignKey("guarantee_type.id"), nullable=False)
    owner_id = Column(Integer, ForeignKey("owner.id"), nullable=False)
    commission_agreement = Column(Boolean, nullable=False)
    assignment_income = Column(Boolean, nullable=False)
    property_file = Column(String, nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    status_id = Column(Integer, ForeignKey("status.id"), nullable=False)
    
    project = relationship("Project", back_populates="lease_request")
    status = relationship("Status", back_populates="lease_requests")
    conditions = relationship("LeaseRequestCondition", back_populates="lease_request")
    guarantee = relationship("Individual", back_populates="lease_requests")
    guarantee_type = relationship("GuaranteeType", back_populates="lease_requests")
    owner = relationship("Owner", back_populates="lease_requests")