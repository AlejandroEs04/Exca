from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.connection import get_db

from app.database.models.document import Document
from app.database.schemas.document_schema import DocumentResponse

router = APIRouter(prefix="/document", tags=["Documents"])

@router.get('/types', response_model=list[DocumentResponse])
def get_types(db: Session = Depends(get_db)):
    return db.query(Document).all()
