from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.connection import SessionLocal

from app.database.models.land import Land
from app.database.schemas.land_schema import LandCreate, LandResponse

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
    new_land = Land(**land.model_dump())
    db.add(new_land)
    db.commit()
    db.refresh(new_land)
    return new_land

@router.get("/", response_model=list[LandResponse])
def get_lands(db: Session = Depends(get_db)):
    return db.query(Land).all()