from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.connection import SessionLocal

from app.database.models.condition import Condition
from app.database.schemas.condition_schema import ConditionResponse

router = APIRouter(prefix="/condition", tags=["Conditions"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.get("/", response_model=list[ConditionResponse])
def get_conditions(db: Session = Depends(get_db)):
    return db.query(Condition).all()