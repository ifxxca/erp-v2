import type { components, paths } from '@rajawali/api-contract'
import createClient from 'openapi-fetch'

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

function apiClient(token?: string) {
  const client = createClient<paths>({ baseUrl: API_BASE_URL })
  client.use({
    onRequest({ request }) {
      request.headers.set('Accept', 'application/json')
      if (token) request.headers.set('Authorization', `Bearer ${token}`)
      if (!['GET', 'HEAD'].includes(request.method) && !request.headers.has('Idempotency-Key')) {
        request.headers.set('Idempotency-Key', crypto.randomUUID())
      }
      return request
    },
  })
  return client
}

function unwrap<T>(result: { data?: T; error?: unknown; response: Response }): T {
  if (!result.response.ok) {
    const payload = (result.error ?? {}) as ErrorPayload
    throw new ApiError(result.response.status, payload.code ?? 'REQUEST_FAILED', payload.message ?? 'Permintaan gagal.', payload.errors, payload.request_id)
  }
  return result.data as T
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
export type LoginResponse = Contract['TokenResponse']
export type OperationsContext = Contract['OperationsContext']
export type VehicleType = Contract['VehicleType']
export type Vehicle = Contract['Vehicle']
export type WorkOrderJob = Contract['WorkOrderJob']
export type WorkOrder = Contract['MaintenanceWorkOrder']
export type ChecklistItem = Contract['ChecklistTemplateItem']
export type ChecklistTemplate = Contract['ChecklistTemplate']
export type VehicleTrip = Contract['VehicleTrip']
export type CreateVehicleInput = Contract['CreateVehicleRequest']
export type CreateVehicleTypeInput = Contract['CreateVehicleTypeRequest']
export type CreateWorkOrderInput = Contract['CreateWorkOrderRequest']
export type CheckoutVehicleInput = Contract['CheckoutVehicleRequest']
export type CheckInVehicleInput = Contract['CheckInVehicleRequest']
export type CancelVehicleTripInput = Contract['CancelVehicleTripRequest']
export type VehicleStatus = Contract['VehicleStatus']
export type WorkOrderTransitionInput = Contract['TransitionWorkOrderRequest']
export type OperationsScope = { companyId: string; locationId: string }

export async function loginOperations(email: string, password: string): Promise<LoginResponse> {
  return unwrap(await apiClient().POST('/auth/login', {
    body: { email, password, surface: 'ops_web', device_name: navigator.userAgent.slice(0, 120) },
  })) as LoginResponse
}

export async function logoutOperations(token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/auth/logout'))
}

export async function challengeOperationsMfa(token: string, credential: string): Promise<void> {
  unwrap(await apiClient(token).POST('/auth/mfa/challenge', { body: { credential } }))
}

export async function getOperationsContexts(token: string): Promise<OperationsContext[]> {
  return unwrap(await apiClient(token).GET('/operations/context')).data
}

export async function listVehicles(scope: OperationsScope, token: string): Promise<Contract['VehiclePage']> {
  return unwrap(await apiClient(token).GET('/companies/{companyId}/locations/{locationId}/fleet/vehicles', {
    params: { path: scope, query: { per_page: 100 } },
  }))
}

export async function listVehicleTypes(scope: OperationsScope, token: string): Promise<VehicleType[]> {
  return unwrap(await apiClient(token).GET('/companies/{companyId}/locations/{locationId}/fleet/vehicle-types', {
    params: { path: scope },
  })).data
}

export async function listWorkOrders(scope: OperationsScope, token: string): Promise<Contract['WorkOrderPage']> {
  return unwrap(await apiClient(token).GET('/companies/{companyId}/locations/{locationId}/maintenance/work-orders', {
    params: { path: scope, query: { per_page: 100 } },
  }))
}

export async function listVehicleTrips(scope: OperationsScope, token: string): Promise<Contract['VehicleTripPage']> {
  return unwrap(await apiClient(token).GET('/companies/{companyId}/locations/{locationId}/fleet/trips', {
    params: { path: scope, query: { per_page: 100 } },
  }))
}

export async function getChecklistTemplate(scope: OperationsScope, token: string): Promise<ChecklistTemplate> {
  return unwrap(await apiClient(token).GET('/companies/{companyId}/locations/{locationId}/fleet/checklist-template', {
    params: { path: scope },
  })).data as ChecklistTemplate
}

export async function getVehicleTrip(scope: OperationsScope, vehicleTripId: string, token: string): Promise<VehicleTrip> {
  return unwrap(await apiClient(token).GET('/companies/{companyId}/locations/{locationId}/fleet/trips/{vehicleTripId}', {
    params: { path: { ...scope, vehicleTripId } },
  })).data as VehicleTrip
}

export async function createVehicleType(scope: OperationsScope, body: CreateVehicleTypeInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/companies/{companyId}/locations/{locationId}/fleet/vehicle-types', {
    params: { path: scope }, body,
  }))
}

