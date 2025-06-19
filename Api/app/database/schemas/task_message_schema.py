from pydantic import BaseModel
from datetime import datetime

class TaskMessageBase(BaseModel):
    message: str
    task_id: int
    
class TaskMessageCreate(TaskMessageBase):
    pass

class TaskMessageResponse(TaskMessageBase):
    id: int
    originator_id: int
    submitted_at: datetime
    
    class config:
        orm_mode=True