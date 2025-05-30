from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from sqlalchemy import text


from app.database.models.land import Land
from app.database.connection import get_db
from app.database.models.property_tax import PropertyTax
from app.database.schemas.property_tax_schema import (
    PropertyTaxCreate,
    PropertyTaxResponse,
    PropertyTaxUpdate,
)

router = APIRouter(prefix="/property-tax", tags=["PropertyTaxes"])

@router.post("/", response_model=PropertyTaxResponse)
def create_property_tax(payload: PropertyTaxCreate, db: Session = Depends(get_db)):
    # Validación previa: evitar duplicado land_id + tax_year
    existing_tax = (
        db.query(PropertyTax)
        .filter(PropertyTax.land_id == payload.land_id)
        .filter(PropertyTax.tax_year == payload.tax_year)
        .first()
    )

    if existing_tax:
        raise HTTPException(
            status_code=400,
            detail="Ya existe un impuesto para ese año en este terreno."
        )
    new_tax = PropertyTax(**payload.model_dump())
    db.add(new_tax)

    try:
        db.commit()
        db.refresh(new_tax)

        # Buscar el último impuesto para ese terreno
        latest_tax = (
            db.query(PropertyTax)
            .filter(PropertyTax.land_id == payload.land_id)
            .order_by(PropertyTax.tax_year.desc())
            .first()
        )

        if latest_tax:
            land = db.query(Land).filter(Land.id == payload.land_id).first()
            if land:
                land.current_cadastral_value = latest_tax.cadastral_value
                land.current_value_per_area = latest_tax.cadastral_value_per_area
                land.current_value_per_built_area = latest_tax.cadastral_value_per_built_area
                land.current_tax_year = latest_tax.tax_year
                db.commit()

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail="Error creating property tax: foreign key violation or invalid data."
        )

    return new_tax



@router.put("/", response_model=PropertyTaxResponse)
def update_property_tax(payload: PropertyTaxUpdate, db: Session = Depends(get_db)):
    # Validación previa: evitar duplicado land_id + tax_year
    existing_tax = (
        db.query(PropertyTax)
        .filter(PropertyTax.id != payload.id)
        .filter(PropertyTax.land_id == payload.land_id)
        .filter(PropertyTax.tax_year == payload.tax_year)
        .first()
    )
    if existing_tax:
        raise HTTPException(
            status_code=400,
            detail="Ya existe un impuesto para ese año en este terreno."
        )
    tax = db.get(PropertyTax, payload.id)
    if not tax:
        raise HTTPException(status_code=404, detail="PropertyTax not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(tax, field, value)
    try:
        db.commit()

        # Buscar el último impuesto para ese terreno
        latest_tax = (
            db.query(PropertyTax)
            .filter(PropertyTax.land_id == payload.land_id)
            .order_by(PropertyTax.tax_year.desc())
            .first()
        )

        if latest_tax:
            land = db.query(Land).filter(Land.id == payload.land_id).first()
            if land:
                land.current_cadastral_value = latest_tax.cadastral_value
                land.current_value_per_area = latest_tax.cadastral_value_per_area
                land.current_value_per_built_area = latest_tax.cadastral_value_per_built_area
                land.current_tax_year = latest_tax.tax_year
                db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating property tax data.")
    db.refresh(tax)
    return tax

@router.get("/", response_model=list[PropertyTaxResponse])
def list_property_taxes(db: Session = Depends(get_db)):
    return db.query(PropertyTax).all()


@router.get("/getPropertyTaxById/{id}", response_model=PropertyTaxResponse)
def get_property_tax_by_id(id: int, db: Session = Depends(get_db)):
    propertyTax = db.get(PropertyTax, id)
    if not propertyTax:
        raise HTTPException(status_code=404, detail="Predial no encontrado")
    return propertyTax
