# Engineering Standards

## Architecture rules

- V2 dimulai sebagai modular monolith dengan boundary domain yang eksplisit.
- Module hanya mengakses domain module lain melalui public application contract, bukan query langsung ke tabel internal.
- Shared kernel dibatasi pada primitive lintas domain; business rule tidak boleh menjadi folder `helpers` global.
- Controller/handler hanya menangani transport, validation, authentication context, dan mapping response.
- Domain command mengelola transaction boundary dan invariant.
- Read model boleh dioptimalkan terpisah, tetapi tidak boleh menjadi sumber kebenaran transaksi.
- Dependency antar-module diperiksa dalam CI melalui architecture test.

## Struktur target konseptual

```text
apps/
  api/
  erp-web/
  ops-web/
  mobile/              # dibuat ketika Stage 5 dimulai
packages/
  api-contract/
  ui-system/
  tooling/
infrastructure/
docs/
```

Struktur internal API mengikuti module, bukan jenis file global:

```text
modules/<domain>/
  application/
  domain/
  infrastructure/
  presentation/
  tests/
```

Nama package detail mengikuti convention Laravel, React/Vite, dan Flutter, tetapi dependency direction di atas tetap.

## Technology standard

- API: Laravel 13, PHP 8.5, Composer, dan OpenAPI 3.1.
- Database: PostgreSQL 18; SQL dan migration tidak bergantung pada perilaku MySQL/phpMyAdmin.
- Queue/cache: Redis dengan worker idempotent.
- Web: React 19, TypeScript strict mode, dan Vite; ERP dan OPS tetap deployable terpisah.
- Mobile: Flutter 3.44 ketika mobile stage dimulai.
- File: private S3-compatible object storage; file tidak disimpan di database atau public web root.
- Shared frontend package hanya berisi design system, generated API client, serta utility non-bisnis.
- Versi patch mengikuti security update; upgrade major membutuhkan ADR/compatibility plan jika berdampak pada contract atau deployment.

## Naming

- Bahasa kode, schema, API, dan commit adalah English; label UI dapat Bahasa Indonesia.
- Class/type memakai singular `PascalCase`; method/variable `camelCase`; database `snake_case`.
- Table memakai plural noun; foreign key `<entity>_id`.
- Boolean diawali `is_`, `has_`, atau `can_` dan tidak nullable tanpa alasan kuat.
- Timestamp memakai `_at`, date memakai `_on`/`_date` secara konsisten.
- Status memakai domain term yang jelas; hindari `active = 0/1` untuk lifecycle kompleks.
- Permission memakai `module.resource.action`.
- Hindari singkatan ambigu seperti `tr`, `dtl`, `mst`, dan nama generik seperti `data`, `process`, atau `handle` tanpa konteks.

## Database dan migration

- Database tidak pernah dibuat atau diubah manual melalui phpMyAdmin untuk environment bersama.
- Semua schema, index, constraint, seed system, dan data fix memiliki migration/versioned script.
- Migration diuji dari database kosong dan dari versi production sebelumnya.
- Migration production dijalankan sebagai deployment job dengan log, lock, timeout, dan backup policy.
- Destructive migration memakai expand/migrate/contract serta compatibility window.
- Unique, foreign key, check constraint, dan index penting ditegakkan di database, bukan hanya validation UI.
- Seed demo dipisahkan dari seed system.
- Tidak ada business identifier menggunakan `MAX(id) + 1`.

## API conventions

- Semua client memakai API contract yang sama; perbedaan UI tidak membuat business endpoint kedua.
- Base path versioned, misalnya `/api/v1`.
- Resource URL menggunakan plural noun; command lifecycle eksplisit, misalnya `POST /purchase-requests/{id}/submit`.
- Error memakai struktur stabil: code, message aman, field errors, request ID.
- Pagination, filter, sort, timezone, dan enum representation konsisten.
- OpenAPI adalah artifact build dan divalidasi di CI.
- Breaking change memerlukan versi atau compatibility plan.
- Create/command yang dapat di-retry dari mobile atau integration wajib mendukung idempotency key.
- Optimistic concurrency/version check dipakai untuk update yang rawan lost update.

## Security baseline

