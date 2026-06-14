{{/*
Base name for all resources. Override with `fullnameOverride`.
*/}}
{{- define "outline.fullname" -}}
{{- .Values.fullnameOverride | default "outline" -}}
{{- end -}}

{{/*
Common labels / selector label value.
*/}}
{{- define "outline.name" -}}
{{- include "outline.fullname" . -}}
{{- end -}}

{{/*
Name of the shared secret holding generated keys
(SECRET_KEY, UTILS_SECRET, S3_SECRET_KEY, OIDC client secret).
*/}}
{{- define "outline.secretName" -}}
{{- .Values.secret.name | default (printf "%s-secret" (include "outline.fullname" .)) -}}
{{- end -}}

{{/*
Name of the secret holding the OIDC client secret. Defaults to the shared secret.
*/}}
{{- define "outline.oidcSecretName" -}}
{{- .Values.oidc.secret.name | default (include "outline.secretName" .) -}}
{{- end -}}

{{/*
Name of the secret holding the database connection URL.
Defaults to the CNPG-generated "<cluster>-app" secret.
*/}}
{{- define "outline.dbSecretName" -}}
{{- .Values.database.secret.name | default (printf "%s-postgresql-app" (include "outline.fullname" .)) -}}
{{- end -}}

{{/*
Name of the CNPG postgres cluster.
*/}}
{{- define "outline.postgresName" -}}
{{- printf "%s-postgresql" (include "outline.fullname" .) -}}
{{- end -}}

{{/*
Redis connection URL. Defaults to the bundled valkey service.
*/}}
{{- define "outline.redisUrl" -}}
{{- .Values.redis.url | default (printf "redis://%s-redis-valkey:6379" (include "outline.fullname" .)) -}}
{{- end -}}

{{/*
S3/MinIO endpoint URL. Defaults to the bundled minio service.
*/}}
{{- define "outline.s3Endpoint" -}}
{{- .Values.storage.s3.endpoint | default (printf "http://%s-s3-minio:9000" (include "outline.fullname" .)) -}}
{{- end -}}

{{/*
Bundled MinIO service name (used by the s3 ingress host).
*/}}
{{- define "outline.minioService" -}}
{{- printf "%s-s3-minio" (include "outline.fullname" .) -}}
{{- end -}}
