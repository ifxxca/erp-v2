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

Credential pada `.env.example` hanya untuk local development dan tidak boleh digunakan pada environment bersama.
