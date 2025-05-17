from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.connection import SessionLocal

from app.database.models.area import Area
from app.database.schemas.area_schema import AreaResponse

router = APIRouter(prefix="/area", tags=["Areas"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.get("/", response_model=list[AreaResponse])
def get_clients(db: Session = Depends(get_db)):
    return db.query(Area).all()