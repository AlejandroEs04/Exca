from pydantic import BaseModel
from datetime import datetime
from app.database.schemas.condition_option_schema import ConditionOptionResponse

class ConditionBase(BaseModel):
    name: str
    description: str | None = None
    type_id: int
    category_id: int
    is_active: bool
    
class ConditionResponse(ConditionBase):
    id: int
    created_at: datetime
    updated_at: datetime
    options: list[ConditionOptionResponse] = []
    
    class Config:
        from_attributes = True