from pydantic import BaseModel

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
    
    class config:
        orm_mode=True