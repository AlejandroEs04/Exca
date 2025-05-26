from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime

class LandTypeBase(BaseModel):
    description: str

class LandTypeCreate(LandTypeBase):
    pass

class LandTypeUpdate(LandTypeBase):
    id: int

class LandTypeResponse(LandTypeBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
