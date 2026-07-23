import { type FormEvent, useCallback, useEffect, useMemo, useState } from 'react'
import {
  Alert,
  Badge,
  Button,
  Card,
  Divider,
  Group,
  LoadingOverlay,
  Modal,
  Select,
  Stack,
  Text,
  Textarea,
  TextInput,
  ThemeIcon,
  Title,
} from '@mantine/core'
import { IconCalendarClock, IconKey, IconPlus, IconShieldCheck, IconTrash } from '@tabler/icons-react'
import {
  createStandardRoleAssignment,
  listStandardRoleAssignments,
  revokeStandardRoleAssignment,
  type Company,
  type IdentityUser,
  type Organization,
  type StandardAccessCatalog,
  type StandardAccessRole,
  type StandardRoleAssignment,
} from './api'

type Props = {
  user: IdentityUser
  currentUserId: string
  organization: Organization
  company: Company
  token: string
  onError: (error: unknown) => void
  onMessage: (message: string) => void
}

const today = () => {
  const value = new Date()
  value.setMinutes(value.getMinutes() - value.getTimezoneOffset())

  return value.toISOString().slice(0, 10)
}
const statusColor: Record<StandardRoleAssignment['status'], string> = {
  active: 'green',
  scheduled: 'blue',
  expired: 'gray',
  revoked: 'red',
}

