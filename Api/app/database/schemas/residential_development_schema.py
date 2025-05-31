from pydantic import BaseModel
from datetime import datetime

class ResidentialDevelopmentSchema(BaseModel):
    name: str
    city_id: int
    state_id: int

class ResidentialDevelopmentCreate(ResidentialDevelopmentSchema):
    pass

class ResidentialDevelopmentUpdate(ResidentialDevelopmentSchema):
    id: int

class ResidentialDevelopmentResponse(ResidentialDevelopmentSchema):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
