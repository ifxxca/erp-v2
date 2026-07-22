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
- `POST /auth/invitations/accept` activates a single-use invitation.
- `GET /me` returns the active authenticated identity.
- `POST /identity/users/invitations` requires `identity.user.manage` in `company_id`.
- `POST /identity/users/{user}/companies/{company}/terminate` terminates scoped employment and revokes stale access.

The canonical payload and response definitions are in `packages/api-contract/openapi.yaml`.

## Verification

```powershell
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api composer validate --strict
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api php artisan test
docker compose --env-file infrastructure/.env.example -f infrastructure/compose.yaml run --rm api ./vendor/bin/pint --test
```

The local PHP installation is not the production baseline. PHP 8.5 is enforced by `composer.json` and the API container.
