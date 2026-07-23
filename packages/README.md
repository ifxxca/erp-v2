# Shared Packages

Packages:

- `api-contract/`: OpenAPI specification dan generated TypeScript schemas.
- `web-ui/`: shared React design tokens/components untuk ERP dan Operations web.
- `tooling/`: lint, formatting, test, dan build configuration.

Business logic tidak boleh ditempatkan di shared frontend package.

`openapi.yaml` adalah sumber kebenaran contract. Jalankan `npm run contract:generate`
setelah mengubah schema, commit `packages/api-contract/src/generated.ts`, dan gunakan
`npm run contract:check` untuk memastikan generated types tidak tertinggal. Versi package
`@rajawali/api-contract` mengikuti `info.version` pada OpenAPI.

Operations Web memakai `openapi-fetch` di atas generated `paths`, sehingga path,
parameter, query, request body, dan response mengikuti contract saat compile. Auth,
idempotency, serta pemetaan error tetap berada pada adapter surface masing-masing;
multipart binary memakai upload URL sementara yang diterbitkan API.
