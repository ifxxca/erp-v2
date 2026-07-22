# Product Requirements Document — Rajawali Platform V2

Status: Draft baseline
Produk: Management ERP + Operations Platform + Mobile-ready API

## 1. Latar belakang

Sistem legacy berkembang menjadi kumpulan modul operasional dan administratif dengan schema database, authorization, naming, dan flow transaksi yang tidak konsisten. V2 bukan refactor file-per-file. V2 mendefinisikan ulang produk berdasarkan proses bisnis yang masih dibutuhkan dan mengimpor hanya data legacy yang bernilai.

## 2. Product vision

Menyediakan satu platform internal multi-company yang aman dan dapat diaudit untuk mengelola operasi lapangan, fleet, pickup, service, procurement, inventory, payment, dan support melalui API yang konsisten.

## 3. Tujuan

- Satu sumber kebenaran per domain.
- Mendukung PT Rajawali Kreatif Sentosa dan PT Rajawali Kreatif Sinergi sebagai dua legal entity dengan data transaksi terisolasi.
- Approval dan permission tidak bergantung pada hardcoded user ID.
- Semua transaksi finansial, stok, dan operasional dapat ditelusuri.
- Web Operations dan mobile tetap dapat bekerja pada jaringan buruk.
- ERP mampu menyajikan ringkasan lintas domain tanpa menyalin business logic.
- Fresh install dan deployment tidak membutuhkan phpMyAdmin atau dump produksi.

## 4. Non-goals rilis awal

- Payroll dan HRIS lengkap.
- CRM/sales pipeline.
- Tax filing otomatis.
- Multi-company consolidation.
- General ledger, chart of accounts, journal, trial balance, dan financial statement penuh pada fase awal.
- Microservices dan database per service.
- Migrasi seluruh histori legacy tanpa kebutuhan bisnis.
- Feature parity untuk bug dan workflow legacy yang tidak diinginkan.

## 5. Persona

| Persona | Kebutuhan utama |
|---|---|
| System Administrator | User lifecycle, permission, configuration, audit |
| Management/Owner | KPI, approval queue, exception, report |
| Department Approver | Review dan approve transaksi dalam scope department |
| Procurement Officer | PR, PO, supplier, receipt |
| Finance Officer | Schedule, payment, reconciliation, period |
| Inventory Officer | Receipt, issue, stock, asset, opname |
| Fleet/GA Manager | Vehicle, document, service, health, cost |
| Operations Supervisor | Pickup, workload, exception, verification |
| Driver/Field Operator | Attendance, vehicle trip, checklist, fuel, pickup/return |
| Support Agent | Ticket dan memo |
| Auditor | Read-only data dan immutable audit trail |

Persona bukan role database. Satu user dapat menerima beberapa role yang di-scope ke department/location tertentu.

## 6. Product surfaces

### Management ERP

- desktop-first;
- procurement, finance, inventory, master data, fleet management, service management;
- centralized approval inbox;
- executive dan operational reporting;
- administrative configuration.

### Operations Web/PWA

- mobile-first;
- attendance, odometer, checklist, fuel, pickup, pending, return, outbound;
- camera/file upload;
- draft dan retry saat jaringan buruk;
- data yang ditampilkan dibatasi berdasarkan assignment.

### Mobile

- memakai kontrak Operations API yang sama;
- secure device session;
- offline queue dan background sync;
- dibangun setelah PWA/API terbukti.

## 7. Foundation requirements

### Identity dan organization

- Identity user bersifat platform-wide, sedangkan membership, role assignment, document sequence, dan data bisnis di-scope ke company.
- Company awal adalah PT Rajawali Kreatif Sentosa dan PT Rajawali Kreatif Sinergi.
- Department awal: Retail, Delivery, Outbound, HR, GA, Finance, Operation Excellence, dan IT.
- Location serta operational area adalah master terpisah dan tidak diperlakukan sebagai department.
- User tidak memiliki kolom `role` tunggal.
- Department mendukung hierarchy dan status aktif.
- User dapat menjadi anggota lebih dari satu department dengan satu primary membership.
- Role merupakan kumpulan permission.
- Role assignment dapat di-scope ke department dan/atau location.
- Assignment memiliki masa berlaku dan actor pemberi akses.
- Perubahan akses selalu tercatat di audit log.
- Rilis awal memakai local identity dengan password baru dan MFA untuk akses privileged/finance; desain tetap OIDC-ready.

### Audit

- Critical mutation menyimpan actor, action, entity, before/after, timestamp, request ID, dan source device.
- Audit record tidak dapat diubah melalui aplikasi.
- Data finansial dan stock menggunakan reversal, bukan menghapus history.

### Approval engine

- Workflow dapat dikonfigurasi berdasarkan subject, department, amount, dan sequence.
- Approver dipilih berdasarkan permission/scope, bukan user ID.
- Setiap action memiliki timestamp, reason, actor, dan state result.
- Duplicate/retry approval bersifat idempotent.

### Files dan notification

