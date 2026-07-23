# ADR-0013: Atomic Document Numbering

Status: Accepted

## Decision

Nomor dokumen dialokasikan oleh service internal di dalam transaksi database aggregate pemilik. Client tidak memiliki endpoint untuk meminta atau memilih nomor. Rule format bersifat company-scoped, dapat dioverride per location, memiliki versi dan effective date, serta reset berdasarkan `none`, `yearly`, `monthly`, atau `daily` pada timezone rule.

Counter menggunakan atomic database upsert pada unique key `rule_id + period_key`. Allocation mengikat satu nomor ke `company + document_type + subject_type + subject_id`, menyimpan rule version dan nilai sequence, serta menghasilkan audit record dalam transaksi yang sama.

## Consequence

- Rollback aggregate juga me-rollback counter, allocation, dan audit sehingga nomor tidak habis karena transaksi gagal.
- Pemanggilan ulang untuk subject yang sama mengembalikan allocation yang sama tanpa increment baru.
- Nomor yang sudah commit tidak pernah digunakan ulang ketika dokumen dibatalkan; dokumen harus mempertahankan histori nomor tersebut.
- Rule location lebih spesifik daripada rule global company; cross-company location ditolak.
- Rule yang sudah memiliki counter/allocation tidak dapat ditulis ulang; perubahan format diterbitkan sebagai versi baru dengan effective date.
- Pattern hanya menerima placeholder terkontrol dan wajib merepresentasikan reset period agar nomor lintas periode tidak bertabrakan.
- Format nyata Fleet/Maintenance belum di-seed. Prefix, padding, reset period, dan location scope menunggu keputusan Q-207 dari domain owner.
- PostgreSQL adalah production baseline; SQLite tetap didukung untuk fast test menggunakan semantik `ON CONFLICT ... RETURNING` yang sama.
