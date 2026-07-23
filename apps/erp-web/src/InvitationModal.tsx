import { useMemo, useState } from 'react'
import {
  Button,
  Grid,
  Modal,
  MultiSelect,
  Select,
  Stack,
  Text,
  TextInput,
} from '@mantine/core'
import { useForm } from '@mantine/form'
import { IconMailPlus } from '@tabler/icons-react'
import { createUserInvitation, type Company, type Organization } from './api'

type Props = {
  opened: boolean
  token: string
  company: Company
  organization: Organization
  onClose: () => void
  onCompleted: (message: string) => Promise<void>
  onError: (error: unknown) => void
}

const today = () => new Date().toISOString().slice(0, 10)

export default function InvitationModal({ opened, token, company, organization, onClose, onCompleted, onError }: Props) {
  const [busy, setBusy] = useState(false)
  const form = useForm({
    mode: 'controlled',
    initialValues: {
      name: '',
      email: '',
      employee_no: '',
      department_ids: [] as string[],
      primary_department_id: '',
      location_ids: [] as string[],
      valid_from: today(),
    },
    validate: {
      name: (value) => value.trim().length < 2 ? 'Nama wajib diisi.' : null,
      email: (value) => /^\S+@\S+\.\S+$/.test(value) ? null : 'Email tidak valid.',
      department_ids: (value) => value.length ? null : 'Pilih minimal satu department.',
      primary_department_id: (value, values) => values.department_ids.includes(value) ? null : 'Pilih primary department.',
      valid_from: (value) => value ? null : 'Tanggal mulai wajib diisi.',
    },
  })

  const departments = useMemo(() => organization.departments.map((item) => ({ value: item.id, label: `${item.code} · ${item.name}` })), [organization])
  const locations = useMemo(() => organization.locations.map((item) => ({ value: item.id, label: `${item.code} · ${item.name}` })), [organization])
  const selectedDepartments = form.getValues().department_ids

  function close() {
    form.reset()
    setBusy(false)
    onClose()
  }

  async function submit(values: typeof form.values) {
    setBusy(true)
    try {
      await createUserInvitation({
        ...values,
        name: values.name.trim(),
        email: values.email.trim(),
        employee_no: values.employee_no.trim() || null,
        company_id: company.id,
      }, token)
      close()
      await onCompleted(`Undangan untuk ${values.name.trim()} berhasil dibuat dan dikirim.`)
    } catch (cause) {
      onError(cause)
    } finally {
      setBusy(false)
    }
  }

  return (
    <Modal opened={opened} onClose={close} title="Invite employee" size="lg" centered>
      <form onSubmit={form.onSubmit((values) => void submit(values))}>
        <Stack gap="md">
          <Text c="dimmed" size="sm">Identity dibuat dalam status invited. Employee mengaktifkan akun melalui tautan sekali pakai yang dikirim ke email.</Text>
          <Grid>
            <Grid.Col span={{ base: 12, sm: 7 }}>
              <TextInput label="Nama lengkap" placeholder="Nama employee" required key={form.key('name')} {...form.getInputProps('name')} />
            </Grid.Col>
            <Grid.Col span={{ base: 12, sm: 5 }}>
              <TextInput label="Nomor pegawai" placeholder="Opsional" key={form.key('employee_no')} {...form.getInputProps('employee_no')} />
            </Grid.Col>
          </Grid>
          <TextInput label="Email" type="email" placeholder="nama@perusahaan.com" leftSection={<IconMailPlus size={16} />} required key={form.key('email')} {...form.getInputProps('email')} />
          <MultiSelect
            label="Departments"
            description="Maksimum 8 department"
            data={departments}
            searchable
            required
            maxValues={8}
            key={form.key('department_ids')}
            {...form.getInputProps('department_ids')}
            onChange={(value) => {
              form.setFieldValue('department_ids', value)
              if (!value.includes(form.getValues().primary_department_id)) form.setFieldValue('primary_department_id', value[0] ?? '')
            }}
          />
          <Select
            label="Primary department"
            data={departments.filter((item) => selectedDepartments.includes(item.value))}
            required
            key={form.key('primary_department_id')}
            {...form.getInputProps('primary_department_id')}
          />
          <MultiSelect label="Locations" data={locations} searchable clearable key={form.key('location_ids')} {...form.getInputProps('location_ids')} />
          <TextInput label="Berlaku mulai" type="date" min={today()} required key={form.key('valid_from')} {...form.getInputProps('valid_from')} />
          <Button type="submit" loading={busy}>Kirim invitation</Button>
        </Stack>
      </form>
    </Modal>
  )
}
