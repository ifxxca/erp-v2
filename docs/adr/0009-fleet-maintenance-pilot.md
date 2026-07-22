# ADR-0009: Fleet and Maintenance Pilot

Status: Accepted

## Decision

Vertical slice pertama setelah foundation adalah Fleet + Maintenance. PT Rajawali Kreatif Sentosa/Warehouse Kresek menjadi planning default untuk operational rollout pertama.

## Reason

Scope ini menguji company/location-scoped RBAC, API, audit, file/document, import, workflow, inventory part usage, serta responsive operations UI tanpa lebih dulu mengambil risiko payment posting.

## Consequence

Pilot dibatasi pada vehicle master, documents, checklist/odometer, service schedule, work order, dan dashboard minimum. Lokasi dapat dikoreksi sebelum onboarding berdasarkan fleet ownership mapping tanpa mengganti architecture.
