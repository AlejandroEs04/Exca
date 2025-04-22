from pydantic import BaseModel
from datetime import datetime
from app.database.schemas.project_land_schema import ProjectLandCreate, ProjectLandResponse
from app.database.schemas.land_schema import LandResponse
from app.database.schemas.stage_schema import StageResponse
from app.database.schemas.client_schema import ClientResponse

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
        
class ProjectLandBase(BaseModel):
    land_id: int
    area: float
    id: int
    land: LandResponse
    
class BrandResponse(BaseModel):
    id: int
    name: str
    client_id: int
    client: ClientResponse
    
class ProjectResponse(ProjectBase):
    id: int
    lands: list[ProjectLandBase] = []
    stage: StageResponse
    brand: BrandResponse
    created_at: datetime
    updated_at: datetime
    
    class Config:
        orm_mode = True