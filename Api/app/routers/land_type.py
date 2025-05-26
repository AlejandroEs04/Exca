from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.land_type import LandType
from app.database.schemas.land_type_schema import (
    LandTypeCreate,
    LandTypeResponse,
    LandTypeUpdate,
)

router = APIRouter(prefix="/land-types", tags=["LandTypes"])

@router.post("/", response_model=LandTypeResponse)
def create_land_type(payload: LandTypeCreate, db: Session = Depends(get_db)):
    """
    Crea un nuevo tipo de terreno.
    """
    data = payload.model_dump()
    new_type = LandType(**data)
    db.add(new_type)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating land type: invalid data.")
    db.refresh(new_type)
    return new_type

@router.put("/", response_model=LandTypeResponse)
def update_land_type(payload: LandTypeUpdate, db: Session = Depends(get_db)):
    """
    Actualiza un tipo de terreno existente.
    """
    type_obj = db.get(LandType, payload.id)
    if not type_obj:
        raise HTTPException(status_code=404, detail="LandType not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(type_obj, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating land type.")
    db.refresh(type_obj)
    return type_obj

@router.get("/", response_model=list[LandTypeResponse])
def list_land_types(db: Session = Depends(get_db)):
    """
    Devuelve la lista de todos los tipos de terreno.
    """
    return db.query(LandType).all()
