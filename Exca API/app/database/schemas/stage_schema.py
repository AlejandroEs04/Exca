from pydantic import BaseModel

class StageBase(BaseModel):
    name: str
    
class StageResponse(StageBase):
    id: int
    
    class Config:
        orm_mode = True