from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy import select
from sqlalchemy.orm import Session, joinedload
from app.database.connection import get_db
from app.database.models.individual import Individual
from app.database.models.lease_request import LeaseRequest
from app.database.schemas.lease_request_schema import LeaseRequestCreate, LeaseRequestResponse
from app.database.models.lease_request_condition import LeaseRequestCondition
from app.database.schemas.approval_request_schema import ApprovalRequestCreate
from app.database.models.project import Project
from app.database.schemas.project_schema import ProjectResponse
from app.database.models.approval_request import ApprovalRequest
from app.database.models.approval_step import ApprovalStep
from app.database.models.user import User
from app.utils.send_approval_email import build_email_body
from app.services.email import send_email
from datetime import datetime
from app.config import FRONTEND_URL

router = APIRouter(prefix='/lease-request', tags=["LeaseRequests"])
        
@router.post("/", response_model=LeaseRequestResponse)
def create_request(request: LeaseRequestCreate, db: Session = Depends(get_db)):
    guarantee_id = None
    guarantee_query = select(Individual).where(Individual.full_name == request.guarantee)
    guarantee_exists = db.scalars(guarantee_query).first()
    
    if(not guarantee_exists):
        new_guarantee = Individual(
            full_name = request.guarantee,
            address = request.guarantee_address
        )
        db.add(new_guarantee)
        db.commit()
        db.refresh(new_guarantee)
        guarantee_id = new_guarantee.id
    else:
        guarantee_id = guarantee_exists.id
        
    request_query = select(LeaseRequest).where(LeaseRequest.project_id == request.project_id)
    request_exists = db.scalars(request_query).first()
    
    new_request = None
    
    if not request_exists:
        new_request = LeaseRequest(
            project_id=request.project_id, 
            guarantee_id=guarantee_id,
            guarantee_type_id=request.guarantee_type_id,
            status_id=1,
            owner_id=request.owner_id,
            commission_agreement=request.owner_id,
            assignment_income=request.assignment_income,
            property_file=request.property_file
        )
        db.add(new_request)
        db.commit()
        db.refresh(new_request)
    else:
        request_exists.guarantee_id=guarantee_id
        request_exists.guarantee_type_id=request.guarantee_type_id
        request_exists.owner_id=request.owner_id
        request_exists.owner_id=request.owner_id
        request_exists.assignment_income=request.assignment_income
        request_exists.property_file=request.property_file
        
        db.query(LeaseRequestCondition).filter(LeaseRequestCondition.lease_request_id == request_exists.id).delete()
        
        db.commit()
        new_request = request_exists
    
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

@router.get("/", response_model=list[LeaseRequestResponse])
def get_leases(db: Session = Depends(get_db)):
    return db.query(LeaseRequest).options(joinedload(LeaseRequest.conditions).joinedload(LeaseRequestCondition.condition)).all()

@router.post("/send-to-approval", status_code=status.HTTP_201_CREATED, response_model=ProjectResponse)
def send_approval(approvalRequest: ApprovalRequestCreate, db: Session = Depends(get_db)):
    request_query = db.query(LeaseRequest).where(LeaseRequest.project_id == approvalRequest.item_id)
    request_exists = db.scalars(request_query).first()
    
    if not request_exists:
        raise HTTPException(
            status_code=404, 
            detail="Solicitud de contrato no encontrado"
        ) 
        
    request_exists.status_id = 2
    
    project_exists = db.query(Project).where(Project.id == request_exists.project_id)
    
    if not project_exists:
        raise HTTPException(
            status_code=404, 
            detail="Proyecto no encontrado"
        ) 
        
    project_exists.stage_id = 2
    db.commit()
    
    steps_query = db.query(ApprovalStep).where(ApprovalStep.flow_id == approvalRequest.flow_id)
    steps = list(db.scalars(steps_query))

    next_ids = {step.next_step_id for step in steps if step.next_step_id is not None}
    first_step = next((step for step in steps if step.id not in next_ids), None)

    if first_step:
        approval_request = db.query(ApprovalRequest).filter(ApprovalRequest.item_id == approvalRequest.item_id and ApprovalRequest.step_id == first_step.id).first()
        
        if approval_request:
            raise HTTPException(
                status_code=401, 
                detail="Approbación en curso"
            )
        
        new_approval = ApprovalRequest(
            item_id=approvalRequest.item_id,
            step_id=first_step.id
        )
        db.add(new_approval)
        db.commit()
        
        # Send Email
        signator = db.query(User).filter(User.id == first_step.signator_id).first()
        
        body = build_email_body("Solicitud de contrato", datetime.now, "Alejandro Estrada", "Daniela Turrubiartes", f"{FRONTEND_URL}/contract-request/1")
        send_email("Solicitud de aprobación", signator.email, body)
    else:
        raise HTTPException(
            status_code=404, 
            detail="Hubo un error al crear la petición"
        )
        
    return db.query(Project).where(Project.id == request_exists.project_id).first()

# Get an especific request
@router.get("/{request_id}", response_model=LeaseRequestResponse)
def get_request_by_id(request_id: int, db: Session = Depends(get_db)):
    return db.query(LeaseRequest).where(LeaseRequest.id == request_id).first()

# Get requests by project
@router.get('/project/{project_id}', response_model=list[LeaseRequestResponse])
def get_project_lease(project_id: int, db: Session = Depends(get_db)):
    lease = db.query(LeaseRequest).options(joinedload(LeaseRequest.conditions)).filter_by(project_id=project_id)
    return lease