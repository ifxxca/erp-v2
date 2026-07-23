# Mobile Client Foundation

Status date: 2026-07-23

Dokumen ini menetapkan fondasi contract untuk aplikasi Flutter. Aplikasi mobile tetap menjadi deployment surface terpisah, tetapi memakai API, authorization, business rule, dan database yang sama dengan ERP serta Operations Web.

## Implemented boundary

- `packages/api-contract/openapi.yaml` tetap menjadi satu-satunya sumber contract.
- `packages/api-client-dart` adalah package `rajawali_api_client` dengan Dio, built-value models, bearer interceptor, dan unknown-enum fallback.
- Package mencakup seluruh API `0.17.2`, termasuk login surface mobile, rotating refresh token, operations context, Fleet/trip/checklist, dan private-file lifecycle.
- OpenAPI Generator `7.22.0`, Dart SDK `3.12.2`, dan build dependency lockfile dipin serta dijalankan melalui Docker.
- Generated source dan output build-runner di-commit. CI meregenerasi package, menjalankan dependency resolution/build/static analysis, lalu menolak drift atau file generated baru yang belum di-commit.
- `apps/mobile` menyediakan Flutter 3.44 Android/iOS shell, environment guard, secure credential blob, generated authentication gateway, single-flight token rotation, request correlation, serta explicit mutation context.
- Flow aplikasi memilih login, MFA challenge, atau authenticated shell dari secure-session state; MFA sukses memperbarui credential blob secara atomic, sedangkan challenge dengan sesi ditolak menghapus seluruh credential lokal.
- Login dan MFA memiliki validasi input, busy-state, safe localized error mapping, device-session label per platform, dan widget test untuk lifecycle login sampai logout.

Generated package adalah transport/model layer, bukan aplikasi dan bukan tempat business policy.

## Application adapter responsibilities

Aplikasi Flutter menyediakan adapter tipis di atas generated client untuk:

- menyimpan access/refresh token sebagai satu blob dalam secure storage OS, bukan preferences atau log;
- menginjeksi bearer token serta request ID pada setiap request;
- menjalankan hanya satu refresh request saat beberapa request menerima unauthorized secara bersamaan;
- menyimpan refresh-token hasil rotasi sebagai satu secure write sebelum request lain dilanjutkan;
- membuat satu `Idempotency-Key` per logical mutation dan memakai key yang sama saat retry;
- tidak melakukan automatic retry mutation tanpa stable idempotency key;
- memetakan correlated API error tanpa mengekspos detail internal;
- memisahkan offline draft dari submitted server state;
- menghapus credential dan local sensitive state saat logout, revocation, atau refresh replay ditolak.

## Offline safety baseline

Offline mode awal hanya menyimpan draft input. Checkout, check-in, perubahan odometer, status kendaraan, attachment final, dan command lain belum dianggap berhasil sampai server menerima serta mengembalikan response sukses. Server tetap menjadi authority untuk availability, permission, checklist version, timestamp, dan conflict resolution.

Queue lokal harus menyimpan logical command ID, idempotency key, payload version, target environment, creation time, serta status retry. Queue tidak boleh menyimpan access token di payload. Policy konflik dan expiry draft harus diputuskan sebelum offline submission diaktifkan.

## Commands

```powershell
npm run contract:generate:dart
npm run contract:check:dart
```

Kedua command memerlukan Docker daemon. File di `packages/api-client-dart` tidak diedit manual. Ubah OpenAPI atau generator config, lalu regenerate seluruh package.

## Next production gate

Fleet domain UI dapat dikembangkan tanpa menganggap aplikasi siap didistribusikan. Distribusi production dan offline capability memerlukan minimum berikut disetujui:

1. production hostname, certificate policy, signing identity, dan application ID final;
2. biometric requirement untuk membuka credential atau tindakan tertentu;
3. device-registration behavior dan copy final untuk revoked/replayed session;
4. local database encryption, draft retention, serta conflict policy;
5. push-notification provider dan deep-link ownership;
6. device-level integration tests untuk login/MFA/refresh/replay, Fleet checkout/check-in, evidence upload, retry, dan revoked session.