export default function StandardAccessPanel({ user, currentUserId, organization, company, token, onError, onMessage }: Props) {
  const [catalog, setCatalog] = useState<StandardAccessCatalog | null>(null)
  const [busy, setBusy] = useState(false)
  const [createOpened, setCreateOpened] = useState(false)
  const [revoking, setRevoking] = useState<StandardRoleAssignment | null>(null)
  const isSelf = user.id === currentUserId

  const refresh = useCallback(async () => {
    setBusy(true)
    try {
      setCatalog(await listStandardRoleAssignments(company.id, user.id, token))
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }, [company.id, onError, token, user.id])

  useEffect(() => { void refresh() }, [refresh])

  const assignments = catalog?.data.assignments ?? []
  const currentCount = assignments.filter((assignment) => assignment.status === 'active' || assignment.status === 'scheduled').length

  return <Stack gap="lg" pos="relative">
    <LoadingOverlay visible={busy && !catalog} />
    <Group justify="space-between" align="flex-start">
      <div><Title order={4}>Standard access</Title><Text size="sm" c="dimmed" mt={3}>Role non-privileged diberikan langsung sesuai employment dan organization membership.</Text></div>
      {!isSelf && <Button leftSection={<IconPlus size={16} />} onClick={() => setCreateOpened(true)}>Assign role</Button>}
    </Group>

    {isSelf && <Alert color="orange" icon={<IconShieldCheck size={18} />}>Access owner tidak dapat memberi atau mencabut assignment miliknya sendiri.</Alert>}
    <Group gap="xs"><Badge variant="light" size="lg">{currentCount} current</Badge><Badge color="gray" variant="light" size="lg">{assignments.length} history</Badge></Group>

    <Stack gap="sm">
      {assignments.map((assignment) => <Card key={assignment.id} padding="md" withBorder>
        <Group justify="space-between" align="flex-start" wrap="nowrap">
          <Group wrap="nowrap" align="flex-start"><ThemeIcon variant="light" mt={2}><IconKey size={16} /></ThemeIcon><div><Group gap="xs"><Text fw={700}>{assignment.role.name}</Text><Badge color={statusColor[assignment.status]} variant="light">{assignment.status}</Badge></Group><Text size="xs" ff="monospace" c="dimmed">{assignment.role.code}</Text><Text size="sm" mt="xs">{scopeLabel(assignment)}</Text><Group gap="xs" mt={4}><IconCalendarClock size={14} color="var(--mantine-color-dimmed)" /><Text size="xs" c="dimmed">{formatDate(assignment.valid_from)} — {assignment.valid_until ? formatDate(assignment.valid_until) : 'Tanpa expiry'}</Text></Group><Text size="xs" c="dimmed" mt={4}>Assigned by {assignment.assigned_by.name}</Text>{assignment.revocation_reason && <Text size="xs" c="red" mt={4}>Revoked: {assignment.revocation_reason}</Text>}</div></Group>
          {!isSelf && assignment.can_revoke && <Button color="red" variant="subtle" px="xs" aria-label={`Revoke ${assignment.role.name}`} onClick={() => setRevoking(assignment)}><IconTrash size={16} /></Button>}
        </Group>
      </Card>)}
      {!busy && !assignments.length && <Card withBorder padding="xl"><Stack align="center" gap="xs"><ThemeIcon size="lg" variant="light"><IconKey size={18} /></ThemeIcon><Text fw={700}>Belum ada standard role assignment.</Text><Text size="sm" c="dimmed" ta="center">Privileged assignment tetap dikelola melalui Access Review.</Text></Stack></Card>}
    </Stack>

    {createOpened && catalog && <AssignRoleModal user={user} roles={catalog.data.roles} organization={organization} company={company} token={token} onClose={() => setCreateOpened(false)} onError={onError} onCompleted={async () => { setCreateOpened(false); await refresh(); onMessage(`Standard access ${user.name} berhasil ditambahkan.`) }} />}
    {revoking && <RevokeAssignmentModal assignment={revoking} user={user} company={company} token={token} onClose={() => setRevoking(null)} onError={onError} onCompleted={async () => { setRevoking(null); await refresh(); onMessage(`Assignment ${revoking.role.name} berhasil dicabut.`) }} />}
  </Stack>
}

function AssignRoleModal({ user, roles, organization, company, token, onClose, onError, onCompleted }: { user: IdentityUser; roles: StandardAccessRole[]; organization: Organization; company: Company; token: string; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [roleId, setRoleId] = useState('')
  const [departmentId, setDepartmentId] = useState<string | null>(null)
  const [locationId, setLocationId] = useState<string | null>(null)
  const [validFrom, setValidFrom] = useState(today())
  const [validUntil, setValidUntil] = useState('')
  const [reason, setReason] = useState('')
  const [busy, setBusy] = useState(false)
  const role = roles.find((item) => item.id === roleId) ?? null
  const departmentIds = useMemo(() => coveredMembershipIds(user.department_memberships, validFrom, validUntil), [user.department_memberships, validFrom, validUntil])
  const locationIds = useMemo(() => coveredMembershipIds(user.location_memberships, validFrom, validUntil), [user.location_memberships, validFrom, validUntil])
  const departments = organization.departments.filter((item) => departmentIds.includes(item.id))
  const locations = organization.locations.filter((item) => locationIds.includes(item.id))
  const scopeReady = role?.assignment_scope === 'department'
    ? Boolean(departmentId && departmentIds.includes(departmentId))
    : role?.assignment_scope === 'location'
      ? Boolean(locationId && locationIds.includes(locationId) && (!departmentId || departmentIds.includes(departmentId)))
      : Boolean(role)

  useEffect(() => {
    if (departmentId && !departmentIds.includes(departmentId)) setDepartmentId(null)
    if (locationId && !locationIds.includes(locationId)) setLocationId(null)
  }, [departmentId, departmentIds, locationId, locationIds])

  async function submit(event: FormEvent) {
    event.preventDefault()
    setBusy(true)
    try {
      await createStandardRoleAssignment(company.id, user.id, {
        role_id: roleId,
        department_id: departmentId,
        location_id: locationId,
        valid_from: validFrom,
        valid_until: validUntil || null,
        reason,
      }, token)
      await onCompleted()
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  return <Modal opened onClose={onClose} title={`Assign standard role · ${user.name}`} centered size="lg"><form onSubmit={(event) => void submit(event)}><Stack><Alert color="blue">Hanya role non-privileged yang tersedia. Privileged access harus melalui request dan approval.</Alert><Select label="Role" placeholder="Pilih standard role" searchable required data={roles.map((item) => ({ value: item.id, label: `${item.name} · ${item.assignment_scope}` }))} value={roleId} onChange={(value) => { setRoleId(value ?? ''); setDepartmentId(null); setLocationId(null) }} />{role?.description && <Text size="sm" c="dimmed">{role.description}</Text>}{role?.assignment_scope === 'department' && <Select label="Department" required data={departments.map((item) => ({ value: item.id, label: `${item.code} · ${item.name}` }))} value={departmentId} onChange={setDepartmentId} />}{role?.assignment_scope === 'location' && <><Select label="Location" required data={locations.map((item) => ({ value: item.id, label: `${item.code} · ${item.name}` }))} value={locationId} onChange={setLocationId} /><Select label="Department restriction" description="Opsional, untuk mempersempit access dalam location" clearable data={departments.map((item) => ({ value: item.id, label: `${item.code} · ${item.name}` }))} value={departmentId} onChange={setDepartmentId} /></>}<Divider /><Group grow align="flex-start"><TextInput type="date" label="Valid from" min={today()} value={validFrom} onChange={(event) => setValidFrom(event.currentTarget.value)} required /><TextInput type="date" label="Valid until" description="Kosong berarti mengikuti membership tanpa expiry" min={validFrom} value={validUntil} onChange={(event) => setValidUntil(event.currentTarget.value)} /></Group><Textarea label="Assignment reason" description="Dicatat pada audit log" minRows={3} minLength={10} value={reason} onChange={(event) => setReason(event.currentTarget.value)} required /><Button type="submit" loading={busy} disabled={!scopeReady || reason.trim().length < 10}>Assign standard role</Button></Stack></form></Modal>
}

function RevokeAssignmentModal({ assignment, user, company, token, onClose, onError, onCompleted }: { assignment: StandardRoleAssignment; user: IdentityUser; company: Company; token: string; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [reason, setReason] = useState('')
  const [busy, setBusy] = useState(false)

  async function revoke() {
    setBusy(true)
    try {
      await revokeStandardRoleAssignment(company.id, user.id, assignment.id, reason, token)
      await onCompleted()
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  return <Modal opened onClose={onClose} title="Revoke standard access" centered><Stack><Alert color="red">Permission berhenti efektif segera. Histori assignment dan alasan revocation tetap disimpan.</Alert><Text size="sm">Cabut <strong>{assignment.role.name}</strong> dari <strong>{user.name}</strong>?</Text><Textarea label="Revocation reason" minRows={3} minLength={10} value={reason} onChange={(event) => setReason(event.currentTarget.value)} required /><Button color="red" loading={busy} disabled={reason.trim().length < 10} onClick={() => void revoke()}>Revoke assignment</Button></Stack></Modal>
}

function coveredMembershipIds(memberships: Array<{ valid_from: string; valid_until: string | null; department?: { id: string }; location?: { id: string } }>, validFrom: string, validUntil: string): string[] {
  return memberships
    .filter((item) => item.valid_from <= validFrom && (validUntil ? !item.valid_until || item.valid_until >= validUntil : !item.valid_until))
    .map((item) => item.department?.id ?? item.location?.id ?? '')
    .filter(Boolean)
}

function scopeLabel(assignment: StandardRoleAssignment): string {
  const parts = [assignment.role.assignment_scope === 'company' ? 'Entire company' : null, assignment.location?.name, assignment.department?.name].filter(Boolean)
  return parts.join(' · ')
}

function formatDate(value: string): string {
  return new Intl.DateTimeFormat('id-ID', { dateStyle: 'medium' }).format(new Date(value))
}
