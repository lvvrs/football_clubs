{{/*
Define default labels
*/}}
{{- define "traefic-proxy.default-labels" }}
chartName: {{ .Chart.Name }}
chartVersion: {{ .Chart.Version }}
appVersion: {{ .Chart.AppVersion }}
traefikVersion: {{ .Values.traefikImageTag }}
{{- end }}
{{/*
Define app resources configuration
*/}}
{{- define "traefic-proxy.container-resources" }}
requests:
  cpu: {{ .Values.traefikResources.requestsCpu }}
  memory: {{ .Values.traefikResources.requestsMemory }}
limits:
  cpu: {{ .Values.traefikResources.limitsCpu }}
  memory: {{ .Values.traefikResources.limitsMemory }}
{{- end }}
{{/*
Define app service template
*/}}
{{- define "traefic-proxy.proxy-application-service-template" }}
{{- if eq .Values.proxyAppSidecarEnable false }}
{{- printf "http://%s.%s.svc.cluster.local:%s" .Values.proxyAppSrvName .Values.proxyAppNs ( .Values.proxyAppPort | toString ) -}}
{{- else }}
{{- printf "http://%s.%s.svc.cluster.local:%s" .Values.proxyAppSrvName .Values.proxyAppNs ( .Values.proxyAppWithSidecarPort | toString ) -}}
{{- end }}
{{- end }}