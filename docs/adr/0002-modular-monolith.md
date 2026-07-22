# ADR-0002: Modular Monolith Before Microservices

Status: Accepted

## Decision

Backend V2 dimulai sebagai satu API modular monolith dan satu database operasional.

## Reason

Tim perlu memperbaiki domain boundary dan transaction consistency sebelum menanggung kompleksitas network, distributed transaction, dan database per service.

## Consequence

Module boundary harus ditegakkan melalui struktur, interface, ownership tabel, dan architecture test.
