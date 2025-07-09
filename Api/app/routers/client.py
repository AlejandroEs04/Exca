from fastapi import APIRouter, Depends, status
from sqlalchemy.orm import Session, joinedload
from app.database.connection import get_db
from app.database.models.client import Client
from app.database.models.client_address import ClientAddress
from app.database.schemas.client_schema import ClientCreate, ClientResponse
from app.database.schemas.brand_schema import BrandResponse, BrandCreate
from app.database.models.brand import Brand
from app.database.models.client_type import ClientType
from app.database.schemas.client_type_schema import ClientTypeResponse

router = APIRouter(prefix="/client", tags=["Clients"])
        
@router.post("/", response_model=ClientResponse)
def create_client(client: ClientCreate, db: Session = Depends(get_db)):
    new_client = Client(
        business_name=client.business_name, 
        email=client.email,
        phone_number=client.phone_number,
        tax_id=client.tax_id,
        type_id=client.type_id,
        turn_id=client.turn_id,
        roll_id=client.roll_id
    )
    db.add(new_client)
    db.commit()
    db.refresh(new_client)
    
    if client.address:
        new_address = ClientAddress(
            client_id=new_client.id,
            street=client.address.street,
            city=client.address.city,
            state=client.address.state,
            postal_code=client.address.postal_code,
            country=client.address.country,
            is_primary=client.address.is_primary
        )
        db.add(new_address)
        db.commit()
        db.refresh(new_client)
    
    return new_client

@router.get("/", response_model=list[ClientResponse])
def get_companies(db: Session = Depends(get_db)):
    return db.query(Client).all()

@router.post("/brand", response_model=BrandResponse)
def create_brand(brand: BrandCreate, db: Session = Depends(get_db)):
    new_brand =  Brand(**brand.model_dump())
    db.add(new_brand)
    db.commit()
    db.refresh(new_brand)
    return new_brand
        
@router.get("/types", response_model=list[ClientTypeResponse])
def get_company_types(db: Session = Depends(get_db)):
    return db.query(ClientType).all()

@router.post('/document', response_model=list[ClientResponse])
def create_document():
    return