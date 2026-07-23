# ERP V2 Documentation Index

Folder ini adalah source of truth untuk fresh rebuild ERP. Dokumen legacy di luar `erp-v2` hanya dipakai untuk menemukan requirement, data, dan edge case; isinya tidak otomatis menjadi desain target.

## Urutan baca

1. [01-PRD.md](01-PRD.md) — tujuan produk, persona, module, flow, dan acceptance baseline.
2. [02-ARCHITECTURE.md](02-ARCHITECTURE.md) — topology API-first dan modular monolith.
3. [03-DOMAIN-ERD.md](03-DOMAIN-ERD.md) — logical data model lintas domain.
4. [04-IDENTITY-RBAC.md](04-IDENTITY-RBAC.md) — desain ulang user, department, role, permission, dan approval scope.
5. [05-DATA-IMPORT.md](05-DATA-IMPORT.md) — aturan selective import, reconciliation, archive, dan cutover.
6. [06-DELIVERY-PLAN.md](06-DELIVERY-PLAN.md) — stage delivery, quality gates, backlog awal, dan risiko.
7. [07-ENGINEERING-STANDARDS.md](07-ENGINEERING-STANDARDS.md) — standard coding, migration, API, security, testing, dan CI/CD.
8. [08-OPEN-QUESTIONS.md](08-OPEN-QUESTIONS.md) — keputusan bisnis/teknis yang belum boleh diasumsikan.
9. [09-LEGACY-TRACEABILITY.md](09-LEGACY-TRACEABILITY.md) — pemetaan setiap masalah legacy ke kontrol/desain V2.
10. [10-P0-DECISIONS.md](10-P0-DECISIONS.md) — baseline final seluruh keputusan architecture/model P0.
11. [11-P1-IDENTITY-DECISIONS.md](11-P1-IDENTITY-DECISIONS.md) — governance akses, multi-scope membership, session/MFA, dan employment ownership.
12. [12-FOUNDATION-STATUS.md](12-FOUNDATION-STATUS.md) — implementation evidence, verified checks, dan intentionally pending work.
13. [13-OBSERVABILITY-RUNBOOK.md](13-OBSERVABILITY-RUNBOOK.md) — health, metrics, alert threshold, triage, dan audited dead-letter re-drive.
14. [14-FLEET-MAINTENANCE-PILOT.md](14-FLEET-MAINTENANCE-PILOT.md) — legacy evidence, physical slice, lifecycle, authorization, dan vehicle import contract pilot.
15. [15-DAILY-VEHICLE-OPERATIONS.md](15-DAILY-VEHICLE-OPERATIONS.md) — checkout/checklist/check-in lifecycle, invariant odometer, role driver, dan mobile readiness.

## Architecture Decision Records

| ADR | Keputusan |
|---|---|
| [0001](adr/0001-fresh-rebuild.md) | Membangun fresh project, bukan refactor in-place |
| [0002](adr/0002-modular-monolith.md) | Memulai dengan modular monolith, bukan microservices |
| [0003](adr/0003-api-first-multi-frontend.md) | Satu API untuk ERP web, OPS web, dan mobile |
| [0004](adr/0004-selective-import.md) | Selective import ke schema baru |
| [0005](adr/0005-shared-multi-company-platform.md) | Dua legal entity pada shared multi-company platform |
| [0006](adr/0006-local-identity-oidc-ready.md) | Local identity sekarang, OIDC-ready untuk SSO berikutnya |
| [0007](adr/0007-finance-ap-before-general-ledger.md) | Finance dimulai dari AP/payment, bukan GL penuh |
| [0008](adr/0008-weighted-average-no-negative-stock.md) | Weighted moving average dan larangan negative stock |
| [0009](adr/0009-fleet-maintenance-pilot.md) | Fleet + Maintenance sebagai pilot pertama |
| [0010](adr/0010-technology-baseline.md) | Baseline teknologi implementation |
| [0011](adr/0011-identity-access-governance.md) | Identity lifecycle dan privileged access governance |
| [0012](adr/0012-private-file-lifecycle.md) | Private file lifecycle, quarantine, scan, dan authorized download |
| [0013](adr/0013-atomic-document-numbering.md) | Atomic, scoped, versioned document numbering |
| [0014](adr/0014-transactional-outbox-notifications.md) | Transactional outbox, central inbox, retry, dan dead-letter notification |
| [0015](adr/0015-production-observability-controls.md) | Vendor-neutral health, metrics, structured logging, alert, dan recovery control |

## Status baseline

| Area | Status | Next gate |
|---|---|---|
| Product scope | P0 accepted | Validasi flow detail bersama domain owner |
| Architecture | Foundation implemented | Production collector integration dan deployment verification |
| Logical ERD | Fleet/Maintenance + daily vehicle operations physical slice | Review documents, service schedule, fuel/event, dan parts boundary |
| Identity/RBAC | Implemented and verified | Access certification/SoD reporting dan production environment verification |
| Data import | Vehicle contract drafted from legacy profile | Owner mapping, dry-run, dan reconciliation sign-off |
| Delivery plan | Accepted baseline | Konfirmasi team capacity dan onboarding pilot |
| Engineering standard | Foundation implemented | Validasi alert routing, retention, dan production SLO |

## Aturan perubahan

- Requirement baru harus menunjuk module, owner, priority, dan acceptance criteria.
- Perubahan model lintas domain memperbarui PRD/ERD dan ADR bila mahal dibalik.
- Perubahan akses memperbarui permission catalog, SoD matrix, serta test matrix.
- Perubahan import memperbarui data contract dan reconciliation control.
- Kode dan migration tidak boleh menjadi satu-satunya dokumentasi keputusan bisnis.
