{{/*
Define chart labels
*/}}
{{- define "traefic-proxy.default-labels" }}
{{- include "football-clubs-chart.main-labels" . }}
appVersion: {{ .Chart.AppVersion }}
traefikVersion: {{ .Values.global.traefikProxyImageVersion }}
{{- end }}
{{/*
Define app service template
*/}}
{{- define "traefic-proxy.proxy-application-service-template" }}
{{- if eq .Values.proxyAppSidecarEnabled false }}
{{- printf "http://%s.%s.svc.cluster.local:%s" .Values.proxyAppSrvName .Values.proxyAppNs ( .Values.proxyAppPort | toString ) -}}
{{- else }}
{{- printf "http://%s.%s.svc.cluster.local:%s" .Values.proxyAppSrvName .Values.proxyAppNs ( .Values.proxyAppWithSidecarPort | toString ) -}}
{{- end }}
{{- end }}