from sqlalchemy.orm import relationship, Mapped, mapped_column
from sqlalchemy import String, Integer, ForeignKey
from app.database.connection import Base

class User(Base):
    __tablename__ = "user"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    full_name: Mapped[str] = mapped_column(nullable=False)
    email: Mapped[str] = mapped_column(nullable=False, unique=True)
    rol_id: Mapped[int] = mapped_column(ForeignKey("user_rol.id"), nullable=False)
    user_title_id: Mapped[int] = mapped_column(ForeignKey("user_title.id"), nullable=False)
    area_id: Mapped[int] = mapped_column(ForeignKey("area.id"), nullable=False)
    hashed_password: Mapped[str] = mapped_column(nullable=False)
    
    cases = relationship("Case", back_populates="originator")
    projects = relationship("Project", back_populates="originator")
    area = relationship("Area", back_populates="users")
    rol = relationship("UserRol", back_populates="users")
    requests = relationship("ApprovalRequest", back_populates="user")
    lease_requests = relationship("LeaseRequest", back_populates="creator")
    approval_flow_steps = relationship("ApprovalFlowStep", back_populates="signator")
    title = relationship("UserTitle", back_populates="users")
    recipients = relationship("NotificationSystemRecipient", back_populates="user")
    tasks_created = relationship("Task", back_populates="originator", foreign_keys="[Task.originator_id]")
    tasks_assigned = relationship("Task", back_populates="responsible", foreign_keys="[Task.responsible_id]")
    task_messages = relationship("TaskMessage", back_populates="originator")