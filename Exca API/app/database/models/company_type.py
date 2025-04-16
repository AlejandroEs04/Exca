from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from app.database.connection import Base

class CompanyType(Base):
    __tablename__ = "company_type"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    companies = relationship("Company", back_populates="company_type")