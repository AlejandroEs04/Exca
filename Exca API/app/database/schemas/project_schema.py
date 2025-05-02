from pydantic import BaseModel
from datetime import datetime
from app.database.schemas.project_land_schema import ProjectLandCreate, ProjectLandResponse
from app.database.schemas.land_schema import LandResponse
from app.database.schemas.stage_schema import StageResponse
from app.database.schemas.client_schema import ClientResponse
from app.database.schemas.lease_request_schema import LeaseRequestResponse
from app.database.schemas.approval_request_schema import ApprovalRequestResponse

class ProjectBase(BaseModel):
    brand_id: int
    stage_id: int
    originator_id: int
    
class ProjectCreate(BaseModel):
    client: str
    brand: str
    lands: list[ProjectLandCreate] = []
    
class ProjectLandType(BaseModel):
    id: int
    name: str
        
class ProjectLandBase(BaseModel):
    land_id: int
    area: float
    id: int
    land: LandResponse
    type_id: int | None = None
    type: ProjectLandType
    
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
    lease_request: LeaseRequestResponse | None = None
    approvations: list[ApprovalRequestResponse] = []
    
    class Config:
        from_attributes = True