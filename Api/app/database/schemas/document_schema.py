from pydantic import BaseModel

class DocumentBase(BaseModel):
    name: str 
    use_legal_entity: bool
    use_physical_person: bool 
    use_individual: bool
    
class DocumentCreate(DocumentBase):
    pass

class DocumentResponse(DocumentBase):
    id: int
    
    class config:
        from_attributes = True