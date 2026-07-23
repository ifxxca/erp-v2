# ADR-0014: Transactional Outbox and Central Notifications

Status: Accepted

## Decision

Perubahan aggregate dan event asynchronous dicatat atomik pada `outbox_messages` melalui `OutboxWriter` di dalam transaksi database pemilik. Writer mewajibkan stable event/aggregate identifiers, deduplication key 16–512 karakter, payload kanonik terbatas ukuran, fingerprint payload, dan request correlation. Raw deduplication key tidak disimpan.

Scheduler mengklaim batch message menggunakan lease, lalu queue worker menjalankan handler terdaftar. Setiap attempt, error code, retry availability, completion, dan dead-letter state disimpan di database. Permanent schema/handler failure langsung menjadi dead letter; transient failure memakai bounded backoff sampai batas attempt.

Event `notification.requested` diproyeksikan menjadi central inbox yang terisolasi per user dan delivery per channel. Inbox dan delivery dibuat idempotent dengan unique source/user serta notification/channel. Channel `inbox` selesai di transaksi handler; channel eksternal seperti mail dikerjakan job terpisah sehingga kegagalan provider tidak membatalkan transaksi domain atau inbox.

Privileged-access request, approval, rejection, dan revocation menjadi producer pertama. Semua frontend memakai endpoint inbox yang sama dari API pusat; domain/subdomain frontend bukan boundary penyimpanan notification.

## Consequence

- Tidak ada crash gap antara commit perubahan privileged access dan pencatatan intent notifikasi.
- Replay handler tidak menggandakan inbox atau delivery.
- Attempt history dan dead-letter menyediakan bukti serta titik recovery operasional.
- Worker tidak menahan transaksi database saat memanggil provider mail.
- External delivery memiliki jaminan at-least-once, bukan exactly-once: crash setelah provider menerima pesan tetapi sebelum status lokal commit dapat menghasilkan duplikasi. Exactly-once hanya dapat ditingkatkan jika provider mendukung idempotency key.
- `request_id` asal dipertahankan pada outbox agar penelusuran request → domain transaction → worker tetap mungkin.
- Scheduler dan worker wajib dijalankan sebagai deployment unit terpisah. Menjalankan API tanpa keduanya membuat event aman tersimpan tetapi belum diproses.
- Re-drive dead letter secara administratif, alerting backlog/age, dan dashboard operasional menjadi bagian observability berikutnya; perubahan status manual di database tidak diperbolehkan.
