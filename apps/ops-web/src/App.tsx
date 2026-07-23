import { useCallback, useEffect, useMemo, useState } from 'react'
import {
  ActionIcon, AppShell, Badge, Box, Button, Card, Center, Container, Divider, Group, Loader, Modal,
  FileInput, NumberInput, PasswordInput, Select, SimpleGrid, Stack, Table, Tabs, Text, Textarea, TextInput, Title,
} from '@mantine/core'
import { useDisclosure } from '@mantine/hooks'
import { useForm } from '@mantine/form'
import { notifications } from '@mantine/notifications'
import { IconCar, IconClipboardCheck, IconDownload, IconLogout, IconPlus, IconRefresh, IconTool } from '@tabler/icons-react'
import './App.css'
import {
  ApiError, apiRequest, type ChecklistTemplate, type FileAsset, type LoginResponse, type OperationsContext, type Page,
  type Vehicle, type VehicleTrip, type VehicleType, type WorkOrder,
  downloadEvidence, uploadChecklistEvidence,
} from './api'

type Workspace = 'fleet' | 'trips' | 'maintenance'
type AuthStage = 'login' | 'mfa' | 'loading' | 'ready'
const statusColor: Record<string, string> = {
  available: 'green', in_use: 'blue', maintenance: 'orange', blocked: 'red', inactive: 'gray',
  draft: 'gray', scheduled: 'blue', in_progress: 'orange', completed: 'green', cancelled: 'red',
  active: 'blue',
}
const statusLabel: Record<string, string> = {
  available: 'Tersedia', in_use: 'Digunakan', maintenance: 'Maintenance', blocked: 'Diblokir', inactive: 'Nonaktif',
  draft: 'Draft', scheduled: 'Terjadwal', in_progress: 'Dikerjakan', completed: 'Selesai', cancelled: 'Dibatalkan',
  active: 'Aktif',
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
  const [trips, setTrips] = useState<VehicleTrip[]>([])
  const [checklist, setChecklist] = useState<ChecklistTemplate | null>(null)
  const [selectedTrip, setSelectedTrip] = useState<VehicleTrip | null>(null)
  const [busy, setBusy] = useState(false)
  const [vehicleOpened, vehicleModal] = useDisclosure(false)
  const [typeOpened, typeModal] = useDisclosure(false)
  const [workOrderOpened, workOrderModal] = useDisclosure(false)
  const [checkoutOpened, checkoutModal] = useDisclosure(false)
  const [checkinOpened, checkinModal] = useDisclosure(false)
  const [cancelOpened, cancelModal] = useDisclosure(false)
  const [detailOpened, detailModal] = useDisclosure(false)
  const [tripDetail, setTripDetail] = useState<VehicleTrip | null>(null)

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
      if (activeContext.capabilities.can_view_trips) {
        requests.push(apiRequest<Page<VehicleTrip>>(`${base}/fleet/trips?per_page=100`, {}, token).then((r) => setTrips(r.data)))
      }
      if (activeContext.capabilities.can_operate_trips) {
        requests.push(apiRequest<{ data: ChecklistTemplate }>(`${base}/fleet/checklist-template`, {}, token).then((r) => setChecklist(r.data)))
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
      <SimpleGrid cols={{ base: 2, sm: 5 }}>
        <Metric label="Total kendaraan" value={vehicles.length} />
        <Metric label="Tersedia" value={vehicles.filter((v) => v.operational_status === 'available').length} tone="green" />
        <Metric label="Maintenance" value={vehicles.filter((v) => v.operational_status === 'maintenance').length} tone="orange" />
        <Metric label="Trip aktif" value={trips.filter((trip) => trip.status === 'active').length} tone="blue" />
        <Metric label="WO aktif" value={workOrders.filter((wo) => ['scheduled', 'in_progress'].includes(wo.status)).length} tone="blue" />
      </SimpleGrid>
      <Tabs value={workspace} onChange={(value) => setWorkspace(value as Workspace)}>
        <Tabs.List><Tabs.Tab value="fleet" leftSection={<IconCar size={16} />}>Fleet</Tabs.Tab><Tabs.Tab value="trips" leftSection={<IconClipboardCheck size={16} />}>Operasional harian</Tabs.Tab><Tabs.Tab value="maintenance" leftSection={<IconTool size={16} />}>Work order</Tabs.Tab></Tabs.List>
        <Tabs.Panel value="fleet" pt="lg"><FleetPanel vehicles={vehicles} busy={busy} canManage={activeContext.capabilities.can_manage_vehicles} onAdd={vehicleModal.open} onAddType={typeModal.open} onStatus={async (vehicle, status) => {
          try { await apiRequest(`${base}/fleet/vehicles/${vehicle.id}/status`, { method: 'POST', body: JSON.stringify({ status, reason: `Status changed by Operations to ${status}.` }) }, token); await loadData() } catch (cause) { reportError(cause) }
        }} /></Tabs.Panel>
        <Tabs.Panel value="trips" pt="lg"><TripPanel trips={trips} busy={busy} canOperate={activeContext.capabilities.can_operate_trips} canManage={activeContext.capabilities.can_manage_trips} onCheckout={checkoutModal.open} onDetail={async (trip) => { try { setBusy(true); const response = await apiRequest<{ data: VehicleTrip }>(`${base}/fleet/trips/${trip.id}`, {}, token); setTripDetail(response.data); detailModal.open() } catch (cause) { reportError(cause) } finally { setBusy(false) } }} onCheckin={(trip) => { setSelectedTrip(trip); checkinModal.open() }} onCancel={(trip) => { setSelectedTrip(trip); cancelModal.open() }} /></Tabs.Panel>
        <Tabs.Panel value="maintenance" pt="lg"><MaintenancePanel orders={workOrders} busy={busy} canManage={activeContext.capabilities.can_manage_work_orders} onAdd={workOrderModal.open} onTransition={async (order, status) => {
          try { await apiRequest(`${base}/maintenance/work-orders/${order.id}/transition`, { method: 'POST', body: JSON.stringify({ status, note: ['completed', 'cancelled'].includes(status) ? `Work order ${status} from Operations.` : null }) }, token); await loadData() } catch (cause) { reportError(cause) }
        }} /></Tabs.Panel>
      </Tabs>
    </Stack></Container></AppShell.Main>
    <VehicleModal opened={vehicleOpened} onClose={vehicleModal.close} types={vehicleTypes} onSubmit={async (values) => { await apiRequest(`${base}/fleet/vehicles`, { method: 'POST', body: JSON.stringify(values) }, token); vehicleModal.close(); await loadData() }} reportError={reportError} />
    <VehicleTypeModal opened={typeOpened} onClose={typeModal.close} onSubmit={async (values) => { await apiRequest(`${base}/fleet/vehicle-types`, { method: 'POST', body: JSON.stringify(values) }, token); typeModal.close(); await loadData() }} reportError={reportError} />
    <WorkOrderModal opened={workOrderOpened} onClose={workOrderModal.close} vehicles={vehicles} onSubmit={async (values) => { await apiRequest(`${base}/maintenance/work-orders`, { method: 'POST', body: JSON.stringify(values) }, token); workOrderModal.close(); await loadData() }} reportError={reportError} />
    {checkoutOpened && <CheckoutModal opened onClose={checkoutModal.close} companyId={activeContext.company.id} token={token} vehicles={vehicles} checklist={checklist} onSubmit={async (values) => { await apiRequest(`${base}/fleet/trips/checkout`, { method: 'POST', body: JSON.stringify(values) }, token); checkoutModal.close(); await loadData() }} reportError={reportError} />}
    {checkinOpened && <CheckinModal opened onClose={checkinModal.close} trip={selectedTrip} onSubmit={async (values) => { if (!selectedTrip) return; await apiRequest(`${base}/fleet/trips/${selectedTrip.id}/check-in`, { method: 'POST', body: JSON.stringify(values) }, token); checkinModal.close(); setSelectedTrip(null); await loadData() }} reportError={reportError} />}
    {cancelOpened && <CancelTripModal opened onClose={cancelModal.close} trip={selectedTrip} onSubmit={async (values) => { if (!selectedTrip) return; await apiRequest(`${base}/fleet/trips/${selectedTrip.id}/cancel`, { method: 'POST', body: JSON.stringify(values) }, token); cancelModal.close(); setSelectedTrip(null); await loadData() }} reportError={reportError} />}
    {detailOpened && <TripDetailModal opened onClose={detailModal.close} trip={tripDetail} onDownload={async (file) => { try { await downloadEvidence(activeContext.company.id, file, token) } catch (cause) { reportError(cause) } }} />}
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
function TripPanel({ trips, busy, canOperate, canManage, onCheckout, onDetail, onCheckin, onCancel }: { trips: VehicleTrip[]; busy: boolean; canOperate: boolean; canManage: boolean; onCheckout: () => void; onDetail: (trip: VehicleTrip) => void; onCheckin: (trip: VehicleTrip) => void; onCancel: (trip: VehicleTrip) => void }) {
  return <Card p={0}><Group justify="space-between" p="md"><Box><Text fw={800}>Checkout & check-in kendaraan</Text><Text size="sm" c="dimmed">Checklist keselamatan dan odometer tercatat dalam satu lifecycle trip.</Text></Box>{canOperate && <Button leftSection={<IconPlus size={16} />} onClick={onCheckout}>Checkout kendaraan</Button>}</Group><Divider /><Box className="table-scroll"><Table striped highlightOnHover><Table.Thead><Table.Tr><Table.Th>Kendaraan</Table.Th><Table.Th>Pengemudi</Table.Th><Table.Th>Tujuan</Table.Th><Table.Th>Odometer</Table.Th><Table.Th>Status</Table.Th><Table.Th>Aksi</Table.Th></Table.Tr></Table.Thead><Table.Tbody>{trips.map((trip) => <Table.Tr key={trip.id}><Table.Td><Text fw={700}>{trip.vehicle.plate_number}</Text><Text size="xs" c="dimmed">{new Date(trip.departed_at).toLocaleString('id-ID')}</Text></Table.Td><Table.Td>{trip.driver.name}</Table.Td><Table.Td><Text>{trip.purpose}</Text><Text size="xs" c="dimmed">{trip.destination ?? 'Tanpa tujuan spesifik'}</Text></Table.Td><Table.Td>{trip.start_odometer.toLocaleString('id-ID')} → {trip.end_odometer?.toLocaleString('id-ID') ?? '—'} km</Table.Td><Table.Td><Badge color={statusColor[trip.status]}>{statusLabel[trip.status]}</Badge></Table.Td><Table.Td><Group gap="xs"><Button size="xs" variant="subtle" onClick={() => onDetail(trip)}>Detail</Button>{trip.status === 'active' && canOperate && <Button size="xs" variant="light" onClick={() => onCheckin(trip)}>Check-in</Button>}{trip.status === 'active' && canManage && <Button size="xs" variant="subtle" color="red" onClick={() => onCancel(trip)}>Batalkan</Button>}</Group></Table.Td></Table.Tr>)}</Table.Tbody></Table></Box>{!busy && !trips.length && <Text p="xl" ta="center" c="dimmed">Belum ada perjalanan kendaraan.</Text>}</Card>
}
function MaintenancePanel({ orders, busy, canManage, onAdd, onTransition }: { orders: WorkOrder[]; busy: boolean; canManage: boolean; onAdd: () => void; onTransition: (order: WorkOrder, status: string) => void }) {
  const actions: Record<string, { value: string; label: string }[]> = { draft: [{ value: 'scheduled', label: 'Jadwalkan' }, { value: 'cancelled', label: 'Batalkan' }], scheduled: [{ value: 'in_progress', label: 'Mulai kerja' }, { value: 'cancelled', label: 'Batalkan' }], in_progress: [{ value: 'completed', label: 'Selesaikan' }, { value: 'cancelled', label: 'Batalkan' }] }
  return <Card p={0}><Group justify="space-between" p="md"><Box><Text fw={800}>Maintenance work order</Text><Text size="sm" c="dimmed">Nomor resmi dialokasikan saat draft dijadwalkan.</Text></Box>{canManage && <Button leftSection={<IconPlus size={16} />} onClick={onAdd}>Buat work order</Button>}</Group><Divider /><Box className="table-scroll"><Table striped highlightOnHover><Table.Thead><Table.Tr><Table.Th>Nomor</Table.Th><Table.Th>Kendaraan</Table.Th><Table.Th>Keluhan</Table.Th><Table.Th>Biaya</Table.Th><Table.Th>Status</Table.Th><Table.Th>Aksi</Table.Th></Table.Tr></Table.Thead><Table.Tbody>{orders.map((order) => <Table.Tr key={order.id}><Table.Td><Text fw={700}>{order.document_number ?? 'DRAFT'}</Text><Text size="xs" c="dimmed">{order.work_order_date}</Text></Table.Td><Table.Td>{order.vehicle.plate_number}</Table.Td><Table.Td maw={260}><Text lineClamp={2}>{order.problem_description}</Text></Table.Td><Table.Td>Rp {Number(order.total_cost).toLocaleString('id-ID')}</Table.Td><Table.Td><Badge color={statusColor[order.status]}>{statusLabel[order.status]}</Badge></Table.Td><Table.Td>{canManage && actions[order.status] && <Select size="xs" w={140} placeholder="Proses" value={null} data={actions[order.status]} onChange={(value) => value && onTransition(order, value)} />}</Table.Td></Table.Tr>)}</Table.Tbody></Table></Box>{!busy && !orders.length && <Text p="xl" ta="center" c="dimmed">Belum ada work order.</Text>}</Card>
}

type ModalProps<T> = { opened: boolean; onClose: () => void; onSubmit: (values: T) => Promise<void>; reportError: (cause: unknown) => void }
function TripDetailModal({ opened, onClose, trip, onDownload }: { opened: boolean; onClose: () => void; trip: VehicleTrip | null; onDownload: (file: FileAsset) => Promise<void> }) {
  return <Modal opened={opened} onClose={onClose} title="Detail trip & checklist" size="lg"><Stack><Group justify="space-between"><Box><Text fw={800}>{trip?.vehicle.plate_number}</Text><Text size="sm" c="dimmed">{trip?.driver.name} · {trip?.purpose}</Text></Box>{trip && <Badge color={statusColor[trip.status]}>{statusLabel[trip.status]}</Badge>}</Group><Divider />{trip?.checklist?.answers.map((answer) => <Card key={answer.id} withBorder p="sm"><Group justify="space-between" align="flex-start"><Box><Text fw={650}>{answer.item.label}</Text><Text size="xs" c={answer.item.is_critical ? 'red' : 'dimmed'}>{answer.item.is_critical ? 'Item kritis' : 'Item pemeriksaan'}</Text></Box><Badge color={answer.result === 'pass' ? 'green' : answer.result === 'fail' ? 'red' : 'gray'}>{answer.result === 'pass' ? 'Baik' : answer.result === 'fail' ? 'Bermasalah' : 'Tidak berlaku'}</Badge></Group>{answer.note && <Text size="sm" mt="xs">{answer.note}</Text>}{answer.evidence_files.map((file) => <Button key={file.id} mt="xs" size="xs" variant="light" leftSection={<IconDownload size={14} />} onClick={() => void onDownload(file)}>{file.original_name}</Button>)}</Card>)}{!trip?.checklist?.answers.length && <Text c="dimmed" ta="center">Checklist tidak tersedia.</Text>}</Stack></Modal>
}
function CheckoutModal({ opened, onClose, onSubmit, reportError, companyId, token, vehicles, checklist }: ModalProps<Record<string, unknown>> & { companyId: string; token: string; vehicles: Vehicle[]; checklist: ChecklistTemplate | null }) {
  const form = useForm({ initialValues: { vehicle_id: '', purpose: '', destination: '', start_odometer: 0 } })
  const [answers, setAnswers] = useState<Record<string, string>>(() => Object.fromEntries(
    checklist?.items.map((item) => [item.id, 'pass']) ?? [],
  ))
  const [busy, setBusy] = useState(false)
  const [evidence, setEvidence] = useState<Record<string, File | null>>({})
  const [uploadedEvidence, setUploadedEvidence] = useState<Record<string, string>>({})
  const [uploadMessage, setUploadMessage] = useState('')
  const available = vehicles.filter((vehicle) => vehicle.operational_status === 'available')
  return <Modal opened={opened} onClose={onClose} title="Checkout kendaraan" size="lg"><form onSubmit={form.onSubmit(async (values) => { if (!checklist) return; setBusy(true); try { const evidenceIds = { ...uploadedEvidence }; const pending = checklist.items.filter((item) => evidence[item.id] && !evidenceIds[item.id]); if (pending.length) setUploadMessage(`Memeriksa ${pending.length} evidence…`); await Promise.all(pending.map(async (item) => { const asset = await uploadChecklistEvidence(companyId, evidence[item.id] as File, token); evidenceIds[item.id] = asset.id; setUploadedEvidence((current) => ({ ...current, [item.id]: asset.id })) })); setUploadMessage(''); await onSubmit({ ...values, destination: values.destination || null, answers: checklist.items.map((item) => ({ item_id: item.id, result: answers[item.id], evidence_file_ids: evidenceIds[item.id] ? [evidenceIds[item.id]] : [] })) }); form.reset() } catch (cause) { reportError(cause) } finally { setBusy(false); setUploadMessage('') } })}><Stack><Select searchable label="Kendaraan tersedia" required data={available.map((vehicle) => ({ value: vehicle.id, label: `${vehicle.plate_number} · ${vehicle.brand} ${vehicle.model} · ${vehicle.current_odometer.toLocaleString('id-ID')} km` }))} value={form.values.vehicle_id} onChange={(value) => { form.setFieldValue('vehicle_id', value ?? ''); const selected = vehicles.find((vehicle) => vehicle.id === value); if (selected) form.setFieldValue('start_odometer', selected.current_odometer) }} /><Group grow><TextInput label="Keperluan" required {...form.getInputProps('purpose')} /><TextInput label="Tujuan" {...form.getInputProps('destination')} /></Group><NumberInput label="Odometer keluar (km)" required min={0} thousandSeparator="." decimalSeparator="," {...form.getInputProps('start_odometer')} /><Divider label={checklist?.name ?? 'Checklist belum tersedia'} />{checklist?.items.map((item) => <Box key={item.id}><Group justify="space-between" wrap="nowrap"><Box><Text size="sm" fw={600}>{item.label}</Text><Text size="xs" c={item.is_critical ? 'red' : 'dimmed'}>{item.is_critical ? 'Item kritis · wajib lulus' : 'Pemeriksaan wajib'}</Text></Box><Select w={150} value={answers[item.id] ?? 'pass'} onChange={(value) => value && setAnswers((current) => ({ ...current, [item.id]: value }))} data={[{ value: 'pass', label: 'Baik' }, { value: 'fail', label: 'Bermasalah' }, { value: 'not_applicable', label: 'Tidak berlaku' }]} /></Group><FileInput mt="xs" size="xs" clearable accept="image/jpeg,image/png,image/webp,application/pdf" label="Evidence (opsional)" description={uploadedEvidence[item.id] ? 'Sudah diunggah dan lolos pemeriksaan.' : 'Foto atau PDF, maksimum 20 MB.'} value={evidence[item.id] ?? null} onChange={(file) => { setEvidence((current) => ({ ...current, [item.id]: file })); setUploadedEvidence((current) => { const next = { ...current }; delete next[item.id]; return next }) }} /></Box>)}{uploadMessage && <Text size="sm" c="blue" ta="center">{uploadMessage}</Text>}<Button type="submit" loading={busy} disabled={!checklist || !available.length}>Konfirmasi checkout</Button></Stack></form></Modal>
}
function CheckinModal({ opened, onClose, onSubmit, reportError, trip }: ModalProps<{ end_odometer: number; note: string | null }> & { trip: VehicleTrip | null }) {
  const form = useForm({ initialValues: { end_odometer: trip?.start_odometer ?? 0, note: '' } }); const [busy, setBusy] = useState(false)
  return <Modal opened={opened} onClose={onClose} title="Check-in kendaraan"><form onSubmit={form.onSubmit(async (values) => { setBusy(true); try { await onSubmit({ end_odometer: values.end_odometer, note: values.note || null }) } catch (cause) { reportError(cause) } finally { setBusy(false) } })}><Stack><Text fw={700}>{trip?.vehicle.plate_number}</Text><Text size="sm" c="dimmed">Odometer keluar: {trip?.start_odometer.toLocaleString('id-ID')} km</Text><NumberInput label="Odometer masuk (km)" required min={trip?.start_odometer ?? 0} thousandSeparator="." decimalSeparator="," {...form.getInputProps('end_odometer')} /><Textarea label="Catatan kembali" {...form.getInputProps('note')} /><Button type="submit" loading={busy}>Selesaikan trip</Button></Stack></form></Modal>
}
function CancelTripModal({ opened, onClose, onSubmit, reportError, trip }: ModalProps<{ reason: string }> & { trip: VehicleTrip | null }) {
  const form = useForm({ initialValues: { reason: '' } }); const [busy, setBusy] = useState(false)
  return <Modal opened={opened} onClose={onClose} title="Batalkan trip"><form onSubmit={form.onSubmit(async (values) => { setBusy(true); try { await onSubmit(values) } catch (cause) { reportError(cause) } finally { setBusy(false) } })}><Stack><Text size="sm">Trip {trip?.vehicle.plate_number} akan dibatalkan dan kendaraan dikembalikan ke status tersedia.</Text><Textarea label="Alasan pembatalan" required minRows={3} {...form.getInputProps('reason')} /><Button type="submit" color="red" loading={busy}>Batalkan trip</Button></Stack></form></Modal>
}
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
