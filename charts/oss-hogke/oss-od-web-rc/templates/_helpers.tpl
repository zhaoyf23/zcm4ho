{{/*
Expand the name of the chart.
*/}}
{{- define "zcm-tpl.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "zcm-tpl.fullname" -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" | default "zcm-tpl" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "zcm-tpl.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zcm-tpl.labels" -}}
helm.sh/chart: {{ include "zcm-tpl.chart" . }}
{{ include "zcm-tpl.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zcm-tpl.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.fullnameOverride }}
app: {{ .Values.fullnameOverride }}
{{- end }}
