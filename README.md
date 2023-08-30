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
    10) Docker-Compose for run Application and additional containers


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
    9) docker_tag - set repository and tag for image
    10) docker_login - login to dockerhub
    11) docker_push - push image to dockerhub
    12) docker_rmi - untagged or remove image
    13) docker_pull - pull image from docker hub
    14) docker_list_images - list docker images on local pc
    15) docker_compose_build - build image with docker-compose
    16) docker_compose_up - run appication with docker compose, create network, depends on docker_compose_build
    17) docker_compose_down - stop and delete application container with docker-compose

## Run Application with Docker
Application run in docker container.
Docker container available on dockerhub: 
https://hub.docker.com/repository/docker/skay1989/football_clubs/general

#### Command for run application:

    docker run -d --name football_clubs_app --env UVICORN_PORT=8080 -p 8080:8080 football_clubs

#### Environment variables:

    UVICORN_PORT - set http port for application (default 80)
    UVICORN_HOST - set host for application (default 0.0.0.0)

    