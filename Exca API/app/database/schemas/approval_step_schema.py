from pydantic import BaseModel

class ApprovalStepBase(BaseModel):
    next_step_id: int | None = None
    flow_id: int
    signator_id: int
    
class ApprovalStepCreate(ApprovalStepBase):
    pass

class ApprovalStepResponse(ApprovalStepBase):
    id: int
    
    class config:
        orm_mode=True