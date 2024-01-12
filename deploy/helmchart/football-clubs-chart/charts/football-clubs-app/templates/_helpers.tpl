{{/*
Define AppVersion Template
*/}}
{{- define "football-clubs-app.application-version" }}
{{- printf .Values.global.footballClubsAppImageVersion | default .Chart.AppVersion }}
{{- end }}
{{/*
Define chart labels
*/}}
{{- define "football-clubs-app.labels" }}
{{- include "football-clubs-chart.main-labels" . }}
chartAppVersion: {{ template "football-clubs-app.application-version" . }}
{{- if .Values.traefikSidecarEnabled}}
traefikVersion: {{ .Values.global.traefikProxyImageVersion }}
{{- end }}
{{- end }}