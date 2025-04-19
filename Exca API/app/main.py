from fastapi import FastAPI
from app.routers import companies, land, client
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

app.include_router(companies.router)
app.include_router(land.router)
app.include_router(client.router)
