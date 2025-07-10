from sqlalchemy.orm import relationship, Mapped, mapped_column
from app.database.connection import Base

class ClientRoll(Base):
    __tablename__ = "client_roll"
    
    id: Mapped[int] = mapped_column(primary_key=True,index=True)
    name: Mapped[str] = mapped_column(nullable=False)
    
    clients = relationship("Client", back_populates="roll")