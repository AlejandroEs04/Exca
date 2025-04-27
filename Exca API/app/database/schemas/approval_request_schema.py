from pydantic import BaseModel
from app.database.schemas.approval_step_schema import ApprovalStepResponse

class ApprovalRequestBase(BaseModel):
    item_id: int
    
class ApprovalRequestCreate(ApprovalRequestBase):
    flow_id: int

class ApprovalRequestResponse(BaseModel):
    id: int
    response: bool

class ApprovalRequestResponse(ApprovalRequestBase):
    id: int
    response: bool | None = None
    step_id: int | None = None
    step: ApprovalStepResponse | None = None
    
    class config:
        orm_mode=True