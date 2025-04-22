from fastapi import APIRouter, Depends
from sqlalchemy import select
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal

from app.database.models.land import Land
from app.database.schemas.land_schema import LandCreate, LandResponse

from app.database.models.residential_development import ResidentialDevelopment
from app.database.schemas.residential_development_schema import ResidentialDevelopmentResponse

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
        residential_development_id=residential_development_id
    )
    db.add(new_land)
    db.commit()
    db.refresh(new_land)
    return new_land

@router.get("/", response_model=list[LandResponse])
def get_lands(db: Session = Depends(get_db)):
    lands = db.query(Land).options(joinedload(Land.residential_development)).all()
    return lands

@router.get("/residential-developments", response_model=list[ResidentialDevelopmentResponse])
def get_residential_developments(db: Session = Depends(get_db)):
    residential_developments = db.query(ResidentialDevelopment).all()
    return residential_developments