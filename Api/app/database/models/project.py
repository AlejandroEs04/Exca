from sqlalchemy import ForeignKey, func
from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base
from datetime import datetime

class Project(Base):
    __tablename__ = "project"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    brand_id: Mapped[int] = mapped_column(ForeignKey("brand.id"), nullable=False)
    stage_id: Mapped[int] = mapped_column(ForeignKey("stage.id"), nullable=False)
    status_id: Mapped[int] = mapped_column(ForeignKey("status.id"), nullable=False)
    originator_id: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    created_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now(), onupdate=func.now())
    
    originator = relationship("User", back_populates="projects")
    brand = relationship("Brand", back_populates="projects")
    stage = relationship("Stage", back_populates="projects")
    status = relationship("Status", back_populates="projects")
    lands = relationship("ProjectLand", back_populates="project")
    lease_request = relationship("LeaseRequest", back_populates="project", uselist=False, lazy="joined")
    events = relationship("ProjectEvent", back_populates="project")
    cases = relationship("Case", back_populates="project", uselist=True, lazy="joined")
    tasks = relationship("Task", back_populates="project")