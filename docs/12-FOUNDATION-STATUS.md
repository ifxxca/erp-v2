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
- Explicit role assignment-scope policy preventing global roles from entering company-scoped access requests.
- Capability-scoped access catalog, maker history, approval queue, and active privileged-assignment API.
- Scoped direct standard-role assignment and revocation with recent MFA, membership-period coverage, self-action denial, overlap protection, and append-only audit.
- TOTP enrollment, encrypted secret storage, confirmation, per-token MFA challenge, and replay prevention.
- Hashed single-use recovery codes, regeneration, optional-MFA disable, and mandatory MFA for active privileged assignments.
- Non-enumerating password recovery with hashed, expiring, single-use reset tokens and device revocation after reset.
- Device-session listing and scoped revocation plus surface-specific idle and absolute token lifetimes.
- Hashed, rotating mobile refresh-token families with 30-day absolute expiry, MFA binding, replay detection, and family-wide revocation.
- Company-scoped identity directory API with search/filter, employment history, organization catalog, and non-leaking cross-company detail.
- Effective-dated department/location administration owned by HR, including primary-department enforcement, scope validation, conflict rejection, and append-only audit.
- Global-only identity status administration owned by IT/security, with self-action denial, active-employment gate, recent MFA, and immediate session/refresh-family revocation.
- Global role/permission catalog plus audited custom-role administration with protected system roles, stable permission codes, recent-MFA mutations, global-only capability isolation, and assignment-history guardrails.
- Explicit user-location memberships and department/location membership checks in effective permission resolution.
- ULID identity schema for companies, departments, locations, memberships, roles, permissions, access requests, and role assignments.
- Seed data for two legal entities, eight departments per company, initial system roles, and initial permission catalog.
- Company-aware permission resolver with active employment and assignment checks.
- API-wide request correlation with normalized `X-Request-ID`, structured error envelopes, audit propagation, and safe 5xx masking.
- Database-backed, identity-scoped mutation idempotency with canonical request fingerprints, atomic acquisition, exact response replay, in-progress/mismatch conflicts, failure recovery, retention cleanup, and hashed client keys.
- Company-scoped private file lifecycle with initiate/upload/finalize separation, owner enforcement, exact size/SHA-256 validation, MIME/signature allowlist, quarantine, asynchronous ClamAV scanning, authorized streaming download, tombstoned deletion, abandoned-upload cleanup, and append-only audit.
- S3-compatible MinIO bucket initialization plus a Redis queue worker and ClamAV service in local Compose; unscanned mode is explicit, non-production-only, and never represented as clean.
- Internal atomic document-number service with company/location rule resolution, effective-dated versions, controlled placeholders, timezone-aware period reset, database upsert counters, subject-idempotent allocation, rollback safety, and transactional audit.
- React 19/TypeScript/Vite Management ERP identity workspace plus Operations Web scaffold.
- Responsive ERP login, MFA challenge, legal-entity directory, identity detail, organization scheduling, and guarded global-status controls.
- Responsive ERP Privileged Access Review workspace for request, approve, reject, and immediate revoke flows.
- Mantine-based ERP design system covering the app shell, responsive navigation, forms, tables, drawers, modals, notifications, and branded theme.
- Company-scoped invitation UI with validated organization assignment and capability-gated access.
- MFA and device-session self-service workspace covering TOTP enrollment, recovery codes, step-up verification, optional disable, session inventory, and scoped/bulk revocation.
- Mantine Roles & Permissions workspace covering catalog search, system-role inspection, custom-role creation/profile editing, permission mapping, and guarded deletion.
- Mantine identity Access tab covering standard-role catalog, scoped effective-dated assignment, history, and guarded revocation.
- npm workspace plus shared API-contract and web-UI packages.
- PostgreSQL 18, Redis 8, MinIO, ClamAV, queue worker, and Mailpit local compose definition.
- PHP 8.5 API development container definition.
- CI jobs for PostgreSQL migration/seed validation, PHP tests/format/audit, and web build/lint.

## Verified locally

- API test suite: 104 tests, 599 assertions.
- SQLite clean migration used by fast automated tests.
- Foundation seeder repeatability.
- Cross-company permission isolation and disabled-user deny behavior.
- Generic credential failures, invitation replay denial, scoped invitation authorization, and termination revocation behavior.
- Privileged self-approval denial, MFA gate, maximum expiry, duplicate request, rejection, wrong-company denial, and immediate token revocation.
- Access catalog isolation, global-role exclusion, role-scope validation, maker-history privacy, capability projection, and active-assignment listing.
- Standard-access catalog isolation, privileged/global-role exclusion, company/department/location coverage, overlap denial, self-action/MFA gates, history, revocation, and scheduled-role classification protection.
- Request-ID preservation/generation, correlated framework errors and audit records, canonical JSON replay without duplicate side effects, payload-mismatch denial, in-progress retry signaling, and failed-response recovery.
- File checksum/signature rejection, upload ownership, company isolation, quarantine/scan state, infected-object removal, authorized download, deletion tombstone, and audit evidence.
- Document-number transaction guard, sequential allocation, subject replay, rollback reuse, monthly reset, location override/global fallback, company isolation, unsafe-pattern denial, and audit evidence.
- Encrypted TOTP enrollment, code replay denial, token-isolated assurance, recovery-code rotation/reuse denial, and mandatory-privileged-MFA behavior.
- Password-reset non-enumeration/replay denial, cross-user session isolation, revoke-all confirmation, and ERP/OPS idle-timeout behavior.
- Mobile refresh hashing, rotation lineage, fixed absolute expiry, access-token replacement, cross-device isolation, ineligible-identity denial, and family revocation on replay/session revoke.
- Identity directory scope/cross-company isolation, HR organization scheduling, invalid-scope and schedule-conflict denial, global-status boundaries, reactivation eligibility, and session revocation.
- ERP and Operations production builds.
- Web lint.
- Browser-based ERP smoke tests at desktop and mobile sizes with real API data and no application console errors, including invitation, TOTP enrollment, recovery-code presentation, mandatory MFA re-entry, session revocation, privileged request/approval/revocation, standard scoped assignment/revocation/self-action guard, system-role inspection, and the full custom-role create/edit/permission-sync/delete lifecycle.
- Frontend tooling is isolated from the legacy parent PostCSS/Tailwind configuration.
- Composer strict validation.
- Composer dependency security audit.
- Docker Compose configuration parsing.

## Pending environment verification

PostgreSQL migration and PHP 8.5 container execution could not be run locally because Docker Desktop daemon was unable to start. CI is configured to run the same migration against PostgreSQL 18. This item is an environment limitation, not a passing test claim.

## Intentionally not implemented yet

- OpenAPI generated clients.
- Remaining shared-platform foundations: transactional outbox/notification worker and production observability.
- Fleet/Maintenance domain migrations and flows.
- Flutter mobile application.

The mobile token lifecycle is implemented, but production deployment still requires PostgreSQL/container verification and mobile OS secure-storage integration.
