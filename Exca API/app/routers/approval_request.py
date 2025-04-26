from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.database.models.approval_request import ApprovalRequest

router = APIRouter(prefix="/approval-request", tags=["ApprovalRequests"])

@router.get('/{request_id}/Approve', status_code=status.HTTP_201_CREATED)
def response_approval_request(request_id: int, db: Session = Depends(get_db)):
    current_step = db.query(ApprovalRequest).filter(ApprovalRequest.id == request_id)
    
    if not current_step:
        raise HTTPException(
            status_code=404, 
            detail="La solicitud no existe"
        )