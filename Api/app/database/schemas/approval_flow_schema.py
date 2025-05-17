from pydantic import BaseModel
from app.database.schemas.approval_flow_step_schema import ApprovalFlowStepResponse, ApprovalFlowStepCreate

class ApprovalFlowBase(BaseModel):
    name: str
    
class ApprovalFlowCreate(ApprovalFlowBase):
    steps: list[ApprovalFlowStepCreate] = []
    
class ApprovalFlowResponse(ApprovalFlowBase):
    id: int
    steps: list[ApprovalFlowStepResponse] = []
    
    class config:
        from_attributes = True
