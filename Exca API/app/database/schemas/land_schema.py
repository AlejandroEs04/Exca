from pydantic import BaseModel

class LandBase(BaseModel):
    cadastral_file: str
    area: float
    price_per_area: float
    address: str
    residential_development: str
    
class LandCreate(LandBase):
    pass 

class LandResponse(LandBase):
    id: int
    
    class config:
        orm_mode = True