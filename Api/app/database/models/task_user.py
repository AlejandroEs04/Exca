from sqlalchemy import ForeignKey, func
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.database.connection import Base

class TaskUser(Base):
    __tablename__ = "task_user"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    task_id: Mapped[int] = mapped_column(ForeignKey("task.id"), nullable=False)
    permission_id: Mapped[int] = mapped_column(ForeignKey("task_user_permission.id"), nullable=False)
    
    user = relationship("User", back_populates="task_related")
    task = relationship("Task", back_populates="users_related")
    permission = relationship("TaskUserPermission", back_populates="users")