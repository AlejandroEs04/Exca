from fastapi import FastAPI
from app.routers import \
    brand,client,land,project,user,condition,lease_request,area,rol,approval_flow,owner,individual,auth,approval_request,document,case,property_tax,property_tax_status,land_category,\
    land_status,land_type,state,city,residential_development,notification_system,task,task_status,task_message,client_roll,project_land
from app.database.connection import Base, engine
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost:5173",
    "http://127.0.0.1:5173",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

Base.metadata.create_all(bind=engine)

app.include_router(client.router)
app.include_router(land.router)
app.include_router(brand.router)
app.include_router(project.router)
app.include_router(user.router)
app.include_router(condition.router)
app.include_router(lease_request.router)
app.include_router(area.router)
app.include_router(rol.router)
app.include_router(approval_flow.router)
app.include_router(owner.router)
app.include_router(individual.router)
app.include_router(auth.router)
app.include_router(approval_request.router)
app.include_router(document.router)
app.include_router(case.router)
app.include_router(task.router)
app.include_router(task_status.router)
app.include_router(task_message.router)
app.include_router(client_roll.router)
app.include_router(property_tax.router)
app.include_router(property_tax_status.router)
app.include_router(land_category.router)
app.include_router(land_status.router)
app.include_router(land_type.router)
app.include_router(state.router)
app.include_router(city.router)
app.include_router(residential_development.router)
app.include_router(notification_system.router)
app.include_router(project_land.router)