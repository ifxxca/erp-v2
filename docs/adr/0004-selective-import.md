# ADR-0004: Selective Legacy Import

Status: Accepted

## Decision

Hanya master data valid, opening balance, transaksi terbuka, dokumen aktif, dan histori yang dibutuhkan yang diimpor. Seluruh database legacy tidak dimigrasikan otomatis.

## Consequence

Setiap dataset memerlukan owner, mapping, cleansing, dry-run, reconciliation, dan acceptance sign-off.
