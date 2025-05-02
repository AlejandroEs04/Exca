from pydantic import BaseModel

class ProjectLandTypeBase(BaseModel):
    name: str
    
class ProjectLandTypeCreate(ProjectLandTypeBase):
    pass

class ProjectLandTypeResponse(ProjectLandTypeBase):
    id: int
    
    class Config:
        from_attributes = True