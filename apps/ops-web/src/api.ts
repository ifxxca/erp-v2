import type { components } from '@rajawali/api-contract'

const API_BASE_URL = (import.meta.env.VITE_API_BASE_URL ?? 'http://localhost:8000/api/v1').replace(/\/$/, '')

type ErrorPayload = { message?: string; code?: string; errors?: Record<string, string[]>; request_id?: string }
type Contract = components['schemas']

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

export type FileAsset = Contract['FileAsset']
export type EvidenceFile = Contract['ChecklistEvidence']

export async function uploadChecklistEvidence(companyId: string, file: File, token: string): Promise<FileAsset> {
  const bytes = new Uint8Array(await crypto.subtle.digest('SHA-256', await file.arrayBuffer()))
  const checksum = Array.from(bytes, (value) => value.toString(16).padStart(2, '0')).join('')
  const initiated = await apiRequest<Contract['FileInitiatedResponse']>(`/companies/${companyId}/files`, {
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
  let asset = (await apiRequest<Contract['FileResponse']>(`/companies/${companyId}/files/${initiated.data.id}/finalize`, {
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

export async function downloadEvidence(companyId: string, file: Pick<FileAsset, 'id' | 'original_name'>, token: string): Promise<void> {
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

export type LoginResponse = Contract['TokenResponse']
export type OperationsContext = Contract['OperationsContext']
export type VehicleType = Contract['VehicleType']
export type Vehicle = Contract['Vehicle']
export type WorkOrderJob = Contract['WorkOrderJob']
export type WorkOrder = Contract['MaintenanceWorkOrder']
export type ChecklistItem = Contract['ChecklistTemplateItem']
export type ChecklistTemplate = Contract['ChecklistTemplate']
export type VehicleTrip = Contract['VehicleTrip']
export type Page<T> = { data: T[]; current_page: number; last_page: number; total: number }
