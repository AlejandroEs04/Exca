from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.connection import SessionLocal
from app.database.models.businessTurn import BusinessTurn
from app.database.schemas.businessTurn_schema import BusinessTurnCreate, BusinessTurnResponse

# Declare endpoint for business turns
router = APIRouter(prefix="/businessTurn", tags=["BusinessTurns"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()

## Create endpoint for create a business turn
@router.post("/", response_model=BusinessTurnResponse)
def create_businessTurn(businessTurn: BusinessTurnCreate, db: Session = Depends(get_db)):
    db_businessTurn = BusinessTurn(**businessTurn.model_dump())
    db.add(db_businessTurn)
    db.commit()
    db.refresh(db_businessTurn)
    return db_businessTurn

@router.get("/", response_model=list[BusinessTurnResponse])
def get_businessTurns(db: Session = Depends(get_db)):
    return db.query(BusinessTurn).all()