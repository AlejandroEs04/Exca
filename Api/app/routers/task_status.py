from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.database.models.task_status import TaskStatus
from app.database.schemas.task_status_schema import TaskStatusResponse

router = APIRouter(prefix="/task-status", tags=["TaskStatus"])

@router.get(path="/", response_model=list[TaskStatusResponse])
def get_task_status(db: Session = Depends(get_db)):
    return db.query(TaskStatus).all()