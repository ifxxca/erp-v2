# ADR-0001: Fresh Rebuild

Status: Accepted

## Decision

Membangun V2 di folder/project baru. Source legacy hanya digunakan untuk menemukan requirement dan edge case; tidak dijadikan foundation V2.

## Reason

Schema, migration, authorization, flow, dan model legacy tidak cukup konsisten untuk refactor in-place dengan risiko terkendali.

## Consequence

Feature parity harus dipilih secara sadar dan product owner wajib memvalidasi flow baru.
