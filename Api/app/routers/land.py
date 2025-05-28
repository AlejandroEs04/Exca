from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.models.property_tax import PropertyTax
from app.database.schemas.property_tax_schema import PropertyTaxResponse
from app.database.connection import get_db
from app.database.models.land import Land
from app.database.schemas.land_schema import LandCreate, LandResponse, LandUpdate

router = APIRouter(prefix="/land", tags=["Lands"])

@router.post("/", response_model=LandResponse)
def create_land(payload: LandCreate, db: Session = Depends(get_db)):
    print("CREANDO LAND")
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
    print("UPDATE LAND: ID =", payload.id)
    land = db.get(Land, payload.id)
    if not land:
        raise HTTPException(status_code=404, detail="Land not found")

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

@router.get("/getLandById/{id}", response_model=LandResponse)
def get_land_by_id(id: int, db: Session = Depends(get_db)):
    land = db.get(Land, id)
    if not land:
        raise HTTPException(status_code=404, detail="Land not found")
    return land

@router.get("/{land_id}/property-taxes", response_model=list[PropertyTaxResponse])
def get_property_taxes_by_land_id(
    land_id: int,
    db: Session = Depends(get_db)
):
    """
    Devuelve todas las PropertyTax asociadas a la land con id = land_id.
    """
    # Opcional: validar que la land exista
    if not db.get(Land, land_id):
        raise HTTPException(status_code=404, detail=f"Land {land_id} not found")

    taxes = (
        db.query(PropertyTax)
        .filter(PropertyTax.land_id == land_id)
        .order_by(PropertyTax.tax_year.desc())
        .all()
    )
    return taxes