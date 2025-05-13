from pydantic import BaseModel

class ResidentialDevelopmentSchema(BaseModel):
    name: str
    
class ResidentialDevelopmentCreate(ResidentialDevelopmentSchema):
    pass

class ResidentialDevelopmentResponse(ResidentialDevelopmentSchema):
    id: int

    class Config:
        from_attributes = True