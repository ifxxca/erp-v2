import { type FormEvent, useMemo, useState } from 'react'
import {
  Alert,
  Avatar,
  Badge,
  Button,
  Card,
  Checkbox,
  Divider,
  Drawer,
  Group,
  MultiSelect,
  Select,
  Stack,
  Tabs,
  Text,
  Textarea,
  TextInput,
  Title,
} from '@mantine/core'
import { IconBuilding, IconCalendarEvent, IconKey, IconShieldExclamation, IconUser } from '@tabler/icons-react'
import {
  changeIdentityStatus,
  updateOrganizationMemberships,
  type Company,
  type IdentityUser,
  type MutableIdentityStatus,
  type Organization,
} from './api'
import { currentDepartments } from './identity'
import StandardAccessPanel from './StandardAccessPanel'

type Props = {
  user: IdentityUser
  organization: Organization
  company: Company
  token: string
  currentUserId: string
  canManageStatus: boolean
  onClose: () => void
  onChanged: (message: string) => Promise<void>
  onError: (error: unknown) => void
  onMessage: (message: string) => void
}

const tomorrow = () => {
  const date = new Date()
  date.setDate(date.getDate() + 1)
  return date.toISOString().slice(0, 10)
}

const formatDate = (value: string | null) => value
  ? new Intl.DateTimeFormat('id-ID', { dateStyle: 'medium' }).format(new Date(value))
  : 'Sekarang'

const badgeColor = (status: string) => status === 'active' ? 'green' : status === 'invited' ? 'yellow' : 'red'

function currentLocations(user: IdentityUser) {
  const today = new Date().toISOString().slice(0, 10)
  return user.location_memberships.filter((item) => item.valid_from <= today && (!item.valid_until || item.valid_until >= today))
}

