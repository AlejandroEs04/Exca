from pydantic import BaseModel, EmailStr
from typing import Optional

class ClientBase(BaseModel):
    name: str
    email: Optional[EmailStr]
    turnId: int

class ClientCreate(ClientBase):
    pass

class ClientResponse(ClientBase):
    id: int
    
    class config:
        orm_mode = True
    