from pydantic import BaseModel

class IndividualBase(BaseModel):
    full_name: str
    tax_id: str | None = None
    address: str | None = None
    
class IndividualCreate(IndividualBase):
    pass

class IndividualResponse(IndividualBase):
    id: int