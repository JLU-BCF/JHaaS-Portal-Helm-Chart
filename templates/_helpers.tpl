{{- define "tfConfig" }}
{{- with .Values.terraform }}
{{- printf "credentials \"%s\" { token = \"%s\" }" .host .token | b64enc | quote }}
{{- end }}
{{- end }}

{{- define "s3MinioConfig" }}
{{- with .Values.s3 }}
{
  "aliases": {
    "s3": {
        "url": "{{ printf "%s://%s:%s" (.ssl | ternary "https" "http") .host .port }}",
        "accessKey": "{{ .access_key }}",
        "secretKey": "{{ .secret_key }}",
        "api": "{{ .api }}"
    }
  }
}
{{- end }}
{{- end }}

{{- define "s3GenericConfig" }}
{{- with .Values.s3 }}
[s3]
type = s3
provider = Other
env_auth = false
access_key_id = {{ .access_key }}
secret_access_key = {{ .secret_key }}
region =
endpoint = {{ printf "%s://%s:%s" (.ssl | ternary "https" "http") .host .port }}
location_constraint =
acl =
server_side_encryption =
storage_class =
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "..name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
