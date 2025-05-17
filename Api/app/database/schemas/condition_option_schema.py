from pydantic import BaseModel

class ConditionOptionBase(BaseModel):
    condition_id: int
    option_value: str
    display_order: int
    is_active: bool
    
class ConditionOptionCreate(ConditionOptionBase):
    pass

class ConditionOptionResponse(ConditionOptionBase):
    id: int
    
    class config:
        orm_mode=True