from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.connection import SessionLocal

from app.database.models.individual import Individual
from app.database.models.guarantee_type import GuaranteeType
from app.database.schemas.individual_schema import IndividualCreate, IndividualResponse
from app.database.schemas.guarantee_type_schema import GuaranteeResponse

router = APIRouter(prefix="/individual", tags=["Individuals"])

def get_db():
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.post("/", response_model=IndividualResponse)
def create_individual(individual: IndividualCreate, db: Session = Depends(get_db)):
    new_individual = Individual(**individual.model_dump())
    db.add(new_individual)
    db.commit()
    db.refresh(new_individual)
    return new_individual

@router.get("/", response_model=list[IndividualResponse])
def get_individuals(db: Session = Depends(get_db)):
    return db.query(Individual).all()

@router.get("/guarantee-type", response_model=list[GuaranteeResponse])
def get_guarantee_types(db: Session = Depends(get_db)):
    return db.query(GuaranteeType).all()