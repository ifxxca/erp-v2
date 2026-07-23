import { useCallback, useEffect, useMemo, useState } from 'react'
import {
  ActionIcon, AppShell, Badge, Box, Button, Card, Center, Container, Divider, Group, Loader, Modal,
  NumberInput, PasswordInput, Select, SimpleGrid, Stack, Table, Tabs, Text, Textarea, TextInput, Title,
} from '@mantine/core'
import { useDisclosure } from '@mantine/hooks'
import { useForm } from '@mantine/form'
import { notifications } from '@mantine/notifications'
import { IconCar, IconClipboardCheck, IconLogout, IconPlus, IconRefresh, IconTool } from '@tabler/icons-react'
import './App.css'
import {
  ApiError, apiRequest, type LoginResponse, type OperationsContext, type Page, type Vehicle,
  type VehicleType, type WorkOrder,
} from './api'

type Workspace = 'fleet' | 'maintenance'
type AuthStage = 'login' | 'mfa' | 'loading' | 'ready'
const statusColor: Record<string, string> = {
  available: 'green', in_use: 'blue', maintenance: 'orange', blocked: 'red', inactive: 'gray',
  draft: 'gray', scheduled: 'blue', in_progress: 'orange', completed: 'green', cancelled: 'red',
}
const statusLabel: Record<string, string> = {
  available: 'Tersedia', in_use: 'Digunakan', maintenance: 'Maintenance', blocked: 'Diblokir', inactive: 'Nonaktif',
  draft: 'Draft', scheduled: 'Terjadwal', in_progress: 'Dikerjakan', completed: 'Selesai', cancelled: 'Dibatalkan',
}

