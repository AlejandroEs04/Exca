from pydantic import BaseModel
from typing import Optional

class TaskStatusBase(BaseModel):
    name: str
    description: Optional[str] = None

class TaskStatusCreate(TaskStatusBase):
    pass

class TaskStatusResponse(TaskStatusBase):
    id: int
    
    class config:
        orm_mode=True