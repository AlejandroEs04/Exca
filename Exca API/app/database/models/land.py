from sqlalchemy import Column, Integer, String, Float
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Land(Base):
    __tablename__ = "land"
    
    id = Column(Integer, primary_key=True, index=True)
    cadastral_file = Column(String, nullable=False)
    area = Column(Float, nullable=False)
    price_per_area = Column(Float, nullable=False)
    address = Column(String, nullable=False)
    residential_development = Column(String, nullable=False)