from fastapi.testclient import TestClient

from .main import app


client = TestClient(app)


def test_main_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Application Name": "Football Club's"}


def test_main_get_all_commands():
    response = client.get("/commads/all_commands")
    assert response.status_code == 200
    assert response.json() == [
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


def test_get_command_by_name_success():
    response = client.get("/commads/Spartak")
    assert response.status_code == 200
    assert response.json() == {
        "command_name": "Spartak",
        "command_city": "Moscow",
        "command_country": "Russia",
        "command_year_of_foundation": 1922,
        "command_home_stadium": "Otkritie bank Arena",
        "command_coach": "Gilermo Abaskal"
    }


def test_get_command_by_name_failure():
    response = client.get("/commads/Rotor")
    assert response.status_code == 200
    assert response.json() == "Command with name Rotor not found!"

