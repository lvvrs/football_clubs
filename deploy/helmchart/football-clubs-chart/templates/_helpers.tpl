{{/*
Define main chart labels
*/}}
{{- define "football-clubs-chart.main-labels" }}
chartName: {{ .Chart.Name }}
chartVersion: {{ .Chart.Version }}
{{- end }}