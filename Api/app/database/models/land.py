from sqlalchemy import Column, Integer, String, Float, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Land(Base):
    __tablename__ = "land"
    
    id = Column(Integer, primary_key=True, index=True)
    cadastral_file = Column(String, nullable=False)
    area = Column(Float, nullable=False)
    build_area = Column(Float, nullable=False)
    price_per_area = Column(Float, nullable=False)
    address = Column(String, nullable=False)
    residential_development_id = Column(Integer, ForeignKey("residential_development.id"), nullable=False)
    cadastral_value = Column(Float, nullable=True)
    predial_payment = Column(Float, nullable=True)
    global_status = Column(Integer, nullable=True)
    name_last_update = Column(String, nullable=True)
    path_predial_file = Column(String, nullable=True)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    
    projects = relationship("ProjectLand", back_populates="land")
    residential_development = relationship("ResidentialDevelopment", back_populates="land")