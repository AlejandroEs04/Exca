from pydantic import BaseModel

class CaseTypeBase(BaseModel):
    name: str
    description: str
    
class CaseTypeCreate(CaseTypeBase):
    pass

class CaseTypeResponse(CaseTypeBase):
    id: int
    
    class config:
        orm_mode = True