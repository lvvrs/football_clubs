# Makefile for run application local and run tests

# Run application
run_app:
				source ./venv/bin/activate && uvicorn app.src.main:app --reload

# Run unit-test
unit_tests:
				source ./venv/bin/activate && pytest

# Freeze python packages (dependencies)
freeze:
				source ./venv/bin/activate && pip freeze > requirements.txt

# Build docker Image
docker_build:
				docker build -t football_clubs .

# Run docker container with application
docker_run:
				docker run -d --name football_clubs_app --env UVICORN_PORT=8080 -p 8080:8080 football_clubs

# Get list of running containers
docker_status:
				docker ps -a

# Get logs from container with application
docker_logs:
				docker logs football_clubs_app

# Stop and delete docker container
docker_down:
				docker stop football_clubs_app && docker rm football_clubs_app

# Build docker image and run docker container
docker_build_run: docker_build docker_run

# Get list of running containers and Get logs from container with application
docker_status_logs: docker_status docker_logs

# Build docker image, run docker container and Get list of running containers
docker_build_run_status: docker_build_run docker_status

# Create docker tag for image with application
docker_tag:
				echo Input Repository_name and image_tag.
				echo Example: \"repo_name 1.0.0\"
				read REPO_NAME IMAGE_TAG; docker tag football_clubs:latest $$REPO_NAME/football_clubs:$$IMAGE_TAG

# Login docker registry
docker_login:
				echo Input Docker_REPO_Username and Docker_Repo_Password.
				echo Example: \"docker_user docker_password\"
				read REPO_USER REPO_PASSWORD; docker login -u $$REPO_USER -p $$REPO_PASSWORD

# Push docker image to registry (dockerhub)
docker_push:
				echo Input Repository_name and image_tag.
				echo Example: \"repo_name 1.0.0\"
				read REPO_NAME IMAGE_TAG; docker push $$REPO_NAME/football_clubs:$$IMAGE_TAG

# Delete docker image
docker_rmi:
				echo Input Repository_name and image_tag.
				echo Example: \"repo_name 1.0.0\"
				read REPO_NAME IMAGE_TAG; docker rmi $$REPO_NAME/football_clubs:$$IMAGE_TAG

# Pull docker image from Registry (dockerhub)
docker_pull:
				echo Input Repository_name and image_tag.
				echo Example: \"repo_name 1.0.0\"
				read REPO_NAME IMAGE_TAG; docker pull $$REPO_NAME/football_clubs:$$IMAGE_TAG

# Get docker images with application
docker_list_images:
				docker images | grep football_clubs

# Docker compose build image with application
docker_compose_build:
				docker-compose build

# Docker compose build image with application and run container
docker_compose_up: docker_compose_build
				docker-compose up -d football_clubs_app

# Docker compose build image with application and run container with container traefik proxy
docker_compose_up_with_traefik_proxy: docker_compose_build
				docker-compose up -d football_clubs_app traefik_proxy

# Docker compose stop and delete containers
docker_compose_down:
				docker-compose down --remove-orphans

# Delete kubernetes namespace with application
kubernetes_helm_uninstall:
				kubectl delete ns football-clubs-ns

# Helm template sidecar disabled
helm_template_sidecar_disabled:
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart

# Helm template sidecar disabled with set custom image version
helm_template_sidecar_disabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG

# Helm upgrade sidecar disabled
helm_upgrade_sidecar_disabled:
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=false \
				--set traefik-proxy.proxyAppSidecarEnabled=false \
				--create-namespace -n football-clubs-ns

# Helm upgrade sidecar disabled with set custom image version
helm_upgrade_sidecar_disabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=false \
				--set traefik-proxy.enabled=false \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar disabled
helm_upgrade_dry_run_sidecar_disabled:
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=false \
				--set traefik-proxy.enabled=false \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar disabled with set custom image version
helm_upgrade_dry_run_sidecar_disabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=false \
				--set traefik-proxy.enabled=false \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG \
				--create-namespace -n football-clubs-ns

# Helm template sidecar enabled
helm_template_sidecar_enabled:
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.proxyAppSidecarEnabled=true

# Helm upgrade sidecar enabled
helm_upgrade_sidecar_enabled:
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.proxyAppSidecarEnabled=true \
				--create-namespace -n football-clubs-ns

# Helm template sidecar enabled with set custom image tag
helm_template_sidecar_enabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.proxyAppSidecarEnabled=true \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG

