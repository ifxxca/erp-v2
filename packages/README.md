# Shared Packages

Packages:

- `api-contract/`: OpenAPI specification dan generated TypeScript schemas.
- `api-client-dart/`: generated Dart/Dio models dan transport client untuk Flutter.
- `web-ui/`: shared React design tokens/components untuk ERP dan Operations web.
- `tooling/`: lint, formatting, test, dan build configuration.

Business logic tidak boleh ditempatkan di shared frontend package.

`openapi.yaml` adalah sumber kebenaran contract. Jalankan `npm run contract:generate`
setelah mengubah schema, commit output TypeScript dan Dart, lalu gunakan
`npm run contract:check` untuk memastikan generated clients tidak tertinggal. Versi
`@rajawali/api-contract` dan `rajawali_api_client` mengikuti `info.version` pada OpenAPI.

Generator Dart memakai image OpenAPI Generator `v7.22.0`, Dart SDK `3.12.2`, dan
tooling lockfile yang dipin sehingga hanya memerlukan Docker pada host:

```powershell
npm run contract:generate:dart
npm run contract:check:dart
```

Isi `api-client-dart/` adalah generated artifact dan tidak diedit manual. Kebijakan
token storage, refresh coordination, idempotency, retry, serta offline draft berada di
adapter aplikasi Flutter, bukan di generated transport client.

ERP dan Operations Web memakai `openapi-fetch` di atas generated `paths`, sehingga path,
parameter, query, request body, dan response mengikuti contract saat compile. Auth,
idempotency, serta pemetaan error tetap berada pada adapter surface masing-masing;
multipart binary memakai upload URL sementara yang diterbitkan API.