- Authorization selalu server-side dan deny by default.
- Scope department/location serta domain ownership diuji pada setiap command/query sensitif.
- Input divalidasi dengan allowlist; output tidak mengekspos field internal secara otomatis.
- Credential, token, key, dan secret hanya berada di secret manager/environment terkontrol.
- Password, token, raw SQL credential, serta personal data sensitif tidak masuk log.
- MFA wajib untuk privileged access; session dapat dicabut.
- Upload diperiksa MIME/signature, size, malware, checksum, ownership, dan authorization download.
- Export besar/sensitif diaudit dan dapat diberi expiry.
- Dependency, container, IaC, dan secret scanning berjalan di CI.
- Threat model diperbarui untuk authentication, payment, import, file, serta offline mobile.

## Transaction dan consistency

- Satu business command memiliki transaction boundary yang eksplisit.
- Side effect eksternal tidak dieksekusi sebelum commit; gunakan outbox/worker.
- Worker idempotent, memiliki retry dengan backoff, dead-letter handling, dan correlation ID.
- Inventory movement dan payment posting bersifat append-only; koreksi memakai compensating record.
- Nomor dokumen dialokasikan atomik.
- Clock-dependent logic memakai injectable clock agar dapat diuji.

## Testing pyramid

| Level | Tujuan minimum |
|---|---|
| Unit | Domain invariant, calculation, state transition, permission resolution |
| Integration | Database constraint, repository, transaction, queue/outbox, file metadata |
| API/contract | Request/response, error, auth allow/deny, idempotency, compatibility |
| End-to-end | Flow kritis per persona dan segregation of duties |
| Migration/import | Clean build, upgrade path, repeatability, reconciliation, rejection |
| Performance | Endpoint/queue kritis pada volume representatif |
| Security | Auth/session, scope isolation, escalation, upload, export, abuse/rate limit |

Bug production wajib menghasilkan regression test pada level terendah yang dapat membuktikannya.

## CI/CD gates

Pull request wajib melewati:

- formatter dan linter;
- static/type analysis;
- unit dan integration test;
- architecture/dependency test;
- OpenAPI compatibility check;
- migration clean-build test;
- secret/dependency/security scan;
- build image/artifact reproducible.

Deployment staging menjalankan smoke test dan migration rehearsal. Production memerlukan artifact immutable yang sama dengan staging, approval sesuai risiko, health check, dan rollback/forward-fix procedure.

## Observability

- Structured log memuat timestamp, level, service/module, request ID, actor ID aman, dan error code.
- Metrics minimum: request latency/error, DB/queue health, failed jobs, auth failure, approval aging, import rejection, dan domain control metric.
- Distributed trace digunakan untuk API-worker/integration flow.
- Alert harus actionable, memiliki owner, severity, serta runbook.
- Audit log berbeda dari application log dan memiliki retention/access control sendiri.

## Performance dan reliability targets

Target angka final diputuskan setelah volume discovery. Baseline awal:

- API read umum p95 di bawah 500 ms pada beban normal;
- command umum p95 di bawah 1 detik, di luar job asynchronous;
- availability production bulanan minimum 99.5% untuk fase awal;
- RPO dan RTO ditetapkan berdasarkan domain; finance dan operasi tidak boleh memakai asumsi yang sama tanpa review;
- restore test dilakukan berkala dan hasilnya dicatat.

## Review dan ownership

- Setiap module memiliki code owner dan business owner.
- Perubahan lintas-boundary memerlukan review owner kedua module.
- ADR dibuat untuk keputusan yang mahal dibalik: persistence, auth, integration, deployment topology, multi-company, dan mobile offline model.
- Dokumentasi berubah dalam pull request yang sama dengan perilaku terkait.

## Definition of Done

Sebuah capability selesai bila:

- acceptance criteria terpenuhi dan didemokan;
- authorization allow/deny serta negative path teruji;
- migration, rollback/forward path, dan seed yang relevan tersedia;
- API contract serta dokumentasi flow diperbarui;
- audit dan observability tersedia;
- accessibility/responsive behavior diperiksa untuk UI;
- data migration/reconciliation evidence tersedia bila ada import;
- tidak ada critical/high issue terbuka tanpa risk acceptance;
- runbook support dan owner operasional jelas.
