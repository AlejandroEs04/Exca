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
def update_flow(flow_id: int, flow: ApprovalFlowCreate, db: Session = Depends(get_db)):
    flow_update = db.get(ApprovalFlow, flow_id)
    if not flow_update:
        raise HTTPException(status_code=404, detail="Flow not found")

    flow_update.name = flow.name

    # Obtener pasos actuales del flujo
    existing_steps = db.query(ApprovalStep).filter(ApprovalStep.flow_id == flow_id).all()
    existing_steps_by_id = {step.id: step for step in existing_steps}

    # Lista temporal para los nuevos pasos y su orden
    new_steps_ordered = sorted(flow.steps, key=lambda x: x.order)
    id_map = {}  # Mapeo temporal para reconstruir las relaciones

    # 1. Crear o actualizar pasos
    for i, step_data in enumerate(new_steps_ordered):
        existing = next((s for s in existing_steps if s.signator_id == step_data.signator_id), None)
        if existing:
            # Actualizar el paso
            existing.order = step_data.order
            existing.signator_id = step_data.signator_id
            db.add(existing)
            id_map[i] = existing.id
        else:
            # Crear nuevo paso
            new_step = ApprovalStep(
                flow_id=flow_id,
                signator_id=step_data.signator_id,
                order=step_data.order
            )
            db.add(new_step)
            db.commit()
            db.refresh(new_step)
            id_map[i] = new_step.id

    db.commit()

    # 2. Reasignar next_step_id según orden
    for i in range(len(new_steps_ordered)):
        step_id = id_map[i]
        next_step_id = id_map[i + 1] if i + 1 < len(new_steps_ordered) else None
        step = db.get(ApprovalStep, step_id)
        step.next_step_id = next_step_id
        db.add(step)

    # 3. Eliminar pasos que ya no estén en el flujo actualizado
    remaining_signator_ids = [step.signator_id for step in new_steps_ordered]
    for step in existing_steps:
        if step.signator_id not in remaining_signator_ids:
            db.delete(step)

    db.commit()
    db.refresh(flow_update)
    return flow_update
