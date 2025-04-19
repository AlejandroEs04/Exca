from pydantic import BaseModel
from datetime import datetime
from app.database.schemas.project_land_schema import ProjectLandCreate, ProjectLandResponse

class ProjectBase(BaseModel):
    name: str
    brand_id: int
    stage_id: int
    originator_id: int
    
class ProjectCreate(BaseModel):
    name: str
    client: str
    brand: str
    lands: list[ProjectLandCreate] = []
    
    class Config:
        from_attributes = True  
    
class ProjectResponse(ProjectBase):
    id: int
    lands: list[ProjectLandResponse] = []
    created_at: datetime
    updated_at: datetime
    
    class Config:
        orm_mode = True