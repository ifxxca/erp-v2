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
- Nginx API gateway: `localhost:8000`
- API liveness/readiness through gateway: `localhost:8000/api/v1/health/live|ready`
- Protected metrics: `localhost:8000/api/v1/internal/metrics`

Credential pada `.env.example` hanya untuk local development dan tidak boleh digunakan pada environment bersama.

Full API suite pada PostgreSQL terisolasi dijalankan dari root workspace dengan `powershell -File infrastructure/test-postgres.ps1`. Script hanya mereset database khusus `rajawali_v2_test` dan memaksa queue/cache/session/file scan ke driver testing supaya tidak menyentuh state development.

PostgreSQL 18 memakai volume `postgres-data-v18` pada `/var/lib/postgresql`. Jangan mengubah mount kembali ke `/var/lib/postgresql/data`; layout image resmi 18 menyimpan cluster pada subdirectory major-version untuk mendukung upgrade yang aman.

API, worker, dan scheduler menulis JSON log ke stderr. `OBSERVABILITY_METRICS_TOKEN` pada contoh environment hanya untuk local development; shared/staging/production wajib mengambil token berbeda dari secret manager dan membatasi metrics endpoint pada private network. Runbook lengkap tersedia di [docs/13-OBSERVABILITY-RUNBOOK.md](../docs/13-OBSERVABILITY-RUNBOOK.md).

API development server hanya diekspos pada network Compose; host mengaksesnya melalui Nginx. Boundary ini menghindari perbedaan port-forward Docker Desktop terhadap PHP built-in server dan sekaligus memberi baseline reverse-proxy yang dekat dengan deployment non-local. `API_PORT` dapat dioverride bila port `8000` dipakai service lain.
