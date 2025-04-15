from fastapi import FastAPI
from app.routers import businessTurn, clients
from app.database.connection import Base, engine

app = FastAPI()

Base.metadata.create_all(bind=engine)

app.include_router(businessTurn.router)
app.include_router(clients.router)
