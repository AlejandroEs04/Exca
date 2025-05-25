from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime

class PropertyTaxStatusBase(BaseModel):
    description: str

class PropertyTaxStatusCreate(PropertyTaxStatusBase):
    pass

class PropertyTaxStatusUpdate(PropertyTaxStatusBase):
    id: int

class PropertyTaxStatusResponse(PropertyTaxStatusBase):
    id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
