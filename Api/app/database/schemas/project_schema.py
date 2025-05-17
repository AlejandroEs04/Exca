from pydantic import BaseModel
from datetime import datetime
from app.database.schemas.project_land_schema import ProjectLandCreate, ProjectLandResponse
from app.database.schemas.user_schema import UserResponse
from app.database.schemas.brand_schema import BrandResponse
from app.database.schemas.stage_schema import StageResponse
from app.database.schemas.brand_schema import BrandResponse
from app.database.schemas.status_schema import StatusResponse
from app.database.schemas.lease_request_schema import LeaseRequestResponse
from app.database.schemas.case_schema import CaseResponse

from datetime import datetime

class ProjectBase(BaseModel):
    brand_id: int
    
class ProjectCreate(ProjectBase):
    lands: list[ProjectLandCreate] = []
    
class ProjectResponse(ProjectBase):
    id: int
    stage_id: int
    status_id: int
    originator_id: int
    created_at: datetime
    updated_at: datetime
    originator: UserResponse
    lands: list[ProjectLandResponse]
    brand: BrandResponse
    stage: StageResponse
    status: StatusResponse
    lease_request: LeaseRequestResponse | None = None
    cases: list[CaseResponse] = []

class ProjectDocResponse(ProjectBase):
    id: int
    name: str
    brand_id: int
    stage_id: int 
    originator_id: int
    created_at: datetime
    updated_at: datetime
    brand: BrandResponse
    stage: StageResponse
    status: StatusResponse
    
    class Config:
        orm_mode = True