from fastapi import FastAPI
from app.routers import companies
from app.database.connection import Base, engine

app = FastAPI()

Base.metadata.create_all(bind=engine)

app.include_router(companies.router)
