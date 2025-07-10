from fastapi import APIRouter, Depends, status, HTTPException
from sqlalchemy.orm import Session
from app.database.connection import get_db
from app.database.models import ProjectLand
from app.database.schemas.project_land_schema import ProjectLandCreate, ProjectLandResponse

router = APIRouter(prefix="/project-land", tags=["ProjectLands"])

@router.put("/{id}", response_model=ProjectLandResponse)
def update_project_land(id: int, project_land: ProjectLandCreate, db: Session = Depends(get_db)):
    exists_project_land = db.query(ProjectLand).where(ProjectLand.id == id).first()
    
    if not exists_project_land:
        raise HTTPException(404, detail="Terreno no encontrado")
    
    exists_project_land.area = project_land.area
    exists_project_land.build_area = project_land.build_area
    exists_project_land.type_id = project_land.type_id
    exists_project_land.deed_sale = project_land.deed_sale
    
    db.add(exists_project_land)
    db.commit()
    db.refresh(exists_project_land)
    return exists_project_land