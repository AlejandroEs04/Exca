from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship
from app.database.connection import Base

class CityDevelopment(Base):
    __tablename__ = "municipios"

    id = Column(Integer, primary_key=True, index=True)
    descripcion = Column(String, nullable=False)
    