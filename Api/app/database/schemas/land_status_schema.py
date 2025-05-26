from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime

class LandStatusBase(BaseModel):
    description: str

class LandStatusCreate(LandStatusBase):
    pass

class LandStatusUpdate(LandStatusBase):
    id: int

class LandStatusResponse(LandStatusBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
