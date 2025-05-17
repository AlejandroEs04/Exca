from sqlalchemy.orm import relationship, Mapped, mapped_column
from sqlalchemy import String, Boolean, Integer
from app.database.connection import Base

class ApprovalFlow(Base):
    __tablename__ = "approval_flow"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(nullable=False)
    description: Mapped[str | None] = mapped_column(nullable=True)
    is_active: Mapped[bool] = mapped_column(nullable=False)

    steps = relationship("ApprovalFlowStep", back_populates="flow")