from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.residential_development import ResidentialDevelopment
from app.database.schemas.residential_development_schema import (
    ResidentialDevelopmentCreate,
    ResidentialDevelopmentUpdate,
    ResidentialDevelopmentResponse,
)

router = APIRouter(prefix="/residential-developments", tags=["ResidentialDevelopments"])

@router.post("/", response_model=ResidentialDevelopmentResponse)
def create_residential_development(
    payload: ResidentialDevelopmentCreate,
    db: Session = Depends(get_db)
):
    """
    Crea un nuevo fraccionamiento.
    """
    data = payload.model_dump()
    new_rd = ResidentialDevelopment(**data)
    db.add(new_rd)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating residential development.")
    db.refresh(new_rd)
    return new_rd

@router.put("/", response_model=ResidentialDevelopmentResponse)
def update_residential_development(
    payload: ResidentialDevelopmentUpdate,
    db: Session = Depends(get_db)
):
    """
    Actualiza un fraccionamiento existente.
    """
    rd = db.get(ResidentialDevelopment, payload.id)
    if not rd:
        raise HTTPException(status_code=404, detail="ResidentialDevelopment not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(rd, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating residential development.")
    db.refresh(rd)
    return rd

@router.get("/", response_model=list[ResidentialDevelopmentResponse])
def list_residential_developments(db: Session = Depends(get_db)):
    """
    Devuelve la lista de todos los fraccionamientos.
    """
    return db.query(ResidentialDevelopment).all()
