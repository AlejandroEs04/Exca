from pydantic import BaseModel

class GuaranteeBase(BaseModel):
    name: str
    
class GuaranteeCreate(GuaranteeBase):
    pass

class GuaranteeResponse(GuaranteeBase):
    id: int
    
    class config:
        from_attributes = True