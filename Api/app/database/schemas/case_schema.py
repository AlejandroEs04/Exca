from pydantic import BaseModel

class CaseBase(BaseModel):
    project_id: int
    originator_id: int
    type_id: int
    