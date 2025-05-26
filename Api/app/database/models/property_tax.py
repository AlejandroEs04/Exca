from sqlalchemy import Column, Integer, Float, String, DateTime, ForeignKey, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class PropertyTax(Base):
    __tablename__ = 'property_tax'
    id = Column(Integer, primary_key=True, autoincrement=True)
    land_id = Column(Integer, ForeignKey('land.id'), nullable=True)
    property_tax_estatus_id = Column(Integer, ForeignKey('property_tax_status.id'), nullable=True)
    verified_user_id = Column(Integer, ForeignKey('user.id'), nullable=True)
    tax_year = Column(Integer, nullable=True)
    cadastral_value = Column(Float, nullable=True)
    cadastral_value_per_area = Column(Float, nullable=True)
    cadastral_value_per_built_area = Column(Float, nullable=True)
    receipt_file_url = Column(String(255), nullable=True)
    tax_amount = Column(Float, nullable=True)
    penalties = Column(Float, nullable=True)
    other_charges = Column(Float, nullable=True)
    total_tax = Column(Float, nullable=True)
    discount = Column(Float, nullable=True)
    bonuses = Column(Float, nullable=True)
    others = Column(Float, nullable=True)
    net_payable = Column(Float, nullable=True)
    created_at = Column(DateTime, server_default=func.getdate(), nullable=False)
    updated_at = Column(DateTime, server_default=func.getdate(), onupdate=func.getdate(), nullable=False)
