import { type FormEvent, useCallback, useEffect, useMemo, useState } from 'react'
import './App.css'
import AccessReview from './AccessReview'
import {
  ApiError,
  apiRequest,
  type Company,
  type CurrentUser,
  type IdentityUser,
  type LoginResponse,
  type Organization,
} from './api'

type AuthStage = 'login' | 'mfa' | 'loading' | 'ready'
type Workspace = 'identity' | 'access'

type CompanyResponse = {
  data: Company[]
  meta: { can_manage_identity_status: boolean }
}

type UserPage = {
  data: IdentityUser[]
  current_page: number
  last_page: number
  total: number
}

const tomorrow = () => {
  const date = new Date()
  date.setDate(date.getDate() + 1)
  return date.toISOString().slice(0, 10)
}

const formatDate = (value: string | null) =>
  value ? new Intl.DateTimeFormat('id-ID', { dateStyle: 'medium' }).format(new Date(value)) : 'Sekarang'

function App() {
  const [token, setToken] = useState(() => sessionStorage.getItem('erp_access_token') ?? '')
  const [stage, setStage] = useState<AuthStage>(token ? 'loading' : 'login')
  const [currentUser, setCurrentUser] = useState<CurrentUser | null>(null)
  const [workspace, setWorkspace] = useState<Workspace>('identity')
  const [companies, setCompanies] = useState<Company[]>([])
  const [canManageStatus, setCanManageStatus] = useState(false)
  const [companyId, setCompanyId] = useState('')
  const [organization, setOrganization] = useState<Organization | null>(null)
  const [users, setUsers] = useState<IdentityUser[]>([])
  const [totalUsers, setTotalUsers] = useState(0)
  const [page, setPage] = useState(1)
  const [lastPage, setLastPage] = useState(1)
  const [selectedUser, setSelectedUser] = useState<IdentityUser | null>(null)
  const [search, setSearch] = useState('')
  const [statusFilter, setStatusFilter] = useState('')
  const [appliedSearch, setAppliedSearch] = useState('')
  const [appliedStatus, setAppliedStatus] = useState('')
  const [busy, setBusy] = useState(false)
  const [message, setMessage] = useState('')
  const [error, setError] = useState('')

  const activeCompany = companies.find((company) => company.id === companyId) ?? null
  const canAccessReview = Boolean(activeCompany && (
    activeCompany.capabilities.can_request_access
    || activeCompany.capabilities.can_approve_access
    || activeCompany.capabilities.can_revoke_access
  ))

  const resetSession = useCallback(() => {
    sessionStorage.removeItem('erp_access_token')
    setToken('')
    setCurrentUser(null)
    setCompanies([])
    setCompanyId('')
    setSelectedUser(null)
    setStage('login')
  }, [])

  const handleError = useCallback(
    (cause: unknown) => {
      if (cause instanceof ApiError) {
        if (cause.status === 401) resetSession()
        if (cause.code === 'MFA_CHALLENGE_REQUIRED') setStage('mfa')
        setError(cause.message)
      } else {
        setError('API tidak dapat dijangkau. Periksa service dan konfigurasi URL.')
      }
    },
    [resetSession],
  )

  useEffect(() => {
    if (!token || stage === 'mfa') return
    let active = true
    Promise.all([
      apiRequest<CurrentUser>('/me', {}, token),
      apiRequest<CompanyResponse>('/identity/companies', {}, token),
    ])
      .then(([user, companyResponse]) => {
        if (!active) return
        setCurrentUser(user)
        setCompanies(companyResponse.data)
        setCanManageStatus(companyResponse.meta.can_manage_identity_status)
        setCompanyId((current) => current || companyResponse.data[0]?.id || '')
        setStage('ready')
      })
      .catch(handleError)
    return () => {
      active = false
    }
  }, [handleError, stage, token])

  const loadUsers = useCallback(async (requestedPage = page) => {
    if (!token || !companyId) return
    setBusy(true)
    setError('')
    try {
      const params = new URLSearchParams()
      if (appliedSearch) params.set('search', appliedSearch)
      if (appliedStatus) params.set('status', appliedStatus)
      params.set('page', String(requestedPage))
      const suffix = params.size ? `?${params}` : ''
      const [userPage, organizationResponse] = await Promise.all([
        apiRequest<UserPage>(`/identity/companies/${companyId}/users${suffix}`, {}, token),
        apiRequest<{ data: Organization }>(`/identity/companies/${companyId}/organization`, {}, token),
      ])
      setUsers(userPage.data)
      setTotalUsers(userPage.total)
      setPage(userPage.current_page)
      setLastPage(userPage.last_page)
      setOrganization(organizationResponse.data)
      setSelectedUser(null)
    } catch (cause) {
      handleError(cause)
    } finally {
      setBusy(false)
    }
  }, [appliedSearch, appliedStatus, companyId, handleError, page, token])

  useEffect(() => {
    if (stage === 'ready' && companyId) void loadUsers()
  }, [companyId, loadUsers, stage])

  async function selectUser(userId: string) {
    setBusy(true)
    setError('')
    try {
      const response = await apiRequest<{ data: IdentityUser }>(
        `/identity/companies/${companyId}/users/${userId}`,
        {},
        token,
      )
      setSelectedUser(response.data)
    } catch (cause) {
      handleError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function logout() {
    try {
      await apiRequest('/auth/logout', { method: 'POST' }, token)
    } finally {
      resetSession()
    }
  }

  if (stage === 'login') {
    return <LoginScreen onAuthenticated={(accessToken, needsMfa) => {
      sessionStorage.setItem('erp_access_token', accessToken)
      setToken(accessToken)
      setError('')
      setStage(needsMfa ? 'mfa' : 'loading')
    }} />
  }

  if (stage === 'mfa') {
    return <MfaScreen token={token} onVerified={() => setStage('loading')} onCancel={resetSession} />
  }

  if (stage === 'loading') {
    return <div className="center-state"><span className="spinner" />Menyiapkan workspace…</div>
  }

  return (
    <div className="app-shell">
      <aside className="sidebar">
        <div className="brand"><span>R</span><div>Rajawali<small>Platform V2</small></div></div>
        <nav aria-label="Navigasi utama">
          <button className={`nav-item ${workspace === 'identity' ? 'active' : ''}`} onClick={() => setWorkspace('identity')}><span>◫</span>Identity</button>
          <button className={`nav-item ${workspace === 'access' ? 'active' : ''}`} disabled={!canAccessReview} onClick={() => { setSelectedUser(null); setWorkspace('access') }}><span>◇</span>Access review</button>
          <button className="nav-item" disabled><span>⌁</span>Audit log</button>
        </nav>
        <div className="session-card">
          <div className="avatar">{currentUser?.name.slice(0, 2).toUpperCase()}</div>
          <div><strong>{currentUser?.name}</strong><small>{currentUser?.email}</small></div>
          <button onClick={() => void logout()} aria-label="Keluar">↗</button>
        </div>
      </aside>

      <main className="workspace">
        <header className="topbar">
          <div><p className="eyebrow">{workspace === 'identity' ? 'Identity administration' : 'Access governance'}</p><h1>{workspace === 'identity' ? 'Employee directory' : 'Privileged access review'}</h1></div>
          <label className="company-picker">Legal entity
            <select value={companyId} onChange={(event) => { setPage(1); setSelectedUser(null); setCompanyId(event.target.value) }}>
              {companies.map((company) => <option key={company.id} value={company.id}>{company.code} · {company.legal_name}</option>)}
            </select>
          </label>
        </header>

        {message && <div className="notice success" role="status">{message}<button onClick={() => setMessage('')}>×</button></div>}
        {error && <div className="notice error" role="alert">{error}<button onClick={() => setError('')}>×</button></div>}

        {workspace === 'identity' && <><section className="summary-grid">
          <article><span>Visible identities</span><strong>{totalUsers}</strong><small>Dalam scope {activeCompany?.code}</small></article>
          <article><span>Employment owner</span><strong>{activeCompany?.capabilities.can_manage_employment ? 'HR access' : 'Read only'}</strong><small>Effective-dated changes</small></article>
          <article><span>Global control</span><strong>{canManageStatus ? 'Enabled' : 'Restricted'}</strong><small>Suspend / disable identity</small></article>
        </section>

        <section className="directory-card">
          <form className="toolbar" onSubmit={(event) => { event.preventDefault(); const normalizedSearch = search.trim(); if (page === 1 && normalizedSearch === appliedSearch && statusFilter === appliedStatus) void loadUsers(1); setPage(1); setAppliedSearch(normalizedSearch); setAppliedStatus(statusFilter) }}>
            <label className="search-box"><span>⌕</span><input value={search} onChange={(event) => setSearch(event.target.value)} placeholder="Cari nama, email, atau nomor pegawai" /></label>
            <select value={statusFilter} onChange={(event) => setStatusFilter(event.target.value)} aria-label="Filter status identity">
              <option value="">Semua status</option><option value="active">Active</option><option value="invited">Invited</option><option value="suspended">Suspended</option><option value="disabled">Disabled</option>
            </select>
            <button className="secondary" type="submit">Terapkan</button>
          </form>

          <div className="table-wrap">
            <table>
              <thead><tr><th>Employee</th><th>Employment</th><th>Departments</th><th>Identity</th><th /></tr></thead>
              <tbody>
                {users.map((user) => (
                  <tr key={user.id}>
                    <td><strong>{user.name}</strong><small>{user.email}</small></td>
                    <td>{user.company_memberships[0]?.employee_no ?? '—'}<small>{user.company_memberships[0]?.employment_status ?? '—'}</small></td>
                    <td>{currentDepartments(user).map((item) => item.department.name).join(', ') || 'Belum ditetapkan'}</td>
                    <td><StatusBadge status={user.status} /></td>
                    <td><button className="row-action" onClick={() => void selectUser(user.id)}>Review →</button></td>
                  </tr>
                ))}
                {!busy && users.length === 0 && <tr><td colSpan={5} className="empty">Tidak ada identity pada filter ini.</td></tr>}
              </tbody>
            </table>
          </div>
          {busy && <div className="loading-bar" />}
          {lastPage > 1 && <footer className="pagination"><span>Halaman {page} dari {lastPage}</span><div><button className="secondary" disabled={busy || page === 1} onClick={() => setPage((current) => current - 1)}>Sebelumnya</button><button className="secondary" disabled={busy || page === lastPage} onClick={() => setPage((current) => current + 1)}>Berikutnya</button></div></footer>}
        </section></>}

        {workspace === 'access' && activeCompany && organization && currentUser && <AccessReview token={token} currentUser={currentUser} company={activeCompany} organization={organization} onError={handleError} onMessage={setMessage} />}
      </main>

      {selectedUser && organization && activeCompany && (
        <IdentityDrawer
          user={selectedUser}
          organization={organization}
          company={activeCompany}
          token={token}
          canManageStatus={canManageStatus}
          onClose={() => setSelectedUser(null)}
          onChanged={async (successMessage) => {
            setMessage(successMessage)
            await loadUsers()
          }}
          onError={handleError}
        />
      )}
    </div>
  )
}

function LoginScreen({ onAuthenticated }: { onAuthenticated: (token: string, needsMfa: boolean) => void }) {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [busy, setBusy] = useState(false)

  async function submit(event: FormEvent) {
    event.preventDefault(); setBusy(true); setError('')
    try {
      const response = await apiRequest<LoginResponse>('/auth/login', {
        method: 'POST', body: JSON.stringify({ email, password, surface: 'erp_web', device_name: navigator.userAgent.slice(0, 120) }),
      })
      onAuthenticated(response.access_token, response.mfa_required)
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Login gagal.')
    } finally { setBusy(false) }
  }

  return <main className="auth-page"><section className="auth-copy"><p className="eyebrow">Rajawali Platform V2</p><h1>One identity.<br />Clear accountability.</h1><p>Workspace management untuk dua legal entity dengan scope, histori, dan approval yang eksplisit.</p><div className="security-note"><span>✓</span><div><strong>Controlled access</strong><small>Session ERP memiliki idle timeout 30 menit.</small></div></div></section><section className="auth-panel"><form onSubmit={(event) => void submit(event)}><div className="auth-mark">R</div><h2>Masuk ke Management ERP</h2><p>Gunakan akun employee yang sudah aktif.</p>{error && <div className="form-error">{error}</div>}<label>Email<input type="email" autoComplete="username" value={email} onChange={(event) => setEmail(event.target.value)} required /></label><label>Password<input type="password" autoComplete="current-password" value={password} onChange={(event) => setPassword(event.target.value)} required /></label><button className="primary" disabled={busy}>{busy ? 'Memverifikasi…' : 'Masuk'}</button></form></section></main>
}

function MfaScreen({ token, onVerified, onCancel }: { token: string; onVerified: () => void; onCancel: () => void }) {
  const [credential, setCredential] = useState('')
  const [error, setError] = useState('')
  async function submit(event: FormEvent) {
    event.preventDefault(); setError('')
    try {
      await apiRequest('/auth/mfa/challenge', { method: 'POST', body: JSON.stringify({ credential }) }, token)
      onVerified()
    } catch (cause) { setError(cause instanceof Error ? cause.message : 'Kode tidak valid.') }
  }
  return <main className="auth-page single"><section className="auth-panel"><form onSubmit={(event) => void submit(event)}><div className="auth-mark">2</div><h2>Verifikasi dua langkah</h2><p>Masukkan kode authenticator atau recovery code.</p>{error && <div className="form-error">{error}</div>}<label>Kode keamanan<input autoFocus value={credential} onChange={(event) => setCredential(event.target.value)} minLength={6} required /></label><button className="primary">Verifikasi</button><button className="text-button" type="button" onClick={onCancel}>Batalkan login</button></form></section></main>
}

function IdentityDrawer({ user, organization, company, token, canManageStatus, onClose, onChanged, onError }: {
  user: IdentityUser; organization: Organization; company: Company; token: string; canManageStatus: boolean; onClose: () => void; onChanged: (message: string) => Promise<void>; onError: (error: unknown) => void
}) {
  const activeDepartments = useMemo(() => currentDepartments(user), [user])
  const activeLocations = useMemo(() => currentLocations(user), [user])
  const [departmentIds, setDepartmentIds] = useState(() => activeDepartments.map((item) => item.department.id))
  const [primaryDepartmentId, setPrimaryDepartmentId] = useState(() => activeDepartments.find((item) => item.is_primary)?.department.id ?? '')
  const [locationIds, setLocationIds] = useState(() => activeLocations.map((item) => item.location.id))
  const [effectiveFrom, setEffectiveFrom] = useState(tomorrow())
  const [reason, setReason] = useState('')
  const [nextStatus, setNextStatus] = useState(user.status === 'active' ? 'suspended' : user.status === 'invited' ? 'disabled' : 'active')
  const [statusReason, setStatusReason] = useState('')
  const [statusConfirmed, setStatusConfirmed] = useState(false)
  const [busy, setBusy] = useState(false)

  useEffect(() => {
    function closeOnEscape(event: KeyboardEvent) {
      if (event.key === 'Escape') onClose()
    }

    document.addEventListener('keydown', closeOnEscape)
    return () => document.removeEventListener('keydown', closeOnEscape)
  }, [onClose])

  function toggle(values: string[], value: string, setter: (values: string[]) => void) {
    setter(values.includes(value) ? values.filter((item) => item !== value) : [...values, value])
  }

  function toggleDepartment(departmentId: string) {
    const next = departmentIds.includes(departmentId)
      ? departmentIds.filter((item) => item !== departmentId)
      : [...departmentIds, departmentId]
    setDepartmentIds(next)
    if (!next.includes(primaryDepartmentId)) setPrimaryDepartmentId(next[0] ?? '')
  }

  async function saveMemberships(event: FormEvent) {
    event.preventDefault(); setBusy(true)
    try {
      await apiRequest(`/identity/companies/${company.id}/users/${user.id}/organization-memberships`, {
        method: 'PUT', body: JSON.stringify({ department_ids: departmentIds, primary_department_id: primaryDepartmentId, location_ids: locationIds, effective_from: effectiveFrom, reason }),
      }, token)
      await onChanged(`Perubahan organisasi ${user.name} dijadwalkan untuk ${formatDate(effectiveFrom)}.`)
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }

  async function changeStatus(event: FormEvent) {
    event.preventDefault(); setBusy(true)
    try {
      await apiRequest(`/identity/users/${user.id}/status`, { method: 'PATCH', body: JSON.stringify({ status: nextStatus, reason: statusReason }) }, token)
      await onChanged(`Status identity ${user.name} diubah menjadi ${nextStatus}.`)
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }

  return <div className="drawer-backdrop" onMouseDown={onClose}><aside className="drawer" role="dialog" aria-modal="true" aria-labelledby="identity-drawer-title" onMouseDown={(event) => event.stopPropagation()}><header><div className="avatar large">{user.name.slice(0, 2).toUpperCase()}</div><div><p className="eyebrow">Identity record</p><h2 id="identity-drawer-title">{user.name}</h2><span>{user.email}</span></div><button className="close" onClick={onClose} aria-label="Tutup detail identity">×</button></header><div className="drawer-body"><div className="identity-meta"><StatusBadge status={user.status} /><span>Last login: {user.last_login_at ? formatDate(user.last_login_at) : 'Belum pernah'}</span></div><section><h3>Employment</h3>{user.company_memberships.map((membership) => <div className="history-row" key={membership.id}><div><strong>{membership.employee_no ?? 'Tanpa nomor pegawai'}</strong><small>{membership.employment_status}</small></div><span>{formatDate(membership.valid_from)} — {formatDate(membership.valid_until)}</span></div>)}</section><section><h3>Organization history</h3>{user.department_memberships.map((membership) => <div className="history-row" key={membership.id}><div><strong>{membership.department.name}{membership.is_primary ? ' · Primary' : ''}</strong><small>{membership.department.code}</small></div><span>{formatDate(membership.valid_from)} — {formatDate(membership.valid_until)}</span></div>)}</section>{company.capabilities.can_manage_employment && <section><h3>Schedule organization change</h3><form className="stack-form" onSubmit={(event) => void saveMemberships(event)}><fieldset><legend>Departments</legend>{organization.departments.map((department) => <label className="check-row" key={department.id}><input type="checkbox" checked={departmentIds.includes(department.id)} onChange={() => toggleDepartment(department.id)} />{department.name}</label>)}</fieldset><label>Primary department<select value={primaryDepartmentId} onChange={(event) => setPrimaryDepartmentId(event.target.value)} required><option value="">Pilih primary</option>{organization.departments.filter((department) => departmentIds.includes(department.id)).map((department) => <option key={department.id} value={department.id}>{department.name}</option>)}</select></label><fieldset><legend>Locations</legend>{organization.locations.length ? organization.locations.map((location) => <label className="check-row" key={location.id}><input type="checkbox" checked={locationIds.includes(location.id)} onChange={() => toggle(locationIds, location.id, setLocationIds)} />{location.name}</label>) : <small>Belum ada location aktif.</small>}</fieldset><label>Effective from<input type="date" min={tomorrow()} value={effectiveFrom} onChange={(event) => setEffectiveFrom(event.target.value)} required /></label><label>Reason<textarea value={reason} onChange={(event) => setReason(event.target.value)} minLength={10} required /></label><button className="primary" disabled={busy || !departmentIds.length || !primaryDepartmentId}>Schedule change</button></form></section>}{canManageStatus && <section className="danger-zone"><h3>Global identity status</h3><p>Disable atau suspend akan mencabut seluruh session dan mobile refresh token. Aksi ini membutuhkan recent MFA.</p><form className="stack-form" onSubmit={(event) => void changeStatus(event)}><label>New status<select value={nextStatus} onChange={(event) => { setNextStatus(event.target.value); setStatusConfirmed(false) }}><option value="active">Active</option><option value="suspended">Suspended</option><option value="disabled">Disabled</option></select></label><label>Reason<textarea value={statusReason} onChange={(event) => setStatusReason(event.target.value)} minLength={10} required /></label><label className="check-row"><input type="checkbox" checked={statusConfirmed} onChange={(event) => setStatusConfirmed(event.target.checked)} />Saya memahami dampak perubahan status global ini.</label><button className="danger" disabled={busy || !statusConfirmed || statusReason.trim().length < 10}>Apply global status</button></form></section>}</div></aside></div>
}

function StatusBadge({ status }: { status: string }) { return <span className={`badge ${status}`}>{status}</span> }

function currentDepartments(user: IdentityUser) {
  const today = new Date().toISOString().slice(0, 10)
  return user.department_memberships.filter((item) => item.valid_from <= today && (!item.valid_until || item.valid_until >= today))
}

function currentLocations(user: IdentityUser) {
  const today = new Date().toISOString().slice(0, 10)
  return user.location_memberships.filter((item) => item.valid_from <= today && (!item.valid_until || item.valid_until >= today))
}

export default App