# Helm upgrade dry-run sidecar enabled
helm_upgrade_dry_run_sidecar_enabled:
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.enabled=true \
				--create-namespace -n football-clubs-ns

# Helm upgrade sidecar enabled with set custom image tag
helm_upgrade_sidecar_enabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar enabled with set custom image tag
helm_upgrade_dry_run_sidecar_enabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG \
				--create-namespace -n football-clubs-ns

# Helm template sidecar disabled (only football-clubs-app)
helm_template_only_football_clubs_app_sidecar_disabled:
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set traefik-proxy.enabled=false

# Helm template sidecar disabled with set custom image tag (only football-clubs-app)
helm_template_only_football_clubs_app_sidecar_disabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set traefik-proxy.enabled=false \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG

# Helm upgrade sidecar disabled (only football-clubs-app)
helm_upgrade_only_football_clubs_app_sidecar_disabled:
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=false \
				--set traefik-proxy.enabled=false \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar disabled (only football-clubs-app)
helm_upgrade_dry_run_only_football_clubs_app_sidecar_disabled:
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=false \
				--set traefik-proxy.enabled=false \
				--create-namespace -n football-clubs-ns

# Helm upgrade sidecar disabled with set custom image tag (only football-clubs-app)
helm_upgrade_only_football_clubs_app_sidecar_disabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=false \
				--set traefik-proxy.enabled=false \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar disabled with set custom image tag (only football-clubs-app)
helm_upgrade_dry_run_only_football_clubs_app_sidecar_disabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=false \
				--set traefik-proxy.enabled=false \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG \
				--create-namespace -n football-clubs-ns

# Helm template sidecar enabled (only football-clubs-app)
helm_template_only_football_clubs_app_sidecar_enabled:
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.enabled=false

# Helm template sidecar enabled with set custom image tag (only football-clubs-app)
helm_template_only_football_clubs_app_sidecar_enabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.enabled=false \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG

# Helm upgrade sidecar enabled (only football-clubs-app)
helm_upgrade_only_football_clubs_app_sidecar_enabled:
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.enabled=false \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar enabled (only football-clubs-app)
helm_upgrade_dry_run_only_football_clubs_app_sidecar_enabled:
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.enabled=false \
				--create-namespace -n football-clubs-ns

# Helm upgrade sidecar enabled with set custom image tag (only football-clubs-app)
helm_upgrade_only_football_clubs_app_sidecar_enabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.enabled=false \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar disabled with set custom image tag (only football-clubs-app)
helm_upgrade_dry_run_only_football_clubs_app_sidecar_enabled_with_custom_image_tag:
				echo Input custom image_tag.
				echo Example: \"1.0.0\"
				read IMAGE_TAG; \
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.traefikSidecarEnabled=true \
				--set traefik-proxy.enabled=false \
				--set global.footballClubsAppImageVersion=$$IMAGE_TAG \
				--create-namespace -n football-clubs-ns

# Helm template sidecar disabled (only traefik-proxy)
helm_template_only_traefik_proxy_sidecar_disabled:
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.enabled=false

# Helm upgrade sidecar disabled (only traefik-proxy)
helm_upgrade_only_traefik_proxy_sidecar_disabled:
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.enabled=false \
				--set traefik-proxy.proxyAppSidecarEnabled=false \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar disabled (only traefik-proxy)
helm_upgrade_dry_run_only_traefik_proxy_sidecar_disabled:
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.enabled=false \
				--set traefik-proxy.proxyAppSidecarEnabled=false \
				--create-namespace -n football-clubs-ns

# Helm template sidecar enabled (only traefik-proxy)
helm_template_only_traefik_proxy_sidecar_enabled:
				helm template football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.enabled=false \
				--set traefik-proxy.proxyAppSidecarEnabled=true

# Helm upgrade sidecar enabled (only traefik-proxy)
helm_upgrade_only_traefik_proxy_sidecar_enabled:
				helm upgrade --install football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.enabled=false \
				--set traefik-proxy.proxyAppSidecarEnabled=true \
				--create-namespace -n football-clubs-ns

# Helm upgrade dry-run sidecar enabled (only traefik-proxy)
helm_upgrade_dry_run_only_traefik_proxy_sidecar_enabled:
				helm upgrade --install --dry-run --debug football-clubs-chart deploy/helmchart/football-clubs-chart \
				--set football-clubs-app.enabled=false \
				--set traefik-proxy.proxyAppSidecarEnabled=true \
				--create-namespace -n football-clubs-ns