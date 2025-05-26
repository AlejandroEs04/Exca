# app/database/models/city.py
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class City(Base):
    __tablename__ = 'municipios'
    id              = Column(Integer, primary_key=True, autoincrement=True)
    id_estado       = Column(Integer, ForeignKey('estados.id'), nullable=False)
    clave_municipio = Column(Integer, nullable=False)
    descripcion     = Column(String(80), nullable=False)

    # Aquí back_populates coincide con el atributo 'municipios' de State
    estado = relationship(
        'State',
        back_populates='municipios'
    )
