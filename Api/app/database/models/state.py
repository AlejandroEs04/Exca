# app/database/models/state.py
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class State(Base):
    __tablename__ = 'estados'
    id                 = Column(Integer, primary_key=True, autoincrement=True)
    clave_estado       = Column(Integer, nullable=False)
    abreviacion_estado = Column(String(10), nullable=False)
    descripcion        = Column(String(80), nullable=False)

    # Aquí back_populates coincide con el atributo 'estado' de City
    municipios = relationship(
        'City',
        back_populates='estado'
    )
