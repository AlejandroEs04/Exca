from pydantic import BaseModel
from typing import Optional, List
from app.database.schemas.city_schema import CityResponse

class StateCreate(BaseModel):
    clave_estado: int
    abreviacion_estado: str
    descripcion: str

class StateUpdate(StateCreate):
    id: int

class StateResponse(BaseModel):
    id: int
    clave_estado: int
    abreviacion_estado: str
    descripcion: str
    municipios: Optional[List[CityResponse]] = None
    class Config:
        from_attributes = True
