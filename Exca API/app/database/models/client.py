from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Client(Base):
    __tablename__ = "client"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    company_id = Column(Integer, ForeignKey("company.id"), nullable=False)
    
    company = relationship("Company", back_populates="clients")