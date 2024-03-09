# Football clubs 

This helm chart install application  football clubs on kubernetes.
Helm chart also install additional infrastructure software.

## Base helm command's for work with chart

### Install chart

    helm install [RELEASE_NAME] football-clubs-chart [flags]

### Uninstall chart

    helm uninstall [RELEASE_NAME] football-clubs-chart [flags]

### Upgrade chart

    helm upgrade [RELEASE_NAME] football-clubs-chart [flags]

### Upgrade chart with first install if chart dont't present in namespace

    helm upgrade --install [RELEASE_NAME] football-clubs-chart [flags]

### Helm template (generate template without install)

    helm template [RELEASE_NAME] football-clubs-chart [flags]

### Helm dry-run (generate all template without install)

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart [flags]

## Available variants for work with chart:

# Helm template

Helm template football-clubs-chart sidecar traefik-proxy disabled:

    helm template [RELEASE_NAME] football-clubs-chart

Helm template football-clubs-chart sidecar traefik-proxy disabled 
with set custom image (with application) tag:

    helm template [RELEASE_NAME] football-clubs-chart \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG]

Helm template football-clubs-chart sidecar traefik-proxy disabled (only football-clubs-app subchart):

    helm template [RELEASE_NAME] football-clubs-chart \
        --set traefik-proxy.enabled=false

Helm template football-clubs-chart sidecar traefik-proxy disabled
with set custom image (with application) tag (only football-clubs-app subchart):

    helm template [RELEASE_NAME] football-clubs-chart \
        --set traefik-proxy.enabled=false \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG]

Helm template football-clubs-chart sidecar traefik-proxy disabled (only traefik-proxy):

    helm template [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.enabled=false

Helm template football-clubs-chart sidecar traefik-proxy enabled:

    helm template [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.proxyAppSidecarEnabled=true

Helm template football-clubs-chart sidecar traefik-proxy enabled 
with set custom image (with application) tag:

    helm template [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.proxyAppSidecarEnabled=true \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG]

Helm template football-clubs-chart sidecar traefik-proxy enabled (only football-clubs-app subchart):

    helm template [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.enabled=false

Helm template football-clubs-chart sidecar traefik-proxy enabled
with set custom image (with application) tag (only football-clubs-app subchart):

    helm template [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.enabled=false \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG]

Helm template football-clubs-chart sidecar traefik-proxy enabled (only traefik-proxy):

    helm template [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.enabled=false \
        --set traefik-proxy.proxyAppSidecarEnabled=true

# Helm upgrade dry-run

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy disabled:

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=false \
        --set traefik-proxy.enabled=false \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy disabled
with set custom image (with application) tag:

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=false \
        --set traefik-proxy.enabled=false \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG] \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy disabled (only football-clubs-app):

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=false \
        --set traefik-proxy.enabled=false \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy disabled
with set custom image (with application) tag (only football-clubs-app):

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=false \
        --set traefik-proxy.enabled=false \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG] \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy disabled (only traefik-proxy):

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.enabled=false \
        --set traefik-proxy.proxyAppSidecarEnabled=false \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy enabled:

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.enabled=true \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy enabled
with set custom image (with application) tag:

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG] \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy enabled (only football-clubs-app):

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.enabled=false \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy enabled
with set custom image (with application) tag (only football-clubs-app):

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.enabled=false \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG] \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade dry-run football-clubs-chart sidecar traefik-proxy enabled (only traefik-proxy):

    helm upgrade --install --dry-run --debug [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.enabled=false \
        --set traefik-proxy.proxyAppSidecarEnabled=true \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

# Helm upgrade

Helm upgrade football-clubs-chart sidecar traefik-proxy disabled:

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=false \
        --set traefik-proxy.proxyAppSidecarEnabled=false \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy disabled
with set custom image (with application) tag

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=false \
        --set traefik-proxy.enabled=false \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG] \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy disabled (only football-clubs-app):

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=false \
        --set traefik-proxy.enabled=false \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy disabled 
with set custom image (with application) tag (only football-clubs-app):

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=false \
        --set traefik-proxy.enabled=false \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG] \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy disabled (only traefik-proxy):

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.enabled=false \
        --set traefik-proxy.proxyAppSidecarEnabled=false \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy enabled:

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.proxyAppSidecarEnabled=true \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy enabled
with set custom image (with application) tag:

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.proxyAppSidecarEnabled=true \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG] \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy enabled (only football-clubs-app):

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.enabled=false \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy enabled
with set custom image (with application) tag (only football-clubs-app):

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.traefikSidecarEnabled=true \
        --set traefik-proxy.enabled=false \
        --set global.footballClubsAppImageVersion=[IMAGE_TAG] \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

Helm upgrade football-clubs-chart sidecar traefik-proxy enabled (only traefik-proxy):

    helm upgrade --install [RELEASE_NAME] football-clubs-chart \
        --set football-clubs-app.enabled=false \
        --set traefik-proxy.proxyAppSidecarEnabled=true \
        --create-namespace -n [KUBERNETES_APP_NAMESPACE]

## Configuration helm chart
Configuration parameters sets in files values.yaml or may set's in command line

# Settings for subcharts (deploy/helmchart/football-clubs-chart/values.yaml)

    football-clubs-app:
      enabled: [true|false]
      traefikSidecarEnabled: [true|false]
    traefik-proxy:
      enabled: [true|false]
      proxyAppSidecarEnabled: [true|false]

# Global settings (deploy/helmchart/football-clubs-chart/values.yaml)
    
    global:
      footballClubsAppImageVersion: [ImageTag]
      systemNamespace: [NamespaceName]
      traefikProxyImageVersion: [ImageTag]

# Football-clubs-app chart settings (deploy/helmchart/football-clubs-chart/football-clubs-app/values.yaml)

    replicasCount: [CountPodsReplicas]
    appPort: [PortNumber]
    appResources:
      requests:
        cpu: [CpuMillicore]
        memory: [MemoryVolume]
      limits:
        cpu: [CpuMillicore]
        memory: [MemoryVolume]
    appImageRegistry: [ImageRegistryName]
    appImageName: [ImageName]
    appEnv:
      UVICORN_PORT: [PortNumber]
    traefikSidecarImageName: [ImageName]
    traefikSidecarEnabled: [true|false]
    traefikSidecarPort: [PortNumber]
    traefikSidecarDashboardPort: [PortNumber]
    traefikSidecarConfigsPath: [AbsoluteFileSystemPath]
    traefikSidecarResources:
      requests:
        cpu: [CpuMillicore]
        memory: [MemoryVolume]
      limits:
        cpu: [CpuMillicore]
        memory: [MemoryVolume]

# Traefik-proxy chart settings (deploy/helmchart/football-clubs-chart/traefik-proxy/values.yaml)

    traefikImageName: [ImageName]
    traefikReplicasCount: [CountPodsReplicas]
    traefikProxyPort: [PortNumber]
    traefikProxyDashboardPort: [PortNumber]
    traefikConfigPath: [AbsoluteFileSystemPath]
    resources:
      requests:
        cpu: [CpuMillicore]
        memory: [MemoryVolume]
      limits:
        cpu: [CpuMillicore]
        memory: [MemoryVolume]
    proxyAppSrvName: [ServiceName]
    proxyAppNs: [NamespaceName]
    proxyAppSidecarEnabled: [true|false]
    proxyAppPort: [PortNumber]
    proxyAppWithSidecarPort: [PortNumber]


    

