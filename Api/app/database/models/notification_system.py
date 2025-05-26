from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base

class NotificationSystem(Base):
    __tablename__ = "notification_system"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(nullable=False)
    description: Mapped[str | None] = mapped_column(nullable=True)
    is_active: Mapped[bool] = mapped_column(nullable=False, default=True)
    
    recipients = relationship("NotificationSystemRecipient", back_populates="notification_system")