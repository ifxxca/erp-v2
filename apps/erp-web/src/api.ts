const API_BASE_URL = import.meta.env.VITE_API_BASE_URL ?? 'http://localhost:8000/api/v1'

export class ApiError extends Error {
  status: number
  code?: string
  errors?: Record<string, string[]>

  constructor(status: number, payload: ApiErrorPayload) {
    super(payload.message ?? 'Permintaan tidak dapat diproses.')
    this.name = 'ApiError'
    this.status = status
    this.code = payload.code
    this.errors = payload.errors
  }
}

type ApiErrorPayload = {
  message?: string
  code?: string
  errors?: Record<string, string[]>
}

export type CurrentUser = {
  id: string
  name: string
  email: string
  status: string
}

export type Company = {
  id: string
  code: string
  legal_name: string
  capabilities: {
    can_view_users: boolean
    can_invite_users: boolean
    can_manage_employment: boolean
    can_request_access: boolean
    can_approve_access: boolean
    can_revoke_access: boolean
  }
}

export type Organization = {
  company: Pick<Company, 'id' | 'code' | 'legal_name'>
  departments: Array<{ id: string; code: string; name: string; parent_id: string | null }>
  locations: Array<{ id: string; code: string; name: string; timezone: string }>
}

export type CompanyMembership = {
  id: string
  employee_no: string | null
  employment_status: string
  is_primary: boolean
  valid_from: string
  valid_until: string | null
}

export type DepartmentMembership = {
  id: string
  department: { id: string; code: string; name: string }
  is_primary: boolean
  valid_from: string
  valid_until: string | null
}

export type LocationMembership = {
  id: string
  location: { id: string; code: string; name: string; timezone: string }
  valid_from: string
  valid_until: string | null
}

export type IdentityUser = {
  id: string
  name: string
  email: string
  status: string
  last_login_at: string | null
  company_memberships: CompanyMembership[]
  department_memberships: DepartmentMembership[]
  location_memberships: LocationMembership[]
}

export type LoginResponse = {
  token_type: 'Bearer'
  access_token: string
  expires_at: string
  mfa_required: boolean
}

export type AccessCatalogUser = {
  id: string
  name: string
  email: string
  mfa_enabled: boolean
  department_ids: string[]
  location_ids: string[]
}

export type AccessRole = {
  id: string
  code: string
  name: string
  description: string | null
  assignment_scope: 'company' | 'department' | 'location'
}

export type AccessRequest = {
  id: string
  status: 'pending' | 'approved' | 'rejected' | 'cancelled'
  target_user: Pick<AccessCatalogUser, 'id' | 'name' | 'email'>
  target_mfa_enabled: boolean
  role: Pick<AccessRole, 'id' | 'code' | 'name'>
  company_id: string
  department_id: string | null
  location_id: string | null
  reason: string
  valid_until: string
  requested_by: { id: string; name: string }
  decided_by: { id: string; name: string } | null
  decided_at: string | null
  decision_note: string | null
}

export type RoleAssignment = {
  id: string
  user: Pick<AccessCatalogUser, 'id' | 'name' | 'email'>
  role: Pick<AccessRole, 'id' | 'code' | 'name' | 'assignment_scope'>
  company_id: string
  department_id: string | null
  location_id: string | null
  access_request_id: string | null
  valid_from: string
  valid_until: string | null
}

export type Page<T> = {
  data: T[]
  current_page: number
  last_page: number
  total: number
}

export async function apiRequest<T>(
  path: string,
  options: RequestInit = {},
  token?: string,
): Promise<T> {
  const headers = new Headers(options.headers)
  headers.set('Accept', 'application/json')
  if (options.body) headers.set('Content-Type', 'application/json')
  if (token) headers.set('Authorization', `Bearer ${token}`)

  const response = await fetch(`${API_BASE_URL}${path}`, { ...options, headers })
  if (response.status === 204) return undefined as T
  const payload = (await response.json().catch(() => ({}))) as ApiErrorPayload
  if (!response.ok) throw new ApiError(response.status, payload)

  return payload as T
}
