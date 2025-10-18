-- =====================================================
-- KLINIK BUNGAS DATABASE SETUP
-- =====================================================
-- Server: 192.168.0.3
-- Port: 3939
-- Database: kbungas
-- Username: kbungas
-- Password: HewlettPackard11@@
-- =====================================================

-- 1. CREATE DATABASE
-- Jalankan sebagai root/admin user terlebih dahulu
CREATE DATABASE IF NOT EXISTS `kbungas` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 2. CREATE USER AND GRANT PRIVILEGES
-- Buat user khusus untuk aplikasi
CREATE USER IF NOT EXISTS 'kbungas'@'%' IDENTIFIED BY 'HewlettPackard11@@';
CREATE USER IF NOT EXISTS 'kbungas'@'localhost' IDENTIFIED BY 'HewlettPackard11@@';

-- Grant privileges untuk user kbungas
GRANT ALL PRIVILEGES ON `kbungas`.* TO 'kbungas'@'%';
GRANT ALL PRIVILEGES ON `kbungas`.* TO 'kbungas'@'localhost';

-- Flush privileges untuk memastikan perubahan diterapkan
FLUSH PRIVILEGES;

-- 3. USE DATABASE
USE `kbungas`;

-- 4. SET TIMEZONE (Optional - sesuaikan dengan lokasi klinik)
SET time_zone = '+07:00'; -- WIB (Waktu Indonesia Barat)

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================
-- Jalankan query berikut untuk memverifikasi setup:

-- Cek database yang telah dibuat
-- SHOW DATABASES LIKE 'kbungas';

-- Cek user yang telah dibuat
-- SELECT User, Host FROM mysql.user WHERE User = 'kbungas';

-- Cek privileges user
-- SHOW GRANTS FOR 'kbungas'@'%';
-- SHOW GRANTS FOR 'kbungas'@'localhost';

-- Test koneksi (jalankan setelah login dengan user kbungas)
-- SELECT 'Database connection successful!' AS status, NOW() AS current_time;