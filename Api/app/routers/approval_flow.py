from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal
from app.database.models.approval_flow import ApprovalFlow
from app.database.models.approval_flow_step import ApprovalFlowStep
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
    
    order_position = len(flow.steps)
    
    for step in flow.steps:
        new_step = ApprovalFlowStep(
            flow_id=new_flow.id,
            step_order=order_position,
            signator_role_id=step.signator_role_id, 
            signator_area_id=step.signator_area_id, 
            signator_id=step.signator_id
        )
        db.add(new_step)
        
        order_position = order_position - 1
        
    db.commit()
    db.refresh(new_flow)
    return new_flow

@router.put("/{flow_id}", response_model=ApprovalFlowResponse)
def update_flow(flow_id: int, flow: ApprovalFlowCreate, db: Session = Depends(get_db)):
    flow_update = db.get(ApprovalFlow, flow_id)
    if not flow_update:
        raise HTTPException(status_code=404, detail="Flow not found")

    flow_update.name = flow.name
    db.add(flow_update)

    existing_steps = db.query(ApprovalFlowStep).filter(ApprovalFlowStep.flow_id == flow_id).all()
    existing_steps_by_id = {step.id: step for step in existing_steps}

    new_steps_ordered = sorted(flow.steps, key=lambda x: x.step_order)
    new_signator_ids = set()
    updated_step_ids = set()

    for step_data in new_steps_ordered:
        existing = next((s for s in existing_steps if s.signator_id == step_data.signator_id), None)
        new_signator_ids.add(step_data.signator_id)

        if existing:
            existing.step_order = step_data.step_order
            if step_data.signator_role_id is not None:
                existing.signator_role_id = step_data.signator_role_id
            if step_data.signator_area_id is not None:
                existing.signator_area_id = step_data.signator_area_id
            existing.is_required = step_data.is_required
            db.add(existing)
            updated_step_ids.add(existing.id)
        else:
            new_step = ApprovalFlowStep(
                flow_id=flow_id,
                step_order=step_data.step_order,
                signator_id=step_data.signator_id,
                signator_role_id=step_data.signator_role_id,
                signator_area_id=step_data.signator_area_id,
                is_required=step_data.is_required
            )
            db.add(new_step)
            db.commit()
            db.refresh(new_step)
            updated_step_ids.add(new_step.id)

    db.commit()

    for step in existing_steps:
        if step.id not in updated_step_ids:
            requests = db.query(ApprovalRequest).filter(ApprovalRequest.flow_step_id == step.id).all()
            for request in requests:
                if request.response is None:
                    steps_query = db.query(ApprovalFlowStep).filter(ApprovalFlowStep.flow_id == step.flow_id)
                    steps = steps_query.order_by(ApprovalFlowStep.step_order).all()

                    if steps:
                        first_step = steps[0]
                        if first_step and first_step.id is not None:
                            existing_req = db.query(ApprovalRequest).filter(
                                ApprovalRequest.item_id == request.item_id,
                                ApprovalRequest.flow_step_id == first_step.id
                            ).first()
                            
                            if existing_req:
                                db.delete(existing_req)
                                db.commit()

                            new_approval = ApprovalRequest(
                                item_id=request.item_id,
                                flow_step_id=first_step.id
                            )

                            db.add(new_approval)

                        signator = db.query(User).filter(User.id == first_step.signator_id).first()
                        body = build_email_body("Solicitud de contrato", datetime.today(), "Alejandro Estrada", "Daniela Turrubiartes", f"{FRONTEND_URL}/contract-request/1")
                        if signator and signator.email:
                            send_email("Solicitud de aprobación", signator.email, body)
            db.delete(step)

    db.commit()
    db.refresh(flow_update)
    return flow_update

