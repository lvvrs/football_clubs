# Makefile for local development project: football_clubs

# Variables for use in Makefile commands
SLEEP_TIME = 10
IMAGE_NAME = football_clubs
CONTAINER_NAME = $(IMAGE_NAME)_app
APPLICATION_HTTP_PORT = 8080
DOCKER_REGISTRY = skay1989
DOCKER_USER = skay1989
PROXY_CONTAINER_NAME = traefik_proxy
KUBERNETES_APP_NAMESPACE = football-clubs-ns
HELM_FOOTBALL_CLUBS_APP_IMAGE_TAG = 0.0.2
HELM_RELEASE_NAME = football-clubs
HELM_CHART_PATH = deploy/helmchart
HELM_CHART_NAME = football-clubs-chart




#Sleep step for waiting run application in docker container
sleep_step:
	sleep $(SLEEP_TIME)

# Run application football_clubs local with uvicorn server in virtualenv
run_app_uvicorn:
	source ./venv/bin/activate && uvicorn app.src.main:app --reload

# Run unit-test's for application football_clubs with pytest in virtualenv
unit_tests_app:
	source ./venv/bin/activate && pytest

# Freeze python packages (dependencies) for application football_clubs in virtualenv
freeze_dependencies:
	source ./venv/bin/activate && pip freeze > requirements1.txt

# Build docker Image with application football_clubs
docker_build_app:
	docker build -t $(IMAGE_NAME) .

# Run docker container from image with application football_clubs
docker_run_app:
	docker run -d --name $(CONTAINER_NAME) --env UVICORN_PORT=$(APPLICATION_HTTP_PORT) \
	-p $(APPLICATION_HTTP_PORT):$(APPLICATION_HTTP_PORT) $(IMAGE_NAME)

# Build docker image with application football_clubs and run docker container from this image
docker_build_and_run_app: docker_build_app docker_run_app

# Get list of running containers
docker_list_running_containers:
	docker ps -a

# Get logs from container with application
docker_logs_app:
	docker logs $(CONTAINER_NAME)

# Get list of running containers and Get logs from container with application
docker_list_running_containers_and_logs_app: docker_list_running_containers docker_logs_app

# Build docker image with application football_clubs,
# run docker container from this image, sleep (variable: SLEEP_TIME) get list of running containers
# and get logs from container with application
docker_build_run_status_logs_app: docker_build_and_run_app sleep_step docker_list_running_containers_and_logs_app

# Stop and delete docker container with application football_clubs
docker_down_app:
	docker stop $(CONTAINER_NAME) && docker rm $(CONTAINER_NAME)

# Create docker tag for image with application football_clubs
docker_create_tag:
	read -p input_image_tag: IMAGE_TAG; docker tag $(IMAGE_NAME):latest $(DOCKER_REGISTRY)/$(IMAGE_NAME):$$IMAGE_TAG

# Login to docker registry (Docker Hub)
docker_hub_login:
	read -p input_password_for_registry: PASSWORD; docker login -u $(DOCKER_USER) -p $$PASSWORD

# Push docker image with application football_clubs to registry (Docker Hub)
docker_hub_push:
	read -p input_image_tag_for_push IMAGE_TAG; docker push $(DOCKER_REGISTRY)/$(IMAGE_NAME):$$IMAGE_TAG

# Remove docker image with application football_clubs from local registry
docker_rmi:
	read -p input_image_tag_for_remove IMAGE_TAG; docker rmi $(DOCKER_REGISTRY)/$(IMAGE_NAME):$$IMAGE_TAG

# Pull docker image with application football_clubs from registry (dockerhub)
docker_pull:
	read -p input_image_tag_for_pull IMAGE_TAG; docker pull $(DOCKER_REGISTRY)/$(IMAGE_NAME):$$IMAGE_TAG

# List docker images with application football_clubs on local registry
docker_list_images:
	docker images | grep $(IMAGE_NAME)

# Docker compose build image with application football_clubs
docker_compose_build:
	docker-compose build

# Docker compose build image with application football_clubs and run docker container from this image
docker_compose_build_and_run_app: docker_compose_build
	docker-compose up -d $(CONTAINER_NAME)

# Docker compose build image with application football_clubs
# and run docker container from image with container traefik proxy
docker_compose_build_and_run_app_with_traefik_proxy: docker_compose_build
	docker-compose up -d $(CONTAINER_NAME) $(PROXY_CONTAINER_NAME)

# Docker compose stop and delete containers
docker_compose_down:
	docker-compose down --remove-orphans

# Delete kubernetes namespace with application football_clubs
kubernetes_helm_uninstall:
	kubectl delete ns $(KUBERNETES_APP_NAMESPACE)

# Helm template football-clubs-chart sidecar disabled
helm_template_sidecar_disabled:
	helm template $(HELM_RELEASE_NAME) $(HELM_CHART_PATH)/$(HELM_CHART_NAME) \
        --set global.footballClubsAppImageVersion=$(HELM_FOOTBALL_CLUBS_APP_IMAGE_TAG)

# Helm template football-clubs-chart sidecar enabled
helm_template_sidecar_enabled:
	helm template $(HELM_RELEASE_NAME) $(HELM_CHART_PATH)/$(HELM_CHART_NAME) \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.proxyAppSidecarEnabled=true \
        --set global.footballClubsAppImageVersion=$(HELM_FOOTBALL_CLUBS_APP_IMAGE_TAG)

# Helm upgrade football-clubs-chart sidecar disabled
helm_upgrade_sidecar_disabled:
	helm upgrade --install $(HELM_RELEASE_NAME) $(HELM_CHART_PATH)/$(HELM_CHART_NAME) \
		--set football-clubs-app.traefikSidecarEnabled=false \
		--set traefik-proxy.proxyAppSidecarEnabled=false \
		--set global.footballClubsAppImageVersion=$(HELM_FOOTBALL_CLUBS_APP_IMAGE_TAG) \
		--create-namespace -n $(KUBERNETES_APP_NAMESPACE)

# Helm upgrade football-clubs-chart sidecar enabled
helm_upgrade_sidecar_enabled:
	helm upgrade --install $(HELM_RELEASE_NAME) $(HELM_CHART_PATH)/$(HELM_CHART_NAME) \
		--set football-clubs-app.traefikSidecarEnabled=true \
		--set traefik-proxy.proxyAppSidecarEnabled=true \
		--set global.footballClubsAppImageVersion=$(HELM_FOOTBALL_CLUBS_APP_IMAGE_TAG) \
		--create-namespace -n $(KUBERNETES_APP_NAMESPACE)
