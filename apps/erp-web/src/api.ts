import type { components, paths } from '@rajawali/api-contract'
import createClient from 'openapi-fetch'

const API_BASE_URL = (import.meta.env.VITE_API_BASE_URL ?? 'http://localhost:8000/api/v1').replace(/\/$/, '')
type Contract = components['schemas']

type ApiErrorPayload = {
  message?: string
  code?: string
  request_id?: string
  errors?: Record<string, string[]>
}

export class ApiError extends Error {
  status: number
  code?: string
  requestId?: string
  errors?: Record<string, string[]>

  constructor(status: number, payload: ApiErrorPayload) {
    super(payload.message ?? 'Permintaan tidak dapat diproses.')
    this.name = 'ApiError'
    this.status = status
    this.code = payload.code
    this.requestId = payload.request_id
    this.errors = payload.errors
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
    throw new ApiError(result.response.status, (result.error ?? {}) as ApiErrorPayload)
  }
  return result.data as T
}

export type CurrentUser = Contract['CurrentUser']
export type PlatformNotification = Contract['PlatformNotification']
export type NotificationPage = Contract['NotificationPage']
export type Company = Contract['IdentityCompany']
export type Organization = Contract['OrganizationCatalog']
export type CompanyMembership = Contract['CompanyMembership']
export type DepartmentMembership = Contract['DepartmentMembership']
export type LocationMembership = Contract['LocationMembership']
export type IdentityUser = Contract['IdentityUser']
export type IdentityStatus = Contract['IdentityStatus']
export type MutableIdentityStatus = Contract['ChangeIdentityStatusRequest']['status']
export type LoginResponse = Contract['TokenResponse']
export type MfaStatus = Contract['MfaStatus']
export type MfaEnrollment = Contract['TotpEnrollment']
export type DeviceSession = Contract['DeviceSession']
export type RoleCatalogPermission = Contract['RoleCatalogPermission']
export type ManagedRole = Contract['ManagedRole']
export type RoleCatalog = Contract['RoleCatalogResponse']
export type StandardAccessRole = Contract['StandardAccessRole']
export type StandardRoleAssignment = Contract['StandardRoleAssignment']
export type StandardAccessCatalog = Contract['StandardAccessCatalogResponse']
export type AccessCatalogUser = Contract['AccessCatalogUser']
export type AccessRole = Contract['AccessCatalogRole']
export type AccessRequest = Contract['PrivilegedAccessRequest']
export type AccessRequestStatus = Contract['AccessRequestStatus']
export type RoleAssignment = Contract['PrivilegedRoleAssignment']
export type AccessRequestPage = Contract['AccessRequestPage']
export type RoleAssignmentPage = Contract['RoleAssignmentPage']
export type IdentityUserPage = Contract['IdentityUserPage']
export type CreateInvitationInput = Contract['CreateInvitationRequest']
export type UpdateOrganizationMembershipsInput = Contract['UpdateOrganizationMembershipsRequest']
export type ChangeIdentityStatusInput = Contract['ChangeIdentityStatusRequest']
export type CreateRoleInput = Contract['CreateRoleRequest']
export type UpdateRoleInput = Contract['UpdateRoleRequest']
export type SyncRolePermissionsInput = Contract['SyncRolePermissionsRequest']
export type CreateStandardRoleAssignmentInput = Contract['CreateStandardRoleAssignmentRequest']
export type CreateAccessRequestInput = Contract['CreatePrivilegedAccessRequest']

export async function loginErp(email: string, password: string): Promise<LoginResponse> {
  return unwrap(await apiClient().POST('/auth/login', {
    body: { email, password, surface: 'erp_web', device_name: navigator.userAgent.slice(0, 120) },
  }))
}

export async function logoutErp(token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/auth/logout'))
}

export async function challengeMfa(token: string, credential: string): Promise<void> {
  unwrap(await apiClient(token).POST('/auth/mfa/challenge', { body: { credential } }))
}

export async function getCurrentUser(token: string): Promise<CurrentUser> {
  return unwrap(await apiClient(token).GET('/me'))
}

