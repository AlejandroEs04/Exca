from datetime import datetime
from sqlalchemy import ForeignKey, String, Float, Boolean, DateTime, func
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.database.connection import Base

class LeaseRequestCondition(Base):
    __tablename__ = "lease_request_condition"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    lease_request_id: Mapped[int] = mapped_column(ForeignKey("lease_request.id"), nullable=False)
    condition_id: Mapped[int] = mapped_column(ForeignKey("condition.id"), nullable=False)
    
    text_value: Mapped[str | None] = mapped_column(String, nullable=True)
    number_value: Mapped[float | None] = mapped_column(Float, nullable=True)
    date_value: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    boolean_value: Mapped[bool | None] = mapped_column(Boolean, nullable=True)
    
    option_id: Mapped[int | None] = mapped_column(ForeignKey("condition_option.id"), nullable=True)  # ojo, antes tenías nullable=False, pero tenías valores opcionales en schema
    
    is_active: Mapped[bool] = mapped_column(Boolean, nullable=False)
    
    created_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())

    # Relaciones
    lease_request = relationship("LeaseRequest", back_populates="conditions")
    condition = relationship("Condition", back_populates="request_conditions")
    option = relationship("ConditionOption", back_populates="lease_request_conditions")
