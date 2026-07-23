# Legacy Findings to V2 Traceability

Dokumen ini memastikan masalah yang ditemukan pada ERP lama ditangani oleh desain V2. Ia bukan daftar feature parity dan bukan izin menyalin implementasi lama.

## Temuan dan respons desain

| Temuan legacy | Risiko | Respons V2 | Evidence |
|---|---|---|---|
| Migration tertinggal dari database/dump dan schema dibuat manual | Environment tidak repeatable, deployment berbahaya | Fresh schema; seluruh perubahan melalui migration; clean-build test di CI | [Engineering Standards](07-ENGINEERING-STANDARDS.md#database-dan-migration) |
| Banyak migration membuat tabel yang sama/bertentangan | Schema ownership tidak jelas | Satu module memiliki tabelnya; architecture/dependency test; versioned migration | [Architecture](02-ARCHITECTURE.md), [Engineering Standards](07-ENGINEERING-STANDARDS.md) |
| User menyimpan role tunggal dan hubungan department tidak sehat | Akses terlalu luas, rotasi organisasi merusak histori | Membership terpisah, multi-department, scoped role assignment, validity period | [Identity & RBAC](04-IDENTITY-RBAC.md) |
| Role/user ID hardcoded | Privilege escalation dan perilaku sulit dilacak | Permission code stabil, deny-by-default policy, no hardcoded ID | [Identity & RBAC](04-IDENTITY-RBAC.md#acceptance-criteria) |
| Admin tertentu dapat memberi dirinya akses tertinggi | Segregation of duties gagal | Access assignment terpisah dari profile update; privileged approval, expiry, audit, break-glass | [Identity & RBAC](04-IDENTITY-RBAC.md#lifecycle-akses) |
| Route, controller, model, dan view sangat banyak tanpa boundary | Perubahan satu flow berdampak ke banyak area | API-first modular monolith dengan module ownership dan application contract | [Architecture](02-ARCHITECTURE.md#2-backend-style) |
| Flow/status tidak jelas dan update dilakukan secara generik | Transaksi lompat status, approval mudah dilewati | Explicit command, state transition, versioned approval instance, domain policy | [ERD](03-DOMAIN-ERD.md#constraint-lintas-domain) |
| Naming campur dan singkatan ambigu | Onboarding serta maintenance mahal | English code/schema/API, naming rules, stable permission vocabulary | [Engineering Standards](07-ENGINEERING-STANDARDS.md#naming) |
| Database lama menjadi satu-satunya gambaran sistem | Tidak diketahui data mana yang benar | Selective import melalui staging, mapping, validation, reconciliation, sign-off | [Data Import](05-DATA-IMPORT.md) |
| Web view dan business rule berpotensi terikat | Mobile membutuhkan duplikasi logic | ERP, OPS, dan mobile menggunakan satu versioned API | [ADR-0003](adr/0003-api-first-multi-frontend.md) |
| Keinginan memecah domain langsung menjadi service | Distributed complexity muncul sebelum boundary matang | Mulai modular monolith; ekstraksi service hanya berdasarkan bukti scaling/ownership/isolation | [ADR-0002](adr/0002-modular-monolith.md) |

## Pemetaan capability legacy ke module target

| Capability yang perlu diverifikasi | Module target | Default treatment |
|---|---|---|
| User, employee, role, department | Identity & Access | Redesign; import identity minimum saja |
| Supplier, request, order, receipt | Procurement | Rebuild flow dan import master/open transaction terpilih |
| Payment schedule dan transaksi pembayaran | Finance | Rebuild dengan maker-checker-approver dan reconciliation |
| Item, stok, asset, spare part | Inventory & Assets | Opening position + ledger baru; histori archive |
| Vehicle, driver, trip, fuel, document | Fleet | Import master aktif dan histori yang operasional |
| Checklist dan daily inspection | Fleet/Operations | Rebuild mobile-ready, template versioned |
| Pickup, entry, pending, return, shift | Operations | Workshop ulang state dan terminology sebelum implementasi |
| Service, repair, component, schedule | Maintenance | Rebuild work order lifecycle; import open/relevant history |
| Ticket, memo, notification | Support/Shared Platform | Re-evaluate kebutuhan; bukan otomatis parity |
| Report legacy | Reporting/read model | Definisikan ulang KPI dan source; jangan menyalin query tanpa validasi |

Profil detail vehicle/service legacy dan kontrak import vehicle pertama dicatat pada [Fleet + Maintenance Pilot](14-FLEET-MAINTENANCE-PILOT.md).

## Rule feature parity

Satu fitur legacy hanya masuk backlog V2 bila memenuhi minimal satu kondisi:

- diperlukan untuk proses bisnis yang masih aktif;
- diwajibkan oleh audit, legal, atau finance;
- mengurangi risiko operasional yang terukur;
- menjadi dependency flow prioritas yang sudah disetujui.

Fitur tidak diteruskan hanya karena sudah ada. Setiap fitur yang dipilih membutuhkan owner, expected outcome, state/exception mapping, authorization, acceptance criteria, serta keputusan import.

## Discovery evidence

Audit codebase yang dibuat sebelum keputusan fresh rebuild tetap menjadi input discovery di [CODEBASE-AUDIT-2026-07-22.md](../../docs/CODEBASE-AUDIT-2026-07-22.md). Jika angka atau temuan berubah setelah pemeriksaan tambahan, audit diperbarui dan dampaknya ditautkan ke dokumen V2 terkait.