export async function listIdentityCompanies(token: string): Promise<Contract['IdentityCompanyCollection']> {
  return unwrap(await apiClient(token).GET('/identity/companies'))
}

export async function listIdentityUsers(
  companyId: string,
  query: { page?: number; search?: string; status?: Contract['IdentityStatus']; employment_status?: Contract['EmploymentStatus']; per_page?: number },
  token: string,
): Promise<IdentityUserPage> {
  return unwrap(await apiClient(token).GET('/identity/companies/{companyId}/users', {
    params: { path: { companyId }, query },
  }))
}

export async function getIdentityOrganization(companyId: string, token: string): Promise<Organization> {
  return unwrap(await apiClient(token).GET('/identity/companies/{companyId}/organization', {
    params: { path: { companyId } },
  })).data
}

export async function getIdentityUser(companyId: string, userId: string, token: string): Promise<IdentityUser> {
  return unwrap(await apiClient(token).GET('/identity/companies/{companyId}/users/{userId}', {
    params: { path: { companyId, userId } },
  })).data
}

export async function updateOrganizationMemberships(
  companyId: string,
  userId: string,
  body: UpdateOrganizationMembershipsInput,
  token: string,
): Promise<void> {
  unwrap(await apiClient(token).PUT('/identity/companies/{companyId}/users/{userId}/organization-memberships', {
    params: { path: { companyId, userId } }, body,
  }))
}

export async function changeIdentityStatus(userId: string, body: ChangeIdentityStatusInput, token: string): Promise<void> {
  unwrap(await apiClient(token).PATCH('/identity/users/{userId}/status', {
    params: { path: { userId } }, body,
  }))
}

export async function createUserInvitation(body: CreateInvitationInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/identity/users/invitations', { body }))
}

export async function getMfaStatus(token: string): Promise<MfaStatus> {
  return unwrap(await apiClient(token).GET('/auth/mfa'))
}

export async function listDeviceSessions(token: string): Promise<DeviceSession[]> {
  return unwrap(await apiClient(token).GET('/auth/sessions')).data
}

export async function enrollTotp(password: string, token: string): Promise<MfaEnrollment> {
  return unwrap(await apiClient(token).POST('/auth/mfa/totp/enroll', { body: { password } }))
}

export async function confirmTotp(code: string, token: string): Promise<string[]> {
  return unwrap(await apiClient(token).POST('/auth/mfa/totp/confirm', { body: { code } })).recovery_codes
}

export async function regenerateMfaRecoveryCodes(token: string): Promise<string[]> {
  return unwrap(await apiClient(token).POST('/auth/mfa/recovery-codes/regenerate')).recovery_codes
}

export async function disableTotp(password: string, token: string): Promise<void> {
  unwrap(await apiClient(token).DELETE('/auth/mfa/totp', { body: { password } }))
}

export async function revokeDeviceSession(tokenId: string, token: string): Promise<{ status: 'revoked'; current: boolean }> {
  return unwrap(await apiClient(token).DELETE('/auth/sessions/{tokenId}', {
    params: { path: { tokenId: Number(tokenId) } },
  })) as { status: 'revoked'; current: boolean }
}

export async function revokeAllDeviceSessions(password: string, keepCurrent: boolean, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/auth/sessions/revoke-all', {
    body: { password, keep_current: keepCurrent },
  }))
}

export async function listNotifications(token: string): Promise<NotificationPage> {
  return unwrap(await apiClient(token).GET('/notifications', {
    params: { query: { per_page: 20 } },
  }))
}

export async function markNotificationRead(notificationId: string, token: string): Promise<PlatformNotification> {
  return unwrap(await apiClient(token).PATCH('/notifications/{notificationId}/read', {
    params: { path: { notificationId } },
  })).data
}

export async function markAllNotificationsRead(token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/notifications/read-all'))
}

export async function listRoles(token: string): Promise<RoleCatalog> {
  return unwrap(await apiClient(token).GET('/identity/roles'))
}

export async function createRole(body: CreateRoleInput, token: string): Promise<string> {
  return unwrap(await apiClient(token).POST('/identity/roles', { body })).data.id
}

