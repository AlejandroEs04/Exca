from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime

class TaskBase(BaseModel):
    title: str
    description: str
    responsible_id: int
    project_id: int
    due_date: datetime
    task_id: Optional[int] = None

class TaskCreate(TaskBase):
    subtasks: list['TaskCreate'] = []
    
class TaskUpdate(TaskBase):
    status_id: int
    
class TaskResponse(TaskBase):
    id: int
    originator_id: int
    status_id: int
    created_at: datetime
    updated_at: datetime
    subtask: list['TaskResponse'] = []
    
    class config:
        orm_mode=True
        
TaskCreate.model_rebuild()
TaskResponse.model_rebuild()