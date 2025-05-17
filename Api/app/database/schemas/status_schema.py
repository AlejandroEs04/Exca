from pydantic import BaseModel
from typing import Optional

class StatusBase(BaseModel):
    name: str
    description: Optional[str]
    
class StatusCreate(StatusBase):
    pass

class StatusResponse(StatusBase):
    id: int
    
    class config:
        orm_mode=True