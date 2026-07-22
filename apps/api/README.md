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

## Identity endpoints

- `POST /auth/login` issues an expiring bearer token for `erp_web`, `ops_web`, or `mobile`.
- `POST /auth/logout` revokes the presented bearer token.
- `POST /auth/password/forgot|reset` performs non-enumerating, single-use password recovery.
- `POST /auth/invitations/accept` activates a single-use invitation.
- `GET /auth/mfa` returns MFA and current-token assurance status.
- `POST /auth/mfa/totp/enroll|confirm` enrolls an authenticator app and returns recovery codes once.
- `POST /auth/mfa/challenge` verifies TOTP or a single-use recovery code.
- `POST /auth/mfa/recovery-codes/regenerate` replaces recovery codes after recent MFA.
- `DELETE /auth/mfa/totp` disables optional MFA and revokes every token.
- `GET /auth/sessions` lists device sessions owned by the authenticated identity.
- `DELETE /auth/sessions/{token}` and `POST /auth/sessions/revoke-all` revoke device access.
- `GET /me` returns the active authenticated identity.
- `POST /identity/users/invitations` requires `identity.user.manage` in `company_id`.
- `POST /identity/users/{user}/companies/{company}/terminate` terminates scoped employment and revokes stale access.
- `GET /identity/companies/{company}/access-requests` returns the scoped approval queue.
- `POST /identity/companies/{company}/access-requests` creates a privileged request.
- `POST /identity/companies/{company}/access-requests/{request}/approve|reject` applies maker-checker policy.
- `POST /identity/companies/{company}/role-assignments/{assignment}/revoke` immediately revokes access and target tokens.

Privileged mutations require an access token with `mfa_verified_at` no older than 15 minutes. Privileged assignments cannot be approved until the target user has active MFA.

Token idle timeout is enforced before Sanctum updates `last_used_at`: ERP Web 30 minutes, Operations Web 2 hours, and Mobile 15 minutes. Absolute lifetime remains 12 hours, 24 hours, and 15 minutes respectively.

The canonical payload and response definitions are in `packages/api-contract/openapi.yaml`.

## Verification

```powershell
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api composer validate --strict
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api php artisan test
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api ./vendor/bin/pint --test
```

The local PHP installation is not the production baseline. PHP 8.5 is enforced by `composer.json` and the API container.
