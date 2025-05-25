from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError

from app.database.connection import get_db
from app.database.models.land_category import LandCategory
from app.database.schemas.land_category_schema import (
    LandCategoryCreate,
    LandCategoryResponse,
    LandCategoryUpdate,
)

router = APIRouter(prefix="/land-categories", tags=["LandCategories"])

@router.post("/", response_model=LandCategoryResponse)
def create_land_category(payload: LandCategoryCreate, db: Session = Depends(get_db)):
    new_cat = LandCategory(**payload.model_dump())
    db.add(new_cat)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error creating land category: invalid data.")
    db.refresh(new_cat)
    return new_cat

@router.put("/", response_model=LandCategoryResponse)
def update_land_category(payload: LandCategoryUpdate, db: Session = Depends(get_db)):
    cat = db.get(LandCategory, payload.id)
    if not cat:
        raise HTTPException(status_code=404, detail="LandCategory not found")
    for field, value in payload.model_dump(exclude_unset=True).items():
        setattr(cat, field, value)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(status_code=400, detail="Error updating land category.")
    db.refresh(cat)
    return cat

@router.get("/", response_model=list[LandCategoryResponse])
def list_land_categories(db: Session = Depends(get_db)):
    return db.query(LandCategory).all()
