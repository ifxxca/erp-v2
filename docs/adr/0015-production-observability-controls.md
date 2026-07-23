# ADR-0015: Production Observability Controls

Status: Accepted

## Decision

Observability foundation tetap vendor-neutral pada application boundary:

- liveness hanya membuktikan process dapat melayani request;
- readiness memeriksa database, cache, queue backend, dan object storage tanpa membuka detail exception;
- metrics operasional diekspor dalam Prometheus text format melalui endpoint internal dengan bearer token khusus;
- HTTP completion, worker, readiness failure, dan threshold breach ditulis sebagai structured JSON ke stderr dengan request/correlation context;
- scheduler mengevaluasi batas backlog age/count, dead letter, delivery, dan failed jobs setiap menit;
- dead-letter recovery hanya melalui application service/Artisan command yang mengunci record, mempertahankan attempt history, membuka retry cycle baru, dan menulis audit operator serta reason.

Metrics memakai label tetap dan cardinality rendah. ID user, company, message, atau file tidak menjadi label. Request body, token, secret, object key, dan exception message tidak masuk telemetry. Request latency/error dapat dibentuk collector dari event `HTTP request completed`; state gauge asynchronous tersedia langsung untuk Prometheus scraping.

## Consequence

- Load balancer/orchestrator dapat membedakan process hidup dari dependency siap.
- Endpoint metrics tidak menerima employee bearer token dan tetap harus dibatasi pada network internal.
- Application tidak terikat pada Prometheus/Grafana/Loki/Sentry tertentu; environment production wajib memilih collector, retention, dashboard, dan paging integration.
- Readiness melakukan cache round-trip dan read-only object-storage probe; probe harus diberi timeout pada infrastructure/client layer.
- Scheduled checker menghasilkan structured alert candidate, bukan mengirim pesan langsung ke manusia. Collector/alert manager bertanggung jawab atas deduplication, routing, silence, dan escalation.
- Re-drive tidak menghapus atau menomori ulang attempt lama. Total attempt terus naik, sementara `attempts_in_cycle` di-reset agar recovery mempunyai retry budget baru.
- Re-drive tidak boleh dilakukan sebelum penyebab utama diperbaiki dan payload diperiksa. Perubahan payload/status manual di database dilarang.
