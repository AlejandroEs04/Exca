from pydantic import BaseModel
from datetime import datetime

from app.database.schemas.city_schema import CityResponse
from app.database.schemas.state_schema import StateResponse

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
    city:  CityResponse
    state: StateResponse
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
