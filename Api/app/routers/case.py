from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.middleware.auth import get_current_user
from app.database.models.case import Case
from app.database.schemas.case_schema import CaseCreate, CaseResponse
from app.database.models.user import User
from app.database.models.case_condition import CaseCondition

router = APIRouter(prefix="/case", tags=["Cases"])

@router.post("/", response_model=CaseResponse)
def create_case(case: CaseCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    new_case = Case(
        project_id=case.project_id,
        originator_id=current_user.id, 
        case_type_id=case.case_type_id
    )
    db.add(new_case)
    db.commit()
    db.refresh(new_case)
    
    for condition in case.conditions:
        new_condition = CaseCondition(
            case_id=condition.case_id, 
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