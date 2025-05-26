from pydantic import BaseModel, model_validator, ValidationError
from typing import Optional
from datetime import datetime
from app.database.schemas.condition_schema import ConditionResponse

class CaseConditionBase(BaseModel):
    case_id: int | None = None
    condition_id: int
    text_value: Optional[str] = None
    number_value: Optional[float] = None
    date_value: Optional[datetime] = None
    boolean_value: Optional[bool] = None
    option_id: Optional[int] = None
    is_active: bool = True
    
class CaseConditionCreate(CaseConditionBase):
    pass

class CaseConditionResponse(CaseConditionBase):
    id: int
    condition: ConditionResponse
    
    class config:
        from_attributes = True