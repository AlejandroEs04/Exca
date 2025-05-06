from pydantic import BaseModel
from app.database.schemas.condition_schema import ConditionResponse

class LeaseRequestConditionBase(BaseModel):
    condition_id: int
    value: str
    is_active: bool

class LeaseRequestConditionCreate(LeaseRequestConditionBase):
    pass

class LeaseRequestConditionResponse(LeaseRequestConditionBase):
    id: int
    lease_request_id: int
    condition: ConditionResponse | None = None
    
    class config:
        from_attributes = True