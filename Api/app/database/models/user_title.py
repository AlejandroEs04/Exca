from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base

class UserTitle(Base):
    __tablename__ = "user_title"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    name: Mapped[str] = mapped_column(nullable=False)
    
    users = relationship("User", back_populates="title")