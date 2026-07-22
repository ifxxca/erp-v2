import { lazy, Suspense, type FormEvent, type ReactNode, useCallback, useEffect, useState } from 'react'
import {
  Alert,
  AppShell,
  Avatar,
  Badge,
  Box,
  Burger,
  Button,
  Card,
  Center,
  Group,
  Loader,
  LoadingOverlay,
  NavLink,
  Pagination,
  Paper,
  PasswordInput,
  ScrollArea,
  Select,
  SimpleGrid,
  Stack,
  Table,
  Text,
  TextInput,
  ThemeIcon,
  Title,
} from '@mantine/core'
import { useDisclosure } from '@mantine/hooks'
import { notifications } from '@mantine/notifications'
import {
  IconBuildingSkyscraper,
  IconChevronRight,
  IconId,
  IconLock,
  IconLogin2,
  IconLogout,
  IconSearch,
  IconShieldCheck,
  IconUserPlus,
  IconUsers,
} from '@tabler/icons-react'
import './App.css'
import { currentDepartments } from './identity'
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
type Workspace = 'identity' | 'access' | 'security'

const AccessReview = lazy(() => import('./AccessReview'))
const IdentityDrawer = lazy(() => import('./IdentityDrawer'))
const InvitationModal = lazy(() => import('./InvitationModal'))
const SecurityCenter = lazy(() => import('./SecurityCenter'))

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

const workspaceCopy: Record<Workspace, { eyebrow: string; title: string; description: string }> = {
  identity: { eyebrow: 'Identity administration', title: 'Employee directory', description: 'Lifecycle employee, employment, dan organisasi dalam satu sumber kebenaran.' },
  access: { eyebrow: 'Access governance', title: 'Privileged access review', description: 'Maker-checker, MFA, scope, dan expiry untuk akses sensitif.' },
  security: { eyebrow: 'Personal security', title: 'Security & sessions', description: 'Kelola MFA, step-up verification, dan perangkat yang memiliki akses.' },
}

