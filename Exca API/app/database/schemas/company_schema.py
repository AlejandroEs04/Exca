from pydantic import BaseModel, EmailStr
from typing import Optional

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
    
    class config:
        orm_mode = True