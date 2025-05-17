from pydantic import BaseModel
from typing import Optional
from app.database.schemas.client_address_schema import ClientAddressResponse, ClientAddressCreate

class IndividualBase(BaseModel):
    full_name: str
    tax_id: str | None = None
    client_id: int
    address_id: int | None = None
    
class IndividualCreate(IndividualBase):
    address: Optional[ClientAddressCreate]

class IndividualResponse(IndividualBase):
    id: int
    address: ClientAddressResponse
    
    class config:
        from_attributes = True