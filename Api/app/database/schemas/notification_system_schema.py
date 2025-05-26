from pydantic import BaseModel
from app.database.schemas.notification_system_recipient_schema import NotificationSystemRecipientCreate, NotificationSystemRecipientResponse

class NotificationSystemSchema(BaseModel):
    name: str
    description: str | None = None

class NotificationSystemCreate(NotificationSystemSchema):
    is_active: bool = True
    recipients: list[NotificationSystemRecipientCreate] = []

class NotificationSystemResponse(NotificationSystemSchema):
    id: int
    is_active: bool
    recipients: list[NotificationSystemRecipientResponse] = []
    
    class config:
        orm_mode=True