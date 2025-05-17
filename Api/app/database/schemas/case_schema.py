from pydantic import BaseModel
from datetime import datetime
from app.database.schemas.case_type_schema import CaseTypeResponse
from app.database.schemas.case_condition_schema import CaseConditionCreate, CaseConditionResponse

class CaseBase(BaseModel):
    project_id: int
    case_type_id: int
    
class CaseCreate(CaseBase):
    conditions: list[CaseConditionCreate]

class CaseResponse(CaseBase):
    id: int
    created_at: datetime
    sended_at: datetime
    updated_at: datetime
    status_id: int
    type: CaseTypeResponse
    originator_id: int
    conditions: list[CaseConditionResponse]
    
    class config:
        orm_mode = True