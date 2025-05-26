from pydantic import BaseModel
from app.database.schemas.technical_case_condition_schema import TechnicalCaseConditionCreate, TechnicalCaseConditionResponse
from datetime import datetime

class TechnicalCaseBase(BaseModel):
    project_id: int
    
class TechnicalCaseCreate(TechnicalCaseBase):
    conditions: list[TechnicalCaseConditionCreate]

class TechnicalCaseResponse(TechnicalCaseBase):
    id: int
    originator_id: int
    conditions: list[TechnicalCaseConditionResponse] = []
    created_at: datetime
    updated_at: datetime
    sended_at: datetime | None = None
    
    class config:
        from_attributes = True