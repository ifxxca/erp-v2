# ADR-0012: Private File Lifecycle

Status: Accepted

## Decision

Semua evidence dan dokumen operasional disimpan sebagai private object pada storage S3-compatible. Database hanya menyimpan metadata, ownership, lifecycle, checksum SHA-256, scan result, attachment reference, dan retention marker.

Upload memakai tiga tahap: initiate metadata, multipart binary upload, lalu finalize. Server memeriksa size, checksum, MIME hasil deteksi, serta binary signature sebelum object masuk quarantine. Finalize mengirim scan ke queue; hanya status `ready` dengan hasil `clean`, atau `skipped` pada environment non-production yang secara eksplisit mengizinkannya, yang dapat di-download melalui endpoint terautentikasi.

## Consequence

- Object key dan storage credential tidak pernah dikirim ke client.
- Upload reservation dan finalize mendukung safe retry; binary upload memakai reservation/checksum dan tidak memakai `Idempotency-Key`.
- File terinfeksi ditolak dan binary-nya dihapus, sementara metadata/audit history dipertahankan.
- Delete generik dilarang setelah file dimiliki record domain; penghapusan harus melalui workflow domain tersebut.
- Reservation terbengkalai berakhir setelah 24 jam dan dibersihkan scheduler.
- Tanggal retention baru ditetapkan ketika domain meng-attach file. Nilai legalnya tidak diasumsikan sampai Q-206 diputuskan.
- Production/local-compose memakai ClamAV. Scanner yang dilewati hanya tersedia melalui konfigurasi eksplisit untuk automated test atau development terbatas dan dicatat sebagai `skipped`, bukan `clean`.
