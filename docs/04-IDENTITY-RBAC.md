# Identity, Organization, dan RBAC

## Tujuan

Mengganti model legacy yang mencampur user, satu role, satu department, serta pemeriksaan ID hardcoded dengan model yang eksplisit, scoped, dapat diaudit, dan aman untuk ERP web, OPS web, serta mobile.

## Model konseptual

Hak akses efektif dibentuk oleh lima hal:

1. user aktif;
2. membership organisasi yang masih berlaku;
3. role assignment yang masih berlaku;
4. company scope yang sesuai;
5. scope resource yang sedang diakses.

```text
effective access = active user
                 + active role assignment
                 + permission in role
                 + matching company/department/location scope
                 + domain policy
```

RBAC menjawab "boleh melakukan aksi apa". Domain policy tetap menjawab "boleh melakukan aksi ini pada record yang mana dan pada status apa".

## Entitas dan aturan

### User

- Identitas login unik, status `invited`, `active`, `suspended`, atau `disabled`.
- Tidak menyimpan role dan department langsung pada record user.
- Employee number boleh kosong untuk akun service/integration, tetapi harus unik jika ada.
- Email terverifikasi sebelum akun dapat mengakses data bisnis.
- Password hasil import tidak dipindahkan; user melakukan set password baru.

### Department

- Department selalu dimiliki satu company.
- Memiliki `code`, `name`, `parent_id`, dan status.
- Hierarki dipakai untuk reporting dan resolution scope, bukan otomatis memberi akses ke seluruh anak department.
- Pemindahan user antar department dilakukan dengan menutup membership lama dan membuat membership baru agar histori terjaga.

### Membership

- Satu user boleh memiliki beberapa membership aktif.
- Hanya satu membership aktif yang `is_primary = true`.
- Membership bukan permission. Ia hanya menyatakan posisi organisasi.

### Role dan permission

- Role adalah kumpulan permission yang dapat dikelola secara terkendali.
- Permission adalah capability stabil dengan pola `module.resource.action`.
- Role mendeklarasikan `assignment_scope` (`global`, `company`, `department`, atau `location`); request tidak boleh memilih scope yang lebih luas atau berbeda dari policy tersebut.
- Role system dan permission catalog adalah baseline release-managed: UI menampilkannya sebagai read-only dan perubahan dilakukan melalui migration/seeder yang direview.
- Runtime administration hanya dapat membuat custom role dengan scope `company`, `department`, atau `location`; custom role tidak dapat menerima permission global-only.
- Perubahan profil dan permission custom role membutuhkan permission global `identity.role.manage`, recent MFA, alasan perubahan, dan audit append-only.
- Custom role dengan assignment atau access-request history tidak dapat dihapus. Classification scope/privileged tidak dapat berubah selama ada assignment aktif atau request pending.
- UI menu tidak menjadi pengaman. API selalu melakukan authorization sendiri.

### Role assignment

Assignment menghubungkan user dan role, dengan scope opsional:

| Company scope | Department scope | Location scope | Arti |
|---|---|---|---|
| wajib | kosong | kosong | berlaku di seluruh company; sangat terbatas penggunaannya |
| wajib | terisi | kosong | berlaku pada department di company tersebut |
| wajib | kosong | terisi | berlaku pada location di company tersebut |
| wajib | terisi | terisi | harus cocok dengan company, department, dan location |

Setiap assignment memiliki masa berlaku dan aktor pemberi akses. Assignment seluruh-company untuk role berisiko tinggi wajib membutuhkan approval atau proses break-glass. Hanya role teknis platform tertentu yang boleh memiliki scope lintas-company.

## Role awal yang direkomendasikan

Role berikut adalah seed awal, bukan role permanen yang tidak bisa disesuaikan:

| Role | Scope normal | Tanggung jawab utama |
|---|---|---|
| `platform-admin` | global | Konfigurasi teknis, bukan approval bisnis |
| `security-admin` | global | User, role, permission, dan access review |
| `hr-administrator` | company | Employment, department, dan location membership |
| `department-manager` | department | Review dan approval dalam department |
| `procurement-officer` | department | PR, sourcing, dan PO |
| `finance-officer` | company/location | Schedule, payment, reconciliation |
| `warehouse-operator` | location | Receipt, movement, dan stock count |
| `fleet-manager` | location | Vehicle, assignment, dan compliance |
| `maintenance-officer` | location | Work order dan service schedule |
| `ops-dispatcher` | location | Pickup planning dan dispatch |
| `ops-driver` | location | Trip, checklist, dan pickup mobile flow |
| `auditor` | global/read-only | Audit log dan laporan terpilih |

Tidak ada role `super_admin` yang secara implisit melewati semua policy. Aksi teknis darurat memakai mekanisme break-glass dengan masa berlaku pendek dan audit penuh.

## Contoh permission catalog

| Module | Permission contoh |
|---|---|
| Identity | `identity.user.view`, `identity.user.manage`, `identity.user.status.manage` (global-only), `identity.role.view` (global-only), `identity.role.manage` (global-only), `identity.employment.manage`, `identity.access.request`, `.approve`, `.revoke` |
| Procurement | `procurement.purchase-request.create`, `.view`, `.submit`, `.approve`; `procurement.purchase-order.issue` |
| Finance | `finance.payment-schedule.view`, `.manage`; `finance.payment.post`, `.reverse` |
| Inventory | `inventory.receipt.create`, `.confirm`; `inventory.movement.create`; `inventory.stock-count.approve` |
| Fleet | `fleet.vehicle.view`, `.manage`; `fleet.trip.dispatch`; `fleet.checklist.submit` |
| Maintenance | `maintenance.work-order.create`, `.approve`, `.complete` |
| Operations | `operations.pickup.dispatch`, `.execute`, `.verify`; `operations.shift.close` |
| Support | `support.ticket.create`, `.assign`, `.resolve` |
| Audit | `audit.log.view`, `audit.export.create` |

Permission code tidak boleh diganti setelah digunakan. Perubahan semantic dibuat sebagai permission baru dan permission lama dideprecate.

## Matriks segregation of duties

| Proses | Pembuat | Approver | Eksekutor/poster | Batasan |
|---|---|---|---|---|
| Purchase request | Requester | Department manager | Procurement | Pembuat tidak menyetujui request sendiri |
| Purchase order | Procurement | Sesuai threshold | Procurement issuer | Approval mengikuti nominal |
| Payment | Finance preparer | Finance approver | Finance poster | Satu user tidak menjalankan ketiga tahap |
| Stock adjustment | Warehouse | Warehouse manager | System posting | Adjustment material wajib alasan dan bukti |
| Service work order | Maintenance | Fleet manager | Maintenance/vendor | Approver berbeda untuk nilai di atas threshold |
| User access | Security admin | Access owner | System | Assignment privileged wajib expiry |

Policy harus memblokir self-approval meskipun user memiliki dua role yang relevan.

## Approval resolution

Pada saat dokumen disubmit:

1. Sistem memilih workflow aktif berdasarkan jenis dokumen, department, lokasi, dan nominal.
2. Sistem menyimpan versi workflow pada approval instance.
3. Setiap step mencari user aktif yang memiliki permission approver pada scope yang cocok.
4. Kandidat yang merupakan pembuat dokumen dikeluarkan jika segregation of duties melarangnya.
5. Jika tidak ada approver, dokumen masuk exception queue—bukan otomatis dianggap disetujui.
6. Action approval menyimpan aktor, timestamp, komentar, request ID, dan snapshot step.

Delegasi approval harus memiliki rentang tanggal dan tercatat sebagai assignment/delegation eksplisit.

## Lifecycle akses

### Joiner

- HR/security membuat atau mengundang user.
- User diverifikasi, membership ditetapkan, lalu role assignment dibuat oleh pihak berwenang.
- Assignment privileged tidak boleh berasal dari endpoint update profile biasa.

### Mover

