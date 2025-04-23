from fastapi import APIRouter, Depends
from sqlalchemy import select
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal

from app.database.models.lease_request import LeaseRequest
from app.database.schemas.lease_request_schema import LeaseRequestCreate, LeaseRequestResponse

from app.database.models.lease_request_condition import LeaseRequestCondition

router = APIRouter(prefix='/lease-request', tags=["LeaseRequests"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.post("/", response_model=LeaseRequestResponse)
def create_request(request: LeaseRequestCreate, db: Session = Depends(get_db)):
    new_request = LeaseRequest(
        project_id=request.project_id, 
        status_id=1
    )
    db.add(new_request)
    db.commit()
    db.refresh(new_request)
    
    for condition_data in request.conditions:
        new_condition = LeaseRequestCondition(
            condition_id = condition_data.condition_id, 
            lease_request_id = new_request.id,
            value = condition_data.value, 
            is_active = condition_data.is_active
        )
        db.add(new_condition)
        
    db.commit()
    return new_request

@router.put("/{request_id}", response_model=LeaseRequestResponse)
def update_request(request_id: int, request: LeaseRequestCreate, db: Session = Depends(get_db)):
    db.query(LeaseRequestCondition).filter(LeaseRequestCondition.lease_request_id == request_id).delete()
    
    for condition_data in request.conditions:
        new_condition = LeaseRequestCondition(
            condition_id = condition_data.condition_id, 
            lease_request_id = request_id,
            value = condition_data.value, 
            is_active = condition_data.is_active
        )
        db.add(new_condition)
        
    db.commit()
    
    return db.query(LeaseRequest).options(joinedload(LeaseRequest.conditions)).filter_by(id=request_id).first()

@router.get("/{request_id}", response_model=LeaseRequestResponse)
def get_request_by_id(request_id: int, db: Session = Depends(get_db)):
    return db.query(LeaseRequest).where(LeaseRequest.id == request_id).first()

@router.get("/", response_model=list[LeaseRequestResponse])
def get_leases(db: Session = Depends(get_db)):
    return db.query(LeaseRequest).options(joinedload(LeaseRequest.conditions).joinedload(LeaseRequestCondition.condition)).all()

@router.get('/project/{project_id}', response_model=list[LeaseRequestResponse])
def get_project_lease(project_id: int, db: Session = Depends(get_db)):
    lease = db.query(LeaseRequest).options(joinedload(LeaseRequest.conditions)).filter_by(project_id=project_id)
    return lease