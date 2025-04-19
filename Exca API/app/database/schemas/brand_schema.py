from pydantic import BaseModel

class BrandBase(BaseModel):
    name: str
    client_id: int
    
class BrandCreate(BrandBase):
    pass

class BrandResponse(BrandBase):
    id: int
    
    class config:
        orm_mode = True