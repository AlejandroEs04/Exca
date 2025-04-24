from pydantic import BaseModel

class ApprovalStepBase(BaseModel):
    signator_id: int
    
class ApprovalStepCreate(ApprovalStepBase):
    order: int

class ApprovalStepResponse(ApprovalStepBase):
    id: int
    flow_id: int
    next_step_id: int | None = None
    
    class config:
        orm_mode=True