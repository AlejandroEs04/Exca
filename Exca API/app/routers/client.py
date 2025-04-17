from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.connection import SessionLocal

from app.database.models.client import Client
from app.database.schemas.client_schema import ClientCreate, ClientResponse

router = APIRouter(prefix="/client", tags=["Clients"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.post("/", response_model=ClientResponse)
def create_client(client: ClientCreate, db: Session = Depends(get_db)):
    new_client = Client(**client.model_dump())
    db.add(new_client)
    db.commit()
    db.refresh(new_client)
    return new_client

@router.get("/", response_model=list[ClientResponse])
def get_clients(db: Session = Depends(get_db)):
    return db.query(Client).all()