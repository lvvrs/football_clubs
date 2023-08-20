from fastapi.testclient import TestClient

from ..src.main import app


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


def test_main_get_command_by_name_success():
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


def test_main_get_command_by_name_failure():
    response = client.get("/commads/Rotor")
    assert response.status_code == 200
    assert response.json() == "Command with name Rotor not found!"


def test_main_get_home_stadium_by_name_success():
    response = client.get("/commads/home_stadium/Spartak")
    assert response.status_code == 200
    assert response.json() == {
        "command_name": "Spartak",
        "command_home_stadium": "Otkritie bank Arena"
    }


def test_main_get_home_stadium_by_name_failure():
    response = client.get("/commads/home_stadium/Rotor")
    assert response.status_code == 200
    assert response.json() == "Command with name Rotor not found!"


def test_main_get_foundation_year_success():
    response = client.get("/commands/foundation_year/Spartak")
    assert response.status_code == 200
    assert response.json() == {
        "command_name": "Spartak",
        "command_foundation_year": 1922
    }


def test_main_get_foundation_year_failure():
    response = client.get("/commands/foundation_year/Rotor")
    assert response.status_code == 200
    assert response.json() == "Command with name Rotor not found!"


def test_main_get_coach_by_name_success():
    response = client.get("/commands/coach/Spartak")
    assert response.status_code == 200
    assert response.json() == {
        "command_name": "Spartak",
        "command_coach": "Gilermo Abaskal"
    }


def test_main_get_coach_by_name_failure():
    response = client.get("/commands/coach/Rotor")
    assert response.status_code == 200
    assert response.json() == "Command with name Rotor not found!"


def test_main_get_commands_by_city_success():
    response = client.get("/commands/city/Moscow")
    assert response.status_code == 200
    assert response.json() == [
        {
            "command_name": "Spartak",
            "command_city": "Moscow"
        },
        {
            "command_name": "Dinamo",
            "command_city": "Moscow"
        },
        {
            "command_name": "CSKA",
            "command_city": "Moscow"
        }
    ]


def test_main_get_commands_by_city_failure():
    response = client.get("/commands/city/Perm")
    assert response.status_code == 200
    assert response.json() == "Commands from Perm not found!"


def test_main_add_command():
    response = client.post("/commands/add",
                           headers={
                               "accept": "application/json",
                               "Content-Type": "application/json"
                           },
                           json={
                               "command_name": "Amrar",
                               "command_city": "Perm",
                               "command_country": "Russia",
                               "command_year_of_foundation": 1994,
                               "command_home_stadium": "Zvezda",
                               "command_coach": "Ivan Cherenchikov"
                           })
    assert response.status_code == 200
    assert response.json() == {
        "command_name": "Amrar",
        "command_city": "Perm",
        "command_country": "Russia",
        "command_year_of_foundation": 1994,
        "command_home_stadium": "Zvezda",
        "command_coach": "Ivan Cherenchikov"
    }


def test_main_delete_command_by_name_success():
    response = client.delete("/commands/delete/CSKA")
    assert response.status_code == 200
    assert response.json() == "Command with name CSKA was removed from command_list !"


def test_main_delete_command_by_name_failure():
    response = client.delete("/commands/delete/Rotor")
    assert response.status_code == 200
    assert response.json() == "Command with name Rotor not found!"


def test_main_change_command_information():
    response = client.put("/commands/change/Dinamo",
                          headers={
                              "accept": "application/json",
                              "Content-Type": "application/json"
                          },
                          json={
                              "command_name": "Dinamo",
                              "command_city": "Moscow",
                              "command_country": "Russia",
                              "command_year_of_foundation": 1924,
                              "command_home_stadium": "Dinamo",
                              "command_coach": "Slavisha Yokanovich"
                          })
    assert response.status_code == 200
    assert response.json() == {
        "command_name": "Dinamo",
        "command_city": "Moscow",
        "command_country": "Russia",
        "command_year_of_foundation": 1924,
        "command_home_stadium": "Dinamo",
        "command_coach": "Slavisha Yokanovich"
    }
