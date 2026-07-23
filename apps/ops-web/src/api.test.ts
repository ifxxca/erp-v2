import { afterEach, describe, expect, it, vi } from 'vitest'
import { challengeOperationsMfa, listVehicles } from './api'

const jsonResponse = (body: unknown, status = 200) => new Response(JSON.stringify(body), {
  status,
  headers: { 'Content-Type': 'application/json', 'X-Request-ID': 'req-test-1234' },
})

afterEach(() => vi.unstubAllGlobals())

describe('Operations typed API client', () => {
  it('sends the MFA credential with bearer and idempotency headers', async () => {
    const fetchMock = vi.fn(async (_request: Request) => jsonResponse({
      status: 'verified', method: 'totp', step_up_expires_at: '2026-07-23T08:00:00Z',
    }))
    vi.stubGlobal('fetch', fetchMock)

    await challengeOperationsMfa('access-token', '123456')

    const request = fetchMock.mock.calls[0][0] as Request
    expect(request.url).toBe('http://localhost:8000/api/v1/auth/mfa/challenge')
    expect(request.headers.get('Authorization')).toBe('Bearer access-token')
    expect(request.headers.get('Idempotency-Key')).toHaveLength(36)
    await expect(request.clone().json()).resolves.toEqual({ credential: '123456' })
  })

  it('serializes typed path and pagination params without mutation headers on GET', async () => {
    const fetchMock = vi.fn(async (_request: Request) => jsonResponse({
      data: [], current_page: 1, last_page: 1, total: 0,
    }))
    vi.stubGlobal('fetch', fetchMock)

    await listVehicles({ companyId: 'company-01', locationId: 'location-01' }, 'access-token')

    const request = fetchMock.mock.calls[0][0] as Request
    expect(request.url).toBe('http://localhost:8000/api/v1/companies/company-01/locations/location-01/fleet/vehicles?per_page=100')
    expect(request.headers.get('Authorization')).toBe('Bearer access-token')
    expect(request.headers.has('Idempotency-Key')).toBe(false)
  })

  it('maps the correlated API error envelope', async () => {
    vi.stubGlobal('fetch', vi.fn(async () => jsonResponse({
      message: 'Credential is invalid.',
      code: 'VALIDATION_FAILED',
      request_id: 'req-test-1234',
      errors: { credential: ['Credential is invalid.'] },
    }, 422)))

    const failure = challengeOperationsMfa('access-token', 'invalid')

    await expect(failure).rejects.toMatchObject({
      status: 422,
      code: 'VALIDATION_FAILED',
      requestId: 'req-test-1234',
      errors: { credential: ['Credential is invalid.'] },
    })
  })
})
