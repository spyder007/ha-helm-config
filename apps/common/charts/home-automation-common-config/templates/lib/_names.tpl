{{/* Expand the name of the chart */}}
{{- define "home-automation-common-config.names.name" -}}
  {{- $globalNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalNameOverride = (default $globalNameOverride .Values.global.nameOverride) -}}
  {{- end -}}
  {{- default .Chart.Name (default .Values.nameOverride $globalNameOverride) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "home-automation-common-config.names.fullname" -}}
  {{- $name := include "home-automation-common-config.names.name" . -}}
  {{- $globalFullNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalFullNameOverride = (default $globalFullNameOverride .Values.global.fullnameOverride) -}}
  {{- end -}}
  {{- if or .Values.fullnameOverride $globalFullNameOverride -}}
    {{- $name = default .Values.fullnameOverride $globalFullNameOverride -}}
  {{- else -}}
    {{- if contains $name .Release.Name -}}
      {{- $name = .Release.Name -}}
    {{- else -}}
      {{- $name = printf "%s-%s" .Release.Name $name -}}
    {{- end -}}
  {{- end -}}
  {{- trunc 63 $name | trimSuffix "-" -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label */}}
{{- define "home-automation-common-config.names.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create the name of the ServiceAccount to use */}}
{{- define "home-automation-common-config.names.serviceAccountName" -}}
  {{- if .Values.serviceAccount.create -}}
    {{- default (include "home-automation-common-config.names.fullname" .) .Values.serviceAccount.name -}}
  {{- else -}}
    {{- default "default" .Values.serviceAccount.name -}}
  {{- end -}}
{{- end -}}

{{/* Return the properly cased version of the controller type */}}
{{- define "home-automation-common-config.names.controllerType" -}}
  {{- if eq .Values.controller.type "deployment" -}}
    {{- print "Deployment" -}}
  {{- else if eq .Values.controller.type "daemonset" -}}
    {{- print "DaemonSet" -}}
  {{- else if eq .Values.controller.type "statefulset"  -}}
    {{- print "StatefulSet" -}}
  {{- else -}}
    {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) -}}
  {{- end -}}
{{- end -}}
