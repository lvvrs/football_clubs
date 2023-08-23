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
				docker run -d --name football_clubs_app -p 80:80 football_clubs

# Work with Pycharm make plugin
docker_status:
				docker ps -a

# Work with Pycharm make plugin
docker_logs:
				docker logs football_clubs_app

# Work with Pycharm make plugin
docker_down:
				docker stop football_clubs_app && docker rm football_clubs_app

# Work with Pycharm make plugin
docker_build_run: docker_build docker_run

# Work with Pycharm make plugin
docker_status_logs: docker_status docker_logs

# Work with Pycharm make plugin
docker_build_run_status: docker_build_run docker_status

# Work with Pycharm make plugin
docker_tag:
				echo Input Repository_name and image_tag.
				echo Example: \"repo_name 1.0.0\"
				read REPO_NAME IMAGE_TAG; docker tag football_clubs:latest $$REPO_NAME/football_clubs:$$IMAGE_TAG

# Work with Pycharm make plugin
docker_login:
				echo Input Docker_REPO_Username and Docker_Repo_Password.
				echo Example: \"docker_user docker_password\"
				read REPO_USER REPO_PASSWORD; docker login -u $$REPO_USER -p $$REPO_PASSWORD

# Work with Pycharm make plugin
docker_push:
				echo Input Repository_name and image_tag.
				echo Example: \"repo_name 1.0.0\"
				read REPO_NAME IMAGE_TAG; docker push $$REPO_NAME/football_clubs:$$IMAGE_TAG

# Work with Pycharm make plugin
docker_rmi:
				echo Input Repository_name and image_tag.
				echo Example: \"repo_name 1.0.0\"
				read REPO_NAME IMAGE_TAG; docker rmi $$REPO_NAME/football_clubs:$$IMAGE_TAG

# Work with Pycharm make plugin
docker_pull:
				echo Input Repository_name and image_tag.
				echo Example: \"repo_name 1.0.0\"
				read REPO_NAME IMAGE_TAG; docker pull $$REPO_NAME/football_clubs:$$IMAGE_TAG

# Work with Pycharm make plugin
docker_list_images:
				docker images | grep football_clubs
