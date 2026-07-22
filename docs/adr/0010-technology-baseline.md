# ADR-0010: Technology Baseline

Status: Accepted

## Decision

- Backend/API: Laravel 13 pada PHP 8.5.
- Database: PostgreSQL 18.
- Queue/cache: Redis.
- ERP/OPS web: React 19, TypeScript, dan Vite.
- Mobile: Flutter 3.44.
- File: private S3-compatible object storage.
- API contract: OpenAPI 3.1.

## Consequence

V2 dibuat sebagai workspace/monorepo dengan deployable API, ERP web, OPS web, worker, scheduler, dan kemudian mobile. Library shared tidak boleh memuat business rule. Patch/security update dipelihara rutin, sedangkan perubahan major memerlukan compatibility review.
