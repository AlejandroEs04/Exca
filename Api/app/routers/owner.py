from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.connection import SessionLocal

from app.database.models.owner import Owner
from app.database.schemas.owner_schema import OwnerResponse, OwnerCreate

router = APIRouter(prefix="/owner", tags=["Owners"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.post("/", response_model=OwnerResponse)
def create_owner(owner: OwnerCreate, db: Session = Depends(get_db)):
    new_company = Owner(**owner.model_dump())
    db.add(new_company)
    db.commit()
    db.refresh(new_company)
    return new_company

@router.get("/", response_model=list[OwnerResponse])
def get_owners(db: Session = Depends(get_db)):
    return db.query(Owner).all()
