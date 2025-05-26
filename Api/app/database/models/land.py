from sqlalchemy import Column, Integer, String, Float, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base
from datetime import datetime

class Land(Base):
    __tablename__ = "land"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    cadastral_file: Mapped[str] = mapped_column(nullable=False)
    area: Mapped[float] = mapped_column(nullable=False)
    build_area: Mapped[float] = mapped_column(nullable=False)
    price_per_area: Mapped[float] = mapped_column(nullable=False)
    address: Mapped[str] = mapped_column(nullable=False)
    residential_development_id: Mapped[int] = mapped_column(ForeignKey("residential_development.id"), nullable=False)
    cadastral_value: Mapped[str] = mapped_column(nullable=True)
    predial_payment: Mapped[float] = mapped_column(nullable=True)
    global_status: Mapped[int] = mapped_column(nullable=True)
    name_last_update: Mapped[str] = mapped_column(nullable=True)
    path_predial_file: Mapped[str] = mapped_column(nullable=True)
    created_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now(), onupdate=func.now())
    
    projects = relationship("ProjectLand", back_populates="land")
    residential_development = relationship("ResidentialDevelopment", back_populates="land")