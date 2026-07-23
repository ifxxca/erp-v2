# Observability and Recovery Runbook

Status: implementation baseline 2026-07-23.

## Health contract

| Endpoint | Tujuan | Dependency | Status gagal |
|---|---|---|---|
| `GET /api/v1/health/live` | process liveness | tidak ada | process/network tidak merespons |
| `GET /api/v1/health/ready` | traffic readiness | database, cache, queue, object storage | HTTP 503 dan check `down` |
| `GET /api/v1/internal/metrics` | Prometheus scrape | database | HTTP 401/503 |

Readiness hanya mengembalikan nama check, `up/down`, dan latency. Exception class masuk structured log; credential, host detail, dan exception message tidak masuk response. Docker healthcheck memakai readiness. Kubernetes/load balancer sebaiknya memakai liveness untuk restart dan readiness untuk traffic routing.

Metrics endpoint wajib memakai `Authorization: Bearer <OBSERVABILITY_METRICS_TOKEN>`. Token minimal 32 karakter, berbeda dari access token user, berasal dari secret manager, dan endpoint dibatasi lagi pada private network/security group. Application menolak boot pada environment production bila token ini hilang atau terlalu pendek.

## Metrics dan alert baseline

| Metric | Default alert |
|---|---:|
| `rajawali_outbox_messages{status="pending"}` | `>= 100` |
| `rajawali_outbox_oldest_pending_seconds` | `>= 300` detik |
| `rajawali_outbox_messages{status="dead_letter"}` | `>= 1`, critical |
| `rajawali_notification_deliveries{status="pending"}` | `>= 100` |
| `rajawali_notification_delivery_oldest_pending_seconds` | `>= 300` detik |
| `rajawali_notification_deliveries{status="dead_letter"}` | `>= 1`, critical |
| `rajawali_queue_jobs{status="failed"}` | `>= 1`, critical |

Gauge tambahan meliputi queued jobs, pending privileged-access request, dan quarantined files. Threshold dikonfigurasi melalui environment `OBSERVABILITY_*`. Command `php artisan observability:check` menjalankan evaluasi yang sama; scheduler menjalankannya setiap menit dan menulis `Operational threshold breached.` ke structured log.

HTTP latency/error berasal dari event `HTTP request completed.` dengan `request_id`, method, route template, status, `duration_ms`, user ID, dan company ID bila tersedia. Jangan menambahkan request body, authorization header, token, password, TOTP, invitation/reset secret, signed URL, atau object key ke context.

## Triage outbox

1. Periksa dead-letter count, oldest pending age, queue worker, scheduler, Redis, dan database readiness.
2. Ambil `outbox_messages.last_error_code`, event type, aggregate reference, request ID, serta attempt history. Jangan menyalin payload sensitif ke ticket/chat.
3. Perbaiki handler/config/dependency terlebih dahulu.
4. Re-drive tepat satu message dengan ticket/reason yang dapat diaudit:

```powershell
php artisan outbox:redrive 01EXAMPLEULID00000000000000 --reason="Provider mapping fixed under OPS-1234" --operator="operator@company"
```

5. Pastikan status menjadi `processed`, attempt baru tercatat, backlog turun, dan tidak ada side effect duplikat.

Unknown/unregistered handler tidak dapat di-re-drive. Payload invalid akan kembali dead letter; payload tidak boleh diedit manual.

## Triage notification delivery

1. Pastikan inbox internal sudah ada; failure mail tidak membatalkan inbox atau transaksi bisnis.
2. Validasi credential/provider connectivity dan periksa `last_error_code` serta attempt history.
3. Setelah dependency pulih, jalankan:

```powershell
php artisan notifications:redrive-delivery 01EXAMPLEULID00000000000000 --reason="SMTP connectivity restored under OPS-1235" --operator="operator@company"
```

4. Pastikan status `delivered`, provider reference bila tersedia, dan audit `platform.notification_delivery_redriven` tercatat.

Mail memiliki jaminan at-least-once. Bila provider menerima mail sebelum worker gagal menyimpan status, re-drive dapat mengirim duplikat. Operator wajib menilai risiko sebelum re-drive massal; command saat ini sengaja hanya menerima satu ID.

## Escalation dan production completion

- Warning backlog: owner platform/on-call melakukan triage pada jam operasional sesuai SLO.
- Critical dead letter/failed job/readiness: page on-call dan buat incident/ticket dengan request ID/error code, tanpa payload sensitif.
- Production belum lengkap sebelum collector, dashboard, alert manager/paging route, retention, access control, dan restore rehearsal diverifikasi pada environment nyata.
