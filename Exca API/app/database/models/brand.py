from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Brand(Base):
    __tablename__ = "brand"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    client_id = Column(Integer, ForeignKey("client.id"), nullable=False)
    
    client = relationship("Client", back_populates="brands")
    projects = relationship("Project", back_populates="brand")