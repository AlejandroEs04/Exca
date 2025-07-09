from fastapi import APIRouter, Depends, HTTPException, status
from app.database.connection import get_db
from sqlalchemy.orm import Session
from app.middleware.auth import get_current_user
from app.database.models.task import Task
from app.database.models.task_message import TaskMessage
from app.database.models.user import User
from app.database.schemas.task_schema import TaskCreate, TaskResponse, TaskUpdate
from app.database.schemas.task_message_schema import TaskMessageCreate, TaskMessageResponse

router = APIRouter(prefix="/task", tags=["Tasks"])

@router.post(path="/", response_model=TaskResponse)
def create_task(task: TaskCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    new_task = Task(
        title=task.title,
        description=task.description, 
        responsible_id=task.responsible_id, 
        project_id=task.project_id, 
        due_date=task.due_date, 
        task_id=task.task_id, 
        originator_id=current_user.id
    )
    db.add(new_task)
    db.commit()
    db.refresh(new_task)
    return new_task

@router.get("/", response_model=list[TaskResponse])
def get_task(db: Session = Depends(get_db)):
    return db.query(Task).all()

@router.put(path="/{task_id}", response_model=TaskResponse)
def update_task(task: TaskUpdate, task_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    task_exists = db.query(Task).where(Task.id == task_id).first()
    
    if not task_exists: 
        raise HTTPException(status_code=404, detail="La tarea no fue encontrada")
    
    if task_exists.originator_id != current_user.id:
        raise HTTPException(status_code=401, detail="No tiene los permisos para actualizar la tarea")
    
    task_exists.title = task.title
    task_exists.description = task.description
    task_exists.due_date = task.due_date
    task_exists.responsible_id = task.responsible_id
    task_exists.status_id = task.status_id
    
    db.add(task_exists)
    db.commit()
    db.refresh(task_exists)
    return task_exists
    
@router.delete(path="/{task_id}", status_code=status.HTTP_200_OK)
def delete_task(task_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    task_exists = db.query(Task).where(Task.id == task_id).first()
    
    if not task_exists: 
        raise HTTPException(status_code=404, detail="La tarea no fue encontrada")
    
    if task_exists.originator_id != current_user.id:
        raise HTTPException(status_code=401, detail="No tiene los permisos para actualizar la tarea")
    
    db.delete(task_exists)
    db.commit()
    
@router.get("/{task_id}/finish", response_model=TaskResponse)
def finish_task(task_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    task_exists = db.query(Task).where(Task.id == task_id).first()
    
    if not task_exists:
        raise HTTPException(status_code=404, detail="No se encontro la tarea")
    
    if task_exists.originator_id != current_user.id:
        raise HTTPException(status_code=401, detail="No tiene los permisos para actualizar la tarea")
    
    task_exists.status_id = 5
    db.add(task_exists)
    db.commit()
    db.refresh(task_exists)
    return task_exists