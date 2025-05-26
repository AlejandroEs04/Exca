from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.property_tax_status import PropertyTaxStatus
from app.database.schemas.property_tax_status_schema import (
    PropertyTaxStatusCreate,
    PropertyTaxStatusResponse,
    PropertyTaxStatusUpdate,
)

router = APIRouter(prefix="/property-tax-status", tags=["PropertyTaxStatus"])

@router.post("/", response_model=PropertyTaxStatusResponse)
def create_property_tax_status(payload: PropertyTaxStatusCreate, db: Session = Depends(get_db)):
    
    data = payload.model_dump()
    new_status = PropertyTaxStatus(**data)
    db.add(new_status)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating property tax status: invalid data.")
    db.refresh(new_status)
    return new_status

@router.put("/", response_model=PropertyTaxStatusResponse)
def update_property_tax_status(payload: PropertyTaxStatusUpdate, db: Session = Depends(get_db)):
    
    status_obj = db.get(PropertyTaxStatus, payload.id)
    if not status_obj:
        raise HTTPException(status_code=404, detail="PropertyTaxStatus not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(status_obj, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating property tax status.")
    db.refresh(status_obj)
    return status_obj

@router.get("/", response_model=list[PropertyTaxStatusResponse])
def list_property_tax_statuses(db: Session = Depends(get_db)):
    return db.query(PropertyTaxStatus).all()
