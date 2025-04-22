from pydantic import BaseModel

class ConditionBase(BaseModel):
    name: str
    type_id: int
    category_id: int
    options: str | None = None
    
class ConditionResponse(ConditionBase):
    id: int
    
    class Config:
        orm_mode = True