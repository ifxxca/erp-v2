import { useCallback, useEffect, useState } from 'react'
import {
  Alert,
  Badge,
  Button,
  Card,
  Checkbox,
  Code,
  CopyButton,
  Divider,
  Group,
  Modal,
  PasswordInput,
  Progress,
  SimpleGrid,
  Stack,
  Text,
  TextInput,
  ThemeIcon,
  Title,
} from '@mantine/core'
import { notifications } from '@mantine/notifications'
import {
  IconCheck,
  IconCopy,
  IconDeviceDesktop,
  IconDeviceMobile,
  IconKey,
  IconLock,
  IconRefresh,
  IconShieldCheck,
  IconTrash,
} from '@tabler/icons-react'
import {
  challengeMfa,
  confirmTotp,
  disableTotp,
  enrollTotp,
  getMfaStatus,
  listDeviceSessions,
  regenerateMfaRecoveryCodes,
  revokeAllDeviceSessions,
  revokeDeviceSession,
  type DeviceSession,
  type MfaEnrollment,
  type MfaStatus,
} from './api'

type Props = {
  token: string
  onError: (error: unknown) => void
  onSessionEnded: () => void
}

const formatDateTime = (value: string | null) => value
  ? new Intl.DateTimeFormat('id-ID', { dateStyle: 'medium', timeStyle: 'short' }).format(new Date(value))
  : 'Belum pernah'

