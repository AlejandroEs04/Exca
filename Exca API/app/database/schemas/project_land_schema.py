from pydantic import BaseModel
from datetime import datetime

class ProjectLandBase(BaseModel):
    land_id: int
    area: float
    
    
class ProjectLandCreate(ProjectLandBase):
    pass
    
class ProjectLandResponse(ProjectLandBase):
    id: int
    created_at: datetime
    updated_at: datetime
    project_id: int
    
    class Config:
        orm_mode = True