export async function createVehicle(scope: OperationsScope, body: CreateVehicleInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/companies/{companyId}/locations/{locationId}/fleet/vehicles', {
    params: { path: scope }, body,
  }))
}

export async function changeVehicleStatus(scope: OperationsScope, vehicleId: string, status: VehicleStatus, reason: string, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/companies/{companyId}/locations/{locationId}/fleet/vehicles/{vehicleId}/status', {
    params: { path: { ...scope, vehicleId } }, body: { status, reason },
  }))
}

export async function createWorkOrder(scope: OperationsScope, body: CreateWorkOrderInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/companies/{companyId}/locations/{locationId}/maintenance/work-orders', {
    params: { path: scope }, body,
  }))
}

export async function transitionWorkOrder(scope: OperationsScope, workOrderId: string, body: WorkOrderTransitionInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/companies/{companyId}/locations/{locationId}/maintenance/work-orders/{workOrderId}/transition', {
    params: { path: { ...scope, workOrderId } }, body,
  }))
}

export async function checkoutVehicle(scope: OperationsScope, body: CheckoutVehicleInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/companies/{companyId}/locations/{locationId}/fleet/trips/checkout', {
    params: { path: scope }, body,
  }))
}

export async function checkInVehicle(scope: OperationsScope, vehicleTripId: string, body: CheckInVehicleInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/companies/{companyId}/locations/{locationId}/fleet/trips/{vehicleTripId}/check-in', {
    params: { path: { ...scope, vehicleTripId } }, body,
  }))
}

export async function cancelVehicleTrip(scope: OperationsScope, vehicleTripId: string, body: CancelVehicleTripInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/companies/{companyId}/locations/{locationId}/fleet/trips/{vehicleTripId}/cancel', {
    params: { path: { ...scope, vehicleTripId } }, body,
  }))
}

export async function uploadChecklistEvidence(companyId: string, file: File, token: string): Promise<FileAsset> {
  const bytes = new Uint8Array(await crypto.subtle.digest('SHA-256', await file.arrayBuffer()))
  const checksum = Array.from(bytes, (value) => value.toString(16).padStart(2, '0')).join('')
  const initiated = unwrap(await apiClient(token).POST('/companies/{companyId}/files', {
    params: { path: { companyId } },
    body: {
      purpose: 'checklist_evidence', original_name: file.name,
      mime_type: file.type as Contract['InitiateFileRequest']['mime_type'],
      size: file.size, checksum_sha256: checksum,
    },
  }))
  const uploadPath = initiated.upload.url.replace(/^\/api\/v1/, '')
  const form = new FormData()
  form.set('file', file)
  await apiMultipart(uploadPath, form, token)
  let asset = unwrap(await apiClient(token).POST('/companies/{companyId}/files/{fileId}/finalize', {
    params: { path: { companyId, fileId: initiated.data.id } },
  })).data

  for (let attempt = 0; attempt < 40 && ['quarantined', 'uploaded'].includes(asset.status); attempt += 1) {
    await new Promise((resolve) => window.setTimeout(resolve, 500))
    asset = unwrap(await apiClient(token).GET('/companies/{companyId}/files/{fileId}', {
      params: { path: { companyId, fileId: asset.id } },
    })).data
  }
  if (asset.status !== 'ready') {
    throw new ApiError(409, 'CHECKLIST_EVIDENCE_NOT_READY', asset.rejection_reason ?? 'Evidence belum lolos pemeriksaan keamanan.')
  }

  return asset
}

export async function downloadEvidence(companyId: string, file: Pick<FileAsset, 'id' | 'original_name'>, token: string): Promise<void> {
  const result = await apiClient(token).GET('/companies/{companyId}/files/{fileId}/download', {
    params: { path: { companyId, fileId: file.id } }, parseAs: 'blob',
  })
  if (!result.response.ok && result.error instanceof Blob) {
    let payload: ErrorPayload = {}
    try { payload = JSON.parse(await result.error.text()) as ErrorPayload } catch { /* Non-JSON download failure. */ }
    throw new ApiError(result.response.status, payload.code ?? 'DOWNLOAD_FAILED', payload.message ?? 'Evidence tidak dapat diunduh.', payload.errors, payload.request_id)
  }
  const url = URL.createObjectURL(unwrap(result))
  const anchor = document.createElement('a')
  anchor.href = url
  anchor.download = file.original_name
  document.body.appendChild(anchor)
  anchor.click()
  anchor.remove()
  window.setTimeout(() => URL.revokeObjectURL(url), 1000)
}
