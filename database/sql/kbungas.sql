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

 Date: 18/10/2025 17:12:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aturan_pakai
-- ----------------------------
DROP TABLE IF EXISTS `aturan_pakai`;
CREATE TABLE `aturan_pakai`  (
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `aturan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tgl_perawatan`, `jam`, `no_rawat`, `kode_brng`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `aturan_pakai_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aturan_pakai_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bahasa_pasien
-- ----------------------------
DROP TABLE IF EXISTS `bahasa_pasien`;
CREATE TABLE `bahasa_pasien`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_bahasa` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nama_bahasa`(`nama_bahasa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for bangsal
-- ----------------------------
DROP TABLE IF EXISTS `bangsal`;
CREATE TABLE `bangsal`  (
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_bangsal` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_bangsal`) USING BTREE,
  INDEX `nm_bangsal`(`nm_bangsal`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank`  (
  `namabank` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`namabank`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for barcode
-- ----------------------------
DROP TABLE IF EXISTS `barcode`;
CREATE TABLE `barcode`  (
  `id` int(11) NOT NULL,
  `barcode` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `barcode`(`barcode`) USING BTREE,
  CONSTRAINT `barcode_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for beri_obat_operasi
-- ----------------------------
DROP TABLE IF EXISTS `beri_obat_operasi`;
CREATE TABLE `beri_obat_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_obat` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hargasatuan` double NOT NULL,
  `jumlah` double NOT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_obat`(`kd_obat`) USING BTREE,
  INDEX `tanggal`(`tanggal`) USING BTREE,
  INDEX `hargasatuan`(`hargasatuan`) USING BTREE,
  INDEX `jumlah`(`jumlah`) USING BTREE,
  CONSTRAINT `beri_obat_operasi_ibfk_2` FOREIGN KEY (`kd_obat`) REFERENCES `obatbhp_ok` (`kd_obat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `beri_obat_operasi_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for berkas_digital_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `berkas_digital_perawatan`;
CREATE TABLE `berkas_digital_perawatan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi_file` varchar(600) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode`, `lokasi_file`) USING BTREE,
  INDEX `kode`(`kode`) USING BTREE,
  CONSTRAINT `berkas_digital_perawatan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `berkas_digital_perawatan_ibfk_2` FOREIGN KEY (`kode`) REFERENCES `master_berkas_digital` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bidang
-- ----------------------------
DROP TABLE IF EXISTS `bidang`;
CREATE TABLE `bidang`  (
  `nama` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`nama`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for booking_operasi
-- ----------------------------
DROP TABLE IF EXISTS `booking_operasi`;
CREATE TABLE `booking_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `jam_mulai` time NULL DEFAULT NULL,
  `jam_selesai` time NULL DEFAULT NULL,
  `status` enum('Menunggu','Proses Operasi','Selesai') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_ruang_ok` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `kd_ruang_ok`(`kd_ruang_ok`) USING BTREE,
  CONSTRAINT `booking_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_2` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_4` FOREIGN KEY (`kd_ruang_ok`) REFERENCES `ruang_ok` (`kd_ruang_ok`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for booking_periksa
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa`;
CREATE TABLE `booking_periksa`  (
  `no_booking` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `nama` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tambahan_pesan` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Diterima','Ditolak','Belum Dibalas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal_booking` datetime NOT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  UNIQUE INDEX `tanggal`(`tanggal`, `no_telp`) USING BTREE,
  INDEX `kd_poli`(`kd_poli`) USING BTREE,
  CONSTRAINT `booking_periksa_ibfk_1` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for booking_periksa_balasan
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa_balasan`;
CREATE TABLE `booking_periksa_balasan`  (
  `no_booking` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `balasan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  CONSTRAINT `booking_periksa_balasan_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking_periksa` (`no_booking`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for booking_periksa_diterima
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa_diterima`;
CREATE TABLE `booking_periksa_diterima`  (
  `no_booking` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  CONSTRAINT `booking_periksa_diterima_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking_periksa` (`no_booking`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_periksa_diterima_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for booking_registrasi
-- ----------------------------
DROP TABLE IF EXISTS `booking_registrasi`;
CREATE TABLE `booking_registrasi`  (
  `tanggal_booking` date NULL DEFAULT NULL,
  `jam_booking` time NULL DEFAULT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal_periksa` date NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_reg` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `limit_reg` int(11) NULL DEFAULT NULL,
  `waktu_kunjungan` datetime NULL DEFAULT NULL,
  `status` enum('Terdaftar','Belum','Batal','Dokter Berhalangan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`, `tanggal_periksa`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `kd_poli`(`kd_poli`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  CONSTRAINT `booking_registrasi_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_2` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_3` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_4` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bookings
-- ----------------------------
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `booking_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('pending','confirmed','in_progress','completed','cancelled','no_show') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'pending',
  `complaint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `total_fee` decimal(10, 2) NULL DEFAULT 0.00,
  `payment_status` enum('unpaid','paid','partial') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'unpaid',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `confirmed_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `cancellation_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `booking_code`(`booking_code`) USING BTREE,
  INDEX `service_id`(`service_id`) USING BTREE,
  INDEX `created_by`(`created_by`) USING BTREE,
  INDEX `idx_bookings_code`(`booking_code`) USING BTREE,
  INDEX `idx_bookings_date`(`appointment_date`) USING BTREE,
  INDEX `idx_bookings_status`(`status`) USING BTREE,
  INDEX `idx_bookings_patient`(`patient_id`) USING BTREE,
  INDEX `idx_bookings_doctor`(`doctor_id`) USING BTREE,
  INDEX `idx_bookings_datetime`(`appointment_date`, `appointment_time`) USING BTREE,
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `bookings_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bpjs_api_logs
-- ----------------------------
DROP TABLE IF EXISTS `bpjs_api_logs`;
CREATE TABLE `bpjs_api_logs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `request_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `response_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status_code` int(11) NULL DEFAULT NULL,
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `bpjs_api_logs_endpoint_created_at_index`(`endpoint`, `created_at`) USING BTREE,
  INDEX `bpjs_api_logs_status_code_index`(`status_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bpjs_prb
-- ----------------------------
DROP TABLE IF EXISTS `bpjs_prb`;
CREATE TABLE `bpjs_prb`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prb` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_sep`) USING BTREE,
  CONSTRAINT `bpjs_prb_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bridging_rujukan_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_rujukan_bpjs`;
CREATE TABLE `bridging_rujukan_bpjs`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tglRujukan` date NULL DEFAULT NULL,
  `tglRencanaKunjungan` date NOT NULL,
  `ppkDirujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_ppkDirujuk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jnsPelayanan` enum('1','2') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catatan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagRujukan` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_diagRujukan` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipeRujukan` enum('0. Penuh','1. Partial','2. Rujuk Balik') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `poliRujukan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_poliRujukan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rujukan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rujukan`) USING BTREE,
  INDEX `no_sep`(`no_sep`) USING BTREE,
  CONSTRAINT `bridging_rujukan_bpjs_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bridging_sep
-- ----------------------------
DROP TABLE IF EXISTS `bridging_sep`;
CREATE TABLE `bridging_sep`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tglsep` date NULL DEFAULT NULL,
  `tglrujukan` date NULL DEFAULT NULL,
  `no_rujukan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdppkrujukan` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmppkrujukan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdppkpelayanan` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmppkpelayanan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jnspelayanan` enum('1','2') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catatan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagawal` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmdiagnosaawal` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdpolitujuan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmpolitujuan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klsrawat` enum('1','2','3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klsnaik` enum('','1','2','3','4','5','6','7') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pembiayaan` enum('','1','2','3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pjnaikkelas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lakalantas` enum('0','1','2','3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nomr` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_lahir` date NULL DEFAULT NULL,
  `peserta` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jkel` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_kartu` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tglpulang` datetime NULL DEFAULT NULL,
  `asal_rujukan` enum('1. Faskes 1','2. Faskes 2(RS)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `eksekutif` enum('0. Tidak','1.Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cob` enum('0. Tidak','1.Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `notelep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `katarak` enum('0. Tidak','1.Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tglkkl` date NOT NULL,
  `keterangankkl` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suplesi` enum('0. Tidak','1.Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_sep_suplesi` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdprop` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmprop` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdkab` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmkab` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdkec` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmkec` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `noskdp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kddpjp` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmdpdjp` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tujuankunjungan` enum('0','1','2') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `flagprosedur` enum('','0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penunjang` enum('','1','2','3','4','5','6','7','8','9','10','11','12') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asesmenpelayanan` enum('','1','2','3','4','5') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kddpjplayanan` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmdpjplayanan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_sep`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `bridging_sep_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bridging_sep_internal
-- ----------------------------
DROP TABLE IF EXISTS `bridging_sep_internal`;
CREATE TABLE `bridging_sep_internal`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tglsep` date NULL DEFAULT NULL,
  `tglrujukan` date NULL DEFAULT NULL,
  `no_rujukan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdppkrujukan` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmppkrujukan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdppkpelayanan` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmppkpelayanan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jnspelayanan` enum('1','2') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catatan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagawal` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmdiagnosaawal` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdpolitujuan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmpolitujuan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klsrawat` enum('1','2','3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klsnaik` enum('','1','2','3','4','5','6','7') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pembiayaan` enum('','1','2','3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pjnaikkelas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lakalantas` enum('0','1','2','3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nomr` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_lahir` date NULL DEFAULT NULL,
  `peserta` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jkel` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_kartu` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tglpulang` datetime NULL DEFAULT NULL,
  `asal_rujukan` enum('1. Faskes 1','2. Faskes 2(RS)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `eksekutif` enum('0. Tidak','1.Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cob` enum('0. Tidak','1.Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `notelep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `katarak` enum('0. Tidak','1.Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tglkkl` date NOT NULL,
  `keterangankkl` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suplesi` enum('0. Tidak','1.Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_sep_suplesi` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdprop` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmprop` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdkab` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmkab` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdkec` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmkec` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `noskdp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kddpjp` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmdpdjp` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tujuankunjungan` enum('0','1','2') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `flagprosedur` enum('','0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penunjang` enum('','1','2','3','4','5','6','7','8','9','10','11','12') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asesmenpelayanan` enum('','1','2','3','4','5') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kddpjplayanan` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmdpjplayanan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_sep`(`no_sep`) USING BTREE,
  CONSTRAINT `bridging_sep_internal_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bridging_sep_internal_ibfk_2` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bridging_srb_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_srb_bpjs`;
CREATE TABLE `bridging_srb_bpjs`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_srb` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_srb` date NULL DEFAULT NULL,
  `alamat` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kodeprogram` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `namaprogram` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kodedpjp` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmdpjp` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `saran` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_sep`, `no_srb`) USING BTREE,
  CONSTRAINT `bridging_srb_bpjs_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bridging_surat_kontrol_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_surat_kontrol_bpjs`;
CREATE TABLE `bridging_surat_kontrol_bpjs`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_surat` date NOT NULL,
  `no_surat` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_rencana` date NULL DEFAULT NULL,
  `kd_dokter_bpjs` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_dokter_bpjs` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli_bpjs` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_poli_bpjs` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_surat`) USING BTREE,
  INDEX `bridging_surat_kontrol_bpjs_ibfk_1`(`no_sep`) USING BTREE,
  CONSTRAINT `bridging_surat_kontrol_bpjs_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bridging_surat_pri_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_surat_pri_bpjs`;
CREATE TABLE `bridging_surat_pri_bpjs`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_kartu` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_surat` date NOT NULL,
  `no_surat` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_rencana` date NULL DEFAULT NULL,
  `kd_dokter_bpjs` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_dokter_bpjs` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli_bpjs` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_poli_bpjs` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosa` varchar(130) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_surat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `bridging_surat_pri_bpjs_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cacat_fisik
-- ----------------------------
DROP TABLE IF EXISTS `cacat_fisik`;
CREATE TABLE `cacat_fisik`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_cacat` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nama_cacat`(`nama_cacat`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_adime_gizi
-- ----------------------------
DROP TABLE IF EXISTS `catatan_adime_gizi`;
CREATE TABLE `catatan_adime_gizi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `asesmen` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosis` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `intervensi` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `evaluasi` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `instruksi` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_adime_gizi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_adime_gizi_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for catatan_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_perawatan`;
CREATE TABLE `catatan_perawatan`  (
  `tanggal` date NULL DEFAULT NULL,
  `jam` time NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catatan` varchar(700) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `catatan_perawatan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_perawatan_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for databarang
-- ----------------------------
DROP TABLE IF EXISTS `databarang`;
CREATE TABLE `databarang`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama_brng` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_satbesar` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `letak_barang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dasar` double NOT NULL,
  `h_beli` double NULL DEFAULT NULL,
  `ralan` double NULL DEFAULT NULL,
  `kelas1` double NULL DEFAULT NULL,
  `kelas2` double NULL DEFAULT NULL,
  `kelas3` double NULL DEFAULT NULL,
  `utama` double NULL DEFAULT NULL,
  `vip` double NULL DEFAULT NULL,
  `vvip` double NULL DEFAULT NULL,
  `beliluar` double NULL DEFAULT NULL,
  `jualbebas` double NULL DEFAULT NULL,
  `karyawan` double NULL DEFAULT NULL,
  `stokminimal` double NULL DEFAULT NULL,
  `kdjns` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `isi` double NOT NULL,
  `kapasitas` double NOT NULL,
  `expire` date NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_industri` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_kategori` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_golongan` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `kdjns`(`kdjns`) USING BTREE,
  INDEX `nama_brng`(`nama_brng`) USING BTREE,
  INDEX `letak_barang`(`letak_barang`) USING BTREE,
  INDEX `h_beli`(`h_beli`) USING BTREE,
  INDEX `h_distributor`(`ralan`) USING BTREE,
  INDEX `h_grosir`(`kelas1`) USING BTREE,
  INDEX `h_retail`(`kelas2`) USING BTREE,
  INDEX `stok`(`stokminimal`) USING BTREE,
  INDEX `kapasitas`(`kapasitas`) USING BTREE,
  INDEX `kode_industri`(`kode_industri`) USING BTREE,
  INDEX `kelas3`(`kelas3`) USING BTREE,
  INDEX `utama`(`utama`) USING BTREE,
  INDEX `vip`(`vip`) USING BTREE,
  INDEX `vvip`(`vvip`) USING BTREE,
  INDEX `beliluar`(`beliluar`) USING BTREE,
  INDEX `jualbebas`(`jualbebas`) USING BTREE,
  INDEX `karyawan`(`karyawan`) USING BTREE,
  INDEX `expire`(`expire`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `kode_kategori`(`kode_kategori`) USING BTREE,
  INDEX `kode_golongan`(`kode_golongan`) USING BTREE,
  INDEX `kode_satbesar`(`kode_satbesar`) USING BTREE,
  CONSTRAINT `databarang_ibfk_2` FOREIGN KEY (`kdjns`) REFERENCES `jenis` (`kdjns`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_4` FOREIGN KEY (`kode_industri`) REFERENCES `industrifarmasi` (`kode_industri`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_5` FOREIGN KEY (`kode_kategori`) REFERENCES `kategori_barang` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_6` FOREIGN KEY (`kode_golongan`) REFERENCES `golongan_barang` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_7` FOREIGN KEY (`kode_satbesar`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for departemen
-- ----------------------------
DROP TABLE IF EXISTS `departemen`;
CREATE TABLE `departemen`  (
  `dep_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`dep_id`) USING BTREE,
  INDEX `nama`(`nama`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detail_pemberian_obat
-- ----------------------------
DROP TABLE IF EXISTS `detail_pemberian_obat`;
CREATE TABLE `detail_pemberian_obat`  (
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h_beli` double NULL DEFAULT NULL,
  `biaya_obat` double NULL DEFAULT NULL,
  `jml` double NOT NULL,
  `embalase` double NULL DEFAULT NULL,
  `tuslah` double NULL DEFAULT NULL,
  `total` double NOT NULL,
  `status` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_perawatan`, `jam`, `no_rawat`, `kode_brng`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_obat`(`kode_brng`) USING BTREE,
  INDEX `tgl_perawatan`(`tgl_perawatan`) USING BTREE,
  INDEX `jam`(`jam`) USING BTREE,
  INDEX `jml`(`jml`) USING BTREE,
  INDEX `tambahan`(`embalase`) USING BTREE,
  INDEX `total`(`total`) USING BTREE,
  INDEX `biaya_obat`(`biaya_obat`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal`) USING BTREE,
  INDEX `tuslah`(`tuslah`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  CONSTRAINT `detail_pemberian_obat_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pemberian_obat_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pemberian_obat_ibfk_5` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detail_periksa_lab
-- ----------------------------
DROP TABLE IF EXISTS `detail_periksa_lab`;
CREATE TABLE `detail_periksa_lab`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `id_template` int(11) NOT NULL,
  `nilai` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_item` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`, `id_template`) USING BTREE,
  INDEX `id_template`(`id_template`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `tgl_periksa`(`tgl_periksa`) USING BTREE,
  INDEX `jam`(`jam`) USING BTREE,
  INDEX `nilai`(`nilai`) USING BTREE,
  INDEX `nilai_rujukan`(`nilai_rujukan`) USING BTREE,
  INDEX `keterangan`(`keterangan`) USING BTREE,
  INDEX `biaya_item`(`biaya_item`) USING BTREE,
  INDEX `menejemen`(`menejemen`) USING BTREE,
  INDEX `kso`(`kso`) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs`) USING BTREE,
  INDEX `bhp`(`bhp`) USING BTREE,
  INDEX `bagian_perujuk`(`bagian_perujuk`) USING BTREE,
  INDEX `bagian_dokter`(`bagian_dokter`) USING BTREE,
  INDEX `bagian_laborat`(`bagian_laborat`) USING BTREE,
  CONSTRAINT `detail_periksa_lab_ibfk_10` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_ibfk_11` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_ibfk_12` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for diagnosa_pasien
-- ----------------------------
DROP TABLE IF EXISTS `diagnosa_pasien`;
CREATE TABLE `diagnosa_pasien`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_penyakit` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas` tinyint(4) NOT NULL,
  `status_penyakit` enum('Lama','Baru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_penyakit`, `status`) USING BTREE,
  INDEX `kd_penyakit`(`kd_penyakit`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `prioritas`(`prioritas`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `diagnosa_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `diagnosa_pasien_ibfk_2` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for doctor_schedules
-- ----------------------------
DROP TABLE IF EXISTS `doctor_schedules`;
CREATE TABLE `doctor_schedules`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `day_of_week` tinyint(4) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `is_available` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_doctor_schedule`(`doctor_id`, `day_of_week`, `start_time`) USING BTREE,
  INDEX `idx_schedules_doctor_day`(`doctor_id`, `day_of_week`) USING BTREE,
  CONSTRAINT `doctor_schedules_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for doctors
-- ----------------------------
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE `doctors`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `specialization` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `license_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `experience_years` int(11) NULL DEFAULT 0,
  `education` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `consultation_fee` decimal(10, 2) NULL DEFAULT 0.00,
  `status` enum('active','inactive','on_leave') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'active',
  `schedule_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `license_number`(`license_number`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `idx_doctors_specialization`(`specialization`) USING BTREE,
  INDEX `idx_doctors_status`(`status`) USING BTREE,
  INDEX `idx_doctors_license`(`license_number`) USING BTREE,
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dokter
-- ----------------------------
DROP TABLE IF EXISTS `dokter`;
CREATE TABLE `dokter`  (
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_dokter` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tmp_lahir` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `gol_drh` enum('A','B','O','AB','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `agama` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `almt_tgl` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_sps` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alumni` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_ijn_praktek` varchar(120) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_dokter`) USING BTREE,
  INDEX `kd_sps`(`kd_sps`) USING BTREE,
  INDEX `nm_dokter`(`nm_dokter`) USING BTREE,
  INDEX `jk`(`jk`) USING BTREE,
  INDEX `tmp_lahir`(`tmp_lahir`) USING BTREE,
  INDEX `tgl_lahir`(`tgl_lahir`) USING BTREE,
  INDEX `gol_drh`(`gol_drh`) USING BTREE,
  INDEX `agama`(`agama`) USING BTREE,
  INDEX `almt_tgl`(`almt_tgl`) USING BTREE,
  INDEX `no_telp`(`no_telp`) USING BTREE,
  INDEX `stts_nikah`(`stts_nikah`) USING BTREE,
  INDEX `alumni`(`alumni`) USING BTREE,
  INDEX `no_ijn_praktek`(`no_ijn_praktek`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  CONSTRAINT `dokter_ibfk_2` FOREIGN KEY (`kd_sps`) REFERENCES `spesialis` (`kd_sps`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `dokter_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `pegawai` (`nik`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dpjp_ranap
-- ----------------------------
DROP TABLE IF EXISTS `dpjp_ranap`;
CREATE TABLE `dpjp_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_dokter`) USING BTREE,
  INDEX `dpjp_ranap_ibfk_2`(`kd_dokter`) USING BTREE,
  CONSTRAINT `dpjp_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `dpjp_ranap_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for emergency_index
-- ----------------------------
DROP TABLE IF EXISTS `emergency_index`;
CREATE TABLE `emergency_index`  (
  `kode_emergency` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_emergency` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `indek` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`kode_emergency`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uuid`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for gambar_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `gambar_radiologi`;
CREATE TABLE `gambar_radiologi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `lokasi_gambar` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_periksa`, `jam`, `lokasi_gambar`) USING BTREE,
  CONSTRAINT `gambar_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for golongan_barang
-- ----------------------------
DROP TABLE IF EXISTS `golongan_barang`;
CREATE TABLE `golongan_barang`  (
  `kode` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gudangbarang
-- ----------------------------
DROP TABLE IF EXISTS `gudangbarang`;
CREATE TABLE `gudangbarang`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `stok` double NOT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode_brng`, `kd_bangsal`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `stok`(`stok`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal`) USING BTREE,
  CONSTRAINT `gudangbarang_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gudangbarang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hasil_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `hasil_radiologi`;
CREATE TABLE `hasil_radiologi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `hasil` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `hasil_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for icd9
-- ----------------------------
DROP TABLE IF EXISTS `icd9`;
CREATE TABLE `icd9`  (
  `kode` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `deskripsi_panjang` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `deskripsi_pendek` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for industrifarmasi
-- ----------------------------
DROP TABLE IF EXISTS `industrifarmasi`;
CREATE TABLE `industrifarmasi`  (
  `kode_industri` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama_industri` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kota` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_industri`) USING BTREE,
  INDEX `nama_industri`(`nama_industri`) USING BTREE,
  INDEX `alamat`(`alamat`) USING BTREE,
  INDEX `kota`(`kota`) USING BTREE,
  INDEX `no_telp`(`no_telp`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventaris
-- ----------------------------
DROP TABLE IF EXISTS `inventaris`;
CREATE TABLE `inventaris`  (
  `no_inventaris` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_barang` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `asal_barang` enum('Beli','Bantuan','Hibah','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_pengadaan` date NULL DEFAULT NULL,
  `harga` double NULL DEFAULT NULL,
  `status_barang` enum('Ada','Rusak','Hilang','Perbaikan','Dipinjam','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_ruang` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rak` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_box` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_inventaris`) USING BTREE,
  INDEX `kode_barang`(`kode_barang`) USING BTREE,
  INDEX `kd_ruang`(`id_ruang`) USING BTREE,
  INDEX `asal_barang`(`asal_barang`) USING BTREE,
  INDEX `tgl_pengadaan`(`tgl_pengadaan`) USING BTREE,
  INDEX `harga`(`harga`) USING BTREE,
  INDEX `status_barang`(`status_barang`) USING BTREE,
  INDEX `no_rak`(`no_rak`) USING BTREE,
  INDEX `no_box`(`no_box`) USING BTREE,
  CONSTRAINT `inventaris_ibfk_1` FOREIGN KEY (`kode_barang`) REFERENCES `inventaris_barang` (`kode_barang`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_ibfk_2` FOREIGN KEY (`id_ruang`) REFERENCES `inventaris_ruang` (`id_ruang`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventaris_barang
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_barang`;
CREATE TABLE `inventaris_barang`  (
  `kode_barang` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_barang` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml_barang` int(11) NULL DEFAULT NULL,
  `kode_produsen` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_merk` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `thn_produksi` year NULL DEFAULT NULL,
  `isbn` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_kategori` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_jenis` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_barang`) USING BTREE,
  INDEX `kode_produsen`(`kode_produsen`) USING BTREE,
  INDEX `id_merk`(`id_merk`) USING BTREE,
  INDEX `id_kategori`(`id_kategori`) USING BTREE,
  INDEX `id_jenis`(`id_jenis`) USING BTREE,
  INDEX `nama_barang`(`nama_barang`) USING BTREE,
  INDEX `jml_barang`(`jml_barang`) USING BTREE,
  INDEX `thn_produksi`(`thn_produksi`) USING BTREE,
  INDEX `isbn`(`isbn`) USING BTREE,
  CONSTRAINT `inventaris_barang_ibfk_5` FOREIGN KEY (`kode_produsen`) REFERENCES `inventaris_produsen` (`kode_produsen`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_6` FOREIGN KEY (`id_merk`) REFERENCES `inventaris_merk` (`id_merk`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_7` FOREIGN KEY (`id_kategori`) REFERENCES `inventaris_kategori` (`id_kategori`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_8` FOREIGN KEY (`id_jenis`) REFERENCES `inventaris_jenis` (`id_jenis`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventaris_jenis
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_jenis`;
CREATE TABLE `inventaris_jenis`  (
  `id_jenis` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_jenis` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_jenis`) USING BTREE,
  INDEX `nama_jenis`(`nama_jenis`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventaris_kategori
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_kategori`;
CREATE TABLE `inventaris_kategori`  (
  `id_kategori` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_kategori` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_kategori`) USING BTREE,
  INDEX `nama_kategori`(`nama_kategori`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventaris_merk
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_merk`;
CREATE TABLE `inventaris_merk`  (
  `id_merk` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_merk` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_merk`) USING BTREE,
  INDEX `nama_merk`(`nama_merk`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventaris_peminjaman
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_peminjaman`;
CREATE TABLE `inventaris_peminjaman`  (
  `peminjam` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tlp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_inventaris` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_pinjam` date NOT NULL DEFAULT '0000-00-00',
  `tgl_kembali` date NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `status_pinjam` enum('Masih Dipinjam','Sudah Kembali') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`peminjam`, `no_inventaris`, `tgl_pinjam`, `nip`) USING BTREE,
  INDEX `no_inventaris`(`no_inventaris`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `tgl_kembali`(`tgl_kembali`) USING BTREE,
  INDEX `status_pinjam`(`status_pinjam`) USING BTREE,
  CONSTRAINT `inventaris_peminjaman_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `inventaris_peminjaman_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for inventaris_produsen
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_produsen`;
CREATE TABLE `inventaris_produsen`  (
  `kode_produsen` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_produsen` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat_produsen` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `website_produsen` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_produsen`) USING BTREE,
  INDEX `nama_produsen`(`nama_produsen`) USING BTREE,
  INDEX `alamat_produsen`(`alamat_produsen`) USING BTREE,
  INDEX `no_telp`(`no_telp`) USING BTREE,
  INDEX `email`(`email`) USING BTREE,
  INDEX `website_produsen`(`website_produsen`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventaris_ruang
-- ----------------------------
DROP TABLE IF EXISTS `inventaris_ruang`;
CREATE TABLE `inventaris_ruang`  (
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_ruang` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_ruang`) USING BTREE,
  INDEX `nama_ruang`(`nama_ruang`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jabatan
-- ----------------------------
DROP TABLE IF EXISTS `jabatan`;
CREATE TABLE `jabatan`  (
  `kd_jbtn` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nm_jbtn` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_jbtn`) USING BTREE,
  INDEX `nm_jbtn`(`nm_jbtn`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jadwal
-- ----------------------------
DROP TABLE IF EXISTS `jadwal`;
CREATE TABLE `jadwal`  (
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hari_kerja` enum('SENIN','SELASA','RABU','KAMIS','JUMAT','SABTU','AKHAD') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'SENIN',
  `jam_mulai` time NOT NULL DEFAULT '00:00:00',
  `jam_selesai` time NULL DEFAULT NULL,
  `kd_poli` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kuota` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`, `hari_kerja`, `jam_mulai`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `kd_poli`(`kd_poli`) USING BTREE,
  INDEX `jam_mulai`(`jam_mulai`) USING BTREE,
  INDEX `jam_selesai`(`jam_selesai`) USING BTREE,
  CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jadwal_ibfk_2` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jadwal_pegawai
-- ----------------------------
DROP TABLE IF EXISTS `jadwal_pegawai`;
CREATE TABLE `jadwal_pegawai`  (
  `id` int(11) NOT NULL,
  `tahun` year NOT NULL,
  `bulan` enum('01','02','03','04','05','06','07','08','09','10','11','12') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h1` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h2` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h3` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h4` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h5` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h6` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h7` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h8` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h9` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h10` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h11` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h12` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h13` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h14` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h15` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h16` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h17` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h18` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h19` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h20` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h21` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h22` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h23` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h24` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h25` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h26` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h27` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h28` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h29` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h30` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h31` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`, `tahun`, `bulan`) USING BTREE,
  INDEX `h1`(`h1`) USING BTREE,
  INDEX `h2`(`h2`) USING BTREE,
  INDEX `h3`(`h3`) USING BTREE,
  INDEX `h4`(`h4`) USING BTREE,
  INDEX `h30`(`h30`) USING BTREE,
  INDEX `h31`(`h31`) USING BTREE,
  INDEX `h29`(`h29`) USING BTREE,
  INDEX `h28`(`h28`) USING BTREE,
  INDEX `h18`(`h18`) USING BTREE,
  INDEX `h9`(`h9`) USING BTREE,
  CONSTRAINT `jadwal_pegawai_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jadwal_tambahan
-- ----------------------------
DROP TABLE IF EXISTS `jadwal_tambahan`;
CREATE TABLE `jadwal_tambahan`  (
  `id` int(11) NOT NULL,
  `tahun` year NOT NULL,
  `bulan` enum('01','02','03','04','05','06','07','08','09','10','11','12') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h1` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h2` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h3` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h4` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h5` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h6` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h7` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h8` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h9` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h10` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h11` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h12` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h13` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h14` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h15` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h16` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h17` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h18` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h19` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h20` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h21` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h22` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h23` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h24` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h25` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h26` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h27` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h28` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h29` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h30` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h31` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`, `tahun`, `bulan`) USING BTREE,
  CONSTRAINT `jadwal_tambahan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jam_jaga
-- ----------------------------
DROP TABLE IF EXISTS `jam_jaga`;
CREATE TABLE `jam_jaga`  (
  `no_id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`no_id`) USING BTREE,
  UNIQUE INDEX `dep_id_2`(`dep_id`, `shift`) USING BTREE,
  INDEX `dep_id`(`dep_id`) USING BTREE,
  INDEX `shift`(`shift`) USING BTREE,
  INDEX `jam_masuk`(`jam_masuk`) USING BTREE,
  INDEX `jam_pulang`(`jam_pulang`) USING BTREE,
  CONSTRAINT `jam_jaga_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departemen` (`dep_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jam_masuk
-- ----------------------------
DROP TABLE IF EXISTS `jam_masuk`;
CREATE TABLE `jam_masuk`  (
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`shift`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jenis
-- ----------------------------
DROP TABLE IF EXISTS `jenis`;
CREATE TABLE `jenis`  (
  `kdjns` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kdjns`) USING BTREE,
  INDEX `nama`(`nama`) USING BTREE,
  INDEX `keterangan`(`keterangan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jnj_jabatan
-- ----------------------------
DROP TABLE IF EXISTS `jnj_jabatan`;
CREATE TABLE `jnj_jabatan`  (
  `kode` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tnj` double NOT NULL,
  `indek` tinyint(4) NOT NULL,
  PRIMARY KEY (`kode`) USING BTREE,
  INDEX `nama`(`nama`) USING BTREE,
  INDEX `tnj`(`tnj`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jns_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan`;
CREATE TABLE `jns_perawatan`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_kategori` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `material` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  `tarif_tindakanpr` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `total_byrdr` double NULL DEFAULT NULL,
  `total_byrpr` double NULL DEFAULT NULL,
  `total_byrdrpr` double NOT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_poli` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `kd_kategori`(`kd_kategori`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  INDEX `kd_poli`(`kd_poli`) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan`) USING BTREE,
  INDEX `material`(`material`) USING BTREE,
  INDEX `tarif_tindakandr`(`tarif_tindakandr`) USING BTREE,
  INDEX `tarif_tindakanpr`(`tarif_tindakanpr`) USING BTREE,
  INDEX `total_byrdr`(`total_byrdr`) USING BTREE,
  INDEX `total_byrpr`(`total_byrpr`) USING BTREE,
  INDEX `kso`(`kso`) USING BTREE,
  INDEX `menejemen`(`menejemen`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `total_byrdrpr`(`total_byrdrpr`) USING BTREE,
  INDEX `bhp`(`bhp`) USING BTREE,
  CONSTRAINT `jns_perawatan_ibfk_1` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori_perawatan` (`kd_kategori`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jns_perawatan_inap
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_inap`;
CREATE TABLE `jns_perawatan_inap`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_kategori` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `material` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  `tarif_tindakanpr` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `total_byrdr` double NULL DEFAULT NULL,
  `total_byrpr` double NULL DEFAULT NULL,
  `total_byrdrpr` double NOT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kelas` enum('-','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal`) USING BTREE,
  INDEX `kd_kategori`(`kd_kategori`) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan`) USING BTREE,
  INDEX `material`(`material`) USING BTREE,
  INDEX `tarif_tindakandr`(`tarif_tindakandr`) USING BTREE,
  INDEX `tarif_tindakanpr`(`tarif_tindakanpr`) USING BTREE,
  INDEX `total_byrdr`(`total_byrdr`) USING BTREE,
  INDEX `total_byrpr`(`total_byrpr`) USING BTREE,
  INDEX `bhp`(`bhp`) USING BTREE,
  INDEX `kso`(`kso`) USING BTREE,
  INDEX `menejemen`(`menejemen`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `total_byrdrpr`(`total_byrdrpr`) USING BTREE,
  CONSTRAINT `jns_perawatan_inap_ibfk_7` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori_perawatan` (`kd_kategori`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_inap_ibfk_8` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_inap_ibfk_9` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jns_perawatan_lab
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_lab`;
CREATE TABLE `jns_perawatan_lab`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bagian_rs` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `total_byr` double NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kategori` enum('PK','PA','MB') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan`) USING BTREE,
  INDEX `tarif_perujuk`(`tarif_perujuk`) USING BTREE,
  INDEX `tarif_tindakan_dokter`(`tarif_tindakan_dokter`) USING BTREE,
  INDEX `tarif_tindakan_petugas`(`tarif_tindakan_petugas`) USING BTREE,
  INDEX `total_byr`(`total_byr`) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs`) USING BTREE,
  INDEX `bhp`(`bhp`) USING BTREE,
  INDEX `kso`(`kso`) USING BTREE,
  INDEX `menejemen`(`menejemen`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  CONSTRAINT `jns_perawatan_lab_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jns_perawatan_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `jns_perawatan_radiologi`;
CREATE TABLE `jns_perawatan_radiologi`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bagian_rs` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `total_byr` double NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan`) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs`) USING BTREE,
  INDEX `tarif_perujuk`(`tarif_perujuk`) USING BTREE,
  INDEX `tarif_tindakan_dokter`(`tarif_tindakan_dokter`) USING BTREE,
  INDEX `tarif_tindakan_petugas`(`tarif_tindakan_petugas`) USING BTREE,
  INDEX `total_byr`(`total_byr`) USING BTREE,
  INDEX `bhp`(`bhp`) USING BTREE,
  INDEX `kso`(`kso`) USING BTREE,
  INDEX `menejemen`(`menejemen`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  CONSTRAINT `jns_perawatan_radiologi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int(11) NULL DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED NULL DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for kabupaten
-- ----------------------------
DROP TABLE IF EXISTS `kabupaten`;
CREATE TABLE `kabupaten`  (
  `kd_kab` int(11) NOT NULL AUTO_INCREMENT,
  `nm_kab` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_kab`) USING BTREE,
  UNIQUE INDEX `nm_kab`(`nm_kab`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kamar
-- ----------------------------
DROP TABLE IF EXISTS `kamar`;
CREATE TABLE `kamar`  (
  `kd_kamar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `trf_kamar` double NULL DEFAULT NULL,
  `status` enum('ISI','KOSONG','DIBERSIHKAN','DIBOOKING') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `statusdata` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_kamar`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal`) USING BTREE,
  INDEX `trf_kamar`(`trf_kamar`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `kelas`(`kelas`) USING BTREE,
  INDEX `statusdata`(`statusdata`) USING BTREE,
  CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kamar_inap
-- ----------------------------
DROP TABLE IF EXISTS `kamar_inap`;
CREATE TABLE `kamar_inap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_kamar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `trf_kamar` double NULL DEFAULT NULL,
  `diagnosa_awal` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosa_akhir` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_masuk` date NOT NULL DEFAULT '0000-00-00',
  `jam_masuk` time NOT NULL DEFAULT '00:00:00',
  `tgl_keluar` date NULL DEFAULT NULL,
  `jam_keluar` time NULL DEFAULT NULL,
  `lama` double NULL DEFAULT NULL,
  `ttl_biaya` double NULL DEFAULT NULL,
  `stts_pulang` enum('Sehat','Rujuk','APS','+','Meninggal','Sembuh','Membaik','Pulang Paksa','-','Pindah Kamar','Status Belum Lengkap','Atas Persetujuan Dokter','Atas Permintaan Sendiri','Isoman','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_masuk`, `jam_masuk`) USING BTREE,
  INDEX `kd_kamar`(`kd_kamar`) USING BTREE,
  INDEX `diagnosa_awal`(`diagnosa_awal`) USING BTREE,
  INDEX `diagnosa_akhir`(`diagnosa_akhir`) USING BTREE,
  INDEX `tgl_keluar`(`tgl_keluar`) USING BTREE,
  INDEX `jam_keluar`(`jam_keluar`) USING BTREE,
  INDEX `lama`(`lama`) USING BTREE,
  INDEX `ttl_biaya`(`ttl_biaya`) USING BTREE,
  INDEX `stts_pulang`(`stts_pulang`) USING BTREE,
  INDEX `trf_kamar`(`trf_kamar`) USING BTREE,
  CONSTRAINT `kamar_inap_ibfk_2` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kamar_inap_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kategori_barang
-- ----------------------------
DROP TABLE IF EXISTS `kategori_barang`;
CREATE TABLE `kategori_barang`  (
  `kode` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kategori_penyakit
-- ----------------------------
DROP TABLE IF EXISTS `kategori_penyakit`;
CREATE TABLE `kategori_penyakit`  (
  `kd_ktg` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_kategori` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ciri_umum` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_ktg`) USING BTREE,
  INDEX `nm_kategori`(`nm_kategori`) USING BTREE,
  INDEX `ciri_umum`(`ciri_umum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kategori_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `kategori_perawatan`;
CREATE TABLE `kategori_perawatan`  (
  `kd_kategori` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_kategori` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_kategori`) USING BTREE,
  INDEX `nm_kategori`(`nm_kategori`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kecamatan
-- ----------------------------
DROP TABLE IF EXISTS `kecamatan`;
CREATE TABLE `kecamatan`  (
  `kd_kec` int(11) NOT NULL AUTO_INCREMENT,
  `nm_kec` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_kec`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kelompok_jabatan
-- ----------------------------
DROP TABLE IF EXISTS `kelompok_jabatan`;
CREATE TABLE `kelompok_jabatan`  (
  `kode_kelompok` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_kelompok` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `indek` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`kode_kelompok`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kelurahan
-- ----------------------------
DROP TABLE IF EXISTS `kelurahan`;
CREATE TABLE `kelurahan`  (
  `kd_kel` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_kel` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_kel`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kodesatuan
-- ----------------------------
DROP TABLE IF EXISTS `kodesatuan`;
CREATE TABLE `kodesatuan`  (
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `satuan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_sat`) USING BTREE,
  INDEX `satuan`(`satuan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for laporan_operasi
-- ----------------------------
DROP TABLE IF EXISTS `laporan_operasi`;
CREATE TABLE `laporan_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `diagnosa_preop` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_postop` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jaringan_dieksekusi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `selesaioperasi` datetime NOT NULL,
  `permintaan_pa` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `laporan_operasi` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  CONSTRAINT `laporan_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for maping_dokter_dpjpvclaim
-- ----------------------------
DROP TABLE IF EXISTS `maping_dokter_dpjpvclaim`;
CREATE TABLE `maping_dokter_dpjpvclaim`  (
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter_bpjs` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_dokter_bpjs` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`) USING BTREE,
  CONSTRAINT `maping_dokter_dpjpvclaim_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for maping_dokter_pcare
-- ----------------------------
DROP TABLE IF EXISTS `maping_dokter_pcare`;
CREATE TABLE `maping_dokter_pcare`  (
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter_pcare` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_dokter_pcare` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`) USING BTREE,
  CONSTRAINT `maping_dokter_pcare_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for maping_poli_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `maping_poli_bpjs`;
CREATE TABLE `maping_poli_bpjs`  (
  `kd_poli_rs` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_poli_bpjs` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_poli_bpjs` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_poli_rs`) USING BTREE,
  UNIQUE INDEX `kd_poli_bpjs`(`kd_poli_bpjs`) USING BTREE,
  CONSTRAINT `maping_poli_bpjs_ibfk_1` FOREIGN KEY (`kd_poli_rs`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for maping_poliklinik_pcare
-- ----------------------------
DROP TABLE IF EXISTS `maping_poliklinik_pcare`;
CREATE TABLE `maping_poliklinik_pcare`  (
  `kd_poli_rs` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_poli_pcare` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_poli_pcare` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_poli_rs`) USING BTREE,
  CONSTRAINT `maping_poliklinik_pcare_ibfk_1` FOREIGN KEY (`kd_poli_rs`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for master_aturan_pakai
-- ----------------------------
DROP TABLE IF EXISTS `master_aturan_pakai`;
CREATE TABLE `master_aturan_pakai`  (
  `aturan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`aturan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for master_berkas_digital
-- ----------------------------
DROP TABLE IF EXISTS `master_berkas_digital`;
CREATE TABLE `master_berkas_digital`  (
  `kode` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for master_masalah_keperawatan
-- ----------------------------
DROP TABLE IF EXISTS `master_masalah_keperawatan`;
CREATE TABLE `master_masalah_keperawatan`  (
  `kode_masalah` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_masalah` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_masalah`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for medical_records
-- ----------------------------
DROP TABLE IF EXISTS `medical_records`;
CREATE TABLE `medical_records`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `booking_id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `diagnosis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `treatment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `prescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `vital_signs` json NULL,
  `follow_up_date` date NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_records_patient`(`patient_id`) USING BTREE,
  INDEX `idx_records_doctor`(`doctor_id`) USING BTREE,
  INDEX `idx_records_booking`(`booking_id`) USING BTREE,
  CONSTRAINT `medical_records_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `medical_records_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `medical_records_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for metode_racik
-- ----------------------------
DROP TABLE IF EXISTS `metode_racik`;
CREATE TABLE `metode_racik`  (
  `kd_racik` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_racik` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_racik`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mlite_akun_kegiatan
-- ----------------------------
DROP TABLE IF EXISTS `mlite_akun_kegiatan`;
CREATE TABLE `mlite_akun_kegiatan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kegiatan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_rek` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_antrian_loket
-- ----------------------------
DROP TABLE IF EXISTS `mlite_antrian_loket`;
CREATE TABLE `mlite_antrian_loket`  (
  `kd` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `noantrian` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `no_rkm_medis` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `postdate` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL DEFAULT '00:00:00',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `loket` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`kd`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_antrian_referensi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_antrian_referensi`;
CREATE TABLE `mlite_antrian_referensi`  (
  `tanggal_periksa` date NOT NULL,
  `no_rkm_medis` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nomor_kartu` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nomor_referensi` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kodebooking` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `jenis_kunjungan` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status_kirim` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keterangan` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_antrian_referensi_batal
-- ----------------------------
DROP TABLE IF EXISTS `mlite_antrian_referensi_batal`;
CREATE TABLE `mlite_antrian_referensi_batal`  (
  `tanggal_batal` date NOT NULL,
  `nomor_referensi` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kodebooking` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `keterangan` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_antrian_referensi_taskid
-- ----------------------------
DROP TABLE IF EXISTS `mlite_antrian_referensi_taskid`;
CREATE TABLE `mlite_antrian_referensi_taskid`  (
  `tanggal_periksa` date NOT NULL,
  `nomor_referensi` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `taskid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `waktu` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keterangan` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_apamregister
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apamregister`;
CREATE TABLE `mlite_apamregister`  (
  `nama_lengkap` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nomor_ktp` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nomor_telepon` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mlite_api_key
-- ----------------------------
DROP TABLE IF EXISTS `mlite_api_key`;
CREATE TABLE `mlite_api_key`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_key` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `username` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `method` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ip_range` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `exp_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mlite_api_key_ibfk_1`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_apotek_online_log
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apotek_online_log`;
CREATE TABLE `mlite_apotek_online_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `noresep` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_kirim` datetime NOT NULL,
  `status` enum('success','error') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `response_resep` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `response_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `request` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `tanggal_kirim`(`tanggal_kirim`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_apotek_online_maping_obat
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apotek_online_maping_obat`;
CREATE TABLE `mlite_apotek_online_maping_obat`  (
  `kode_brng` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kd_obat_bpjs` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nama_obat_bpjs` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`kode_brng`) USING BTREE,
  INDEX `kd_obat_bpjs`(`kd_obat_bpjs`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_apotek_online_resep_response_log
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apotek_online_resep_response_log`;
CREATE TABLE `mlite_apotek_online_resep_response_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `no_sep_kunjungan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `no_kartu` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `faskes_asal` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `no_apotik` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `no_resep` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tgl_resep` date NULL DEFAULT NULL,
  `kd_jns_obat` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `by_tag_rsp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `by_ver_rsp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tgl_entry` date NULL DEFAULT NULL,
  `meta_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `meta_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `raw_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tanggal_simpan` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_no_rawat`(`no_rawat`) USING BTREE,
  INDEX `idx_no_sep_kunjungan`(`no_sep_kunjungan`) USING BTREE,
  INDEX `idx_no_resep`(`no_resep`) USING BTREE,
  INDEX `idx_tanggal_simpan`(`tanggal_simpan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_apotek_online_sep_data
-- ----------------------------
DROP TABLE IF EXISTS `mlite_apotek_online_sep_data`;
CREATE TABLE `mlite_apotek_online_sep_data`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_sep` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `faskes_asal_resep` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nm_faskes_asal_resep` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `no_kartu` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_peserta` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `jns_kelamin` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `pisat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kd_jenis_peserta` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nm_jenis_peserta` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kode_bu` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_bu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tgl_sep` date NULL DEFAULT NULL,
  `tgl_plg_sep` date NULL DEFAULT NULL,
  `jns_pelayanan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nm_diag` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `poli` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `flag_prb` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_prb` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kode_dokter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nama_dokter` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tanggal_simpan` datetime NOT NULL,
  `user_simpan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `raw_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `no_rawat` varchar(17) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `no_sep`(`no_sep`) USING BTREE,
  INDEX `no_kartu`(`no_kartu`) USING BTREE,
  INDEX `nama_peserta`(`nama_peserta`) USING BTREE,
  INDEX `tanggal_simpan`(`tanggal_simpan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_billing
-- ----------------------------
DROP TABLE IF EXISTS `mlite_billing`;
CREATE TABLE `mlite_billing`  (
  `id_billing` int(11) NOT NULL AUTO_INCREMENT,
  `kd_billing` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `jumlah_total` int(11) NOT NULL,
  `potongan` int(11) NOT NULL,
  `jumlah_harus_bayar` int(11) NOT NULL,
  `jumlah_bayar` int(11) NOT NULL,
  `tgl_billing` date NOT NULL,
  `jam_billing` time NOT NULL,
  `id_user` int(11) NOT NULL,
  `keterangan` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_billing`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_bridging_pcare
-- ----------------------------
DROP TABLE IF EXISTS `mlite_bridging_pcare`;
CREATE TABLE `mlite_bridging_pcare`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_rawat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `no_rkm_medis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tgl_daftar` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nomor_kunjungan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_provider_peserta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nomor_jaminan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_poli` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_poli` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kunjungan_sakit` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `sistole` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `diastole` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nadi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `respirasi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tinggi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `berat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `lingkar_perut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `rujuk_balik` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `subyektif` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_tkp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nomor_urut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_kesadaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_kesadaran` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `terapi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_status_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_status_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tgl_pulang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tgl_kunjungan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_dokter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_dokter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_diagnosa1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_diagnosa1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_diagnosa2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_diagnosa2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_diagnosa3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_diagnosa3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `tgl_estimasi_rujuk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_ppk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_ppk` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_spesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_spesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_subspesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_subspesialis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_sarana` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_sarana` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_referensikhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_referensikhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_faskeskhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_faskeskhusus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `alasan_tacc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status_kirim` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `kode_alergi_makanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_alergi_makanan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_alergi_udara` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_alergi_udara` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_alergi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_alergi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kode_prognosa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nama_prognosa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `terapi_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `terapi_non_obat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mlite_detailjurnal
-- ----------------------------
DROP TABLE IF EXISTS `mlite_detailjurnal`;
CREATE TABLE `mlite_detailjurnal`  (
  `no_jurnal` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `arus_kas` int(11) NOT NULL,
  `debet` double NOT NULL,
  `kredit` double NOT NULL,
  INDEX `no_jurnal`(`no_jurnal`) USING BTREE,
  INDEX `kd_rek`(`kd_rek`) USING BTREE,
  INDEX `debet`(`debet`) USING BTREE,
  INDEX `kredit`(`kredit`) USING BTREE,
  CONSTRAINT `mlite_detailjurnal_ibfk_1` FOREIGN KEY (`no_jurnal`) REFERENCES `mlite_jurnal` (`no_jurnal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mlite_detailjurnal_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `mlite_rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_disabled_menu
-- ----------------------------
DROP TABLE IF EXISTS `mlite_disabled_menu`;
CREATE TABLE `mlite_disabled_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `module` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `can_create` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'false',
  `can_read` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'false',
  `can_update` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'false',
  `can_delete` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'false',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user`(`user`, `module`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_duitku
-- ----------------------------
DROP TABLE IF EXISTS `mlite_duitku`;
CREATE TABLE `mlite_duitku`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` datetime NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `paymentUrl` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `merchantCode` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `reference` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `vaNumber` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `amount` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusCode` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusMessage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `reference`(`reference`) USING BTREE,
  INDEX `mlite_duitku_ibfk_1`(`no_rkm_medis`) USING BTREE,
  CONSTRAINT `mlite_duitku_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_geolocation_presensi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_geolocation_presensi`;
CREATE TABLE `mlite_geolocation_presensi`  (
  `id` int(11) NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `latitude` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `longitude` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `mlite_geolocation_presensi_ibfk_1`(`id`) USING BTREE,
  CONSTRAINT `mlite_geolocation_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_jurnal
-- ----------------------------
DROP TABLE IF EXISTS `mlite_jurnal`;
CREATE TABLE `mlite_jurnal`  (
  `no_jurnal` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_bukti` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_jurnal` date NULL DEFAULT NULL,
  `jenis` enum('U','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kegiatan` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(350) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_jurnal`) USING BTREE,
  INDEX `no_bukti`(`no_bukti`) USING BTREE,
  INDEX `tgl_jurnal`(`tgl_jurnal`) USING BTREE,
  INDEX `jenis`(`jenis`) USING BTREE,
  INDEX `keterangan`(`keterangan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_login_attempts
-- ----------------------------
DROP TABLE IF EXISTS `mlite_login_attempts`;
CREATE TABLE `mlite_login_attempts`  (
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `attempts` int(11) NOT NULL,
  `expires` int(11) NOT NULL DEFAULT 0
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_loinc_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_loinc_radiologi`;
CREATE TABLE `mlite_loinc_radiologi`  (
  `No` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Kategori` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `NamaPemeriksaan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `PermintaanHasil` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Code` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Display` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Component` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Property` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Timing` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `System` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Scale` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `Method` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `UnitOfMeasure` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `CodeSystem` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `BodySiteCode` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `BodySiteDisplay` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `BodySiteCodeSystem` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`Code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_modules
-- ----------------------------
DROP TABLE IF EXISTS `mlite_modules`;
CREATE TABLE `mlite_modules`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dir` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sequence` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 80 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_news
-- ----------------------------
DROP TABLE IF EXISTS `mlite_news`;
CREATE TABLE `mlite_news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `slug` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `intro` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `cover_photo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` int(11) NOT NULL,
  `comments` int(11) NULL DEFAULT 1,
  `markdown` int(11) NULL DEFAULT 0,
  `published_at` int(11) NULL DEFAULT 0,
  `updated_at` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_news_tags
-- ----------------------------
DROP TABLE IF EXISTS `mlite_news_tags`;
CREATE TABLE `mlite_news_tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `slug` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_news_tags_relationship
-- ----------------------------
DROP TABLE IF EXISTS `mlite_news_tags_relationship`;
CREATE TABLE `mlite_news_tags_relationship`  (
  `news_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  INDEX `mlite_news_tags_relationship_ibfk_1`(`news_id`) USING BTREE,
  INDEX `tag_id`(`tag_id`) USING BTREE,
  CONSTRAINT `mlite_news_tags_relationship_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `mlite_news` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `mlite_news_tags_relationship_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `mlite_news_tags` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_notifications
-- ----------------------------
DROP TABLE IF EXISTS `mlite_notifications`;
CREATE TABLE `mlite_notifications`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `judul` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pesan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `no_rkm_medis` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'unread',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_odontogram
-- ----------------------------
DROP TABLE IF EXISTS `mlite_odontogram`;
CREATE TABLE `mlite_odontogram`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_rkm_medis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pemeriksaan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kondisi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `catatan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_ohis
-- ----------------------------
DROP TABLE IF EXISTS `mlite_ohis`;
CREATE TABLE `mlite_ohis`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_rkm_medis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `d_16` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `d_11` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `d_26` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `d_36` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `d_31` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `d_46` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `c_16` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `c_11` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `c_26` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `c_36` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `c_31` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `c_46` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `debris` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `calculus` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `nilai` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `kriteria` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `id_user` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tgl_input` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_pengaduan
-- ----------------------------
DROP TABLE IF EXISTS `mlite_pengaduan`;
CREATE TABLE `mlite_pengaduan`  (
  `id` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pesan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  CONSTRAINT `mlite_pengaduan_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_pengaduan_detail
-- ----------------------------
DROP TABLE IF EXISTS `mlite_pengaduan_detail`;
CREATE TABLE `mlite_pengaduan_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pengaduan_id` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pesan` varchar(225) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pengaduan_detail_ibfk_1`(`pengaduan_id`) USING BTREE,
  CONSTRAINT `mlite_pengaduan_detail_ibfk_1` FOREIGN KEY (`pengaduan_id`) REFERENCES `mlite_pengaduan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mlite_penjualan
-- ----------------------------
DROP TABLE IF EXISTS `mlite_penjualan`;
CREATE TABLE `mlite_penjualan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pembeli` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `alamat_pembeli` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nomor_telepon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `id_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `keterangan` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_penjualan_barang
-- ----------------------------
DROP TABLE IF EXISTS `mlite_penjualan_barang`;
CREATE TABLE `mlite_penjualan_barang`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stok` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `harga` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_penjualan_billing
-- ----------------------------
DROP TABLE IF EXISTS `mlite_penjualan_billing`;
CREATE TABLE `mlite_penjualan_billing`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_penjualan` int(11) NOT NULL,
  `jumlah_total` int(11) NOT NULL,
  `potongan` int(11) NULL DEFAULT NULL,
  `jumlah_harus_bayar` int(11) NOT NULL,
  `jumlah_bayar` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `id_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_penjualan_detail
-- ----------------------------
DROP TABLE IF EXISTS `mlite_penjualan_detail`;
CREATE TABLE `mlite_penjualan_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_penjualan` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `harga` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga_total` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `id_user` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_query_logs
-- ----------------------------
DROP TABLE IF EXISTS `mlite_query_logs`;
CREATE TABLE `mlite_query_logs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sql_text` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bindings` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `error_message` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `username` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 132 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_rekening
-- ----------------------------
DROP TABLE IF EXISTS `mlite_rekening`;
CREATE TABLE `mlite_rekening`  (
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nm_rek` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipe` enum('N','M','R') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `balance` enum('D','K') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_rek`) USING BTREE,
  INDEX `nm_rek`(`nm_rek`) USING BTREE,
  INDEX `tipe`(`tipe`) USING BTREE,
  INDEX `balance`(`balance`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_rekeningtahun
-- ----------------------------
DROP TABLE IF EXISTS `mlite_rekeningtahun`;
CREATE TABLE `mlite_rekeningtahun`  (
  `thn` year NOT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `saldo_awal` double NOT NULL,
  PRIMARY KEY (`thn`, `kd_rek`) USING BTREE,
  INDEX `kd_rek`(`kd_rek`) USING BTREE,
  INDEX `saldo_awal`(`saldo_awal`) USING BTREE,
  CONSTRAINT `mlite_rekeningtahun_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `mlite_rekening` (`kd_rek`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_remember_me
-- ----------------------------
DROP TABLE IF EXISTS `mlite_remember_me`;
CREATE TABLE `mlite_remember_me`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `user_id` int(11) NOT NULL,
  `expiry` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mlite_remember_me_ibfk_1`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_rujukan_internal_poli
-- ----------------------------
DROP TABLE IF EXISTS `mlite_rujukan_internal_poli`;
CREATE TABLE `mlite_rujukan_internal_poli`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_poli` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `isi_rujukan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `jawab_rujukan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`no_rawat`, `kd_dokter`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `kd_poli`(`kd_poli`) USING BTREE,
  CONSTRAINT `mlite_rujukan_internal_poli_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mlite_rujukan_internal_poli_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mlite_rujukan_internal_poli_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for mlite_satu_sehat_departemen
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_departemen`;
CREATE TABLE `mlite_satu_sehat_departemen`  (
  `dep_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_organisasi_satusehat` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dep_id`) USING BTREE,
  UNIQUE INDEX `id_organisasi_satusehat`(`id_organisasi_satusehat`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_departemen_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departemen` (`dep_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_satu_sehat_lokasi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_lokasi`;
CREATE TABLE `mlite_satu_sehat_lokasi`  (
  `kode` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_organisasi_satusehat` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lokasi_satusehat` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `longitude` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `latitude` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `altitude` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode`) USING BTREE,
  UNIQUE INDEX `id_lokasi_satusehat`(`id_lokasi_satusehat`) USING BTREE,
  INDEX `id_organisasi_satusehat`(`id_organisasi_satusehat`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_lokasi_ibfk_2` FOREIGN KEY (`id_organisasi_satusehat`) REFERENCES `mlite_satu_sehat_departemen` (`id_organisasi_satusehat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_satu_sehat_mapping_lab
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_mapping_lab`;
CREATE TABLE `mlite_satu_sehat_mapping_lab`  (
  `id_template` int(11) NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `display` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sampel_code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sampel_system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sampel_display` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_template`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_mapping_lab_ibfk_1` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_satu_sehat_mapping_obat
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_mapping_obat`;
CREATE TABLE `mlite_satu_sehat_mapping_obat`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_kfa` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_kfa` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_bahan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bahan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numerator` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `satuan_num` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `denominator` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `satuan_den` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_satuan_den` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_sediaan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_sediaan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_route` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_route` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` enum('obat','vaksin') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_medication` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_brng`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_mapping_obat_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_satu_sehat_mapping_praktisi
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_mapping_praktisi`;
CREATE TABLE `mlite_satu_sehat_mapping_praktisi`  (
  `practitioner_id` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jenis_praktisi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`practitioner_id`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_mapping_praktisi_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_satu_sehat_mapping_rad
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_mapping_rad`;
CREATE TABLE `mlite_satu_sehat_mapping_rad`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `display` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sampel_code` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sampel_system` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sampel_display` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_mapping_rad_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_satu_sehat_response
-- ----------------------------
DROP TABLE IF EXISTS `mlite_satu_sehat_response`;
CREATE TABLE `mlite_satu_sehat_response`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_encounter` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_condition` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvnadi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvrespirasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvsuhu` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvspo2` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvgcs` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvtinggi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvberat` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvperut` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvtensi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_observation_ttvkesadaran` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_procedure` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_clinical_impression` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_composition` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_immunization` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_medication_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_medication_dispense` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_medication_statement` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_rad_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_rad_specimen` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_rad_observation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_rad_diagnostic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pk_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pk_specimen` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pk_observation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pk_diagnostic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pa_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pa_specimen` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pa_observation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_pa_diagnostic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_mb_request` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_mb_specimen` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_mb_observation` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_lab_mb_diagnostic` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_careplan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  CONSTRAINT `mlite_satu_sehat_response_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_settings
-- ----------------------------
DROP TABLE IF EXISTS `mlite_settings`;
CREATE TABLE `mlite_settings`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `module`(`module`, `field`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 287 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_surat_rujukan
-- ----------------------------
DROP TABLE IF EXISTS `mlite_surat_rujukan`;
CREATE TABLE `mlite_surat_rujukan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_surat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kepada` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `di` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `anamnesa` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_fisik` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosa` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `terapi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alasan_dirujuk` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_surat_sakit
-- ----------------------------
DROP TABLE IF EXISTS `mlite_surat_sakit`;
CREATE TABLE `mlite_surat_sakit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_surat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keadaan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosa` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lama_angka` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lama_huruf` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_mulai` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_selesai` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_surat_sehat
-- ----------------------------
DROP TABLE IF EXISTS `mlite_surat_sehat`;
CREATE TABLE `mlite_surat_sehat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomor_surat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berat_badan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tinggi_badan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tensi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gol_darah` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `riwayat_penyakit` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keperluan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_temporary
-- ----------------------------
DROP TABLE IF EXISTS `mlite_temporary`;
CREATE TABLE `mlite_temporary`  (
  `temp1` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp2` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp3` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp4` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp5` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp6` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp7` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp8` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp9` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp10` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp11` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp12` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp13` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp14` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp15` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp16` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp17` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp18` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp19` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp20` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp21` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp22` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp23` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp24` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp25` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp26` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp27` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp28` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp29` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp30` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp31` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp32` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp33` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp34` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp35` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp36` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp37` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp38` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp39` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp40` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp41` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp42` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp43` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp44` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp45` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp46` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp47` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp48` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp49` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp50` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp51` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp52` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp53` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp54` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp55` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp56` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp57` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp58` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp59` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp60` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp61` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp62` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp63` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp64` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp65` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp66` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp67` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp68` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp69` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp70` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp71` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp72` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp73` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp74` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp75` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp76` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp77` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp78` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp79` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp80` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp81` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp82` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp83` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp84` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp85` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp86` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp87` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp88` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp89` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp90` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp91` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp92` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp93` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp94` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp95` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp96` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp97` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp98` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp99` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `temp100` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_triase_igd
-- ----------------------------
DROP TABLE IF EXISTS `mlite_triase_igd`;
CREATE TABLE `mlite_triase_igd`  (
  `id_triase` bigint(20) NOT NULL AUTO_INCREMENT,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_triase` datetime NOT NULL,
  `petugas_id` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kesadaran` enum('Compos Mentis','Apatis','Somnolen','Sopor','Koma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `airway` enum('Bebas','Sumbatan Parsial','Sumbatan Total') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `breathing` enum('Spontan','Tak Spontan','Distres Nafas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `circulation` enum('Baik','Syok','Perdarahan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tekanan_darah` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nadi` int(11) NULL DEFAULT NULL,
  `respirasi` int(11) NULL DEFAULT NULL,
  `suhu` decimal(4, 1) NULL DEFAULT NULL,
  `spo2` int(11) NULL DEFAULT NULL,
  `gcs_e` tinyint(4) NULL DEFAULT NULL,
  `gcs_v` tinyint(4) NULL DEFAULT NULL,
  `gcs_m` tinyint(4) NULL DEFAULT NULL,
  `kategori` enum('Merah','Kuning','Hijau','Hitam') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `skala_triase` enum('1','2','3','4','5') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keluhan_utama` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `diagnosa_awal` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_triase`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `fk_triase_reg_periksa` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_users
-- ----------------------------
DROP TABLE IF EXISTS `mlite_users`;
CREATE TABLE `mlite_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `fullname` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `password` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `avatar` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `email` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'user',
  `cap` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `access` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'dashboard',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_users_vedika
-- ----------------------------
DROP TABLE IF EXISTS `mlite_users_vedika`;
CREATE TABLE `mlite_users_vedika`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `password` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `fullname` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_vedika
-- ----------------------------
DROP TABLE IF EXISTS `mlite_vedika`;
CREATE TABLE `mlite_vedika`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` date NULL DEFAULT NULL,
  `no_rkm_medis` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `no_rawat` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tgl_registrasi` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nosep` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `jenis` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_vedika_feedback
-- ----------------------------
DROP TABLE IF EXISTS `mlite_vedika_feedback`;
CREATE TABLE `mlite_vedika_feedback`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nosep` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `catatan` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_veronisa
-- ----------------------------
DROP TABLE IF EXISTS `mlite_veronisa`;
CREATE TABLE `mlite_veronisa`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` date NULL DEFAULT NULL,
  `no_rkm_medis` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `no_rawat` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tgl_registrasi` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nosep` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mlite_veronisa_feedback
-- ----------------------------
DROP TABLE IF EXISTS `mlite_veronisa_feedback`;
CREATE TABLE `mlite_veronisa_feedback`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nosep` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `catatan` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mutasi_berkas
-- ----------------------------
DROP TABLE IF EXISTS `mutasi_berkas`;
CREATE TABLE `mutasi_berkas`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Sudah Dikirim','Sudah Diterima','Sudah Kembali','Tidak Ada','Masuk Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dikirim` datetime NULL DEFAULT NULL,
  `diterima` datetime NULL DEFAULT NULL,
  `kembali` datetime NULL DEFAULT NULL,
  `tidakada` datetime NULL DEFAULT NULL,
  `ranap` datetime NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  CONSTRAINT `mutasi_berkas_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mutasibarang
-- ----------------------------
DROP TABLE IF EXISTS `mutasibarang`;
CREATE TABLE `mutasibarang`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml` double NOT NULL,
  `harga` double NOT NULL,
  `kd_bangsaldari` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_bangsalke` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `keterangan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode_brng`, `kd_bangsaldari`, `kd_bangsalke`, `tanggal`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `kd_bangsaldari`(`kd_bangsaldari`) USING BTREE,
  INDEX `kd_bangsalke`(`kd_bangsalke`) USING BTREE,
  INDEX `jml`(`jml`) USING BTREE,
  INDEX `keterangan`(`keterangan`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `mutasibarang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mutasibarang_ibfk_2` FOREIGN KEY (`kd_bangsaldari`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mutasibarang_ibfk_3` FOREIGN KEY (`kd_bangsalke`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for obat_racikan
-- ----------------------------
DROP TABLE IF EXISTS `obat_racikan`;
CREATE TABLE `obat_racikan`  (
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_racik` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_racik` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml_dr` int(11) NOT NULL,
  `aturan_pakai` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_perawatan`, `jam`, `no_rawat`, `no_racik`) USING BTREE,
  INDEX `kd_racik`(`kd_racik`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_racik`(`no_racik`) USING BTREE,
  CONSTRAINT `obat_racikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `obat_racikan_ibfk_2` FOREIGN KEY (`kd_racik`) REFERENCES `metode_racik` (`kd_racik`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for obatbhp_ok
-- ----------------------------
DROP TABLE IF EXISTS `obatbhp_ok`;
CREATE TABLE `obatbhp_ok`  (
  `kd_obat` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_obat` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hargasatuan` double NOT NULL,
  PRIMARY KEY (`kd_obat`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `nm_obat`(`nm_obat`) USING BTREE,
  INDEX `hargasatuan`(`hargasatuan`) USING BTREE,
  CONSTRAINT `obatbhp_ok_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for operasi
-- ----------------------------
DROP TABLE IF EXISTS `operasi`;
CREATE TABLE `operasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `jenis_anasthesi` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kategori` enum('-','Khusus','Besar','Sedang','Kecil','Elektive','Emergency') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `operator1` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `operator2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `operator3` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_operator1` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_operator2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_operator3` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `instrumen` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter_anak` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perawaat_resusitas` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dokter_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asisten_anestesi2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bidan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bidan2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bidan3` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perawat_luar` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `omloop` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `omloop2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `omloop3` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `omloop4` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `omloop5` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter_pjanak` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dokter_umum` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biayaoperator1` double NOT NULL,
  `biayaoperator2` double NOT NULL,
  `biayaoperator3` double NOT NULL,
  `biayaasisten_operator1` double NOT NULL,
  `biayaasisten_operator2` double NOT NULL,
  `biayaasisten_operator3` double NULL DEFAULT NULL,
  `biayainstrumen` double NULL DEFAULT NULL,
  `biayadokter_anak` double NOT NULL,
  `biayaperawaat_resusitas` double NOT NULL,
  `biayadokter_anestesi` double NOT NULL,
  `biayaasisten_anestesi` double NOT NULL,
  `biayaasisten_anestesi2` double NULL DEFAULT NULL,
  `biayabidan` double NOT NULL,
  `biayabidan2` double NULL DEFAULT NULL,
  `biayabidan3` double NULL DEFAULT NULL,
  `biayaperawat_luar` double NOT NULL,
  `biayaalat` double NOT NULL,
  `biayasewaok` double NOT NULL,
  `akomodasi` double NULL DEFAULT NULL,
  `bagian_rs` double NOT NULL,
  `biaya_omloop` double NULL DEFAULT NULL,
  `biaya_omloop2` double NULL DEFAULT NULL,
  `biaya_omloop3` double NULL DEFAULT NULL,
  `biaya_omloop4` double NULL DEFAULT NULL,
  `biaya_omloop5` double NULL DEFAULT NULL,
  `biayasarpras` double NULL DEFAULT NULL,
  `biaya_dokter_pjanak` double NULL DEFAULT NULL,
  `biaya_dokter_umum` double NULL DEFAULT NULL,
  `status` enum('Ranap','Ralan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `operator1`(`operator1`) USING BTREE,
  INDEX `operator2`(`operator2`) USING BTREE,
  INDEX `operator3`(`operator3`) USING BTREE,
  INDEX `asisten_operator1`(`asisten_operator1`) USING BTREE,
  INDEX `asisten_operator2`(`asisten_operator2`) USING BTREE,
  INDEX `dokter_anak`(`dokter_anak`) USING BTREE,
  INDEX `perawaat_resusitas`(`perawaat_resusitas`) USING BTREE,
  INDEX `dokter_anestesi`(`dokter_anestesi`) USING BTREE,
  INDEX `asisten_anestesi`(`asisten_anestesi`) USING BTREE,
  INDEX `bidan`(`bidan`) USING BTREE,
  INDEX `perawat_luar`(`perawat_luar`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  CONSTRAINT `operasi_ibfk_31` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_32` FOREIGN KEY (`operator1`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_33` FOREIGN KEY (`operator2`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_34` FOREIGN KEY (`operator3`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_35` FOREIGN KEY (`asisten_operator1`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_36` FOREIGN KEY (`asisten_operator2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_38` FOREIGN KEY (`dokter_anak`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_39` FOREIGN KEY (`perawaat_resusitas`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_40` FOREIGN KEY (`dokter_anestesi`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_41` FOREIGN KEY (`asisten_anestesi`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_42` FOREIGN KEY (`bidan`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_43` FOREIGN KEY (`perawat_luar`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_44` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for opname
-- ----------------------------
DROP TABLE IF EXISTS `opname`;
CREATE TABLE `opname`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h_beli` double NULL DEFAULT NULL,
  `tanggal` date NOT NULL,
  `stok` double NOT NULL,
  `real` double NOT NULL,
  `selisih` double NOT NULL,
  `nomihilang` double NOT NULL,
  `lebih` double NOT NULL,
  `nomilebih` double NOT NULL,
  `keterangan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode_brng`, `tanggal`, `kd_bangsal`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal`) USING BTREE,
  INDEX `stok`(`stok`) USING BTREE,
  INDEX `real`(`real`) USING BTREE,
  INDEX `selisih`(`selisih`) USING BTREE,
  INDEX `nomihilang`(`nomihilang`) USING BTREE,
  INDEX `keterangan`(`keterangan`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `opname_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `opname_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for paket_operasi
-- ----------------------------
DROP TABLE IF EXISTS `paket_operasi`;
CREATE TABLE `paket_operasi`  (
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_perawatan` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kategori` enum('Kebidanan','Operasi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `operator1` double NOT NULL,
  `operator2` double NOT NULL,
  `operator3` double NOT NULL,
  `asisten_operator1` double NULL DEFAULT NULL,
  `asisten_operator2` double NOT NULL,
  `asisten_operator3` double NULL DEFAULT NULL,
  `instrumen` double NULL DEFAULT NULL,
  `dokter_anak` double NOT NULL,
  `perawaat_resusitas` double NOT NULL,
  `dokter_anestesi` double NOT NULL,
  `asisten_anestesi` double NOT NULL,
  `asisten_anestesi2` double NULL DEFAULT NULL,
  `bidan` double NOT NULL,
  `bidan2` double NULL DEFAULT NULL,
  `bidan3` double NULL DEFAULT NULL,
  `perawat_luar` double NOT NULL,
  `sewa_ok` double NOT NULL,
  `alat` double NOT NULL,
  `akomodasi` double NULL DEFAULT NULL,
  `bagian_rs` double NOT NULL,
  `omloop` double NOT NULL,
  `omloop2` double NULL DEFAULT NULL,
  `omloop3` double NULL DEFAULT NULL,
  `omloop4` double NULL DEFAULT NULL,
  `omloop5` double NULL DEFAULT NULL,
  `sarpras` double NULL DEFAULT NULL,
  `dokter_pjanak` double NULL DEFAULT NULL,
  `dokter_umum` double NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_paket`) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan`) USING BTREE,
  INDEX `operator1`(`operator1`) USING BTREE,
  INDEX `operator2`(`operator2`) USING BTREE,
  INDEX `operator3`(`operator3`) USING BTREE,
  INDEX `asisten_operator1`(`asisten_operator1`) USING BTREE,
  INDEX `asisten_operator2`(`asisten_operator2`) USING BTREE,
  INDEX `asisten_operator3`(`instrumen`) USING BTREE,
  INDEX `dokter_anak`(`dokter_anak`) USING BTREE,
  INDEX `perawat_resusitas`(`perawaat_resusitas`) USING BTREE,
  INDEX `dokter_anestasi`(`dokter_anestesi`) USING BTREE,
  INDEX `asisten_anastesi`(`asisten_anestesi`) USING BTREE,
  INDEX `bidan`(`bidan`) USING BTREE,
  INDEX `perawat_luar`(`perawat_luar`) USING BTREE,
  INDEX `sewa_ok`(`sewa_ok`) USING BTREE,
  INDEX `alat`(`alat`) USING BTREE,
  INDEX `sewa_vk`(`akomodasi`) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs`) USING BTREE,
  INDEX `omloop`(`omloop`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  INDEX `asisten_anestesi2`(`asisten_anestesi2`) USING BTREE,
  INDEX `omloop2`(`omloop2`) USING BTREE,
  INDEX `omloop3`(`omloop3`) USING BTREE,
  INDEX `omloop4`(`omloop4`) USING BTREE,
  INDEX `omloop5`(`omloop5`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `kategori`(`kategori`) USING BTREE,
  INDEX `bidan2`(`bidan2`) USING BTREE,
  INDEX `bidan3`(`bidan3`) USING BTREE,
  INDEX `asisten_operator3_2`(`asisten_operator3`) USING BTREE,
  CONSTRAINT `paket_operasi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pasien
-- ----------------------------
DROP TABLE IF EXISTS `pasien`;
CREATE TABLE `pasien`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_pasien` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_ktp` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tmp_lahir` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `nm_ibu` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamat` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pekerjaan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `agama` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_daftar` date NULL DEFAULT NULL,
  `no_tlp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pnd` enum('TS','TK','SD','SMP','SMA','SLTA/SEDERAJAT','D1','D2','D3','D4','S1','S2','S3','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluarga` enum('AYAH','IBU','ISTRI','SUAMI','SAUDARA','ANAK') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `namakeluarga` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_peserta` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_kel` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_kec` int(11) NOT NULL,
  `kd_kab` int(11) NOT NULL,
  `pekerjaanpj` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamatpj` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kelurahanpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kecamatanpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kabupatenpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perusahaan_pasien` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suku_bangsa` int(11) NOT NULL,
  `bahasa_pasien` int(11) NOT NULL,
  `cacat_fisik` int(11) NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prop` int(11) NOT NULL,
  `propinsipj` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rkm_medis`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  INDEX `kd_kec`(`kd_kec`) USING BTREE,
  INDEX `kd_kab`(`kd_kab`) USING BTREE,
  INDEX `nm_pasien`(`nm_pasien`) USING BTREE,
  INDEX `alamat`(`alamat`) USING BTREE,
  INDEX `kd_kel_2`(`kd_kel`) USING BTREE,
  INDEX `no_ktp`(`no_ktp`) USING BTREE,
  INDEX `no_peserta`(`no_peserta`) USING BTREE,
  INDEX `perusahaan_pasien`(`perusahaan_pasien`) USING BTREE,
  INDEX `suku_bangsa`(`suku_bangsa`) USING BTREE,
  INDEX `bahasa_pasien`(`bahasa_pasien`) USING BTREE,
  INDEX `cacat_fisik`(`cacat_fisik`) USING BTREE,
  INDEX `kd_prop`(`kd_prop`) USING BTREE,
  CONSTRAINT `pasien_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_3` FOREIGN KEY (`kd_kec`) REFERENCES `kecamatan` (`kd_kec`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_4` FOREIGN KEY (`kd_kab`) REFERENCES `kabupaten` (`kd_kab`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_5` FOREIGN KEY (`perusahaan_pasien`) REFERENCES `perusahaan_pasien` (`kode_perusahaan`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_6` FOREIGN KEY (`suku_bangsa`) REFERENCES `suku_bangsa` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_7` FOREIGN KEY (`bahasa_pasien`) REFERENCES `bahasa_pasien` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_8` FOREIGN KEY (`cacat_fisik`) REFERENCES `cacat_fisik` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_9` FOREIGN KEY (`kd_prop`) REFERENCES `propinsi` (`kd_prop`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for patients
-- ----------------------------
DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `date_of_birth` date NULL DEFAULT NULL,
  `gender` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `emergency_contact_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `emergency_contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `blood_type` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `allergies` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `medical_history` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `patient_code`(`patient_code`) USING BTREE,
  INDEX `idx_patients_code`(`patient_code`) USING BTREE,
  INDEX `idx_patients_phone`(`phone`) USING BTREE,
  INDEX `idx_patients_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for pegawai
-- ----------------------------
DROP TABLE IF EXISTS `pegawai`;
CREATE TABLE `pegawai`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jk` enum('Pria','Wanita') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jbtn` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jnj_jabatan` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_kelompok` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_resiko` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_emergency` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `departemen` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bidang` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_wp` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_kerja` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `npwp` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pendidikan` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gapok` double NOT NULL,
  `tmp_lahir` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kota` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mulai_kerja` date NOT NULL,
  `ms_kerja` enum('<1','PT','FT>1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `indexins` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bpd` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rekening` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_aktif` enum('AKTIF','CUTI','KELUAR','TENAGA LUAR') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `wajibmasuk` tinyint(4) NOT NULL,
  `pengurang` double NOT NULL,
  `indek` tinyint(4) NOT NULL,
  `mulai_kontrak` date NULL DEFAULT NULL,
  `cuti_diambil` int(11) NOT NULL,
  `dankes` double NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_ktp` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nik_2`(`nik`) USING BTREE,
  INDEX `departemen`(`departemen`) USING BTREE,
  INDEX `bidang`(`bidang`) USING BTREE,
  INDEX `stts_wp`(`stts_wp`) USING BTREE,
  INDEX `stts_kerja`(`stts_kerja`) USING BTREE,
  INDEX `pendidikan`(`pendidikan`) USING BTREE,
  INDEX `indexins`(`indexins`) USING BTREE,
  INDEX `jnj_jabatan`(`jnj_jabatan`) USING BTREE,
  INDEX `bpd`(`bpd`) USING BTREE,
  INDEX `nama`(`nama`) USING BTREE,
  INDEX `jbtn`(`jbtn`) USING BTREE,
  INDEX `npwp`(`npwp`) USING BTREE,
  INDEX `dankes`(`dankes`) USING BTREE,
  INDEX `cuti_diambil`(`cuti_diambil`) USING BTREE,
  INDEX `mulai_kontrak`(`mulai_kontrak`) USING BTREE,
  INDEX `stts_aktif`(`stts_aktif`) USING BTREE,
  INDEX `tmp_lahir`(`tmp_lahir`) USING BTREE,
  INDEX `alamat`(`alamat`) USING BTREE,
  INDEX `mulai_kerja`(`mulai_kerja`) USING BTREE,
  INDEX `gapok`(`gapok`) USING BTREE,
  INDEX `kota`(`kota`) USING BTREE,
  INDEX `pengurang`(`pengurang`) USING BTREE,
  INDEX `indek`(`indek`) USING BTREE,
  INDEX `jk`(`jk`) USING BTREE,
  INDEX `ms_kerja`(`ms_kerja`) USING BTREE,
  INDEX `tgl_lahir`(`tgl_lahir`) USING BTREE,
  INDEX `rekening`(`rekening`) USING BTREE,
  INDEX `wajibmasuk`(`wajibmasuk`) USING BTREE,
  INDEX `kode_emergency`(`kode_emergency`) USING BTREE,
  INDEX `kode_kelompok`(`kode_kelompok`) USING BTREE,
  INDEX `kode_resiko`(`kode_resiko`) USING BTREE,
  CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`jnj_jabatan`) REFERENCES `jnj_jabatan` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_10` FOREIGN KEY (`kode_kelompok`) REFERENCES `kelompok_jabatan` (`kode_kelompok`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_11` FOREIGN KEY (`kode_resiko`) REFERENCES `resiko_kerja` (`kode_resiko`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_2` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`dep_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_3` FOREIGN KEY (`bidang`) REFERENCES `bidang` (`nama`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_4` FOREIGN KEY (`stts_wp`) REFERENCES `stts_wp` (`stts`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_5` FOREIGN KEY (`stts_kerja`) REFERENCES `stts_kerja` (`stts`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_6` FOREIGN KEY (`pendidikan`) REFERENCES `pendidikan` (`tingkat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_7` FOREIGN KEY (`indexins`) REFERENCES `departemen` (`dep_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_8` FOREIGN KEY (`bpd`) REFERENCES `bank` (`namabank`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_9` FOREIGN KEY (`kode_emergency`) REFERENCES `emergency_index` (`kode_emergency`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pemeliharaan_inventaris
-- ----------------------------
DROP TABLE IF EXISTS `pemeliharaan_inventaris`;
CREATE TABLE `pemeliharaan_inventaris`  (
  `no_inventaris` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `uraian_kegiatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pelaksana` enum('Teknisi Rumah Sakit','Teknisi Rujukan','Pihak ke III') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biaya` double NOT NULL,
  `jenis_pemeliharaan` enum('Running Maintenance','Shut Down Maintenance','Emergency Maintenance') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_inventaris`, `tanggal`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `pemeliharaan_inventaris_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemeliharaan_inventaris_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pemeriksaan_ralan
-- ----------------------------
DROP TABLE IF EXISTS `pemeriksaan_ralan`;
CREATE TABLE `pemeriksaan_ralan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `suhu_tubuh` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tensi` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nadi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `respirasi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tinggi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berat` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spo2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kesadaran` enum('Compos Mentis','Somnolence','Sopor','Coma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lingkar_perut` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rtl` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `instruksi` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `evaluasi` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `pemeriksaan_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemeriksaan_ralan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pemeriksaan_ranap
-- ----------------------------
DROP TABLE IF EXISTS `pemeriksaan_ranap`;
CREATE TABLE `pemeriksaan_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `suhu_tubuh` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tensi` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nadi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `respirasi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tinggi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berat` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spo2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kesadaran` enum('Compos Mentis','Somnolence','Sopor','Coma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rtl` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `instruksi` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `evaluasi` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `pemeriksaan_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemeriksaan_ranap_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pendidikan
-- ----------------------------
DROP TABLE IF EXISTS `pendidikan`;
CREATE TABLE `pendidikan`  (
  `tingkat` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `indek` tinyint(4) NOT NULL,
  `gapok1` double NOT NULL,
  `kenaikan` double NOT NULL,
  `maksimal` int(11) NOT NULL,
  PRIMARY KEY (`tingkat`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penilaian_awal_keperawatan_igd
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_awal_keperawatan_igd`;
CREATE TABLE `penilaian_awal_keperawatan_igd`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_kehamilan` enum('Tidak Hamil','Hamil') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gravida` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `para` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `abortus` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hpht` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tekanan` enum('TAK','Sakit Kepala','Muntah','Pusing','Bingung') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pupil` enum('Normal','Miosis','Isokor','Anisokor') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `neurosensorik` enum('TAK','Spasme Otot','Perubahan Sensorik','Perubahan Motorik','Perubahan Bentuk Ekstremitas','Penurunan Tingkat Kesadaran','Fraktur/Dislokasi','Luksasio','Kerusakan Jaringan/Luka') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `integumen` enum('TAK','Luka Bakar','Luka Robek','Lecet','Luka Decubitus','Luka Gangren') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `turgor` enum('Baik','Menurun') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edema` enum('Tidak Ada','Ekstremitas','Seluruh Tubuh','Asites','Palpebrae') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mukosa` enum('Lembab','Kering') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perdarahan` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah_perdarahan` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `warna_perdarahan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `intoksikasi` enum('Tidak Ada','Ada','Gigitan Binatang','Zat Kimia','Gas','Obat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bab` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `xbab` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kbab` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wbab` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bak` char(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `xbak` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `wbak` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `lbak` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `psikologis` enum('Tidak Ada Masalah','Marah','Takut','Depresi','Cepat Lelah','Cemas','Gelisah','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jiwa` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perilaku` enum('Perilaku Kekerasan','Gangguan Efek','Gangguan Memori','Halusinasi','Kecenderungan Percobaan Bunuh Diri','Lainnya','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dilaporkan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sebutkan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hubungan` enum('Harmonis','Kurang Harmonis','Tidak Harmonis','Konflik Besar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tinggal_dengan` enum('Sendiri','Orang Tua','Suami / Istri','Lainnya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_tinggal` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `budaya` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_budaya` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pendidikan_pj` enum('-','TS','TK','SD','SMP','SMA','SLTA/SEDERAJAT','D1','D2','D3','D4','S1','S2','S3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_pendidikan_pj` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `edukasi` enum('Pasien','Keluarga') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_edukasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kemampuan` enum('Mandiri','Bantuan Minimal','Bantuan Sebagian','Ketergantungan Total') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `aktifitas` enum('Tirah Baring','Duduk','Berjalan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alat_bantu` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_bantu` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `provokes` enum('Proses Penyakit','Benturan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_provokes` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `quality` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_quality` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `menyebar` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_nyeri` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pada_dokter` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_dokter` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berjalan_a` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_b` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_c` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hasil` enum('Tidak beresiko (tidak ditemukan a dan b)','Resiko rendah (ditemukan a/b)','Resiko tinggi (ditemukan a dan b)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lapor` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lapor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rencana` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `penilaian_awal_keperawatan_igd_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_igd_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for penilaian_awal_keperawatan_ralan
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_awal_keperawatan_ralan`;
CREATE TABLE `penilaian_awal_keperawatan_ralan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `gcs` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `bmi` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpd` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `alat_bantu` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_bantu` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `prothesa` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_pro` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `adl` enum('Mandiri','Dibantu') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_psiko` enum('Tenang','Takut','Cemas','Depresi','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_psiko` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hub_keluarga` enum('Baik','Tidak Baik') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tinggal_dengan` enum('Sendiri','Orang Tua','Suami / Istri','Lainnya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_tinggal` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekonomi` enum('Baik','Cukup','Kurang') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `budaya` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_budaya` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edukasi` enum('Pasien','Keluarga') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_edukasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_a` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_b` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berjalan_c` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hasil` enum('Tidak beresiko (tidak ditemukan a dan b)','Resiko rendah (ditemukan a/b)','Resiko tinggi (ditemukan a dan b)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lapor` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lapor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sg1` enum('Tidak','Tidak Yakin','Ya, 1-5 Kg','Ya, 6-10 Kg','Ya, 11-15 Kg','Ya, >15 Kg') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai1` enum('0','1','2','3','4') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sg2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai2` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `total_hasil` tinyint(4) NOT NULL,
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `provokes` enum('Proses Penyakit','Benturan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_provokes` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `quality` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_quality` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `menyebar` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_nyeri` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pada_dokter` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_dokter` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rencana` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `penilaian_awal_keperawatan_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ralan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penilaian_awal_keperawatan_ranap
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_awal_keperawatan_ranap`;
CREATE TABLE `penilaian_awal_keperawatan_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_informasi` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tiba_diruang_rawat` enum('Jalan Tanpa Bantuan','Kursi Roda','Brankar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kasus_trauma` enum('Trauma','Non Trauma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cara_masuk` enum('Poli','IGD','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rps` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpk` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_pembedahan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_dirawat_dirs` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alat_bantu_dipakai` enum('Kacamata','Prothesa','Alat Bantu Dengar','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_kehamilan` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_kehamilan_perkiraan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_tranfusi` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_alergi` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_merokok` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_merokok_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_alkohol` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_alkohol_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_narkoba` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_olahraga` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_mental` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_keadaan_umum` enum('Baik','Sedang','Buruk') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_spo2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_kepala` enum('TAK','Hydrocephalus','Hematoma','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_kepala_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_wajah` enum('TAK','Asimetris','Kelainan Kongenital') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_wajah_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_leher` enum('TAK','Kaku Kuduk','Pembesaran Thyroid','Pembesaran KGB') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_kejang` enum('TAK','Kuat','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_kejang_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_susunan_sensorik` enum('TAK','Sakit Nyeri','Rasa kebas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_kardiovaskuler_denyut_nadi` enum('Teratur','Tidak Teratur') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_kardiovaskuler_sirkulasi` enum('Akral Hangat','Akral Dingin','Edema') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_kardiovaskuler_sirkulasi_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_kardiovaskuler_pulsasi` enum('Kuat','Lemah','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_pola_nafas` enum('Normal','Bradipnea','Tachipnea') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_retraksi` enum('Tidak Ada','Ringan','Berat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_suara_nafas` enum('Vesikuler','Wheezing','Rhonki') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_volume_pernafasan` enum('Normal','Hiperventilasi','Hipoventilasi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_jenis_pernafasan` enum('Pernafasan Dada','Alat Bantu Pernafasaan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_jenis_pernafasan_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_irama_nafas` enum('Teratur','Tidak Teratur') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_respirasi_batuk` enum('Tidak','Ya : Produktif','Ya : Non Produktif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_mulut` enum('TAK','Stomatitis','Mukosa Kering','Bibir Pucat','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_mulut_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_gigi` enum('TAK','Karies','Goyang','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_gigi_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_lidah` enum('TAK','Kotor','Gerak Asimetris','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_lidah_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_tenggorokan` enum('TAK','Gangguan Menelan','Sakit Menelan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_tenggorokan_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_abdomen` enum('Supel','Asictes',' Tegang','Nyeri Tekan/Lepas','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_abdomen_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_peistatik_usus` enum('TAK','Tidak Ada Bising Usus','Hiperistaltik') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_gastrointestinal_anus` enum('TAK','Atresia Ani') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_pengelihatan` enum('TAK','Ada Kelainan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_pengelihatan_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_alat_bantu_penglihatan` enum('Tidak','Kacamata','Lensa Kontak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_pendengaran` enum('TAK','Berdengung','Nyeri','Tuli','Keluar Cairan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_bicara` enum('Jelas','Tidak Jelas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_bicara_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_sensorik` enum('TAK','Sakit Nyeri','Rasa Kebas','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_motorik` enum('TAK','Hemiparese','Tetraparese','Tremor','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_neurologi_kekuatan_otot` enum('Kuat','Lemah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_integument_warnakulit` enum('Pucat','Sianosis','Normal','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_integument_turgor` enum('Baik','Sedang','Buruk') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_integument_kulit` enum('Normal','Rash/Kemerahan','Luka','Memar','Ptekie','Bula') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_integument_dekubitas` enum('Tidak Ada','Usia > 65 tahun','Obesitas','Imobilisasi','Paraplegi/Vegetative State','Dirawat Di HCU','Penyakit Kronis (DM, CHF, CKD)','Inkontinentia Uri/Alvi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_pergerakan_sendi` enum('Bebas','Terbatas') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_kekauatan_otot` enum('Baik','Lemah','Tremor') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_nyeri_sendi` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_nyeri_sendi_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_oedema` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_oedema_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_fraktur` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_muskuloskletal_fraktur_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bab_frekuensi_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bab_frekuensi_durasi` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bab_konsistensi` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bab_warna` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bak_frekuensi_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bak_frekuensi_durasi` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bak_warna` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_eliminasi_bak_lainlain` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_makanminum` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_mandi` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_eliminasi` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_berpakaian` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_aktifitas_berpindah` enum('Mandiri','Bantuan Orang Lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_nutrisi_frekuesi_makan` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_nutrisi_jenis_makanan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_nutrisi_porsi_makan` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_tidur_lama_tidur` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pola_tidur_gangguan` enum('Tidak Ada Gangguan','Insomnia') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_kemampuan_sehari` enum('Mandiri','Bantuan Minimal','Bantuan Sebagian','Ketergantungan Total') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_aktifitas` enum('Tirah Baring','Duduk','Berjalan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_berjalan` enum('TAK','Penurunan Kekuatan/ROM','Paralisis','Sering Jatuh','Deformitas','Hilang Keseimbangan','Riwayat Patah Tulang','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_berjalan_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ambulasi` enum('Walker','Tongkat','Kursi Roda','Tidak Menggunakan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ekstrimitas_atas` enum('TAK','Lemah','Oedema','Tidak Simetris','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ekstrimitas_atas_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ekstrimitas_bawah` enum('TAK','Varises','Oedema','Tidak Simetris','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_ekstrimitas_bawah_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_menggenggam` enum('Tidak Ada Kesulitan','Terakhir','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_menggenggam_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_koordinasi` enum('Tidak Ada Kesulitan','Ada Masalah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_koordinasi_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pengkajian_fungsi_kesimpulan` enum('Ya (Co DPJP)','Tidak (Tidak Perlu Co DPJP)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_kondisi_psiko` enum('Tidak Ada Masalah','Marah','Takut','Depresi','Cepat Lelah','Cemas','Gelisah','Sulit Tidur','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_gangguan_jiwa` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_perilaku` enum('Tidak Ada Masalah','Perilaku Kekerasan','Gangguan Efek','Gangguan Memori','Halusinasi','Kecenderungan Percobaan Bunuh Diri','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_perilaku_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_hubungan_keluarga` enum('Harmonis','Kurang Harmonis','Tidak Harmonis','Konflik Besar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_tinggal` enum('Sendiri','Orang Tua','Suami/Istri','Keluarga','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_tinggal_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_nilai_kepercayaan` enum('Tidak Ada','Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_nilai_kepercayaan_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_pendidikan_pj` enum('-','TS','TK','SD','SMP','SMA','SLTA/SEDERAJAT','D1','D2','D3','D4','S1','S2','S3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_edukasi_diberikan` enum('Pasien','Keluarga') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `riwayat_psiko_edukasi_diberikan_keterangan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_penyebab` enum('Proses Penyakit','Benturan','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_ket_penyebab` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_kualitas` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_ket_kualitas` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_lokasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_menyebar` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_skala` enum('0','1','2','3','4','5','6','7','8','9','10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_waktu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_ket_hilang` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_diberitahukan_dokter` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_nyeri_jam_diberitahukan_dokter` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penilaian_jatuhmorse_skala1` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai1` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala2` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai2` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala3` enum('Tidak Ada/Kursi Roda/Perawat/Tirah Baring','Tongkat/Alat Penopang','Berpegangan Pada Perabot') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai3` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala4` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai4` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala5` enum('Normal/Tirah Baring/Imobilisasi','Lemah','Terganggu') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai5` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhmorse_skala6` enum('Sadar Akan Kemampuan Diri Sendiri','Sering Lupa Akan Keterbatasan Yang Dimiliki') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhmorse_nilai6` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhmorse_totalnilai` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala1` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai1` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala2` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai2` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala3` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai3` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala4` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai4` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala5` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai5` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala6` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai6` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala7` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai7` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala8` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai8` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala9` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai9` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala10` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai10` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_skala11` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penilaian_jatuhsydney_nilai11` tinyint(4) NULL DEFAULT NULL,
  `penilaian_jatuhsydney_totalnilai` tinyint(4) NULL DEFAULT NULL,
  `skrining_gizi1` enum('Tidak ada penurunan berat badan','Tidak yakin/ tidak tahu/ terasa baju lebih longgar','Ya 1-5 kg','Ya 6-10 kg','Ya 11-15 kg','Ya > 15 kg') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nilai_gizi1` int(11) NULL DEFAULT NULL,
  `skrining_gizi2` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nilai_gizi2` int(11) NULL DEFAULT NULL,
  `nilai_total_gizi` double NULL DEFAULT NULL,
  `skrining_gizi_diagnosa_khusus` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `skrining_gizi_ket_diagnosa_khusus` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `skrining_gizi_diketahui_dietisen` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `skrining_gizi_jam_diketahui_dietisen` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rencana` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip1` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip2` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip1`(`nip1`) USING BTREE,
  INDEX `nip2`(`nip2`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `penilaian_awal_keperawatan_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ranap_ibfk_2` FOREIGN KEY (`nip1`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ranap_ibfk_3` FOREIGN KEY (`nip2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ranap_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penilaian_medis_igd
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_medis_igd`;
CREATE TABLE `penilaian_medis_igd`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `anamnesis` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hubungan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rps` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpk` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `keadaan` enum('Sehat','Sakit Ringan','Sakit Sedang','Sakit Berat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kesadaran` enum('Compos Mentis','Apatis','Somnolen','Sopor','Koma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `spo` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kepala` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mata` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gigi` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `leher` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `thoraks` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `abdomen` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `genital` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekstremitas` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_fisik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lokalis` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekg` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rad` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lab` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosis` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tata` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `penilaian_medis_igd_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_medis_igd_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penilaian_medis_ralan
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_medis_ralan`;
CREATE TABLE `penilaian_medis_ralan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `anamnesis` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hubungan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rps` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpk` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `keadaan` enum('Sehat','Sakit Ringan','Sakit Sedang','Sakit Berat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kesadaran` enum('Compos Mentis','Apatis','Somnolen','Sopor','Koma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `spo` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kepala` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gigi` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tht` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `thoraks` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `abdomen` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `genital` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekstremitas` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kulit` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_fisik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lokalis` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penunjang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosis` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tata` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `konsulrujuk` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `penilaian_medis_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_medis_ralan_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penilaian_medis_ranap
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_medis_ranap`;
CREATE TABLE `penilaian_medis_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `anamnesis` enum('Autoanamnesis','Alloanamnesis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hubungan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rps` varchar(2000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpd` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rpk` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rpo` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `keadaan` enum('Sehat','Sakit Ringan','Sakit Sedang','Sakit Berat') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kesadaran` enum('Compos Mentis','Apatis','Somnolen','Sopor','Koma') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `spo` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kepala` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mata` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gigi` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tht` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `thoraks` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jantung` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `paru` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `abdomen` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `genital` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ekstremitas` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kulit` enum('Normal','Abnormal','Tidak Diperiksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_fisik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_lokalis` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lab` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rad` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `penunjang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosis` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tata` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edukasi` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `penilaian_medis_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_medis_ranap_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for penilaian_ulang_nyeri
-- ----------------------------
DROP TABLE IF EXISTS `penilaian_ulang_nyeri`;
CREATE TABLE `penilaian_ulang_nyeri`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `provokes` enum('Proses Penyakit','Benturan','Lain-lain','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_provokes` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `quality` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_quality` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lokasi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `menyebar` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_nyeri` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `penilaian_ulang_nyeri_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_ulang_nyeri_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penjab
-- ----------------------------
DROP TABLE IF EXISTS `penjab`;
CREATE TABLE `penjab`  (
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `png_jawab` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_perusahaan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamat_asuransi` varchar(130) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_telp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `attn` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_pj`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penyakit
-- ----------------------------
DROP TABLE IF EXISTS `penyakit`;
CREATE TABLE `penyakit`  (
  `kd_penyakit` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_penyakit` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ciri_ciri` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `keterangan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_ktg` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Menular','Tidak Menular') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_penyakit`) USING BTREE,
  INDEX `kd_ktg`(`kd_ktg`) USING BTREE,
  INDEX `nm_penyakit`(`nm_penyakit`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  CONSTRAINT `penyakit_ibfk_1` FOREIGN KEY (`kd_ktg`) REFERENCES `kategori_penyakit` (`kd_ktg`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for perbaikan_inventaris
-- ----------------------------
DROP TABLE IF EXISTS `perbaikan_inventaris`;
CREATE TABLE `perbaikan_inventaris`  (
  `no_permintaan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `uraian_kegiatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pelaksana` enum('Teknisi Rumah Sakit','Teknisi Rujukan','Pihak ke III') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biaya` double NOT NULL,
  `keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Bisa Diperbaiki','Tidak Bisa Diperbaiki') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_permintaan`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `perbaikan_inventaris_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_perbaikan_inventaris` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `perbaikan_inventaris_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for periksa_lab
-- ----------------------------
DROP TABLE IF EXISTS `periksa_lab`;
CREATE TABLE `periksa_lab`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya` double NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kategori` enum('PA','PK','MB') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `dokter_perujuk`(`dokter_perujuk`) USING BTREE,
  CONSTRAINT `periksa_lab_ibfk_10` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_11` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_12` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_13` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_9` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for periksa_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `periksa_radiologi`;
CREATE TABLE `periksa_radiologi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya` double NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Ranap','Ralan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `proyeksi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kV` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mAS` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `FFD` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `BSF` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `inak` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml_penyinaran` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dosis` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `dokter_perujuk`(`dokter_perujuk`) USING BTREE,
  CONSTRAINT `periksa_radiologi_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_5` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_7` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_8` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permintaan_detail_permintaan_lab
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_detail_permintaan_lab`;
CREATE TABLE `permintaan_detail_permintaan_lab`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_template` int(11) NOT NULL,
  `stts_bayar` enum('Sudah','Belum') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`noorder`, `kd_jenis_prw`, `id_template`) USING BTREE,
  INDEX `id_template`(`id_template`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_3` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_4` FOREIGN KEY (`noorder`) REFERENCES `permintaan_lab` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permintaan_lab
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_lab`;
CREATE TABLE `permintaan_lab`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_permintaan` date NOT NULL,
  `jam_permintaan` time NOT NULL,
  `tgl_sampel` date NOT NULL,
  `jam_sampel` time NOT NULL,
  `tgl_hasil` date NOT NULL,
  `jam_hasil` time NOT NULL,
  `dokter_perujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('ralan','ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `informasi_tambahan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_klinis` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`noorder`) USING BTREE,
  INDEX `dokter_perujuk`(`dokter_perujuk`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `permintaan_lab_ibfk_2` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_lab_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permintaan_pemeriksaan_lab
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_pemeriksaan_lab`;
CREATE TABLE `permintaan_pemeriksaan_lab`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_bayar` enum('Sudah','Belum') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`noorder`, `kd_jenis_prw`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `permintaan_pemeriksaan_lab_ibfk_1` FOREIGN KEY (`noorder`) REFERENCES `permintaan_lab` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_pemeriksaan_lab_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permintaan_pemeriksaan_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_pemeriksaan_radiologi`;
CREATE TABLE `permintaan_pemeriksaan_radiologi`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `stts_bayar` enum('Sudah','Belum') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`noorder`, `kd_jenis_prw`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `permintaan_pemeriksaan_radiologi_ibfk_1` FOREIGN KEY (`noorder`) REFERENCES `permintaan_radiologi` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_pemeriksaan_radiologi_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permintaan_perbaikan_inventaris
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_perbaikan_inventaris`;
CREATE TABLE `permintaan_perbaikan_inventaris`  (
  `no_permintaan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_inventaris` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` datetime NULL DEFAULT NULL,
  `deskripsi_kerusakan` varchar(300) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_permintaan`) USING BTREE,
  INDEX `no_inventaris`(`no_inventaris`) USING BTREE,
  INDEX `nik`(`nik`) USING BTREE,
  CONSTRAINT `permintaan_perbaikan_inventaris_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_perbaikan_inventaris_ibfk_2` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permintaan_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `permintaan_radiologi`;
CREATE TABLE `permintaan_radiologi`  (
  `noorder` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_permintaan` date NOT NULL,
  `jam_permintaan` time NOT NULL,
  `tgl_sampel` date NOT NULL,
  `jam_sampel` time NOT NULL,
  `tgl_hasil` date NOT NULL,
  `jam_hasil` time NOT NULL,
  `dokter_perujuk` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('ralan','ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `informasi_tambahan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_klinis` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`noorder`) USING BTREE,
  INDEX `dokter_perujuk`(`dokter_perujuk`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `permintaan_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_radiologi_ibfk_3` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for personal_pasien
-- ----------------------------
DROP TABLE IF EXISTS `personal_pasien`;
CREATE TABLE `personal_pasien`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gambar` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`) USING BTREE,
  CONSTRAINT `personal_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for perusahaan_pasien
-- ----------------------------
DROP TABLE IF EXISTS `perusahaan_pasien`;
CREATE TABLE `perusahaan_pasien`  (
  `kode_perusahaan` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_perusahaan` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kota` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(27) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_perusahaan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for petugas
-- ----------------------------
DROP TABLE IF EXISTS `petugas`;
CREATE TABLE `petugas`  (
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tmp_lahir` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `agama` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_jbtn` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`nip`) USING BTREE,
  INDEX `kd_jbtn`(`kd_jbtn`) USING BTREE,
  INDEX `nama`(`nama`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `tmp_lahir`(`tmp_lahir`) USING BTREE,
  INDEX `tgl_lahir`(`tgl_lahir`) USING BTREE,
  INDEX `agama`(`agama`) USING BTREE,
  INDEX `stts_nikah`(`stts_nikah`) USING BTREE,
  INDEX `alamat`(`alamat`) USING BTREE,
  CONSTRAINT `petugas_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `petugas_ibfk_5` FOREIGN KEY (`kd_jbtn`) REFERENCES `jabatan` (`kd_jbtn`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for poliklinik
-- ----------------------------
DROP TABLE IF EXISTS `poliklinik`;
CREATE TABLE `poliklinik`  (
  `kd_poli` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nm_poli` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `registrasi` double NOT NULL,
  `registrasilama` double NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_poli`) USING BTREE,
  INDEX `nm_poli`(`nm_poli`) USING BTREE,
  INDEX `registrasi`(`registrasi`) USING BTREE,
  INDEX `registrasilama`(`registrasilama`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for propinsi
-- ----------------------------
DROP TABLE IF EXISTS `propinsi`;
CREATE TABLE `propinsi`  (
  `kd_prop` int(11) NOT NULL AUTO_INCREMENT,
  `nm_prop` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kd_prop`) USING BTREE,
  UNIQUE INDEX `nm_prop`(`nm_prop`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for prosedur_pasien
-- ----------------------------
DROP TABLE IF EXISTS `prosedur_pasien`;
CREATE TABLE `prosedur_pasien`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas` tinyint(4) NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode`, `status`) USING BTREE,
  INDEX `kode`(`kode`) USING BTREE,
  CONSTRAINT `prosedur_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prosedur_pasien_ibfk_2` FOREIGN KEY (`kode`) REFERENCES `icd9` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rawat_inap_dr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_dr`;
CREATE TABLE `rawat_inap_dr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `kd_dokter`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `tgl_perawatan`(`tgl_perawatan`) USING BTREE,
  INDEX `biaya_rawat`(`biaya_rawat`) USING BTREE,
  INDEX `jam_rawat`(`jam_rawat`) USING BTREE,
  CONSTRAINT `rawat_inap_dr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_dr_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_dr_ibfk_7` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rawat_inap_drpr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_drpr`;
CREATE TABLE `rawat_inap_drpr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  `tarif_tindakanpr` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `kd_dokter`, `nip`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `rawat_inap_drpr_ibfk_2`(`kd_jenis_prw`) USING BTREE,
  INDEX `rawat_inap_drpr_ibfk_3`(`kd_dokter`) USING BTREE,
  INDEX `rawat_inap_drpr_ibfk_4`(`nip`) USING BTREE,
  CONSTRAINT `rawat_inap_drpr_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rawat_inap_pr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_inap_pr`;
CREATE TABLE `rawat_inap_pr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `nip`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `biaya_rawat`(`biaya_rawat`) USING BTREE,
  CONSTRAINT `rawat_inap_pr_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_pr_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_pr_ibfk_7` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rawat_jl_dr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_dr`;
CREATE TABLE `rawat_jl_dr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum','Suspen') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `kd_dokter`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `biaya_rawat`(`biaya_rawat`) USING BTREE,
  CONSTRAINT `rawat_jl_dr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_dr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_dr_ibfk_5` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rawat_jl_drpr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_drpr`;
CREATE TABLE `rawat_jl_drpr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double NULL DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  `tarif_tindakanpr` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum','Suspen') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `kd_dokter`, `nip`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `rawat_jl_drpr_ibfk_2`(`kd_jenis_prw`) USING BTREE,
  INDEX `rawat_jl_drpr_ibfk_3`(`kd_dokter`) USING BTREE,
  INDEX `rawat_jl_drpr_ibfk_4`(`nip`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `rawat_jl_drpr_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rawat_jl_pr
-- ----------------------------
DROP TABLE IF EXISTS `rawat_jl_pr`;
CREATE TABLE `rawat_jl_pr`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_rawat` double NULL DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum','Suspen') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `nip`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `biaya_rawat`(`biaya_rawat`) USING BTREE,
  CONSTRAINT `rawat_jl_pr_ibfk_10` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_pr_ibfk_8` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_pr_ibfk_9` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reg_periksa
-- ----------------------------
DROP TABLE IF EXISTS `reg_periksa`;
CREATE TABLE `reg_periksa`  (
  `no_reg` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_registrasi` date NULL DEFAULT NULL,
  `jam_reg` time NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `p_jawab` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `almt_pj` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hubunganpj` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `biaya_reg` double NULL DEFAULT NULL,
  `stts` enum('Belum','Sudah','Batal','Berkas Diterima','Dirujuk','Meninggal','Dirawat','Pulang Paksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_daftar` enum('-','Lama','Baru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_lanjut` enum('Ralan','Ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `umurdaftar` int(11) NULL DEFAULT NULL,
  `sttsumur` enum('Th','Bl','Hr') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_bayar` enum('Sudah Bayar','Belum Bayar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_poli` enum('Lama','Baru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  INDEX `kd_poli`(`kd_poli`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  INDEX `status_lanjut`(`status_lanjut`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `status_bayar`(`status_bayar`) USING BTREE,
  CONSTRAINT `reg_periksa_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_6` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_7` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rekap_presensi
-- ----------------------------
DROP TABLE IF EXISTS `rekap_presensi`;
CREATE TABLE `rekap_presensi`  (
  `id` int(11) NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam_datang` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `jam_pulang` datetime NULL DEFAULT NULL,
  `status` enum('Tepat Waktu','Terlambat Toleransi','Terlambat I','Terlambat II','Tepat Waktu & PSW','Terlambat Toleransi & PSW','Terlambat I & PSW','Terlambat II & PSW') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterlambatan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`, `jam_datang`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  CONSTRAINT `rekap_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resep_dokter
-- ----------------------------
DROP TABLE IF EXISTS `resep_dokter`;
CREATE TABLE `resep_dokter`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml` double NULL DEFAULT NULL,
  `aturan_pakai` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_resep`(`no_resep`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `resep_dokter_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resep_dokter_racikan
-- ----------------------------
DROP TABLE IF EXISTS `resep_dokter_racikan`;
CREATE TABLE `resep_dokter_racikan`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_racik` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_racik` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml_dr` int(11) NOT NULL,
  `aturan_pakai` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_resep`, `no_racik`) USING BTREE,
  INDEX `kd_racik`(`kd_racik`) USING BTREE,
  CONSTRAINT `resep_dokter_racikan_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_racikan_ibfk_2` FOREIGN KEY (`kd_racik`) REFERENCES `metode_racik` (`kd_racik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resep_dokter_racikan_detail
-- ----------------------------
DROP TABLE IF EXISTS `resep_dokter_racikan_detail`;
CREATE TABLE `resep_dokter_racikan_detail`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `p1` double NULL DEFAULT NULL,
  `p2` double NULL DEFAULT NULL,
  `kandungan` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_resep`, `no_racik`, `kode_brng`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `resep_dokter_racikan_detail_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_racikan_detail_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resep_obat
-- ----------------------------
DROP TABLE IF EXISTS `resep_obat`;
CREATE TABLE `resep_obat`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_perawatan` date NULL DEFAULT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_peresepan` date NULL DEFAULT NULL,
  `jam_peresepan` time NULL DEFAULT NULL,
  `status` enum('ralan','ranap') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_penyerahan` date NOT NULL,
  `jam_penyerahan` time NOT NULL,
  PRIMARY KEY (`no_resep`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `resep_obat_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `resep_obat_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resep_pulang
-- ----------------------------
DROP TABLE IF EXISTS `resep_pulang`;
CREATE TABLE `resep_pulang`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jml_barang` double NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  `dosis` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `kd_bangsal` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode_brng`, `tanggal`, `jam`, `no_batch`, `no_faktur`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `resep_pulang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_pulang_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `resep_pulang_ibfk_4` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resiko_kerja
-- ----------------------------
DROP TABLE IF EXISTS `resiko_kerja`;
CREATE TABLE `resiko_kerja`  (
  `kode_resiko` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_resiko` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `indek` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`kode_resiko`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resume_pasien
-- ----------------------------
DROP TABLE IF EXISTS `resume_pasien`;
CREATE TABLE `resume_pasien`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jalannya_penyakit` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_penunjang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hasil_laborat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_utama` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_utama` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder2` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder2` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder3` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder3` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder4` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder4` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_utama` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_utama` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder2` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder2` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder3` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder3` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kondisi_pulang` enum('Hidup','Meninggal') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `obat_pulang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `resume_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resume_pasien_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resume_pasien_ranap
-- ----------------------------
DROP TABLE IF EXISTS `resume_pasien_ranap`;
CREATE TABLE `resume_pasien_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_awal` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alasan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_fisik` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jalannya_penyakit` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemeriksaan_penunjang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hasil_laborat` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tindakan_dan_operasi` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `obat_di_rs` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_utama` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_utama` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder2` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder2` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder3` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder3` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_sekunder4` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diagnosa_sekunder4` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_utama` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_utama` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder2` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder2` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prosedur_sekunder3` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_prosedur_sekunder3` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alergi` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diet` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lab_belum` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `edukasi` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cara_keluar` enum('Atas Izin Dokter','Pindah RS','Pulang Atas Permintaan Sendiri','Lainnya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_keluar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keadaan` enum('Membaik','Sembuh','Keadaan Khusus','Meninggal') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_keadaan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dilanjutkan` enum('Kembali Ke RS','RS Lain','Dokter Luar','Puskesmes','Lainnya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ket_dilanjutkan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontrol` datetime NULL DEFAULT NULL,
  `obat_pulang` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `resume_pasien_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resume_pasien_ranap_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for riwayat_barang_medis
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_barang_medis`;
CREATE TABLE `riwayat_barang_medis`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stok_awal` double NULL DEFAULT NULL,
  `masuk` double NULL DEFAULT NULL,
  `keluar` double NULL DEFAULT NULL,
  `stok_akhir` double NOT NULL,
  `posisi` enum('Pemberian Obat','Pengadaan','Penerimaan','Piutang','Retur Beli','Retur Jual','Retur Piutang','Mutasi','Opname','Resep Pulang','Retur Pasien','Stok Pasien Ranap','Pengambilan Medis','Penjualan','Stok Keluar','Hibah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `jam` time NULL DEFAULT NULL,
  `petugas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Simpan','Hapus') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  INDEX `riwayat_barang_medis_ibfk_1`(`kode_brng`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal`) USING BTREE,
  CONSTRAINT `riwayat_barang_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `riwayat_barang_medis_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ruang_ok
-- ----------------------------
DROP TABLE IF EXISTS `ruang_ok`;
CREATE TABLE `ruang_ok`  (
  `kd_ruang_ok` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_ruang_ok` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_ruang_ok`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for services
-- ----------------------------
DROP TABLE IF EXISTS `services`;
CREATE TABLE `services`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `price` decimal(10, 2) NULL DEFAULT 0.00,
  `duration_minutes` int(11) NULL DEFAULT 30,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_active` tinyint(1) NULL DEFAULT 1,
  `requires_appointment` tinyint(1) NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_services_category`(`category`) USING BTREE,
  INDEX `idx_services_active`(`is_active`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for set_keterlambatan
-- ----------------------------
DROP TABLE IF EXISTS `set_keterlambatan`;
CREATE TABLE `set_keterlambatan`  (
  `toleransi` int(11) NULL DEFAULT NULL,
  `terlambat1` int(11) NULL DEFAULT NULL,
  `terlambat2` int(11) NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for set_no_rkm_medis
-- ----------------------------
DROP TABLE IF EXISTS `set_no_rkm_medis`;
CREATE TABLE `set_no_rkm_medis`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for skdp_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `skdp_bpjs`;
CREATE TABLE `skdp_bpjs`  (
  `tahun` year NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosa` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `terapi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alasan1` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alasan2` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rtl1` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rtl2` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_datang` datetime NULL DEFAULT NULL,
  `tanggal_rujukan` datetime NOT NULL,
  `no_antrian` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Menunggu','Sudah Periksa','Batal Periksa') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tahun`, `no_antrian`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `skdp_bpjs_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `skdp_bpjs_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for spesialis
-- ----------------------------
DROP TABLE IF EXISTS `spesialis`;
CREATE TABLE `spesialis`  (
  `kd_sps` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nm_sps` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_sps`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stts_kerja
-- ----------------------------
DROP TABLE IF EXISTS `stts_kerja`;
CREATE TABLE `stts_kerja`  (
  `stts` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ktg` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `indek` tinyint(4) NOT NULL,
  PRIMARY KEY (`stts`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stts_wp
-- ----------------------------
DROP TABLE IF EXISTS `stts_wp`;
CREATE TABLE `stts_wp`  (
  `stts` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ktg` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`stts`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for suku_bangsa
-- ----------------------------
DROP TABLE IF EXISTS `suku_bangsa`;
CREATE TABLE `suku_bangsa`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_suku_bangsa` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nama_suku_bangsa`(`nama_suku_bangsa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for tambahan_biaya
-- ----------------------------
DROP TABLE IF EXISTS `tambahan_biaya`;
CREATE TABLE `tambahan_biaya`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_biaya` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `besar_biaya` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `nama_biaya`) USING BTREE,
  CONSTRAINT `tambahan_biaya_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for template_laboratorium
-- ----------------------------
DROP TABLE IF EXISTS `template_laboratorium`;
CREATE TABLE `template_laboratorium`  (
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_template` int(11) NOT NULL AUTO_INCREMENT,
  `Pemeriksaan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `satuan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan_ld` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan_la` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan_pd` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nilai_rujukan_pa` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double NULL DEFAULT NULL,
  `menejemen` double NULL DEFAULT NULL,
  `biaya_item` double NOT NULL,
  `urut` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_template`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `Pemeriksaan`(`Pemeriksaan`) USING BTREE,
  INDEX `satuan`(`satuan`) USING BTREE,
  INDEX `nilai_rujukan_ld`(`nilai_rujukan_ld`) USING BTREE,
  INDEX `nilai_rujukan_la`(`nilai_rujukan_la`) USING BTREE,
  INDEX `nilai_rujukan_pd`(`nilai_rujukan_pd`) USING BTREE,
  INDEX `nilai_rujukan_pa`(`nilai_rujukan_pa`) USING BTREE,
  INDEX `bagian_rs`(`bagian_rs`) USING BTREE,
  INDEX `bhp`(`bhp`) USING BTREE,
  INDEX `bagian_perujuk`(`bagian_perujuk`) USING BTREE,
  INDEX `bagian_dokter`(`bagian_dokter`) USING BTREE,
  INDEX `bagian_laborat`(`bagian_laborat`) USING BTREE,
  INDEX `kso`(`kso`) USING BTREE,
  INDEX `menejemen`(`menejemen`) USING BTREE,
  INDEX `biaya_item`(`biaya_item`) USING BTREE,
  INDEX `urut`(`urut`) USING BTREE,
  CONSTRAINT `template_laboratorium_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for temporary_presensi
-- ----------------------------
DROP TABLE IF EXISTS `temporary_presensi`;
CREATE TABLE `temporary_presensi`  (
  `id` int(11) NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam_datang` datetime NULL DEFAULT NULL,
  `jam_pulang` datetime NULL DEFAULT NULL,
  `status` enum('Tepat Waktu','Terlambat Toleransi','Terlambat I','Terlambat II','Tepat Waktu & PSW','Terlambat Toleransi & PSW','Terlambat I & PSW','Terlambat II & PSW') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterlambatan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `durasi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `temporary_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role` enum('super_admin','admin','staff','doctor') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'staff',
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'active',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `two_factor_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `two_factor_recovery_codes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `profile_photo_path` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  INDEX `idx_users_email`(`email`) USING BTREE,
  INDEX `idx_users_role`(`role`) USING BTREE,
  INDEX `idx_users_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for utd_donor
-- ----------------------------
DROP TABLE IF EXISTS `utd_donor`;
CREATE TABLE `utd_donor`  (
  `no_donor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_pendonor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tensi` varchar(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_bag` int(11) NULL DEFAULT NULL,
  `jenis_bag` enum('SB','DB','TB','QB') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jenis_donor` enum('DB','DP','DS') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tempat_aftap` enum('Dalam Gedung','Luar Gedung') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas_aftap` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hbsag` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hcv` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hiv` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spilis` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `malaria` enum('Negatif','Positif') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `petugas_u_saring` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Aman','Cekal') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_donor`) USING BTREE,
  INDEX `petugas_aftap`(`petugas_aftap`) USING BTREE,
  INDEX `petugas_u_saring`(`petugas_u_saring`) USING BTREE,
  INDEX `no_pendonor`(`no_pendonor`) USING BTREE,
  CONSTRAINT `utd_donor_ibfk_1` FOREIGN KEY (`petugas_aftap`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_donor_ibfk_2` FOREIGN KEY (`petugas_u_saring`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_donor_ibfk_3` FOREIGN KEY (`no_pendonor`) REFERENCES `utd_pendonor` (`no_pendonor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for utd_komponen_darah
-- ----------------------------
DROP TABLE IF EXISTS `utd_komponen_darah`;
CREATE TABLE `utd_komponen_darah`  (
  `kode` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lama` smallint(6) NULL DEFAULT NULL,
  `jasa_sarana` double NULL DEFAULT NULL,
  `paket_bhp` double NULL DEFAULT NULL,
  `kso` double NULL DEFAULT NULL,
  `manajemen` double NULL DEFAULT NULL,
  `total` double NULL DEFAULT NULL,
  `pembatalan` double NULL DEFAULT NULL,
  PRIMARY KEY (`kode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for utd_pendonor
-- ----------------------------
DROP TABLE IF EXISTS `utd_pendonor`;
CREATE TABLE `utd_pendonor`  (
  `no_pendonor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_ktp` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jk` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tmp_lahir` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_kel` int(11) NOT NULL,
  `kd_kec` int(11) NOT NULL,
  `kd_kab` int(11) NOT NULL,
  `kd_prop` int(11) NOT NULL,
  `golongan_darah` enum('A','AB','B','O') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `resus` enum('(-)','(+)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_telp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_pendonor`) USING BTREE,
  INDEX `kd_kec`(`kd_kec`) USING BTREE,
  INDEX `kd_kab`(`kd_kab`) USING BTREE,
  INDEX `kd_prop`(`kd_prop`) USING BTREE,
  INDEX `kd_kel`(`kd_kel`) USING BTREE,
  CONSTRAINT `utd_pendonor_ibfk_1` FOREIGN KEY (`kd_kec`) REFERENCES `kecamatan` (`kd_kec`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `utd_pendonor_ibfk_2` FOREIGN KEY (`kd_kab`) REFERENCES `kabupaten` (`kd_kab`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `utd_pendonor_ibfk_3` FOREIGN KEY (`kd_prop`) REFERENCES `propinsi` (`kd_prop`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for utd_stok_darah
-- ----------------------------
DROP TABLE IF EXISTS `utd_stok_darah`;
CREATE TABLE `utd_stok_darah`  (
  `no_kantong` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_komponen` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `golongan_darah` enum('A','AB','B','O') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `resus` enum('(-)','(+)') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_aftap` date NULL DEFAULT NULL,
  `tanggal_kadaluarsa` date NULL DEFAULT NULL,
  `asal_darah` enum('Hibah','Beli','Produksi Sendiri') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Ada','Diambil','Dimusnahkan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_kantong`) USING BTREE,
  INDEX `kode_komponen`(`kode_komponen`) USING BTREE,
  CONSTRAINT `utd_stok_darah_ibfk_1` FOREIGN KEY (`kode_komponen`) REFERENCES `utd_komponen_darah` (`kode`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for view_periksa_tindakan
-- ----------------------------
DROP VIEW IF EXISTS `view_periksa_tindakan`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_periksa_tindakan` AS select 1 AS `jenis`,1 AS `no_rawat`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `tgl_perawatan`,1 AS `jam_rawat`;

-- ----------------------------
-- View structure for view_rujukan_bulanan
-- ----------------------------
DROP VIEW IF EXISTS `view_rujukan_bulanan`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_rujukan_bulanan` AS select 1 AS `Nama_Poli`,1 AS `Total_Rujukan`,1 AS `Asal_Rujukan`;

-- ----------------------------
-- View structure for view_tindakan_medis_semua
-- ----------------------------
DROP VIEW IF EXISTS `view_tindakan_medis_semua`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_tindakan_medis_semua` AS select 1 AS `tgl_perawatan`,1 AS `jam_rawat`,1 AS `no_rawat`,1 AS `kd_jenis_prw`,1 AS `nm_tindakan`,1 AS `id_petugas`,1 AS `peran`,1 AS `bhp`,1 AS `material`,1 AS `tarif_dokter`,1 AS `tarif_perawat`,1 AS `biaya_rawat`,1 AS `sumber`;

-- ----------------------------
-- View structure for v_alamat_pasien
-- ----------------------------
DROP VIEW IF EXISTS `v_alamat_pasien`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_alamat_pasien` AS select `p`.`no_rkm_medis` AS `no_rkm_medis`,`p`.`nm_pasien` AS `nm_pasien`,`p`.`alamat` AS `alamat`,`kel`.`nm_kel` AS `nm_kel`,`kec`.`nm_kec` AS `nm_kec`,`kab`.`nm_kab` AS `nm_kab`,`prop`.`nm_prop` AS `nm_prop` from ((((`pasien` `p` join `kelurahan` `kel` on((`kel`.`kd_kel` = `p`.`kd_kel`))) join `kecamatan` `kec` on((`kec`.`kd_kec` = `p`.`kd_kec`))) join `kabupaten` `kab` on((`kab`.`kd_kab` = `p`.`kd_kab`))) join `propinsi` `prop` on((`prop`.`kd_prop` = `p`.`kd_prop`)));

-- ----------------------------
-- View structure for v_billing_ralan_dokter
-- ----------------------------
DROP VIEW IF EXISTS `v_billing_ralan_dokter`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_billing_ralan_dokter` AS select 1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `kd_dokter`,1 AS `tgl_perawatan`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya_rawat`;

-- ----------------------------
-- View structure for v_billing_ralan_dokter_petugas
-- ----------------------------
DROP VIEW IF EXISTS `v_billing_ralan_dokter_petugas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_billing_ralan_dokter_petugas` AS select 1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `kd_dokter`,1 AS `nip`,1 AS `tgl_perawatan`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya_rawat`;

-- ----------------------------
-- View structure for v_billing_ralan_lab
-- ----------------------------
DROP VIEW IF EXISTS `v_billing_ralan_lab`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_billing_ralan_lab` AS select 1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `kd_dokter`,1 AS `nip`,1 AS `tgl_periksa`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya_rawat`;

-- ----------------------------
-- View structure for v_billing_ralan_petugas
-- ----------------------------
DROP VIEW IF EXISTS `v_billing_ralan_petugas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_billing_ralan_petugas` AS select 1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `nip`,1 AS `tgl_perawatan`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya_rawat`;

-- ----------------------------
-- View structure for v_billing_ralan_radiologi
-- ----------------------------
DROP VIEW IF EXISTS `v_billing_ralan_radiologi`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_billing_ralan_radiologi` AS select 1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `kd_dokter`,1 AS `nip`,1 AS `tgl_periksa`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya_rawat`;

-- ----------------------------
-- View structure for v_billing_ranap_dokter
-- ----------------------------
DROP VIEW IF EXISTS `v_billing_ranap_dokter`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_billing_ranap_dokter` AS select 1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `kd_dokter`,1 AS `tgl_perawatan`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya_rawat`;

-- ----------------------------
-- View structure for v_billing_ranap_dokter_petugas
-- ----------------------------
DROP VIEW IF EXISTS `v_billing_ranap_dokter_petugas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_billing_ranap_dokter_petugas` AS select 1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `kd_dokter`,1 AS `nip`,1 AS `tgl_perawatan`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya_rawat`;

-- ----------------------------
-- View structure for v_billing_ranap_petugas
-- ----------------------------
DROP VIEW IF EXISTS `v_billing_ranap_petugas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_billing_ranap_petugas` AS select 1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `nip`,1 AS `tgl_perawatan`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya_rawat`;

-- ----------------------------
-- View structure for v_detail_tindakan_medis
-- ----------------------------
DROP VIEW IF EXISTS `v_detail_tindakan_medis`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_detail_tindakan_medis` AS select 1 AS `tgl_perawatan`,1 AS `jam_rawat`,1 AS `no_rawat`,1 AS `kd_jenis_prw`,1 AS `nm_tindakan`,1 AS `nm_kategori`,1 AS `id_petugas`,1 AS `peran`,1 AS `bhp`,1 AS `material`,1 AS `tarif_dokter`,1 AS `tarif_perawat`,1 AS `biaya_rawat`,1 AS `sumber`;

-- ----------------------------
-- View structure for v_kamar_pasien
-- ----------------------------
DROP VIEW IF EXISTS `v_kamar_pasien`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_kamar_pasien` AS select 1 AS `no_rawat`,1 AS `kode`,1 AS `kategori`,1 AS `nama`,1 AS `biaya`,1 AS `jumlah`;

-- ----------------------------
-- View structure for v_tindakan_billing_all
-- ----------------------------
DROP VIEW IF EXISTS `v_tindakan_billing_all`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_tindakan_billing_all` AS select 1 AS `visit_id`,1 AS `no_rawat`,1 AS `nm_kategori`,1 AS `kd_jenis_prw`,1 AS `nm_perawatan`,1 AS `kd_dokter`,1 AS `nip`,1 AS `tgl_perawatan`,1 AS `jasa_rs`,1 AS `jasa_dr`,1 AS `jasa_pr`,1 AS `biaya`,1 AS `kategori`,1 AS `urutan`;

-- ----------------------------
-- View structure for v_tindakan_ralan_dokter
-- ----------------------------
DROP VIEW IF EXISTS `v_tindakan_ralan_dokter`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_tindakan_ralan_dokter` AS select 1 AS `no_rawat`,1 AS `jenis_jasa`,1 AS `kd_jenis_prw`,1 AS `jasa_dokter`,1 AS `jasa_perawat`,1 AS `jasa_rs`;

-- ----------------------------
-- View structure for v_tindakan_ralan_perawat
-- ----------------------------
DROP VIEW IF EXISTS `v_tindakan_ralan_perawat`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_tindakan_ralan_perawat` AS select 1 AS `no_rawat`,1 AS `jenis_jasa`,1 AS `kd_jenis_prw`,1 AS `jasa_dokter`,1 AS `jasa_perawat`,1 AS `jasa_rs`;

-- ----------------------------
-- View structure for v_user_info
-- ----------------------------
DROP VIEW IF EXISTS `v_user_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_user_info` AS select 1 AS `id`,1 AS `name`,1 AS `id_div`,1 AS `name_div`,1 AS `status`;

SET FOREIGN_KEY_CHECKS = 1;
