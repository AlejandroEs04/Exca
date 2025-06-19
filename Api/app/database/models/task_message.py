from sqlalchemy import ForeignKey, func
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.database.connection import Base
from datetime import datetime

class TaskMessage(Base):
    __tablename__ = "task_message"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    message: Mapped[str] = mapped_column(nullable=False)
    originator_id: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    task_id: Mapped[int] = mapped_column(ForeignKey("task.id"), nullable=False)
    submitted_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now())
    
    originator = relationship("User", back_populates="task_messages")
    task = relationship("Task", back_populates="messages")