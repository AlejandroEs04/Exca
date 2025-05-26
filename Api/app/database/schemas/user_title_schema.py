from pydantic import BaseModel

class UserTitleBase(BaseModel):
    name: str
    
class UserTitleCreate(UserTitleBase):
    pass

class UserTitleResponse(UserTitleBase):
    id: int
    
    class config:
        orm_mode = True