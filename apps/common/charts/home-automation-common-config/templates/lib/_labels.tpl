{{/* Common labels shared across objects */}}
{{- define "home-automation-common-config.labels" -}}
helm.sh/chart: {{ include "home-automation-common-config.names.chart" . }}
{{ include "home-automation-common-config.labels.selectorLabels" . }}
  {{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* Selector labels shared across objects */}}
{{- define "home-automation-common-config.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "home-automation-common-config.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}