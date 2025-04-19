from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal

from app.database.models.company import Company
from app.database.schemas.company_schema import CompanyCreate, CompanyResponse

from app.database.models.company_type import CompanyType
from app.database.schemas.company_type_schema import CompanyTypeResponse

router = APIRouter(prefix="/company", tags=["Companies"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.post("/", response_model=CompanyResponse)
def create_company(company: CompanyCreate, db: Session = Depends(get_db)):
    new_company = Company(**company.model_dump())
    db.add(new_company)
    db.commit()
    db.refresh(new_company)
    return new_company

@router.get("/", response_model=list[CompanyResponse])
def get_companies(db: Session = Depends(get_db)):
    return db.query(Company).all()
        
@router.get("/types", response_model=list[CompanyTypeResponse])
def get_company_types(db: Session = Depends(get_db)):
    companies = db.query(CompanyType).options(joinedload(Company.clients)).all()
    return companies