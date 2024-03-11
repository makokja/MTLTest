{{/*
Expand the name of the chart.
*/}}
{{- define "test-go-app-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "test-go-app-chart.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Generate a fully qualified name for resources */}}
{{- define "MTLTest.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Generate a name for the application */}}
{{- define "MTLTest.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Generate labels for Kubernetes resources */}}
{{- define "MTLTest.labels" -}}
app.kubernetes.io/name: {{ include "MTLTest.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "test-go-app-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "test-go-app-chart.labels" -}}
helm.sh/chart: {{ include "test-go-app-chart.chart" . }}
{{ include "test-go-app-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Generate selector labels for Kubernetes resources */}}
{{- define "MTLTest.selectorLabels" -}}
app.kubernetes.io/name: {{ include "MTLTest.name" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "test-go-app-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "test-go-app-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "test-go-app-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "test-go-app-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
