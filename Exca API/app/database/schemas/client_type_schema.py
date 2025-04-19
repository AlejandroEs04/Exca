from pydantic import BaseModel

class ClientTypeBase(BaseModel):
    name: str

class ClientTypeCreate(ClientTypeBase):
    pass

class ClientTypeResponse(ClientTypeCreate):
    id: int

    class config:
        orm_mode = True