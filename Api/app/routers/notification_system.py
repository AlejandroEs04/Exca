from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.database.schemas.notification_system_schema import NotificationSystemCreate, NotificationSystemResponse
from app.database.models.notification_system import NotificationSystem
from app.database.models.notification_system_recipient import NotificationSystemRecipient

router = APIRouter(prefix="/notification-system", tags=["NotificationSystems"])

@router.post("/", response_model=NotificationSystemResponse)
def create_notification_system(notification_system: NotificationSystemCreate, db: Session = Depends(get_db)):
    new_notification_system = NotificationSystem(
        name=notification_system.name,
        description=notification_system.description
    )
    db.add(new_notification_system)
    db.commit()
    db.refresh(new_notification_system)
    
    for recipient in notification_system.recipients:
        new_recipient = NotificationSystemRecipient(
            notification_system_id=new_notification_system.id, 
            user_id=recipient.user_id
        )
        db.add(new_recipient)
        
    db.commit()
    db.refresh(new_notification_system)
    return new_notification_system

@router.put("/{notification_system_id}", response_model=NotificationSystemResponse)
def update_notification_system(notification_system: NotificationSystemCreate, notification_system_id: int, db: Session = Depends(get_db)):
    exists_notification_system = db.query(NotificationSystem).where(NotificationSystem.id == notification_system_id).first()
    
    if not exists_notification_system: 
        raise HTTPException(status_code=404, detail="El sistema de notificaciones no fue encontrado")
    
    exists_notification_system.name = notification_system.name
    exists_notification_system.description = notification_system.description
    exists_notification_system.is_active = notification_system.is_active
    
    db.query(NotificationSystemRecipient).where(NotificationSystemRecipient.notification_system_id == notification_system_id).delete()
    
    for recipient in notification_system.recipients:
        new_recipient = NotificationSystemRecipient(
            notification_system_id=notification_system_id, 
            user_id=recipient.user_id
        )
        db.add(new_recipient)
        
    db.commit()
    db.refresh(exists_notification_system)
    return exists_notification_system

@router.get("/", response_model=list[NotificationSystemResponse])
def get_notification_systems(db: Session = Depends(get_db)):
    return db.query(NotificationSystem).all()