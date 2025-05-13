from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal
from app.database.models.approval_flow import ApprovalFlow
from Api.app.database.models.approval_flow_step import ApprovalStep
from app.database.models.approval_request import ApprovalRequest
from app.database.models.user import User
from app.database.schemas.approval_flow_schema import ApprovalFlowResponse,ApprovalFlowCreate
from app.config import FRONTEND_URL
from app.services.email import send_email
from app.utils.send_approval_email import build_email_body
from datetime import datetime

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

@router.post("/", response_model=ApprovalFlowResponse)
def create_flow(flow: ApprovalFlowCreate, db: Session = Depends(get_db)):
    new_flow = ApprovalFlow(**flow.model_dump())
    db.add(new_flow)
    db.commit()
    db.refresh(new_flow)
    
    for step in flow.steps:
        new_step = ApprovalStep(
            next_step_id=step.next_step_id,
            flow_id=new_flow.id,
            signator_id=step.signator_id
        )
        db.add(new_step)
        
    db.commit()
    db.refresh(new_flow)
    return new_flow

@router.put("/{flow_id}", response_model=ApprovalFlowResponse)
def update_flow(flow_id: int, flow: ApprovalFlowCreate, db: Session = Depends(get_db)):
    flow_update = db.get(ApprovalFlow, flow_id)
    if not flow_update:
        raise HTTPException(status_code=404, detail="Flow not found")

    flow_update.name = flow.name

    existing_steps = db.query(ApprovalStep).filter(ApprovalStep.flow_id == flow_id).all()
    existing_steps_by_id = {step.id: step for step in existing_steps}

    new_steps_ordered = sorted(flow.steps, key=lambda x: x.order)
    id_map = {} 

    for i, step_data in enumerate(new_steps_ordered):
        existing = next((s for s in existing_steps if s.signator_id == step_data.signator_id), None)
        if existing:
            existing.order = step_data.order
            existing.signator_id = step_data.signator_id
            db.add(existing)
            id_map[i] = existing.id
        else:
            new_step = ApprovalStep(
                flow_id=flow_id,
                signator_id=step_data.signator_id
            )
            db.add(new_step)
            db.commit()
            db.refresh(new_step)
            id_map[i] = new_step.id

    db.commit()

    for i in range(len(new_steps_ordered)):
        step_id = id_map[i]
        next_step_id = id_map[i + 1] if i + 1 < len(new_steps_ordered) else None
        step = db.get(ApprovalStep, step_id)
        step.next_step_id = next_step_id
        db.add(step)
        
    db.commit()

    remaining_signator_ids = [step.signator_id for step in new_steps_ordered]
    for step in existing_steps:
        if step.signator_id not in remaining_signator_ids:
            db.delete(step)
            
        requests = db.query(ApprovalRequest).where(ApprovalRequest.step_id == step.id).all()
        for request in requests:
            if request.response is None:
                steps_query = db.query(ApprovalStep).where(ApprovalStep.flow_id == step.flow_id)
                steps = list(db.scalars(steps_query))

                next_ids = {step.next_step_id for step in steps if step.next_step_id is not None}
                first_step = next((step for step in steps if step.id not in next_ids), None)

                if first_step:
                    approval_request = db.query(ApprovalRequest).filter(ApprovalRequest.item_id == request.item_id and ApprovalRequest.step_id == first_step.id).first()
                    
                    if approval_request:
                        db.delete(approval_request)
                    
                    new_approval = ApprovalRequest(
                        item_id=request.item_id,
                        step_id=first_step.id
                    )
                    db.add(new_approval)
                    db.commit()
                    
                    # Send Email
                    signator = db.query(User).filter(User.id == first_step.signator_id).first()
                    
                    body = build_email_body("Solicitud de contrato", datetime.today(), "Alejandro Estrada", "Daniela Turrubiartes", f"{FRONTEND_URL}/contract-request/1")
                    send_email("Solicitud de aprobación", signator.email, body)

    db.commit()
    db.refresh(flow_update)
    return flow_update
