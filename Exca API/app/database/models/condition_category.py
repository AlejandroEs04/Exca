from sqlalchemy import Column, String, Integer
from sqlalchemy.orm import relationship
from app.database.connection import Base

class ConditionCategory(Base):
    __tablename__ = "condition_category"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    
    conditions = relationship("Condition", back_populates="category")