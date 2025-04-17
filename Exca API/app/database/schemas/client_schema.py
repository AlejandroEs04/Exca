from pydantic import BaseModel

class ClientBase(BaseModel):
    name: str
    company_id: int
    
class ClientCreate(ClientBase):
    pass

class ClientResponse(ClientBase):
    id: int
    
    class config:
        orm_mode = True