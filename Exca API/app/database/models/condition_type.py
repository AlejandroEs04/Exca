from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ConditionType(Base):
    __tablename__ = "condition_type"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)