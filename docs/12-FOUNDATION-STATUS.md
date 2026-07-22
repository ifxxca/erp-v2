# Foundation Implementation Status

Status date: 2026-07-22

## Implemented

- Laravel 13 API with PHP 8.5 production constraint.
- Sanctum API authentication foundation and versioned `/api/v1/me` contract.
- ULID identity schema for companies, departments, locations, memberships, roles, permissions, access requests, and role assignments.
- Seed data for two legal entities, eight departments per company, initial system roles, and initial permission catalog.
- Company-aware permission resolver with active employment and assignment checks.
- React 19/TypeScript/Vite scaffolds for Management ERP and Operations Web.
- npm workspace plus shared API-contract and web-UI packages.
- PostgreSQL 18, Redis 8, MinIO, and Mailpit local compose definition.
- PHP 8.5 API development container definition.
- CI jobs for PostgreSQL migration/seed validation, PHP tests/format/audit, and web build/lint.

## Verified locally

- API test suite: 8 tests, 22 assertions.
- SQLite clean migration used by fast automated tests.
- Foundation seeder repeatability.
- Cross-company permission isolation and disabled-user deny behavior.
- ERP and Operations production builds.
- Web lint.
- Frontend tooling is isolated from the legacy parent PostCSS/Tailwind configuration.
- Composer strict validation.
- Composer dependency security audit.
- Docker Compose configuration parsing.

## Pending environment verification

PostgreSQL migration and PHP 8.5 container execution could not be run locally because Docker Desktop daemon was unable to start. CI is configured to run the same migration against PostgreSQL 18. This item is an environment limitation, not a passing test claim.

## Intentionally not implemented yet

- Invite/login/reset/MFA endpoints and UI.
- Privileged access request commands and approval policies.
- Session absolute-lifetime middleware and refresh-token family implementation.
- Organization/access administration screens.
- OpenAPI generated clients.
- Fleet/Maintenance domain migrations and flows.
- Flutter mobile application.

These belong to the next identity vertical slice; the scaffold must not be described as production-ready authentication.
