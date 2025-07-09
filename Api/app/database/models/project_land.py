from sqlalchemy import Column, Integer, Float, ForeignKey, DateTime, func, String
from sqlalchemy.orm import relationship, Mapped, mapped_column
from datetime import datetime
from app.database.connection import Base

class ProjectLand(Base):
    __tablename__ = "project_land"

    id: Mapped[int] = mapped_column(primary_key=True,index=True)
    project_id: Mapped[int] = mapped_column(ForeignKey("project.id"), nullable=False)
    land_id: Mapped[int] = mapped_column(ForeignKey("land.id"), nullable=False)
    area: Mapped[float] = mapped_column(nullable=False)
    build_area: Mapped[float] = mapped_column(nullable=False)
    type_id: Mapped[int | None] = mapped_column(ForeignKey("project_land_type.id"), nullable=True)
    deed_sale: Mapped[str | None] = mapped_column(nullable=True)
    created_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now(), onupdate=func.now())

    project = relationship("Project", back_populates="lands")
    land = relationship("Land", back_populates="projects")
    type = relationship("ProjectLandType", back_populates="projects")