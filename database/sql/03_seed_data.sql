-- =====================================================
-- KLINIK BUNGAS - SEED DATA
-- =====================================================
-- Pastikan sudah menggunakan database kbungas
USE `kbungas`;

-- =====================================================
-- 1. INSERT USERS (Admin & Staff)
-- =====================================================
INSERT INTO `users` (`name`, `email`, `password`, `phone`, `role`, `status`, `created_at`) VALUES
('Super Admin', 'admin@klinikbungas.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567890', 'super_admin', 'active', NOW()),
('Dr. Admin', 'doctor.admin@klinikbungas.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567891', 'admin', 'active', NOW()),
('Staff Resepsionis', 'staff@klinikbungas.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567892', 'staff', 'active', NOW()),
('Dr. Sari Melati', 'dr.sari@klinikbungas.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567893', 'doctor', 'active', NOW()),
('Dr. Budi Santoso', 'dr.budi@klinikbungas.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '081234567894', 'doctor', 'active', NOW());

-- =====================================================
-- 2. INSERT DOCTORS
-- =====================================================
INSERT INTO `doctors` (`user_id`, `name`, `specialization`, `license_number`, `phone`, `email`, `experience_years`, `education`, `bio`, `consultation_fee`, `status`) VALUES
(4, 'Dr. Sari Melati, Sp.PD', 'Penyakit Dalam', 'STR-001-2020', '081234567893', 'dr.sari@klinikbungas.com', 8, 'S1 Kedokteran Universitas Indonesia, Sp.PD RSCM', 'Dokter spesialis penyakit dalam dengan pengalaman 8 tahun menangani berbagai kasus medis internal.', 150000.00, 'active'),
(5, 'Dr. Budi Santoso, Sp.OG', 'Obstetri & Ginekologi', 'STR-002-2019', '081234567894', 'dr.budi@klinikbungas.com', 10, 'S1 Kedokteran Universitas Gadjah Mada, Sp.OG RSUP Dr. Sardjito', 'Dokter spesialis kandungan dan kebidanan dengan pengalaman 10 tahun dalam pelayanan kesehatan wanita.', 200000.00, 'active'),
(NULL, 'Dr. Maya Indira, Sp.A', 'Anak', 'STR-003-2021', '081234567895', 'dr.maya@klinikbungas.com', 5, 'S1 Kedokteran Universitas Padjadjaran, Sp.A RSHS', 'Dokter spesialis anak yang berpengalaman dalam menangani kesehatan bayi, anak, dan remaja.', 175000.00, 'active'),
(NULL, 'Dr. Ahmad Fauzi, Sp.JP', 'Jantung', 'STR-004-2018', '081234567896', 'dr.ahmad@klinikbungas.com', 12, 'S1 Kedokteran Universitas Airlangga, Sp.JP RSUD Dr. Soetomo', 'Dokter spesialis jantung dan pembuluh darah dengan keahlian dalam kardiologi interventional.', 250000.00, 'active'),
(NULL, 'Dr. Lisa Permata, Sp.M', 'Mata', 'STR-005-2022', '081234567897', 'dr.lisa@klinikbungas.com', 3, 'S1 Kedokteran Universitas Hasanuddin, Sp.M RS Wahidin', 'Dokter spesialis mata yang menangani berbagai gangguan penglihatan dan operasi mata.', 180000.00, 'active');

-- =====================================================
-- 3. INSERT SERVICES
-- =====================================================
INSERT INTO `services` (`name`, `description`, `price`, `duration_minutes`, `category`, `is_active`) VALUES
('Konsultasi Umum', 'Pemeriksaan kesehatan umum dan konsultasi medis dasar', 75000.00, 30, 'Umum', TRUE),
('Konsultasi Spesialis Penyakit Dalam', 'Konsultasi dengan dokter spesialis penyakit dalam', 150000.00, 45, 'Spesialis', TRUE),
('Konsultasi Spesialis Kandungan', 'Konsultasi dengan dokter spesialis obstetri & ginekologi', 200000.00, 45, 'Spesialis', TRUE),
('Konsultasi Spesialis Anak', 'Konsultasi dengan dokter spesialis anak', 175000.00, 45, 'Spesialis', TRUE),
('Konsultasi Spesialis Jantung', 'Konsultasi dengan dokter spesialis jantung', 250000.00, 60, 'Spesialis', TRUE),
('Konsultasi Spesialis Mata', 'Konsultasi dengan dokter spesialis mata', 180000.00, 45, 'Spesialis', TRUE),
('Medical Check Up Basic', 'Pemeriksaan kesehatan dasar meliputi vital sign, lab dasar', 350000.00, 90, 'MCU', TRUE),
('Medical Check Up Executive', 'Pemeriksaan kesehatan lengkap dengan berbagai tes penunjang', 750000.00, 180, 'MCU', TRUE),
('Vaksinasi Dewasa', 'Layanan vaksinasi untuk dewasa (influenza, hepatitis, dll)', 125000.00, 15, 'Vaksinasi', TRUE),
('Vaksinasi Anak', 'Layanan vaksinasi untuk anak sesuai jadwal imunisasi', 100000.00, 15, 'Vaksinasi', TRUE),
('USG Kandungan', 'Pemeriksaan ultrasonografi untuk kehamilan', 150000.00, 30, 'Diagnostik', TRUE),
('EKG', 'Pemeriksaan elektrokardiografi untuk jantung', 100000.00, 20, 'Diagnostik', TRUE);

-- =====================================================
-- 4. INSERT DOCTOR SCHEDULES
-- =====================================================
-- Dr. Sari Melati (Senin-Jumat, 08:00-16:00)
INSERT INTO `doctor_schedules` (`doctor_id`, `day_of_week`, `start_time`, `end_time`, `is_available`) VALUES
(1, 1, '08:00:00', '16:00:00', TRUE), -- Monday
(1, 2, '08:00:00', '16:00:00', TRUE), -- Tuesday
(1, 3, '08:00:00', '16:00:00', TRUE), -- Wednesday
(1, 4, '08:00:00', '16:00:00', TRUE), -- Thursday
(1, 5, '08:00:00', '16:00:00', TRUE); -- Friday

-- Dr. Budi Santoso (Senin, Rabu, Jumat 09:00-17:00)
INSERT INTO `doctor_schedules` (`doctor_id`, `day_of_week`, `start_time`, `end_time`, `is_available`) VALUES
(2, 1, '09:00:00', '17:00:00', TRUE), -- Monday
(2, 3, '09:00:00', '17:00:00', TRUE), -- Wednesday
(2, 5, '09:00:00', '17:00:00', TRUE); -- Friday

-- Dr. Maya Indira (Selasa, Kamis, Sabtu 08:00-15:00)
INSERT INTO `doctor_schedules` (`doctor_id`, `day_of_week`, `start_time`, `end_time`, `is_available`) VALUES
(3, 2, '08:00:00', '15:00:00', TRUE), -- Tuesday
(3, 4, '08:00:00', '15:00:00', TRUE), -- Thursday
(3, 6, '08:00:00', '15:00:00', TRUE); -- Saturday

-- Dr. Ahmad Fauzi (Senin-Kamis 10:00-18:00)
INSERT INTO `doctor_schedules` (`doctor_id`, `day_of_week`, `start_time`, `end_time`, `is_available`) VALUES
(4, 1, '10:00:00', '18:00:00', TRUE), -- Monday
(4, 2, '10:00:00', '18:00:00', TRUE), -- Tuesday
(4, 3, '10:00:00', '18:00:00', TRUE), -- Wednesday
(4, 4, '10:00:00', '18:00:00', TRUE); -- Thursday

-- Dr. Lisa Permata (Rabu-Sabtu 09:00-16:00)
INSERT INTO `doctor_schedules` (`doctor_id`, `day_of_week`, `start_time`, `end_time`, `is_available`) VALUES
(5, 3, '09:00:00', '16:00:00', TRUE), -- Wednesday
(5, 4, '09:00:00', '16:00:00', TRUE), -- Thursday
(5, 5, '09:00:00', '16:00:00', TRUE), -- Friday
(5, 6, '09:00:00', '16:00:00', TRUE); -- Saturday

-- =====================================================
-- 5. INSERT SAMPLE PATIENTS
-- =====================================================
INSERT INTO `patients` (`patient_code`, `name`, `phone`, `email`, `date_of_birth`, `gender`, `address`, `emergency_contact_name`, `emergency_contact_phone`, `blood_type`) VALUES
('P001', 'Andi Wijaya', '081234567801', 'andi.wijaya@email.com', '1985-03-15', 'male', 'Jl. Merdeka No. 123, Jakarta Pusat', 'Siti Wijaya', '081234567802', 'O+'),
('P002', 'Sari Dewi', '081234567803', 'sari.dewi@email.com', '1990-07-22', 'female', 'Jl. Sudirman No. 456, Jakarta Selatan', 'Budi Dewi', '081234567804', 'A+'),
('P003', 'Bambang Sutrisno', '081234567805', 'bambang.s@email.com', '1978-11-08', 'male', 'Jl. Gatot Subroto No. 789, Jakarta Barat', 'Ratna Sutrisno', '081234567806', 'B+'),
('P004', 'Maya Sari', '081234567807', 'maya.sari@email.com', '1995-01-30', 'female', 'Jl. Thamrin No. 321, Jakarta Pusat', 'Dedi Sari', '081234567808', 'AB+'),
('P005', 'Rudi Hartono', '081234567809', 'rudi.h@email.com', '1982-09-12', 'male', 'Jl. Kuningan No. 654, Jakarta Selatan', 'Lia Hartono', '081234567810', 'O-');

-- =====================================================
-- 6. INSERT SAMPLE BOOKINGS
-- =====================================================
INSERT INTO `bookings` (`booking_code`, `patient_id`, `doctor_id`, `service_id`, `appointment_date`, `appointment_time`, `status`, `complaint`, `total_fee`, `payment_status`, `created_by`) VALUES
('BK001', 1, 1, 2, '2024-01-15', '09:00:00', 'completed', 'Sakit kepala dan demam sejak 3 hari', 150000.00, 'paid', 3),
('BK002', 2, 2, 3, '2024-01-16', '10:00:00', 'confirmed', 'Kontrol kehamilan rutin', 200000.00, 'unpaid', 3),
('BK003', 3, 4, 5, '2024-01-17', '14:00:00', 'pending', 'Nyeri dada dan sesak napas', 250000.00, 'unpaid', 3),
('BK004', 4, 3, 4, '2024-01-18', '11:00:00', 'confirmed', 'Imunisasi anak', 175000.00, 'paid', 3),
('BK005', 5, 5, 6, '2024-01-19', '13:00:00', 'pending', 'Mata merah dan berair', 180000.00, 'unpaid', 3);

-- =====================================================
-- 7. INSERT CLINIC SETTINGS
-- =====================================================
INSERT INTO `clinic_settings` (`key`, `value`, `type`, `description`) VALUES
('clinic_name', 'Klinik Bungas', 'string', 'Nama klinik'),
('clinic_address', 'Jl. Kesehatan No. 123, Jakarta', 'string', 'Alamat klinik'),
('clinic_phone', '021-12345678', 'string', 'Nomor telepon klinik'),
('clinic_email', 'info@klinikbungas.com', 'string', 'Email klinik'),
('clinic_website', 'https://klinikbungas.com', 'string', 'Website klinik'),
('operating_hours', '{"monday": "08:00-17:00", "tuesday": "08:00-17:00", "wednesday": "08:00-17:00", "thursday": "08:00-17:00", "friday": "08:00-17:00", "saturday": "08:00-15:00", "sunday": "closed"}', 'json', 'Jam operasional klinik'),
('emergency_contact', '081234567890', 'string', 'Nomor kontak darurat'),
('whatsapp_number', '6281234567890', 'string', 'Nomor WhatsApp untuk booking'),
('booking_advance_days', '30', 'number', 'Maksimal hari booking di muka'),
('booking_cancel_hours', '24', 'number', 'Minimal jam sebelum appointment untuk cancel'),
('auto_confirm_booking', 'false', 'boolean', 'Otomatis konfirmasi booking baru'),
('send_reminder_sms', 'true', 'boolean', 'Kirim SMS reminder'),
('reminder_hours_before', '24', 'number', 'Jam sebelum appointment untuk reminder');

-- =====================================================
-- 8. INSERT SAMPLE MEDICAL RECORDS
-- =====================================================
INSERT INTO `medical_records` (`booking_id`, `patient_id`, `doctor_id`, `diagnosis`, `treatment`, `prescription`, `notes`, `vital_signs`) VALUES
(1, 1, 1, 'Demam tifoid ringan', 'Istirahat total, banyak minum air putih', 'Paracetamol 3x500mg, Amoxicillin 3x500mg', 'Pasien disarankan kontrol 3 hari lagi', '{"blood_pressure": "120/80", "temperature": "38.2", "weight": "70", "height": "170", "pulse": "88"}');

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================
-- Uncomment untuk verifikasi data yang telah diinsert

-- SELECT 'Users created:' as info, COUNT(*) as count FROM users;
-- SELECT 'Doctors created:' as info, COUNT(*) as count FROM doctors;
-- SELECT 'Services created:' as info, COUNT(*) as count FROM services;
-- SELECT 'Patients created:' as info, COUNT(*) as count FROM patients;
-- SELECT 'Bookings created:' as info, COUNT(*) as count FROM bookings;
-- SELECT 'Doctor schedules created:' as info, COUNT(*) as count FROM doctor_schedules;
-- SELECT 'Clinic settings created:' as info, COUNT(*) as count FROM clinic_settings;
-- SELECT 'Medical records created:' as info, COUNT(*) as count FROM medical_records;