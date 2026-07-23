import { useCallback, useEffect, useState } from 'react'
import {
  ActionIcon,
  Badge,
  Button,
  Divider,
  Drawer,
  Group,
  Indicator,
  Loader,
  Paper,
  ScrollArea,
  Stack,
  Text,
} from '@mantine/core'
import { useDisclosure } from '@mantine/hooks'
import { IconBell, IconChecks } from '@tabler/icons-react'
import { apiRequest, type NotificationPage, type PlatformNotification } from './api'

type Props = {
  token: string
  onError: (cause: unknown) => void
}

const dateTime = new Intl.DateTimeFormat('id-ID', {
  dateStyle: 'medium',
  timeStyle: 'short',
})

export default function NotificationCenter({ token, onError }: Props) {
  const [opened, { open, close }] = useDisclosure(false)
  const [items, setItems] = useState<PlatformNotification[]>([])
  const [unreadCount, setUnreadCount] = useState(0)
  const [loading, setLoading] = useState(false)

  const load = useCallback(async () => {
    setLoading(true)
    try {
      const response = await apiRequest<NotificationPage>('/notifications?per_page=20', {}, token)
      setItems(response.data)
      setUnreadCount(response.meta.unread_count)
    } catch (cause) {
      onError(cause)
    } finally {
      setLoading(false)
    }
  }, [onError, token])

  useEffect(() => {
    void load()
  }, [load])

  async function markRead(notification: PlatformNotification) {
    if (notification.read_at) return
    try {
      const response = await apiRequest<{ data: PlatformNotification }>(
        `/notifications/${notification.id}/read`,
        { method: 'PATCH', headers: { 'Idempotency-Key': crypto.randomUUID() } },
        token,
      )
      setItems((current) => current.map((item) => item.id === notification.id ? response.data : item))
      setUnreadCount((current) => Math.max(0, current - 1))
    } catch (cause) {
      onError(cause)
    }
  }

  async function markAllRead() {
    try {
      await apiRequest<{ updated: number }>(
        '/notifications/read-all',
        { method: 'POST', headers: { 'Idempotency-Key': crypto.randomUUID() } },
        token,
      )
      const readAt = new Date().toISOString()
      setItems((current) => current.map((item) => item.read_at ? item : { ...item, read_at: readAt }))
      setUnreadCount(0)
    } catch (cause) {
      onError(cause)
    }
  }

  return <>
    <Indicator color="red" size={18} label={unreadCount > 99 ? '99+' : unreadCount} disabled={unreadCount === 0}>
      <ActionIcon variant="subtle" color="gray" size="lg" aria-label="Buka notifikasi" onClick={() => { open(); void load() }}>
        <IconBell size={20} />
      </ActionIcon>
    </Indicator>
    <Drawer opened={opened} onClose={close} position="right" size="md" title="Notifications">
      <Stack gap="md" h="calc(100vh - 96px)">
        <Group justify="space-between">
          <Text size="sm" c="dimmed">{unreadCount} belum dibaca</Text>
          <Button variant="subtle" size="xs" leftSection={<IconChecks size={16} />} disabled={unreadCount === 0} onClick={() => void markAllRead()}>
            Tandai semua dibaca
          </Button>
        </Group>
        <Divider />
        {loading && items.length === 0
          ? <Group justify="center" py="xl"><Loader size="sm" /></Group>
          : <ScrollArea flex={1} offsetScrollbars>
            <Stack gap="sm">
              {items.map((notification) => <Paper
                key={notification.id}
                withBorder
                p="md"
                bg={notification.read_at ? undefined : 'var(--mantine-color-blue-light)'}
                style={{ cursor: notification.read_at ? 'default' : 'pointer' }}
                onClick={() => void markRead(notification)}
              >
                <Group justify="space-between" align="flex-start" wrap="nowrap">
                  <Text fw={700} size="sm">{notification.title}</Text>
                  {!notification.read_at && <Badge size="xs" variant="filled">Baru</Badge>}
                </Group>
                <Text size="sm" mt={6} lh={1.5}>{notification.body}</Text>
                <Text size="xs" c="dimmed" mt="sm">{dateTime.format(new Date(notification.created_at))}</Text>
              </Paper>)}
              {!items.length && <Text c="dimmed" ta="center" py="xl">Belum ada notifikasi.</Text>}
            </Stack>
          </ScrollArea>}
      </Stack>
    </Drawer>
  </>
}
