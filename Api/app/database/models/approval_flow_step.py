from sqlalchemy.orm import relationship, Mapped, mapped_column
from sqlalchemy import Integer, ForeignKey, Boolean
from app.database.connection import Base

class ApprovalFlowStep(Base):
    __tablename__ = "approval_flow_step"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    flow_id: Mapped[int] = mapped_column(ForeignKey("approval_flow.id"), nullable=False)
    step_order: Mapped[int] = mapped_column(nullable=False)
    signator_role_id: Mapped[int] = mapped_column(ForeignKey("user_rol.id"), nullable=False)
    signator_area_id: Mapped[int] = mapped_column(ForeignKey("area.id"), nullable=False)
    signator_id: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    is_required: Mapped[bool] = mapped_column(nullable=False)
    
    signator = relationship("User", back_populates="approval_flow_steps")
    flow = relationship("ApprovalFlow", back_populates="steps")
    area = relationship("Area", back_populates="approval_steps")
    rol = relationship("UserRol", back_populates="approval_steps")
    requests = relationship("ApprovalRequest", back_populates="step")