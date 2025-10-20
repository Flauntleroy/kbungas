/*
 Navicat Premium Data Transfer

 Source Server         : Master N
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : 192.168.0.3:3939
 Source Schema         : kbungas

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 20/10/2025 06:44:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for clinic_settings
-- ----------------------------
DROP TABLE IF EXISTS `clinic_settings`;
CREATE TABLE `clinic_settings`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `type` enum('string','number','boolean','json') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'string',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `key`(`key`) USING BTREE,
  INDEX `idx_settings_key`(`key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of clinic_settings
-- ----------------------------
INSERT INTO `clinic_settings` VALUES (1, 'clinic_name', 'Klinik Bungas', 'string', 'Nama klinik', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (2, 'clinic_address', 'Jl. Kesehatan No. 123, Jakarta', 'string', 'Alamat klinik', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (3, 'clinic_phone', '021-12345678', 'string', 'Nomor telepon klinik', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (4, 'clinic_email', 'info@klinikbungas.com', 'string', 'Email klinik', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (5, 'clinic_website', 'https://klinikbungas.com', 'string', 'Website klinik', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (6, 'operating_hours', '{\"monday\": \"08:00-17:00\", \"tuesday\": \"08:00-17:00\", \"wednesday\": \"08:00-17:00\", \"thursday\": \"08:00-17:00\", \"friday\": \"08:00-17:00\", \"saturday\": \"08:00-15:00\", \"sunday\": \"closed\"}', 'json', 'Jam operasional klinik', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (7, 'emergency_contact', '081234567890', 'string', 'Nomor kontak darurat', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (8, 'whatsapp_number', '6281234567890', 'string', 'Nomor WhatsApp untuk booking', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (9, 'booking_advance_days', '30', 'number', 'Maksimal hari booking di muka', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (10, 'booking_cancel_hours', '24', 'number', 'Minimal jam sebelum appointment untuk cancel', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (11, 'auto_confirm_booking', 'false', 'boolean', 'Otomatis konfirmasi booking baru', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (12, 'send_reminder_sms', 'true', 'boolean', 'Kirim SMS reminder', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (13, 'reminder_hours_before', '24', 'number', 'Jam sebelum appointment untuk reminder', '2025-10-18 10:41:16', '2025-10-18 10:41:16');
INSERT INTO `clinic_settings` VALUES (14, 'doctors_content', '[{\"name\":\"dr. Aan Widhi Anningrum\",\"specialization\":\"Dokter Umum\",\"description\":\"Berpengalaman lebih dari 10 tahun dalam menangani berbagai masalah kulit\",\"photo\":\"\\/images\\/doctors\\/dr-sarah.jpg\",\"whatsapp\":\"081234567890\",\"available\":true}]', 'json', 'Landing page doctors content', '2025-10-18 18:26:15', '2025-10-18 18:26:15');
INSERT INTO `clinic_settings` VALUES (15, 'contact_content', '{\"address\":\"Jl. Kesehatan No. 123, Jakarta Selatan\",\"phone\":\"021-12345678\",\"whatsapp\":\"081234567890\",\"email\":\"info@klinikbungas.com\",\"hours\":{\"senin\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"selasa\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"rabu\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"kamis\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"jumat\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"sabtu\":{\"open\":\"08:00\",\"close\":\"14:00\",\"closed\":false},\"minggu\":{\"open\":null,\"close\":null,\"closed\":true}},\"schedule\":{\"senin\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"selasa\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"rabu\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"kamis\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"jumat\":{\"open\":\"08:00\",\"close\":\"17:00\",\"closed\":false},\"sabtu\":{\"open\":\"08:00\",\"close\":\"14:00\",\"closed\":false},\"minggu\":{\"open\":null,\"close\":null,\"closed\":true}}}', 'json', 'Landing page contact content', '2025-10-18 18:26:15', '2025-10-18 18:26:15');
INSERT INTO `clinic_settings` VALUES (16, 'services_content', '[{\"name\":\"Konsultasi Kulit\",\"description\":\"Konsultasi menyeluruh untuk berbagai masalah kulit dengan dokter spesialis\",\"icon\":\"<svg class=\\\"w-8 h-8\\\" fill=\\\"none\\\" stroke=\\\"currentColor\\\" viewBox=\\\"0 0 24 24\\\"><path stroke-linecap=\\\"round\\\" stroke-linejoin=\\\"round\\\" stroke-width=\\\"2\\\" d=\\\"M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z\\\"\\/><\\/svg>\"},{\"name\":\"Perawatan Jerawat\",\"description\":\"Treatment khusus untuk mengatasi jerawat dan bekasnya\",\"icon\":\"<svg class=\\\"w-8 h-8\\\" fill=\\\"none\\\" stroke=\\\"currentColor\\\" viewBox=\\\"0 0 24 24\\\"><path stroke-linecap=\\\"round\\\" stroke-linejoin=\\\"round\\\" stroke-width=\\\"2\\\" d=\\\"M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z\\\"\\/><\\/svg>\"}]', 'json', 'Landing page services content', '2025-10-18 18:26:15', '2025-10-18 18:26:15');
INSERT INTO `clinic_settings` VALUES (17, 'hero_content', '{\"title\":\"Klinik Kulit & Kecantikan Terpercaya\",\"subtitle\":\"Dapatkan perawatan kulit terbaik dengan teknologi modern dan dokter berpengalaman. Konsultasi gratis untuk semua pasien baru.\",\"ctaText\":\"Booking Konsultasi\",\"ctaLink\":\"\\/booking\"}', 'json', 'Landing page hero content', '2025-10-18 18:26:15', '2025-10-18 18:26:15');

SET FOREIGN_KEY_CHECKS = 1;
