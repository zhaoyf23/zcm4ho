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
