from sqlalchemy import Column, Integer, String, Float, ForeignKey
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
    city = Column(String, nullable=False)
    state = Column(String, nullable=False)
    
    projects = relationship("ProjectLand", back_populates="land")
    residential_development = relationship("ResidentialDevelopment", back_populates="land")