- File disimpan di object storage/private disk.
- Akses file melalui authorized/signed URL.
- Notification memakai outbox dan queue.
- Kegagalan WA/email tidak membatalkan transaksi utama.

## 8. Functional scope

### Fleet dan daily operations

- Vehicle dan VehicleType canonical.
- Vehicle availability state machine.
- Document, contract, insurance, KIR, tax, dan violation history.
- Vehicle checkout/check-in dan odometer monotonic validation.
- Checklist template dan response.
- Fuel entry, receipt, volume, price, dan efficiency.
- Health/inspection trigger dan maintenance follow-up.

### Pickup dan return

- Customer master.
- Pickup session dan entry quantity per package type.
- Pending item lifecycle yang eksplisit.
- Return hanya dapat memakai pending item yang eligible dan customer yang sama.
- Verification dan exception notes.
- Outbound session dan handover.
- Work shift/workload serta finance verification.

### Service dan maintenance

- Vendor, service type, template, dan schedule.
- Work order dengan items, jobs, parts, biaya, approval, dan completion.
- Part usage terintegrasi inventory ledger.
- Maintenance hasil inspection.
- Vehicle status otomatis dan konsisten.

### Inventory dan asset

- Item, category, unit, warehouse/location.
- Immutable stock movement dan materialized balance.
- Receipt, issue, transfer, adjustment, dan reversal.
- Stock opname dan discrepancy resolution.
- Asset registration, assignment, return, maintenance, disposal, dan valuation.
- Stock quantity tidak boleh negatif; command issue/transfer ditolak atomik jika saldo tidak cukup.
- Stock item dinilai dengan weighted moving average per company, item, dan inventory location.
- Fixed asset memakai acquisition/depreciation lifecycle terpisah dan tidak ikut weighted moving average stock.

### Procurement

- PR draft, submit, approval, reject, revise, cancel.
- PR lines dan attachments.
- PO dari PR approved.
- PO approval, supplier, terms, tax/discount/fee.
- Goods receipt dan integration ke inventory.
- Conversation tersanitasi dan auditable.
- Document numbering terpusat.

### Finance

- Payment account dan payment method.
- Unified payment schedule.
- Partial/full/bulk payment menggunakan satu execution service.
- Payment transaction immutable dan allocation ke schedule.
- Adjustment dan reversal.
- Payment period dan close/reopen dengan permission khusus.
- Budget dan commitment minimal untuk procurement.
- Scope fase awal adalah accounts payable, operational expense, petty cash, cash disbursement/payment, allocation, serta reconciliation.
- General ledger penuh berada di luar fase awal; V2 menyediakan export/integration contract untuk accounting system bila dibutuhkan.

### Support

- Ticket owner, assignee, CC participant, SLA, status transition, comment, attachment.
- TicketPolicy pada seluruh read/mutation.
- Memo draft/publish/expire dan audience.
- Central notification center.

### Reporting

- Executive dashboard lintas domain.
- Approval queue.
- Procurement spend dan outstanding.
- Payment due/paid/overdue.
- Inventory balance/movement/valuation.
- Fleet cost, availability, document expiry, fuel efficiency.
- Pickup volume, pending age, return, verification.
- Report definisi metric dan source harus terdokumentasi.

## 9. Critical workflows

```text
PR -> Approval -> PO -> PO Approval -> Payment Schedule
   -> Payment -> Goods Receipt -> Inventory Movement

Vehicle Checkout -> Odometer Out -> Checklist
   -> Daily Operation -> Fuel/Pickup -> Odometer In -> Available

Pickup -> Entry -> Pending
   -> Resolved by Entry OR Return -> Verification -> Closed

Inspection -> Maintenance Required -> Work Order
   -> Parts/Jobs -> Approval -> Complete -> Next Schedule
```

## 10. Success metrics

- 100% mutation endpoint memiliki server-side permission.
- 100% payment/stock/approval critical action memiliki audit record.
- Tidak ada duplicate payment akibat retry.
- Tidak ada negative stock akibat race condition.
- Fresh install dan migration lulus CI.
- Reconciliation selective import mencapai 100% untuk open balances dan open transactions.
- P95 API read umum <500 ms dan mutation umum <1 s, di luar upload/provider eksternal.
- Operations retry tidak menghasilkan duplicate transaction.
- Error rate critical workflow <0,5% setelah stabilization period.

## 11. Release slices

| Release | Scope |
|---|---|
| R0 | Foundation, identity, RBAC, audit, files, API contract |
| R1 | Fleet + Maintenance pilot pada RKS/Warehouse Kresek |
| R2 | Fleet Operations + Pickup/Return + Operations PWA |
| R3 | Inventory + Procurement + Finance |
| R4 | Support + cross-domain reporting |
| R5 | Mobile MVP |

## 12. Acceptance baseline

- Requirement dan state transition telah disetujui product owner.
- ERD/migration tidak bergantung pada schema legacy.
- Selective import memiliki mapping dan reconciliation report.
- Authorization matrix dan test tersedia.
- Critical workflow lulus end-to-end dan concurrency test.
- Backup/restore, observability, dan rollback runbook tersedia sebelum production.