export default function IdentityDrawer({ user, organization, company, token, currentUserId, canManageStatus, onClose, onChanged, onError, onMessage }: Props) {
  const activeDepartments = useMemo(() => currentDepartments(user), [user])
  const activeLocations = useMemo(() => currentLocations(user), [user])
  const [departmentIds, setDepartmentIds] = useState(() => activeDepartments.map((item) => item.department.id))
  const [primaryDepartmentId, setPrimaryDepartmentId] = useState(() => activeDepartments.find((item) => item.is_primary)?.department.id ?? '')
  const [locationIds, setLocationIds] = useState(() => activeLocations.map((item) => item.location.id))
  const [effectiveFrom, setEffectiveFrom] = useState(tomorrow())
  const [reason, setReason] = useState('')
  const [nextStatus, setNextStatus] = useState<MutableIdentityStatus>(user.status === 'active' ? 'suspended' : user.status === 'invited' ? 'disabled' : 'active')
  const [statusReason, setStatusReason] = useState('')
  const [statusConfirmed, setStatusConfirmed] = useState(false)
  const [busy, setBusy] = useState(false)

  const departmentOptions = organization.departments.map((item) => ({ value: item.id, label: `${item.code} · ${item.name}` }))
  const locationOptions = organization.locations.map((item) => ({ value: item.id, label: `${item.code} · ${item.name}` }))

  async function saveMemberships(event: FormEvent) {
    event.preventDefault()
    setBusy(true)
    try {
      await updateOrganizationMemberships(company.id, user.id, {
        department_ids: departmentIds,
        primary_department_id: primaryDepartmentId,
        location_ids: locationIds,
        effective_from: effectiveFrom,
        reason,
      }, token)
      await onChanged(`Perubahan organisasi ${user.name} dijadwalkan untuk ${formatDate(effectiveFrom)}.`)
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function changeStatus(event: FormEvent) {
    event.preventDefault()
    setBusy(true)
    try {
      await changeIdentityStatus(user.id, { status: nextStatus, reason: statusReason }, token)
      await onChanged(`Status identity ${user.name} diubah menjadi ${nextStatus}.`)
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  return (
    <Drawer opened onClose={onClose} position="right" size="lg" title={
      <Group wrap="nowrap">
        <Avatar color="forest" radius="xl">{user.name.slice(0, 2).toUpperCase()}</Avatar>
        <div><Title order={3}>{user.name}</Title><Text size="sm" c="dimmed">{user.email}</Text></div>
      </Group>
    }>
      <Tabs defaultValue="profile">
        <Tabs.List grow mb="xl">
          <Tabs.Tab value="profile" leftSection={<IconUser size={16} />}>Profile & organization</Tabs.Tab>
          {company.capabilities.can_assign_access && <Tabs.Tab value="access" leftSection={<IconKey size={16} />}>Access</Tabs.Tab>}
        </Tabs.List>

        <Tabs.Panel value="profile">
          <Stack gap="xl">
        <Group justify="space-between"><Badge color={badgeColor(user.status)} variant="light">{user.status}</Badge><Text size="xs" c="dimmed">Last login: {user.last_login_at ? formatDate(user.last_login_at) : 'Belum pernah'}</Text></Group>

        <section>
          <Group mb="sm"><IconBuilding size={18} /><Title order={4}>Employment</Title></Group>
          <Stack gap="xs">
            {user.company_memberships.map((membership) => (
              <Card key={membership.id} padding="sm" radius="md">
                <Group justify="space-between"><div><Text fw={700} size="sm">{membership.employee_no ?? 'Tanpa nomor pegawai'}</Text><Text size="xs" c="dimmed">{membership.employment_status}</Text></div><Text size="xs" c="dimmed">{formatDate(membership.valid_from)} — {formatDate(membership.valid_until)}</Text></Group>
              </Card>
            ))}
          </Stack>
        </section>

        <section>
          <Group mb="sm"><IconCalendarEvent size={18} /><Title order={4}>Organization history</Title></Group>
          <Stack gap="xs">
            {user.department_memberships.map((membership) => (
              <Card key={membership.id} padding="sm" radius="md">
                <Group justify="space-between"><div><Text fw={700} size="sm">{membership.department.name}{membership.is_primary ? ' · Primary' : ''}</Text><Text size="xs" c="dimmed">{membership.department.code}</Text></div><Text size="xs" c="dimmed">{formatDate(membership.valid_from)} — {formatDate(membership.valid_until)}</Text></Group>
              </Card>
            ))}
          </Stack>
        </section>

        {company.capabilities.can_manage_employment && <>
          <Divider />
          <section>
            <Title order={4} mb="xs">Schedule organization change</Title>
            <Text size="sm" c="dimmed" mb="md">Perubahan effective-dated menjaga histori organisasi dan tidak menimpa assignment lama.</Text>
            <form onSubmit={(event) => void saveMemberships(event)}>
              <Stack>
                <MultiSelect label="Departments" data={departmentOptions} value={departmentIds} onChange={(value) => { setDepartmentIds(value); if (!value.includes(primaryDepartmentId)) setPrimaryDepartmentId(value[0] ?? '') }} searchable required />
                <Select label="Primary department" data={departmentOptions.filter((item) => departmentIds.includes(item.value))} value={primaryDepartmentId} onChange={(value) => setPrimaryDepartmentId(value ?? '')} required />
                <MultiSelect label="Locations" data={locationOptions} value={locationIds} onChange={setLocationIds} searchable clearable />
                <TextInput type="date" label="Effective from" min={tomorrow()} value={effectiveFrom} onChange={(event) => setEffectiveFrom(event.currentTarget.value)} required />
                <Textarea label="Reason" minRows={3} minLength={10} value={reason} onChange={(event) => setReason(event.currentTarget.value)} required />
                <Button type="submit" loading={busy} disabled={!departmentIds.length || !primaryDepartmentId || reason.trim().length < 10}>Schedule change</Button>
              </Stack>
            </form>
          </section>
        </>}

        {canManageStatus && <>
          <Divider />
          <section>
            <Alert color="red" icon={<IconShieldExclamation size={18} />} title="Global identity status" mb="md">Suspend atau disable mencabut seluruh web session dan mobile refresh-token family. Recent MFA wajib.</Alert>
            <form onSubmit={(event) => void changeStatus(event)}>
              <Stack>
                <Select label="New status" data={[{ value: 'active', label: 'Active' }, { value: 'suspended', label: 'Suspended' }, { value: 'disabled', label: 'Disabled' }]} value={nextStatus} onChange={(value) => { setNextStatus(value ?? 'active'); setStatusConfirmed(false) }} />
                <Textarea label="Reason" minRows={3} minLength={10} value={statusReason} onChange={(event) => setStatusReason(event.currentTarget.value)} required />
                <Checkbox checked={statusConfirmed} onChange={(event) => setStatusConfirmed(event.currentTarget.checked)} label="Saya memahami dampak perubahan status global ini." />
                <Button type="submit" color="red" loading={busy} disabled={!statusConfirmed || statusReason.trim().length < 10}>Apply global status</Button>
              </Stack>
            </form>
          </section>
        </>}
          </Stack>
        </Tabs.Panel>

        {company.capabilities.can_assign_access && <Tabs.Panel value="access">
          <StandardAccessPanel user={user} currentUserId={currentUserId} organization={organization} company={company} token={token} onError={onError} onMessage={onMessage} />
        </Tabs.Panel>}
      </Tabs>
    </Drawer>
  )
}
