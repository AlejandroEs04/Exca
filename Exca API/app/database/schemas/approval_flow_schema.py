from pydantic import BaseModel
from app.database.schemas.approval_step_schema import ApprovalStepResponse

class ApprovalFlowBase(BaseModel):
    name: str
    
class ApprovalFlowCreate(ApprovalFlowBase):
    pass

class ApprovalFlowResponse(ApprovalFlowBase):
    id: int
    steps: list[ApprovalStepResponse] = []
    
    class config:
        orm_mode = True