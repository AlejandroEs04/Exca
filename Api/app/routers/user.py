from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.database.models.user import User
from app.database.schemas.user_schema import UserCreate, UserResponse
from app.database.models.user_title import UserTitle
from app.database.schemas.user_title_schema import UserTitleResponse
from app.utils.security import hash_password

router = APIRouter(prefix="/user", tags=["Users"])

@router.post("/", response_model=UserResponse)
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    # Check if the user already exists
    existing_user = db.query(User).filter(User.email == user.email).first()
    
    if existing_user:
        raise HTTPException(
            status_code=400,
            detail="User with this email already exists."
        )
        
    hashed_password = hash_password(user.password)
    
    new_user = User(
        full_name=user.full_name,
        email=user.email,
        hashed_password=hashed_password,
        rol_id=user.rol_id,
        user_title_id=user.user_title_id,
        area_id=user.area_id
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    return new_user

@router.put("/{user_id}", response_model=UserResponse)
def update_user(user: UserCreate, user_id: int, db: Session = Depends(get_db)):
    user_exists = db.query(User).where(User.id == user_id).first()
    
    if not user_exists:
        raise HTTPException(
            status_code=404, 
            detail="El usuario no fue encontrado"
        )
        
    user_exists.user_title_id = user.user_title_id
    user_exists.rol_id = user.rol_id
    user_exists.area_id = user.area_id
    user_exists.email = user.email
    user_exists.full_name = user.full_name
    
    db.add(user_exists)
    db.commit()
    db.refresh(user_exists)

    return user_exists
    

@router.get("/", response_model=list[UserResponse])
def get_users(db: Session = Depends(get_db)):
    users = db.query(User).all()
    return users

@router.get("/titles", response_model=list[UserTitleResponse])
def get_titles(db: Session = Depends(get_db)):
    return db.query(UserTitle).all()    