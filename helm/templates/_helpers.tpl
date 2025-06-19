{{/*
Expand the name of the chart.
*/}}
{{- define "jtl-reporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jtl-reporter.fullname" -}}
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
Create a unique full name for a specific service by suffix
Usage: {{ include "fe.fullname" . }}
*/}}

{{- define "fe.fullname" -}}
{{- printf "%s-fe" (include "jtl-reporter.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "be.fullname" -}}
{{- printf "%s-be" (include "jtl-reporter.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "db.fullname" -}}
{{- printf "%s-db" (include "jtl-reporter.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "listener.fullname" -}}
{{- printf "%s-listener" (include "jtl-reporter.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "scheduler.fullname" -}}
{{- printf "%s-scheduler" (include "jtl-reporter.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "migration.fullname" -}}
{{- printf "%s-migration" (include "jtl-reporter.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "jtl-reporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "jtl-reporter.labels" -}}
helm.sh/chart: {{ include "jtl-reporter.chart" . }}
serviceOwner: {{ .Values.serviceOwner }}
{{ include "jtl-reporter.componentSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "jtl-reporter.componentSelectorLabels" -}}
app: {{ include "jtl-reporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .component }}
app.kubernetes.io/name: {{ .component }}
{{- else }}
app.kubernetes.io/name: {{ include "jtl-reporter.name" . }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "jtl-reporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "jtl-reporter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
