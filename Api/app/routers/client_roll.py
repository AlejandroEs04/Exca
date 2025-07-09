from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.database.schemas.client_roll_schema import ClientRollCreate, ClientRollResponse
from app.database.models.client_roll import ClientRoll

router = APIRouter(prefix="/client-rolls", tags=["ClientRolls"])

@router.get("/", response_model=list[ClientRollResponse])
def get_client_rolls(db: Session = Depends(get_db)):
    return db.query(ClientRoll).all()

@router.post("/", response_model=ClientRollResponse)
def create_client_rolls(client_roll: ClientRollCreate, db: Session = Depends(get_db)):
    new_client_roll = ClientRoll(**client_roll.model_dump())
    db.add(new_client_roll)
    
    try:
        db.commit()
    except:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating client roll")
    
    db.refresh(new_client_roll)
    return new_client_roll