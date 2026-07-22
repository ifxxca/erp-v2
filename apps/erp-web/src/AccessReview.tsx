import { type FormEvent, type ReactNode, useCallback, useEffect, useState } from 'react'
import {
  apiRequest,
  type AccessCatalogUser,
  type AccessRequest,
  type AccessRole,
  type Company,
  type CurrentUser,
  type Organization,
  type Page,
  type RoleAssignment,
} from './api'

type Section = 'queue' | 'mine' | 'assignments'

type Props = {
  token: string
  currentUser: CurrentUser
  company: Company
  organization: Organization
  onError: (error: unknown) => void
  onMessage: (message: string) => void
}

const localDateTime = (daysFromNow: number) => {
  const date = new Date()
  date.setDate(date.getDate() + daysFromNow)
  date.setMinutes(date.getMinutes() - date.getTimezoneOffset())
  return date.toISOString().slice(0, 16)
}

const displayDateTime = (value: string | null) => value
  ? new Intl.DateTimeFormat('id-ID', { dateStyle: 'medium', timeStyle: 'short' }).format(new Date(value))
  : 'Tanpa expiry'

export default function AccessReview({ token, currentUser, company, organization, onError, onMessage }: Props) {
  const capabilities = company.capabilities
  const defaultSection: Section = capabilities.can_approve_access
    ? 'queue'
    : capabilities.can_request_access
      ? 'mine'
      : 'assignments'
  const [section, setSection] = useState<Section>(defaultSection)
  const [catalogUsers, setCatalogUsers] = useState<AccessCatalogUser[]>([])
  const [roles, setRoles] = useState<AccessRole[]>([])
  const [queue, setQueue] = useState<AccessRequest[]>([])
  const [mine, setMine] = useState<AccessRequest[]>([])
  const [assignments, setAssignments] = useState<RoleAssignment[]>([])
  const [queuePage, setQueuePage] = useState(1)
  const [queueLastPage, setQueueLastPage] = useState(1)
  const [queueTotal, setQueueTotal] = useState(0)
  const [minePage, setMinePage] = useState(1)
  const [mineLastPage, setMineLastPage] = useState(1)
  const [mineTotal, setMineTotal] = useState(0)
  const [assignmentPage, setAssignmentPage] = useState(1)
  const [assignmentLastPage, setAssignmentLastPage] = useState(1)
  const [assignmentTotal, setAssignmentTotal] = useState(0)
  const [queueStatus, setQueueStatus] = useState('pending')
  const [showRequestForm, setShowRequestForm] = useState(false)
  const [decision, setDecision] = useState<{ request: AccessRequest; action: 'approve' | 'reject' } | null>(null)
  const [revocation, setRevocation] = useState<RoleAssignment | null>(null)
  const [busy, setBusy] = useState(false)

  const refresh = useCallback(async () => {
    setBusy(true)
    try {
      const requests: Array<Promise<void>> = []
      if (capabilities.can_request_access) {
        requests.push(apiRequest<{ data: { users: AccessCatalogUser[]; roles: AccessRole[] } }>(
          `/identity/companies/${company.id}/access-catalog`, {}, token,
        ).then((response) => {
          setCatalogUsers(response.data.users)
          setRoles(response.data.roles)
        }))
        requests.push(apiRequest<Page<AccessRequest>>(
          `/identity/companies/${company.id}/access-requests/mine?page=${minePage}`, {}, token,
        ).then((response) => {
          setMine(response.data)
          setMineLastPage(response.last_page)
          setMineTotal(response.total)
        }))
      }
      if (capabilities.can_approve_access) {
        const params = new URLSearchParams({ page: String(queuePage) })
        if (queueStatus) params.set('status', queueStatus)
        requests.push(apiRequest<Page<AccessRequest>>(
          `/identity/companies/${company.id}/access-requests?${params}`, {}, token,
        ).then((response) => {
          setQueue(response.data)
          setQueueLastPage(response.last_page)
          setQueueTotal(response.total)
        }))
      }
      if (capabilities.can_revoke_access) {
        requests.push(apiRequest<Page<RoleAssignment>>(
          `/identity/companies/${company.id}/role-assignments?page=${assignmentPage}`, {}, token,
        ).then((response) => {
          setAssignments(response.data)
          setAssignmentLastPage(response.last_page)
          setAssignmentTotal(response.total)
        }))
      }
      await Promise.all(requests)
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }, [assignmentPage, capabilities.can_approve_access, capabilities.can_request_access, capabilities.can_revoke_access, company.id, minePage, onError, queuePage, queueStatus, token])

  useEffect(() => {
    setSection(defaultSection)
    setShowRequestForm(false)
    setQueuePage(1)
    setMinePage(1)
    setAssignmentPage(1)
  }, [company.id, defaultSection])

  useEffect(() => {
    void refresh()
  }, [refresh])

  const tabs = [
    capabilities.can_approve_access && { id: 'queue' as const, label: 'Approval queue', count: queueTotal },
    capabilities.can_request_access && { id: 'mine' as const, label: 'My requests', count: mineTotal },
    capabilities.can_revoke_access && { id: 'assignments' as const, label: 'Active assignments', count: assignmentTotal },
  ].filter(Boolean) as Array<{ id: Section; label: string; count: number }>

  async function completed(message: string) {
    setDecision(null)
    setRevocation(null)
    setShowRequestForm(false)
    onMessage(message)
    await refresh()
  }

  return <>
    <section className="access-summary">
      <article><span>{queueStatus === 'pending' ? 'Pending review' : 'Visible reviews'}</span><strong>{queueTotal}</strong><small>Maker dan approver harus berbeda</small></article>
      <article><span>My requests</span><strong>{mineTotal}</strong><small>Maximum privileged expiry 90 hari</small></article>
      <article><span>Active privileged</span><strong>{assignmentTotal}</strong><small>Revocation berlaku segera</small></article>
    </section>

    <section className="access-card">
      <header className="access-toolbar">
        <div className="tabs" role="tablist" aria-label="Access review sections">
          {tabs.map((tab) => <button key={tab.id} role="tab" aria-selected={section === tab.id} className={section === tab.id ? 'active' : ''} onClick={() => setSection(tab.id)}>{tab.label}<span>{tab.count}</span></button>)}
        </div>
        {capabilities.can_request_access && <button className="primary compact" onClick={() => setShowRequestForm(true)}>+ New request</button>}
      </header>

      {section === 'queue' && <>
        <div className="queue-filter"><label>Status<select value={queueStatus} onChange={(event) => { setQueuePage(1); setQueueStatus(event.target.value) }}><option value="pending">Pending</option><option value="">Semua</option><option value="approved">Approved</option><option value="rejected">Rejected</option><option value="cancelled">Cancelled</option></select></label></div>
        <RequestList requests={queue} currentUser={currentUser} canDecide onDecision={(request, action) => setDecision({ request, action })} />
        <Pagination page={queuePage} lastPage={queueLastPage} busy={busy} onPage={setQueuePage} />
      </>}
      {section === 'mine' && <><RequestList requests={mine} currentUser={currentUser} /><Pagination page={minePage} lastPage={mineLastPage} busy={busy} onPage={setMinePage} /></>}
      {section === 'assignments' && <><AssignmentList assignments={assignments} organization={organization} onRevoke={setRevocation} /><Pagination page={assignmentPage} lastPage={assignmentLastPage} busy={busy} onPage={setAssignmentPage} /></>}
      {busy && <div className="loading-bar" />}
    </section>

    {showRequestForm && <RequestDrawer token={token} company={company} organization={organization} users={catalogUsers.filter((user) => user.id !== currentUser.id)} roles={roles} onClose={() => setShowRequestForm(false)} onError={onError} onCompleted={() => completed('Privileged access request berhasil dibuat dan menunggu approver yang berbeda.')} />}
    {decision && <DecisionDialog token={token} company={company} decision={decision} onClose={() => setDecision(null)} onError={onError} onCompleted={() => completed(`Request untuk ${decision.request.target_user.name} berhasil ${decision.action === 'approve' ? 'disetujui' : 'ditolak'}.`)} />}
    {revocation && <RevocationDialog token={token} company={company} assignment={revocation} onClose={() => setRevocation(null)} onError={onError} onCompleted={() => completed(`Akses ${revocation.user.name} dicabut dan seluruh session-nya direvoke.`)} />}
  </>
}

function RequestList({ requests, currentUser, canDecide = false, onDecision }: { requests: AccessRequest[]; currentUser: CurrentUser; canDecide?: boolean; onDecision?: (request: AccessRequest, action: 'approve' | 'reject') => void }) {
  if (!requests.length) return <div className="access-empty"><strong>Tidak ada request pada tampilan ini.</strong><span>Request baru atau perubahan filter akan muncul di sini.</span></div>

  return <div className="request-list">{requests.map((request) => {
    const selfDecision = request.requested_by.id === currentUser.id || request.target_user.id === currentUser.id
    return <article className="request-row" key={request.id}>
      <div className="request-person"><div className="avatar">{request.target_user.name.slice(0, 2).toUpperCase()}</div><div><strong>{request.target_user.name}</strong><small>{request.target_user.email}</small></div></div>
      <div><span className="label">Role</span><strong>{request.role.name}</strong><small>{request.role.code}</small></div>
      <div><span className="label">Requested by</span><strong>{request.requested_by.name}</strong><small>Until {displayDateTime(request.valid_until)}</small></div>
      <div><StatusPill value={request.status} />{!request.target_mfa_enabled && request.status === 'pending' && <small className="warning">Target belum MFA</small>}</div>
      {canDecide && request.status === 'pending' && <div className="decision-actions"><button className="secondary" disabled={selfDecision} title={selfDecision ? 'Maker/target tidak dapat memutus request ini' : ''} onClick={() => onDecision?.(request, 'reject')}>Reject</button><button className="primary compact" disabled={selfDecision || !request.target_mfa_enabled} onClick={() => onDecision?.(request, 'approve')}>Approve</button></div>}
      <div className="request-reason">{request.reason}</div>
    </article>
  })}</div>
}

function AssignmentList({ assignments, organization, onRevoke }: { assignments: RoleAssignment[]; organization: Organization; onRevoke: (assignment: RoleAssignment) => void }) {
  const scopeName = (assignment: RoleAssignment) => {
    if (assignment.location_id) return organization.locations.find((item) => item.id === assignment.location_id)?.name ?? 'Location scope'
    if (assignment.department_id) return organization.departments.find((item) => item.id === assignment.department_id)?.name ?? 'Department scope'
    return 'Company-wide'
  }
  if (!assignments.length) return <div className="access-empty"><strong>Tidak ada privileged assignment aktif.</strong><span>Assignment approved akan muncul di sini.</span></div>

  return <div className="table-wrap"><table><thead><tr><th>User</th><th>Role</th><th>Scope</th><th>Expiry</th><th /></tr></thead><tbody>{assignments.map((assignment) => <tr key={assignment.id}><td><strong>{assignment.user.name}</strong><small>{assignment.user.email}</small></td><td><strong>{assignment.role.name}</strong><small>{assignment.role.code}</small></td><td>{scopeName(assignment)}</td><td>{displayDateTime(assignment.valid_until)}</td><td><button className="row-action danger-text" onClick={() => onRevoke(assignment)}>Revoke</button></td></tr>)}</tbody></table></div>
}

function RequestDrawer({ token, company, organization, users, roles, onClose, onError, onCompleted }: { token: string; company: Company; organization: Organization; users: AccessCatalogUser[]; roles: AccessRole[]; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [targetId, setTargetId] = useState('')
  const [roleId, setRoleId] = useState('')
  const [departmentId, setDepartmentId] = useState('')
  const [locationId, setLocationId] = useState('')
  const [validUntil, setValidUntil] = useState(localDateTime(30))
  const [reason, setReason] = useState('')
  const [confirmed, setConfirmed] = useState(false)
  const [busy, setBusy] = useState(false)
  const selectedRole = roles.find((role) => role.id === roleId)
  const selectedUser = users.find((user) => user.id === targetId)
  const availableDepartments = organization.departments.filter((item) => selectedUser?.department_ids.includes(item.id))
  const availableLocations = organization.locations.filter((item) => selectedUser?.location_ids.includes(item.id))

  async function submit(event: FormEvent) {
    event.preventDefault(); setBusy(true)
    try {
      await apiRequest(`/identity/companies/${company.id}/access-requests`, {
        method: 'POST',
        body: JSON.stringify({ target_user_id: targetId, role_id: roleId, department_id: departmentId || null, location_id: locationId || null, reason, valid_until: new Date(validUntil).toISOString() }),
      }, token)
      await onCompleted()
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }

  const scopeReady = selectedRole?.assignment_scope === 'department'
    ? Boolean(departmentId)
    : selectedRole?.assignment_scope === 'location'
      ? Boolean(locationId)
      : true

  return <Modal title="New privileged access request" subtitle="MFA step-up dan approver berbeda wajib" onClose={onClose}><form className="stack-form" onSubmit={(event) => void submit(event)}><label>Target employee<select value={targetId} onChange={(event) => { setTargetId(event.target.value); setDepartmentId(''); setLocationId(''); setConfirmed(false) }} required><option value="">Pilih employee</option>{users.map((user) => <option key={user.id} value={user.id}>{user.name} · {user.mfa_enabled ? 'MFA ready' : 'MFA belum aktif'}</option>)}</select></label>{selectedUser && !selectedUser.mfa_enabled && <div className="inline-warning">Request dapat dibuat, tetapi approval akan ditolak sampai target mengaktifkan MFA.</div>}<label>Privileged role<select value={roleId} onChange={(event) => { setRoleId(event.target.value); setDepartmentId(''); setLocationId(''); setConfirmed(false) }} required><option value="">Pilih role</option>{roles.map((role) => <option key={role.id} value={role.id}>{role.name} · {role.assignment_scope}</option>)}</select></label>{selectedRole?.description && <small>{selectedRole.description}</small>}{selectedRole?.assignment_scope === 'department' && <label>Department<select value={departmentId} onChange={(event) => setDepartmentId(event.target.value)} required><option value="">Pilih department</option>{availableDepartments.map((item) => <option key={item.id} value={item.id}>{item.name}</option>)}</select></label>}{selectedRole?.assignment_scope === 'location' && <><label>Location<select value={locationId} onChange={(event) => setLocationId(event.target.value)} required><option value="">Pilih location</option>{availableLocations.map((item) => <option key={item.id} value={item.id}>{item.name}</option>)}</select></label><label>Department restriction (optional)<select value={departmentId} onChange={(event) => setDepartmentId(event.target.value)}><option value="">Semua department target</option>{availableDepartments.map((item) => <option key={item.id} value={item.id}>{item.name}</option>)}</select></label></>}<label>Valid until<input type="datetime-local" min={localDateTime(0)} max={localDateTime(89)} value={validUntil} onChange={(event) => setValidUntil(event.target.value)} required /></label><label>Business justification<textarea value={reason} onChange={(event) => setReason(event.target.value)} minLength={10} maxLength={2000} required /></label><label className="check-row"><input type="checkbox" checked={confirmed} onChange={(event) => setConfirmed(event.target.checked)} />Saya memastikan scope dan expiry request ini minimum yang diperlukan.</label><button className="primary" disabled={busy || !confirmed || !scopeReady || reason.trim().length < 10}>{busy ? 'Submitting…' : 'Submit request'}</button></form></Modal>
}

function DecisionDialog({ token, company, decision, onClose, onError, onCompleted }: { token: string; company: Company; decision: { request: AccessRequest; action: 'approve' | 'reject' }; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [note, setNote] = useState('')
  const [confirmed, setConfirmed] = useState(false)
  const [busy, setBusy] = useState(false)
  async function submit(event: FormEvent) {
    event.preventDefault(); setBusy(true)
    try {
      await apiRequest(`/identity/companies/${company.id}/access-requests/${decision.request.id}/${decision.action}`, { method: 'POST', body: JSON.stringify({ note }) }, token)
      await onCompleted()
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }
  return <Modal title={`${decision.action === 'approve' ? 'Approve' : 'Reject'} access request`} subtitle={`${decision.request.target_user.name} · ${decision.request.role.name}`} onClose={onClose}><div className="decision-context"><span>Requested by {decision.request.requested_by.name}</span><p>{decision.request.reason}</p><strong>Expires {displayDateTime(decision.request.valid_until)}</strong></div><form className="stack-form" onSubmit={(event) => void submit(event)}><label>Decision note<textarea value={note} onChange={(event) => setNote(event.target.value)} minLength={10} required /></label><label className="check-row"><input type="checkbox" checked={confirmed} onChange={(event) => setConfirmed(event.target.checked)} />Saya sudah memverifikasi target, role, scope, dan expiry.</label><button className={decision.action === 'approve' ? 'primary' : 'danger'} disabled={busy || !confirmed || note.trim().length < 10}>{busy ? 'Processing…' : decision.action === 'approve' ? 'Approve access' : 'Reject request'}</button></form></Modal>
}

function RevocationDialog({ token, company, assignment, onClose, onError, onCompleted }: { token: string; company: Company; assignment: RoleAssignment; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [reason, setReason] = useState('')
  const [confirmed, setConfirmed] = useState(false)
  const [busy, setBusy] = useState(false)
  async function submit(event: FormEvent) {
    event.preventDefault(); setBusy(true)
    try {
      await apiRequest(`/identity/companies/${company.id}/role-assignments/${assignment.id}/revoke`, { method: 'POST', body: JSON.stringify({ reason }) }, token)
      await onCompleted()
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }
  return <Modal title="Revoke privileged assignment" subtitle={`${assignment.user.name} · ${assignment.role.name}`} onClose={onClose}><div className="inline-warning">Revocation langsung mencabut assignment, seluruh web session, dan mobile refresh-token family milik target.</div><form className="stack-form" onSubmit={(event) => void submit(event)}><label>Revocation reason<textarea value={reason} onChange={(event) => setReason(event.target.value)} minLength={10} required /></label><label className="check-row"><input type="checkbox" checked={confirmed} onChange={(event) => setConfirmed(event.target.checked)} />Saya memahami dampak immediate revocation ini.</label><button className="danger" disabled={busy || !confirmed || reason.trim().length < 10}>{busy ? 'Revoking…' : 'Revoke access immediately'}</button></form></Modal>
}

function Modal({ title, subtitle, onClose, children }: { title: string; subtitle: string; onClose: () => void; children: ReactNode }) {
  useEffect(() => {
    const close = (event: KeyboardEvent) => event.key === 'Escape' && onClose()
    document.addEventListener('keydown', close)
    return () => document.removeEventListener('keydown', close)
  }, [onClose])

  return <div className="drawer-backdrop" onMouseDown={onClose}><aside className="drawer access-drawer" role="dialog" aria-modal="true" aria-labelledby="access-dialog-title" onMouseDown={(event) => event.stopPropagation()}><header><div className="auth-mark">◇</div><div><p className="eyebrow">Access governance</p><h2 id="access-dialog-title">{title}</h2><span>{subtitle}</span></div><button className="close" onClick={onClose} aria-label="Tutup dialog" autoFocus>×</button></header><div className="drawer-body">{children}</div></aside></div>
}

function StatusPill({ value }: { value: string }) {
  return <span className={`badge ${value}`}>{value}</span>
}

function Pagination({ page, lastPage, busy, onPage }: { page: number; lastPage: number; busy: boolean; onPage: (page: number) => void }) {
  if (lastPage <= 1) return null
  return <footer className="pagination"><span>Halaman {page} dari {lastPage}</span><div><button className="secondary" disabled={busy || page === 1} onClick={() => onPage(page - 1)}>Sebelumnya</button><button className="secondary" disabled={busy || page === lastPage} onClick={() => onPage(page + 1)}>Berikutnya</button></div></footer>
}
