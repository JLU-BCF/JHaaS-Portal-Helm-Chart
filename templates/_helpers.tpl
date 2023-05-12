{{- define "imagePullSecret" }}
{{- with .Values.imageCredentials }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password (printf "%s:%s" .username .password | b64enc) | b64enc | quote }}
{{- end }}
{{- end }}

{{- define "tfConfig" }}
{{- with .Values.terraform }}
{{- printf "credentials \"%s\" { token = \"%s\" }" .host .token | b64enc | quote }}
{{- end }}
{{- end }}

{{- define "s3Config" }}
{{- with .Values.s3 }}
{{- printf "{ \"aliases\": { \"s3\": { \"url\": \"%s://%s:%s\", \"accessKey\": \"%s\", \"secretKey\": \"%s\" } } }" (.ssl | ternary "https" "http") .host .port .access_key .secret_key | b64enc | quote }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "..name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
