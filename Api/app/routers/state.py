from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.state import State
from app.database.schemas.state_schema import (
    StateResponse,
    # Assuming you have StateCreate and StateUpdate schemas
    StateCreate,
    StateUpdate,
)

router = APIRouter(prefix="/states", tags=["States"])

@router.post("/", response_model=StateResponse)
def create_state(payload: StateCreate, db: Session = Depends(get_db)):
    data = payload.model_dump()
    new_state = State(**data)
    db.add(new_state)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating state: invalid data.")
    db.refresh(new_state)
    return new_state

@router.put("/", response_model=StateResponse)
def update_state(payload: StateUpdate, db: Session = Depends(get_db)):
    state_obj = db.get(State, payload.id)
    if not state_obj:
        raise HTTPException(status_code=404, detail="State not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(state_obj, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating state.")
    db.refresh(state_obj)
    return state_obj

@router.get("/", response_model=list[StateResponse])
def list_states(db: Session = Depends(get_db)):
    return db.query(State).all()
