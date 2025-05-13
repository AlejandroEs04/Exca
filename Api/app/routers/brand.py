from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.connection import SessionLocal

from app.database.models.brand import Brand
from app.database.schemas.brand_schema import BrandCreate, BrandResponse

router = APIRouter(prefix="/brand", tags=["Brands"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.post("/", response_model=BrandResponse)
def create_client(client: BrandCreate, db: Session = Depends(get_db)):
    new_client = Brand(**client.model_dump())
    db.add(new_client)
    db.commit()
    db.refresh(new_client)
    return new_client

@router.get("/", response_model=list[BrandResponse])
def get_clients(db: Session = Depends(get_db)):
    return db.query(Brand).all()