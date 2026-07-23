import { type FormEvent, type ReactNode, useCallback, useEffect, useState } from 'react'
import {
  Alert,
  Avatar,
  Badge,
  Button,
  Card,
  Checkbox,
  Drawer,
  Group,
  LoadingOverlay,
  Modal,
  Pagination,
  Select,
  SimpleGrid,
  Stack,
  Table,
  Tabs,
  Text,
  Textarea,
  TextInput,
  ThemeIcon,
  Title,
} from '@mantine/core'
import {
  IconAlertTriangle,
  IconCheck,
  IconClipboardCheck,
  IconKey,
  IconPlus,
  IconShieldLock,
  IconTrash,
  IconX,
} from '@tabler/icons-react'
import {
  createAccessRequest,
  decideAccessRequest,
  getPrivilegedAccessCatalog,
  listAccessRequests,
  listMyAccessRequests,
  listPrivilegedRoleAssignments,
  revokePrivilegedRoleAssignment,
  type AccessCatalogUser,
  type AccessRequest,
  type AccessRequestStatus,
  type AccessRole,
  type Company,
  type CurrentUser,
  type Organization,
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

const statusColor = (value: string) => value === 'approved' ? 'green' : value === 'pending' ? 'yellow' : 'red'

export default function AccessReview({ token, currentUser, company, organization, onError, onMessage }: Props) {
  const capabilities = company.capabilities
  const defaultSection: Section = capabilities.can_approve_access ? 'queue' : capabilities.can_request_access ? 'mine' : 'assignments'
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
  const [queueStatus, setQueueStatus] = useState<AccessRequestStatus | null>('pending')
  const [showRequestForm, setShowRequestForm] = useState(false)
  const [decision, setDecision] = useState<{ request: AccessRequest; action: 'approve' | 'reject' } | null>(null)
  const [revocation, setRevocation] = useState<RoleAssignment | null>(null)
  const [busy, setBusy] = useState(false)

  const refresh = useCallback(async () => {
    setBusy(true)
    try {
      const requests: Array<Promise<void>> = []
      if (capabilities.can_request_access) {
        requests.push(getPrivilegedAccessCatalog(company.id, token).then((response) => {
          setCatalogUsers(response.data.users)
          setRoles(response.data.roles)
        }))
        requests.push(listMyAccessRequests(company.id, minePage, token).then((response) => {
          setMine(response.data); setMineLastPage(response.last_page); setMineTotal(response.total)
        }))
      }
      if (capabilities.can_approve_access) {
        requests.push(listAccessRequests(company.id, queueStatus ?? undefined, queuePage, token).then((response) => {
          setQueue(response.data); setQueueLastPage(response.last_page); setQueueTotal(response.total)
        }))
      }
      if (capabilities.can_revoke_access) {
        requests.push(listPrivilegedRoleAssignments(company.id, assignmentPage, token).then((response) => {
          setAssignments(response.data); setAssignmentLastPage(response.last_page); setAssignmentTotal(response.total)
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

  useEffect(() => { void refresh() }, [refresh])

  async function completed(message: string) {
    setDecision(null)
    setRevocation(null)
    setShowRequestForm(false)
    onMessage(message)
    await refresh()
  }

  return <Stack gap="lg">
    <SimpleGrid cols={{ base: 1, sm: 3 }}>
      <SummaryCard label={queueStatus === 'pending' ? 'Pending review' : 'Visible reviews'} value={queueTotal} detail="Maker dan approver harus berbeda" icon={<IconClipboardCheck size={20} />} />
      <SummaryCard label="My requests" value={mineTotal} detail="Maximum privileged expiry 90 hari" icon={<IconKey size={20} />} />
      <SummaryCard label="Active privileged" value={assignmentTotal} detail="Revocation berlaku segera" icon={<IconShieldLock size={20} />} />
    </SimpleGrid>

    <Card padding={0} pos="relative" style={{ overflow: 'hidden' }}>
      <LoadingOverlay visible={busy} overlayProps={{ blur: 1 }} />
      <Group justify="space-between" p="md" align="flex-end">
        <Tabs value={section} onChange={(value) => setSection(value as Section)}>
          <Tabs.List>
            {capabilities.can_approve_access && <Tabs.Tab value="queue" rightSection={<Badge size="xs" variant="light">{queueTotal}</Badge>}>Approval queue</Tabs.Tab>}
            {capabilities.can_request_access && <Tabs.Tab value="mine" rightSection={<Badge size="xs" variant="light">{mineTotal}</Badge>}>My requests</Tabs.Tab>}
            {capabilities.can_revoke_access && <Tabs.Tab value="assignments" rightSection={<Badge size="xs" variant="light">{assignmentTotal}</Badge>}>Active assignments</Tabs.Tab>}
          </Tabs.List>
        </Tabs>
        {capabilities.can_request_access && <Button leftSection={<IconPlus size={17} />} onClick={() => setShowRequestForm(true)}>New request</Button>}
      </Group>

      {section === 'queue' && <>
        <Group justify="flex-end" p="md" bg="gray.0"><Select label="Status" w={180} clearable value={queueStatus} onChange={(value) => { setQueuePage(1); setQueueStatus(value as AccessRequestStatus | null) }} data={['pending', 'approved', 'rejected', 'cancelled']} /></Group>
        <RequestList requests={queue} currentUser={currentUser} canDecide onDecision={(request, action) => setDecision({ request, action })} />
        <Pager page={queuePage} lastPage={queueLastPage} onPage={setQueuePage} />
      </>}
      {section === 'mine' && <><RequestList requests={mine} currentUser={currentUser} /><Pager page={minePage} lastPage={mineLastPage} onPage={setMinePage} /></>}
      {section === 'assignments' && <><AssignmentList assignments={assignments} organization={organization} onRevoke={setRevocation} /><Pager page={assignmentPage} lastPage={assignmentLastPage} onPage={setAssignmentPage} /></>}
    </Card>

    <RequestDrawer opened={showRequestForm} token={token} company={company} organization={organization} users={catalogUsers.filter((user) => user.id !== currentUser.id)} roles={roles} onClose={() => setShowRequestForm(false)} onError={onError} onCompleted={() => completed('Privileged access request berhasil dibuat dan menunggu approver yang berbeda.')} />
    {decision && <DecisionDialog token={token} company={company} decision={decision} onClose={() => setDecision(null)} onError={onError} onCompleted={() => completed(`Request untuk ${decision.request.target_user.name} berhasil ${decision.action === 'approve' ? 'disetujui' : 'ditolak'}.`)} />}
    {revocation && <RevocationDialog token={token} company={company} assignment={revocation} onClose={() => setRevocation(null)} onError={onError} onCompleted={() => completed(`Akses ${revocation.user.name} dicabut dan seluruh session-nya direvoke.`)} />}
  </Stack>
}

function SummaryCard({ label, value, detail, icon }: { label: string; value: number; detail: string; icon: ReactNode }) {
  return <Card padding="lg"><Group justify="space-between"><Text size="sm" c="dimmed">{label}</Text><ThemeIcon variant="light" size="lg">{icon}</ThemeIcon></Group><Title order={3} mt="sm">{value}</Title><Text size="xs" c="dimmed" mt={4}>{detail}</Text></Card>
}

function RequestList({ requests, currentUser, canDecide = false, onDecision }: { requests: AccessRequest[]; currentUser: CurrentUser; canDecide?: boolean; onDecision?: (request: AccessRequest, action: 'approve' | 'reject') => void }) {
  if (!requests.length) return <EmptyState title="Tidak ada request pada tampilan ini." detail="Request baru atau perubahan filter akan muncul di sini." />
  return <Stack p="md" gap="sm">{requests.map((request) => {
    const selfDecision = request.requested_by.id === currentUser.id || request.target_user.id === currentUser.id
    return <Card key={request.id} padding="md" radius="md">
      <Group justify="space-between" align="flex-start">
        <Group wrap="nowrap"><Avatar color="forest" variant="light">{request.target_user.name.slice(0, 2).toUpperCase()}</Avatar><div><Text fw={700}>{request.target_user.name}</Text><Text size="xs" c="dimmed">{request.target_user.email}</Text></div></Group>
        <Stack gap={3} align="flex-end"><Badge color={statusColor(request.status)} variant="light">{request.status}</Badge>{!request.target_mfa_enabled && request.status === 'pending' && <Text size="xs" c="orange">Target belum MFA</Text>}</Stack>
      </Group>
      <SimpleGrid cols={{ base: 1, sm: 3 }} mt="md">
        <div><Text size="xs" c="dimmed">Role</Text><Text size="sm" fw={700}>{request.role.name}</Text><Text size="xs" c="dimmed">{request.role.code}</Text></div>
        <div><Text size="xs" c="dimmed">Requested by</Text><Text size="sm" fw={700}>{request.requested_by.name}</Text></div>
        <div><Text size="xs" c="dimmed">Valid until</Text><Text size="sm" fw={700}>{displayDateTime(request.valid_until)}</Text></div>
      </SimpleGrid>
      <Text size="sm" p="sm" mt="md" bg="gray.0" style={{ borderRadius: 'var(--mantine-radius-md)' }}>{request.reason}</Text>
      {canDecide && request.status === 'pending' && <Group justify="flex-end" mt="md"><Button color="red" variant="light" leftSection={<IconX size={16} />} disabled={selfDecision} onClick={() => onDecision?.(request, 'reject')}>Reject</Button><Button leftSection={<IconCheck size={16} />} disabled={selfDecision || !request.target_mfa_enabled} onClick={() => onDecision?.(request, 'approve')}>Approve</Button></Group>}
    </Card>
  })}</Stack>
}

function AssignmentList({ assignments, organization, onRevoke }: { assignments: RoleAssignment[]; organization: Organization; onRevoke: (assignment: RoleAssignment) => void }) {
  const scopeName = (assignment: RoleAssignment) => assignment.location_id
    ? organization.locations.find((item) => item.id === assignment.location_id)?.name ?? 'Location scope'
    : assignment.department_id
      ? organization.departments.find((item) => item.id === assignment.department_id)?.name ?? 'Department scope'
      : 'Company-wide'
  if (!assignments.length) return <EmptyState title="Tidak ada privileged assignment aktif." detail="Assignment approved akan muncul di sini." />
  return <Table.ScrollContainer minWidth={760}><Table verticalSpacing="md" horizontalSpacing="lg" highlightOnHover><Table.Thead><Table.Tr><Table.Th>User</Table.Th><Table.Th>Role</Table.Th><Table.Th>Scope</Table.Th><Table.Th>Expiry</Table.Th><Table.Th /></Table.Tr></Table.Thead><Table.Tbody>{assignments.map((assignment) => <Table.Tr key={assignment.id}><Table.Td><Text size="sm" fw={700}>{assignment.user.name}</Text><Text size="xs" c="dimmed">{assignment.user.email}</Text></Table.Td><Table.Td><Text size="sm" fw={700}>{assignment.role.name}</Text><Text size="xs" c="dimmed">{assignment.role.code}</Text></Table.Td><Table.Td><Text size="sm">{scopeName(assignment)}</Text></Table.Td><Table.Td><Text size="sm">{displayDateTime(assignment.valid_until)}</Text></Table.Td><Table.Td><Button color="red" variant="subtle" size="xs" leftSection={<IconTrash size={15} />} onClick={() => onRevoke(assignment)}>Revoke</Button></Table.Td></Table.Tr>)}</Table.Tbody></Table></Table.ScrollContainer>
}

function RequestDrawer({ opened, token, company, organization, users, roles, onClose, onError, onCompleted }: { opened: boolean; token: string; company: Company; organization: Organization; users: AccessCatalogUser[]; roles: AccessRole[]; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [targetId, setTargetId] = useState<string | null>(null)
  const [roleId, setRoleId] = useState<string | null>(null)
  const [departmentId, setDepartmentId] = useState<string | null>(null)
  const [locationId, setLocationId] = useState<string | null>(null)
  const [validUntil, setValidUntil] = useState(localDateTime(30))
  const [reason, setReason] = useState('')
  const [confirmed, setConfirmed] = useState(false)
  const [busy, setBusy] = useState(false)
  const selectedRole = roles.find((role) => role.id === roleId)
  const selectedUser = users.find((user) => user.id === targetId)
  const availableDepartments = organization.departments.filter((item) => selectedUser?.department_ids.includes(item.id))
  const availableLocations = organization.locations.filter((item) => selectedUser?.location_ids.includes(item.id))
  const scopeReady = selectedRole?.assignment_scope === 'department' ? Boolean(departmentId) : selectedRole?.assignment_scope === 'location' ? Boolean(locationId) : true

  async function submit(event: FormEvent) {
    event.preventDefault()
    if (!targetId || !roleId) return
    setBusy(true)
    try {
      await createAccessRequest(company.id, { target_user_id: targetId, role_id: roleId, department_id: departmentId, location_id: locationId, reason, valid_until: new Date(validUntil).toISOString() }, token)
      await onCompleted()
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }

  return <Drawer opened={opened} onClose={onClose} position="right" size="lg" title="New privileged access request">
    <form onSubmit={(event) => void submit(event)}><Stack>
      <Alert color="blue" title="Controlled workflow">MFA step-up dan approver yang berbeda wajib untuk assignment privileged.</Alert>
      <Select label="Target employee" searchable required data={users.map((user) => ({ value: user.id, label: `${user.name} · ${user.mfa_enabled ? 'MFA ready' : 'MFA belum aktif'}` }))} value={targetId} onChange={(value) => { setTargetId(value); setDepartmentId(null); setLocationId(null); setConfirmed(false) }} />
      {selectedUser && !selectedUser.mfa_enabled && <Alert color="orange" icon={<IconAlertTriangle size={17} />}>Request dapat dibuat, tetapi approval diblokir sampai target mengaktifkan MFA.</Alert>}
      <Select label="Privileged role" required data={roles.map((role) => ({ value: role.id, label: `${role.name} · ${role.assignment_scope}` }))} value={roleId} onChange={(value) => { setRoleId(value); setDepartmentId(null); setLocationId(null); setConfirmed(false) }} />
      {selectedRole?.description && <Text size="sm" c="dimmed">{selectedRole.description}</Text>}
      {selectedRole?.assignment_scope === 'department' && <Select label="Department" required data={availableDepartments.map((item) => ({ value: item.id, label: item.name }))} value={departmentId} onChange={setDepartmentId} />}
      {selectedRole?.assignment_scope === 'location' && <><Select label="Location" required data={availableLocations.map((item) => ({ value: item.id, label: item.name }))} value={locationId} onChange={setLocationId} /><Select label="Department restriction" clearable data={availableDepartments.map((item) => ({ value: item.id, label: item.name }))} value={departmentId} onChange={setDepartmentId} /></>}
      <TextInput type="datetime-local" label="Valid until" min={localDateTime(0)} max={localDateTime(89)} value={validUntil} onChange={(event) => setValidUntil(event.currentTarget.value)} required />
      <Textarea label="Business justification" minRows={4} minLength={10} maxLength={2000} value={reason} onChange={(event) => setReason(event.currentTarget.value)} required />
      <Checkbox checked={confirmed} onChange={(event) => setConfirmed(event.currentTarget.checked)} label="Saya memastikan scope dan expiry request ini minimum yang diperlukan." />
      <Button type="submit" loading={busy} disabled={!confirmed || !scopeReady || reason.trim().length < 10}>Submit request</Button>
    </Stack></form>
  </Drawer>
}

function DecisionDialog({ token, company, decision, onClose, onError, onCompleted }: { token: string; company: Company; decision: { request: AccessRequest; action: 'approve' | 'reject' }; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [note, setNote] = useState('')
  const [confirmed, setConfirmed] = useState(false)
  const [busy, setBusy] = useState(false)
  async function submit(event: FormEvent) {
    event.preventDefault(); setBusy(true)
    try {
      await decideAccessRequest(company.id, decision.request.id, decision.action, note, token)
      await onCompleted()
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }
  return <Modal opened onClose={onClose} title={`${decision.action === 'approve' ? 'Approve' : 'Reject'} access request`} centered><form onSubmit={(event) => void submit(event)}><Stack><Text size="sm"><strong>{decision.request.target_user.name}</strong> · {decision.request.role.name}</Text><Text size="sm" p="sm" bg="gray.0">{decision.request.reason}</Text><Text size="xs" c="dimmed">Requested by {decision.request.requested_by.name} · expires {displayDateTime(decision.request.valid_until)}</Text><Textarea label="Decision note" minRows={3} minLength={10} value={note} onChange={(event) => setNote(event.currentTarget.value)} required /><Checkbox checked={confirmed} onChange={(event) => setConfirmed(event.currentTarget.checked)} label="Saya sudah memverifikasi target, role, scope, dan expiry." /><Button type="submit" color={decision.action === 'approve' ? 'forest' : 'red'} loading={busy} disabled={!confirmed || note.trim().length < 10}>{decision.action === 'approve' ? 'Approve access' : 'Reject request'}</Button></Stack></form></Modal>
}

function RevocationDialog({ token, company, assignment, onClose, onError, onCompleted }: { token: string; company: Company; assignment: RoleAssignment; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [reason, setReason] = useState('')
  const [confirmed, setConfirmed] = useState(false)
  const [busy, setBusy] = useState(false)
  async function submit(event: FormEvent) {
    event.preventDefault(); setBusy(true)
    try {
      await revokePrivilegedRoleAssignment(company.id, assignment.id, reason, token)
      await onCompleted()
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }
  return <Modal opened onClose={onClose} title="Revoke privileged assignment" centered><form onSubmit={(event) => void submit(event)}><Stack><Alert color="red" icon={<IconAlertTriangle size={17} />}>Revocation langsung mencabut assignment, seluruh web session, dan mobile refresh-token family milik target.</Alert><Text size="sm"><strong>{assignment.user.name}</strong> · {assignment.role.name}</Text><Textarea label="Revocation reason" minRows={3} minLength={10} value={reason} onChange={(event) => setReason(event.currentTarget.value)} required /><Checkbox checked={confirmed} onChange={(event) => setConfirmed(event.currentTarget.checked)} label="Saya memahami dampak immediate revocation ini." /><Button type="submit" color="red" loading={busy} disabled={!confirmed || reason.trim().length < 10}>Revoke access immediately</Button></Stack></form></Modal>
}

function EmptyState({ title, detail }: { title: string; detail: string }) {
  return <Stack align="center" py={60} px="md" gap="xs"><ThemeIcon variant="light" size={48} radius="xl"><IconClipboardCheck size={24} /></ThemeIcon><Text fw={700}>{title}</Text><Text size="sm" c="dimmed" ta="center">{detail}</Text></Stack>
}

function Pager({ page, lastPage, onPage }: { page: number; lastPage: number; onPage: (page: number) => void }) {
  if (lastPage <= 1) return null
  return <Group justify="space-between" p="md" className="card-footer"><Text size="sm" c="dimmed">Halaman {page} dari {lastPage}</Text><Pagination value={page} total={lastPage} onChange={onPage} size="sm" /></Group>
}
