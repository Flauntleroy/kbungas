-- =====================================================
-- KLINIK BUNGAS - OPTIMIZATION & USEFUL QUERIES
-- =====================================================
-- Pastikan sudah menggunakan database kbungas
USE `kbungas`;

-- =====================================================
-- 1. ADDITIONAL INDEXES FOR PERFORMANCE
-- =====================================================

-- Index untuk pencarian booking berdasarkan tanggal dan status
CREATE INDEX IF NOT EXISTS `idx_bookings_date_status` ON `bookings` (`appointment_date`, `status`);

-- Index untuk pencarian pasien berdasarkan nama (untuk autocomplete)
CREATE INDEX IF NOT EXISTS `idx_patients_name_phone` ON `patients` (`name`, `phone`);

-- Index untuk medical records berdasarkan tanggal
CREATE INDEX IF NOT EXISTS `idx_medical_records_date` ON `medical_records` (`created_at`);

-- Index untuk doctor schedules berdasarkan hari dan waktu
CREATE INDEX IF NOT EXISTS `idx_doctor_schedules_time` ON `doctor_schedules` (`day_of_week`, `start_time`, `end_time`);

-- Index untuk users berdasarkan last login
CREATE INDEX IF NOT EXISTS `idx_users_last_login` ON `users` (`last_login_at`);

-- =====================================================
-- 2. USEFUL VIEWS FOR REPORTING
-- =====================================================

-- View untuk booking dengan detail lengkap
CREATE OR REPLACE VIEW `v_booking_details` AS
SELECT 
    b.id,
    b.booking_code,
    b.appointment_date,
    b.appointment_time,
    b.status,
    b.total_fee,
    b.payment_status,
    p.name AS patient_name,
    p.phone AS patient_phone,
    p.patient_code,
    d.name AS doctor_name,
    d.specialization,
    s.name AS service_name,
    s.category AS service_category,
    u.name AS created_by_name,
    b.created_at,
    b.updated_at
FROM bookings b
JOIN patients p ON b.patient_id = p.id
JOIN doctors d ON b.doctor_id = d.id
JOIN services s ON b.service_id = s.id
LEFT JOIN users u ON b.created_by = u.id;

-- View untuk statistik dokter
CREATE OR REPLACE VIEW `v_doctor_statistics` AS
SELECT 
    d.id,
    d.name,
    d.specialization,
    d.status,
    COUNT(b.id) AS total_bookings,
    COUNT(CASE WHEN b.status = 'completed' THEN 1 END) AS completed_bookings,
    COUNT(CASE WHEN b.status = 'cancelled' THEN 1 END) AS cancelled_bookings,
    COALESCE(SUM(CASE WHEN b.status = 'completed' AND b.payment_status = 'paid' THEN b.total_fee END), 0) AS total_revenue,
    AVG(CASE WHEN b.status = 'completed' THEN b.total_fee END) AS avg_consultation_fee
FROM doctors d
LEFT JOIN bookings b ON d.id = b.doctor_id
GROUP BY d.id, d.name, d.specialization, d.status;

-- View untuk laporan harian
CREATE OR REPLACE VIEW `v_daily_report` AS
SELECT 
    DATE(b.appointment_date) AS report_date,
    COUNT(b.id) AS total_appointments,
    COUNT(CASE WHEN b.status = 'completed' THEN 1 END) AS completed_appointments,
    COUNT(CASE WHEN b.status = 'cancelled' THEN 1 END) AS cancelled_appointments,
    COUNT(CASE WHEN b.status = 'no_show' THEN 1 END) AS no_show_appointments,
    COALESCE(SUM(CASE WHEN b.status = 'completed' AND b.payment_status = 'paid' THEN b.total_fee END), 0) AS daily_revenue,
    COUNT(DISTINCT b.patient_id) AS unique_patients,
    COUNT(DISTINCT b.doctor_id) AS active_doctors
FROM bookings b
WHERE b.appointment_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY DATE(b.appointment_date)
ORDER BY report_date DESC;

-- =====================================================
-- 3. STORED PROCEDURES FOR COMMON OPERATIONS
-- =====================================================

-- Procedure untuk generate booking code
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS `GenerateBookingCode`()
BEGIN
    DECLARE new_code VARCHAR(20);
    DECLARE code_exists INT DEFAULT 1;
    
    WHILE code_exists > 0 DO
        SET new_code = CONCAT('BK', LPAD(FLOOR(RAND() * 999999), 6, '0'));
        SELECT COUNT(*) INTO code_exists FROM bookings WHERE booking_code = new_code;
    END WHILE;
    
    SELECT new_code AS booking_code;
END //
DELIMITER ;

-- Procedure untuk generate patient code
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS `GeneratePatientCode`()
BEGIN
    DECLARE new_code VARCHAR(20);
    DECLARE code_exists INT DEFAULT 1;
    
    WHILE code_exists > 0 DO
        SET new_code = CONCAT('P', LPAD(FLOOR(RAND() * 9999), 4, '0'));
        SELECT COUNT(*) INTO code_exists FROM patients WHERE patient_code = new_code;
    END WHILE;
    
    SELECT new_code AS patient_code;
END //
DELIMITER ;

