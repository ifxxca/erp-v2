# Rajawali Operations Mobile

Flutter Android/iOS shell untuk operasi lapangan. Aplikasi memakai generated
`rajawali_api_client` dari OpenAPI yang sama dengan ERP dan Operations Web.

Foundation yang sudah tersedia:

- compile-time environment dan API base URL validation;
- satu encrypted credential blob melalui OS secure storage;
- mobile login/rotating refresh gateway dari generated client;
- responsive login, MFA TOTP/recovery-code, restored-session, dan authenticated
  application shell;
- current-user dan access-derived company/location workspace dengan pemilihan
  area kerja serta capability projection;
- read-only Fleet dashboard dengan exact vehicle status totals, active trips,
  paginated vehicle list, dan stale-site response protection;
- proactive dan 401-triggered single-flight refresh;
- bearer injection, stable request ID saat retry, dan explicit idempotency context;
- local-session removal ketika refresh replay ditolak atau logout dilakukan;
- translated safe authentication errors tanpa mengekspos detail internal;
- retryable correlated context errors dan automatic local sign-out pada `401`;
- Android API 24 minimum dan iOS Keychain entitlement.

## Development

Versi yang dipin: Flutter `3.44.0` / Dart `3.12.0`.

```powershell
docker run --rm `
  -e PUB_CACHE=/workspace/apps/mobile/.pub-cache `
  -v ${PWD}:/workspace `
  -w /workspace/apps/mobile `
  ghcr.io/cirruslabs/flutter:3.44.0 flutter pub get --enforce-lockfile
```

Ganti command terakhir dengan `flutter analyze`, `flutter test`, atau
`flutter build apk --debug` sesuai kebutuhan.

Default local API adalah `http://10.0.2.2:8080/api/v1` untuk Android emulator.
Environment lain wajib menggunakan HTTPS:

```text
--dart-define=APP_ENV=staging
--dart-define=API_BASE_URL=https://api-staging.domain.com/api/v1
```

Cleartext HTTP hanya diizinkan oleh Android debug manifest. Release tidak
memiliki cleartext exception. iOS development sebaiknya memakai HTTPS staging.

## Security boundary

Access dan refresh token tidak boleh disimpan di preferences, database draft,
log, crash report, atau queue mutation. `MobileCredentials` disimpan sebagai
satu secure value agar token hasil rotasi tidak terpisah secara parsial.

Offline submission belum aktif. Mutation queue hanya boleh ditambahkan setelah
conflict, retention, encryption, dan replay policy disetujui.