export default function SecurityCenter({ token, onError, onSessionEnded }: Props) {
  const [mfa, setMfa] = useState<MfaStatus | null>(null)
  const [sessions, setSessions] = useState<DeviceSession[]>([])
  const [busy, setBusy] = useState(false)
  const [enrollOpened, setEnrollOpened] = useState(false)
  const [enrollment, setEnrollment] = useState<MfaEnrollment | null>(null)
  const [enrollPassword, setEnrollPassword] = useState('')
  const [confirmCode, setConfirmCode] = useState('')
  const [recoveryCodes, setRecoveryCodes] = useState<string[]>([])
  const [stepUpCredential, setStepUpCredential] = useState('')
  const [disableOpened, setDisableOpened] = useState(false)
  const [disablePassword, setDisablePassword] = useState('')
  const [revokeSession, setRevokeSession] = useState<DeviceSession | null>(null)
  const [revokeAllOpened, setRevokeAllOpened] = useState(false)
  const [revokeAllPassword, setRevokeAllPassword] = useState('')
  const [keepCurrent, setKeepCurrent] = useState(true)

  const refresh = useCallback(async () => {
    setBusy(true)
    try {
      const [mfaResponse, sessionResponse] = await Promise.all([
        getMfaStatus(token),
        listDeviceSessions(token),
      ])
      setMfa(mfaResponse)
      setSessions(sessionResponse)
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }, [onError, token])

  useEffect(() => {
    void refresh()
  }, [refresh])

  async function startEnrollment() {
    setBusy(true)
    try {
      setEnrollment(await enrollTotp(enrollPassword, token))
      setEnrollPassword('')
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function confirmEnrollment() {
    setBusy(true)
    try {
      setRecoveryCodes(await confirmTotp(confirmCode, token))
      setEnrollOpened(false)
      setEnrollment(null)
      setConfirmCode('')
      await refresh()
      notifications.show({ color: 'green', title: 'MFA aktif', message: 'Authenticator berhasil ditautkan ke identity ini.' })
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function verifyStepUp() {
    setBusy(true)
    try {
      await challengeMfa(token, stepUpCredential)
      setStepUpCredential('')
      await refresh()
      notifications.show({ color: 'green', title: 'Verifikasi berhasil', message: 'Aksi sensitif terbuka selama 15 menit.' })
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function regenerateCodes() {
    setBusy(true)
    try {
      setRecoveryCodes(await regenerateMfaRecoveryCodes(token))
      await refresh()
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function disableMfa() {
    setBusy(true)
    try {
      await disableTotp(disablePassword, token)
      setDisableOpened(false)
      setDisablePassword('')
      notifications.show({ color: 'orange', title: 'MFA dinonaktifkan', message: 'Semua session telah dicabut. Silakan masuk kembali.' })
      onSessionEnded()
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function revokeOne() {
    if (!revokeSession) return
    setBusy(true)
    try {
      const response = await revokeDeviceSession(revokeSession.id, token)
      setRevokeSession(null)
      if (response.current) {
        onSessionEnded()
        return
      }
      await refresh()
      notifications.show({ color: 'green', message: 'Session berhasil dicabut.' })
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  async function revokeAll() {
    setBusy(true)
    try {
      await revokeAllDeviceSessions(revokeAllPassword, keepCurrent, token)
      setRevokeAllOpened(false)
      setRevokeAllPassword('')
      if (!keepCurrent) {
        onSessionEnded()
        return
      }
      await refresh()
      notifications.show({ color: 'green', message: 'Semua session lain berhasil dicabut.' })
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  return (
    <Stack gap="lg">
      <SimpleGrid cols={{ base: 1, md: 2 }}>
        <Card padding="xl">
          <Group justify="space-between" align="flex-start">
            <Group>
              <ThemeIcon size={44} radius="xl" variant="light"><IconShieldCheck size={23} /></ThemeIcon>
              <div><Title order={3}>Multi-factor authentication</Title><Text size="sm" c="dimmed">Authenticator app dan recovery code</Text></div>
            </Group>
            <Badge color={mfa?.enabled ? 'green' : mfa?.required ? 'red' : 'gray'} variant="light">
              {mfa?.enabled ? 'Aktif' : mfa?.required ? 'Wajib' : 'Opsional'}
            </Badge>
          </Group>
          <Divider my="lg" />
          <Stack gap="sm">
            <Group justify="space-between"><Text size="sm">Status konfigurasi</Text><Text size="sm" fw={700}>{mfa?.status ?? 'Memuat…'}</Text></Group>
            <Group justify="space-between"><Text size="sm">Recovery code tersedia</Text><Text size="sm" fw={700}>{mfa?.unused_recovery_codes ?? 0} kode</Text></Group>
            <Group justify="space-between"><Text size="sm">Verifikasi token terakhir</Text><Text size="sm" fw={700}>{formatDateTime(mfa?.current_token_verified_at ?? null)}</Text></Group>
          </Stack>
          <Group mt="xl">
            {!mfa?.enabled && <Button onClick={() => setEnrollOpened(true)} leftSection={<IconKey size={17} />}>Aktifkan MFA</Button>}
            {mfa?.enabled && <Button variant="light" onClick={() => void regenerateCodes()} leftSection={<IconRefresh size={17} />} loading={busy}>Recovery code baru</Button>}
            {mfa?.enabled && !mfa.required && <Button color="red" variant="subtle" onClick={() => setDisableOpened(true)}>Nonaktifkan</Button>}
          </Group>
        </Card>

        <Card padding="xl">
          <Group>
            <ThemeIcon size={44} radius="xl" variant="light"><IconLock size={22} /></ThemeIcon>
            <div><Title order={3}>Step-up verification</Title><Text size="sm" c="dimmed">Diperlukan untuk aksi privileged</Text></div>
          </Group>
          <Divider my="lg" />
          {mfa?.enabled ? (
            <Stack>
              <Text size="sm">Masukkan kode authenticator atau recovery code sebelum melakukan perubahan status, approval, atau regenerasi recovery code.</Text>
              <TextInput label="Kode keamanan" placeholder="6 digit atau recovery code" value={stepUpCredential} onChange={(event) => setStepUpCredential(event.currentTarget.value)} />
              <Button variant="light" onClick={() => void verifyStepUp()} disabled={stepUpCredential.length < 6} loading={busy}>Verifikasi sekarang</Button>
            </Stack>
          ) : (
            <Alert color="orange" title="MFA belum aktif">Aktifkan MFA lebih dulu untuk menggunakan privileged access.</Alert>
          )}
        </Card>
      </SimpleGrid>

      <Card padding="xl">
        <Group justify="space-between" mb="lg">
          <div><Title order={3}>Device sessions</Title><Text size="sm" c="dimmed">Kelola browser dan aplikasi yang masih memiliki akses.</Text></div>
          <Button color="red" variant="light" leftSection={<IconTrash size={16} />} onClick={() => setRevokeAllOpened(true)}>Cabut session</Button>
        </Group>
        {busy && <Progress value={100} animated mb="md" size="xs" />}
        <Stack gap={0}>
          {sessions.map((session, index) => (
            <div key={session.id}>
              {index > 0 && <Divider />}
              <Group justify="space-between" py="md" wrap="nowrap">
                <Group wrap="nowrap">
                  <ThemeIcon variant="default" size={40}>{session.surface === 'mobile' ? <IconDeviceMobile size={20} /> : <IconDeviceDesktop size={20} />}</ThemeIcon>
                  <div>
                    <Group gap="xs"><Text fw={700} size="sm">{session.device_name}</Text>{session.current && <Badge size="xs" color="green">Saat ini</Badge>}</Group>
                    <Text size="xs" c="dimmed">{session.surface ?? 'web'} · terakhir dipakai {formatDateTime(session.last_used_at)}</Text>
                    <Text size="xs" c="dimmed">Berakhir {formatDateTime(session.expires_at)}</Text>
                  </div>
                </Group>
                <Button size="xs" color="red" variant="subtle" onClick={() => setRevokeSession(session)}>Cabut</Button>
              </Group>
            </div>
          ))}
          {!sessions.length && <Text c="dimmed" ta="center" py="xl">Tidak ada session aktif.</Text>}
        </Stack>
      </Card>

      <Modal opened={enrollOpened} onClose={() => { setEnrollOpened(false); setEnrollment(null) }} title="Aktifkan authenticator" centered>
        {!enrollment ? (
          <Stack>
            <Text size="sm" c="dimmed">Konfirmasi password untuk memulai enrollment MFA.</Text>
            <PasswordInput label="Password" value={enrollPassword} onChange={(event) => setEnrollPassword(event.currentTarget.value)} />
            <Button onClick={() => void startEnrollment()} disabled={!enrollPassword} loading={busy}>Lanjutkan</Button>
          </Stack>
        ) : (
          <Stack>
            <Alert color="blue" title="Tambahkan ke authenticator">Buka authenticator app, tambahkan akun secara manual, lalu masukkan kode 6 digit yang muncul.</Alert>
            <Text size="sm" fw={700}>Secret key</Text>
            <Group wrap="nowrap"><Code block style={{ flex: 1 }}>{enrollment.secret}</Code><CopyButton value={enrollment.secret}>{({ copied, copy }) => <Button variant="light" onClick={copy} leftSection={copied ? <IconCheck size={16} /> : <IconCopy size={16} />}>{copied ? 'Tersalin' : 'Salin'}</Button>}</CopyButton></Group>
            <Text size="xs" c="dimmed" lineClamp={2}>{enrollment.otpauth_url}</Text>
            <TextInput label="Kode authenticator" value={confirmCode} onChange={(event) => setConfirmCode(event.currentTarget.value.replace(/\D/g, '').slice(0, 6))} maxLength={6} />
            <Button onClick={() => void confirmEnrollment()} disabled={confirmCode.length !== 6} loading={busy}>Konfirmasi dan aktifkan</Button>
          </Stack>
        )}
      </Modal>

      <Modal opened={recoveryCodes.length > 0} onClose={() => setRecoveryCodes([])} title="Simpan recovery codes" centered>
        <Stack>
          <Alert color="orange" title="Ditampilkan satu kali">Simpan kode ini di tempat aman. Setiap kode hanya dapat digunakan sekali.</Alert>
          <SimpleGrid cols={2}>{recoveryCodes.map((code) => <Code key={code} ta="center" p="sm">{code}</Code>)}</SimpleGrid>
          <CopyButton value={recoveryCodes.join('\n')}>{({ copied, copy }) => <Button variant="light" onClick={copy} leftSection={copied ? <IconCheck size={16} /> : <IconCopy size={16} />}>{copied ? 'Semua tersalin' : 'Salin semua kode'}</Button>}</CopyButton>
        </Stack>
      </Modal>

      <Modal opened={disableOpened} onClose={() => setDisableOpened(false)} title="Nonaktifkan MFA" centered>
        <Stack><Alert color="red">Semua session akan dicabut. MFA yang diwajibkan privileged assignment tidak dapat dinonaktifkan.</Alert><PasswordInput label="Konfirmasi password" value={disablePassword} onChange={(event) => setDisablePassword(event.currentTarget.value)} /><Button color="red" onClick={() => void disableMfa()} disabled={!disablePassword} loading={busy}>Nonaktifkan dan keluar</Button></Stack>
      </Modal>

      {revokeSession && <Modal opened onClose={() => setRevokeSession(null)} title="Cabut session" centered>
        <Stack><Text size="sm">Session <strong>{revokeSession.device_name}</strong> akan langsung kehilangan akses.{revokeSession.current ? ' Anda akan keluar dari ERP.' : ''}</Text><Button color="red" onClick={() => void revokeOne()} loading={busy}>Cabut session</Button></Stack>
      </Modal>}

      <Modal opened={revokeAllOpened} onClose={() => setRevokeAllOpened(false)} title="Cabut banyak session" centered>
        <Stack><PasswordInput label="Konfirmasi password" value={revokeAllPassword} onChange={(event) => setRevokeAllPassword(event.currentTarget.value)} /><Checkbox label="Pertahankan session ERP saat ini" checked={keepCurrent} onChange={(event) => setKeepCurrent(event.currentTarget.checked)} /><Button color="red" onClick={() => void revokeAll()} disabled={!revokeAllPassword} loading={busy}>Cabut session</Button></Stack>
      </Modal>
    </Stack>
  )
}
