from sqlalchemy import ForeignKey, func
from sqlalchemy.orm import relationship, Mapped, mapped_column
from datetime import datetime
from app.database.connection import Base

class ApprovalRequest(Base):
    __tablename__ = "approval_request"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    flow_step_id: Mapped[int] = mapped_column(ForeignKey("approval_flow_step.id"), nullable=False)
    item_id: Mapped[str] = mapped_column(nullable=False)
    requested_by: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    requested_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now())
    responsed_at: Mapped[datetime | None] = mapped_column(nullable=True, server_default=func.now())
    response: Mapped[bool | None] = mapped_column(nullable=True)
    comments: Mapped[str | None] = mapped_column(nullable=True)
    
    user = relationship("User", back_populates="requests")
    step = relationship("ApprovalFlowStep", back_populates="requests")