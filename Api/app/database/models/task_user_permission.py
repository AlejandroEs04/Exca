from sqlalchemy import ForeignKey, func
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.database.connection import Base

class TaskUserPermission(Base):
    __tablename__ = "task_user_permission"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(nullable=False)
    description: Mapped[str] = mapped_column(nullable=True)
    
    users = relationship("TaskUser", back_populates="permission")