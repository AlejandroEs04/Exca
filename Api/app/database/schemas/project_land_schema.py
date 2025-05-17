from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from app.database.schemas.land_schema import LandResponse

class ProjectLandBase(BaseModel):
    land_id: int
    area: float
    build_area: float = 0
    type_id: Optional[int]
class ProjectLandCreate(ProjectLandBase):
    pass
    
class ProjectLandResponse(ProjectLandBase):
    id: int
    created_at: datetime
    updated_at: datetime
    project_id: int
    land: LandResponse
    
    class Config:
        orm_mode = True