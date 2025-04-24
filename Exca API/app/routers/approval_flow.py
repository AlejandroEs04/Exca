from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal
from app.database.models.approval_flow import ApprovalFlow
from app.database.models.approval_step import ApprovalStep
from app.database.schemas.approval_flow_schema import ApprovalFlowResponse,ApprovalFlowCreate

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
def create_flow(flow_id: int, flow: ApprovalFlowCreate, db: Session = Depends(get_db)):
    flow_update = db.get(ApprovalFlow, flow_id)
    if not flow:
        raise HTTPException(status_code=404, detail="Flow not found")
    
    flow_update.name = flow.name
    
    db.query(ApprovalStep).filter(ApprovalStep.flow_id == flow_id).delete()
    
    new_array = sorted(flow.steps, key=lambda x: x.order, reverse=True)
    next_id = None
    for step in new_array:
        new_step = ApprovalStep(
            next_step_id=next_id,
            flow_id=flow_id,
            signator_id=step.signator_id
        )
        db.add(new_step)
        db.commit()
        db.refresh(new_step)
        next_id = new_step.id
        
    db.refresh(flow_update)
    return flow_update