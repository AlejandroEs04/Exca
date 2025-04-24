from pydantic import BaseModel

class IndividualBase(BaseModel):
    full_name: str
    tax_id: str
    address: str
    
class IndividualCreate(IndividualBase):
    pass

class IndividualResponse(IndividualBase):
    id: int