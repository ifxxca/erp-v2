# Operations Web

Mobile-first React/TypeScript/Vite frontend for operational workflows. Fleet and Maintenance is the first pilot.

The current slice includes login/MFA, access-derived company/location selection, vehicle and vehicle-type registration, canonical vehicle status controls, and maintenance work-order lifecycle actions. It uses the same versioned API intended for the future mobile client.

```powershell
npm run dev:ops
```

API URL is configured through `.env` using `VITE_API_BASE_URL`.
