from sqlalchemy import Column, ForeignKey, String, Integer, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ResidentialDevelopment(Base):
    __tablename__ = "residential_development"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)

    city_id  = Column(Integer, ForeignKey("municipios.id"), nullable=False)
    state_id = Column(Integer, ForeignKey("estados.id"),   nullable=False)

    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())

    city  = relationship("City",  back_populates="residential_developments")
    state = relationship("State", back_populates="residential_developments")
    land = relationship("Land", back_populates="residential_development")