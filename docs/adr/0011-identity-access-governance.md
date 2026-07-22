# ADR-0011: Identity and Access Governance

Status: Accepted

## Decision

Privileged access memakai request-approval-execution dengan aktor berbeda, expiry, MFA, dan audit. User boleh memiliki membership multi-company/department/location secara eksplisit. HR-maintained V2 employment roster menjadi source of truth sampai HRIS tersedia. Session lifetime dibedakan untuk ERP, Operations PWA, dan mobile dengan rotating refresh token serta step-up MFA.

## Consequence

- Privileged assignment tidak dapat dibuat melalui CRUD user/profile biasa.
- Revocation bersifat immediate dan tidak menunggu approval.
- Identity, employment/company membership, organization membership, dan authorization assignment tetap menjadi konsep terpisah.
- API test wajib mencakup cross-company isolation, self-approval, expiry, revocation, dan token reuse.
