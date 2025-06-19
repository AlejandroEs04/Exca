from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime
from app.database.schemas.land_status_schema import LandStatusResponse
from app.database.schemas.residential_development_schema import ResidentialDevelopmentResponse

class LandBase(BaseModel):
    municipality_id: Optional[int]
    state_id: Optional[int]
    land_type_id: Optional[int]
    category_id: Optional[int]
    owner_company_id: Optional[int]
    tax_payer_company_id: Optional[int]
    user_last_update_id: Optional[int]
    status_id: Optional[int]
    residential_development_id: Optional[int]
    cadastral_file: Optional[str] = None
    block_lot: Optional[str] = None
    address: Optional[str] = None
    area: Optional[float] = None
    built_area: Optional[float] = None
    comments: Optional[str] = None
    has_water_service: Optional[bool] = None
    has_drainage_service: Optional[bool] = None
    has_cfe_service: Optional[bool] = None
    is_trust_owned: Optional[bool] = None
    notes: Optional[str] = None
    incorporation: Optional[str] = None
    incorporation_notes: Optional[str] = None

    current_tax_year: Optional[int] = None
    current_value_per_built_area: Optional[float] = None
    current_value_per_area: Optional[float] = None
    current_cadastral_value: Optional[float] = None

class LandCreate(LandBase):
    residential_development_id: Optional[int]
    
class LandUpdate(LandBase):
    id: int

class LandResponse(LandBase):
    id: int
   
    residential_development: Optional[ResidentialDevelopmentResponse]
    land_status: Optional[LandStatusResponse]
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
