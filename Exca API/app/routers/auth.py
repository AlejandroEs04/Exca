from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from app.utils.auth import create_access_token
from app.database.connection import SessionLocal
from app.database.models.user import User
from app.database.schemas.user_schema import LoginData, Token
from app.database.schemas.user_schema import UserResponse
from app.middleware.auth import get_current_user

router = APIRouter(prefix="/auth", tags=["Auth"])
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

@router.post("/login", response_model=Token)
def login(data: LoginData, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == data.email).first()
    if not user or not verify_password(data.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    token_data = {"sub": str(user.id)}
    token = create_access_token(data=token_data)
    return {"access_token": token, "token_type": "bearer"}
        
@router.get('/', response_model=UserResponse)
def get_auth(current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    return current_user