{{/*
Define default labels
*/}}
{{- define "football_clubs.default_labels" }}
chartName: {{ .Chart.Name }}
chartVersion: {{ .Chart.Version }}
appVersion: {{ .Chart.AppVersion }}
{{- if .Values.traefikSidecarEnabled}}
traefikVersion: {{ .Values.traefikSidecarImageTag }}
{{- end }}
{{- end }}
{{/*
Define app resources configuration
*/}}
{{- define "football_clubs.application_resources" }}
requests:
  cpu: {{ .Values.appResources.requestsCpu }}
  memory: {{ .Values.appResources.requestsMemory }}
limits:
  cpu: {{ .Values.appResources.limitsCpu }}
  memory: {{ .Values.appResources.limitsMemory }}
{{- end }}
{{/*
Define traefik sidecar resources configuration
*/}}
{{- define "football_clubs.traefik_sidecar_resources" }}
requests:
  cpu: {{ .Values.traefikSidecatResources.requestsCpu }}
  memory: {{ .Values.traefikSidecatResources.requestsMemory }}
limits:
  cpu: {{ .Values.traefikSidecatResources.limitsCpu }}
  memory: {{ .Values.traefikSidecatResources.limitsMemory }}
{{- end }}