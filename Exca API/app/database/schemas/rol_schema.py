from pydantic import BaseModel

class RolBase(BaseModel):
    name: str

class RolCreate(RolBase):
    pass

class RolResponse(RolBase):
    id: int
    
    class config:
        orm_mode: True