from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime

class LandCategoryBase(BaseModel):
    description: str

class LandCategoryCreate(LandCategoryBase):
    pass

class LandCategoryUpdate(LandCategoryBase):
    id: int

class LandCategoryResponse(LandCategoryBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
