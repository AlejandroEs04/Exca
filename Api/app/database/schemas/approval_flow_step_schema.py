from pydantic import BaseModel
from typing import Optional

class ApprovalFlowStepBase(BaseModel):
    flow_id: int
    step_order: int
    signator_role_id: Optional[int]
    signator_area_id: Optional[int]
    signator_id: Optional[int]
    is_required: bool
    
class ApprovalFlowStepCreate(ApprovalFlowStepBase):
    pass

class ApprovalFlowStepResponse(ApprovalFlowStepBase):
    id: int
    
    class config:
        from_attributes = True