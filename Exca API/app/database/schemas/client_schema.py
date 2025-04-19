from pydantic import BaseModel, EmailStr
from typing import Optional, List
from app.database.schemas.brand_schema import BrandResponse

class ClientBase(BaseModel):
    business_name: str
    email: Optional[EmailStr]
    phone_number: Optional[str]
    tax_id: Optional[str]
    address: Optional[str]
    type_id: int
    
class ClientCreate(ClientBase):
    pass

class ClientResponse(ClientBase):
    id: int
    brands: List[BrandResponse] = []
    
    class config:
        orm_mode = True