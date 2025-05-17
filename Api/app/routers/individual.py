from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.connection import SessionLocal
from app.database.models.client_address import ClientAddress
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
    address_id = None
    
    if individual.address:
        new_address = ClientAddress(
            client_id=individual.client_id,
            street=individual.address.street,
            city=individual.address.city,
            state=individual.address.state,
            postal_code=individual.address.postal_code,
            country=individual.address.country,
            is_primary=individual.address.is_primary
        )
        db.add(new_address)
        db.commit()
        db.refresh(new_address)
        address_id = new_address.id
    elif individual.address_id:
      address_id = individual.address_id  
    
    new_individual = Individual(
        full_name=individual.full_name, 
        tax_id=individual.tax_id,
        address_id=address_id,
        client_id=individual.client_id
    )
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