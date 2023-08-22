# football_clubs
Repository for study project on python

## Instuments and technology's

    1) Python 3.9
    2) FastApi Framework for Rest API
    3) SQL Alchemy for work with DB
    4) Pydantic for data models
    5) Docker for run Application
    6) Httpx for client Application (Using with Pytest)
    7) Pytest for unit tests Application
    8) Make and Makefile
    9) Httpx for TestClient in unittest's for Pytest


## Makefile
The Make utility is used to manage project locally.
The project contains a Makefile with commands to perform actions.

### Makefile command's description

#### Commands work's in virtualenv
    1) run_app - local run app
    2) unit_tests - run unit test's with pytest util
    3) freeze - generate requirements.txt file with application dependencies
#### Commands work's global
    1) docker_build - run build docker image with application
    2) docker_run - run docker container
    3) docker_status - check container status (docker ps -a)
    4) docker_logs - check application logs from container
    5) docker_down - stop and remove docker container
    6) docker_build_run - consists of commands: docker_build and docker_run
    7) docker_status_logs - consists of commands: docker_status and docker_logs
    8) docker_build_run_status - consists of commands: docker_build_run and docker_status