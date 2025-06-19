from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.database.models.approval_request import ApprovalRequest
from app.database.schemas.approval_request_schema import ApprovalRequestResponse
from app.database.models.approval_flow_step import ApprovalFlowStep
from app.database.models.lease_request import LeaseRequest
from app.database.models.case import Case
from app.database.models.project import Project
from app.database.models.notification_system_recipient import NotificationSystemRecipient
from app.database.models.user import User
from app.middleware.auth import get_current_user
from app.utils.send_approval_email import build_email_body
from app.utils.body_generator import build_reject_approvation, build_finish_approvation, build_send_approbation_request
from app.services.email import send_email
from datetime import datetime
from app.config import FRONTEND_URL

router = APIRouter(prefix="/approval-request", tags=["ApprovalRequests"])

@router.get("/", response_model=list[ApprovalRequestResponse])
def get_requests(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    query = db.query(ApprovalRequest).join(ApprovalRequest.step)
    query = query.filter(ApprovalFlowStep.signator_id == current_user.id)
    return query.all()

@router.get('/response/{request_id}/{response}', status_code=status.HTTP_201_CREATED)
def response_approval_request(request_id: int, response: bool, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    approval_request = db.query(ApprovalRequest).filter(ApprovalRequest.id == request_id).first()
    
    if not approval_request:
        raise HTTPException(
            status_code=404, 
            detail="La solicitud no existe"
        )
        
    if type(approval_request.response) is bool:
        raise HTTPException(
            status_code=401, 
            detail="La petición ya fue respondida"
        )
        
    current_step = db.query(ApprovalFlowStep).filter(ApprovalFlowStep.id == approval_request.flow_step_id).first()
    
    if not current_step:
        raise HTTPException(
            status_code=404, 
            detail="El flujo no fue encontrado"
        )
        
    if current_step.signator_id != current_user.id:
        raise HTTPException(
            status_code=401, 
            detail="No tiene los permisos para firmar esta petición"
        )
        
    approval_request.response = response
    db.commit()
      
    if not response:
        #Rejected
        reject_flow(current_step.flow_id, approval_request.item_id, current_user, db, approval_request.comments)
        return
        
    next_step = db.query(ApprovalFlowStep).filter(
        (ApprovalFlowStep.flow_id == current_step.flow_id) &
        (ApprovalFlowStep.step_order == current_step.step_order + 1)
    ).first()
    
    if not next_step:
        finish_flow(current_step.flow_id, approval_request.item_id, current_user, db)
        return
    else:
        new_request = ApprovalRequest(
            item_id=approval_request.item_id,
            flow_step_id=next_step.id, 
            requested_by=current_user.id
        )
        db.add(new_request)
        db.commit()
        
    signator = db.query(User).filter(User.id == next_step.signator_id).first()
    
    if not signator:
        raise HTTPException(
            status_code=404, 
            detail="No se encontro el aprovador"
        )
    
    body = build_email_body("Solicitud de contrato", datetime.now(), "Alejandro Estrada", "Daniela Turrubiartes", f"{FRONTEND_URL}/contract-request/1")
    send_email("Solicitud de aprobación", signator.email, body)


def finish_flow(flow_id: int, item_id: str, user: User, db: Session):
    if flow_id == 1:
        lease_request = db.query(LeaseRequest).filter(LeaseRequest.id == item_id).first()
        
        if not lease_request:
            raise HTTPException(
                status_code=404, 
                detail="La solicitud de contrato no existe"
            )
        
        project = db.query(Project).where(Project.id == lease_request.project_id).first()
        
        if not project:
            raise HTTPException(
                status_code=404, 
                detail="No se encontro el proyecto"
            )
        
        project.stage_id = 3
        lease_request.status_id = 3
        db.add(project)
        db.add(lease_request)
        db.commit()
    elif flow_id == 2:
        case_exists = db.query(Case).where(Case.id == item_id).first()
        if not case_exists:
            raise HTTPException(status_code=404, detail="No se encontro la caratula")
        
        case_exists.status_id = 3
        db.add(case_exists)
        
        project = db.query(Project).where(Project.id == case_exists.project_id).first()
        if not project:
            raise HTTPException(status_code=404, detail="No se encontro el proyecto")
        
        project.stage_id = 4
        db.add(project)
        
        db.commit()
        
        recipients = db.query(NotificationSystemRecipient).where(NotificationSystemRecipient.notification_system_id == 3).all()
        for recipient in recipients:
            user = db.query(User).where(User.id == recipient.user_id).first()
            if not user:
                raise HTTPException(
                    status_code=404, 
                    detail="El usuario recipiente no fue encontrado"
                )
            body = build_email_body("Carátula técnica terminada", datetime.now, user.full_name, user.full_name, "")
            send_email("Caratula técnica finalizada", user.email, body)
            
def reject_flow(flow_id: int, item_id: str, user: User, db: Session, reason: str | None = "No hay razón"):
    document_name = ""
    url_address = ""
    to_address = ""
    
    if flow_id == 1:
        document_name = "Solicitud de contrato"
        lease_request = db.query(LeaseRequest).filter(LeaseRequest.id == item_id).first()
        
        if not lease_request:
            raise HTTPException(
                status_code=404, 
                detail="La solicitud de contrato no existe"
            )
        
        lease_request.status_id = 5
        db.commit()
        
        originator = db.query(User).where(User.id == lease_request.created_by).first()
        
        if not originator:
            raise HTTPException(status_code=404, detail="Usuario no encontrado")
        
        to_address = originator.email
    elif flow_id == 2:
        case_exists = db.query(Case).where(Case.id == item_id).first()
        
        if not case_exists:
            raise HTTPException(status_code=404, detail="No se encontro la caratula")
        
        if case_exists.case_type_id == 1:
            document_name = "Caratula Técnica"
        else:
            document_name = "Caratula Legal"
        
        case_exists.status_id = 5
        db.add(case_exists)
        db.commit()
        
        originator = db.query(User).where(User.id == case_exists.originator_id).first()
        
        if not originator:
            raise HTTPException(status_code=404, detail="Usuario no encontrado")
        
        to_address = originator.email
    
    body = build_reject_approvation(document_name, user.full_name, reason, item_id, url_address)
    send_email("Solicitud rechazada", to_address, body)
        