-- Procedure untuk cek ketersediaan dokter
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS `CheckDoctorAvailability`(
    IN doctor_id_param BIGINT,
    IN appointment_date_param DATE,
    IN appointment_time_param TIME
)
BEGIN
    DECLARE day_of_week_num INT;
    DECLARE is_available INT DEFAULT 0;
    DECLARE existing_booking INT DEFAULT 0;
    
    -- Get day of week (0=Sunday, 1=Monday, etc.)
    SET day_of_week_num = DAYOFWEEK(appointment_date_param) - 1;
    
    -- Check if doctor has schedule on this day and time
    SELECT COUNT(*) INTO is_available
    FROM doctor_schedules ds
    WHERE ds.doctor_id = doctor_id_param
    AND ds.day_of_week = day_of_week_num
    AND ds.is_available = TRUE
    AND appointment_time_param BETWEEN ds.start_time AND ds.end_time;
    
    -- Check if there's already a booking at this time
    SELECT COUNT(*) INTO existing_booking
    FROM bookings b
    WHERE b.doctor_id = doctor_id_param
    AND b.appointment_date = appointment_date_param
    AND b.appointment_time = appointment_time_param
    AND b.status NOT IN ('cancelled', 'no_show');
    
    -- Return availability status
    SELECT 
        CASE 
            WHEN is_available > 0 AND existing_booking = 0 THEN 'available'
            WHEN is_available = 0 THEN 'no_schedule'
            WHEN existing_booking > 0 THEN 'already_booked'
            ELSE 'not_available'
        END AS availability_status;
END //
DELIMITER ;

-- =====================================================
-- 4. USEFUL QUERIES FOR ADMIN DASHBOARD
-- =====================================================

-- Query untuk statistik dashboard
-- Total bookings hari ini
-- SELECT COUNT(*) AS today_bookings FROM bookings WHERE DATE(appointment_date) = CURDATE();

-- Total revenue bulan ini
-- SELECT COALESCE(SUM(total_fee), 0) AS monthly_revenue 
-- FROM bookings 
-- WHERE MONTH(appointment_date) = MONTH(CURDATE()) 
-- AND YEAR(appointment_date) = YEAR(CURDATE()) 
-- AND status = 'completed' 
-- AND payment_status = 'paid';

-- Total pasien aktif
-- SELECT COUNT(DISTINCT patient_id) AS active_patients 
-- FROM bookings 
-- WHERE appointment_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Booking terbaru (5 terakhir)
-- SELECT * FROM v_booking_details ORDER BY created_at DESC LIMIT 5;

-- Dokter dengan booking terbanyak bulan ini
-- SELECT 
--     d.name,
--     d.specialization,
--     COUNT(b.id) AS booking_count
-- FROM doctors d
-- JOIN bookings b ON d.id = b.doctor_id
-- WHERE MONTH(b.appointment_date) = MONTH(CURDATE())
-- AND YEAR(b.appointment_date) = YEAR(CURDATE())
-- GROUP BY d.id, d.name, d.specialization
-- ORDER BY booking_count DESC
-- LIMIT 5;

-- =====================================================
-- 5. MAINTENANCE QUERIES
-- =====================================================

-- Query untuk cleanup data lama (jalankan secara berkala)
-- DELETE FROM cache WHERE expiration < UNIX_TIMESTAMP();
-- DELETE FROM jobs WHERE created_at < UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 7 DAY));

-- Query untuk backup booking yang sudah selesai lebih dari 1 tahun
-- CREATE TABLE IF NOT EXISTS bookings_archive LIKE bookings;
-- INSERT INTO bookings_archive SELECT * FROM bookings WHERE status = 'completed' AND appointment_date < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- =====================================================
-- 6. PERFORMANCE MONITORING QUERIES
-- =====================================================

-- Cek ukuran tabel
-- SELECT 
--     table_name AS 'Table',
--     ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
-- FROM information_schema.TABLES 
-- WHERE table_schema = 'kbungas'
-- ORDER BY (data_length + index_length) DESC;

-- Cek index yang tidak terpakai
-- SELECT 
--     s.table_name,
--     s.index_name,
--     s.cardinality
-- FROM information_schema.statistics s
-- LEFT JOIN information_schema.key_column_usage k ON s.table_name = k.table_name AND s.index_name = k.constraint_name
-- WHERE s.table_schema = 'kbungas' AND k.constraint_name IS NULL
-- ORDER BY s.table_name, s.index_name;

-- =====================================================
-- 7. SECURITY QUERIES
-- =====================================================

-- Query untuk audit login
-- SELECT 
--     u.name,
--     u.email,
--     u.role,
--     u.last_login_at,
--     CASE 
--         WHEN u.last_login_at IS NULL THEN 'Never logged in'
--         WHEN u.last_login_at < DATE_SUB(NOW(), INTERVAL 30 DAY) THEN 'Inactive (30+ days)'
--         WHEN u.last_login_at < DATE_SUB(NOW(), INTERVAL 7 DAY) THEN 'Less active (7+ days)'
--         ELSE 'Active'
--     END AS login_status
-- FROM users u
-- WHERE u.status = 'active'
-- ORDER BY u.last_login_at DESC;

-- Query untuk cek booking yang mencurigakan (banyak booking dalam waktu singkat)
-- SELECT 
--     p.name,
--     p.phone,
--     COUNT(b.id) AS booking_count,
--     MIN(b.created_at) AS first_booking,
--     MAX(b.created_at) AS last_booking
-- FROM patients p
-- JOIN bookings b ON p.id = b.patient_id
-- WHERE b.created_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)
-- GROUP BY p.id, p.name, p.phone
-- HAVING booking_count > 5
-- ORDER BY booking_count DESC;