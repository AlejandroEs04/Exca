from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Company(Base):
    __tablename__ = "company"
    
    id = Column(Integer, primary_key=True, index=True)
    business_name = Column(String, nullable=False)
    email = Column(String, nullable=True)
    phone_number = Column(String, nullable=True)
    tax_id = Column(String, nullable=True)
    address = Column(String, nullable=True)
    type_id = Column(Integer, ForeignKey("company_type.id"), nullable=False)
    
    company_type = relationship("CompanyType", back_populates="companies")
    clients = relationship("Client", back_populates="company")
