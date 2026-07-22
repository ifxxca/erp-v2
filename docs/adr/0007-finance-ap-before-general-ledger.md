# ADR-0007: Accounts Payable Before General Ledger

Status: Accepted

## Decision

Finance fase awal mencakup accounts payable, operational expense, petty cash, payment schedule, payment execution, allocation, adjustment/reversal, dan reconciliation. General ledger, chart of accounts, journal, trial balance, serta financial statement penuh tidak dibangun pada baseline awal.

## Reason

Legacy memiliki flow payable/payment tetapi tidak memiliki model general ledger yang dapat dipercaya. Membuat ledger tanpa accounting requirement dan ownership yang matang akan menghasilkan sistem finansial semu.

## Consequence

Payment tetap immutable, audited, company-scoped, serta memakai maker-checker-approver. V2 menyediakan export/integration contract untuk accounting system. GL hanya masuk melalui product decision dan ADR baru.
