from fastapi import APIRouter, Depends, HTTPException, status
from app.database.connection import get_db
from app.middleware.auth import get_current_user
from sqlalchemy.orm import Session
from app.database.models.task_message import TaskMessage
from app.database.models.task import Task 
from app.database.models.user import User
from app.database.schemas.task_message_schema import TaskMessageCreate, TaskMessageResponse
from app.utils.body_generator import build_notify_task_message
from app.services.email import send_email

router = APIRouter(prefix="/task-message", tags=["TagsMessages"])

@router.post(path="/", response_model=TaskMessageResponse)
def create_task_message(message: TaskMessageCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    exists_task = db.query(Task).where(Task.id == message.task_id).first()
    if not exists_task:
        raise HTTPException(status_code=404, detail="No se encontro la tarea")
    
    new_message = TaskMessage(
        message=message.message, 
        originator_id=current_user.id, 
        task_id=message.task_id
    )
    db.add(new_message)
    db.commit()
    db.refresh(new_message)
    
    user_responsible = db.query(User).where(User.id == exists_task.responsible_id).first()
    if not user_responsible:
        raise HTTPException(status_code=404, detail="No se encontro el usuario responsable")
    
    body = build_notify_task_message(exists_task.id, message.message, current_user.full_name)
    send_email("Tiene un mensaje nuevo", user_responsible.email, body)
    return new_message