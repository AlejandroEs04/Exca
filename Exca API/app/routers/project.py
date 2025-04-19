from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.orm import Session, joinedload

from app.database.connection import SessionLocal
from app.database.models.client import Client
from app.database.models.brand import Brand
from app.database.models.project_land import ProjectLand
from app.database.models.project import Project
from app.database.schemas.project_schema import ProjectCreate, ProjectResponse

router = APIRouter(prefix="/project", tags=["Projects"])

def get_db():
    # Start db connection
    db = SessionLocal()
    
    try:
        yield db
    finally:
        db.close()
        
@router.post("/", response_model=ProjectResponse)
def create_project(project: ProjectCreate, db: Session = Depends(get_db)):
    client_id = None
    client_query = select(Client).where(Client.business_name == project.client)
    client_exists = db.scalars(client_query).first()
    
    if(not client_exists):
        # Create a new client if it doesn't exist
        newClient = Client(
            business_name=project.client,
            email=None,
            phone_number=None,
            tax_id=None,
            address=None,
            type_id=2
        )
        
        db.add(newClient)
        db.commit()
        db.refresh(newClient)
        client_id = newClient.id
    else:
        client_id = client_exists.id
        
    brand_id = None
    brand_query = select(Brand).where(Brand.name == project.brand).where(Brand.client_id == client_id)
    brand_exists = db.scalars(brand_query).first()
    
    if(not brand_exists):
        # Create a new brand if it doesn't exist
        newBrand = Brand(
            name=project.brand,
            client_id=client_id
        )
        
        db.add(newBrand)
        db.commit()
        db.refresh(newBrand)
        brand_id = newBrand.id
    else:
        brand_id = brand_exists.id
        
    # Create a new project
    new_project = Project(
        name=project.name,
        brand_id=brand_id,
        stage_id=1,
        originator_id=1
    )
    db.add(new_project)
    db.commit()
    db.refresh(new_project)
    
    new_lands = []
    
    for land in project.lands:
        new_land = ProjectLand(
            project_id=new_project.id,
            land_id=land.land_id,
            area=land.area
        )
        db.add(new_land)
        db.commit()
        db.refresh(new_land)
        new_lands.append(new_land)
        
    new_project.lands = new_lands
    return new_project

@router.get("/", response_model=list[ProjectResponse])
def get_projects(db: Session = Depends(get_db)):
    projects = db.query(Project).options(joinedload(Project.lands)).all()
    return projects