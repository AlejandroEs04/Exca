from pydantic import BaseModel
from app.database.schemas.user_schema import UserResponse

class ApprovalStepBase(BaseModel):
    signator_id: int
    
class ApprovalStepCreate(ApprovalStepBase):
    order: int

class ApprovalFlowResponse(BaseModel):
    id: int
    name: str

class ApprovalStepResponse(ApprovalStepBase):
    id: int
    flow_id: int
    next_step_id: int | None = None
    flow: ApprovalFlowResponse | None = None
    signator: UserResponse | None = None
    
    class config:
        from_attributes = True