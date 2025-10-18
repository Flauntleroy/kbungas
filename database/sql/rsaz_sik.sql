/*
 Navicat Premium Data Transfer

 Source Server         : Master N
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44-log)
 Source Host           : 192.168.0.3:3939
 Source Schema         : rsaz_sik

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44-log)
 File Encoding         : 65001

 Date: 18/10/2025 12:43:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity_log
-- ----------------------------
DROP TABLE IF EXISTS `activity_log`;
CREATE TABLE `activity_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `action` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `details` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 275 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for activity_simandai
-- ----------------------------
DROP TABLE IF EXISTS `activity_simandai`;
CREATE TABLE `activity_simandai`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4847 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `usere` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `passworde` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for akun_aset_inventaris
-- ----------------------------
DROP TABLE IF EXISTS `akun_aset_inventaris`;
CREATE TABLE `akun_aset_inventaris`  (
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_jenis` char(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_jenis`) USING BTREE,
  INDEX `kd_rek`(`kd_rek`) USING BTREE,
  CONSTRAINT `akun_aset_inventaris_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `akun_aset_inventaris_ibfk_2` FOREIGN KEY (`id_jenis`) REFERENCES `inventaris_jenis` (`id_jenis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for akun_bayar
-- ----------------------------
DROP TABLE IF EXISTS `akun_bayar`;
CREATE TABLE `akun_bayar`  (
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ppn` double NULL DEFAULT NULL,
  PRIMARY KEY (`nama_bayar`) USING BTREE,
  INDEX `akun_bayar_ibfk_1`(`kd_rek`) USING BTREE,
  INDEX `ppn`(`ppn`) USING BTREE,
  CONSTRAINT `akun_bayar_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for akun_bayar_hutang
-- ----------------------------
DROP TABLE IF EXISTS `akun_bayar_hutang`;
CREATE TABLE `akun_bayar_hutang`  (
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`nama_bayar`) USING BTREE,
  INDEX `kd_rek`(`kd_rek`) USING BTREE,
  CONSTRAINT `akun_bayar_hutang_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for akun_penagihan_piutang
-- ----------------------------
DROP TABLE IF EXISTS `akun_penagihan_piutang`;
CREATE TABLE `akun_penagihan_piutang`  (
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_bank` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `atas_nama` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rek` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kd_rek`) USING BTREE,
  CONSTRAINT `akun_penagihan_piutang_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for akun_piutang
-- ----------------------------
DROP TABLE IF EXISTS `akun_piutang`;
CREATE TABLE `akun_piutang`  (
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_pj` char(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`nama_bayar`) USING BTREE,
  UNIQUE INDEX `kd_rek_2`(`kd_rek`, `kd_pj`) USING BTREE,
  INDEX `kd_rek`(`kd_rek`) USING BTREE,
  INDEX `kd_pj`(`kd_pj`) USING BTREE,
  CONSTRAINT `akun_piutang_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `akun_piutang_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alergi_pasien
-- ----------------------------
DROP TABLE IF EXISTS `alergi_pasien`;
CREATE TABLE `alergi_pasien`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` datetime NOT NULL,
  `allergy_code` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `category` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nippetugas` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `note` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `reactioncode` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `severity` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kode_brng`(`allergy_code`) USING BTREE,
  CONSTRAINT `alergi_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ambil_dankes
-- ----------------------------
DROP TABLE IF EXISTS `ambil_dankes`;
CREATE TABLE `ambil_dankes`  (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `ktg` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dankes` double NOT NULL,
  PRIMARY KEY (`id`, `tanggal`) USING BTREE,
  INDEX `ktg`(`ktg`) USING BTREE,
  INDEX `dankes`(`dankes`) USING BTREE,
  CONSTRAINT `ambil_dankes_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for angsuran_koperasi
-- ----------------------------
DROP TABLE IF EXISTS `angsuran_koperasi`;
CREATE TABLE `angsuran_koperasi`  (
  `id` int(11) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_angsur` date NOT NULL,
  `pokok` double NOT NULL,
  `jasa` double NOT NULL,
  PRIMARY KEY (`id`, `tanggal_pinjam`, `tanggal_angsur`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `pokok`(`pokok`) USING BTREE,
  INDEX `jasa`(`jasa`) USING BTREE,
  CONSTRAINT `angsuran_koperasi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antriapotek
-- ----------------------------
DROP TABLE IF EXISTS `antriapotek`;
CREATE TABLE `antriapotek`  (
  `loket` int(11) NOT NULL,
  `antrian` int(11) NOT NULL,
  INDEX `loket`(`loket`) USING BTREE,
  INDEX `antrian`(`antrian`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antriapotek2
-- ----------------------------
DROP TABLE IF EXISTS `antriapotek2`;
CREATE TABLE `antriapotek2`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antriapotek3
-- ----------------------------
DROP TABLE IF EXISTS `antriapotek3`;
CREATE TABLE `antriapotek3`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antriaps
-- ----------------------------
DROP TABLE IF EXISTS `antriaps`;
CREATE TABLE `antriaps`  (
  `no_pernyataan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antrilabmb
-- ----------------------------
DROP TABLE IF EXISTS `antrilabmb`;
CREATE TABLE `antrilabmb`  (
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antrilabmb2
-- ----------------------------
DROP TABLE IF EXISTS `antrilabmb2`;
CREATE TABLE `antrilabmb2`  (
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antrilabpa
-- ----------------------------
DROP TABLE IF EXISTS `antrilabpa`;
CREATE TABLE `antrilabpa`  (
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antrilabpa2
-- ----------------------------
DROP TABLE IF EXISTS `antrilabpa2`;
CREATE TABLE `antrilabpa2`  (
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antrilabpk
-- ----------------------------
DROP TABLE IF EXISTS `antrilabpk`;
CREATE TABLE `antrilabpk`  (
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antrilabpk2
-- ----------------------------
DROP TABLE IF EXISTS `antrilabpk2`;
CREATE TABLE `antrilabpk2`  (
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antriloket
-- ----------------------------
DROP TABLE IF EXISTS `antriloket`;
CREATE TABLE `antriloket`  (
  `loket` int(11) NOT NULL,
  `antrian` int(11) NOT NULL,
  INDEX `loket`(`loket`) USING BTREE,
  INDEX `antrian`(`antrian`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antriloketcetak
-- ----------------------------
DROP TABLE IF EXISTS `antriloketcetak`;
CREATE TABLE `antriloketcetak`  (
  `tanggal` date NOT NULL,
  `jam` time NULL DEFAULT NULL,
  `nomor` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tanggal`, `nomor`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripemulangan
-- ----------------------------
DROP TABLE IF EXISTS `antripemulangan`;
CREATE TABLE `antripemulangan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripengkajianrestrain
-- ----------------------------
DROP TABLE IF EXISTS `antripengkajianrestrain`;
CREATE TABLE `antripengkajianrestrain`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripenolakananjuranmedis
-- ----------------------------
DROP TABLE IF EXISTS `antripenolakananjuranmedis`;
CREATE TABLE `antripenolakananjuranmedis`  (
  `no_surat` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_surat`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripenundaanpelayanan
-- ----------------------------
DROP TABLE IF EXISTS `antripenundaanpelayanan`;
CREATE TABLE `antripenundaanpelayanan`  (
  `no_surat` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripernyataanumum
-- ----------------------------
DROP TABLE IF EXISTS `antripernyataanumum`;
CREATE TABLE `antripernyataanumum`  (
  `no_pernyataan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripersetujuan
-- ----------------------------
DROP TABLE IF EXISTS `antripersetujuan`;
CREATE TABLE `antripersetujuan`  (
  `no_pernyataan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripersetujuanrawatinap
-- ----------------------------
DROP TABLE IF EXISTS `antripersetujuanrawatinap`;
CREATE TABLE `antripersetujuanrawatinap`  (
  `no_persetujuan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripersetujuantransferantarruang
-- ----------------------------
DROP TABLE IF EXISTS `antripersetujuantransferantarruang`;
CREATE TABLE `antripersetujuantransferantarruang`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal_masuk` datetime NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripersetujuanumum
-- ----------------------------
DROP TABLE IF EXISTS `antripersetujuanumum`;
CREATE TABLE `antripersetujuanumum`  (
  `no_surat` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antripoli
-- ----------------------------
DROP TABLE IF EXISTS `antripoli`;
CREATE TABLE `antripoli`  (
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for antriradiologi
-- ----------------------------
DROP TABLE IF EXISTS `antriradiologi`;
CREATE TABLE `antriradiologi`  (
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for antriradiologi2
-- ----------------------------
DROP TABLE IF EXISTS `antriradiologi2`;
CREATE TABLE `antriradiologi2`  (
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = FIXED;

-- ----------------------------
-- Table structure for aplicare_ketersediaan_kamar
-- ----------------------------
DROP TABLE IF EXISTS `aplicare_ketersediaan_kamar`;
CREATE TABLE `aplicare_ketersediaan_kamar`  (
  `kode_kelas_aplicare` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_bangsal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Kelas 1',
  `kapasitas` int(11) NULL DEFAULT NULL,
  `tersedia` int(11) NULL DEFAULT NULL,
  `tersediapria` int(11) NULL DEFAULT NULL,
  `tersediawanita` int(11) NULL DEFAULT NULL,
  `tersediapriawanita` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`kode_kelas_aplicare`, `kd_bangsal`, `kelas`) USING BTREE,
  INDEX `kd_bangsal`(`kd_bangsal`) USING BTREE,
  INDEX `kapasitas`(`kapasitas`) USING BTREE,
  INDEX `tersedia`(`tersedia`) USING BTREE,
  INDEX `tersediapria`(`tersediapria`) USING BTREE,
  INDEX `tersediawanita`(`tersediawanita`) USING BTREE,
  INDEX `tersediapriawanita`(`tersediapriawanita`) USING BTREE,
  CONSTRAINT `aplicare_ketersediaan_kamar_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for asuhan_gizi
-- ----------------------------
DROP TABLE IF EXISTS `asuhan_gizi`;
CREATE TABLE `asuhan_gizi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `antropometri_bb` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `antropometri_tb` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `antropometri_imt` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `antropometri_lla` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `antropometri_tl` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `antropometri_ulna` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `antropometri_bbideal` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `antropometri_bbperu` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `antropometri_tbperu` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `antropometri_bbpertb` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `antropometri_llaperu` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biokimia` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fisik_klinis` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi_telur` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi_susu_sapi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi_kacang` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi_gluten` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi_udang` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi_ikan` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alergi_hazelnut` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pola_makan` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `riwayat_personal` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagnosis` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `intervensi_gizi` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_evaluasi` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `asuhan_gizi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `asuhan_gizi_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for asuransi
-- ----------------------------
DROP TABLE IF EXISTS `asuransi`;
CREATE TABLE `asuransi`  (
  `stts` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`stts`) USING BTREE,
  INDEX `biaya`(`biaya`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_bundle_iadp
-- ----------------------------
DROP TABLE IF EXISTS `audit_bundle_iadp`;
CREATE TABLE `audit_bundle_iadp`  (
  `tanggal` datetime NOT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `handhygiene` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `apd` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `skin_antiseptik` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lokasi_iv` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perawatan_rutin` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `nik`) USING BTREE,
  INDEX `nik`(`nik`) USING BTREE,
  CONSTRAINT `audit_bundle_iadp_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_bundle_ido
-- ----------------------------
DROP TABLE IF EXISTS `audit_bundle_ido`;
CREATE TABLE `audit_bundle_ido`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pencukuran_rambut` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `antibiotik` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `temperature` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sugar` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_bundle_ido_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_bundle_isk
-- ----------------------------
DROP TABLE IF EXISTS `audit_bundle_isk`;
CREATE TABLE `audit_bundle_isk`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemasangan_sesuai_indikasi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hand_hygiene` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `menggunakan_apd_yang_tepat` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemasangan_menggunakan_alat_steril` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `segera_dilepas_setelah_tidak_diperlukan` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pengisian_balon_sesuai_petunjuk` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fiksasi_kateter_dengan_plester` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `urinebag_menggantung_tidak_menyentuh_lantai` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_bundle_isk_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_bundle_plabsi
-- ----------------------------
DROP TABLE IF EXISTS `audit_bundle_plabsi`;
CREATE TABLE `audit_bundle_plabsi`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sebelum_melakukan_hand_hygiene` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `menggunakan_apd_lengkap` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lokasi_pemasangan_sesuai` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alat_yang_digunakan_steril` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pembersihan_kulit` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `setelah_melakukan_hand_hygiene` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perawatan_dressing_infus` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spoit_yang_digunakan_disposible` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `memberi_tanggal_dan_jam_pemasangan_infus` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `set_infus_setiap_72jam` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_bundle_plabsi_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_bundle_vap
-- ----------------------------
DROP TABLE IF EXISTS `audit_bundle_vap`;
CREATE TABLE `audit_bundle_vap`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `posisi_kepala` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pengkajian_setiap_hari` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hand_hygiene` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `oral_hygiene` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `suction_manajemen_sekresi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `profilaksis_peptic_ulcer` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `dvt_profiklasisi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penggunaan_apd_sesuai` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_bundle_vap_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_cuci_tangan_medis
-- ----------------------------
DROP TABLE IF EXISTS `audit_cuci_tangan_medis`;
CREATE TABLE `audit_cuci_tangan_medis`  (
  `tanggal` datetime NOT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sebelum_menyentuh_pasien` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sebelum_tehnik_aseptik` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `setelah_terpapar_cairan_tubuh_pasien` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `setelah_kontak_dengan_pasien` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `setelah_kontak_dengan_lingkungan_pasien` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `nik`) USING BTREE,
  INDEX `nik`(`nik`) USING BTREE,
  CONSTRAINT `audit_cuci_tangan_medis_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_fasilitas_apd
-- ----------------------------
DROP TABLE IF EXISTS `audit_fasilitas_apd`;
CREATE TABLE `audit_fasilitas_apd`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `audit1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_fasilitas_apd_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_fasilitas_kebersihan_tangan
-- ----------------------------
DROP TABLE IF EXISTS `audit_fasilitas_kebersihan_tangan`;
CREATE TABLE `audit_fasilitas_kebersihan_tangan`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `audit1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit9` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_fasilitas_kebersihan_tangan_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_kamar_jenazah
-- ----------------------------
DROP TABLE IF EXISTS `audit_kamar_jenazah`;
CREATE TABLE `audit_kamar_jenazah`  (
  `tanggal` datetime NOT NULL,
  `audit1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_kepatuhan_apd
-- ----------------------------
DROP TABLE IF EXISTS `audit_kepatuhan_apd`;
CREATE TABLE `audit_kepatuhan_apd`  (
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tindakan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `topi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `masker` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kacamata` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sarungtangan` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `apron` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sepatu` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`nik`, `tindakan`, `tanggal`) USING BTREE,
  CONSTRAINT `audit_kepatuhan_apd_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_pembuangan_benda_tajam
-- ----------------------------
DROP TABLE IF EXISTS `audit_pembuangan_benda_tajam`;
CREATE TABLE `audit_pembuangan_benda_tajam`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `setiap_injeksi_needle_langsung_dimasukkan_safety_box` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `setiap_pemasangan_iv_canula_langsung_dimasukkan_safety_box` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `setiap_benda_tajam_jarum_dimasukkan_safety_box` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `safety_box_tigaperempat_diganti` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `safety_box_keadaan_bersih` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `saftey_box_tertutup_setelah_digunakan` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_pembuangan_benda_tajam_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_pembuangan_limbah
-- ----------------------------
DROP TABLE IF EXISTS `audit_pembuangan_limbah`;
CREATE TABLE `audit_pembuangan_limbah`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemisahan_limbah_oleh_penghasil_limbah` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `limbah_infeksius_dimasukkan_kantong_kuning` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `limbah_noninfeksius_dimasukkan_kantong_hitam` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `limbah_tigaperempat_diikat` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `limbah_segera_dibawa_kepembuangan_sementara` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kotak_sampah_dalam_kondisi_bersih` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pembersihan_tempat_sampah_dengan_desinfekten` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pembersihan_penampungan_sementara_dengan_desinfekten` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_pembuangan_limbah_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_pembuangan_limbah_cair_infeksius
-- ----------------------------
DROP TABLE IF EXISTS `audit_pembuangan_limbah_cair_infeksius`;
CREATE TABLE `audit_pembuangan_limbah_cair_infeksius`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `audit1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_pembuangan_limbah_cair_infeksius_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_penanganan_darah
-- ----------------------------
DROP TABLE IF EXISTS `audit_penanganan_darah`;
CREATE TABLE `audit_penanganan_darah`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `menggunakan_apd_waktu_membuang_darah` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `komponen_darah_tidak_ada_dilantai` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `membuang_darah_pada_tempat_ditentukan` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pembersihan_areal_tumbahan_darah` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `apd_dibuang_di_limbah_infeksius` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `melakukan_kebersihan_tangan_setelah_prosedur` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_penanganan_darah_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_penempatan_pasien
-- ----------------------------
DROP TABLE IF EXISTS `audit_penempatan_pasien`;
CREATE TABLE `audit_penempatan_pasien`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `audit1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit9` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_penempatan_pasien_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_pengelolaan_linen_kotor
-- ----------------------------
DROP TABLE IF EXISTS `audit_pengelolaan_linen_kotor`;
CREATE TABLE `audit_pengelolaan_linen_kotor`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `audit1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_pengelolaan_linen_kotor_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for audit_sterilisasi_alat
-- ----------------------------
DROP TABLE IF EXISTS `audit_sterilisasi_alat`;
CREATE TABLE `audit_sterilisasi_alat`  (
  `tanggal` datetime NOT NULL,
  `id_ruang` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `audit1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `audit9` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `audit10` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `audit11` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tanggal`, `id_ruang`) USING BTREE,
  INDEX `id_ruang`(`id_ruang`) USING BTREE,
  CONSTRAINT `audit_sterilisasi_alat_ibfk_1` FOREIGN KEY (`id_ruang`) REFERENCES `ruang_audit_kepatuhan` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bahasa_pasien
-- ----------------------------
DROP TABLE IF EXISTS `bahasa_pasien`;
CREATE TABLE `bahasa_pasien`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_bahasa` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nama_bahasa`(`nama_bahasa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for balasan_pengaduan
-- ----------------------------
DROP TABLE IF EXISTS `balasan_pengaduan`;
CREATE TABLE `balasan_pengaduan`  (
  `id_pengaduan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pesan_balasan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_pengaduan`) USING BTREE,
  CONSTRAINT `balasan_pengaduan_ibfk_1` FOREIGN KEY (`id_pengaduan`) REFERENCES `pengaduan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank`  (
  `namabank` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`namabank`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bank_tujuan_transfer_bankmandiri
-- ----------------------------
DROP TABLE IF EXISTS `bank_tujuan_transfer_bankmandiri`;
CREATE TABLE `bank_tujuan_transfer_bankmandiri`  (
  `kode_bank` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_bank` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_bank`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_detail_periksa_lab
-- ----------------------------
DROP TABLE IF EXISTS `bayar_detail_periksa_lab`;
CREATE TABLE `bayar_detail_periksa_lab`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `id_template` int(11) NOT NULL,
  `bagian_dokter` double NOT NULL,
  PRIMARY KEY (`no_bayar`, `no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`, `id_template`) USING BTREE,
  INDEX `id_template`(`id_template`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_detail_periksa_lab_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_detail_periksa_lab_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_detail_periksa_lab_ibfk_3` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_detail_periksa_lab_ibfk_4` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_detail_periksa_lab_perujuk
-- ----------------------------
DROP TABLE IF EXISTS `bayar_detail_periksa_lab_perujuk`;
CREATE TABLE `bayar_detail_periksa_lab_perujuk`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `id_template` int(11) NOT NULL,
  `bagian_perujuk` double NOT NULL,
  PRIMARY KEY (`no_bayar`, `no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`, `id_template`) USING BTREE,
  INDEX `id_template`(`id_template`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_detail_periksa_lab_perujuk_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_detail_periksa_lab_perujuk_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_detail_periksa_lab_perujuk_ibfk_3` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_detail_periksa_lab_perujuk_ibfk_4` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_jm_dokter
-- ----------------------------
DROP TABLE IF EXISTS `bayar_jm_dokter`;
CREATE TABLE `bayar_jm_dokter`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `besar_bayar` double NULL DEFAULT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rawatjalan` double NOT NULL,
  `rawatinap` double NOT NULL,
  `labrawatjalan` double NOT NULL,
  `labrawatinap` double NOT NULL,
  `radrawatjalan` double NOT NULL,
  `radrawatinap` double NOT NULL,
  `operasiralan` double NOT NULL,
  `operasiranap` double NOT NULL,
  PRIMARY KEY (`no_bayar`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `nama_bayar`(`nama_bayar`) USING BTREE,
  CONSTRAINT `bayar_jm_dokter_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_jm_dokter_ibfk_2` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar_hutang` (`nama_bayar`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_operasi_dokter_anak
-- ----------------------------
DROP TABLE IF EXISTS `bayar_operasi_dokter_anak`;
CREATE TABLE `bayar_operasi_dokter_anak`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `biayadokter_anak` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`, `no_bayar`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  CONSTRAINT `bayar_operasi_dokter_anak_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_dokter_anak_ibfk_2` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_dokter_anak_ibfk_3` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_operasi_dokter_anestesi
-- ----------------------------
DROP TABLE IF EXISTS `bayar_operasi_dokter_anestesi`;
CREATE TABLE `bayar_operasi_dokter_anestesi`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `biayadokter_anestesi` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`, `no_bayar`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  CONSTRAINT `bayar_operasi_dokter_anestesi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_dokter_anestesi_ibfk_2` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_dokter_anestesi_ibfk_3` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_operasi_dokter_pjanak
-- ----------------------------
DROP TABLE IF EXISTS `bayar_operasi_dokter_pjanak`;
CREATE TABLE `bayar_operasi_dokter_pjanak`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `biaya_dokter_pjanak` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`, `no_bayar`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  CONSTRAINT `bayar_operasi_dokter_pjanak_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_dokter_pjanak_ibfk_2` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_dokter_pjanak_ibfk_3` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_operasi_dokter_umum
-- ----------------------------
DROP TABLE IF EXISTS `bayar_operasi_dokter_umum`;
CREATE TABLE `bayar_operasi_dokter_umum`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `biaya_dokter_umum` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`, `no_bayar`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  CONSTRAINT `bayar_operasi_dokter_umum_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_dokter_umum_ibfk_2` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_dokter_umum_ibfk_3` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_operasi_operator1
-- ----------------------------
DROP TABLE IF EXISTS `bayar_operasi_operator1`;
CREATE TABLE `bayar_operasi_operator1`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `biayaoperator1` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`, `no_bayar`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  CONSTRAINT `bayar_operasi_operator1_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_operator1_ibfk_2` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_operator1_ibfk_3` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_operasi_operator2
-- ----------------------------
DROP TABLE IF EXISTS `bayar_operasi_operator2`;
CREATE TABLE `bayar_operasi_operator2`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `biayaoperator2` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`, `no_bayar`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  CONSTRAINT `bayar_operasi_operator2_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_operator2_ibfk_2` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_operator2_ibfk_3` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_operasi_operator3
-- ----------------------------
DROP TABLE IF EXISTS `bayar_operasi_operator3`;
CREATE TABLE `bayar_operasi_operator3`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `biayaoperator3` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_operasi`, `kode_paket`, `no_bayar`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  CONSTRAINT `bayar_operasi_operator3_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_operator3_ibfk_2` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_operasi_operator3_ibfk_3` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_pemesanan
-- ----------------------------
DROP TABLE IF EXISTS `bayar_pemesanan`;
CREATE TABLE `bayar_pemesanan`  (
  `tgl_bayar` date NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `besar_bayar` double NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_bukti` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_bayar`, `no_faktur`, `no_bukti`) USING BTREE,
  INDEX `bayar_pemesanan_ibfk_2`(`nip`) USING BTREE,
  INDEX `bayar_pemesanan_ibfk_3`(`nama_bayar`) USING BTREE,
  INDEX `bayar_pemesanan_ibfk_1`(`no_faktur`) USING BTREE,
  CONSTRAINT `bayar_pemesanan_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `pemesanan` (`no_faktur`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar_hutang` (`nama_bayar`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_pemesanan_dapur
-- ----------------------------
DROP TABLE IF EXISTS `bayar_pemesanan_dapur`;
CREATE TABLE `bayar_pemesanan_dapur`  (
  `tgl_bayar` date NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `besar_bayar` double NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_bukti` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_bayar`, `no_faktur`, `no_bukti`) USING BTREE,
  INDEX `tgl_bayar`(`tgl_bayar`) USING BTREE,
  INDEX `no_faktur`(`no_faktur`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `nama_bayar`(`nama_bayar`) USING BTREE,
  CONSTRAINT `bayar_pemesanan_dapur_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `dapurpemesanan` (`no_faktur`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_dapur_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_dapur_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar_hutang` (`nama_bayar`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_pemesanan_inventaris
-- ----------------------------
DROP TABLE IF EXISTS `bayar_pemesanan_inventaris`;
CREATE TABLE `bayar_pemesanan_inventaris`  (
  `tgl_bayar` date NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `besar_bayar` double NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_bukti` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_bayar`, `no_faktur`, `no_bukti`) USING BTREE,
  INDEX `tgl_bayar`(`tgl_bayar`) USING BTREE,
  INDEX `no_faktur`(`no_faktur`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `nama_bayar`(`nama_bayar`) USING BTREE,
  CONSTRAINT `bayar_pemesanan_inventaris_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `inventaris_pemesanan` (`no_faktur`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_inventaris_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_inventaris_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar_hutang` (`nama_bayar`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_pemesanan_non_medis
-- ----------------------------
DROP TABLE IF EXISTS `bayar_pemesanan_non_medis`;
CREATE TABLE `bayar_pemesanan_non_medis`  (
  `tgl_bayar` date NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `besar_bayar` double NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_bukti` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_bayar`, `no_faktur`, `no_bukti`) USING BTREE,
  INDEX `tgl_bayar`(`tgl_bayar`) USING BTREE,
  INDEX `no_faktur`(`no_faktur`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `nama_bayar`(`nama_bayar`) USING BTREE,
  CONSTRAINT `bayar_pemesanan_non_medis_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `ipsrspemesanan` (`no_faktur`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_non_medis_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_non_medis_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar_hutang` (`nama_bayar`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_periksa_lab
-- ----------------------------
DROP TABLE IF EXISTS `bayar_periksa_lab`;
CREATE TABLE `bayar_periksa_lab`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  PRIMARY KEY (`no_bayar`, `no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_periksa_lab_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_periksa_lab_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_periksa_lab_ibfk_3` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_periksa_lab_perujuk
-- ----------------------------
DROP TABLE IF EXISTS `bayar_periksa_lab_perujuk`;
CREATE TABLE `bayar_periksa_lab_perujuk`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `tarif_perujuk` double NOT NULL,
  PRIMARY KEY (`no_bayar`, `no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_periksa_lab_perujuk_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_periksa_lab_perujuk_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_periksa_lab_perujuk_ibfk_3` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_periksa_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `bayar_periksa_radiologi`;
CREATE TABLE `bayar_periksa_radiologi`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `no_bayar`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_periksa_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_periksa_radiologi_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_periksa_radiologi_ibfk_3` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_periksa_radiologi_perujuk
-- ----------------------------
DROP TABLE IF EXISTS `bayar_periksa_radiologi_perujuk`;
CREATE TABLE `bayar_periksa_radiologi_perujuk`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `tarif_perujuk` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `no_bayar`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_periksa_radiologi_perujuk_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_periksa_radiologi_perujuk_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_periksa_radiologi_perujuk_ibfk_3` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_piutang
-- ----------------------------
DROP TABLE IF EXISTS `bayar_piutang`;
CREATE TABLE `bayar_piutang`  (
  `tgl_bayar` date NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `besar_cicilan` double NOT NULL,
  `catatan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_rek_kontra` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diskon_piutang` double NOT NULL,
  `kd_rek_diskon_piutang` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tidak_terbayar` double NOT NULL,
  `kd_rek_tidak_terbayar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_bayar`, `no_rkm_medis`, `no_rawat`, `kd_rek`, `kd_rek_kontra`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  INDEX `nota_piutang`(`no_rawat`) USING BTREE,
  INDEX `besar_cicilan`(`besar_cicilan`) USING BTREE,
  INDEX `catatan`(`catatan`) USING BTREE,
  INDEX `kd_rek`(`kd_rek`) USING BTREE,
  INDEX `kd_rek_kontra`(`kd_rek_kontra`) USING BTREE,
  INDEX `kd_rek_diskon_piutang`(`kd_rek_diskon_piutang`) USING BTREE,
  INDEX `kd_rek_tidak_terbayar`(`kd_rek_tidak_terbayar`) USING BTREE,
  CONSTRAINT `bayar_piutang_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_ibfk_3` FOREIGN KEY (`kd_rek_kontra`) REFERENCES `rekening` (`kd_rek`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_ibfk_4` FOREIGN KEY (`kd_rek_diskon_piutang`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_ibfk_5` FOREIGN KEY (`kd_rek_tidak_terbayar`) REFERENCES `rekening` (`kd_rek`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_piutang_lainlain
-- ----------------------------
DROP TABLE IF EXISTS `bayar_piutang_lainlain`;
CREATE TABLE `bayar_piutang_lainlain`  (
  `tgl_bayar` date NOT NULL,
  `kode_peminjam` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `besar_cicilan` double NOT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nota_piutang` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_bayar`, `kode_peminjam`, `nota_piutang`, `kd_rek`, `nama_bayar`) USING BTREE,
  INDEX `kode_peminjam`(`kode_peminjam`) USING BTREE,
  INDEX `kd_rek`(`kd_rek`) USING BTREE,
  INDEX `nama_bayar`(`nama_bayar`) USING BTREE,
  INDEX `nota_piutang`(`nota_piutang`) USING BTREE,
  CONSTRAINT `bayar_piutang_lainlain_ibfk_1` FOREIGN KEY (`kode_peminjam`) REFERENCES `peminjampiutang` (`kode_peminjam`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_lainlain_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_lainlain_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_lainlain_ibfk_4` FOREIGN KEY (`nota_piutang`) REFERENCES `piutang_lainlain` (`nota_piutang`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_rawat_inap_dr
-- ----------------------------
DROP TABLE IF EXISTS `bayar_rawat_inap_dr`;
CREATE TABLE `bayar_rawat_inap_dr`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `tarif_tindakandr` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `no_bayar`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_rawat_inap_dr_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_rawat_inap_dr_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_rawat_inap_dr_ibfk_3` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_rawat_inap_drpr
-- ----------------------------
DROP TABLE IF EXISTS `bayar_rawat_inap_drpr`;
CREATE TABLE `bayar_rawat_inap_drpr`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `tarif_tindakandr` double NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `no_bayar`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_rawat_inap_drpr_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_rawat_inap_drpr_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_rawat_inap_drpr_ibfk_3` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_rawat_jl_dr
-- ----------------------------
DROP TABLE IF EXISTS `bayar_rawat_jl_dr`;
CREATE TABLE `bayar_rawat_jl_dr`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  PRIMARY KEY (`no_bayar`, `no_rawat`, `kd_jenis_prw`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `bayar_rawat_jl_dr_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_rawat_jl_dr_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_rawat_jl_dr_ibfk_3` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bayar_rawat_jl_drpr
-- ----------------------------
DROP TABLE IF EXISTS `bayar_rawat_jl_drpr`;
CREATE TABLE `bayar_rawat_jl_drpr`  (
  `no_bayar` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `tarif_tindakandr` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `no_bayar`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `no_bayar`(`no_bayar`) USING BTREE,
  CONSTRAINT `bayar_rawat_jl_drpr_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_rawat_jl_drpr_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bayar_rawat_jl_drpr_ibfk_3` FOREIGN KEY (`no_bayar`) REFERENCES `bayar_jm_dokter` (`no_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for beri_bhp_radiologi
-- ----------------------------
DROP TABLE IF EXISTS `beri_bhp_radiologi`;
CREATE TABLE `beri_bhp_radiologi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NULL DEFAULT NULL,
  `total` double NULL DEFAULT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `tgl_periksa`(`tgl_periksa`) USING BTREE,
  INDEX `jam`(`jam`) USING BTREE,
  INDEX `jumlah`(`jumlah`) USING BTREE,
  CONSTRAINT `beri_bhp_radiologi_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `beri_bhp_radiologi_ibfk_5` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `beri_bhp_radiologi_ibfk_6` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for berkas_pegawai
-- ----------------------------
DROP TABLE IF EXISTS `berkas_pegawai`;
CREATE TABLE `berkas_pegawai`  (
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_uploud` date NOT NULL,
  `kode_berkas` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `berkas` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  INDEX `nik`(`nik`) USING BTREE,
  INDEX `kode_berkas`(`kode_berkas`) USING BTREE,
  CONSTRAINT `berkas_pegawai_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `berkas_pegawai_ibfk_2` FOREIGN KEY (`kode_berkas`) REFERENCES `master_berkas_pegawai` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for biaya_harian
-- ----------------------------
DROP TABLE IF EXISTS `biaya_harian`;
CREATE TABLE `biaya_harian`  (
  `kd_kamar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_biaya` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `besar_biaya` double NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`kd_kamar`, `nama_biaya`) USING BTREE,
  INDEX `besar_biaya`(`besar_biaya`) USING BTREE,
  INDEX `jml`(`jml`) USING BTREE,
  CONSTRAINT `biaya_harian_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for biaya_sekali
-- ----------------------------
DROP TABLE IF EXISTS `biaya_sekali`;
CREATE TABLE `biaya_sekali`  (
  `kd_kamar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_biaya` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `besar_biaya` double NOT NULL,
  PRIMARY KEY (`kd_kamar`, `nama_biaya`) USING BTREE,
  INDEX `kd_kamar`(`kd_kamar`) USING BTREE,
  INDEX `besar_biaya`(`besar_biaya`) USING BTREE,
  CONSTRAINT `biaya_sekali_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bidang
-- ----------------------------
DROP TABLE IF EXISTS `bidang`;
CREATE TABLE `bidang`  (
  `nama` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`nama`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for billing
-- ----------------------------
DROP TABLE IF EXISTS `billing`;
CREATE TABLE `billing`  (
  `noindex` int(11) NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_byr` date NULL DEFAULT NULL,
  `no` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_perawatan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pemisah` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biaya` double NOT NULL,
  `jumlah` double NOT NULL,
  `tambahan` double NOT NULL,
  `totalbiaya` double NOT NULL,
  `status` enum('Laborat','Radiologi','Operasi','Obat','Ranap Dokter','Ranap Dokter Paramedis','Ranap Paramedis','Ralan Dokter','Ralan Dokter Paramedis','Ralan Paramedis','Tambahan','Potongan','Administrasi','Kamar','-','Registrasi','Harian','Service','TtlObat','TtlRanap Dokter','TtlRanap Paramedis','TtlRalan Dokter','TtlRalan Paramedis','TtlKamar','Dokter','Perawat','TtlTambahan','Retur Obat','TtlRetur Obat','Resep Pulang','TtlResep Pulang','TtlPotongan','TtlLaborat','TtlOperasi','TtlRadiologi','Tagihan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `totalbiaya`(`totalbiaya`) USING BTREE,
  INDEX `nm_perawatan`(`nm_perawatan`) USING BTREE,
  INDEX `tgl_byr`(`tgl_byr`) USING BTREE,
  INDEX `no`(`no`) USING BTREE,
  INDEX `pemisah`(`pemisah`) USING BTREE,
  INDEX `biaya`(`biaya`) USING BTREE,
  INDEX `jumlah`(`jumlah`) USING BTREE,
  INDEX `tambahan`(`tambahan`) USING BTREE,
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_mcu_perusahaan
-- ----------------------------
DROP TABLE IF EXISTS `booking_mcu_perusahaan`;
CREATE TABLE `booking_mcu_perusahaan`  (
  `tanggal_booking` date NULL DEFAULT NULL,
  `jam_booking` time NULL DEFAULT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal_mcu` date NOT NULL,
  `no_mcu` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Terdaftar','Menunggu Hasil','Selesai') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_perusahaan` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_mcu`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  INDEX `kode_perusahaan`(`kode_perusahaan`) USING BTREE,
  CONSTRAINT `booking_mcu_perusahaan_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_mcu_perusahaan_ibfk_2` FOREIGN KEY (`kode_perusahaan`) REFERENCES `perusahaan_pasien` (`kode_perusahaan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_mcu_perusahaan_berhasil_registrasi
-- ----------------------------
DROP TABLE IF EXISTS `booking_mcu_perusahaan_berhasil_registrasi`;
CREATE TABLE `booking_mcu_perusahaan_berhasil_registrasi`  (
  `no_mcu` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_mcu`, `no_rawat`) USING BTREE,
  INDEX `booking_mcu_perusahaan_berhasil_registrasi_ibfk_2`(`no_rawat`) USING BTREE,
  CONSTRAINT `booking_mcu_perusahaan_berhasil_registrasi_ibfk_1` FOREIGN KEY (`no_mcu`) REFERENCES `booking_mcu_perusahaan` (`no_mcu`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `booking_mcu_perusahaan_berhasil_registrasi_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_mcu_perusahaan_pasien_baru
-- ----------------------------
DROP TABLE IF EXISTS `booking_mcu_perusahaan_pasien_baru`;
CREATE TABLE `booking_mcu_perusahaan_pasien_baru`  (
  `no_pengajuan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_pasien` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_ktp` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jk` enum('L','P') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tmp_lahir` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `nm_ibu` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamat` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kelurahan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kecamatan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kabupaten` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `propinsi` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gol_darah` enum('A','B','O','AB','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pekerjaan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `agama` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_mcu` date NULL DEFAULT NULL,
  `no_tlp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `umur` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pnd` enum('TS','TK','SD','SMP','SMA','SLTA/SEDERAJAT','D1','D2','D3','D4','S1','S2','S3','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluarga` enum('AYAH','IBU','ISTRI','SUAMI','SAUDARA','ANAK','DIRI SENDIRI','LAIN-LAIN') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `namakeluarga` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pekerjaanpj` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alamatpj` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kelurahanpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kecamatanpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kabupatenpj` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `propinsipj` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perusahaan_pasien` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suku_bangsa` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bahasa_pasien` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cacat_fisik` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Sudah Dikonfirmasi','Menunggu Konfirmasi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_pengajuan`) USING BTREE,
  INDEX `perusahaan_pasien`(`perusahaan_pasien`) USING BTREE,
  CONSTRAINT `booking_mcu_perusahaan_pasien_baru_ibfk_1` FOREIGN KEY (`perusahaan_pasien`) REFERENCES `perusahaan_pasien` (`kode_perusahaan`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_operasi
-- ----------------------------
DROP TABLE IF EXISTS `booking_operasi`;
CREATE TABLE `booking_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NULL DEFAULT NULL,
  `status` enum('Menunggu','Proses Operasi','Selesai') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_ruang_ok` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode_paket`, `tanggal`, `jam_mulai`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `kd_ruang_ok`(`kd_ruang_ok`) USING BTREE,
  CONSTRAINT `booking_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_2` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_4` FOREIGN KEY (`kd_ruang_ok`) REFERENCES `ruang_ok` (`kd_ruang_ok`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_operasi_keterangan
-- ----------------------------
DROP TABLE IF EXISTS `booking_operasi_keterangan`;
CREATE TABLE `booking_operasi_keterangan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_paket` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NULL DEFAULT NULL,
  `status` enum('Menunggu','Proses Operasi','Selesai') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_ruang_ok` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '-',
  PRIMARY KEY (`no_rawat`, `kode_paket`, `tanggal`, `jam_mulai`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kode_paket`(`kode_paket`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `kd_ruang_ok`(`kd_ruang_ok`) USING BTREE,
  CONSTRAINT `booking_operasi_keterangan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_keterangan_ibfk_2` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_keterangan_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_keterangan_ibfk_4` FOREIGN KEY (`kd_ruang_ok`) REFERENCES `ruang_ok` (`kd_ruang_ok`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_pasienbaru
-- ----------------------------
DROP TABLE IF EXISTS `booking_pasienbaru`;
CREATE TABLE `booking_pasienbaru`  (
  `no_booking` varchar(17) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nm_pasien` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `no_ktp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `jk` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp_lahir` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tgl_lahir` date NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `no_tlp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `no_peserta` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tgl_daftar` datetime NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `agama` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pendidikan` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keluarga` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `namakeluarga` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pekerjaan` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nm_ibu` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gol_darah` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stts_nikah` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `kd_pj` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `catatan` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_periksa
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa`;
CREATE TABLE `booking_periksa`  (
  `no_booking` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rkm_medis` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nomor_kartu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `alamat` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_poli` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_dokter` varchar(55) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_pj` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Diterima','Ditolak','Belum Dibalas','Check In','CheckIn') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `catatan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_booking` datetime NOT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  INDEX `kd_poli`(`kd_poli`) USING BTREE,
  CONSTRAINT `booking_periksa_ibfk_1` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_periksa_balasan
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa_balasan`;
CREATE TABLE `booking_periksa_balasan`  (
  `no_booking` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `balasan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  CONSTRAINT `booking_periksa_balasan_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking_periksa_simandaiold` (`no_booking`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_periksa_diterima
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa_diterima`;
CREATE TABLE `booking_periksa_diterima`  (
  `no_booking` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_booking`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  CONSTRAINT `booking_periksa_diterima_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking_periksa_simandaiold` (`no_booking`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_periksa_diterima_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for booking_periksa_simandaiold
-- ----------------------------
DROP TABLE IF EXISTS `booking_periksa_simandaiold`;
CREATE TABLE `booking_periksa_simandaiold`  (
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
  CONSTRAINT `booking_periksa_simandaiold_ibfk_1` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
  `limit_reg` int(1) NULL DEFAULT NULL,
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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bpjs`;
CREATE TABLE `bpjs`  (
  `stts` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`stts`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bpjs_api_logs
-- ----------------------------
DROP TABLE IF EXISTS `bpjs_api_logs`;
CREATE TABLE `bpjs_api_logs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `request` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `response` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1009 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bpjs_monitor_log
-- ----------------------------
DROP TABLE IF EXISTS `bpjs_monitor_log`;
CREATE TABLE `bpjs_monitor_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `endpoint` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `response_time` float NULL DEFAULT NULL,
  `code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `polled_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18526 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bpjs_prb
-- ----------------------------
DROP TABLE IF EXISTS `bpjs_prb`;
CREATE TABLE `bpjs_prb`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prb` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_sep`) USING BTREE,
  CONSTRAINT `bpjs_prb_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_dukcapil
-- ----------------------------
DROP TABLE IF EXISTS `bridging_dukcapil`;
CREATE TABLE `bridging_dukcapil`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_id` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`) USING BTREE,
  CONSTRAINT `bridging_dukcapil_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_inhealth
-- ----------------------------
DROP TABLE IF EXISTS `bridging_inhealth`;
CREATE TABLE `bridging_inhealth`  (
  `no_sjp` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tglsep` datetime NULL DEFAULT NULL,
  `tglrujukan` datetime NULL DEFAULT NULL,
  `no_rujukan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdppkrujukan` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmppkrujukan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdppkpelayanan` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmppkpelayanan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jnspelayanan` enum('1','2','3','4') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catatan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagawal` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmdiagnosaawal` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `diagawal2` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmdiagnosaawal2` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdpolitujuan` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmpolitujuan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klsrawat` enum('000','100','101','102','103','104','110','200','201','202','203','204','210','300','301','302','303','304','310','311','312','400','401','402','403','404','410','411','412','413','500','510','511','512','610','611','612','613','710','711','712','713','910','911','912','913') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klsdesc` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kdbu` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmbu` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lakalantas` enum('0','1','2') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lokasilaka` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nomr` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_lahir` date NULL DEFAULT NULL,
  `jkel` enum('LAKI-LAKI','PEREMPUAN') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_kartu` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tglpulang` datetime NULL DEFAULT NULL,
  `plan` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `plandesc` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `idakomodasi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipesjp` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipecob` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_sjp`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `bridging_inhealth_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_resep_apotek_bpjs
-- ----------------------------
DROP TABLE IF EXISTS `bridging_resep_apotek_bpjs`;
CREATE TABLE `bridging_resep_apotek_bpjs`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_sep_apotek` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_sep` datetime NOT NULL,
  `kdpoli` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmpoli` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdjenis` enum('1. Obat PRB','2. Obat Kronis Blm Stabil','3. Obat Kemoterapi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nota_piutang` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_user_sep` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_resep` datetime NULL DEFAULT NULL,
  `tgl_pelayanan` datetime NULL DEFAULT NULL,
  `kodedpjp` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmdpjp` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `iterasi` enum('0. Non Iterasi','1. Iterasi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_kartu` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_pasien` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kdppkrujukan` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nmppkpelayanan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `byTagRsp` double NOT NULL,
  `byVerRsp` double NOT NULL,
  `status` enum('Piutang','Non Piutang') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_sep_apotek`) USING BTREE,
  INDEX `no_sep`(`no_sep`) USING BTREE,
  CONSTRAINT `bridging_resep_apotek_bpjs_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_resep_apotek_bpjs_nonracikan
-- ----------------------------
DROP TABLE IF EXISTS `bridging_resep_apotek_bpjs_nonracikan`;
CREATE TABLE `bridging_resep_apotek_bpjs_nonracikan`  (
  `no_sep_apotek` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `signa1` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `signa2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml_obat` double NULL DEFAULT NULL,
  `jho` double NULL DEFAULT NULL,
  `catatan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_sep_apotek`(`no_sep_apotek`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `bridging_resep_apotek_bpjs_nonracikan_ibfk_1` FOREIGN KEY (`no_sep_apotek`) REFERENCES `bridging_resep_apotek_bpjs` (`no_sep_apotek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bridging_resep_apotek_bpjs_nonracikan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `maping_obat_apotek_bpjs` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_resep_apotek_bpjs_racikan
-- ----------------------------
DROP TABLE IF EXISTS `bridging_resep_apotek_bpjs_racikan`;
CREATE TABLE `bridging_resep_apotek_bpjs_racikan`  (
  `no_sep_apotek` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nomor_racik` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `signa1` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `signa2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml_obat` double NULL DEFAULT NULL,
  `permintaan` double NULL DEFAULT NULL,
  `jho` double NULL DEFAULT NULL,
  `catatan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_sep_apotek`(`no_sep_apotek`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `bridging_resep_apotek_bpjs_racikan_ibfk_1` FOREIGN KEY (`no_sep_apotek`) REFERENCES `bridging_resep_apotek_bpjs` (`no_sep_apotek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bridging_resep_apotek_bpjs_racikan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `maping_obat_apotek_bpjs` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_rujukan_bpjs_khusus
-- ----------------------------
DROP TABLE IF EXISTS `bridging_rujukan_bpjs_khusus`;
CREATE TABLE `bridging_rujukan_bpjs_khusus`  (
  `no_rujukan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nokapst` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nmpst` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tglrujukan_awal` date NULL DEFAULT NULL,
  `tglrujukan_berakhir` date NULL DEFAULT NULL,
  PRIMARY KEY (`no_rujukan`) USING BTREE,
  CONSTRAINT `bridging_rujukan_bpjs_khusus_ibfk_1` FOREIGN KEY (`no_rujukan`) REFERENCES `bridging_rujukan_bpjs` (`no_rujukan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_rujukan_bpjs_khusus_diagnosa
-- ----------------------------
DROP TABLE IF EXISTS `bridging_rujukan_bpjs_khusus_diagnosa`;
CREATE TABLE `bridging_rujukan_bpjs_khusus_diagnosa`  (
  `no_rujukan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('P','S') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_diagnosa` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_diagnosa` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rujukan`, `kode_diagnosa`) USING BTREE,
  CONSTRAINT `bridging_rujukan_bpjs_khusus_diagnosa_ibfk_1` FOREIGN KEY (`no_rujukan`) REFERENCES `bridging_rujukan_bpjs` (`no_rujukan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_rujukan_bpjs_khusus_prosedur
-- ----------------------------
DROP TABLE IF EXISTS `bridging_rujukan_bpjs_khusus_prosedur`;
CREATE TABLE `bridging_rujukan_bpjs_khusus_prosedur`  (
  `no_rujukan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_prosedur` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_prosedur` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rujukan`, `kode_prosedur`) USING BTREE,
  CONSTRAINT `bridging_rujukan_bpjs_khusus_prosedur_ibfk_1` FOREIGN KEY (`no_rujukan`) REFERENCES `bridging_rujukan_bpjs` (`no_rujukan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
  `klsnaik` enum('','1','2','3','4','5','6','7','8') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pembiayaan` enum('','1','2','3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pjnaikkelas` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `lakalantas` enum('0','1','2','3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
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
  CONSTRAINT `bridging_sep_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_sep_copy1
-- ----------------------------
DROP TABLE IF EXISTS `bridging_sep_copy1`;
CREATE TABLE `bridging_sep_copy1`  (
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
  `klsnaik` enum('','1','2','3','4','5','6','7','8') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
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
  CONSTRAINT `bridging_sep_copy1_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
  `klsnaik` enum('','1','2','3','4','5','6','7','8') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
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
  CONSTRAINT `bridging_sep_internal_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `bridging_sep_internal_ibfk_2` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bridging_srb_bpjs_obat
-- ----------------------------
DROP TABLE IF EXISTS `bridging_srb_bpjs_obat`;
CREATE TABLE `bridging_srb_bpjs_obat`  (
  `no_sep` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_srb` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_obat` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_obat` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah` double NULL DEFAULT NULL,
  `signa1` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `signa2` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_sep`(`no_sep`) USING BTREE,
  CONSTRAINT `bridging_srb_bpjs_obat_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_pemesanan
-- ----------------------------
DROP TABLE IF EXISTS `bukti_pemesanan`;
CREATE TABLE `bukti_pemesanan`  (
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_faktur`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_pemesanan2
-- ----------------------------
DROP TABLE IF EXISTS `bukti_pemesanan2`;
CREATE TABLE `bukti_pemesanan2`  (
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_faktur`) USING BTREE,
  CONSTRAINT `bukti_pemesanan2_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `pemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_pemesanan_dapur
-- ----------------------------
DROP TABLE IF EXISTS `bukti_pemesanan_dapur`;
CREATE TABLE `bukti_pemesanan_dapur`  (
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_faktur`) USING BTREE,
  CONSTRAINT `bukti_pemesanan_dapur_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `dapurpemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_pemesanan_logistik
-- ----------------------------
DROP TABLE IF EXISTS `bukti_pemesanan_logistik`;
CREATE TABLE `bukti_pemesanan_logistik`  (
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_faktur`) USING BTREE,
  CONSTRAINT `bukti_pemesanan_logistik_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `ipsrspemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_penagihan_piutang
-- ----------------------------
DROP TABLE IF EXISTS `bukti_penagihan_piutang`;
CREATE TABLE `bukti_penagihan_piutang`  (
  `no_tagihan` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_tagihan`) USING BTREE,
  CONSTRAINT `bukti_penagihan_piutang_ibfk_1` FOREIGN KEY (`no_tagihan`) REFERENCES `penagihan_piutang` (`no_tagihan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_penyerahan_resep_obat
-- ----------------------------
DROP TABLE IF EXISTS `bukti_penyerahan_resep_obat`;
CREATE TABLE `bukti_penyerahan_resep_obat`  (
  `no_resep` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_resep`) USING BTREE,
  CONSTRAINT `bukti_penyerahan_resep_obat_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_perencanaan_pemulangan_saksikeluarga
-- ----------------------------
DROP TABLE IF EXISTS `bukti_perencanaan_pemulangan_saksikeluarga`;
CREATE TABLE `bukti_perencanaan_pemulangan_saksikeluarga`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  CONSTRAINT `bukti_perencanaan_pemulangan_saksikeluarga_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `perencanaan_pemulangan` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_persetujuan_penolakan_tindakan_penerimainformasi
-- ----------------------------
DROP TABLE IF EXISTS `bukti_persetujuan_penolakan_tindakan_penerimainformasi`;
CREATE TABLE `bukti_persetujuan_penolakan_tindakan_penerimainformasi`  (
  `no_pernyataan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_pernyataan`) USING BTREE,
  CONSTRAINT `bukti_persetujuan_penolakan_tindakan_penerimainformasi_ibfk_1` FOREIGN KEY (`no_pernyataan`) REFERENCES `persetujuan_penolakan_tindakan` (`no_pernyataan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_persetujuan_penolakan_tindakan_saksikeluarga
-- ----------------------------
DROP TABLE IF EXISTS `bukti_persetujuan_penolakan_tindakan_saksikeluarga`;
CREATE TABLE `bukti_persetujuan_penolakan_tindakan_saksikeluarga`  (
  `no_pernyataan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_pernyataan`) USING BTREE,
  CONSTRAINT `bukti_persetujuan_penolakan_tindakan_saksikeluarga_ibfk_1` FOREIGN KEY (`no_pernyataan`) REFERENCES `persetujuan_penolakan_tindakan` (`no_pernyataan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_persetujuan_penundaan_pelayanan
-- ----------------------------
DROP TABLE IF EXISTS `bukti_persetujuan_penundaan_pelayanan`;
CREATE TABLE `bukti_persetujuan_penundaan_pelayanan`  (
  `no_surat` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_surat`) USING BTREE,
  CONSTRAINT `bukti_persetujuan_penundaan_pelayanan_ibfk_1` FOREIGN KEY (`no_surat`) REFERENCES `persetujuan_penundaan_pelayanan` (`no_surat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bukti_persetujuan_transfer_pasien_antar_ruang
-- ----------------------------
DROP TABLE IF EXISTS `bukti_persetujuan_transfer_pasien_antar_ruang`;
CREATE TABLE `bukti_persetujuan_transfer_pasien_antar_ruang`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal_masuk` datetime NULL DEFAULT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  CONSTRAINT `bukti_persetujuan_transfer_pasien_antar_ruang_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cacat_fisik
-- ----------------------------
DROP TABLE IF EXISTS `cacat_fisik`;
CREATE TABLE `cacat_fisik`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_cacat` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `nama_cacat`(`nama_cacat`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_anestesi_sedasi
-- ----------------------------
DROP TABLE IF EXISTS `catatan_anestesi_sedasi`;
CREATE TABLE `catatan_anestesi_sedasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_dokter_bedah` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_pre_bedah` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tindakan_jenis_pembedahan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `diagnosa_pasca_bedah` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pre_induksi_jam` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_kesadaran` enum('Compos Mentis','Somnolence','Sopor','Coma','Alert','Confusion','Voice','Pain','Unresponsive','Apatis','Delirium') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_o2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_tb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_rhesus` enum('+','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_hb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_ht` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_leko` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_trombo` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_btct` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_gds` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pre_induksi_lainlain` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_hiopotensi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_tci` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_cpb` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_ventilasi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_broncoskopy` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_glidescopi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_usg` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_stimulator_saraf` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `teknik_alat_lainlain` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_ekg` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_ekg_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_arteri` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_arteri_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_cvp` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_cvp_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_etco` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_stetoskop` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_nibp` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_ngt` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_bis` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_cath_a_pulmo` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_spo2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_kateter` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_temp` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `monitoring_lainlain` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_fisik_asa` enum('1','2','3','4','5','E') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_fisik_alergi` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status_fisik_alergi_keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_fisik_penyulit_sedasi` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut_sedasi` enum('Sedang','Dalam','Tidak','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut_sedasi_keterangan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut_spinal` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut_anestesi_umum` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut_anestesi_umum_keterangan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut_blok_perifer` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut_blok_perifer_keterangan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_lanjut_epidural` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_batal` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perencanaan_batal_alasan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip_perawat_ok` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip_perawat_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nip_perawat_ok`(`nip_perawat_ok`) USING BTREE,
  INDEX `kd_dokter_anestesi`(`kd_dokter_anestesi`) USING BTREE,
  INDEX `kd_dokter_bedah`(`kd_dokter_bedah`) USING BTREE,
  INDEX `nip_perawat_anestesi`(`nip_perawat_anestesi`) USING BTREE,
  CONSTRAINT `catatan_anestesi_sedasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_anestesi_sedasi_ibfk_2` FOREIGN KEY (`nip_perawat_ok`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_anestesi_sedasi_ibfk_3` FOREIGN KEY (`nip_perawat_anestesi`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_anestesi_sedasi_ibfk_4` FOREIGN KEY (`kd_dokter_anestesi`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_anestesi_sedasi_ibfk_5` FOREIGN KEY (`kd_dokter_bedah`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_cek_gds
-- ----------------------------
DROP TABLE IF EXISTS `catatan_cek_gds`;
CREATE TABLE `catatan_cek_gds`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `gdp` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `insulin` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `obat_gula` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_cek_gds_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_cek_gds_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_infus_ralan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_infus_ralan`;
CREATE TABLE `catatan_infus_ralan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_infus` date NOT NULL,
  `jam_infus` time NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kolf` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_cairan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `obat` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_infus_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_infus_ralan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_keperawatan_ralan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_keperawatan_ralan`;
CREATE TABLE `catatan_keperawatan_ralan`  (
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `uraian` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tanggal`, `jam`, `no_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_keperawatan_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_keperawatan_ralan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_keperawatan_ranap
-- ----------------------------
DROP TABLE IF EXISTS `catatan_keperawatan_ranap`;
CREATE TABLE `catatan_keperawatan_ranap`  (
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `uraian` varchar(1000) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tanggal`, `jam`, `no_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_keperawatan_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_keperawatan_ranap_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_keseimbangan_cairan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_keseimbangan_cairan`;
CREATE TABLE `catatan_keseimbangan_cairan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `infus` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tranfusi` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `minum` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `urine` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `drain` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ngt` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `iwl` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keseimbangan` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_keseimbangan_cairan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_keseimbangan_cairan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_observasi_chbp
-- ----------------------------
DROP TABLE IF EXISTS `catatan_observasi_chbp`;
CREATE TABLE `catatan_observasi_chbp`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `djj` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `his` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ppv` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_observasi_chbp_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_observasi_chbp_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_observasi_igd
-- ----------------------------
DROP TABLE IF EXISTS `catatan_observasi_igd`;
CREATE TABLE `catatan_observasi_igd`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spo2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_observasi_igd_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_observasi_igd_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_observasi_induksi_persalinan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_observasi_induksi_persalinan`;
CREATE TABLE `catatan_observasi_induksi_persalinan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `obat` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cairan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `dosis` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `his` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `djj` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_observasi_induksi_persalinan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_observasi_induksi_persalinan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_observasi_ranap
-- ----------------------------
DROP TABLE IF EXISTS `catatan_observasi_ranap`;
CREATE TABLE `catatan_observasi_ranap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spo2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_observasi_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_observasi_ranap_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_observasi_ranap_kebidanan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_observasi_ranap_kebidanan`;
CREATE TABLE `catatan_observasi_ranap_kebidanan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spo2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kontraksi` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `bjj` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ppv` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `vt` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_observasi_ranap_kebidanan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_observasi_ranap_kebidanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_observasi_ranap_postpartum
-- ----------------------------
DROP TABLE IF EXISTS `catatan_observasi_ranap_postpartum`;
CREATE TABLE `catatan_observasi_ranap_postpartum`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `gcs` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `spo2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tfu` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kontraksi` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `perdarahan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_observasi_ranap_postpartum_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_observasi_ranap_postpartum_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_observasi_restrain_nonfarma
-- ----------------------------
DROP TABLE IF EXISTS `catatan_observasi_restrain_nonfarma`;
CREATE TABLE `catatan_observasi_restrain_nonfarma`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `tangan_kiri` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tangan_kanan` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kaki_kiri` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kaki_kanan` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `badan` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `edema` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `iritasi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sirkulasi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kondisi_keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_observasi_restrain_nonfarma_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_observasi_restrain_nonfarma_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_observasi_ventilator
-- ----------------------------
DROP TABLE IF EXISTS `catatan_observasi_ventilator`;
CREATE TABLE `catatan_observasi_ventilator`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `mode` enum('CPAP','Nasal IMV','IMV','SIMV','A/C Atau SIPPV','PSV','Volume Guarantee','HFO','HFO + IMV') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `vt` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pakar` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `reefps` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ee` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `tgl_perawatan`, `jam_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_observasi_ventilator_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_observasi_ventilator_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_pasien
-- ----------------------------
DROP TABLE IF EXISTS `catatan_pasien`;
CREATE TABLE `catatan_pasien`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `catatan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  PRIMARY KEY (`no_rkm_medis`) USING BTREE,
  INDEX `no_rkm_medis`(`no_rkm_medis`) USING BTREE,
  CONSTRAINT `catatan_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_perawatan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_perawatan`;
CREATE TABLE `catatan_perawatan`  (
  `tanggal` date NULL DEFAULT NULL,
  `jam` time NULL DEFAULT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `catatan` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  CONSTRAINT `catatan_perawatan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_perawatan_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for catatan_persalinan
-- ----------------------------
DROP TABLE IF EXISTS `catatan_persalinan`;
CREATE TABLE `catatan_persalinan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mulai` datetime NOT NULL,
  `selesai` datetime NOT NULL,
  `kd_dokter` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `catatan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `waktu_persalinan_kala_1` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `waktu_persalinan_kala_2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `waktu_persalinan_kala_3` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `waktu_persalinan_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perineum` enum('Utuh','Rupture','Episiotomi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jahitan_luar_1` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jahitan_luar_2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jahitan_dalam_1` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jahitan_dalam_2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `anak` enum('Laki-laki','Perempuan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_lahir` enum('Hidup','Mati') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `apgar_score` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `bb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pb` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kelainan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ketuban` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `placenta` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ukuran` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tali_pusat` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `insertio` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `darah_keluar_kala_1` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `darah_keluar_kala_2` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `darah_keluar_kala_3` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `darah_keluar_kala_4` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `darah_keluar_jumlah` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kondisi_umum` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `td` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nadi` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rr` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontraksi_uterus` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ppv` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pengobatan` varchar(600) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kd_dokter`(`kd_dokter`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `catatan_persalinan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_persalinan_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_persalinan_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for checklist_kriteria_keluar_hcu
-- ----------------------------
DROP TABLE IF EXISTS `checklist_kriteria_keluar_hcu`;
CREATE TABLE `checklist_kriteria_keluar_hcu`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kriteria1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria9` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria10` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria11` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria12` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nik`(`nik`) USING BTREE,
  CONSTRAINT `checklist_kriteria_keluar_hcu_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_kriteria_keluar_hcu_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for checklist_kriteria_keluar_icu
-- ----------------------------
DROP TABLE IF EXISTS `checklist_kriteria_keluar_icu`;
CREATE TABLE `checklist_kriteria_keluar_icu`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kriteria1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria9` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria10` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria11` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nik`(`nik`) USING BTREE,
  CONSTRAINT `checklist_kriteria_keluar_icu_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_kriteria_keluar_icu_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for checklist_kriteria_masuk_hcu
-- ----------------------------
DROP TABLE IF EXISTS `checklist_kriteria_masuk_hcu`;
CREATE TABLE `checklist_kriteria_masuk_hcu`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `kardiologi1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kardiologi2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kardiologi3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kardiologi4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kardiologi5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kardiologi6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pernapasan1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pernapasan2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pernapasan3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `syaraf1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `syaraf2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `syaraf3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `syaraf4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pencernaan1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pencernaan2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pencernaan3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pencernaan4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pembedahan1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pembedahan2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hematologi1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `hematologi2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `infeksi` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nik`(`nik`) USING BTREE,
  CONSTRAINT `checklist_kriteria_masuk_hcu_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_kriteria_masuk_hcu_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for checklist_kriteria_masuk_icu
-- ----------------------------
DROP TABLE IF EXISTS `checklist_kriteria_masuk_icu`;
CREATE TABLE `checklist_kriteria_masuk_icu`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `prioritas1_1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas1_2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas1_3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas1_4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas1_5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas1_6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas2_1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas2_2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas2_3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas2_4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas2_5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas2_6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas2_7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas2_8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas3_1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas3_2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas3_3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `prioritas3_4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_tanda_vital_1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_tanda_vital_2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_tanda_vital_3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_tanda_vital_4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_tanda_vital_5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_laborat_1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_laborat_2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_laborat_3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_laborat_4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_laborat_5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_laborat_6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_radiologi_1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_radiologi_2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_klinis_1` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_klinis_2` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_klinis_3` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_klinis_4` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_klinis_5` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_klinis_6` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_klinis_7` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kriteria_fisiologis_klinis_8` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nik`(`nik`) USING BTREE,
  CONSTRAINT `checklist_kriteria_masuk_icu_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_kriteria_masuk_icu_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for checklist_pemberian_fibrinolitik
-- ----------------------------
DROP TABLE IF EXISTS `checklist_pemberian_fibrinolitik`;
CREATE TABLE `checklist_pemberian_fibrinolitik`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kontra_indikasi1` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi1` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi2` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi2` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi3` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi3` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi4` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi4` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi5` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi5` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi6` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi6` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi7` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi7` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi8` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi8` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi9` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi9` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kontra_indikasi10` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_kontra_indikasi10` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `risiko_tinggi1` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_risiko_tinggi1` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `risiko_tinggi2` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_risiko_tinggi2` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `risiko_tinggi3` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_risiko_tinggi3` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `risiko_tinggi4` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_risiko_tinggi4` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `risiko_tinggi5` enum('Tidak','Ya') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_risiko_tinggi5` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kesimpulan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `persyaratan_ekg_pre_streptase` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `persyaratan_ekg_post_streptase` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cek_troponin` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `checklist_pemberian_fibrinolitik_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_pemberian_fibrinolitik_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for checklist_post_operasi
-- ----------------------------
DROP TABLE IF EXISTS `checklist_post_operasi`;
CREATE TABLE `checklist_post_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `sncn` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tindakan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter_bedah` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keadaan_umum` enum('Sadar','Tidur','Terintubasi') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_rontgen` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_rontgen` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_ekg` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_ekg` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_usg` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_usg` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_ctscan` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_ctscan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_mri` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_mri` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jenis_cairan_infus` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kateter_urine` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_pemasangan_kateter` datetime NULL DEFAULT NULL,
  `warna_kateter` enum('Jernih','Keruh','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah_kateter` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `area_luka_operasi` varchar(120) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `drain` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah_drain` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `letak_drain` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `warna_drain` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jaringan_pa` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip_perawat_ok` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip_perawat_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nip_perawat_ok`(`nip_perawat_ok`) USING BTREE,
  INDEX `kd_dokter_anestesi`(`kd_dokter_anestesi`) USING BTREE,
  INDEX `kd_dokter_bedah`(`kd_dokter_bedah`) USING BTREE,
  INDEX `nip_perawat_anestesi`(`nip_perawat_anestesi`) USING BTREE,
  CONSTRAINT `checklist_post_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_post_operasi_ibfk_2` FOREIGN KEY (`nip_perawat_ok`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_post_operasi_ibfk_3` FOREIGN KEY (`nip_perawat_anestesi`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_post_operasi_ibfk_4` FOREIGN KEY (`kd_dokter_anestesi`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_post_operasi_ibfk_5` FOREIGN KEY (`kd_dokter_bedah`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for checklist_pre_operasi
-- ----------------------------
DROP TABLE IF EXISTS `checklist_pre_operasi`;
CREATE TABLE `checklist_pre_operasi`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` datetime NOT NULL,
  `sncn` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tindakan` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter_bedah` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_dokter_anestesi` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `identitas` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `surat_ijin_bedah` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `surat_ijin_anestesi` enum('Ada','Tidak Ada') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `surat_ijin_transfusi` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `penandaan_area_operasi` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keadaan_umum` enum('Baik','Sedang','Lemah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_rontgen` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_rontgen` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_ekg` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_ekg` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_usg` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_usg` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_ctscan` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_ctscan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pemeriksaan_penunjang_mri` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_pemeriksaan_penunjang_mri` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `persiapan_darah` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan_persiapan_darah` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `perlengkapan_khusus` enum('Ada','Tidak Ada','Tidak Diperlukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip_petugas_ruangan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip_perawat_ok` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `tanggal`) USING BTREE,
  INDEX `nip_petugas_ruangan`(`nip_petugas_ruangan`) USING BTREE,
  INDEX `nip_perawat_ok`(`nip_perawat_ok`) USING BTREE,
  INDEX `kd_dokter_anestesi`(`kd_dokter_anestesi`) USING BTREE,
  INDEX `kd_dokter_bedah`(`kd_dokter_bedah`) USING BTREE,
  CONSTRAINT `checklist_pre_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_pre_operasi_ibfk_2` FOREIGN KEY (`nip_petugas_ruangan`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_pre_operasi_ibfk_3` FOREIGN KEY (`nip_perawat_ok`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_pre_operasi_ibfk_4` FOREIGN KEY (`kd_dokter_anestesi`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checklist_pre_operasi_ibfk_5` FOREIGN KEY (`kd_dokter_bedah`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for closing_kasir
-- ----------------------------
DROP TABLE IF EXISTS `closing_kasir`;
CREATE TABLE `closing_kasir`  (
  `shift` enum('Pagi','Siang','Sore','Malam') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`shift`) USING BTREE,
  INDEX `jam_masuk`(`jam_masuk`) USING BTREE,
  INDEX `jam_pulang`(`jam_pulang`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cssd_barang
-- ----------------------------
DROP TABLE IF EXISTS `cssd_barang`;
CREATE TABLE `cssd_barang`  (
  `no_inventaris` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jenis_barang` enum('Heacting Set','Partus Set','Set Bedah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_inventaris`) USING BTREE,
  CONSTRAINT `cssd_barang_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dansos
-- ----------------------------
DROP TABLE IF EXISTS `dansos`;
CREATE TABLE `dansos`  (
  `dana` double NOT NULL,
  PRIMARY KEY (`dana`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapur_detail_hibah
-- ----------------------------
DROP TABLE IF EXISTS `dapur_detail_hibah`;
CREATE TABLE `dapur_detail_hibah`  (
  `no_hibah` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah` double NULL DEFAULT NULL,
  `h_hibah` double NULL DEFAULT NULL,
  `subtotalhibah` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_hibah`, `kode_brng`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `no_hibah`(`no_hibah`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  CONSTRAINT `dapur_detail_hibah_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapur_detail_hibah_ibfk_2` FOREIGN KEY (`no_hibah`) REFERENCES `dapur_hibah` (`no_hibah`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapur_detail_hibah_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapur_detail_returbeli
-- ----------------------------
DROP TABLE IF EXISTS `dapur_detail_returbeli`;
CREATE TABLE `dapur_detail_returbeli`  (
  `no_retur_beli` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `h_beli` double NULL DEFAULT NULL,
  `h_retur` double NULL DEFAULT NULL,
  `jml_retur` double NULL DEFAULT NULL,
  `total` double NULL DEFAULT NULL,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `no_retur_beli`(`no_retur_beli`) USING BTREE,
  CONSTRAINT `dapur_detail_returbeli_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `dapur_detail_returbeli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapur_detail_returbeli_ibfk_3` FOREIGN KEY (`no_retur_beli`) REFERENCES `dapurreturbeli` (`no_retur_beli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapur_detail_titip_faktur
-- ----------------------------
DROP TABLE IF EXISTS `dapur_detail_titip_faktur`;
CREATE TABLE `dapur_detail_titip_faktur`  (
  `no_tagihan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_tagihan`, `no_faktur`) USING BTREE,
  INDEX `no_faktur`(`no_faktur`) USING BTREE,
  CONSTRAINT `dapur_detail_titip_faktur_ibfk_1` FOREIGN KEY (`no_tagihan`) REFERENCES `dapur_titip_faktur` (`no_tagihan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapur_detail_titip_faktur_ibfk_2` FOREIGN KEY (`no_faktur`) REFERENCES `dapurpemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapur_hibah
-- ----------------------------
DROP TABLE IF EXISTS `dapur_hibah`;
CREATE TABLE `dapur_hibah`  (
  `no_hibah` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_pemberi` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_hibah` date NULL DEFAULT NULL,
  `totalhibah` double NOT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_hibah`) USING BTREE,
  INDEX `kode_pemberi`(`kode_pemberi`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `dapur_hibah_ibfk_1` FOREIGN KEY (`kode_pemberi`) REFERENCES `pemberihibah` (`kode_pemberi`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `dapur_hibah_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapur_riwayat_barang
-- ----------------------------
DROP TABLE IF EXISTS `dapur_riwayat_barang`;
CREATE TABLE `dapur_riwayat_barang`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stok_awal` double NULL DEFAULT NULL,
  `masuk` double NULL DEFAULT NULL,
  `keluar` double NULL DEFAULT NULL,
  `stok_akhir` double NOT NULL,
  `posisi` enum('Pengadaan','Penerimaan','Retur Beli','Opname','Stok Keluar','Hibah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `jam` time NULL DEFAULT NULL,
  `petugas` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Simpan','Hapus') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `dapur_riwayat_barang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapur_titip_faktur
-- ----------------------------
DROP TABLE IF EXISTS `dapur_titip_faktur`;
CREATE TABLE `dapur_titip_faktur`  (
  `no_tagihan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` enum('Ditagihkan','Dibayar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_tagihan`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `dapur_titip_faktur_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapurbarang
-- ----------------------------
DROP TABLE IF EXISTS `dapurbarang`;
CREATE TABLE `dapurbarang`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_brng` varchar(80) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jenis` enum('Basah','Kering') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `stok` double NOT NULL,
  `harga` double NOT NULL,
  `status` enum('0','1') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `nama_brng`(`nama_brng`) USING BTREE,
  INDEX `jenis`(`jenis`) USING BTREE,
  INDEX `stok`(`stok`) USING BTREE,
  INDEX `harga`(`harga`) USING BTREE,
  CONSTRAINT `dapurbarang_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapurdetailbeli
-- ----------------------------
DROP TABLE IF EXISTS `dapurdetailbeli`;
CREATE TABLE `dapurdetailbeli`  (
  `no_faktur` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `subtotal` double NOT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `jumlah`(`jumlah`) USING BTREE,
  INDEX `harga`(`harga`) USING BTREE,
  INDEX `subtotal`(`subtotal`) USING BTREE,
  INDEX `dis`(`dis`) USING BTREE,
  INDEX `besardis`(`besardis`) USING BTREE,
  INDEX `total`(`total`) USING BTREE,
  INDEX `no_faktur`(`no_faktur`) USING BTREE,
  CONSTRAINT `dapurdetailbeli_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `dapurpembelian` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapurdetailbeli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapurdetailbeli_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapurdetailpengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `dapurdetailpengeluaran`;
CREATE TABLE `dapurdetailpengeluaran`  (
  `no_keluar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `jumlah`(`jumlah`) USING BTREE,
  INDEX `harga`(`harga`) USING BTREE,
  INDEX `total`(`total`) USING BTREE,
  INDEX `no_keluar`(`no_keluar`) USING BTREE,
  CONSTRAINT `dapurdetailpengeluaran_ibfk_1` FOREIGN KEY (`no_keluar`) REFERENCES `dapurpengeluaran` (`no_keluar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapurdetailpengeluaran_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `dapurdetailpengeluaran_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapurdetailpesan
-- ----------------------------
DROP TABLE IF EXISTS `dapurdetailpesan`;
CREATE TABLE `dapurdetailpesan`  (
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `subtotal` double NOT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  INDEX `no_faktur`(`no_faktur`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  CONSTRAINT `dapurdetailpesan_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `dapurpemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapurdetailpesan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapurdetailpesan_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapuropname
-- ----------------------------
DROP TABLE IF EXISTS `dapuropname`;
CREATE TABLE `dapuropname`  (
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `h_beli` double NULL DEFAULT NULL,
  `tanggal` date NOT NULL,
  `stok` int(11) NOT NULL,
  `real` int(11) NOT NULL,
  `selisih` int(11) NOT NULL,
  `nomihilang` double NOT NULL,
  `lebih` int(11) NOT NULL,
  `nomilebih` double NOT NULL,
  `keterangan` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`kode_brng`, `tanggal`) USING BTREE,
  INDEX `stok`(`stok`) USING BTREE,
  INDEX `real`(`real`) USING BTREE,
  INDEX `selisih`(`selisih`) USING BTREE,
  INDEX `nomihilang`(`nomihilang`) USING BTREE,
  INDEX `keterangan`(`keterangan`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `dapuropname_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapurpembelian
-- ----------------------------
DROP TABLE IF EXISTS `dapurpembelian`;
CREATE TABLE `dapurpembelian`  (
  `no_faktur` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_suplier` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_beli` date NOT NULL,
  `subtotal` double NOT NULL,
  `potongan` double NOT NULL,
  `total` double NOT NULL,
  `ppn` double NULL DEFAULT NULL,
  `meterai` double NULL DEFAULT NULL,
  `tagihan` double NULL DEFAULT NULL,
  `kd_rek` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_faktur`) USING BTREE,
  INDEX `kode_suplier`(`kode_suplier`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `tgl_beli`(`tgl_beli`) USING BTREE,
  INDEX `subtotal`(`subtotal`) USING BTREE,
  INDEX `potongan`(`potongan`) USING BTREE,
  INDEX `total`(`total`) USING BTREE,
  INDEX `kd_rek`(`kd_rek`) USING BTREE,
  CONSTRAINT `dapurpembelian_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `dapurpembelian_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `dapurpembelian_ibfk_3` FOREIGN KEY (`kode_suplier`) REFERENCES `dapursuplier` (`kode_suplier`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapurpemesanan
-- ----------------------------
DROP TABLE IF EXISTS `dapurpemesanan`;
CREATE TABLE `dapurpemesanan`  (
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_order` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_suplier` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_pesan` date NULL DEFAULT NULL,
  `tgl_faktur` date NULL DEFAULT NULL,
  `tgl_tempo` date NULL DEFAULT NULL,
  `total1` double NOT NULL,
  `potongan` double NOT NULL,
  `total2` double NOT NULL,
  `ppn` double NOT NULL,
  `meterai` double NULL DEFAULT NULL,
  `tagihan` double NOT NULL,
  `status` enum('Sudah Dibayar','Belum Dibayar','Belum Lunas','Titip Faktur') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_faktur`) USING BTREE,
  INDEX `kode_suplier`(`kode_suplier`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `dapurpemesanan_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `dapursuplier` (`kode_suplier`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `dapurpemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapurpengeluaran
-- ----------------------------
DROP TABLE IF EXISTS `dapurpengeluaran`;
CREATE TABLE `dapurpengeluaran`  (
  `no_keluar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_keluar`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `tanggal`(`tanggal`) USING BTREE,
  INDEX `keterangan`(`keterangan`) USING BTREE,
  CONSTRAINT `dapurpengeluaran_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapurreturbeli
-- ----------------------------
DROP TABLE IF EXISTS `dapurreturbeli`;
CREATE TABLE `dapurreturbeli`  (
  `no_retur_beli` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_retur` date NULL DEFAULT NULL,
  `nip` char(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_suplier` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `catatan` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`no_retur_beli`) USING BTREE,
  INDEX `kode_suplier`(`kode_suplier`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  CONSTRAINT `dapurreturbeli_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `dapursuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dapurreturbeli_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for dapursuplier
-- ----------------------------
DROP TABLE IF EXISTS `dapursuplier`;
CREATE TABLE `dapursuplier`  (
  `kode_suplier` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_suplier` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kota` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bank` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rekening` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_suplier`) USING BTREE,
  INDEX `nama_suplier`(`nama_suplier`) USING BTREE,
  INDEX `alamat`(`alamat`) USING BTREE,
  INDEX `kota`(`kota`) USING BTREE,
  INDEX `no_telp`(`no_telp`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_HAIs
-- ----------------------------
DROP TABLE IF EXISTS `data_HAIs`;
CREATE TABLE `data_HAIs`  (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ETT` int(11) NULL DEFAULT NULL,
  `CVL` int(11) NULL DEFAULT NULL,
  `IVL` int(11) NULL DEFAULT NULL,
  `UC` int(11) NULL DEFAULT NULL,
  `VAP` int(11) NULL DEFAULT NULL,
  `IAD` int(11) NULL DEFAULT NULL,
  `PLEB` int(11) NULL DEFAULT NULL,
  `ISK` int(11) NULL DEFAULT NULL,
  `ILO` int(11) NOT NULL,
  `HAP` int(11) NULL DEFAULT NULL,
  `Tinea` int(11) NULL DEFAULT NULL,
  `Scabies` int(11) NULL DEFAULT NULL,
  `DEKU` enum('IYA','TIDAK') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `SPUTUM` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `DARAH` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `URINE` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ANTIBIOTIK` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_kamar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `no_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `ETT`(`ETT`) USING BTREE,
  INDEX `CVL`(`CVL`) USING BTREE,
  INDEX `IVL`(`IVL`) USING BTREE,
  INDEX `SPUTUM`(`SPUTUM`) USING BTREE,
  INDEX `ANTIBIOTIK`(`ANTIBIOTIK`) USING BTREE,
  INDEX `DARAH`(`DARAH`) USING BTREE,
  INDEX `URINE`(`URINE`) USING BTREE,
  INDEX `DEKU`(`DEKU`) USING BTREE,
  INDEX `ISK`(`ISK`) USING BTREE,
  INDEX `PLEB`(`PLEB`) USING BTREE,
  INDEX `IAD`(`IAD`) USING BTREE,
  INDEX `VAP`(`VAP`) USING BTREE,
  INDEX `UC`(`UC`) USING BTREE,
  INDEX `ILO`(`ILO`) USING BTREE,
  INDEX `kd_kamar`(`kd_kamar`) USING BTREE,
  CONSTRAINT `data_HAIs_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_HAIs_ibfk_2` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_batch
-- ----------------------------
DROP TABLE IF EXISTS `data_batch`;
CREATE TABLE `data_batch`  (
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl_beli` date NOT NULL,
  `tgl_kadaluarsa` date NOT NULL,
  `asal` enum('Penerimaan','Pengadaan','Hibah') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
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
  `jumlahbeli` double NOT NULL,
  `sisa` double NOT NULL,
  PRIMARY KEY (`no_batch`, `kode_brng`, `no_faktur`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `data_batch_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_klasifikasi_pasien_ranap
-- ----------------------------
DROP TABLE IF EXISTS `data_klasifikasi_pasien_ranap`;
CREATE TABLE `data_klasifikasi_pasien_ranap`  (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(51) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Minimal` enum('TIDAK','IYA') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Partial` enum('TIDAK','IYA') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `Total` enum('TIDAK','IYA') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_kamar` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tanggal`, `no_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kd_kamar`(`kd_kamar`) USING BTREE,
  CONSTRAINT `data_klasifikasi_pasien_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_klasifikasi_pasien_ranap_ibfk_2` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_tb
-- ----------------------------
DROP TABLE IF EXISTS `data_tb`;
CREATE TABLE `data_tb`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_tb_03` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_periode_laporan` enum('1=Januari - Maret','2=April - Juni','3=Juli - September','4=Oktober - Desember') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_buat_laporan` datetime NULL DEFAULT NULL,
  `tahun_buat_laporan` year NULL DEFAULT NULL,
  `kd_wasor` int(11) NULL DEFAULT NULL,
  `noregkab` int(11) NULL DEFAULT NULL,
  `id_propinsi` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kd_kabupaten` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_kecamatan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_kelurahan` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_rujukan` enum('Inisiatif pasien/Keluarga','Anggota Masyarakat/Kader','Faskes','Dokter Praktek Mandiri','Poli lain','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sebutkan1` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipe_diagnosis` enum('Terkonfirmasi bakteriologis','Terdiagnosis klinis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klasifikasi_lokasi_anatomi` enum('Paru','Ekstraparu') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klasifikasi_riwayat_pengobatan` enum('Baru','Kambuh','Diobati setelah gagal','Diobati Setelah Putus Berobat','Lain-lain','Riwayat Pengobatan Sebelumnya Tidak Diketahui','Pindahan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `klasifikasi_status_hiv` enum('Positif','Negatif','Tidak diketahui') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `total_skoring_anak` enum('1','2','3','4','5','6','7','8','9','10','11','12','13','Tidak dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `konfirmasiSkoring5` enum('Uji Tuberkulin Positif','Ada Kontak TB Paru','Uji Tuberkulin Negatif','Tidak Ada Kontak TB Paru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `konfirmasiSkoring6` enum('Ada Kontak TB Paru','Tidak Ada','Tidak Jelas Kontak TB Paru') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_mulai_pengobatan` date NULL DEFAULT NULL,
  `paduan_oat` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sumber_obat` enum('Program TB','Bayar Sendiri','Asuransi','Lain-lain') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sebutkan` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sebelum_pengobatan_hasil_mikroskopis` enum('Positif','Negatif','Tidak dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sebelum_pengobatan_hasil_tes_cepat` enum('Rif sensitif','Rif resisten','Negatif','Rif Indeterminated','Invalid','Error','No Result','Tidak dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sebelum_pengobatan_hasil_biakan` enum('Negatif','1-19 BTA','1+','2+','3+','4+','NTM','Kontaminasi','Tidak dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `noreglab_bulan_2` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hasil_mikroskopis_bulan_2` enum('Positif','Negatif','Tidak dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `noreglab_bulan_3` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hasil_mikroskopis_bulan_3` enum('Positif','Negatif','Tidak dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `noreglab_bulan_5` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hasil_mikroskopis_bulan_5` enum('Positif','Negatif','Tidak dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `akhir_pengobatan_noreglab` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `akhir_pengobatan_hasil_mikroskopis` enum('Positif','Negatif','Tidak dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_hasil_akhir_pengobatan` date NULL DEFAULT NULL,
  `hasil_akhir_pengobatan` enum('Belum','Sembuh','Pengobatan Lengkap','Lost To Follow Up','Meninggal','Gagal','Pindah','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tanggal_dianjurkan_tes` date NULL DEFAULT NULL,
  `tanggal_tes_hiv` date NULL DEFAULT NULL,
  `hasil_tes_hiv` enum('Reaktif','Non Reaktif','Indeterminated') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ppk` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `art` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tb_dm` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `terapi_dm` enum('OHO','Inj. Insulin','') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pindah_ro` enum('Ya','Tidak') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_pengobatan` enum('Sesuai Standar','Tidak Sesuai Standar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `foto_toraks` enum('Positif','Negatif','Tidak Dilakukan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `toraks_tdk_dilakukan` enum('Tidak dilakukan','Setelah terapi antibioka non OAT: tidak ada perbaikan Klinis, ada faktor resiko TB, dan atas pertimbangan dokter','Setelah terapi antibioka non OAT: ada Perbaikan Klinis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `keterangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_icd_x` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kode_icd_x`(`kode_icd_x`) USING BTREE,
  CONSTRAINT `data_tb_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_tb_ibfk_2` FOREIGN KEY (`kode_icd_x`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_triase_igd
-- ----------------------------
DROP TABLE IF EXISTS `data_triase_igd`;
CREATE TABLE `data_triase_igd`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_kunjungan` datetime NOT NULL,
  `cara_masuk` enum('Jalan','Brankar','Kursi Roda','Digendong') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alat_transportasi` enum('-','AGD','Sendiri','Swasta') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `alasan_kedatangan` enum('Datang Sendiri','Polisi','Rujukan','-') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan_kedatangan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_kasus` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tekanan_darah` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nadi` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pernapasan` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `suhu` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `saturasi_o2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nyeri` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `kode_kasus`(`kode_kasus`) USING BTREE,
  CONSTRAINT `data_triase_igd_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igd_ibfk_2` FOREIGN KEY (`kode_kasus`) REFERENCES `master_triase_macam_kasus` (`kode_kasus`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_triase_igddetail_skala1
-- ----------------------------
DROP TABLE IF EXISTS `data_triase_igddetail_skala1`;
CREATE TABLE `data_triase_igddetail_skala1`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_skala1` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode_skala1`) USING BTREE,
  INDEX `data_triase_igddetail_skala1_ibfk_1`(`kode_skala1`) USING BTREE,
  CONSTRAINT `data_triase_igddetail_skala1_ibfk_1` FOREIGN KEY (`kode_skala1`) REFERENCES `master_triase_skala1` (`kode_skala1`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala1_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_triase_igddetail_skala2
-- ----------------------------
DROP TABLE IF EXISTS `data_triase_igddetail_skala2`;
CREATE TABLE `data_triase_igddetail_skala2`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_skala2` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode_skala2`) USING BTREE,
  INDEX `kode_skala2`(`kode_skala2`) USING BTREE,
  CONSTRAINT `data_triase_igddetail_skala2_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala2_ibfk_2` FOREIGN KEY (`kode_skala2`) REFERENCES `master_triase_skala2` (`kode_skala2`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_triase_igddetail_skala3
-- ----------------------------
DROP TABLE IF EXISTS `data_triase_igddetail_skala3`;
CREATE TABLE `data_triase_igddetail_skala3`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_skala3` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode_skala3`) USING BTREE,
  INDEX `kode_skala3`(`kode_skala3`) USING BTREE,
  CONSTRAINT `data_triase_igddetail_skala3_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala3_ibfk_2` FOREIGN KEY (`kode_skala3`) REFERENCES `master_triase_skala3` (`kode_skala3`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_triase_igddetail_skala4
-- ----------------------------
DROP TABLE IF EXISTS `data_triase_igddetail_skala4`;
CREATE TABLE `data_triase_igddetail_skala4`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_skala4` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode_skala4`) USING BTREE,
  INDEX `kode_skala4`(`kode_skala4`) USING BTREE,
  CONSTRAINT `data_triase_igddetail_skala4_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala4_ibfk_2` FOREIGN KEY (`kode_skala4`) REFERENCES `master_triase_skala4` (`kode_skala4`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_triase_igddetail_skala5
-- ----------------------------
DROP TABLE IF EXISTS `data_triase_igddetail_skala5`;
CREATE TABLE `data_triase_igddetail_skala5`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_skala5` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kode_skala5`) USING BTREE,
  INDEX `kode_skala5`(`kode_skala5`) USING BTREE,
  CONSTRAINT `data_triase_igddetail_skala5_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala5_ibfk_2` FOREIGN KEY (`kode_skala5`) REFERENCES `master_triase_skala5` (`kode_skala5`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_triase_igdprimer
-- ----------------------------
DROP TABLE IF EXISTS `data_triase_igdprimer`;
CREATE TABLE `data_triase_igdprimer`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keluhan_utama` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kebutuhan_khusus` enum('-','UPPA','Airborne','Dekontaminan') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `catatan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `plan` enum('Ruang Resusitasi','Ruang Kritis') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggaltriase` datetime NOT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip`(`nik`) USING BTREE,
  CONSTRAINT `data_triase_igdprimer_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igdprimer_ibfk_2` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for data_triase_igdsekunder
-- ----------------------------
DROP TABLE IF EXISTS `data_triase_igdsekunder`;
CREATE TABLE `data_triase_igdsekunder`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `anamnesa_singkat` varchar(400) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `catatan` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `plan` enum('Zona Kuning','Zona Hijau') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggaltriase` datetime NOT NULL,
  `nik` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  INDEX `nip`(`nik`) USING BTREE,
  CONSTRAINT `data_triase_igdsekunder_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igdsekunder_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for datasuplier
-- ----------------------------
DROP TABLE IF EXISTS `datasuplier`;
CREATE TABLE `datasuplier`  (
  `kode_suplier` char(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_suplier` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `alamat` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kota` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bank` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `rekening` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kode_suplier`) USING BTREE,
  INDEX `nama_suplier`(`nama_suplier`) USING BTREE,
  INDEX `alamat`(`alamat`) USING BTREE,
  INDEX `kota`(`kota`) USING BTREE,
  INDEX `no_telp`(`no_telp`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for departemen
-- ----------------------------
DROP TABLE IF EXISTS `departemen`;
CREATE TABLE `departemen`  (
  `dep_id` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`dep_id`) USING BTREE,
  INDEX `nama`(`nama`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for deposit
-- ----------------------------
DROP TABLE IF EXISTS `deposit`;
CREATE TABLE `deposit`  (
  `no_deposit` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_deposit` datetime NOT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `besarppn` double NOT NULL,
  `besar_deposit` double NULL DEFAULT NULL,
  `nip` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `keterangan` varchar(70) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_deposit`) USING BTREE,
  INDEX `nip`(`nip`) USING BTREE,
  INDEX `besar_deposit`(`besar_deposit`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nama_bayar`(`nama_bayar`) USING BTREE,
  CONSTRAINT `deposit_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `deposit_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `deposit_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_beri_diet
-- ----------------------------
DROP TABLE IF EXISTS `detail_beri_diet`;
CREATE TABLE `detail_beri_diet`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_kamar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tanggal` date NOT NULL,
  `waktu` enum('Pagi','Pagi2','Pagi3','Siang','Siang2','Siang3','Sore','Sore2','Sore3','Malam','Malam2','Malam3') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_diet` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_kamar`, `tanggal`, `waktu`, `kd_diet`) USING BTREE,
  INDEX `kd_kamar`(`kd_kamar`) USING BTREE,
  INDEX `kd_diet`(`kd_diet`) USING BTREE,
  INDEX `tanggal`(`tanggal`) USING BTREE,
  INDEX `waktu`(`waktu`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `detail_beri_diet_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_beri_diet_ibfk_5` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_beri_diet_ibfk_6` FOREIGN KEY (`kd_diet`) REFERENCES `diet` (`kd_diet`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_beri_diet_ibfk_7` FOREIGN KEY (`waktu`) REFERENCES `jam_diet_pasien` (`waktu`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_instrumen_uji_fungsi_kfr
-- ----------------------------
DROP TABLE IF EXISTS `detail_instrumen_uji_fungsi_kfr`;
CREATE TABLE `detail_instrumen_uji_fungsi_kfr`  (
  `no_rawat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_nota_inap
-- ----------------------------
DROP TABLE IF EXISTS `detail_nota_inap`;
CREATE TABLE `detail_nota_inap`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `besarppn` double NULL DEFAULT NULL,
  `besar_bayar` double NULL DEFAULT NULL,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nama_bayar`(`nama_bayar`) USING BTREE,
  INDEX `besarppn`(`besarppn`) USING BTREE,
  INDEX `besar_bayar`(`besar_bayar`) USING BTREE,
  CONSTRAINT `detail_nota_inap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_nota_inap_ibfk_2` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_nota_jalan
-- ----------------------------
DROP TABLE IF EXISTS `detail_nota_jalan`;
CREATE TABLE `detail_nota_jalan`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_bayar` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `besarppn` double NULL DEFAULT NULL,
  `besar_bayar` double NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `nama_bayar`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `nama_bayar`(`nama_bayar`) USING BTREE,
  INDEX `besarppn`(`besarppn`) USING BTREE,
  INDEX `besar_bayar`(`besar_bayar`) USING BTREE,
  CONSTRAINT `detail_nota_jalan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_nota_jalan_ibfk_2` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_obat_racikan
-- ----------------------------
DROP TABLE IF EXISTS `detail_obat_racikan`;
CREATE TABLE `detail_obat_racikan`  (
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tgl_perawatan`, `jam`, `no_rawat`, `no_racik`, `kode_brng`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `detail_obat_racikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_obat_racikan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_obat_racikan_jual
-- ----------------------------
DROP TABLE IF EXISTS `detail_obat_racikan_jual`;
CREATE TABLE `detail_obat_racikan_jual`  (
  `nota_jual` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_racik` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`nota_jual`, `no_racik`, `kode_brng`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `detail_obat_racikan_jual_ibfk_1` FOREIGN KEY (`nota_jual`) REFERENCES `penjualan` (`nota_jual`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_obat_racikan_jual_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_penagihan_piutang
-- ----------------------------
DROP TABLE IF EXISTS `detail_penagihan_piutang`;
CREATE TABLE `detail_penagihan_piutang`  (
  `no_tagihan` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sisapiutang` double NOT NULL,
  PRIMARY KEY (`no_tagihan`, `no_rawat`) USING BTREE,
  INDEX `no_rawat`(`no_rawat`) USING BTREE,
  CONSTRAINT `detail_penagihan_piutang_ibfk_1` FOREIGN KEY (`no_tagihan`) REFERENCES `penagihan_piutang` (`no_tagihan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_penagihan_piutang_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_pengajuan_barang_dapur
-- ----------------------------
DROP TABLE IF EXISTS `detail_pengajuan_barang_dapur`;
CREATE TABLE `detail_pengajuan_barang_dapur`  (
  `no_pengajuan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah` double NULL DEFAULT NULL,
  `h_pengajuan` double NULL DEFAULT NULL,
  `total` double NOT NULL,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `no_pengajuan`(`no_pengajuan`) USING BTREE,
  CONSTRAINT `detail_pengajuan_barang_dapur_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_dapur_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_dapur_ibfk_3` FOREIGN KEY (`no_pengajuan`) REFERENCES `pengajuan_barang_dapur` (`no_pengajuan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_pengajuan_barang_medis
-- ----------------------------
DROP TABLE IF EXISTS `detail_pengajuan_barang_medis`;
CREATE TABLE `detail_pengajuan_barang_medis`  (
  `no_pengajuan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah` double NULL DEFAULT NULL,
  `h_pengajuan` double NULL DEFAULT NULL,
  `total` double NOT NULL,
  `jumlah2` double NOT NULL,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `no_pengajuan`(`no_pengajuan`) USING BTREE,
  CONSTRAINT `detail_pengajuan_barang_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_medis_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_medis_ibfk_3` FOREIGN KEY (`no_pengajuan`) REFERENCES `pengajuan_barang_medis` (`no_pengajuan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_pengajuan_barang_nonmedis
-- ----------------------------
DROP TABLE IF EXISTS `detail_pengajuan_barang_nonmedis`;
CREATE TABLE `detail_pengajuan_barang_nonmedis`  (
  `no_pengajuan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah` double NULL DEFAULT NULL,
  `h_pengajuan` double NULL DEFAULT NULL,
  `total` double NOT NULL,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `no_pengajuan`(`no_pengajuan`) USING BTREE,
  CONSTRAINT `detail_pengajuan_barang_nonmedis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_nonmedis_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_nonmedis_ibfk_3` FOREIGN KEY (`no_pengajuan`) REFERENCES `pengajuan_barang_nonmedis` (`no_pengajuan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_pengeluaran_obat_bhp
-- ----------------------------
DROP TABLE IF EXISTS `detail_pengeluaran_obat_bhp`;
CREATE TABLE `detail_pengeluaran_obat_bhp`  (
  `no_keluar` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `no_batch` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah` double NOT NULL,
  `harga_beli` double NOT NULL,
  `total` double NOT NULL,
  `no_faktur` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `jumlah`(`jumlah`) USING BTREE,
  INDEX `harga_beli`(`harga_beli`) USING BTREE,
  INDEX `total`(`total`) USING BTREE,
  INDEX `no_keluar`(`no_keluar`) USING BTREE,
  CONSTRAINT `detail_pengeluaran_obat_bhp_ibfk_1` FOREIGN KEY (`no_keluar`) REFERENCES `pengeluaran_obat_bhp` (`no_keluar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pengeluaran_obat_bhp_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_pengeluaran_obat_bhp_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_periksa_labpa
-- ----------------------------
DROP TABLE IF EXISTS `detail_periksa_labpa`;
CREATE TABLE `detail_periksa_labpa`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `diagnosa_klinik` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `makroskopik` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `mikroskopik` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `kesimpulan` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `kesan` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `no_sediaan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `detail_periksa_labpa_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_labpa_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_periksa_labpa_gambar
-- ----------------------------
DROP TABLE IF EXISTS `detail_periksa_labpa_gambar`;
CREATE TABLE `detail_periksa_labpa_gambar`  (
  `no_rawat` varchar(17) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kd_jenis_prw` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `photo` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`no_rawat`, `kd_jenis_prw`, `tgl_periksa`, `jam`) USING BTREE,
  INDEX `kd_jenis_prw`(`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `detail_periksa_labpa_gambar_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_labpa_gambar_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_permintaan_dapur
-- ----------------------------
DROP TABLE IF EXISTS `detail_permintaan_dapur`;
CREATE TABLE `detail_permintaan_dapur`  (
  `no_permintaan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah` double NULL DEFAULT NULL,
  `keterangan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_permintaan`(`no_permintaan`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  CONSTRAINT `detail_permintaan_dapur_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_dapur` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_dapur_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `dapurbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_dapur_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_permintaan_medis
-- ----------------------------
DROP TABLE IF EXISTS `detail_permintaan_medis`;
CREATE TABLE `detail_permintaan_medis`  (
  `no_permintaan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah` double NULL DEFAULT NULL,
  `keterangan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_permintaan`(`no_permintaan`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  CONSTRAINT `detail_permintaan_medis_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_medis` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_medis_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_medis_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_permintaan_non_medis
-- ----------------------------
DROP TABLE IF EXISTS `detail_permintaan_non_medis`;
CREATE TABLE `detail_permintaan_non_medis`  (
  `no_permintaan` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_sat` char(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jumlah` double NULL DEFAULT NULL,
  `keterangan` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_permintaan`(`no_permintaan`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  INDEX `kode_sat`(`kode_sat`) USING BTREE,
  CONSTRAINT `detail_permintaan_non_medis_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_non_medis` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_non_medis_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_non_medis_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_permintaan_resep_pulang
-- ----------------------------
DROP TABLE IF EXISTS `detail_permintaan_resep_pulang`;
CREATE TABLE `detail_permintaan_resep_pulang`  (
  `no_permintaan` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml` double NULL DEFAULT NULL,
  `dosis` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  INDEX `no_permintaan`(`no_permintaan`) USING BTREE,
  INDEX `kode_brng`(`kode_brng`) USING BTREE,
  CONSTRAINT `detail_permintaan_resep_pulang_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_resep_pulang` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_resep_pulang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detail_permintaan_stok_obat_pasien
-- ----------------------------
DROP TABLE IF EXISTS `detail_permintaan_stok_obat_pasien`;
CREATE TABLE `detail_permintaan_stok_obat_pasien`  (
  `no_permintaan` varchar(14) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kode_brng` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jml` double NULL DEFAULT NULL,
  `aturan_pakai` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jam00` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam01` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam02` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam03` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam04` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam05` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam06` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam07` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam08` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam09` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam10` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam11` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam12` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam13` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam14` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam15` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam16` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam17` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam18` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam19` enum('true','false') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `jam20` enum('true','false') CHARACTER SET latin1 COLLATE lat