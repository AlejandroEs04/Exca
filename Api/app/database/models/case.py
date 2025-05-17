from sqlalchemy import ForeignKey, DateTime, func
from sqlalchemy.orm import relationship, Mapped, mapped_column
from datetime import datetime
from app.database.connection import Base

class Case(Base):
    __tablename__ = "case"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    project_id: Mapped[int] = mapped_column(ForeignKey("project.id"), nullable=False)
    case_type_id: Mapped[int] = mapped_column(ForeignKey("case_type.id"), nullable=False)
    originator_id: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    created_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now())
    sended_at: Mapped[datetime | None] = mapped_column(nullable=True)
    updated_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now(), onupdate=func.now())
    status_id: Mapped[int] = mapped_column(ForeignKey("status.id"), nullable=False)

    originator = relationship("User", back_populates="cases")
    type = relationship("CaseType", back_populates="cases")
    status = relationship("Status", back_populates="cases")
    conditions = relationship("CaseCondition", back_populates="case")
    project = relationship("Project", back_populates="cases")
