from pydantic import BaseModel
from app.database.schemas.residential_development_schema import ResidentialDevelopmentResponse
from typing import Optional

class LandBase(BaseModel):
    cadastral_file: str
    area: float
    build_area: float = 0
    price_per_area: float
    address: str

    municipio: Optional[int]
    valor_catastral: Optional[float]
    area_construida: Optional[float]
    pago_predial: Optional[float]
    global_status: Optional[int]
    path_predial_file: Optional[str]
    name_last_update: Optional[str]
    

    city: str
    state: str

    
class LandCreate(LandBase):
    residential_development: str

class LandResponse(LandBase):
    id: int
    residential_development_id: int
    residential_development: ResidentialDevelopmentResponse
    
    class config:
        from_attributes = True

class LandUpdate(BaseModel):
    id: int
    cadastral_file: str
    area: float
    price_per_area: float
    address: str
    municipio: int
    valor_catastral: float
    area_construida: float
    pago_predial: float
    residential_development_id: int
    global_status: int
    class Config:
        from_attributes = True
