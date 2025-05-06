from sqlalchemy import Column, Integer, DateTime, func
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Case(Base):
    __tablename__ = "case"
    
    id = Column(Integer, primary_key=True, index=True)
    project_id = Column(Integer, nullable=False)
    originator_id = Column(Integer, nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    sended_at = Column(DateTime, nullable=True)
    updated_at = Column(DateTime, nullable=False, server_default=func.now(), onupdate=func.now())
    type_id = Column(Integer, nullable=False)