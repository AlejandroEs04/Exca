from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy import select
from sqlalchemy.orm import Session, joinedload
from app.database.connection import get_db
from app.middleware.auth import get_current_user
from app.database.models.lease_request import LeaseRequest
from app.database.schemas.lease_request_schema import LeaseRequestCreate, LeaseRequestResponse
from app.database.models.lease_request_condition import LeaseRequestCondition
from app.database.schemas.approval_request_schema import ApprovalRequestCreate
from app.database.models.project import Project
from app.database.schemas.project_schema import ProjectResponse
from app.database.models.approval_request import ApprovalRequest
from app.database.models.approval_flow_step import ApprovalFlowStep
from app.database.models.user import User
from app.utils.send_approval_email import build_email_body
from app.services.email import send_email
from datetime import datetime
from app.config import FRONTEND_URL

router = APIRouter(prefix='/lease-request', tags=["LeaseRequests"])

@router.post("/", response_model=LeaseRequestResponse)
def create_request(request: LeaseRequestCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    request_query = select(LeaseRequest).where(LeaseRequest.project_id == request.project_id)
    request_exists = db.scalars(request_query).first()

    if request_exists:
        raise HTTPException(status_code=409, detail="A lease request for this project already exists.")
    
    new_request = LeaseRequest(
        project_id=request.project_id,
        guarantee_id=request.guarantee_id,
        guarantee_type_id=request.guarantee_type_id,
        status_id=1,
        owner_id=request.owner_id,
        commission_agreement=request.commission_agreement,
        assignment_income=request.assignment_income,
        property_file=request.property_file,
        created_by=current_user.id
    )
    db.add(new_request)
    db.commit()
    db.refresh(new_request)

    for condition_data in request.conditions:
        new_condition = LeaseRequestCondition(
            lease_request_id = new_request.id,
            condition_id = condition_data.condition_id,
            is_active = condition_data.is_active,
            text_value = condition_data.text_value,
            number_value = condition_data.number_value,
            date_value = condition_data.date_value,
            boolean_value = condition_data.boolean_value,
            option_id = condition_data.option_id
        )
        db.add(new_condition)


    db.commit()
    return new_request

@router.put("/{id}", response_model=LeaseRequestResponse)
def update_request(
    id: int,
    request: LeaseRequestCreate, 
    db: Session = Depends(get_db)
):
    # Obtener la solicitud existente
    lease_request = db.get(LeaseRequest, id)
    if not lease_request:
        raise HTTPException(status_code=404, detail="Lease Request not found")

    # Actualizar datos del LeaseRequest
    lease_request.guarantee_id = request.guarantee_id
    lease_request.guarantee_type_id = request.guarantee_type_id
    lease_request.owner_id = request.owner_id
    lease_request.commission_agreement = request.commission_agreement
    lease_request.assignment_income = request.assignment_income
    lease_request.property_file = request.property_file

    db.commit()

    # --- Actualización de condiciones ---
    # Obtener las condiciones actuales en DB
    existing_conditions = db.query(LeaseRequestCondition)\
        .filter(LeaseRequestCondition.lease_request_id == lease_request.id)\
        .all()
    
    # Crear diccionarios para búsqueda rápida
    existing_conditions_map = {cond.condition_id: cond for cond in existing_conditions}
    incoming_conditions_map = {cond.condition_id: cond for cond in request.conditions}

    # Actualizar o crear condiciones
    for condition_id, condition_data in incoming_conditions_map.items():
        if condition_id in existing_conditions_map:
            # ➔ Actualizar condición existente
            existing_condition = existing_conditions_map[condition_id]
            existing_condition.is_active = condition_data.is_active
            existing_condition.text_value = condition_data.text_value
            existing_condition.number_value = condition_data.number_value
            existing_condition.date_value = condition_data.date_value
            existing_condition.boolean_value = condition_data.boolean_value
            existing_condition.option_id = condition_data.option_id
        else:
            # ➔ Crear nueva condición
            new_condition = LeaseRequestCondition(
                lease_request_id = lease_request.id,
                condition_id = condition_data.condition_id,
                is_active = condition_data.is_active,
                text_value = condition_data.text_value,
                number_value = condition_data.number_value,
                date_value = condition_data.date_value,
                boolean_value = condition_data.boolean_value,
                option_id = condition_data.option_id
            )
            db.add(new_condition)

    # Eliminar condiciones que ya no vienen en el request
    for condition_id, existing_condition in existing_conditions_map.items():
        if condition_id not in incoming_conditions_map:
            db.delete(existing_condition)

    db.commit()
    db.refresh(lease_request)

    return lease_request


@router.get("/", response_model=list[LeaseRequestResponse])
def get_leases(db: Session = Depends(get_db)):
    return db.query(LeaseRequest).options(joinedload(LeaseRequest.conditions).joinedload(LeaseRequestCondition.condition)).all()

@router.post("/send-to-approval", status_code=status.HTTP_201_CREATED, response_model=ProjectResponse)
def send_approval(approvalRequest: ApprovalRequestCreate, db: Session = Depends(get_db)):
    request_exists = db.query(LeaseRequest).where(LeaseRequest.project_id == approvalRequest.item_id).first()
    
    if not request_exists:
        raise HTTPException(
            status_code=404, 
            detail="Solicitud de contrato no encontrado"
        ) 
        
    request_exists.status_id = 2
    
    project_exists = db.query(Project).where(Project.id == request_exists.project_id).first()
    
    if not project_exists:
        raise HTTPException(
            status_code=404, 
            detail="Proyecto no encontrado"
        ) 
        
    project_exists.status_id = 2
    
    steps_query = db.query(ApprovalFlowStep).where(ApprovalFlowStep.flow_id == approvalRequest.flow_id)
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
        
    db.commit()
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