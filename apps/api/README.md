# Rajawali Platform API

Laravel 13 modular-monolith API for Rajawali Platform V2.

## Local setup

From the repository root:

```powershell
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml up -d
Copy-Item apps/api/.env.example apps/api/.env
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api php artisan key:generate
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api php artisan migrate:fresh --seed
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml up api
```

API base URL: `http://localhost:8000/api/v1`.

## Request controls

Every API response includes `X-Request-ID`. Clients may send an 8–128 character URL-safe value; invalid or missing values are replaced by a server-generated ULID. Error JSON always contains `message`, stable `code`, and the same `request_id`; validation errors additionally contain `errors`.

Authenticated business mutations accept an optional `Idempotency-Key` containing 16–128 URL-safe characters. The key is scoped to the authenticated identity and exact route/query/canonical JSON payload. A completed request is replayed for 24 hours with `Idempotency-Replayed: true`; reuse for another request returns `409 IDEMPOTENCY_KEY_REUSED`, while an equivalent request still running returns `409 IDEMPOTENCY_REQUEST_IN_PROGRESS` plus `Retry-After`. Failed responses are not cached. Clients must reuse the same key only when retrying the same logical command.

## Private file endpoints

- `POST /companies/{company}/files` reserves company-scoped metadata and returns the multipart content endpoint.
- `POST /companies/{company}/files/{file}/content` accepts the owner binary and verifies its exact size, SHA-256 checksum, detected MIME, and binary signature. This multipart endpoint intentionally does not use `Idempotency-Key`.
- `POST /companies/{company}/files/{file}/finalize` quarantines the upload and dispatches malware scanning.
- `GET /companies/{company}/files/{file}` returns metadata without disk credentials or object key.
- `GET /companies/{company}/files/{file}/download` streams only a `ready` private object after scoped authorization.
- `DELETE /companies/{company}/files/{file}` removes the binary and keeps a metadata/audit tombstone; attached files must be deleted by their owning domain workflow.

The Compose stack creates the private MinIO bucket, runs Redis queue worker and scheduler processes, and scans with ClamAV. Production must keep `FILES_ALLOW_UNSCANNED=false`. The test-only skipped scanner records `scan_status=skipped`, never `clean`. Abandoned reservations expire after 24 hours. Legal retention remains unset until a domain attaches the file and Q-206 defines the policy.

## Internal document numbering

`DocumentNumberService` allocates document numbers only inside the owning domain transaction; there is intentionally no generic API endpoint. Rules are company-scoped with optional location override, effective-dated versions, controlled placeholders, timezone-aware period reset, and an atomic `rule + period` counter. A repeated subject returns its existing allocation, while transaction rollback also rolls back the counter and audit record. Actual Fleet/Maintenance patterns remain unseeded until Q-207 is approved.

## Transactional outbox and notifications

`OutboxWriter` records an asynchronous intent only inside the owning domain transaction. Canonical payload fingerprinting and a hashed deduplication key reject conflicting replay. The scheduler claims pending/stale work, while queue jobs persist attempt history, bounded backoff, and dead-letter state. Inbox creation is idempotent; mail delivery is isolated in a second job and therefore cannot roll back a committed business transaction.

- `GET /notifications` returns the authenticated identity's paginated inbox and unread count.
- `PATCH /notifications/{notification}/read` marks one owned item read.
- `POST /notifications/read-all` marks all owned items read.

Privileged-access lifecycle notifications are the first domain producer. The API, scheduler, and queue worker must all run in deployed environments. External mail remains at-least-once unless its provider supports an idempotency key.

## Identity endpoints

