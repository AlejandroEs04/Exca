from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.middleware.auth import get_current_user
from app.database.models.case import Case
from app.database.models.case_condition import CaseCondition
from app.database.models.user import User
from app.database.schemas.technical_case_schema import TechnicalCaseResponse, TechnicalCaseCreate
from datetime import datetime

router = APIRouter(prefix="/technical-case", tags=["TechnicalCases"])

@router.get("/", response_model=list[TechnicalCaseResponse])
def get_technical_cases(db: Session = Depends(get_db)):
    return db.query(Case).all()

@router.post(path="/", response_model=TechnicalCaseResponse)
def create_technical_case(technical_case: TechnicalCaseCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    exists_technical_case = db.query(Case).where(Case.project_id == technical_case.project_id).first()
    
    new_technical_case = Case(
        project_id=technical_case.project_id,
        originator_id=current_user.id
    )
    
    if not exists_technical_case:
        db.add(new_technical_case)
        db.commit()
        db.refresh(new_technical_case)
    else:
        new_technical_case = exists_technical_case
        db.query(CaseCondition).filter(CaseCondition.technical_case_id == exists_technical_case.id).delete()
    
    for condition in technical_case.conditions:
        new_condition = CaseCondition(
            technical_case_id=new_technical_case.id,
            condition_id=condition.condition_id,
            value=condition.value, 
            is_active=condition.is_active
        )
        db.add(new_condition)
    
    db.commit()
    db.refresh(new_technical_case)
    return new_technical_case

@router.put(path="/edit/{technical_case_id}", response_model=TechnicalCaseResponse)
def edit_technical_case(technical_case_id: int, technical_case: TechnicalCaseCreate, db: Session = Depends(get_db)):
    current_technical_case = db.query(Case).where(Case.id == technical_case_id).first()
    
    if not current_technical_case:
        raise HTTPException(
            status_code=404, 
            detail="No se encontro la carátula técnica"
        )
        
    db.query(CaseCondition).filter(CaseCondition.technical_case_id == technical_case_id).delete()
    
    for condition in technical_case.conditions:
        new_condition = CaseCondition(
            technical_case_id=technical_case_id,
            condition_id=condition.condition_id,
            value=condition.value, 
            is_active=condition.is_active
        )
        db.add(new_condition)
        
    db.commit()
    db.refresh(current_technical_case)
    return current_technical_case

@router.get("/send/{technical_case_id}", response_model=TechnicalCaseResponse)
def send_technical_case(technical_case_id: int, db: Session = Depends(get_db)):
    current_technical_case = db.query(Case).where(Case.id == technical_case_id).first()
    
    if not current_technical_case:
        raise HTTPException(
            status_code=404, 
            detail="No se encontro la carátula técnica"
        )
        
    current_technical_case.sended_at = datetime.now()
    db.add(current_technical_case)
    db.commit()
    db.refresh(current_technical_case)
    return current_technical_case
    
        
    