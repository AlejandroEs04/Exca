from fastapi import APIRouter, Depends, status
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal

from app.database.models.client import Client
from app.database.schemas.client_schema import ClientCreate, ClientResponse

from app.database.models.client_type import ClientType
from app.database.schemas.client_type_schema import ClientTypeResponse

router = APIRouter(prefix="/client", tags=["Clients"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.post("/", response_model=ClientResponse)
def create_company(company: ClientCreate, db: Session = Depends(get_db)):
    new_company = Client(**company.model_dump())
    db.add(new_company)
    db.commit()
    db.refresh(new_company)
    return new_company

@router.get("/", response_model=list[ClientResponse])
def get_companies(db: Session = Depends(get_db)):
    clients =  db.query(Client).options(joinedload(Client.brands)).all()
    return clients

@router.put('/', response_model=ClientResponse)
def update_client(id: int, client: ClientCreate, db: Session = Depends(get_db)):
    db_client = db.query(Client).filter(Client.id == id).first()
    
    if not db_client:
        return None
    for key, value in client.model_dump().items():
        setattr(db_client, key, value)
        
    db.commit()
    db.refresh(db_client)
    return db_client

@router.delete("/", status_code=status.HTTP_201_CREATED)
def delete_client(id: int, db: Session = Depends(get_db)):
    db_client = db.query(Client).filter(Client.id == id).first()
    
    if not db_client:
        return None
    
    db.delete(db_client)
    db.commit()
    return {"message": "Client deleted successfully"}    
        
@router.get("/types", response_model=list[ClientTypeResponse])
def get_company_types(db: Session = Depends(get_db)):
    return db.query(ClientType).all()

@router.post('/document', response_model=list[ClientResponse])
def create_document():
    return