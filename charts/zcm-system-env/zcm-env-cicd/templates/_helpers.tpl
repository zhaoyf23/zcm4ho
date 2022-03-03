{{/*
Expand the name of the chart.
*/}}
{{- define "zcm-env-cicd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "zcm-env-cicd.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "zcm-env-cicd.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zcm-env-cicd.labels" -}}
helm.sh/chart: {{ include "zcm-env-cicd.chart" . }}
{{ include "zcm-env-cicd.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zcm-env-cicd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "zcm-env-cicd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
zcm-app: {{ include "zcm-env-cicd.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "zcm-env-cicd.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "zcm-env-cicd.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}