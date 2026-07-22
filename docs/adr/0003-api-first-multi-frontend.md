# ADR-0003: API-First Multi-Frontend

Status: Accepted

## Decision

Management ERP, Operations PWA, dan mobile menggunakan satu versioned API. Frontend dipisahkan berdasarkan persona, bukan satu aplikasi per domain.

## Consequence

OpenAPI, backward compatibility, permission, idempotency, dan offline behavior menjadi kebutuhan foundation.
