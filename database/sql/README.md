# 🏥 Klinik Bungas - Database Setup Guide

Panduan lengkap untuk setup database sistem Klinik Bungas dengan konfigurasi yang telah ditentukan.

## 📋 Konfigurasi Database

- **Server**: 192.168.0.3
- **Port**: 3939
- **Database**: kbungas
- **Username**: kbungas
- **Password**: HewlettPackard11@@

## 🚀 Langkah-langkah Setup

### 1. Setup Database & User
```sql
-- Jalankan file ini sebagai root/admin user
mysql -u root -p -h 192.168.0.3 -P 3939 < 01_setup_database.sql
```

### 2. Buat Tabel-tabel
```sql
-- Jalankan setelah database dan user berhasil dibuat
mysql -u kbungas -p -h 192.168.0.3 -P 3939 kbungas < 02_create_tables.sql
```

### 3. Insert Data Sample
```sql
-- Jalankan untuk mengisi data sample/testing
mysql -u kbungas -p -h 192.168.0.3 -P 3939 kbungas < 03_seed_data.sql
```

### 4. Optimasi Database
```sql
-- Jalankan untuk optimasi performa dan views
mysql -u kbungas -p -h 192.168.0.3 -P 3939 kbungas < 04_optimization_queries.sql
```

### 5. Konfigurasi Laravel
- Copy konfigurasi dari `05_env_configuration.txt` ke file `.env`
- Jalankan `php artisan key:generate`
- Jalankan `php artisan config:cache`

## 📊 Struktur Database

### Tabel Utama

| Tabel | Deskripsi |
|-------|-----------|
| `users` | Data pengguna sistem (admin, staff, dokter) |
| `doctors` | Data dokter dan spesialisasi |
| `patients` | Data pasien |
| `services` | Layanan klinik |
| `bookings` | Data booking/appointment |
| `doctor_schedules` | Jadwal praktek dokter |
| `medical_records` | Rekam medis pasien |
| `clinic_settings` | Pengaturan klinik |

### Views yang Tersedia

| View | Deskripsi |
|------|-----------|
| `v_booking_details` | Detail booking dengan informasi lengkap |
| `v_doctor_statistics` | Statistik performa dokter |
| `v_daily_report` | Laporan harian klinik |

### Stored Procedures

| Procedure | Deskripsi |
|-----------|-----------|
| `GenerateBookingCode()` | Generate kode booking unik |
| `GeneratePatientCode()` | Generate kode pasien unik |
| `CheckDoctorAvailability()` | Cek ketersediaan dokter |

## 🔐 Data Sample

### Users Default
- **Super Admin**: admin@klinikbungas.com (password: password)
- **Admin**: doctor.admin@klinikbungas.com (password: password)
- **Staff**: staff@klinikbungas.com (password: password)

### Dokter Sample
- Dr. Sari Melati, Sp.PD (Penyakit Dalam)
- Dr. Budi Santoso, Sp.OG (Kandungan)
- Dr. Maya Indira, Sp.A (Anak)
- Dr. Ahmad Fauzi, Sp.JP (Jantung)
- Dr. Lisa Permata, Sp.M (Mata)

### Layanan Sample
- Konsultasi Umum (Rp 75.000)
- Konsultasi Spesialis (Rp 150.000 - 250.000)
- Medical Check Up (Rp 350.000 - 750.000)
- Vaksinasi (Rp 100.000 - 125.000)

## 📈 Query Berguna

### Dashboard Statistics
```sql
-- Total booking hari ini
SELECT COUNT(*) FROM bookings WHERE DATE(appointment_date) = CURDATE();

-- Revenue bulan ini
SELECT SUM(total_fee) FROM bookings 
WHERE MONTH(appointment_date) = MONTH(CURDATE()) 
AND status = 'completed' AND payment_status = 'paid';

-- Pasien aktif (30 hari terakhir)
SELECT COUNT(DISTINCT patient_id) FROM bookings 
WHERE appointment_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);
```

### Laporan Dokter
```sql
-- Statistik dokter
SELECT * FROM v_doctor_statistics ORDER BY total_bookings DESC;

-- Jadwal dokter hari ini
SELECT d.name, ds.start_time, ds.end_time 
FROM doctors d 
JOIN doctor_schedules ds ON d.id = ds.doctor_id 
WHERE ds.day_of_week = DAYOFWEEK(CURDATE()) - 1;
```

### Manajemen Booking
```sql
-- Booking hari ini
SELECT * FROM v_booking_details 
WHERE appointment_date = CURDATE() 
ORDER BY appointment_time;

-- Cek ketersediaan dokter
CALL CheckDoctorAvailability(1, '2024-01-20', '10:00:00');
```

## 🛠 Maintenance

### Backup Database
```bash
mysqldump -u kbungas -p -h 192.168.0.3 -P 3939 kbungas > backup_kbungas_$(date +%Y%m%d).sql
```

### Restore Database
```bash
mysql -u kbungas -p -h 192.168.0.3 -P 3939 kbungas < backup_kbungas_20240120.sql
```

### Cleanup Data Lama
```sql
-- Hapus cache expired
DELETE FROM cache WHERE expiration < UNIX_TIMESTAMP();

-- Hapus jobs lama (7 hari)
DELETE FROM jobs WHERE created_at < UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 7 DAY));
```

## 🔍 Troubleshooting

### Koneksi Gagal
1. Pastikan MySQL server berjalan di 192.168.0.3:3939
2. Cek firewall dan network connectivity
3. Verifikasi username/password
4. Cek privileges user kbungas

### Performance Issues
1. Jalankan `ANALYZE TABLE` untuk semua tabel
2. Cek query slow dengan `SHOW PROCESSLIST`
3. Monitor ukuran tabel dengan query di `04_optimization_queries.sql`

### Laravel Integration
1. Pastikan konfigurasi .env benar
2. Jalankan `php artisan config:clear`
3. Test koneksi dengan `php artisan tinker` → `DB::connection()->getPdo()`

## 📞 Support

Untuk bantuan teknis, hubungi tim development atau database administrator.

---
**Klinik Bungas Database Setup** - Version 1.0