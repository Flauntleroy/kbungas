# Dokumentasi Sistem Transfer Booking ke Reg Periksa

## Deskripsi
Sistem transfer booking memungkinkan admin untuk mentransfer data booking pasien ke dalam tabel `reg_periksa` (registrasi pemeriksaan) untuk memulai proses pemeriksaan medis.

## Fitur Utama
- Transfer otomatis data booking ke reg_periksa
- Validasi data sebelum transfer
- Pencegahan duplikasi transfer
- Logging aktivitas transfer
- Interface admin yang user-friendly

## Cara Penggunaan

### 1. Melalui Interface Admin Booking

#### Langkah-langkah:
1. Login ke admin panel
2. Navigasi ke menu **"Manajemen Booking"**
3. Pada tabel booking, cari booking yang ingin ditransfer
4. Klik tombol **"Transfer ke Reg Periksa"** (ikon panah biru) pada kolom aksi
5. Konfirmasi transfer pada dialog yang muncul
6. Sistem akan menampilkan pesan sukses dengan nomor rawat yang dihasilkan

#### Syarat Transfer:
- Status booking harus **"Diterima"**
- Pasien sudah terdaftar di SIMRS (memiliki no_rkm_medis)
- Booking belum pernah ditransfer sebelumnya

### 2. Melalui Command Line

#### Transfer Single Booking:
```bash
php artisan transfer:booking-to-reg-periksa BK202510180017
```

#### Transfer Multiple Bookings:
```bash
php artisan transfer:booking-to-reg-periksa BK202510180017 BK202510180018 BK202510180019
```

### 3. Melalui API Endpoint

#### Single Transfer:
```bash
POST /api/reg-periksa/transfer
Content-Type: application/json

{
    "booking_id": "BK202510180017"
}
```

#### Multiple Transfer:
```bash
POST /api/reg-periksa/transfer-multiple
Content-Type: application/json

{
    "booking_ids": ["BK202510180017", "BK202510180018"],
    "validate_only": false
}
```

## Data yang Ditransfer

Sistem akan mentransfer data berikut dari booking ke reg_periksa:

| Field Booking | Field Reg Periksa | Keterangan |
|---------------|-------------------|------------|
| no_booking | no_booking | ID booking asli |
| pasien.no_rkm_medis | no_rkm_medis | Nomor rekam medis |
| tanggal | tgl_registrasi | Tanggal registrasi |
| tanggal | jam_reg | Jam registrasi |
| kd_dokter | kd_dokter | Kode dokter |
| kd_poli | kd_poli | Kode poliklinik |
| - | no_rawat | Auto-generated (YYYY/MM/DD/NNNNNN) |
| - | no_reg | Auto-generated berdasarkan urutan |
| - | kd_pj | Default: "BPJ" (BPJS) |
| - | almt_pj | Alamat penanggung jawab |
| - | hubunganpj | Default: "KELUARGA" |
| - | biaya_reg | Default: 0 |
| - | stts | Default: "Belum" |

## Validasi dan Error Handling

### Validasi yang Dilakukan:
1. **Booking exists**: Memastikan booking ada di database
2. **Patient registered**: Memastikan pasien sudah terdaftar di SIMRS
3. **Status check**: Memastikan status booking adalah "Diterima"
4. **Duplicate prevention**: Mencegah transfer booking yang sudah pernah ditransfer
5. **Date validation**: Memastikan tanggal booking valid

### Pesan Error Umum:
- `"Booking tidak ditemukan"` - Booking ID tidak ada
- `"Pasien belum terdaftar di SIMRS"` - Pasien belum memiliki no_rkm_medis
- `"Status booking harus 'Diterima'"` - Status booking tidak sesuai
- `"Booking sudah pernah ditransfer"` - Mencegah duplikasi

## Monitoring dan Logging

### Log Transfer:
Setiap transfer akan dicatat dalam log dengan informasi:
- Timestamp transfer
- Booking ID yang ditransfer
- No rawat yang dihasilkan
- Status transfer (berhasil/gagal)
- Pesan error (jika ada)

### Lokasi Log:
- Laravel Log: `storage/logs/laravel.log`
- Command Output: Terminal/Console

## Troubleshooting

### Masalah Umum:

1. **Transfer Gagal - Pasien Belum Terdaftar**
   - **Solusi**: Daftarkan pasien terlebih dahulu melalui tombol "Daftarkan ke SIMRS"

2. **Transfer Gagal - Status Bukan "Diterima"**
   - **Solusi**: Ubah status booking menjadi "Diterima" terlebih dahulu

3. **Transfer Gagal - Booking Sudah Ditransfer**
   - **Solusi**: Cek tabel reg_periksa, booking mungkin sudah pernah ditransfer

4. **No Rawat Tidak Muncul**
   - **Solusi**: Periksa format tanggal dan pastikan sequence number ter-generate dengan benar

### Debugging:
```bash
# Cek log Laravel
tail -f storage/logs/laravel.log

# Cek data reg_periksa terbaru
php artisan tinker
>>> App\Models\RegPeriksa::latest('tgl_registrasi')->take(5)->get()

# Cek status booking
>>> App\Models\BookingPeriksa::where('no_booking', 'BK202510180017')->first()
```

## Keamanan

### Validasi Input:
- Semua input divalidasi sebelum diproses
- Sanitasi data untuk mencegah SQL injection
- CSRF protection pada form web

### Authorization:
- Hanya admin yang dapat melakukan transfer
- API endpoint dilindungi dengan authentication
- Rate limiting untuk mencegah abuse

## Performance

### Optimasi:
- Batch processing untuk multiple transfer
- Database transaction untuk data consistency
- Efficient query dengan eager loading

### Monitoring:
- Track waktu eksekusi transfer
- Monitor penggunaan memory
- Log slow queries

## Backup dan Recovery

### Sebelum Transfer:
- Sistem otomatis membuat backup data booking
- Log semua perubahan untuk audit trail

### Recovery:
- Data dapat di-rollback jika diperlukan
- Backup dapat direstore melalui command khusus

---

**Catatan**: Dokumentasi ini akan diperbarui seiring dengan pengembangan fitur baru. Untuk pertanyaan atau masalah, hubungi tim development.