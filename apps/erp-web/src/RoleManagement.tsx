import { type FormEvent, type ReactNode, useCallback, useEffect, useMemo, useState } from 'react'
import {
  Alert,
  Badge,
  Button,
  Card,
  Checkbox,
  Divider,
  Grid,
  Group,
  LoadingOverlay,
  Modal,
  Paper,
  ScrollArea,
  Select,
  SimpleGrid,
  Stack,
  Switch,
  Text,
  Textarea,
  TextInput,
  ThemeIcon,
  Title,
  UnstyledButton,
} from '@mantine/core'
import { useForm } from '@mantine/form'
import {
  IconAlertTriangle,
  IconKey,
  IconLock,
  IconPlus,
  IconSearch,
  IconShieldCheck,
  IconTrash,
  IconUsersGroup,
} from '@tabler/icons-react'
import {
  createRole,
  deleteRole as deleteRoleRequest,
  listRoles,
  syncRolePermissions,
  updateRole,
  type CreateRoleInput,
  type ManagedRole,
  type RoleCatalog,
  type RoleCatalogPermission,
  type UpdateRoleInput,
} from './api'

type Props = {
  token: string
  onError: (error: unknown) => void
  onMessage: (message: string) => void
}

type PermissionGroups = Array<{ module: string; permissions: RoleCatalogPermission[] }>

const scopeData = [
  { value: 'company', label: 'Company' },
  { value: 'department', label: 'Department' },
  { value: 'location', label: 'Location' },
]

