# ADR-0005: Shared Multi-Company Platform

Status: Accepted

## Context

PT Rajawali Kreatif Sentosa dan PT Rajawali Kreatif Sinergi adalah dua legal entity berbeda. Keduanya akan memakai platform yang sama, tetapi transaksi dan pembukuannya tidak boleh bercampur.

## Decision

V2 memakai satu platform dan satu database operasional multi-company. Seluruh aggregate bisnis, document sequence, approval, account, balance, serta role assignment memiliki company scope. Identity user dapat dipakai lintas company, tetapi akses diberikan eksplisit per company.

## Consequence

- `company_id` wajib pada data bisnis dan menjadi bagian constraint/index penting.
- Department dan location dimiliki company.
- Cross-company access ditolak secara default dan diuji di API/integration test.
- Consolidated accounting/reporting tidak otomatis masuk scope awal.
- Service/database terpisah per company hanya dipertimbangkan bila kebutuhan regulasi atau isolation terbukti.
