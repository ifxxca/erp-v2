# Foundation Implementation Status

Status date: 2026-07-22

## Implemented

- Laravel 13 API with PHP 8.5 production constraint.
- Sanctum API authentication foundation and versioned `/api/v1/me` contract.
- Credential login and token logout with rate limiting and surface-specific access-token expiry.
- Company-scoped employee invitation and single-use activation token stored only as a SHA-256 hash.
- Company membership termination with role revocation, device-token revocation, and automatic identity disable when no active employment remains.
- Append-only identity audit records for login, logout, invitation, activation, and termination events.
- Privileged-access request, approval, rejection, and immediate-revocation workflow with strict maker/target/approver separation.
- Ninety-day maximum privileged expiry, duplicate protection, scoped notification, and recent-MFA enforcement point.
- TOTP enrollment, encrypted secret storage, confirmation, per-token MFA challenge, and replay prevention.
- Hashed single-use recovery codes, regeneration, optional-MFA disable, and mandatory MFA for active privileged assignments.
- Non-enumerating password recovery with hashed, expiring, single-use reset tokens and device revocation after reset.
- Device-session listing and scoped revocation plus surface-specific idle and absolute token lifetimes.
- Hashed, rotating mobile refresh-token families with 30-day absolute expiry, MFA binding, replay detection, and family-wide revocation.
- Explicit user-location memberships and department/location membership checks in effective permission resolution.
- ULID identity schema for companies, departments, locations, memberships, roles, permissions, access requests, and role assignments.
- Seed data for two legal entities, eight departments per company, initial system roles, and initial permission catalog.
- Company-aware permission resolver with active employment and assignment checks.
- React 19/TypeScript/Vite scaffolds for Management ERP and Operations Web.
- npm workspace plus shared API-contract and web-UI packages.
- PostgreSQL 18, Redis 8, MinIO, and Mailpit local compose definition.
- PHP 8.5 API development container definition.
- CI jobs for PostgreSQL migration/seed validation, PHP tests/format/audit, and web build/lint.

## Verified locally

- API test suite: 49 tests, 278 assertions.
- SQLite clean migration used by fast automated tests.
- Foundation seeder repeatability.
- Cross-company permission isolation and disabled-user deny behavior.
- Generic credential failures, invitation replay denial, scoped invitation authorization, and termination revocation behavior.
- Privileged self-approval denial, MFA gate, maximum expiry, duplicate request, rejection, wrong-company denial, and immediate token revocation.
- Encrypted TOTP enrollment, code replay denial, token-isolated assurance, recovery-code rotation/reuse denial, and mandatory-privileged-MFA behavior.
- Password-reset non-enumeration/replay denial, cross-user session isolation, revoke-all confirmation, and ERP/OPS idle-timeout behavior.
- Mobile refresh hashing, rotation lineage, fixed absolute expiry, access-token replacement, cross-device isolation, ineligible-identity denial, and family revocation on replay/session revoke.
- ERP and Operations production builds.
- Web lint.
- Frontend tooling is isolated from the legacy parent PostCSS/Tailwind configuration.
- Composer strict validation.
- Composer dependency security audit.
- Docker Compose configuration parsing.

## Pending environment verification

PostgreSQL migration and PHP 8.5 container execution could not be run locally because Docker Desktop daemon was unable to start. CI is configured to run the same migration against PostgreSQL 18. This item is an environment limitation, not a passing test claim.

## Intentionally not implemented yet

- Identity administration UI.
- Organization/access administration screens.
- OpenAPI generated clients.
- Fleet/Maintenance domain migrations and flows.
- Flutter mobile application.

The mobile token lifecycle is implemented, but production deployment still requires PostgreSQL/container verification and mobile OS secure-storage integration.