const statusColor = (status: string) => status === 'active' ? 'green' : status === 'invited' ? 'yellow' : 'red'

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
  const [statusFilter, setStatusFilter] = useState<string | null>(null)
  const [appliedSearch, setAppliedSearch] = useState('')
  const [appliedStatus, setAppliedStatus] = useState('')
  const [busy, setBusy] = useState(false)
  const [inviteOpened, setInviteOpened] = useState(false)
  const [navOpened, { toggle: toggleNav, close: closeNav }] = useDisclosure(false)

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

  const handleError = useCallback((cause: unknown) => {
    if (cause instanceof ApiError) {
      if (cause.status === 401) resetSession()
      if (cause.code === 'MFA_CHALLENGE_REQUIRED') setStage('mfa')
      const detail = cause.errors ? Object.values(cause.errors).flat()[0] : null
      notifications.show({ color: 'red', title: 'Permintaan gagal', message: detail ?? cause.message })
      return
    }
    notifications.show({ color: 'red', title: 'API tidak dapat dijangkau', message: 'Periksa service dan konfigurasi URL.' })
  }, [resetSession])

  const showSuccess = useCallback((message: string) => {
    notifications.show({ color: 'green', title: 'Perubahan tersimpan', message })
  }, [])

  useEffect(() => {
    if (!token || stage === 'mfa') return
    let active = true
    Promise.all([
      apiRequest<CurrentUser>('/me', {}, token),
      apiRequest<CompanyResponse>('/identity/companies', {}, token),
    ]).then(([user, companyResponse]) => {
      if (!active) return
      setCurrentUser(user)
      setCompanies(companyResponse.data)
      setCanManageStatus(companyResponse.meta.can_manage_identity_status)
      setCompanyId((current) => current || companyResponse.data[0]?.id || '')
      setStage('ready')
    }).catch(handleError)
    return () => { active = false }
  }, [handleError, stage, token])

  const loadUsers = useCallback(async (requestedPage: number) => {
    if (!token || !companyId) return
    setBusy(true)
    try {
      const params = new URLSearchParams({ page: String(requestedPage) })
      if (appliedSearch) params.set('search', appliedSearch)
      if (appliedStatus) params.set('status', appliedStatus)
      const [userPage, organizationResponse] = await Promise.all([
        apiRequest<UserPage>(`/identity/companies/${companyId}/users?${params}`, {}, token),
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
  }, [appliedSearch, appliedStatus, companyId, handleError, token])

  useEffect(() => {
    if (stage === 'ready' && companyId) void loadUsers(page)
  }, [companyId, loadUsers, page, stage])

  async function selectUser(userId: string) {
    setBusy(true)
    try {
      const response = await apiRequest<{ data: IdentityUser }>(`/identity/companies/${companyId}/users/${userId}`, {}, token)
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

  function navigate(next: Workspace) {
    setSelectedUser(null)
    setWorkspace(next)
    closeNav()
  }

  if (stage === 'login') {
    return <LoginScreen onAuthenticated={(accessToken, needsMfa) => {
      sessionStorage.setItem('erp_access_token', accessToken)
      setToken(accessToken)
      setStage(needsMfa ? 'mfa' : 'loading')
    }} />
  }

  if (stage === 'mfa') return <MfaScreen token={token} onVerified={() => setStage('loading')} onCancel={resetSession} />

  if (stage === 'loading') {
    return <Center mih="100vh"><Stack align="center"><Loader color="forest" /><Text c="dimmed" size="sm">Menyiapkan workspace…</Text></Stack></Center>
  }

  const copy = workspaceCopy[workspace]

  return (
    <AppShell
      header={{ height: 64 }}
      navbar={{ width: 260, breakpoint: 'sm', collapsed: { mobile: !navOpened } }}
      padding={{ base: 'md', md: 'xl' }}
    >
      <AppShell.Header className="app-header">
        <Group h="100%" px="lg" justify="space-between">
          <Group><Burger opened={navOpened} onClick={toggleNav} hiddenFrom="sm" size="sm" /><Brand compact /></Group>
          <Group gap="xs"><Avatar size="sm" color="forest">{currentUser?.name.slice(0, 2).toUpperCase()}</Avatar><Text size="sm" fw={700} visibleFrom="xs">{currentUser?.name}</Text></Group>
        </Group>
      </AppShell.Header>

      <AppShell.Navbar p="md" className="app-navbar">
        <AppShell.Section><Brand /></AppShell.Section>
        <AppShell.Section grow component={ScrollArea} mt="xl">
          <Stack gap={4}>
            <NavLink label="Identity" description="Employee lifecycle" leftSection={<IconUsers size={19} />} active={workspace === 'identity'} onClick={() => navigate('identity')} />
            <NavLink label="Access review" description="Privileged access" leftSection={<IconShieldCheck size={19} />} active={workspace === 'access'} disabled={!canAccessReview} onClick={() => navigate('access')} />
            <NavLink label="Security" description="MFA & sessions" leftSection={<IconLock size={19} />} active={workspace === 'security'} onClick={() => navigate('security')} />
          </Stack>
        </AppShell.Section>
        <AppShell.Section>
          <Paper p="sm" radius="md" className="user-card">
            <Group wrap="nowrap">
              <Avatar color="forest">{currentUser?.name.slice(0, 2).toUpperCase()}</Avatar>
              <Box style={{ minWidth: 0, flex: 1 }}><Text size="sm" fw={700} truncate>{currentUser?.name}</Text><Text size="xs" c="dimmed" truncate>{currentUser?.email}</Text></Box>
              <Button variant="subtle" color="gray" px={8} onClick={() => void logout()} aria-label="Keluar"><IconLogout size={18} /></Button>
            </Group>
          </Paper>
        </AppShell.Section>
      </AppShell.Navbar>

      <AppShell.Main>
        <Stack gap="xl" maw={1480} mx="auto">
          <Group justify="space-between" align="flex-end">
            <div><Text className="eyebrow">{copy.eyebrow}</Text><Title order={1}>{copy.title}</Title><Text c="dimmed" mt={5}>{copy.description}</Text></div>
            {workspace !== 'security' && <Select
              label="Legal entity"
              w={{ base: '100%', sm: 330 }}
              leftSection={<IconBuildingSkyscraper size={17} />}
              data={companies.map((company) => ({ value: company.id, label: `${company.code} · ${company.legal_name}` }))}
              value={companyId}
              onChange={(value) => { setPage(1); setSelectedUser(null); setCompanyId(value ?? '') }}
              allowDeselect={false}
            />}
          </Group>

          {workspace === 'identity' && activeCompany && <>
            <SimpleGrid cols={{ base: 1, sm: 3 }}>
              <StatCard label="Visible identities" value={String(totalUsers)} detail={`Dalam scope ${activeCompany.code}`} icon={<IconId size={20} />} />
              <StatCard label="Employment owner" value={activeCompany.capabilities.can_manage_employment ? 'HR access' : 'Read only'} detail="Effective-dated changes" icon={<IconBuildingSkyscraper size={20} />} />
              <StatCard label="Global control" value={canManageStatus ? 'Enabled' : 'Restricted'} detail="Suspend / disable identity" icon={<IconShieldCheck size={20} />} />
            </SimpleGrid>

            <Card padding={0} pos="relative" className="data-card">
              <LoadingOverlay visible={busy} overlayProps={{ blur: 1 }} loaderProps={{ color: 'forest' }} />
              <form onSubmit={(event) => {
                event.preventDefault()
                const normalizedSearch = search.trim()
                if (page === 1 && normalizedSearch === appliedSearch && (statusFilter ?? '') === appliedStatus) void loadUsers(1)
                setPage(1)
                setAppliedSearch(normalizedSearch)
                setAppliedStatus(statusFilter ?? '')
              }}>
                <Group p="md" align="flex-end">
                  <TextInput style={{ flex: 1 }} miw={240} label="Cari identity" placeholder="Nama, email, atau nomor pegawai" leftSection={<IconSearch size={17} />} value={search} onChange={(event) => setSearch(event.currentTarget.value)} />
                  <Select label="Status" w={180} clearable placeholder="Semua status" value={statusFilter} onChange={setStatusFilter} data={['active', 'invited', 'suspended', 'disabled']} />
                  <Button type="submit" variant="light">Terapkan</Button>
                  {activeCompany.capabilities.can_invite_users && <Button leftSection={<IconUserPlus size={17} />} onClick={() => setInviteOpened(true)}>Invite employee</Button>}
                </Group>
              </form>
              <Table.ScrollContainer minWidth={820}>
                <Table verticalSpacing="md" horizontalSpacing="lg" highlightOnHover>
                  <Table.Thead><Table.Tr><Table.Th>Employee</Table.Th><Table.Th>Employment</Table.Th><Table.Th>Departments</Table.Th><Table.Th>Identity</Table.Th><Table.Th /></Table.Tr></Table.Thead>
                  <Table.Tbody>
                    {users.map((user) => <Table.Tr key={user.id}>
                      <Table.Td><Group gap="sm" wrap="nowrap"><Avatar color="forest" variant="light">{user.name.slice(0, 2).toUpperCase()}</Avatar><div><Text size="sm" fw={700}>{user.name}</Text><Text size="xs" c="dimmed">{user.email}</Text></div></Group></Table.Td>
                      <Table.Td><Text size="sm">{user.company_memberships[0]?.employee_no ?? '—'}</Text><Text size="xs" c="dimmed">{user.company_memberships[0]?.employment_status ?? '—'}</Text></Table.Td>
                      <Table.Td><Text size="sm" lineClamp={2}>{currentDepartments(user).map((item) => item.department.name).join(', ') || 'Belum ditetapkan'}</Text></Table.Td>
                      <Table.Td><Badge color={statusColor(user.status)} variant="light">{user.status}</Badge></Table.Td>
                      <Table.Td><Button variant="subtle" size="xs" rightSection={<IconChevronRight size={15} />} onClick={() => void selectUser(user.id)}>Review</Button></Table.Td>
                    </Table.Tr>)}
                    {!busy && users.length === 0 && <Table.Tr><Table.Td colSpan={5}><Text c="dimmed" ta="center" py="xl">Tidak ada identity pada filter ini.</Text></Table.Td></Table.Tr>}
                  </Table.Tbody>
                </Table>
              </Table.ScrollContainer>
              {lastPage > 1 && <Group justify="space-between" p="md" className="card-footer"><Text size="sm" c="dimmed">Halaman {page} dari {lastPage}</Text><Pagination value={page} onChange={setPage} total={lastPage} size="sm" /></Group>}
            </Card>
          </>}

          <Suspense fallback={<Center py={80}><Loader color="forest" /></Center>}>
            {workspace === 'access' && activeCompany && organization && currentUser && <AccessReview token={token} currentUser={currentUser} company={activeCompany} organization={organization} onError={handleError} onMessage={showSuccess} />}
            {workspace === 'security' && <SecurityCenter token={token} onError={handleError} onSessionEnded={resetSession} />}
          </Suspense>
        </Stack>
      </AppShell.Main>

      <Suspense fallback={null}>
        {selectedUser && organization && activeCompany && <IdentityDrawer user={selectedUser} organization={organization} company={activeCompany} token={token} canManageStatus={canManageStatus} onClose={() => setSelectedUser(null)} onChanged={async (message) => { showSuccess(message); await loadUsers(page) }} onError={handleError} />}
        {activeCompany && organization && inviteOpened && <InvitationModal opened token={token} company={activeCompany} organization={organization} onClose={() => setInviteOpened(false)} onCompleted={async (message) => { showSuccess(message); await loadUsers(1) }} onError={handleError} />}
      </Suspense>
    </AppShell>
  )
}

function Brand({ compact = false }: { compact?: boolean }) {
  return <Group gap="sm" className={compact ? 'header-brand' : ''}><ThemeIcon size={38} radius="md" color="lime" c="dark" fw={900}>R</ThemeIcon><div><Text fw={800} c={compact ? undefined : 'white'}>Rajawali</Text><Text size="xs" c={compact ? 'dimmed' : 'forest.1'}>Platform V2</Text></div></Group>
}

function StatCard({ label, value, detail, icon }: { label: string; value: string; detail: string; icon: ReactNode }) {
  return <Card padding="lg"><Group justify="space-between"><Text size="sm" c="dimmed">{label}</Text><ThemeIcon variant="light" size="lg">{icon}</ThemeIcon></Group><Title order={3} mt="sm">{value}</Title><Text size="xs" c="dimmed" mt={4}>{detail}</Text></Card>
}

function LoginScreen({ onAuthenticated }: { onAuthenticated: (token: string, needsMfa: boolean) => void }) {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [busy, setBusy] = useState(false)

  async function submit(event: FormEvent) {
    event.preventDefault()
    setBusy(true)
    setError('')
    try {
      const response = await apiRequest<LoginResponse>('/auth/login', {
        method: 'POST', body: JSON.stringify({ email, password, surface: 'erp_web', device_name: navigator.userAgent.slice(0, 120) }),
      })
      onAuthenticated(response.access_token, response.mfa_required)
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Login gagal.')
    } finally {
      setBusy(false)
    }
  }

  return <main className="auth-page">
    <section className="auth-copy"><Text className="eyebrow" c="forest.2">Rajawali Platform V2</Text><Title order={1}>One identity.<br />Clear accountability.</Title><Text maw={540} c="forest.1" mt="xl" lh={1.7}>Workspace management untuk dua legal entity dengan scope, histori, dan approval yang eksplisit.</Text><Group mt={50}><ThemeIcon color="lime" c="dark" radius="xl"><IconShieldCheck size={18} /></ThemeIcon><div><Text c="white" fw={700}>Controlled access</Text><Text c="forest.1" size="sm">Session ERP memiliki idle timeout 30 menit.</Text></div></Group></section>
    <section className="auth-panel"><Card component="form" onSubmit={(event) => void submit(event)} padding="xl" shadow="xl" w="min(420px, 100%)"><ThemeIcon size={44} color="lime" c="dark" fw={900}>R</ThemeIcon><Title order={2} mt="xl">Masuk ke Management ERP</Title><Text c="dimmed" size="sm" mt={5}>Gunakan akun employee yang sudah aktif.</Text>{error && <Alert color="red" mt="lg">{error}</Alert>}<Stack mt="xl"><TextInput label="Email" type="email" autoComplete="username" value={email} onChange={(event) => setEmail(event.currentTarget.value)} required /><PasswordInput label="Password" autoComplete="current-password" value={password} onChange={(event) => setPassword(event.currentTarget.value)} required /><Button type="submit" size="md" loading={busy} leftSection={<IconLogin2 size={18} />}>Masuk</Button></Stack></Card></section>
  </main>
}

function MfaScreen({ token, onVerified, onCancel }: { token: string; onVerified: () => void; onCancel: () => void }) {
  const [credential, setCredential] = useState('')
  const [error, setError] = useState('')
  const [busy, setBusy] = useState(false)
  async function submit(event: FormEvent) {
    event.preventDefault()
    setBusy(true)
    setError('')
    try {
      await apiRequest('/auth/mfa/challenge', { method: 'POST', body: JSON.stringify({ credential }) }, token)
      onVerified()
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'Kode tidak valid.')
    } finally {
      setBusy(false)
    }
  }
  return <Center mih="100vh" className="mfa-page"><Card component="form" onSubmit={(event) => void submit(event)} padding="xl" shadow="xl" w="min(430px, calc(100% - 32px))"><ThemeIcon size={46} radius="xl"><IconLock size={23} /></ThemeIcon><Title order={2} mt="lg">Verifikasi dua langkah</Title><Text c="dimmed" size="sm" mt={5}>Masukkan kode authenticator atau recovery code.</Text>{error && <Alert color="red" mt="lg">{error}</Alert>}<Stack mt="xl"><TextInput autoFocus label="Kode keamanan" value={credential} onChange={(event) => setCredential(event.currentTarget.value)} minLength={6} required /><Button type="submit" loading={busy}>Verifikasi</Button><Button variant="subtle" color="gray" onClick={onCancel}>Batalkan login</Button></Stack></Card></Center>
}

export default App
