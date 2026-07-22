# ADR-0006: Local Identity with OIDC-Ready Boundary

Status: Accepted

## Context

Perusahaan belum memiliki akun korporat atau identity provider terpusat. ERP, Operations Web, dan mobile tetap membutuhkan lifecycle akun serta authentication yang konsisten.

## Decision

Rilis awal menggunakan local identity di V2. Web memakai secure session cookie; mobile memakai rotating device-bound token. MFA wajib untuk privileged dan finance access. Authentication boundary dibuat OIDC-ready agar identity provider dapat ditambahkan kemudian tanpa mendesain ulang RBAC.

## Consequence

- Password, remember token, session, dan credential legacy tidak diimpor.
- V2 bertanggung jawab atas invite, activation, reset, MFA, session revocation, dan security monitoring.
- Membership, scoped role assignment, permission, dan audit tetap berada di V2 ketika SSO ditambahkan.
