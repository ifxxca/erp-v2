# Infrastructure

Planned infrastructure artifacts:

- local development containers;
- reverse proxy dan TLS;
- CI/CD pipelines;
- secrets management;
- database backup/restore;
- queue/cache/object storage;
- metrics, logs, traces, dan alerting;
- staging dan production environment definitions.

Tidak ada credential atau data produksi yang boleh disimpan di folder ini.

## Local dependencies

```powershell
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml up -d
```

Services:

- PostgreSQL: `localhost:5432`
- Redis: `localhost:6379`
- MinIO API/Console: `localhost:9000` / `localhost:9001`
- Mailpit SMTP/UI: `localhost:1025` / `localhost:8025`
- API liveness/readiness: `localhost:8000/api/v1/health/live|ready`
- Protected metrics: `localhost:8000/api/v1/internal/metrics`

Credential pada `.env.example` hanya untuk local development dan tidak boleh digunakan pada environment bersama.

API, worker, dan scheduler menulis JSON log ke stderr. `OBSERVABILITY_METRICS_TOKEN` pada contoh environment hanya untuk local development; shared/staging/production wajib mengambil token berbeda dari secret manager dan membatasi metrics endpoint pada private network. Runbook lengkap tersedia di [docs/13-OBSERVABILITY-RUNBOOK.md](../docs/13-OBSERVABILITY-RUNBOOK.md).
