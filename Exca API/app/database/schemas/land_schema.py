from pydantic import BaseModel
from app.database.schemas.residential_development_schema import ResidentialDevelopmentResponse

class LandBase(BaseModel):
    cadastral_file: str
    area: float
    price_per_area: float
    address: str
    
class LandCreate(LandBase):
    residential_development: str

class LandResponse(LandBase):
    id: int
    residential_development_id: int
    residential_development: ResidentialDevelopmentResponse
    
    class config:
        orm_mode = True