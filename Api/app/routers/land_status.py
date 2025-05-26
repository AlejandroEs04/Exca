from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.land_status import LandStatus
from app.database.schemas.land_status_schema import (
    LandStatusCreate,
    LandStatusResponse,
    LandStatusUpdate,
)

router = APIRouter(prefix="/land-statuses", tags=["LandStatuses"])

@router.post("/", response_model=LandStatusResponse)
def create_land_status(payload: LandStatusCreate, db: Session = Depends(get_db)):
    """
    Crea un nuevo estado de terreno.
    """
    data = payload.model_dump()
    new_status = LandStatus(**data)
    db.add(new_status)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating land status: invalid data.")
    db.refresh(new_status)
    return new_status

@router.put("/", response_model=LandStatusResponse)
def update_land_status(payload: LandStatusUpdate, db: Session = Depends(get_db)):
    """
    Actualiza un estado de terreno existente.
    """
    status_obj = db.get(LandStatus, payload.id)
    if not status_obj:
        raise HTTPException(status_code=404, detail="LandStatus not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(status_obj, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating land status.")
    db.refresh(status_obj)
    return status_obj

@router.get("/", response_model=list[LandStatusResponse])
def list_land_statuses(db: Session = Depends(get_db)):
    """
    Devuelve la lista de todos los estados de terreno.
    """
    return db.query(LandStatus).all()
