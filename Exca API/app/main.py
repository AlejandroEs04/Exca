from fastapi import FastAPI
from app.routers import \
    brand,client,land,project,user,condition,lease_request,area,rol,approval_flow,owner,individual,auth,approval_request,document,technical_case
from app.database.connection import Base, engine
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost:5173",
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
app.include_router(technical_case.router)
