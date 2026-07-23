# Open Questions dan Decision Register

Dokumen ini mencegah tim mengisi kekosongan requirement dengan asumsi tersembunyi. P0 harus dijawab sebelum foundation/domain terkait dibekukan; P1 sebelum module masuk development; P2 dapat diselesaikan sebelum rollout.

Seluruh P0 telah diselesaikan pada 2026-07-22 dan dirangkum di [10-P0-DECISIONS.md](10-P0-DECISIONS.md).

## P0 — Mengubah arsitektur atau model data

| ID | Pertanyaan | Owner keputusan | Dampak jika terlambat | Status |
|---|---|---|---|---|
| Q-001 | Apakah V2 melayani satu legal entity atau multi-company sejak awal? | Sponsor + Finance | Hampir semua key, numbering, scope, reporting | Accepted: dua legal entity, shared multi-company platform |
| Q-002 | Department dan location target apa saja, siapa parent-nya, dan siapa owner aksesnya? | HR/Ops + Management | Identity, approval, import user | Accepted baseline: 8 department; location/area terpisah |
| Q-003 | Apakah finance scope hanya payable/payment atau general ledger penuh? | Finance | ERD, roadmap, resource, cutover | Accepted: AP/expense/petty cash/payment; tanpa GL fase awal |
| Q-004 | Apa metode valuation inventory dan apakah negative stock dibolehkan? | Finance + Warehouse | Movement, costing, reconciliation | Accepted: weighted moving average; negative stock dilarang |
| Q-005 | Module mana yang menjadi pilot dan lokasi mana yang pertama? | Product owner | Urutan delivery dan import | Accepted: Fleet + Maintenance; RKS/Warehouse Kresek planning default |
| Q-006 | Stack backend/frontend/mobile serta database apa yang disetujui? | Technical owner | Scaffold, hiring, infrastructure | Accepted: Laravel/PHP, PostgreSQL, React/Vite, Flutter, Redis, S3 |
| Q-007 | Apakah perusahaan memerlukan SSO, dan identity provider apa? | Security/IT | Auth design dan user provisioning | Accepted: local identity, OIDC-ready, belum ada corporate IdP |

## P1 — Diperlukan sebelum module dibangun

### Identity dan organization

| ID | Pertanyaan | Owner | Status |
|---|---|---|---|
| Q-101 | Siapa yang boleh membuat, menyetujui, dan mencabut privileged assignment? | Security | Accepted: IT proposes, Management Access Owner approves, immediate audited revoke |
| Q-102 | Apakah user boleh aktif di beberapa department/location pada saat sama? | HR/Ops | Accepted: yes, explicit company/department/location scope |
| Q-103 | Berapa lama session web/mobile dan apakah MFA wajib untuk kelompok apa saja? | Security | Accepted: surface-specific lifetime; privileged/finance MFA + step-up |
| Q-104 | Apa sumber kebenaran status karyawan: ERP, HR system, atau manual? | HR/IT | Accepted: HR-maintained V2 roster until HRIS exists |

### Procurement dan approval

| ID | Pertanyaan | Owner | Status |
|---|---|---|---|
| Q-111 | Threshold approval per department/currency dan jalur eskalasinya? | Management/Finance | Open |
| Q-112 | Kapan PR/PO boleh diubah, dibatalkan, atau dibuka ulang? | Procurement | Open |
| Q-113 | Apakah partial receipt dan over/under delivery dibolehkan? | Procurement/Warehouse | Open |
| Q-114 | Aturan tax, discount, currency, dan rounding apa yang berlaku? | Finance | Open |

### Inventory dan assets

| ID | Pertanyaan | Owner | Status |
|---|---|---|---|
| Q-121 | Apakah lot/serial/expiry tracking diperlukan per kategori item? | Warehouse | Open |
| Q-122 | Unit conversion apa yang valid dan siapa yang boleh mengubahnya? | Warehouse | Open |
| Q-123 | Barang apa yang menjadi consumable, stock item, atau fixed asset? | Finance/Warehouse | Open |
| Q-124 | Seberapa sering stock count dan siapa approver adjustment? | Warehouse/Finance | Open |

### Fleet dan maintenance

| ID | Pertanyaan | Owner | Status |
|---|---|---|---|
| Q-131 | Status kendaraan resmi dan transisi yang diperbolehkan apa saja? | Fleet | Open |
| Q-132 | Service due berdasarkan waktu, odometer, engine hour, atau kombinasi? | Fleet/Maintenance | Open |
| Q-133 | Dokumen kendaraan apa yang wajib dan bagaimana escalation expiry? | Fleet/Compliance | Open |
| Q-134 | Apakah fuel data berasal dari input manual, card provider, atau sensor? | Fleet/Finance | Open |

### Pickup dan operations

| ID | Pertanyaan | Owner | Status |
|---|---|---|---|
| Q-141 | Definisi satu pickup, entry, pending, return, dan completion yang sah? | Operations | Open |
| Q-142 | Bukti apa yang wajib: foto, tanda tangan, GPS, berat, dokumen? | Operations | Open |
| Q-143 | Flow apa yang harus bekerja offline dan berapa lama? | Operations/IT | Open |
| Q-144 | Siapa yang boleh mengoreksi data lapangan setelah submit? | Operations/Audit | Open |

### Data import dan archive

| ID | Pertanyaan | Owner | Status |
|---|---|---|---|
| Q-151 | Berapa tahun histori yang wajib tersedia operasional dan audit? | Legal/Finance | Open |
| Q-152 | Transaksi terbuka per module apa yang wajib dilanjutkan di V2? | Domain owners | Open |
| Q-153 | Siapa menandatangani control total dan variance? | Finance/Data owners | Open |
| Q-154 | Kapan legacy menjadi read-only dan kapan archive dihentikan? | Sponsor/IT | Open |

## P2 — Rollout dan optimasi

| ID | Pertanyaan | Owner | Status |
|---|---|---|---|
| Q-201 | Domain dan environment resmi untuk API, ERP, OPS, dan archive? | IT | Proposed: api/erp/ops/olderp |
| Q-202 | Device dan versi OS mobile minimum? | Operations/IT | Open |
| Q-203 | Bahasa, timezone, currency, dan format lokal yang didukung? | Product | Open |
| Q-204 | Target availability, RPO, RTO, serta support hours per module? | Sponsor/IT | Open |
| Q-205 | Integrasi eksternal prioritas: GPS, bank, accounting, attendance, messaging? | Product | Open |
| Q-206 | Kebijakan retention file, audit, dan personal data? Metadata retention sudah tersedia tetapi tanggal tidak diasumsikan sebelum attachment/domain policy diputuskan. | Legal/Security | Open |
| Q-207 | Pattern, prefix, padding, reset period, timezone, dan location scope nomor dokumen Fleet/Maintenance? | Fleet/Maintenance owner | Open |

## Template keputusan

Saat satu pertanyaan diselesaikan, catat:

```text
Decision ID:
Date:
Decision owner:
Decision:
Why:
Alternatives rejected:
Impacted documents/modules:
Review date (if temporary):
```

Keputusan arsitektur yang mahal untuk dibalik kemudian dibuat sebagai ADR baru di folder `docs/adr`.
