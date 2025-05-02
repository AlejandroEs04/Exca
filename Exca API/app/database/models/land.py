from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Land(Base):
    __tablename__ = "land"
    
    id = Column(Integer, primary_key=True, index=True)
    cadastral_file = Column(String, nullable=False)
    area = Column(Float, nullable=False)
    price_per_area = Column(Float, nullable=False)
    address = Column(String, nullable=False)
    residential_development_id = Column(Integer, ForeignKey("residential_development.id"), nullable=False)
    municipio = Column(Integer, nullable=True)
    valor_catastral = Column(Float, nullable=True)
    area_construida = Column(Float, nullable=True)
    pago_predial = Column(Float, nullable=True)
    global_status = Column(Integer, nullable=True)
    path_predial_file = Column(String, nullable=True)
    name_last_update = Column(String, nullable=True)


    projects = relationship("ProjectLand", back_populates="land")
    residential_development = relationship("ResidentialDevelopment", back_populates="land")