export default function RoleManagement({ token, onError, onMessage }: Props) {
  const [catalog, setCatalog] = useState<RoleCatalog | null>(null)
  const [selectedId, setSelectedId] = useState('')
  const [search, setSearch] = useState('')
  const [busy, setBusy] = useState(false)
  const [createOpened, setCreateOpened] = useState(false)
  const [editOpened, setEditOpened] = useState(false)
  const [deleteOpened, setDeleteOpened] = useState(false)
  const [permissionIds, setPermissionIds] = useState<string[]>([])
  const [permissionReason, setPermissionReason] = useState('')

  const refresh = useCallback(async () => {
    setBusy(true)
    try {
      const response = await listRoles(token)
      setCatalog(response)
      setSelectedId((current) => response.data.roles.some((role) => role.id === current)
        ? current
        : response.data.roles[0]?.id ?? '')
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }, [onError, token])

  useEffect(() => { void refresh() }, [refresh])

  const roles = useMemo(() => catalog?.data.roles ?? [], [catalog])
  const permissions = useMemo(() => catalog?.data.permissions ?? [], [catalog])
  const selectedRole = roles.find((role) => role.id === selectedId) ?? null
  const filteredRoles = roles.filter((role) => `${role.name} ${role.code}`.toLowerCase().includes(search.toLowerCase()))

  useEffect(() => {
    setPermissionIds(selectedRole?.permission_ids ?? [])
    setPermissionReason('')
  }, [selectedRole])

  const groups = useMemo(() => groupPermissions(permissions), [permissions])

  async function savePermissions(event: FormEvent) {
    event.preventDefault()
    if (!selectedRole) return
    setBusy(true)
    try {
      await syncRolePermissions(selectedRole.id, { permission_ids: permissionIds, reason: permissionReason }, token)
      onMessage(`Permission ${selectedRole.name} berhasil diperbarui.`)
      await refresh()
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function deleteRole(reason: string) {
    if (!selectedRole) return
    setBusy(true)
    try {
      await deleteRoleRequest(selectedRole.id, reason, token)
      setDeleteOpened(false)
      setSelectedId('')
      onMessage(`Role ${selectedRole.name} berhasil dihapus.`)
      await refresh()
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  return <Stack gap="lg">
    <SimpleGrid cols={{ base: 1, sm: 4 }}>
      <Metric label="Total roles" value={roles.length} icon={<IconUsersGroup size={19} />} />
      <Metric label="System roles" value={roles.filter((role) => role.is_system).length} icon={<IconLock size={19} />} />
      <Metric label="Custom roles" value={roles.filter((role) => !role.is_system).length} icon={<IconKey size={19} />} />
      <Metric label="Privileged roles" value={roles.filter((role) => role.is_privileged).length} icon={<IconShieldCheck size={19} />} />
    </SimpleGrid>

    <Grid align="stretch">
      <Grid.Col span={{ base: 12, lg: 4 }}>
        <Card padding={0} h="100%" pos="relative">
          <LoadingOverlay visible={busy && !catalog} />
          <Group p="md" align="flex-end">
            <TextInput style={{ flex: 1 }} label="Cari role" placeholder="Nama atau code" leftSection={<IconSearch size={16} />} value={search} onChange={(event) => setSearch(event.currentTarget.value)} />
            {catalog?.meta.can_manage && <Button px="sm" aria-label="Buat role" onClick={() => setCreateOpened(true)}><IconPlus size={18} /></Button>}
          </Group>
          <Divider />
          <ScrollArea h={620}>
            <Stack gap={0} p="xs">
              {filteredRoles.map((role) => <RoleListItem key={role.id} role={role} active={role.id === selectedId} onClick={() => setSelectedId(role.id)} />)}
              {!filteredRoles.length && <Text c="dimmed" size="sm" ta="center" py="xl">Role tidak ditemukan.</Text>}
            </Stack>
          </ScrollArea>
        </Card>
      </Grid.Col>

      <Grid.Col span={{ base: 12, lg: 8 }}>
        {selectedRole ? <Card padding="xl" pos="relative" h="100%">
          <LoadingOverlay visible={busy} overlayProps={{ blur: 1 }} />
          <Group justify="space-between" align="flex-start">
            <div>
              <Group gap="xs"><Title order={2}>{selectedRole.name}</Title>{selectedRole.is_system && <Badge color="blue" variant="light">System</Badge>}{selectedRole.is_privileged && <Badge color="orange" variant="light">Privileged</Badge>}</Group>
              <Text ff="monospace" size="sm" c="dimmed" mt={4}>{selectedRole.code}</Text>
            </div>
            {catalog?.meta.can_manage && selectedRole.can_edit && <Group gap="xs"><Button variant="light" onClick={() => setEditOpened(true)}>Edit profile</Button><Button color="red" variant="subtle" leftSection={<IconTrash size={16} />} disabled={selectedRole.has_history} onClick={() => setDeleteOpened(true)}>Delete</Button></Group>}
          </Group>

          <Text c="dimmed" mt="md">{selectedRole.description || 'Belum ada deskripsi role.'}</Text>
          <SimpleGrid cols={{ base: 2, sm: 4 }} mt="xl">
            <Detail label="Assignment scope" value={selectedRole.assignment_scope} />
            <Detail label="Permissions" value={String(selectedRole.permission_count)} />
            <Detail label="Active assignments" value={String(selectedRole.active_assignment_count)} />
            <Detail label="Assignment history" value={String(selectedRole.assignment_count)} />
          </SimpleGrid>

          <Divider my="xl" />
          <Group justify="space-between" mb="md"><div><Title order={3}>Permission mapping</Title><Text size="sm" c="dimmed">Permission code bersifat stabil; role hanya mengatur capability yang dikumpulkan.</Text></div></Group>

          {selectedRole.is_system ? <>
            <Alert color="blue" icon={<IconLock size={18} />} title="Protected system role" mb="lg">Perubahan system role hanya dilakukan melalui reviewed release agar baseline authorization tetap dapat direproduksi.</Alert>
            <PermissionReadOnly groups={groups} selected={selectedRole.permission_ids} />
          </> : !catalog?.meta.can_manage ? <>
            <Alert color="gray" mb="lg">Anda memiliki akses lihat. Perubahan role memerlukan global identity.role.manage dan verifikasi MFA terbaru.</Alert>
            <PermissionReadOnly groups={groups} selected={selectedRole.permission_ids} />
          </> : <form onSubmit={(event) => void savePermissions(event)}>
            <Stack>
              <PermissionPicker groups={groups} selected={permissionIds} onChange={setPermissionIds} />
              <Textarea label="Change reason" description="Dicatat pada audit log" minRows={2} minLength={10} value={permissionReason} onChange={(event) => setPermissionReason(event.currentTarget.value)} required />
              <Button type="submit" style={{ alignSelf: 'flex-end' }} disabled={!permissionIds.length || permissionReason.trim().length < 10} loading={busy}>Save permission mapping</Button>
            </Stack>
          </form>}

          {selectedRole.has_history && !selectedRole.is_system && <Alert color="gray" mt="xl">Role memiliki assignment atau access-request history sehingga tidak dapat dihapus.</Alert>}
        </Card> : <Card h="100%"><Stack align="center" justify="center" h={500}><ThemeIcon size={52} radius="xl" variant="light"><IconUsersGroup size={25} /></ThemeIcon><Text fw={700}>Pilih role untuk melihat detail.</Text></Stack></Card>}
      </Grid.Col>
    </Grid>

    {createOpened && <CreateRoleModal opened token={token} permissions={permissions} onClose={() => setCreateOpened(false)} onError={onError} onCompleted={async (id) => { setCreateOpened(false); await refresh(); setSelectedId(id); onMessage('Custom role berhasil dibuat.') }} />}
    {selectedRole && editOpened && <EditRoleModal role={selectedRole} token={token} onClose={() => setEditOpened(false)} onError={onError} onCompleted={async () => { setEditOpened(false); await refresh(); onMessage(`Profile ${selectedRole.name} berhasil diperbarui.`) }} />}
    {selectedRole && deleteOpened && <DeleteRoleModal role={selectedRole} busy={busy} onClose={() => setDeleteOpened(false)} onDelete={deleteRole} />}
  </Stack>
}

function RoleListItem({ role, active, onClick }: { role: ManagedRole; active: boolean; onClick: () => void }) {
  return <UnstyledButton onClick={onClick} p="sm" style={(theme) => ({ borderRadius: theme.radius.md, background: active ? theme.colors.forest[0] : undefined })}>
    <Group justify="space-between" wrap="nowrap"><div><Group gap={6}><Text size="sm" fw={700}>{role.name}</Text>{role.is_system && <IconLock size={13} color="var(--mantine-color-blue-6)" />}</Group><Text size="xs" c="dimmed">{role.code} · {role.assignment_scope}</Text></div><Badge size="sm" variant="light" color={role.is_privileged ? 'orange' : 'gray'}>{role.permission_count}</Badge></Group>
  </UnstyledButton>
}

function Metric({ label, value, icon }: { label: string; value: number; icon: ReactNode }) {
  return <Card padding="lg"><Group justify="space-between"><div><Text size="sm" c="dimmed">{label}</Text><Title order={3} mt={5}>{value}</Title></div><ThemeIcon size="lg" variant="light">{icon}</ThemeIcon></Group></Card>
}

function Detail({ label, value }: { label: string; value: string }) {
  return <Paper bg="gray.0" p="sm" radius="md"><Text size="xs" c="dimmed">{label}</Text><Text fw={700} mt={3} tt="capitalize">{value}</Text></Paper>
}

function PermissionPicker({ groups, selected, onChange }: { groups: PermissionGroups; selected: string[]; onChange: (value: string[]) => void }) {
  const toggle = (id: string) => onChange(selected.includes(id) ? selected.filter((item) => item !== id) : [...selected, id])
  return <Stack gap="lg">{groups.map((group) => <section key={group.module}><Text fw={800} size="xs" tt="uppercase" c="dimmed" mb="sm">{group.module}</Text><SimpleGrid cols={{ base: 1, md: 2 }}>{group.permissions.map((permission) => <Checkbox key={permission.id} checked={selected.includes(permission.id)} disabled={permission.global_only} onChange={() => toggle(permission.id)} label={<div><Text size="sm" fw={600}>{permission.code}</Text><Text size="xs" c="dimmed">{permission.resource} · {permission.action}{permission.global_only ? ' · global only' : ''}</Text></div>} />)}</SimpleGrid></section>)}</Stack>
}

function PermissionReadOnly({ groups, selected }: { groups: PermissionGroups; selected: string[] }) {
  const activeGroups = groups.map((group) => ({ ...group, permissions: group.permissions.filter((permission) => selected.includes(permission.id)) })).filter((group) => group.permissions.length)
  return <Stack gap="lg">{activeGroups.map((group) => <section key={group.module}><Text fw={800} size="xs" tt="uppercase" c="dimmed" mb="sm">{group.module}</Text><SimpleGrid cols={{ base: 1, md: 2 }}>{group.permissions.map((permission) => <Paper key={permission.id} withBorder p="sm" radius="md"><Group wrap="nowrap"><ThemeIcon size="sm" color="green" variant="light"><IconShieldCheck size={13} /></ThemeIcon><div><Text size="sm" fw={600}>{permission.code}</Text><Text size="xs" c="dimmed">{permission.resource} · {permission.action}</Text></div></Group></Paper>)}</SimpleGrid></section>)}</Stack>
}

function CreateRoleModal({ opened, token, permissions, onClose, onError, onCompleted }: { opened: boolean; token: string; permissions: RoleCatalogPermission[]; onClose: () => void; onError: (error: unknown) => void; onCompleted: (id: string) => Promise<void> }) {
  const [busy, setBusy] = useState(false)
  const groups = useMemo(() => groupPermissions(permissions), [permissions])
  const form = useForm<CreateRoleInput>({
    mode: 'controlled',
    initialValues: { code: '', name: '', description: '', assignment_scope: 'company', is_privileged: false, permission_ids: [], reason: '' },
    validate: {
      code: (value) => /^[a-z][a-z0-9-]{2,127}$/.test(value) ? null : 'Gunakan lowercase dan tanda hubung.',
      name: (value) => value.trim().length >= 3 ? null : 'Nama role wajib diisi.',
      permission_ids: (value) => value.length ? null : 'Pilih minimal satu permission.',
      reason: (value) => value.trim().length >= 10 ? null : 'Alasan minimal 10 karakter.',
    },
  })

  async function submit(values: typeof form.values) {
    setBusy(true)
    try {
      await onCompleted(await createRole(values, token))
    } catch (cause) { onError(cause) } finally { setBusy(false) }
  }

  return <Modal opened={opened} onClose={onClose} title="Create custom role" size="xl" centered><form onSubmit={form.onSubmit((values) => void submit(values))}><Stack><Alert color="blue">Custom role hanya dapat memakai company, department, atau location scope. Global role tetap dikelola sebagai system baseline.</Alert><SimpleGrid cols={{ base: 1, sm: 2 }}><TextInput label="Role code" placeholder="regional-fleet-coordinator" required {...form.getInputProps('code')} /><TextInput label="Role name" required {...form.getInputProps('name')} /></SimpleGrid><Textarea label="Description" minRows={2} {...form.getInputProps('description')} /><SimpleGrid cols={{ base: 1, sm: 2 }}><Select label="Assignment scope" data={scopeData} allowDeselect={false} required {...form.getInputProps('assignment_scope')} /><Switch label="Privileged role" description="Assignment wajib MFA dan approval" mt="xl" {...form.getInputProps('is_privileged', { type: 'checkbox' })} /></SimpleGrid><Divider label="Permissions" labelPosition="left" /><PermissionPicker groups={groups} selected={form.values.permission_ids} onChange={(value) => form.setFieldValue('permission_ids', value)} /><Textarea label="Creation reason" minRows={2} required {...form.getInputProps('reason')} /><Button type="submit" loading={busy}>Create role</Button></Stack></form></Modal>
}

function EditRoleModal({ role, token, onClose, onError, onCompleted }: { role: ManagedRole; token: string; onClose: () => void; onError: (error: unknown) => void; onCompleted: () => Promise<void> }) {
  const [busy, setBusy] = useState(false)
  const form = useForm<UpdateRoleInput>({ mode: 'controlled', initialValues: { name: role.name, description: role.description ?? '', assignment_scope: role.assignment_scope as UpdateRoleInput['assignment_scope'], is_privileged: role.is_privileged, reason: '' }, validate: { name: (value) => value.trim().length >= 3 ? null : 'Nama role wajib diisi.', reason: (value) => value.trim().length >= 10 ? null : 'Alasan minimal 10 karakter.' } })
  async function submit(values: typeof form.values) {
    setBusy(true)
    try { await updateRole(role.id, values, token); await onCompleted() } catch (cause) { onError(cause) } finally { setBusy(false) }
  }
  return <Modal opened onClose={onClose} title={`Edit ${role.name}`} centered><form onSubmit={form.onSubmit((values) => void submit(values))}><Stack><TextInput label="Role code" value={role.code} disabled /><TextInput label="Role name" required {...form.getInputProps('name')} /><Textarea label="Description" minRows={2} {...form.getInputProps('description')} /><Select label="Assignment scope" data={scopeData} allowDeselect={false} required {...form.getInputProps('assignment_scope')} /><Switch label="Privileged role" {...form.getInputProps('is_privileged', { type: 'checkbox' })} />{role.active_assignment_count > 0 && <Alert color="orange" icon={<IconAlertTriangle size={17} />}>Scope dan privileged classification tidak dapat diubah selama assignment aktif.</Alert>}<Textarea label="Change reason" minRows={2} required {...form.getInputProps('reason')} /><Button type="submit" loading={busy}>Save profile</Button></Stack></form></Modal>
}

function DeleteRoleModal({ role, busy, onClose, onDelete }: { role: ManagedRole; busy: boolean; onClose: () => void; onDelete: (reason: string) => Promise<void> }) {
  const [reason, setReason] = useState('')
  return <Modal opened onClose={onClose} title="Delete custom role" centered><Stack><Alert color="red" icon={<IconAlertTriangle size={17} />}>Role hanya dapat dihapus jika belum pernah dipakai dalam assignment atau access request.</Alert><Text size="sm">Hapus <strong>{role.name}</strong>?</Text><Textarea label="Deletion reason" minRows={2} value={reason} onChange={(event) => setReason(event.currentTarget.value)} required /><Button color="red" loading={busy} disabled={reason.trim().length < 10} onClick={() => void onDelete(reason)}>Delete role</Button></Stack></Modal>
}

function groupPermissions(permissions: RoleCatalogPermission[]): PermissionGroups {
  return Array.from(permissions.reduce((groups, permission) => {
    const items = groups.get(permission.module) ?? []
    items.push(permission)
    groups.set(permission.module, items)
    return groups
  }, new Map<string, RoleCatalogPermission[]>()), ([module, items]) => ({ module, permissions: items }))
}
