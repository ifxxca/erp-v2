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
}
export type Page<T> = { data: T[]; current_page: number; last_page: number; total: number }
