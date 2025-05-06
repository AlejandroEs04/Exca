from pydantic import BaseModel

class CityDevelopmentSchema(BaseModel):
    descripcion: str
    
class CityDevelopmentCreate(CityDevelopmentSchema):
    pass

class CityDevelopmentResponse(CityDevelopmentSchema):
    id: int

    class Config:
        from_attributes = True