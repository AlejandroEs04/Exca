from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Project(Base):
    __tablename__ = "project"
    
    id = Column(Integer, primary_key=True, index=True)
    brand_id = Column(Integer, ForeignKey("brand.id"), nullable=False)
    stage_id = Column(Integer, ForeignKey("stage.id"), nullable=False)
    status_id = Column(Integer, ForeignKey("status.id"), nullable=False)
    originator_id = Column(Integer, ForeignKey("user.id"), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    
    originator = relationship("User", back_populates="projects")
    brand = relationship("Brand", back_populates="projects")
    stage = relationship("Stage", back_populates="projects")
    status = relationship("Status", back_populates="projects")
    lands = relationship("ProjectLand", back_populates="project")
    lease_request = relationship("LeaseRequest", back_populates="project", uselist=False, lazy="joined")
    events = relationship("ProjectEvent", back_populates="project")