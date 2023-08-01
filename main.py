from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Command(BaseModel):
    command_name: str
    command_city: str
    command_country: str = "Russia"
    command_year_of_foundation: int
    command_home_stadium: str


command_list = [
    {
        "command_name": "Spartak",
        "command_city": "Moscow",
        "command_country": "Russia",
        "command_year_of_foundation": 1922,
        "command_home_stadium": "Otkritie bank Arena"
    },
    {
        "command_name": "Dinamo",
        "command_city": "Moscow",
        "command_country": "Russia",
        "command_year_of_foundation": 1923,
        "command_home_stadium": "Dinamo"
    },
    {
        "command_name": "CSKA",
        "command_city": "Moscow",
        "command_country": "Russia",
        "command_year_of_foundation": 1911,
        "command_home_stadium": "VEB Arena"
    }
]


@app.get("/")
async def root():
    return {"Application Name": "Football Club's"}


@app.get("/commads/all_commands")
async def get_all_commands():
    return command_list


@app.get("/commads/{name}")
async def get_command_by_name(name: str):
    searched_command = {}
    for command in command_list:
        if command["command_name"] == name:
            searched_command = command
            break
    if searched_command == {}:
        return f"Command with name {name} not found!"
    return searched_command


@app.post("/commands/add", response_model=Command)
def add_command(command: Command) -> Command:
    command_list.append(dict(command))
    return command


@app.delete("/commands/delete/{name}")
def delete_command_by_name(name: str):
    delete_count = 0
    for command in command_list:
        if command["command_name"] == name:
            command_list.remove(command)
            delete_count += 1
            return f"Command with name {name} was removed from command_list !"
    if delete_count == 0:
        return f"Command with name {name} not found!"