export async function updateRole(roleId: string, body: UpdateRoleInput, token: string): Promise<void> {
  unwrap(await apiClient(token).PATCH('/identity/roles/{roleId}', {
    params: { path: { roleId } }, body,
  }))
}

export async function syncRolePermissions(roleId: string, body: SyncRolePermissionsInput, token: string): Promise<void> {
  unwrap(await apiClient(token).PUT('/identity/roles/{roleId}/permissions', {
    params: { path: { roleId } }, body,
  }))
}

export async function deleteRole(roleId: string, reason: string, token: string): Promise<void> {
  unwrap(await apiClient(token).DELETE('/identity/roles/{roleId}', {
    params: { path: { roleId } }, body: { reason },
  }))
}

export async function listStandardRoleAssignments(companyId: string, userId: string, token: string): Promise<StandardAccessCatalog> {
  return unwrap(await apiClient(token).GET('/identity/companies/{companyId}/users/{userId}/role-assignments', {
    params: { path: { companyId, userId } },
  }))
}

export async function createStandardRoleAssignment(
  companyId: string,
  userId: string,
  body: CreateStandardRoleAssignmentInput,
  token: string,
): Promise<void> {
  unwrap(await apiClient(token).POST('/identity/companies/{companyId}/users/{userId}/role-assignments', {
    params: { path: { companyId, userId } }, body,
  }))
}

export async function revokeStandardRoleAssignment(
  companyId: string,
  userId: string,
  assignmentId: string,
  reason: string,
  token: string,
): Promise<void> {
  unwrap(await apiClient(token).POST('/identity/companies/{companyId}/users/{userId}/role-assignments/{assignmentId}/revoke', {
    params: { path: { companyId, userId, assignmentId } }, body: { reason },
  }))
}

export async function getPrivilegedAccessCatalog(companyId: string, token: string): Promise<Contract['AccessCatalogResponse']> {
  return unwrap(await apiClient(token).GET('/identity/companies/{companyId}/access-catalog', {
    params: { path: { companyId } },
  }))
}

export async function listMyAccessRequests(companyId: string, page: number, token: string): Promise<AccessRequestPage> {
  return unwrap(await apiClient(token).GET('/identity/companies/{companyId}/access-requests/mine', {
    params: { path: { companyId }, query: { page } },
  }))
}

export async function listAccessRequests(
  companyId: string,
  status: Contract['AccessRequestStatus'] | undefined,
  page: number,
  token: string,
): Promise<AccessRequestPage> {
  return unwrap(await apiClient(token).GET('/identity/companies/{companyId}/access-requests', {
    params: { path: { companyId }, query: { status, page } },
  }))
}

export async function listPrivilegedRoleAssignments(companyId: string, page: number, token: string): Promise<RoleAssignmentPage> {
  return unwrap(await apiClient(token).GET('/identity/companies/{companyId}/role-assignments', {
    params: { path: { companyId }, query: { page } },
  }))
}

export async function createAccessRequest(companyId: string, body: CreateAccessRequestInput, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/identity/companies/{companyId}/access-requests', {
    params: { path: { companyId } }, body,
  }))
}

export async function decideAccessRequest(
  companyId: string,
  accessRequestId: string,
  action: 'approve' | 'reject',
  note: string,
  token: string,
): Promise<void> {
  if (action === 'approve') {
    unwrap(await apiClient(token).POST('/identity/companies/{companyId}/access-requests/{accessRequestId}/approve', {
      params: { path: { companyId, accessRequestId } }, body: { note },
    }))
    return
  }
  unwrap(await apiClient(token).POST('/identity/companies/{companyId}/access-requests/{accessRequestId}/reject', {
    params: { path: { companyId, accessRequestId } }, body: { note },
  }))
}

export async function revokePrivilegedRoleAssignment(companyId: string, assignmentId: string, reason: string, token: string): Promise<void> {
  unwrap(await apiClient(token).POST('/identity/companies/{companyId}/role-assignments/{assignmentId}/revoke', {
    params: { path: { companyId, assignmentId } }, body: { reason },
  }))
}
