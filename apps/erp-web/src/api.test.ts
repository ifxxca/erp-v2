import { afterEach, describe, expect, it, vi } from 'vitest'
import { challengeMfa, createRole, listIdentityUsers, revokeDeviceSession } from './api'

const jsonResponse = (body: unknown, status = 200) => new Response(JSON.stringify(body), {
  status,
  headers: { 'Content-Type': 'application/json', 'X-Request-ID': 'req-erp-test' },
})

afterEach(() => vi.unstubAllGlobals())

describe('ERP typed API client', () => {
  it('adds bearer and idempotency headers to MFA mutations', async () => {
    const fetchMock = vi.fn(async (_request: Request) => jsonResponse({
      status: 'verified', method: 'totp', step_up_expires_at: '2026-07-23T08:00:00Z',
    }))
    vi.stubGlobal('fetch', fetchMock)

    await challengeMfa('access-token', '123456')

    const request = fetchMock.mock.calls[0][0] as Request
    expect(request.url).toBe('http://localhost:8000/api/v1/auth/mfa/challenge')
    expect(request.headers.get('Authorization')).toBe('Bearer access-token')
    expect(request.headers.get('Idempotency-Key')).toHaveLength(36)
    await expect(request.clone().json()).resolves.toEqual({ credential: '123456' })
  })

  it('serializes typed identity filters without mutation headers on GET', async () => {
    const fetchMock = vi.fn(async (_request: Request) => jsonResponse({
      data: [], current_page: 2, last_page: 3, total: 41,
    }))
    vi.stubGlobal('fetch', fetchMock)

    await listIdentityUsers('company-01', { page: 2, search: 'dian', status: 'active', per_page: 20 }, 'access-token')

    const request = fetchMock.mock.calls[0][0] as Request
    expect(request.url).toBe('http://localhost:8000/api/v1/identity/companies/company-01/users?page=2&search=dian&status=active&per_page=20')
    expect(request.headers.has('Idempotency-Key')).toBe(false)
  })

  it('uses typed role bodies and returns the created identifier', async () => {
    const fetchMock = vi.fn(async (_request: Request) => jsonResponse({ data: { id: 'role-01' } }, 201))
    vi.stubGlobal('fetch', fetchMock)

    const roleId = await createRole({
      code: 'fleet-supervisor',
      name: 'Fleet Supervisor',
      description: null,
      assignment_scope: 'location',
      is_privileged: true,
      permission_ids: ['permission-01'],
      reason: 'Required for fleet supervision.',
    }, 'access-token')

    expect(roleId).toBe('role-01')
    const request = fetchMock.mock.calls[0][0] as Request
    expect(request.headers.get('Idempotency-Key')).toHaveLength(36)
    await expect(request.clone().json()).resolves.toMatchObject({ code: 'fleet-supervisor', assignment_scope: 'location' })
  })

  it('coerces the session identifier at the typed path boundary and maps API errors', async () => {
    const fetchMock = vi.fn(async (_request: Request) => jsonResponse({
      message: 'Session was not found.',
      code: 'RESOURCE_NOT_FOUND',
      request_id: 'req-erp-test',
    }, 404))
    vi.stubGlobal('fetch', fetchMock)

    const failure = revokeDeviceSession('42', 'access-token')

    await expect(failure).rejects.toMatchObject({
      status: 404,
      code: 'RESOURCE_NOT_FOUND',
      requestId: 'req-erp-test',
    })
    expect((fetchMock.mock.calls[0][0] as Request).url).toBe('http://localhost:8000/api/v1/auth/sessions/42')
  })
})
