from sqlalchemy import Column, Integer, Float, String, DateTime, ForeignKey, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class LandCategory(Base):
    __tablename__ = 'land_categories'
    id = Column(Integer, primary_key=True, autoincrement=True)
    description = Column(String(50), nullable=False)
    created_at = Column(DateTime, server_default=func.getdate(), nullable=False)
    updated_at = Column(DateTime, server_default=func.getdate(), onupdate=func.getdate(), nullable=False)