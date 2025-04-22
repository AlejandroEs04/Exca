from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Condition(Base):
    __tablename__ = "condition"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    category_id = Column(Integer, ForeignKey("condition_category.id"), nullable=False)
    type_id = Column(Integer, ForeignKey("condition_type.id"), nullable=False)
    options = Column(String, nullable=True)
    
    category = relationship("ConditionCategory", back_populates="conditions")
    type = relationship("ConditionType", back_populates="conditions")