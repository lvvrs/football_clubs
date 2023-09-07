{{/*
Define default labels
*/}}
{{- define "football_clubs.default_labels" }}
chartName: {{ .Chart.Name }}
chartVersion: {{ .Chart.Version }}
appVersion: {{ .Chart.AppVersion }}
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