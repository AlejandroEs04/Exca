from pydantic import BaseModel, EmailStr
from typing import Optional, List
from app.database.schemas.client_schema import ClientResponse

class CompanyBase(BaseModel):
    business_name: str
    email: Optional[EmailStr]
    phone_number: Optional[str]
    tax_id: Optional[str]
    address: Optional[str]
    type_id: int
    
class CompanyCreate(CompanyBase):
    pass

class CompanyResponse(CompanyBase):
    id: int
    clients: List[ClientResponse] = []
    
    class config:
        orm_mode = True