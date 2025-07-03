from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.middleware.auth import get_current_user
from app.database.models.case import Case
from app.database.schemas.case_schema import CaseCreate, CaseResponse
from app.database.models.user import User
from app.database.models.case_condition import CaseCondition
from app.database.models.notification_system_recipient import NotificationSystemRecipient
from app.database.models.approval_flow_step import ApprovalFlowStep
from app.database.models.approval_request import ApprovalRequest
from app.services.email import send_email
from app.utils.send_approval_email import build_email_body
from datetime import datetime

router = APIRouter(prefix="/case", tags=["Cases"])

@router.post("/", response_model=CaseResponse)
def create_case(case: CaseCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    case_exists = db.query(Case).where(Case.project_id == case.project_id, Case.case_type_id == case.case_type_id).first()
    
    if case_exists:
        raise HTTPException(
            status_code=403,
            detail="Ya existe una cáratula para este proyecto"
        )
    
    new_case = Case(
        project_id=case.project_id,
        originator_id=current_user.id, 
        case_type_id=case.case_type_id,
        status_id=1
    )
    db.add(new_case)
    db.commit()
    db.refresh(new_case)
    
    for condition in case.conditions:
        new_condition = CaseCondition(
            case_id=new_case.id, 
            condition_id=condition.condition_id, 
            text_value=condition.text_value,
            number_value=condition.number_value,
            date_value=condition.date_value,
            boolean_value=condition.boolean_value,
            option_id=condition.option_id,
            is_active=condition.is_active
        )
        db.add(new_condition)
        
    db.commit()
    db.refresh(new_case)
    return new_case

@router.get("/", response_model=list[CaseResponse])
def get_cases(db: Session = Depends(get_db)):
    return db.query(Case).all()

@router.put("/edit/{case_id}", response_model=CaseResponse)
def update_case(case_id: int, case: CaseCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    case_exists = db.query(Case).where(Case.id == case_id).first()
    
    if not case_exists:
        raise HTTPException(
            status_code=404, 
            detail="No se encontro el case"
        )
        
    existing_conditions = db.query(CaseCondition)\
        .filter(CaseCondition.case_id == case_exists.id)\
        .all()
        
    existing_conditions_map = {cond.condition_id: cond for cond in existing_conditions}
    incoming_conditions_map = {cond.condition_id: cond for cond in case.conditions}
    
    for condition_id, condition_data in incoming_conditions_map.items():
        if condition_id in existing_conditions_map:
            # Update existing condition
            existing_condition = existing_conditions_map[condition_id]
            existing_condition.is_active = condition_data.is_active
            existing_condition.text_value = condition_data.text_value
            existing_condition.number_value = condition_data.number_value
            existing_condition.date_value = condition_data.date_value
            existing_condition.boolean_value = condition_data.boolean_value
            if condition_data.option_id is not None:
                existing_condition.option_id = condition_data.option_id
        else:
            # Create new condition
            new_condition = CaseCondition(
                case_id=case_exists.id,
                condition_id = condition_data.condition_id,
                is_active = condition_data.is_active,
                text_value = condition_data.text_value,
                number_value = condition_data.number_value,
                date_value = condition_data.date_value,
                boolean_value = condition_data.boolean_value,
                option_id = condition_data.option_id
            )
            db.add(new_condition)
            
    for condition_id, existing_condition in existing_conditions_map.items():
        if condition_id not in incoming_conditions_map:
            db.delete(existing_condition)

    db.commit()
    db.refresh(case_exists)
    return case_exists

@router.post("/send/{case_id}", status_code=status.HTTP_200_OK, response_model=CaseResponse)
def send_case(case_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    exists_case = db.query(Case).where(Case.id == case_id).first()
    
    if not exists_case:
        raise HTTPException(
            status_code=404, 
            detail="No se encontro la cáratula"
        )
        
    print(exists_case.id)
        
    if exists_case.case_type_id == 2:
        exists_technical_case = db.query(Case).where(Case.project_id == exists_case.project_id, Case.case_type_id == 1).first()
        
        if not exists_technical_case:
            raise HTTPException(status_code=401, detail="Es necesario completar la caratula técnica antes de mandar la caratula legal")
        
        if exists_technical_case.status_id != 5:
            raise HTTPException(status_code=401, detail="Es necesario que la catula técnica sea enviada antes de enviar la caratula legal")
        
    exists_case.status_id = 2
    exists_case.sended_at = datetime.now()
    
    if exists_case.case_type_id == 1:
        recipients = db.query(NotificationSystemRecipient).where(NotificationSystemRecipient.notification_system_id == 3).all()
        for recipient in recipients:
            user = db.query(User).where(User.id == recipient.user_id).first()
            if not user:
                raise HTTPException(
                    status_code=404, 
                    detail="El usuario recipiente no fue encontrado"
                )
            body = build_email_body("Carátula técnica terminada", datetime.now, current_user.full_name, user.full_name, "")
            send_email("Caratula técnica finalizada", user.email, body)
            
        exists_case.status_id = 5
    elif exists_case.case_type_id == 2:
        first_step = db.query(ApprovalFlowStep).where(ApprovalFlowStep.flow_id == 2, ApprovalFlowStep.step_order == 1).first()
        
        if not first_step:
            raise HTTPException(status_code=404, detail="No se pudo encontrar el flujo de aprobación")
        
        approval_request = db.query(ApprovalRequest).where(ApprovalRequest.item_id == case_id, ApprovalRequest.flow_step_id == first_step.id).first()
        
        if approval_request:
            raise HTTPException(status_code=401, detail="Aprobación en curso")
        
        new_approval = ApprovalRequest(
            item_id=case_id, 
            flow_step_id=first_step.id, 
            requested_by=current_user.id
        )
        db.add(new_approval)
    db.add(exists_case)
    db.commit()
        
    return exists_case