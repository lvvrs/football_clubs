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
    11) TraefikProxy for emulate production work application behinde reverse proxy
    12) Kubernetes for run and orchestrating Application
    13) Helm for install Aplication on Kubernetes


## Makefile
The Make utility is used to manage project locally.
The project contains a Makefile with commands to perform actions.

## Makefile Variables

      SLEEP_TIME = [TimeForSleepCommandInSeconds]
      IMAGE_NAME = [ImageNameApplicationForWork]
      CONTAINER_NAME = [ContainerNameForRun]
      APPLICATION_HTTP_PORT = [ApplicationHttpPort]
      DOCKER_REGISTRY = [DockerRegistryName]
      DOCKER_USER = [DockerRegistryUsername]
      PROXY_CONTAINER_NAME = [TraefikProxyContainerName]
      KUBERNETES_APP_NAMESPACE = [KybernetesNamepspaceName]
      HELM_FOOTBALL_CLUBS_APP_IMAGE_TAG = [ImageTagApplicationForWork]
      HELM_RELEASE_NAME = [HelmReleaseName]
      HELM_CHART_PATH = [PathToHelmChart]
      HELM_CHART_NAME = []HelmChartName]

### Makefile command's description

#### Support command's for work
    1) sleep_step - step run's command sleep for wait results actions

#### Commands work's in virtualenv
    1) run_app_uvicorn - local run app
    2) unit_tests_app - run unit test's with pytest util
    3) freeze_dependencies - generate requirements.txt file with application dependencies

#### Commands work's global
    1) docker_build_app - run build docker image with application
    2) docker_run_app - run docker container
    3) docker_build_and_run_app - consists of commands: docker_build_app and docker_run_app
    4) docker_list_running_containers - check container status (docker ps -a)
    5) docker_logs_app - check application logs from container
    6) docker_list_running_containers_and_logs_app - consists of commands: docker_list_running_containers and docker_logs_app
    7) docker_build_run_status_logs_app - consists of commands: docker_build_and_run_app sleep_step docker_list_running_containers_and_logs_app
    8) docker_down_app - stop and remove docker container
    9) docker_create_tag - set docker tag for image
    10) docker_hub_login - login to dockerhub
    11) docker_hub_push - push image to dockerhub
    12) docker_rmi - untagged or remove image
    13) docker_pull - pull image from docker hub
    14) docker_list_images - list docker images on local pc
    15) docker_compose_build - build image with docker-compose
    16) docker_compose_build_and_run_app - run appication with docker compose, create network, consists command docker_compose_build
    17) docker_compose_build_and_run_app_with_traefik_proxy - run appication and traefik proxy with docker compose, create network, consists command docker_compose_build
    18) docker_compose_down - stop and delete application container with docker-compose
    19) kubernetes_helm_uninstall - uninstall helm chart with application from local kubernetes (delete kubernetes namespace with application)
    20) helm_template_sidecar_disabled - helm template chart when sidecar disabled
    21) helm_template_sidecar_enabled - helm template chart when sidecar enabled
    22) helm_upgrade_sidecar_disabled - install application on local kubernetes cluster with helm when sidecar disabled
    23) helm_upgrade_sidecar_enabled - install application on local kubernetes cluster with helm when sidecar enabled

## Run Application with Docker
Application run in docker container.
Docker container available on dockerhub: 
https://hub.docker.com/repository/docker/skay1989/football_clubs/general

#### Command for run application in docker container:

    docker run -d --name football_clubs_app --env UVICORN_PORT=8080 -p 8080:8080 football_clubs

#### Environment variables:

    UVICORN_PORT - set http port for application (default 80)
    UVICORN_HOST - set host for application (default 0.0.0.0)

### Run Application with Docker-Compose
Application run with docker-compose in 2 modes:

    1) Without reverse proxy - docker_compose_build_and_run_app in Makefile
    2) With reverse proxy - docker_compose_build_and_run_app_with_traefik_proxy in Makefile

Traefik was chosen as a reverse proxy (Traefik Proxy)

### Traefik Proxy
Configuration for Traefik Proxy store in directory: infra/traefik_proxy_config.
Configuration files:

    1) traefik.toml  or traefik.yml - contain main settings
    2) routes.toml or routes.yml - contain routes settings

### Run Application with Helm on local Kubernetes cluster
Application may be install on local single node Kubernetes cluster.
Example: Docker Desktop with enable Kubernetes.
Install on Kubernetes using helm chart. Helm chart is located along the way: deploy/helmchart/football-clubs-chart

Helm chart contains subcharts:
1) football-clubs-app - install application football clubs with or without traefik proxy install
2) traefik-proxy - install traefik proxy for redirect requests to application pod's

#### Command for install application with helm chart:

    Install on local kubernetes cluster (helm_upgrade_sidecar_disabled in Makefile):
        helm upgrade --install $(HELM_RELEASE_NAME) $(HELM_CHART_PATH)/$(HELM_CHART_NAME) \
		  --set football-clubs-app.traefikSidecarEnabled=false \
		  --set traefik-proxy.proxyAppSidecarEnabled=false \
		  --set global.footballClubsAppImageVersion=$(HELM_FOOTBALL_CLUBS_APP_IMAGE_TAG) \
		  --create-namespace -n $(KUBERNETES_APP_NAMESPACE)

    Install on local kubernetes cluster with traefik proxy (helm_upgrade_sidecar_enabled in Makefile):
        helm upgrade --install $(HELM_RELEASE_NAME) $(HELM_CHART_PATH)/$(HELM_CHART_NAME) \
		  --set football-clubs-app.traefikSidecarEnabled=true \
		  --set traefik-proxy.proxyAppSidecarEnabled=true \
		  --set global.footballClubsAppImageVersion=$(HELM_FOOTBALL_CLUBS_APP_IMAGE_TAG) \
		  --create-namespace -n $(KUBERNETES_APP_NAMESPACE)
    
    Delete form local kubernetes cluster (kubernetes_helm_uninstall in Makefile):
        kubectl delete ns $(KUBERNETES_APP_NAMESPACE)

## Local Development and Testing results

### Port-Forward's when install project with helm on local kubernetes without ingress controller

1) When application install without traefik proxy: 

        kubectl port-forward service/football-clubs-svc 8090:8090 -n football-clubs-ns

2) When application install with traefik proxy sidecar:

        kubectl port-forward service/football-clubs-svc 9090:9090 -n football-clubs-ns

3) When application install with traefik proxy sidecar and traefik proxy application:

        kubectl port-forward service/traefik-proxy-svc 9090:9090 -n football-clubs-ns

    