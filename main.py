from fastapi import FastAPI
from pydantic import BaseModel
from typing import Union

app = FastAPI()


class Command(BaseModel):
    command_name: str
    command_city: str
    command_country: str = "Russia"
    command_year_of_foundation: int
    command_home_stadium: str
    command_coach: str


command_list = [
    {
        "command_name": "Spartak",
        "command_city": "Moscow",
        "command_country": "Russia",
        "command_year_of_foundation": 1922,
        "command_home_stadium": "Otkritie bank Arena",
        "command_coach": "Gilermo Abaskal"
    },
    {
        "command_name": "Dinamo",
        "command_city": "Moscow",
        "command_country": "Russia",
        "command_year_of_foundation": 1923,
        "command_home_stadium": "Dinamo",
        "command_coach": "Slavisha Yokanovich"
    },
    {
        "command_name": "CSKA",
        "command_city": "Moscow",
        "command_country": "Russia",
        "command_year_of_foundation": 1911,
        "command_home_stadium": "VEB Arena",
        "command_coach": "Vladimir Fedotov"
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


@app.get("/commads/home_stadium/{name}")
async def get_home_stadium_by_name(name: str):
    home_stadium: int = 0
    for command in command_list:
        if command["command_name"] == name:
            home_stadium += 1
            return {
                "command_name": command["command_name"],
                "command_home_stadium": command["command_home_stadium"],
            }
    if home_stadium < 1:
        return f"Command with name {name} not found!"


@app.get("/commands/foundation_year/{name}")
async def get_foundation_year(name: str):
    foundation_year_count: int = 0
    for command in command_list:
        if command["command_name"] == name:
            foundation_year_count += 1
            return {
                "command_name": command["command_name"],
                "command_foundation_year": command["command_year_of_foundation"],
            }
    if foundation_year_count < 1:
        return f"Command with name {name} not found!"


@app.get("/commands/coach/{name}")
async def get_coach_by_name(name: str) -> Union[dict, str]:
    coach_count: int = 0
    for command in command_list:
        if command["command_name"] == name:
            coach_count += 1
            return {
                "command_name": command["command_name"],
                "command_coach": command["command_coach"]
            }
    if coach_count < 1:
        return f"Command with name {name} not found!"


@app.get("/commands/city/{city}")
async def get_commands_by_city(city_name: str) -> Union[list, str]:
    command_list_by_city: list = []
    commands_count: int = 0
    for command in command_list:
        if command["command_city"] == city_name:
            commands_count += 1
            searched_command_dict = {
                "command_name": command["command_name"],
                "command_city": command["command_city"]
            }
            command_list_by_city.append(searched_command_dict)
    if len(command_list_by_city) > 0:
        return command_list_by_city
    else:
        return f"Commands from {city_name} not found!"


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


@app.put("/commands/change/{name}")
def change_command_information(name: str, command_update: dict):
    for command in command_list:
        if command["command_name"] == name:
            command_list.remove(command)
    command_list.append(command_update)
    return command_update

