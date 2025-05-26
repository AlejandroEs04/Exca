from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.city import City
from app.database.schemas.city_schema import CityCreate, CityUpdate, CityResponse

router = APIRouter(prefix="/cities", tags=["Cities"])

@router.post("/", response_model=CityResponse)
def create_city(payload: CityCreate, db: Session = Depends(get_db)):
    """
    Crea un nuevo City.
    """
    new_city = City(**payload.model_dump())
    db.add(new_city)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating city: invalid foreign key or data.")
    db.refresh(new_city)
    return new_city

@router.put("/", response_model=CityResponse)
def update_city(payload: CityUpdate, db: Session = Depends(get_db)):
    """
    Actualiza un City existente.
    """
    city = db.get(City, payload.id)
    if not city:
        raise HTTPException(status_code=404, detail="City not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(city, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating city data.")
    db.refresh(city)
    return city

@router.get("/", response_model=list[CityResponse])
def list_cities(db: Session = Depends(get_db)):
    """
    Devuelve todos los Citys.
    """
    return db.query(City).all()
