from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.land import Land
from app.database.schemas.land_schema import LandCreate, LandResponse, LandUpdate

router = APIRouter(prefix="/land", tags=["Lands"])

@router.post("/", response_model=LandResponse)
def create_land(payload: LandCreate, db: Session = Depends(get_db)):
 
    new_land = Land(**payload.model_dump())
    db.add(new_land)
    try:
        db.commit()
    except IntegrityError as e:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating land: posibles claves foráneas inválidas.")
    db.refresh(new_land)
    return new_land

@router.put("/", response_model=LandResponse)
def update_land(payload: LandUpdate, db: Session = Depends(get_db)):

    land = db.get(Land, payload.id)
    if not land:
        raise HTTPException(status_code=404, detail="Land not found")
    # Solo actualiza los atributos provistos
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(land, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating land data.")
    db.refresh(land)
    return land

@router.get("/", response_model=list[LandResponse])
def list_lands(db: Session = Depends(get_db)):
    return db.query(Land).all()
