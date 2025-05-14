from pydantic import BaseModel
from datetime import datetime

class ResidentialDevelopmentSchema(BaseModel):
    name: str
    city: str
    state: str
    
class ResidentialDevelopmentCreate(ResidentialDevelopmentSchema):
    pass

class ResidentialDevelopmentResponse(ResidentialDevelopmentSchema):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True