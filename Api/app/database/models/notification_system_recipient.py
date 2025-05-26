from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base

class NotificationSystemRecipient(Base):
    __tablename__ = "notification_system_recipient"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    notification_system_id: Mapped[int] = mapped_column(ForeignKey("notification_system.id"), nullable=False)
    user_id: Mapped[int] = mapped_column(ForeignKey("user.id"), nullable=False)
    is_active: Mapped[bool] = mapped_column(nullable=False, default=True)
    
    notification_system = relationship("NotificationSystem", back_populates="recipients")
    user = relationship("User", back_populates="recipients")