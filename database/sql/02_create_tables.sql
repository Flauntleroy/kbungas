-- =====================================================
-- KLINIK BUNGAS - CREATE TABLES
-- =====================================================
-- Pastikan sudah menggunakan database kbungas
USE `kbungas`;

-- =====================================================
-- 1. USERS TABLE (Extended Laravel Users)
-- =====================================================
CREATE TABLE IF NOT EXISTS `users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `email_verified_at` TIMESTAMP NULL DEFAULT NULL,
    `password` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(20) NULL,
    `role` ENUM('super_admin', 'admin', 'staff', 'doctor') DEFAULT 'staff',
    `status` ENUM('active', 'inactive') DEFAULT 'active',
    `avatar` VARCHAR(255) NULL,
    `two_factor_secret` TEXT NULL,
    `two_factor_recovery_codes` TEXT NULL,
    `two_factor_confirmed_at` TIMESTAMP NULL DEFAULT NULL,
    `remember_token` VARCHAR(100) NULL,
    `current_team_id` BIGINT UNSIGNED NULL,
    `profile_photo_path` VARCHAR(2048) NULL,
    `last_login_at` TIMESTAMP NULL DEFAULT NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_users_email` (`email`),
    INDEX `idx_users_role` (`role`),
    INDEX `idx_users_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 2. DOCTORS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS `doctors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL, -- Link ke users table jika dokter juga user
    `name` VARCHAR(255) NOT NULL,
    `specialization` VARCHAR(255) NOT NULL,
    `license_number` VARCHAR(100) NOT NULL UNIQUE,
    `phone` VARCHAR(20) NULL,
    `email` VARCHAR(255) NULL,
    `photo` VARCHAR(255) NULL,
    `experience_years` INT DEFAULT 0,
    `education` TEXT NULL,
    `bio` TEXT NULL,
    `consultation_fee` DECIMAL(10,2) DEFAULT 0.00,
    `status` ENUM('active', 'inactive', 'on_leave') DEFAULT 'active',
    `schedule_notes` TEXT NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_doctors_specialization` (`specialization`),
    INDEX `idx_doctors_status` (`status`),
    INDEX `idx_doctors_license` (`license_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 3. SERVICES TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS `services` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `price` DECIMAL(10,2) DEFAULT 0.00,
    `duration_minutes` INT DEFAULT 30,
    `category` VARCHAR(100) NULL,
    `icon` VARCHAR(255) NULL,
    `is_active` BOOLEAN DEFAULT TRUE,
    `requires_appointment` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_services_category` (`category`),
    INDEX `idx_services_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 4. PATIENTS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS `patients` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `patient_code` VARCHAR(20) NOT NULL UNIQUE,
    `name` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(20) NOT NULL,
    `email` VARCHAR(255) NULL,
    `date_of_birth` DATE NULL,
    `gender` ENUM('male', 'female') NULL,
    `address` TEXT NULL,
    `emergency_contact_name` VARCHAR(255) NULL,
    `emergency_contact_phone` VARCHAR(20) NULL,
    `blood_type` VARCHAR(5) NULL,
    `allergies` TEXT NULL,
    `medical_history` TEXT NULL,
    `notes` TEXT NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_patients_code` (`patient_code`),
    INDEX `idx_patients_phone` (`phone`),
    INDEX `idx_patients_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 5. BOOKINGS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS `bookings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `booking_code` VARCHAR(20) NOT NULL UNIQUE,
    `patient_id` BIGINT UNSIGNED NOT NULL,
    `doctor_id` BIGINT UNSIGNED NOT NULL,
    `service_id` BIGINT UNSIGNED NOT NULL,
    `appointment_date` DATE NOT NULL,
    `appointment_time` TIME NOT NULL,
    `status` ENUM('pending', 'confirmed', 'in_progress', 'completed', 'cancelled', 'no_show') DEFAULT 'pending',
    `complaint` TEXT NULL,
    `notes` TEXT NULL,
    `total_fee` DECIMAL(10,2) DEFAULT 0.00,
    `payment_status` ENUM('unpaid', 'paid', 'partial') DEFAULT 'unpaid',
    `payment_method` VARCHAR(50) NULL,
    `created_by` BIGINT UNSIGNED NULL,
    `confirmed_at` TIMESTAMP NULL DEFAULT NULL,
    `completed_at` TIMESTAMP NULL DEFAULT NULL,
    `cancelled_at` TIMESTAMP NULL DEFAULT NULL,
    `cancellation_reason` TEXT NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`patient_id`) REFERENCES `patients`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
    INDEX `idx_bookings_code` (`booking_code`),
    INDEX `idx_bookings_date` (`appointment_date`),
    INDEX `idx_bookings_status` (`status`),
    INDEX `idx_bookings_patient` (`patient_id`),
    INDEX `idx_bookings_doctor` (`doctor_id`),
    INDEX `idx_bookings_datetime` (`appointment_date`, `appointment_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 6. DOCTOR SCHEDULES TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS `doctor_schedules` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `doctor_id` BIGINT UNSIGNED NOT NULL,
    `day_of_week` TINYINT NOT NULL, -- 0=Sunday, 1=Monday, ..., 6=Saturday
    `start_time` TIME NOT NULL,
    `end_time` TIME NOT NULL,
    `is_available` BOOLEAN DEFAULT TRUE,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`id`) ON DELETE CASCADE,
    INDEX `idx_schedules_doctor_day` (`doctor_id`, `day_of_week`),
    UNIQUE KEY `unique_doctor_schedule` (`doctor_id`, `day_of_week`, `start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 7. CLINIC SETTINGS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS `clinic_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `key` VARCHAR(100) NOT NULL UNIQUE,
    `value` TEXT NULL,
    `type` ENUM('string', 'number', 'boolean', 'json') DEFAULT 'string',
    `description` TEXT NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_settings_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 8. MEDICAL RECORDS TABLE
-- =====================================================
CREATE TABLE IF NOT EXISTS `medical_records` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `booking_id` BIGINT UNSIGNED NOT NULL,
    `patient_id` BIGINT UNSIGNED NOT NULL,
    `doctor_id` BIGINT UNSIGNED NOT NULL,
    `diagnosis` TEXT NULL,
    `treatment` TEXT NULL,
    `prescription` TEXT NULL,
    `notes` TEXT NULL,
    `vital_signs` JSON NULL, -- {"blood_pressure": "120/80", "temperature": "36.5", "weight": "70", "height": "170"}
    `follow_up_date` DATE NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`booking_id`) REFERENCES `bookings`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`patient_id`) REFERENCES `patients`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`id`) ON DELETE CASCADE,
    INDEX `idx_records_patient` (`patient_id`),
    INDEX `idx_records_doctor` (`doctor_id`),
    INDEX `idx_records_booking` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 9. CACHE TABLE (Laravel Cache)
