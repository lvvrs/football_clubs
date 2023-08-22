# Makefile for run application local and run tests

# Work only run in virtualenv (make run_app) only in command line
run_app:
				uvicorn app.src.main:app --reload

# Work only run in virtualenv (make unit_tests) only in command line
unit_tests:
				pytest

# Work only run in virtualenv (make freeze) only in command line
freeze:
				pip freeze > requirements.txt

# Work with Pycharm make plugin
docker_build:
				docker build -t football_clubs .

# Work with Pycharm make plugin
docker_run:
				docker run -d --name footbool_clubs_app -p 80:80 football_clubs

# Work with Pycharm make plugin
docker_status:
				docker ps -a

# Work with Pycharm make plugin
docker_logs:
				docker logs footbool_clubs_app

# Work with Pycharm make plugin
docker_down:
				docker stop footbool_clubs_app && docker rm footbool_clubs_app

# Work with Pycharm make plugin
docker_build_run: docker_build docker_run

# Work with Pycharm make plugin
docker_status_logs: docker_status docker_logs

# Work with Pycharm make plugin
docker_build_run_status: docker_build_run docker_status
