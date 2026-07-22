# ADR-0008: Weighted Average and No Negative Stock

Status: Accepted

## Decision

Stock item dinilai dengan weighted moving average per company, item, dan inventory location. Negative stock tidak diizinkan. Fixed asset dipisahkan dari stock valuation.

## Consequence

- Receipt/positive adjustment menghitung average cost secara atomik.
- Issue memakai average cost yang berlaku sebelum movement.
- Concurrent issue dikunci/divalidasi agar saldo tidak pernah negatif.
- Movement ledger adalah source of truth; balance/cost adalah reconstructable projection.
- Opening quantity dan value harus direkonsiliasi per company-item-location.
