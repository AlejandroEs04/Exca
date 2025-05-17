from pydantic import BaseModel
from datetime import datetime
from app.database.schemas.lease_request_condition_schema import LeaseRequestConditionCreate, LeaseRequestConditionResponse
from app.database.schemas.individual_schema import IndividualResponse
from app.database.schemas.user_schema import UserResponse

class LeaseRequestBase(BaseModel):
    project_id: int
    guarantee_type_id: int
    owner_id: int
    commission_agreement: bool
    assignment_income: bool
    property_file: str
    guarantee_id: int

class LeaseRequestCreate(LeaseRequestBase):
    conditions: list[LeaseRequestConditionCreate]
    
class LeaseRequestResponse(LeaseRequestBase):
    id: int
    guarantee_id: int
    conditions: list[LeaseRequestConditionResponse] = []
    created_at: datetime
    updated_at: datetime
    guarantee: IndividualResponse | None = None
    status_id: int
    created_by: int
    creator: UserResponse
    
    class config:
        from_attributes = True