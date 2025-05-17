from pydantic import BaseModel, EmailStr
from typing import Optional
from app.database.schemas.brand_schema import BrandResponse
from app.database.schemas.client_address_schema import ClientAddressResponse, ClientAddressCreate

class ClientBase(BaseModel):
    business_name: str
    email: Optional[EmailStr]
    phone_number: Optional[str]
    tax_id: Optional[str]
    type_id: int
    turn_id: Optional[int]
    
class ClientCreate(ClientBase):
    address: Optional[ClientAddressCreate]

class ClientResponse(ClientBase):
    id: int
    address: list[ClientAddressResponse] = []
    brands: list[BrandResponse] = []
    
    class config:
        from_attributes = True