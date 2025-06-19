from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base

class TaskStatus(Base):
    __tablename__ = "task_status"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(nullable=False)
    description: Mapped[str] = mapped_column(nullable=True)
    
    tasks = relationship("Task", back_populates="status")