- Membership lama ditutup pada effective date.
- Assignment scoped lama dievaluasi dan dicabut bila tidak lagi relevan.
- Assignment baru tidak diwariskan otomatis hanya karena hierarchy department.

### Leaver

- Status user menjadi `disabled`.
- Semua refresh token, session, API key pribadi, dan assignment aktif dicabut.
- Record bisnis serta audit trail tetap menunjuk user yang sama.

### Access review

- Role privileged ditinjau minimal per kuartal.
- Assignment yang memiliki expiry berakhir otomatis.
- Laporan orphaned account, inactive account, dan conflicting roles tersedia untuk security admin.

### Privileged access request

- IT Access Administrator mengajukan request, tetapi tidak dapat menyetujuinya sendiri.
- Management Access Owner yang berbeda menyetujui company-scoped privileged access.
- System membuat assignment dari request approved; profile/user CRUD tidak boleh menulis privileged assignment.
- Expiry maksimum privileged assignment adalah 90 hari.
- Revocation oleh HR, manager, access owner, atau IT berlaku segera dan tetap diaudit.
- Break-glass maksimum 60 menit, memakai MFA, incident reference, serta post-use review.

## Authentication dan session

- Rilis awal menggunakan local identity karena perusahaan belum memiliki identity provider terpusat.
- Credential dibuat baru; password dan session legacy tidak diimpor.
- Web memakai secure, HTTP-only, same-site cookie melalui identity/API layer.
- Mobile memakai short-lived access token dan rotating refresh token yang terikat perangkat.
- MFA wajib untuk privileged role dan aksi finansial berisiko tinggi.
- Rate limit diterapkan pada login, reset password, OTP, dan token refresh.
- Reset password serta invite token bersifat sekali pakai dan memiliki expiry pendek.
- Semua session dapat dicabut per perangkat atau seluruh akun.
- Authentication boundary tetap mendukung migrasi ke OIDC tanpa mengubah membership, role, permission, atau domain policy.
- ERP Web memiliki idle timeout 30 menit dan absolute lifetime 12 jam.
- Operations PWA memiliki idle timeout 2 jam dan absolute lifetime 24 jam.
- Mobile memakai access token 15 menit serta rotating refresh token maksimum 30 hari; reuse mencabut token family.
- Step-up MFA berlaku 15 menit untuk privileged assignment, payment post/reverse, perubahan MFA, export sensitif, dan break-glass.

## Employment ownership

- HR memelihara roster employment V2 sebagai source of truth sampai ada HRIS.
- `identity.employment.manage` memberi hak company-scoped untuk mengubah employment dan organization membership; perubahan memakai effective date dan tidak menimpa histori.
- IT mengelola identity/credential, tetapi tidak dapat mengaktifkan employment yang ditutup HR.
- `identity.user.status.manage` hanya sah pada assignment global; company, department, atau location scope tidak pernah cukup untuk suspend, disable, atau re-enable identity global.
- Re-enable identity ditolak jika tidak ada active employment pada legal entity mana pun.
- Company membership, department membership, dan role assignment memiliki effective dates terpisah.
- Termination menutup membership dan mencabut session/token pada effective time tanpa menghapus histori actor.

## Audit minimum

Wajib dicatat:

- login berhasil/gagal dan perubahan credential;
- create, suspend, disable, serta re-enable user;
- perubahan membership;
- create/revoke role assignment;
- perubahan role-permission;
- approval/rejection dan penggunaan break-glass;
- export data sensitif.

Audit log bersifat append-only dan hanya boleh dilihat melalui permission khusus. Nilai rahasia seperti password, token, dan secret tidak pernah masuk log.

## Acceptance criteria

- Tidak ada authorization berdasarkan numeric user/role ID.
- User dengan beberapa department dapat berpindah konteks tanpa memperoleh hak di luar assignment.
- Self-approval dan kombinasi role konflik terblokir di API.
- Disable user mencabut akses yang sudah aktif.
- Semua perubahan akses dapat ditelusuri ke aktor dan alasan.
- Test matrix mencakup allow, deny, expired assignment, wrong scope, disabled user, dan conflicting duties.
