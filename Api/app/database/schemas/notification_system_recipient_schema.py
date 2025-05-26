from pydantic import BaseModel

class NotificationSystemRecipientBase(BaseModel):
    user_id: int
    
class NotificationSystemRecipientCreate(NotificationSystemRecipientBase):
    pass

class NotificationSystemRecipientResponse(NotificationSystemRecipientBase):
    id: int
    notification_system_id: int
    is_active: bool
    
    class config:
        orm_mode=True