-- =====================================================
CREATE TABLE IF NOT EXISTS `cache` (
    `key` VARCHAR(255) NOT NULL,
    `value` MEDIUMTEXT NOT NULL,
    `expiration` INT NOT NULL,
    PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `cache_locks` (
    `key` VARCHAR(255) NOT NULL,
    `owner` VARCHAR(255) NOT NULL,
    `expiration` INT NOT NULL,
    PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 10. JOBS TABLE (Laravel Queue)
-- =====================================================
CREATE TABLE IF NOT EXISTS `jobs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `queue` VARCHAR(255) NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `attempts` TINYINT UNSIGNED NOT NULL,
    `reserved_at` INT UNSIGNED NULL,
    `available_at` INT UNSIGNED NOT NULL,
    `created_at` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `job_batches` (
    `id` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `total_jobs` INT NOT NULL,
    `pending_jobs` INT NOT NULL,
    `failed_jobs` INT NOT NULL,
    `failed_job_ids` LONGTEXT NOT NULL,
    `options` MEDIUMTEXT NULL,
    `cancelled_at` INT NULL,
    `created_at` INT NOT NULL,
    `finished_at` INT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `failed_jobs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(255) NOT NULL UNIQUE,
    `connection` TEXT NOT NULL,
    `queue` TEXT NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `exception` LONGTEXT NOT NULL,
    `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;