from pydantic import BaseModel, EmailStr
from typing import Optional
from app.database.schemas.client_address_schema import ClientAddressResponse
from app.database.schemas.client_roll_schema import ClientRollResponse

class Client(BaseModel):
    business_name: str
    email: Optional[EmailStr]
    phone_number: Optional[str]
    tax_id: Optional[str]
    type_id: int
    turn_id: Optional[int]
    id: int
    address: list[ClientAddressResponse] = []
    roll: Optional[ClientRollResponse]

class BrandBase(BaseModel):
    name: str
    client_id: int
    
class BrandCreate(BrandBase):
    pass

class BrandResponse(BrandBase):
    id: int
    client: Client
    
    class config:
        from_attributes = True