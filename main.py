from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Command(BaseModel):
    command_name: str
    command_city: str
    command_country: str = "Russia"
    command_year_of_foundation: int
    command_home_stadium: str


@app.get("/")
async def root():
    return {"Application Name": "Football Club's"}


@app.post("/commands/add", response_model=Command)
def add_command(command: Command) -> Command:
    return command
