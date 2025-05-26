from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime

class PropertyTaxBase(BaseModel):
    land_id: Optional[int]
    property_tax_estatus_id: Optional[int]
    verified_user_id: Optional[int]
    tax_year: Optional[int]
    cadastral_value: Optional[float]
    cadastral_value_per_area: Optional[float]
    cadastral_value_per_built_area: Optional[float]
    receipt_file_url: Optional[str]
    tax_amount: Optional[float]
    penalties: Optional[float]
    other_charges: Optional[float]
    total_tax: Optional[float]
    discount: Optional[float]
    bonuses: Optional[float]
    others: Optional[float]
    net_payable: Optional[float]

class PropertyTaxCreate(PropertyTaxBase):
    pass

class PropertyTaxUpdate(PropertyTaxBase):
    id: int

class PropertyTaxResponse(PropertyTaxBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
