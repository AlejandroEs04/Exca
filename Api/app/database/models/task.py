from sqlalchemy import ForeignKey, func
from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base
from datetime import datetime

class Task(Base):
    __tablename__ = "task"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    description: Mapped[str] = mapped_column(nullable=False)
    originator_id: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    responsible_id: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    project_id: Mapped[int] = mapped_column(ForeignKey("project.id"), nullable=False)
    status_id: Mapped[int] = mapped_column(ForeignKey("task_status.id"), nullable=False)
    due_date: Mapped[datetime] = mapped_column(nullable=False)
    task_id: Mapped[int] = mapped_column(ForeignKey("task.id"), nullable=True)
    created_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now(), onupdate=func.now())
    
    status = relationship("TaskStatus", back_populates="tasks")
    originator = relationship("User", back_populates="tasks_created", foreign_keys=[originator_id])
    responsible = relationship("User", back_populates="tasks_assigned", foreign_keys=[responsible_id])
    project = relationship("Project", back_populates="tasks")
    parent = relationship("Task", remote_side=[id], backref="subtasks")
    messages = relationship("TaskMessage", back_populates="task")