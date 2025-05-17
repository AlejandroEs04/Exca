from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class CaseConditionBase(BaseModel):
    case_id: int
    condition_id: int
    text_value: Optional[str]
    number_value: Optional[float]
    date_value: Optional[datetime]
    boolean_value: Optional[bool]
    option_id: Optional[int]
    is_active: bool = True
    
class CaseConditionCreate(CaseConditionBase):
    pass

class CaseConditionResponse(CaseConditionBase):
    id: int
    
    class config:
        orm_mode = True