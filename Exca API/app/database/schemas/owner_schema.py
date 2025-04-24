from pydantic import BaseModel

class OwnerBase(BaseModel):
    name: str

class OwnerCreate(OwnerBase):
    pass

class OwnerResponse(OwnerBase):
    id: int
    
    class config:
        orm_mode=True