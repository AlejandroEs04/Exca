from pydantic import BaseModel
from datetime import datetime
from typing import Optional
from app.database.schemas.land_schema import LandResponse
from app.database.schemas.project_land_type_schema import ProjectLandTypeResponse

class ProjectLandBase(BaseModel):
    land_id: int
    area: float
    build_area: float = 0
    type_id: Optional[int]
    deed_sale: Optional[str] = None
class ProjectLandCreate(ProjectLandBase):
    pass
    
class ProjectLandResponse(ProjectLandBase):
    id: int
    created_at: datetime
    updated_at: datetime
    project_id: int
    land: LandResponse
    type: Optional[ProjectLandTypeResponse]
    
    class config:
        from_attributes = True