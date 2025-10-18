# Dokumentasi Fitur Konfirmasi Booking via WhatsApp

## Deskripsi
Fitur ini memungkinkan dokter untuk mengkonfirmasi booking pasien melalui link yang dikirim via WhatsApp. Setelah konfirmasi, pasien akan menerima notifikasi WhatsApp otomatis.

## Alur Kerja

### 1. Pembuatan Token Konfirmasi
- Token konfirmasi dibuat dengan masa berlaku 24 jam
- Token berisi informasi booking yang dienkripsi
- URL konfirmasi: `http://klinikbungas.test/booking/confirm/{token}`

### 2. Proses Konfirmasi
- Dokter mengklik link konfirmasi
- Sistem memvalidasi token (struktur dan masa berlaku)
- Status booking diubah menjadi "Diterima"
- Notifikasi WhatsApp dikirim ke pasien

### 3. Notifikasi ke Pasien
- Pesan WhatsApp berisi informasi konfirmasi booking
- Mencakup nama pasien, tanggal, dan instruksi selanjutnya

## Endpoint API

### Konfirmasi Booking
```
GET /booking/confirm/{token}
```

**Response Sukses:**
```json
{
    "success": true,
    "message": "Booking berhasil dikonfirmasi",
    "data": {
        "booking_id": "TEST-2025101816154771",
        "nama": "Test Patient 3",
        "status": "Diterima",
        "confirmed_at": "2025-10-18 16:16:37"
    }
}
```

**Response Error:**
```json
{
    "success": false,
    "message": "Token tidak valid atau sudah kedaluwarsa"
}
```

## Skenario Pengujian

### 1. Konfirmasi Berhasil ✅
- Token valid dan belum kedaluwarsa
- Booking belum dikonfirmasi sebelumnya
- Nomor telepon pasien tersedia
- **Hasil:** Booking dikonfirmasi, notifikasi WhatsApp terkirim

### 2. Token Kedaluwarsa ✅
- Token sudah melewati masa berlaku 24 jam
- **Hasil:** Error "Expired token" di log

### 3. Token Invalid ✅
- Token dengan format yang salah
- **Hasil:** Error "Invalid token structure" di log

### 4. Booking Sudah Dikonfirmasi ✅
- Mencoba konfirmasi booking yang sudah berstatus "Diterima"
- **Hasil:** Tidak ada perubahan status, log tetap mencatat akses

## Log Sistem

### Log Konfirmasi Berhasil
```
[2025-10-18 16:16:37] local.INFO: Booking confirmed successfully {"booking_id":"TEST-2025101816154771","doctor_id":"DR001","patient_name":"Test Patient 3","confirmed_at":"2025-10-18 16:16:37","ip":"127.0.0.1"}
```

### Log WhatsApp Berhasil
```
[2025-10-18 16:16:38] local.INFO: WhatsApp: Pesan berhasil dikirim {"phone":"6281234567891","response":{"detail":"success! message in queue"}}
[2025-10-18 16:16:38] local.INFO: Notifikasi konfirmasi berhasil dikirim ke pasien Test Patient 3 (6281234567891) untuk booking TEST-2025101816154771
```

### Log Error Token
```
[2025-10-18 16:17:30] local.WARNING: Expired token {"booking_id":"TEST-2025101816154771","expires_at":"2025-10-17T15:17:12.590312Z"}
[2025-10-18 16:18:49] local.WARNING: Invalid token structure {"token":"invalid-token-test..."}
```

## Keamanan
- Token memiliki masa berlaku 24 jam
- Token dienkripsi untuk mencegah manipulasi
- Validasi struktur token sebelum pemrosesan
- Logging semua aktivitas untuk audit

## Troubleshooting

### Notifikasi WhatsApp Tidak Terkirim
1. Periksa nomor telepon pasien di database
2. Pastikan kolom `no_telp` terisi dengan benar
3. Cek log WhatsApp untuk error API

### Token Tidak Valid
1. Pastikan token belum kedaluwarsa (< 24 jam)
2. Periksa format token di URL
3. Cek log untuk detail error

### Booking Tidak Terkonfirmasi
1. Periksa status booking di database
2. Pastikan dokter yang mengkonfirmasi sesuai
3. Cek log konfirmasi untuk detail error

## File Terkait
- `app/Http/Controllers/BookingController.php` - Controller utama
- `app/Models/BookingPeriksa.php` - Model booking
- `app/Models/ConfirmationToken.php` - Model token konfirmasi
- `storage/logs/laravel.log` - Log sistem