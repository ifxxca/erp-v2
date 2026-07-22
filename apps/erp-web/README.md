# Management ERP Web

React/TypeScript/Vite frontend for management and administrative workflows.

The first implemented workspace is Identity Administration:

- access-token login and MFA challenge handling;
- server-scoped legal-entity selector and capability-driven controls;
- searchable identity directory with employment and organization history;
- effective-dated department/location changes for HR administrators;
- global suspend, disable, and re-enable controls for security administrators;
- destructive-action confirmation and responsive desktop/mobile layouts.

The Privileged Access Review workspace adds:

- capability-driven maker history, approval queue, and active assignment tabs;
- target catalog constrained by active employment and organization memberships;
- explicit role scope and expiry selection with MFA-readiness warnings;
- maker/target/approver separation in the UI and API;
- approve, reject, and immediate-revocation dialogs with required confirmation.

```powershell
npm run dev:erp
```

API URL is configured through `.env` using `VITE_API_BASE_URL`.

The current bearer token is kept in `sessionStorage` and never local persistent storage. This is an interim first-party web implementation; the target production boundary remains a secure HTTP-only cookie/BFF as described in the architecture documents.