function App() {
  const [token, setToken] = useState(() => sessionStorage.getItem('ops_access_token') ?? '')
  const [stage, setStage] = useState<AuthStage>(token ? 'loading' : 'login')
  const [contexts, setContexts] = useState<OperationsContext[]>([])
  const [contextKey, setContextKey] = useState('')
  const [workspace, setWorkspace] = useState<Workspace>('fleet')
  const [vehicles, setVehicles] = useState<Vehicle[]>([])
  const [vehicleTypes, setVehicleTypes] = useState<VehicleType[]>([])
  const [workOrders, setWorkOrders] = useState<WorkOrder[]>([])
  const [busy, setBusy] = useState(false)
  const [vehicleOpened, vehicleModal] = useDisclosure(false)
  const [typeOpened, typeModal] = useDisclosure(false)
  const [workOrderOpened, workOrderModal] = useDisclosure(false)

  const activeContext = contexts.find((item) => `${item.company.id}:${item.location.id}` === contextKey) ?? null
  const base = activeContext ? `/companies/${activeContext.company.id}/locations/${activeContext.location.id}` : ''

  const resetSession = useCallback(() => {
    sessionStorage.removeItem('ops_access_token'); setToken(''); setContexts([]); setContextKey(''); setStage('login')
  }, [])
  const reportError = useCallback((cause: unknown) => {
    if (cause instanceof ApiError) {
      if (cause.status === 401) resetSession()
      if (cause.code === 'MFA_CHALLENGE_REQUIRED') setStage('mfa')
      const detail = cause.errors ? Object.values(cause.errors).flat()[0] : cause.message
      notifications.show({ color: 'red', title: 'Permintaan gagal', message: `${detail}${cause.requestId ? ` · Ref ${cause.requestId}` : ''}` })
    } else notifications.show({ color: 'red', title: 'API tidak terjangkau', message: 'Periksa koneksi service Operations.' })
  }, [resetSession])

  useEffect(() => {
    if (!token || stage === 'mfa') return
    apiRequest<{ data: OperationsContext[] }>('/operations/context', {}, token).then((response) => {
      setContexts(response.data)
      setContextKey((current) => current || (response.data[0] ? `${response.data[0].company.id}:${response.data[0].location.id}` : ''))
      setStage('ready')
    }).catch(reportError)
  }, [reportError, stage, token])

  const loadData = useCallback(async () => {
    if (!base || !activeContext) return
    setBusy(true)
    try {
      const requests: Promise<unknown>[] = []
      if (activeContext.capabilities.can_view_vehicles) {
        requests.push(apiRequest<Page<Vehicle>>(`${base}/fleet/vehicles?per_page=100`, {}, token).then((r) => setVehicles(r.data)))
        requests.push(apiRequest<{ data: VehicleType[] }>(`${base}/fleet/vehicle-types`, {}, token).then((r) => setVehicleTypes(r.data)))
      }
      if (activeContext.capabilities.can_view_work_orders) {
        requests.push(apiRequest<Page<WorkOrder>>(`${base}/maintenance/work-orders?per_page=100`, {}, token).then((r) => setWorkOrders(r.data)))
      }
      await Promise.all(requests)
    } catch (cause) { reportError(cause) } finally { setBusy(false) }
  }, [activeContext, base, reportError, token])
  useEffect(() => { if (stage === 'ready') void loadData() }, [loadData, stage])

  async function logout() { try { await apiRequest('/auth/logout', { method: 'POST' }, token) } finally { resetSession() } }
  if (stage === 'login') return <Login onAuthenticated={(accessToken, mfa) => { sessionStorage.setItem('ops_access_token', accessToken); setToken(accessToken); setStage(mfa ? 'mfa' : 'loading') }} />
  if (stage === 'mfa') return <Mfa token={token} onVerified={() => setStage('loading')} onCancel={resetSession} />
  if (stage === 'loading') return <Center mih="100vh"><Stack align="center"><Loader /><Text c="dimmed">Menyiapkan area operasional…</Text></Stack></Center>
  if (!activeContext) return <Center mih="100vh"><Card maw={460}><Stack><Title order={2}>Belum ada area kerja</Title><Text c="dimmed">Akun ini belum memiliki akses Fleet atau Maintenance pada lokasi aktif.</Text><Button onClick={logout}>Keluar</Button></Stack></Card></Center>

  const contextOptions = contexts.map((item) => ({ value: `${item.company.id}:${item.location.id}`, label: `${item.company.code} · ${item.location.name}` }))
  return <AppShell header={{ height: 72 }} padding="md">
    <AppShell.Header><Container size="xl" h="100%"><Group h="100%" justify="space-between">
      <Group gap="sm"><Box className="brand-mark"><IconTool size={21} /></Box><Box><Text fw={800}>Rajawali Operations</Text><Text size="xs" c="dimmed">Fleet & Maintenance</Text></Box></Group>
      <Group><Select aria-label="Area kerja" data={contextOptions} value={contextKey} onChange={(value) => value && setContextKey(value)} w={{ base: 180, sm: 280 }} /><ActionIcon variant="subtle" onClick={() => void loadData()} aria-label="Muat ulang"><IconRefresh size={18} /></ActionIcon><ActionIcon color="gray" variant="subtle" onClick={logout} aria-label="Keluar"><IconLogout size={18} /></ActionIcon></Group>
    </Group></Container></AppShell.Header>
    <AppShell.Main><Container size="xl"><Stack gap="lg">
      <Box><Text className="eyebrow">{activeContext.company.legal_name} · {activeContext.location.name}</Text><Title order={1}>Kendaraan siap, pekerjaan terpantau.</Title><Text c="dimmed" maw={680}>Status armada dan maintenance menggunakan satu lifecycle yang sama untuk web operasional, ERP, dan aplikasi mobile berikutnya.</Text></Box>
      <SimpleGrid cols={{ base: 2, sm: 4 }}>
        <Metric label="Total kendaraan" value={vehicles.length} />
        <Metric label="Tersedia" value={vehicles.filter((v) => v.operational_status === 'available').length} tone="green" />
        <Metric label="Maintenance" value={vehicles.filter((v) => v.operational_status === 'maintenance').length} tone="orange" />
        <Metric label="WO aktif" value={workOrders.filter((wo) => ['scheduled', 'in_progress'].includes(wo.status)).length} tone="blue" />
      </SimpleGrid>
      <Tabs value={workspace} onChange={(value) => setWorkspace(value as Workspace)}>
        <Tabs.List><Tabs.Tab value="fleet" leftSection={<IconCar size={16} />}>Fleet</Tabs.Tab><Tabs.Tab value="maintenance" leftSection={<IconClipboardCheck size={16} />}>Work order</Tabs.Tab></Tabs.List>
        <Tabs.Panel value="fleet" pt="lg"><FleetPanel vehicles={vehicles} busy={busy} canManage={activeContext.capabilities.can_manage_vehicles} onAdd={vehicleModal.open} onAddType={typeModal.open} onStatus={async (vehicle, status) => {
          try { await apiRequest(`${base}/fleet/vehicles/${vehicle.id}/status`, { method: 'POST', body: JSON.stringify({ status, reason: `Status changed by Operations to ${status}.` }) }, token); await loadData() } catch (cause) { reportError(cause) }
        }} /></Tabs.Panel>
        <Tabs.Panel value="maintenance" pt="lg"><MaintenancePanel orders={workOrders} busy={busy} canManage={activeContext.capabilities.can_manage_work_orders} onAdd={workOrderModal.open} onTransition={async (order, status) => {
          try { await apiRequest(`${base}/maintenance/work-orders/${order.id}/transition`, { method: 'POST', body: JSON.stringify({ status, note: ['completed', 'cancelled'].includes(status) ? `Work order ${status} from Operations.` : null }) }, token); await loadData() } catch (cause) { reportError(cause) }
        }} /></Tabs.Panel>
      </Tabs>
    </Stack></Container></AppShell.Main>
    <VehicleModal opened={vehicleOpened} onClose={vehicleModal.close} types={vehicleTypes} onSubmit={async (values) => { await apiRequest(`${base}/fleet/vehicles`, { method: 'POST', body: JSON.stringify(values) }, token); vehicleModal.close(); await loadData() }} reportError={reportError} />
    <VehicleTypeModal opened={typeOpened} onClose={typeModal.close} onSubmit={async (values) => { await apiRequest(`${base}/fleet/vehicle-types`, { method: 'POST', body: JSON.stringify(values) }, token); typeModal.close(); await loadData() }} reportError={reportError} />
    <WorkOrderModal opened={workOrderOpened} onClose={workOrderModal.close} vehicles={vehicles} onSubmit={async (values) => { await apiRequest(`${base}/maintenance/work-orders`, { method: 'POST', body: JSON.stringify(values) }, token); workOrderModal.close(); await loadData() }} reportError={reportError} />
  </AppShell>
}

