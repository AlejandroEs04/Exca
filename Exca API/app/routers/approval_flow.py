from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal
from app.database.models.approval_flow import ApprovalFlow
from app.database.schemas.approval_flow_schema import ApprovalFlowResponse

router = APIRouter(prefix="/approval-flow", tags=["ApprovalFlows"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.get("/", response_model=list[ApprovalFlowResponse])
def get_approval_request(db: Session = Depends(get_db)):
    return db.query(ApprovalFlow).all()