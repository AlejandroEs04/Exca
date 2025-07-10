from pydantic import BaseModel

class ClientRollBase(BaseModel):
    name: str
    
class ClientRollCreate(ClientRollBase):
    pass

class ClientRollResponse(ClientRollBase):
    id: int
    
    class config:
        from_attributes=True