from pydantic import BaseModel
from typing import Optional

class ClientAddressBase(BaseModel):
    client_id: Optional[int]
    street: str
    city: str
    state: str
    postal_code: str
    country: str
    is_primary: bool
    
class ClientAddressCreate(ClientAddressBase):
    pass

class ClientAddressResponse(ClientAddressCreate):
    id: int
    
    class config:
        orm_mode = True