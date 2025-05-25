from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.property_tax import PropertyTax
from app.database.schemas.property_tax_schema import (
    PropertyTaxCreate,
    PropertyTaxResponse,
    PropertyTaxUpdate,
)

router = APIRouter(prefix="/property-taxes", tags=["PropertyTaxes"])

@router.post("/", response_model=PropertyTaxResponse)
def create_property_tax(payload: PropertyTaxCreate, db: Session = Depends(get_db)):
    new_tax = PropertyTax(**payload.model_dump())
    db.add(new_tax)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating property tax: foreign key violation or invalid data.")
    db.refresh(new_tax)
    return new_tax

@router.put("/", response_model=PropertyTaxResponse)
def update_property_tax(payload: PropertyTaxUpdate, db: Session = Depends(get_db)):
    tax = db.get(PropertyTax, payload.id)
    if not tax:
        raise HTTPException(status_code=404, detail="PropertyTax not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(tax, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating property tax data.")
    db.refresh(tax)
    return tax

@router.get("/", response_model=list[PropertyTaxResponse])
def list_property_taxes(db: Session = Depends(get_db)):
    return db.query(PropertyTax).all()
