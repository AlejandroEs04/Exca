from sqlalchemy import ForeignKey, String, Boolean, DateTime, Float
from sqlalchemy.orm import relationship, Mapped, mapped_column
from datetime import datetime
from app.database.connection import Base

class CaseCondition(Base):
    __tablename__ = "case_condition"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    case_id: Mapped[int] = mapped_column(ForeignKey("case.id"), nullable=False)
    condition_id: Mapped[int] = mapped_column(ForeignKey("condition.id"), nullable=False)
    text_value: Mapped[str | None] = mapped_column(nullable=True)
    number_value: Mapped[float | None] = mapped_column(nullable=True)
    date_value: Mapped[datetime | None] = mapped_column(nullable=True)
    boolean_value: Mapped[bool | None] = mapped_column(nullable=True)
    option_id: Mapped[int] = mapped_column(ForeignKey("condition_option.id"), nullable=False)
    is_active: Mapped[bool] = mapped_column(nullable=False)

    case = relationship("Case", back_populates="conditions")
    condition = relationship("Condition", back_populates="case_conditions")
    option = relationship("ConditionOption", back_populates="case_conditions")
