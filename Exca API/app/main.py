from fastapi import FastAPI
from app.routers import brand, client, land, project, user
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
