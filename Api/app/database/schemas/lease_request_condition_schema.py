from datetime import datetime
from pydantic import BaseModel, ConfigDict
from typing import Optional, Union
from app.database.schemas.condition_schema import ConditionResponse
from app.database.schemas.condition_option_schema import ConditionOptionResponse

class LeaseRequestConditionBase(BaseModel):
    lease_request_id: int | None = None
    condition_id: int
    is_active: bool

class LeaseRequestConditionCreate(LeaseRequestConditionBase):
    text_value: Optional[str] = None
    number_value: Optional[float] = None
    date_value: Optional[datetime] = None
    boolean_value: Optional[bool] = None
    option_id: Optional[int] = None

class LeaseRequestConditionResponse(LeaseRequestConditionBase):
    id: int
    text_value: Optional[str] = None
    number_value: Optional[float] = None
    date_value: Optional[datetime] = None
    boolean_value: Optional[bool] = None
    created_at: datetime
    updated_at: datetime
    condition: Optional[ConditionResponse] = None
    option_id: Optional[int] = None
    # option: Optional[list[ConditionOptionResponse]] = None
    
    # Para Pydantic v2
    model_config = ConfigDict(from_attributes=True)

    # Propiedad computada 'value' como unión de todos los tipos de valores
    @property
    def value(self) -> Union[str, float, datetime, bool, None]:
        if self.text_value is not None:
            return self.text_value
        elif self.number_value is not None:
            return self.number_value
        elif self.date_value is not None:
            return self.date_value
        elif self.boolean_value is not None:
            return self.boolean_value
        return None