from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.orm import Session, joinedload
from sqlalchemy.exc import IntegrityError

from app.database.connection import SessionLocal

from app.database.models.land import Land
from app.database.schemas.land_schema import LandCreate, LandResponse, LandUpdate

from app.database.models.residential_development import ResidentialDevelopment
from app.database.schemas.residential_development_schema import ResidentialDevelopmentResponse


from app.database.models.city import CityDevelopment
from app.database.schemas.city_schema import CityDevelopmentResponse

router = APIRouter(prefix="/land", tags=["Lands"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()




@router.post("/", response_model=LandResponse)
def create_land(land: LandCreate, db: Session = Depends(get_db)):
    residential_development_id = None
    residential_development = select(ResidentialDevelopment).where(ResidentialDevelopment.name == land.residential_development)
    residential_development_exists = db.scalars(residential_development).first()
    
    if(not residential_development_exists):
        new_residential_development = ResidentialDevelopment(
            name=land.residential_development
        )
        db.add(new_residential_development)
        db.commit()
        db.refresh(new_residential_development)
        residential_development_id = new_residential_development.id
    else: 
        residential_development_id = residential_development_exists.id
        
    new_land = Land(
        cadastral_file=land.cadastral_file,
        area=land.area,
        price_per_area=land.price_per_area,
        address=land.address,
        residential_development_id=residential_development_id,
        build_area=land.build_area,
        city=land.city,
        state=land.state
    )
    db.add(new_land)
    db.commit()
    db.refresh(new_land)
    return new_land

@router.post("/updateLand", response_model=LandResponse)
def update_land(land: LandUpdate, db: Session = Depends(get_db)):
    # Buscar el objeto 'Land' por su ID
    existing_land = db.query(Land).filter(Land.id == land.id).first()

    # Verificar que el objeto exista
    if not existing_land:
        raise HTTPException(status_code=404, detail="Land not found")

    # Actualizar los valores del objeto 'Land' con los nuevos datos
    existing_land.cadastral_file             = land.cadastral_file
    existing_land.area                       = land.area
    existing_land.price_per_area             = land.price_per_area
    existing_land.address                    = land.address
    existing_land.residential_development_id = land.residential_development_id
    existing_land.municipio                  = land.municipio
    existing_land.valor_catastral            = land.valor_catastral
    existing_land.pago_predial               = land.pago_predial
    existing_land.area_construida            = land.area_construida
    existing_land.global_status              = land.global_status
    try:
        db.commit()  # Guardamos los cambios
        db.refresh(existing_land)  # Refrescamos el objeto con los nuevos valores
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating land data.")

    return existing_land



@router.get("/", response_model=list[LandResponse])
def get_lands(db: Session = Depends(get_db)):
    lands = db.query(Land).options(joinedload(Land.residential_development)).all()
    return lands

@router.get("/residential-developments", response_model=list[ResidentialDevelopmentResponse])
def get_residential_developments(db: Session = Depends(get_db)):
    residential_developments = db.query(ResidentialDevelopment).all()
    return residential_developments

@router.get("/cities", response_model=list[CityDevelopmentResponse])
def getCities(db: Session = Depends(get_db)):
    residential_developments = db.query(CityDevelopment).all()
    return residential_developments