function Login({ onAuthenticated }: { onAuthenticated: (token: string, mfa: boolean) => void }) {
  const form = useForm({ initialValues: { email: '', password: '' } }); const [busy, setBusy] = useState(false)
  return <Center mih="100vh" p="md" className="auth-bg"><Card w="100%" maw={420} p="xl"><form onSubmit={form.onSubmit(async (values) => { setBusy(true); try { const response = await apiRequest<LoginResponse>('/auth/login', { method: 'POST', body: JSON.stringify({ ...values, device_name: navigator.userAgent.slice(0, 120), surface: 'ops_web' }) }); onAuthenticated(response.access_token, response.mfa_required) } catch (cause) { notifications.show({ color: 'red', title: 'Login gagal', message: cause instanceof Error ? cause.message : 'Periksa kredensial.' }) } finally { setBusy(false) } })}><Stack><Box className="brand-mark"><IconTool /></Box><Title order={2}>Masuk ke Operations</Title><Text c="dimmed" size="sm">Gunakan akun perusahaan dan area kerja yang sudah diberikan.</Text><TextInput label="Email" type="email" required {...form.getInputProps('email')} /><PasswordInput label="Password" required {...form.getInputProps('password')} /><Button type="submit" loading={busy}>Masuk</Button></Stack></form></Card></Center>
}
function Mfa({ token, onVerified, onCancel }: { token: string; onVerified: () => void; onCancel: () => void }) {
  const [code, setCode] = useState(''); const [busy, setBusy] = useState(false)
  return <Center mih="100vh" p="md"><Card w="100%" maw={420} p="xl"><Stack><Title order={2}>Verifikasi MFA</Title><Text c="dimmed">Masukkan kode authenticator atau recovery code.</Text><TextInput label="Kode" value={code} onChange={(event) => setCode(event.currentTarget.value)} /><Button loading={busy} onClick={async () => { setBusy(true); try { await apiRequest('/auth/mfa/challenge', { method: 'POST', body: JSON.stringify({ code }) }, token); onVerified() } catch (cause) { notifications.show({ color: 'red', title: 'Verifikasi gagal', message: cause instanceof Error ? cause.message : 'Kode tidak valid.' }) } finally { setBusy(false) } }}>Verifikasi</Button><Button variant="subtle" color="gray" onClick={onCancel}>Batal</Button></Stack></Card></Center>
}
function Metric({ label, value, tone = 'dark' }: { label: string; value: number; tone?: string }) { return <Card p="md"><Text size="xs" c="dimmed" tt="uppercase" fw={700}>{label}</Text><Text fz={30} fw={850} c={tone}>{value}</Text></Card> }

