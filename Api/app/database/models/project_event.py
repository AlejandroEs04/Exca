from sqlalchemy import Column, String, Integer, DateTime, func, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ProjectEvent(Base):
    __tablename__ = "project_event"
    
    id = Column(Integer, primary_key=True, index=True)
    description = Column(String, nullable=False)
    tentative_date = Column(DateTime, nullable=False)
    actual_date = Column(DateTime, nullable=False)
    project_id = Column(Integer, ForeignKey("project.id"), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())

    project = relationship("Project", back_populates="events")