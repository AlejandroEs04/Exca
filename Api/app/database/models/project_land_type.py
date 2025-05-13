from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ProjectLandType(Base):
    __tablename__ = "project_land_type"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    descripcion = Column(String, nullable=True)

    
    projects = relationship("ProjectLand", back_populates="type")