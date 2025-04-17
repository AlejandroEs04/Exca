from fastapi import FastAPI
from app.routers import companies, land, client
from app.database.connection import Base, engine

app = FastAPI()

Base.metadata.create_all(bind=engine)

app.include_router(companies.router)
app.include_router(land.router)
app.include_router(client.router)
