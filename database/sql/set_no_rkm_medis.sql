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

 Date: 19/10/2025 12:53:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for set_no_rkm_medis
-- ----------------------------
DROP TABLE IF EXISTS `set_no_rkm_medis`;
CREATE TABLE `set_no_rkm_medis`  (
  `no_rkm_medis` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
