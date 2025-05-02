from pydantic import BaseModel

class StageBase(BaseModel):
    name: str
    
class StageResponse(StageBase):
    id: int
    
    class Config:
        from_attributes = True