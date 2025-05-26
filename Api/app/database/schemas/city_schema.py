from pydantic import BaseModel

class CityCreate(BaseModel):
    id_estado: int
    clave_municipio: int
    descripcion: str

class CityUpdate(CityCreate):
    id: int

class CityResponse(BaseModel):
    id: int
    id_estado: int
    clave_municipio: int
    descripcion: str

    class Config:
        from_attributes = True
