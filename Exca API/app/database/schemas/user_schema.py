from pydantic import BaseModel, EmailStr
from typing import Optional

from app.database.schemas.rol_schema import RolResponse
from app.database.schemas.area_schema import AreaResponse

class UserBase(BaseModel):
    full_name: str
    email: EmailStr
    rol_id: int
    area_id: int
    
class UserCreate(UserBase):
    password: str
    
class UserResponse(UserBase):
    id: int
    rol: RolResponse | None = None
    area: AreaResponse | None = None
    class Config:
        from_attributes = True
        
class Token(BaseModel):
    access_token: str
    token_type: str

class LoginData(BaseModel):
    email: str
    password: str
