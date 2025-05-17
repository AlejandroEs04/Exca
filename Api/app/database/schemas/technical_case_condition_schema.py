from pydantic import BaseModel
from app.database.schemas.condition_schema import ConditionResponse

class TechnicalCaseConditionBase(BaseModel):
    condition_id: int
    value: str | None = None
    is_active: bool = True

class TechnicalCaseConditionCreate(TechnicalCaseConditionBase):
    pass

class TechnicalCaseConditionResponse(TechnicalCaseConditionBase):
    id: int
    technical_case_id: int
    condition: ConditionResponse
    
    class config:
        orm_mode=True