- `POST /auth/login` issues an expiring bearer token; mobile login also starts one 30-day device-bound refresh family.
- `POST /auth/mobile/refresh` rotates the refresh secret and mobile access token; reuse revokes the entire family.
- `POST /auth/logout` revokes the presented bearer token and its mobile refresh family when applicable.
- `POST /auth/password/forgot|reset` performs non-enumerating, single-use password recovery.
- `POST /auth/invitations/accept` activates a single-use invitation.
- `GET /auth/mfa` returns MFA and current-token assurance status.
- `POST /auth/mfa/totp/enroll|confirm` enrolls an authenticator app and returns recovery codes once.
- `POST /auth/mfa/challenge` verifies TOTP or a single-use recovery code.
- `POST /auth/mfa/recovery-codes/regenerate` replaces recovery codes after recent MFA.
- `DELETE /auth/mfa/totp` disables optional MFA and revokes every token.
- `GET /auth/sessions` lists device sessions owned by the authenticated identity.
- `DELETE /auth/sessions/{tokenId}` and `POST /auth/sessions/revoke-all` revoke device access and associated refresh families.
- `GET /me` returns the active authenticated identity.
- `GET /identity/companies` returns only legal entities visible to the administrator and server-derived UI capabilities.
- `GET /identity/companies/{company}/organization` returns the active department and location catalog.
- `GET /identity/companies/{company}/users` and `GET /identity/companies/{company}/users/{user}` expose a company-scoped identity directory and history.
- `PUT /identity/companies/{company}/users/{user}/organization-memberships` requires `identity.employment.manage`; it schedules effective-dated organization changes without overwriting history.
- `GET|POST /identity/companies/{company}/users/{user}/role-assignments` requires `identity.access.assign`; it returns the standard-role catalog/history or creates a direct non-privileged assignment after recent MFA.
- `POST /identity/companies/{company}/users/{user}/role-assignments/{assignment}/revoke` revokes only a direct standard assignment after recent MFA.
- `PATCH /identity/users/{user}/status` requires global `identity.user.status.manage` plus recent MFA; suspend/disable revoke all device sessions and mobile refresh families.
- `GET /identity/roles` requires global `identity.role.view` and returns the role/permission catalog plus server-derived management capability.
- `POST /identity/roles`, `PATCH|DELETE /identity/roles/{role}`, and `PUT /identity/roles/{role}/permissions` require global `identity.role.manage`, recent MFA, and an audit reason.
- `POST /identity/users/invitations` requires `identity.user.manage` in `company_id`.
- `POST /identity/users/{user}/companies/{company}/terminate` requires `identity.employment.manage`, terminates scoped employment, and revokes stale access.
- `GET /identity/companies/{company}/access-requests` returns the scoped approval queue.
- `GET /identity/companies/{company}/access-requests/mine` returns only the current maker's request history.
- `GET /identity/companies/{company}/access-catalog` returns eligible active targets, their organization memberships/MFA readiness, and non-global privileged roles.
- `POST /identity/companies/{company}/access-requests` creates a privileged request.
- `POST /identity/companies/{company}/access-requests/{request}/approve|reject` applies maker-checker policy.
- `GET /identity/companies/{company}/role-assignments` returns active privileged assignments for authorized revokers.
- `POST /identity/companies/{company}/role-assignments/{assignment}/revoke` immediately revokes access and target tokens.

Privileged mutations require an access token with `mfa_verified_at` no older than 15 minutes. Privileged assignments cannot be approved until the target user has active MFA.

Every role declares an `assignment_scope`. Company access requests reject global-only roles and validate that company, department, or location scope matches the role policy and the target's active organization membership.

Direct standard access is deliberately separate from the privileged maker-checker flow. It rejects privileged/global roles, self-assignment and self-revocation, overlapping periods, and any assignment period not fully covered by the target's company and organization memberships. Every mutation records an actor, reason, and append-only audit event.

Permission codes and system-role mappings are release-managed baselines. Runtime administration may create and maintain only non-global custom roles; global-only permissions cannot be attached to them, and roles with assignment or request history cannot be deleted.

Employment and organization placement are HR-owned through `identity.employment.manage`. IT/security owns global credential status through a global-only `identity.user.status.manage` assignment. A company-scoped role can never change global identity status, reactivation is rejected unless active employment exists, and an invited identity must complete invitation acceptance rather than being manually activated.

Token idle timeout is enforced before Sanctum updates `last_used_at`: ERP Web 30 minutes, Operations Web 2 hours, and Mobile 15 minutes. Absolute lifetime remains 12 hours, 24 hours, and 15 minutes respectively.

Mobile refresh tokens are stored server-side only as SHA-256 hashes, rotate on every use, and retain their consumed history for replay detection. Rotation does not extend the 30-day family expiry. Mobile clients must transmit them only over TLS and keep them in platform-protected secure storage, never ordinary preferences or logs.

The canonical payload and response definitions are in `packages/api-contract/openapi.yaml` (version 0.13.0).

## Verification

```powershell
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api composer validate --strict
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api php artisan test
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api ./vendor/bin/pint --test
```

The local PHP installation is not the production baseline. PHP 8.5 is enforced by `composer.json` and the API container.
