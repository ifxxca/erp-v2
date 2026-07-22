# P1 Identity and Access Decisions

Status: Accepted baseline

Decision date: 2026-07-22

## Decision summary

| ID | Keputusan | Kontrol utama |
|---|---|---|
| Q-101 | IT Access Administrator mengajukan privileged access; Management Access Owner yang berbeda menyetujui; system mengeksekusi | No self-approval, expiry wajib, audit dan notification |
| Q-102 | User boleh aktif di beberapa company, department, dan location | Assignment eksplisit per scope; tidak ada inheritance otomatis |
| Q-103 | Session dibedakan per surface dan MFA/step-up wajib untuk akses berisiko | Short access lifetime, rotating refresh token, central revocation |
| Q-104 | Roster employment yang dipelihara HR di V2 menjadi source of truth sampai ada HRIS | HR memiliki employment status; Identity service menegakkan disable/revoke |

## Privileged access governance

Privileged assignment meliputi `platform-admin`, `security-admin`, company-wide finance approver/poster, auditor export, dan assignment lain yang diberi klasifikasi `privileged`.

Flow:

1. IT Access Administrator membuat request dengan user, role, company/scope, alasan, dan expiry.
2. Management Access Owner pada company terkait menyetujui atau menolak.
3. Requester, target user, dan approver harus berbeda untuk privileged assignment.
4. System membuat assignment hanya dari request approved dan mencatat seluruh event.
5. Assignment privileged memiliki expiry maksimum 90 hari dan harus direview sebelum diperpanjang.

Revocation dapat diminta HR, direct manager, Management Access Owner, atau IT Access Administrator dan berlaku segera tanpa menunggu approval. Emergency revocation selalu lebih penting daripada maker-checker; alasan, actor, dan notification tetap wajib.

Break-glass access berdurasi maksimum 60 menit, memerlukan MFA, alasan, incident reference, dan post-use review. Ia tidak dapat digunakan untuk menyetujui transaksi yang dibuat oleh user yang sama.

## Multiple organization scope

- Satu identity dapat memiliki membership pada kedua legal entity.
- Setiap company membership mempunyai employment/access status dan effective dates sendiri.
- Satu primary company diperbolehkan per user.
- Dalam setiap company, satu active primary department diperbolehkan; secondary department eksplisit dapat ditambahkan.
- Location assignment tidak diwariskan dari department.
- Memilih company/location pada UI hanya mengubah context, tidak menambah permission.
- API memvalidasi bahwa resource, membership, dan role assignment memiliki company yang sama.

## Session and MFA policy

| Surface | Idle timeout | Absolute lifetime | Renewal |
|---|---:|---:|---|
| ERP Web | 30 menit | 12 jam | Login ulang setelah absolute lifetime |
| Operations PWA | 2 jam | 24 jam | Login ulang setelah absolute lifetime |
| Mobile access token | 15 menit | 15 menit | Rotating refresh token |
| Mobile refresh token | — | 30 hari | Rotation setiap penggunaan; reuse mencabut token family |
| Step-up authentication | — | 15 menit | MFA ulang untuk aksi sensitif |

MFA wajib untuk platform/security admin, Management Access Owner, finance approver/poster, company-wide privileged role, break-glass, dan user yang melakukan aksi sensitif. Step-up wajib pada privileged assignment, payment post/reverse, perubahan MFA, export sensitif, dan break-glass activation.

Seluruh session dapat dicabut per device, per company access, atau seluruh identity. Disable identity mencabut semuanya; penutupan satu company membership mencabut akses company tersebut.

## Employment source of truth

Sampai HRIS formal tersedia:

- HR memelihara employment roster di V2 dan bertanggung jawab atas employee number, company, department utama, start date, end date, serta employment status.
- IT mengelola credential dan technical access, tetapi tidak boleh mengubah status employment untuk mengaktifkan kembali user.
- `inactive`/`terminated` pada seluruh company men-disable login identity kecuali akun service yang memiliki owner dan lifecycle terpisah.
- Perubahan department menutup membership lama pada effective date; histori tidak ditimpa.
- Import user legacy selalu masuk sebagai `invited` dan membutuhkan verifikasi HR sebelum activation.

Ketika HRIS tersedia, HRIS menjadi source untuk employment facts melalui integration; V2 tetap menjadi source of truth session, role assignment, permission, dan audit akses.

## Acceptance tests

- Requester tidak dapat menyetujui request aksesnya sendiri.
- Privileged assignment tanpa expiry ditolak.
- Revocation menghentikan request API dan refresh token berikutnya.
- User lintas-company tidak dapat mengakses record company lain hanya dengan mengganti ID/header.
- Secondary department tidak otomatis memberi role.
- Expired membership/assignment menghasilkan deny.
- Reuse refresh token mencabut token family.
- Employment termination mencabut seluruh akses terkait pada effective time.
