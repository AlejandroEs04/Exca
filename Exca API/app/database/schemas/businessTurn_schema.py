from pydantic import BaseModel

class BusinessTurnBase(BaseModel):
    description: str

class BusinessTurnCreate(BusinessTurnBase):
    pass

class BusinessTurnResponse(BusinessTurnBase):
    id: int

    class config:
        orm_mode = True