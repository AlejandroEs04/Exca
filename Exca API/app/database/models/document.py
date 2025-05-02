from sqlalchemy import Column, Integer, String, Boolean
from sqlalchemy.orm import relationship
from app.database.connection import Base

class Document(Base):
    __tablename__ = "document"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    use_legal_entity = Column(Boolean, nullable=False)
    use_physical_person = Column(Boolean, nullable=False)
    use_individual = Column(Boolean, nullable=False)
    
    individual_documents = relationship("IndividualDocument", back_populates="document")
    entities = relationship("DocumentEntity", back_populates="document")