from sqlalchemy import Boolean, Column, Integer, String, Float, ForeignKey, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base
from datetime import datetime

class Land(Base):
    __tablename__ = "land"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    municipality_id = Column(Integer, ForeignKey('municipios.id'), nullable=True)
    state_id = Column(Integer, ForeignKey('estados.id'), nullable=True)
    residential_development_id = Column(Integer, ForeignKey('residential_development.id'), nullable=True)
    land_type_id = Column(Integer, ForeignKey('land_types.id'), nullable=True) 
    category_id = Column(Integer, ForeignKey('land_categories.id'), nullable=True)
    owner_company_id = Column(Integer, ForeignKey('owner.id'), nullable=True)
    tax_payer_company_id = Column(Integer, ForeignKey('owner.id'), nullable=True)
    user_last_update_id = Column(Integer, ForeignKey('user.id'), nullable=True)
    status_id = Column(Integer, ForeignKey('land_statuses.id'), nullable=True)
    is_trust_owned = Column(Boolean, nullable=True)
    cadastral_file = Column(String(20), nullable=True)
    block_lot = Column(String(30), nullable=True)
    address = Column(String(255), nullable=True)
    area = Column(Float, nullable=True)
    built_area = Column(Float, nullable=True)
    comments = Column(String(255), nullable=True)
    has_water_service = Column(Boolean, nullable=True)
    has_drainage_service = Column(Boolean, nullable=True)
    has_cfe_service = Column(Boolean, nullable=True)
    notes = Column(String(255), nullable=True)
    incorporation = Column(String(50), nullable=True)
    incorporation_notes = Column(String(255), nullable=True)
    num_lot = Column(String(30), nullable=True)
    seven_percentage = Column(Boolean, nullable=True)
    created_at = Column(DateTime, server_default=func.getdate(), nullable=False)
    updated_at = Column(DateTime, server_default=func.getdate(), onupdate=func.getdate(), nullable=False)

    current_tax_year = Column(Integer, nullable=True)
    current_value_per_built_area = Column(Float, nullable=True)
    current_value_per_area = Column(Float, nullable=True)
    current_cadastral_value = Column(Float, nullable=True)

    
    projects = relationship("ProjectLand", back_populates="land")
    residential_development = relationship("ResidentialDevelopment", back_populates="land")

    land_status = relationship('LandStatus', back_populates='lands')

