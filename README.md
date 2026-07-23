# Rajawali Platform V2

Fresh rebuild untuk menggantikan ERP legacy secara terkontrol.

Workspace ini sengaja dimulai dari dokumentasi dan kontrak, bukan dari menyalin source lama. Source legacy di parent folder hanya menjadi bahan discovery. Tidak ada controller, model, migration, role, atau struktur tabel lama yang otomatis dianggap benar.

## Keputusan yang sudah dikunci

1. V2 adalah fresh project.
2. Data legacy diimpor secara selektif, bukan seluruh database.
3. User, department, role, dan permission didesain ulang.
4. Backend dimulai sebagai API-first modular monolith.
5. Frontend utama: Management ERP dan Operations Web/PWA.
6. Mobile memakai API yang sama setelah kontrak Operations stabil.
7. Legacy tidak menjadi dependency runtime permanen V2.
8. Transaksi penting harus atomic, auditable, dan idempotent.

## Target aplikasi

```text
api.domain.com       Backend API dan business rules
erp.domain.com       Management ERP
ops.domain.com       Operations Web/PWA
mobile               Android/iOS pada fase berikutnya
```

## Struktur workspace

```text
erp-v2/
  apps/               Source aplikasi (dibuat setelah foundation disetujui)
  docs/               Source of truth produk dan teknis
  infrastructure/     Deployment, environment, observability
  packages/           API contract dan shared frontend packages
```

## Dokumen utama

- [Index dan status dokumentasi](docs/00-INDEX.md)
- [PRD](docs/01-PRD.md)
- [Arsitektur](docs/02-ARCHITECTURE.md)
- [Domain Model dan ERD](docs/03-DOMAIN-ERD.md)
- [Identity, Department, dan RBAC](docs/04-IDENTITY-RBAC.md)
- [Strategi Selective Import](docs/05-DATA-IMPORT.md)
- [Delivery Plan](docs/06-DELIVERY-PLAN.md)
- [API, Security, Testing, dan NFR](docs/07-ENGINEERING-STANDARDS.md)
- [Open Questions](docs/08-OPEN-QUESTIONS.md)
- [Traceability temuan legacy ke V2](docs/09-LEGACY-TRACEABILITY.md)
- [P0 Decisions Baseline](docs/10-P0-DECISIONS.md)
- [P1 Identity Decisions](docs/11-P1-IDENTITY-DECISIONS.md)
- [Foundation Implementation Status](docs/12-FOUNDATION-STATUS.md)
- [Daily Vehicle Operations](docs/15-DAILY-VEHICLE-OPERATIONS.md)
- [Architecture Decision Records](docs/adr/)

## Status

P0 architecture baseline dan P1 Identity governance sudah disetujui. API, ERP Web dan Operations Web dengan typed OpenAPI runtime, shared generated TypeScript contract, local infrastructure, multi-company identity, private files, atomic numbering, transactional outbox, central notification inbox, observability/recovery control, serta Fleet checkout/checklist/check-in sudah memiliki implementation foundation. Lihat status verifikasi sebelum menganggap capability siap production.

## Quick verification

```powershell
npm ci
npm run build
npm run lint

docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml build api
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api composer install
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml up -d
powershell -File infrastructure/test-postgres.ps1
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api php vendor/bin/pint --test
```

PHP 8.5 dan PostgreSQL 18 dijalankan melalui container/CI. Runtime PHP lokal yang lebih lama hanya dapat dipakai untuk fast test jika dependency masih kompatibel.

## Aturan kontribusi

- Perubahan scope harus memperbarui PRD.
- Perubahan struktur data harus memperbarui ERD dan strategi import.
- Keputusan arsitektur penting harus memiliki ADR.
- API harus contract-first melalui OpenAPI.
- Tidak boleh meng-copy file legacy tanpa review dan test baru.
- Tidak boleh membuat tabel secara manual di production.
