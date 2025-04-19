from pydantic import BaseModel, EmailStr
from typing import Optional

class UserBase(BaseModel):
    full_name: str
    email: EmailStr
    rol_id: int
    area_id: int
    
class UserCreate(UserBase):
    password: str
    
class UserResponse(UserBase):
    id: int
    
    class Config:
        orm_mode = True