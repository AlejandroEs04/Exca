from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ResidentialDevelopment(Base):
    __tablename__ = "residential_development"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    land = relationship("Land", back_populates="residential_development")