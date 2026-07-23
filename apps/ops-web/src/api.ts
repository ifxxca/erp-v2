const API_BASE_URL = (import.meta.env.VITE_API_BASE_URL ?? 'http://localhost:8000/api/v1').replace(/\/$/, '')

type ErrorPayload = { message?: string; code?: string; errors?: Record<string, string[]>; request_id?: string }

export class ApiError extends Error {
  status: number
  code: string
  errors?: Record<string, string[]>
  requestId?: string

  constructor(
    status: number,
    code: string,
    message: string,
    errors?: Record<string, string[]>,
    requestId?: string,
  ) {
    super(message)
    this.status = status
    this.code = code
    this.errors = errors
    this.requestId = requestId
  }
}

export async function apiRequest<T>(path: string, options: RequestInit = {}, token?: string): Promise<T> {
  const headers = new Headers(options.headers)
  headers.set('Accept', 'application/json')
  if (options.body) headers.set('Content-Type', 'application/json')
  if (token) headers.set('Authorization', `Bearer ${token}`)
  if (options.method && !['GET', 'HEAD'].includes(options.method)) headers.set('Idempotency-Key', crypto.randomUUID())
  const response = await fetch(`${API_BASE_URL}${path}`, { ...options, headers })
  if (response.status === 204) return undefined as T
  const payload = await response.json().catch(() => ({})) as ErrorPayload
  if (!response.ok) throw new ApiError(response.status, payload.code ?? 'REQUEST_FAILED', payload.message ?? 'Permintaan gagal.', payload.errors, payload.request_id)
  return payload as T
}

async function apiMultipart<T>(path: string, form: FormData, token: string): Promise<T> {
  const headers = new Headers({ Accept: 'application/json', Authorization: `Bearer ${token}` })
  const response = await fetch(`${API_BASE_URL}${path}`, { method: 'POST', headers, body: form })
  const payload = await response.json().catch(() => ({})) as ErrorPayload
  if (!response.ok) throw new ApiError(response.status, payload.code ?? 'UPLOAD_FAILED', payload.message ?? 'Upload gagal.', payload.errors, payload.request_id)
  return payload as T
}

export type FileAsset = {
  id: string; original_name: string; status: string; scan_status: string; rejection_reason: string | null
}

export async function uploadChecklistEvidence(companyId: string, file: File, token: string): Promise<FileAsset> {
  const bytes = new Uint8Array(await crypto.subtle.digest('SHA-256', await file.arrayBuffer()))
  const checksum = Array.from(bytes, (value) => value.toString(16).padStart(2, '0')).join('')
  const initiated = await apiRequest<{ data: FileAsset; upload: { url: string } }>(`/companies/${companyId}/files`, {
    method: 'POST',
    body: JSON.stringify({
      purpose: 'checklist_evidence', original_name: file.name, mime_type: file.type,
      size: file.size, checksum_sha256: checksum,
    }),
  }, token)
  const uploadPath = initiated.upload.url.replace(/^\/api\/v1/, '')
  const form = new FormData()
  form.set('file', file)
  await apiMultipart(uploadPath, form, token)
  let asset = (await apiRequest<{ data: FileAsset }>(`/companies/${companyId}/files/${initiated.data.id}/finalize`, {
    method: 'POST',
  }, token)).data

  for (let attempt = 0; attempt < 40 && ['quarantined', 'uploaded'].includes(asset.status); attempt += 1) {
    await new Promise((resolve) => window.setTimeout(resolve, 500))
    asset = (await apiRequest<{ data: FileAsset }>(`/companies/${companyId}/files/${asset.id}`, {}, token)).data
  }
  if (asset.status !== 'ready') {
    throw new ApiError(409, 'CHECKLIST_EVIDENCE_NOT_READY', asset.rejection_reason ?? 'Evidence belum lolos pemeriksaan keamanan.')
  }

  return asset
}

export async function downloadEvidence(companyId: string, file: FileAsset, token: string): Promise<void> {
  const response = await fetch(`${API_BASE_URL}/companies/${companyId}/files/${file.id}/download`, {
    headers: { Accept: 'application/octet-stream', Authorization: `Bearer ${token}` },
  })
  if (!response.ok) {
    const payload = await response.json().catch(() => ({})) as ErrorPayload
    throw new ApiError(response.status, payload.code ?? 'DOWNLOAD_FAILED', payload.message ?? 'Evidence tidak dapat diunduh.')
  }
  const url = URL.createObjectURL(await response.blob())
  const anchor = document.createElement('a')
  anchor.href = url
  anchor.download = file.original_name
  document.body.appendChild(anchor)
  anchor.click()
  anchor.remove()
  window.setTimeout(() => URL.revokeObjectURL(url), 1000)
}

export type LoginResponse = { access_token: string; mfa_required: boolean }
export type OperationsContext = {
  company: { id: string; code: string; legal_name: string }
  location: { id: string; code: string; name: string; timezone: string }
  capabilities: {
    can_view_vehicles: boolean
    can_manage_vehicles: boolean
    can_view_work_orders: boolean
    can_manage_work_orders: boolean
    can_view_trips: boolean
    can_operate_trips: boolean
    can_manage_trips: boolean
  }
}
export type VehicleType = { id: string; code: string; name: string }
export type Vehicle = {
  id: string; code: string; plate_number: string; brand: string; model: string; model_year: number | null
  ownership_type: string; current_odometer: number; operational_status: string; status_reason: string | null
  type: VehicleType
}
export type WorkOrderJob = { id: string; description: string; status: string; labor_cost: string }
export type WorkOrder = {
  id: string; document_number: string | null; work_order_date: string; priority: string; status: string
  problem_description: string; total_cost: string; vehicle: Vehicle; jobs: WorkOrderJob[]
}
export type ChecklistItem = {
  id: string; code: string; label: string; line_number: number; is_required: boolean; is_critical: boolean
}
export type ChecklistTemplate = {
  id: string; code: string; name: string; version: number; items: ChecklistItem[]
}
export type VehicleTrip = {
  id: string; status: string; purpose: string; destination: string | null
  start_odometer: number; end_odometer: number | null; departed_at: string; arrived_at: string | null
  cancel_reason: string | null; vehicle: Vehicle; driver: { id: string; name: string; email: string }
  checklist?: {
    submitted_at: string
    answers: Array<{
      id: string; result: string; note: string | null; item: ChecklistItem; evidence_files: FileAsset[]
    }>
  }
}
export type Page<T> = { data: T[]; current_page: number; last_page: number; total: number }
