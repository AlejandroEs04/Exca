from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.connection import SessionLocal

from app.database.models.user_rol import UserRol
from app.database.schemas.rol_schema import RolResponse

router = APIRouter(prefix="/rol", tags=["Roles"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.get("/", response_model=list[RolResponse])
def get_clients(db: Session = Depends(get_db)):
    return db.query(UserRol).all()