function FleetPanel({ vehicles, busy, canManage, onAdd, onAddType, onStatus }: { vehicles: Vehicle[]; busy: boolean; canManage: boolean; onAdd: () => void; onAddType: () => void; onStatus: (vehicle: Vehicle, status: string) => void }) {
  return <Card p={0}><Group justify="space-between" p="md"><Box><Text fw={800}>Master kendaraan</Text><Text size="sm" c="dimmed">Status saat ini adalah sumber kebenaran operasional.</Text></Box>{canManage && <Group><Button variant="light" onClick={onAddType}>Tambah tipe</Button><Button leftSection={<IconPlus size={16} />} onClick={onAdd}>Tambah kendaraan</Button></Group>}</Group><Divider /><Box className="table-scroll"><Table striped highlightOnHover><Table.Thead><Table.Tr><Table.Th>Armada</Table.Th><Table.Th>Tipe</Table.Th><Table.Th>Odometer</Table.Th><Table.Th>Status</Table.Th><Table.Th>Aksi</Table.Th></Table.Tr></Table.Thead><Table.Tbody>{vehicles.map((vehicle) => <Table.Tr key={vehicle.id}><Table.Td><Text fw={700}>{vehicle.plate_number}</Text><Text size="xs" c="dimmed">{vehicle.code} · {vehicle.brand} {vehicle.model}</Text></Table.Td><Table.Td>{vehicle.type?.name}</Table.Td><Table.Td>{vehicle.current_odometer.toLocaleString('id-ID')} km</Table.Td><Table.Td><Badge color={statusColor[vehicle.operational_status]}>{statusLabel[vehicle.operational_status]}</Badge></Table.Td><Table.Td>{canManage && <Select size="xs" w={150} placeholder="Ubah status" value={null} onChange={(value) => value && onStatus(vehicle, value)} data={['available', 'in_use', 'maintenance', 'blocked', 'inactive'].filter((s) => s !== vehicle.operational_status).map((s) => ({ value: s, label: statusLabel[s] }))} />}</Table.Td></Table.Tr>)}</Table.Tbody></Table></Box>{!busy && !vehicles.length && <Text p="xl" ta="center" c="dimmed">Belum ada kendaraan pada lokasi ini.</Text>}</Card>
}
function MaintenancePanel({ orders, busy, canManage, onAdd, onTransition }: { orders: WorkOrder[]; busy: boolean; canManage: boolean; onAdd: () => void; onTransition: (order: WorkOrder, status: string) => void }) {
  const actions: Record<string, { value: string; label: string }[]> = { draft: [{ value: 'scheduled', label: 'Jadwalkan' }, { value: 'cancelled', label: 'Batalkan' }], scheduled: [{ value: 'in_progress', label: 'Mulai kerja' }, { value: 'cancelled', label: 'Batalkan' }], in_progress: [{ value: 'completed', label: 'Selesaikan' }, { value: 'cancelled', label: 'Batalkan' }] }
  return <Card p={0}><Group justify="space-between" p="md"><Box><Text fw={800}>Maintenance work order</Text><Text size="sm" c="dimmed">Nomor resmi dialokasikan saat draft dijadwalkan.</Text></Box>{canManage && <Button leftSection={<IconPlus size={16} />} onClick={onAdd}>Buat work order</Button>}</Group><Divider /><Box className="table-scroll"><Table striped highlightOnHover><Table.Thead><Table.Tr><Table.Th>Nomor</Table.Th><Table.Th>Kendaraan</Table.Th><Table.Th>Keluhan</Table.Th><Table.Th>Biaya</Table.Th><Table.Th>Status</Table.Th><Table.Th>Aksi</Table.Th></Table.Tr></Table.Thead><Table.Tbody>{orders.map((order) => <Table.Tr key={order.id}><Table.Td><Text fw={700}>{order.document_number ?? 'DRAFT'}</Text><Text size="xs" c="dimmed">{order.work_order_date}</Text></Table.Td><Table.Td>{order.vehicle.plate_number}</Table.Td><Table.Td maw={260}><Text lineClamp={2}>{order.problem_description}</Text></Table.Td><Table.Td>Rp {Number(order.total_cost).toLocaleString('id-ID')}</Table.Td><Table.Td><Badge color={statusColor[order.status]}>{statusLabel[order.status]}</Badge></Table.Td><Table.Td>{canManage && actions[order.status] && <Select size="xs" w={140} placeholder="Proses" value={null} data={actions[order.status]} onChange={(value) => value && onTransition(order, value)} />}</Table.Td></Table.Tr>)}</Table.Tbody></Table></Box>{!busy && !orders.length && <Text p="xl" ta="center" c="dimmed">Belum ada work order.</Text>}</Card>
}

