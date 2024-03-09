{{/*
Expand the name of the chart.
*/}}
{{- define "test-go-app-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default app name for the test-go-app.
*/}}
{{- define "test-go-app.name" -}}
{{- printf "%s" .Chart.Name }}
{{- end }}

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
