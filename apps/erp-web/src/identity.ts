import type { IdentityUser } from './api'

export function currentDepartments(user: IdentityUser) {
  const today = new Date().toISOString().slice(0, 10)
  return user.department_memberships.filter((item) => item.valid_from <= today && (!item.valid_until || item.valid_until >= today))
}
