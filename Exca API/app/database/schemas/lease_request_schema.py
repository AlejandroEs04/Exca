from pydantic import BaseModel
from datetime import datetime
from app.database.schemas.lease_request_condition_schema import LeaseRequestConditionCreate, LeaseRequestConditionResponse

class LeaseRequestBase(BaseModel):
    project_id: int

class LeaseRequestCreate(LeaseRequestBase):
    conditions: list[LeaseRequestConditionCreate]
    
class LeaseRequestResponse(LeaseRequestBase):
    id: int
    conditions: list[LeaseRequestConditionResponse]
    created_at: datetime
    updated_at: datetime
    
    class config:
        orm_mode=True