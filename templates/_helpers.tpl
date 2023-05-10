{{- define "imagePullSecret" }}
{{- with .Values.imageCredentials }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}

{{- define "tfConfig" }}
{{- with .Values.terraform }}
{{- printf "credentials \"%s\" { token = \"%s\" }" .host .token | b64enc }}
{{- end }}
{{- end }}

{{- define "s3Config" }}
{{- with .Values.s3 }}
{{- printf "{ \"aliases\": { \"s3\": { \"url\": \"%s\", \"accessKey\": \"%s\", \"secretKey\": \"%s\" } } }" .url .access_key .secret_key | b64enc }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "..name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