type ModalProps<T> = { opened: boolean; onClose: () => void; onSubmit: (values: T) => Promise<void>; reportError: (cause: unknown) => void }
function VehicleModal({ opened, onClose, onSubmit, reportError, types }: ModalProps<Record<string, unknown>> & { types: VehicleType[] }) {
  const form = useForm({ initialValues: { vehicle_type_id: '', code: '', plate_number: '', brand: '', model: '', model_year: new Date().getFullYear(), ownership_type: 'owned', provider_name: '', current_odometer: 0 } }); const [busy, setBusy] = useState(false)
  return <Modal opened={opened} onClose={onClose} title="Tambah kendaraan"><form onSubmit={form.onSubmit(async (values) => { setBusy(true); try { await onSubmit({ ...values, provider_name: values.ownership_type === 'owned' ? null : values.provider_name }) } catch (cause) { reportError(cause) } finally { setBusy(false) } })}><Stack><Select label="Tipe" required data={types.map((type) => ({ value: type.id, label: `${type.code} · ${type.name}` }))} {...form.getInputProps('vehicle_type_id')} /><TextInput label="Kode armada" required {...form.getInputProps('code')} /><TextInput label="Nomor polisi" required {...form.getInputProps('plate_number')} /><Group grow><TextInput label="Merek" required {...form.getInputProps('brand')} /><TextInput label="Model" required {...form.getInputProps('model')} /></Group><NumberInput label="Tahun" min={1900} max={new Date().getFullYear() + 1} {...form.getInputProps('model_year')} /><Select label="Kepemilikan" data={[{ value: 'owned', label: 'Milik sendiri' }, { value: 'leased', label: 'Sewa' }, { value: 'vendor', label: 'Vendor' }]} {...form.getInputProps('ownership_type')} />{form.values.ownership_type !== 'owned' && <TextInput label="Penyedia" required {...form.getInputProps('provider_name')} />}<NumberInput label="Odometer awal (km)" min={0} thousandSeparator="." decimalSeparator="," {...form.getInputProps('current_odometer')} /><Button type="submit" loading={busy}>Simpan kendaraan</Button></Stack></form></Modal>
}
function VehicleTypeModal({ opened, onClose, onSubmit, reportError }: ModalProps<{ code: string; name: string }>) {
  const form = useForm({ initialValues: { code: '', name: '' } }); const [busy, setBusy] = useState(false)
  return <Modal opened={opened} onClose={onClose} title="Tambah tipe kendaraan"><form onSubmit={form.onSubmit(async (values) => { setBusy(true); try { await onSubmit({ ...values, code: values.code.toUpperCase() }); form.reset() } catch (cause) { reportError(cause) } finally { setBusy(false) } })}><Stack><TextInput label="Kode" required {...form.getInputProps('code')} /><TextInput label="Nama tipe" required {...form.getInputProps('name')} /><Button type="submit" loading={busy}>Simpan tipe</Button></Stack></form></Modal>
}
function WorkOrderModal({ opened, onClose, onSubmit, reportError, vehicles }: ModalProps<Record<string, unknown>> & { vehicles: Vehicle[] }) {
  const form = useForm({ initialValues: { vehicle_id: '', work_order_date: new Date().toISOString().slice(0, 10), priority: 'normal', problem_description: '', parts_cost: 0, job_description: '', labor_cost: 0 } }); const [busy, setBusy] = useState(false)
  const availableVehicles = useMemo(() => vehicles.filter((vehicle) => !['in_use', 'inactive'].includes(vehicle.operational_status)), [vehicles])
  return <Modal opened={opened} onClose={onClose} title="Buat work order" size="lg"><form onSubmit={form.onSubmit(async (values) => { setBusy(true); try { await onSubmit({ vehicle_id: values.vehicle_id, work_order_date: values.work_order_date, priority: values.priority, problem_description: values.problem_description, parts_cost: values.parts_cost, jobs: [{ description: values.job_description, labor_cost: values.labor_cost }] }) } catch (cause) { reportError(cause) } finally { setBusy(false) } })}><Stack><Select searchable label="Kendaraan" required data={availableVehicles.map((vehicle) => ({ value: vehicle.id, label: `${vehicle.plate_number} · ${vehicle.brand} ${vehicle.model}` }))} {...form.getInputProps('vehicle_id')} /><Group grow><TextInput label="Tanggal" type="date" required {...form.getInputProps('work_order_date')} /><Select label="Prioritas" data={['low', 'normal', 'high', 'urgent'].map((value) => ({ value, label: value.toUpperCase() }))} {...form.getInputProps('priority')} /></Group><Textarea label="Keluhan / kebutuhan" minRows={3} required {...form.getInputProps('problem_description')} /><Divider label="Pekerjaan awal" /><TextInput label="Deskripsi pekerjaan" required {...form.getInputProps('job_description')} /><Group grow><NumberInput label="Biaya jasa" min={0} thousandSeparator="." decimalSeparator="," {...form.getInputProps('labor_cost')} /><NumberInput label="Estimasi parts" min={0} thousandSeparator="." decimalSeparator="," {...form.getInputProps('parts_cost')} /></Group><Button type="submit" loading={busy}>Simpan sebagai draft</Button></Stack></form></Modal>
}
export default App
