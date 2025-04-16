from pydantic import BaseModel

class CompanyTypeBase(BaseModel):
    name: str

class CompanyTypeCreate(CompanyTypeBase):
    pass

class CompanyTypeResponse(CompanyTypeCreate):
    id: int

    class config:
        orm_mode = True