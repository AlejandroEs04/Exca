from sqlalchemy import Column, Integer, ForeignKey, func, DateTime, Boolean, String
from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base
from datetime import datetime

class LeaseRequest(Base):
    __tablename__ = "lease_request"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    project_id: Mapped[int] = mapped_column(ForeignKey("project.id"), nullable=False)
    guarantee_id: Mapped[int] = mapped_column(ForeignKey("individual.id"), nullable=False)
    guarantee_type_id: Mapped[int] = mapped_column(ForeignKey("guarantee_type.id"), nullable=False)
    owner_id: Mapped[int] = mapped_column(ForeignKey("owner.id"), nullable=False)
    commission_agreement: Mapped[bool] = mapped_column(nullable=False)
    assignment_income: Mapped[bool] = mapped_column(nullable=False)
    property_file: Mapped[str] = mapped_column(nullable=False)
    created_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(nullable=False, server_default=func.now(), onupdate=func.now())
    status_id: Mapped[int] = mapped_column(ForeignKey("status.id"), nullable=False)
    created_by: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)

    # Relaciones igual
    project = relationship("Project", back_populates="lease_request")
    status = relationship("Status", back_populates="lease_requests")
    creator = relationship("User", back_populates="lease_requests")
    conditions = relationship("LeaseRequestCondition", back_populates="lease_request")
    guarantee = relationship("Individual", back_populates="lease_requests")
    guarantee_type = relationship("GuaranteeType", back_populates="lease_requests")
    owner = relationship("Owner", back_populates="lease_requests")
