/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : db_dormitory_manager_web

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 15/07/2020 02:32:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', 1);
INSERT INTO `admin` VALUES (5, 'admin2', '12345', 1);

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `location` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dormitory_manager_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dormitory_id_fk`(`dormitory_manager_id`) USING BTREE,
  CONSTRAINT `dormitory_id_fk` FOREIGN KEY (`dormitory_manager_id`) REFERENCES `dormitory_manager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES (1, '五区A栋', '教学楼北面', 7);
INSERT INTO `building` VALUES (2, '五区B栋', '教学楼北面', 19);
INSERT INTO `building` VALUES (15, '00', '00', 7);
INSERT INTO `building` VALUES (16, '四区', '00', 18);

-- ----------------------------
-- Table structure for dormitory
-- ----------------------------
DROP TABLE IF EXISTS `dormitory`;
CREATE TABLE `dormitory`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `building_id` int(11) NOT NULL,
  `floor` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `max_number` int(2) NOT NULL,
  `lived_number` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `building_id_fk`(`building_id`) USING BTREE,
  CONSTRAINT `building_id_fk` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dormitory
-- ----------------------------
INSERT INTO `dormitory` VALUES (1, '5A 1402', 1, '一层', 8, 7);
INSERT INTO `dormitory` VALUES (5, '男生宿舍01栋1002', 1, '一层', 4, 1);
INSERT INTO `dormitory` VALUES (15, '中国', 2, '五', 1, 0);
INSERT INTO `dormitory` VALUES (16, '小', 2, '110', 1, 0);
INSERT INTO `dormitory` VALUES (17, '1', 2, '1', 1, 0);
INSERT INTO `dormitory` VALUES (20, '11', 1, '11', 11, 0);
INSERT INTO `dormitory` VALUES (21, '11', 1, '11', 11, 0);
INSERT INTO `dormitory` VALUES (22, '11', 15, '11', 11, 0);
INSERT INTO `dormitory` VALUES (23, '100', 16, '100', 10, 1);
INSERT INTO `dormitory` VALUES (24, '111', 16, '11', 11, 0);

-- ----------------------------
-- Table structure for dormitory_manager
-- ----------------------------
DROP TABLE IF EXISTS `dormitory_manager`;
CREATE TABLE `dormitory_manager`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dormitory_manager
-- ----------------------------
INSERT INTO `dormitory_manager` VALUES (7, '13316795103', '刘大爷', '123456', '男');
INSERT INTO `dormitory_manager` VALUES (18, '19924812037', '王阿姨', '123456', '女');
INSERT INTO `dormitory_manager` VALUES (19, 'DM1594748395793', '李阿姨', '123', '女');

-- ----------------------------
-- Table structure for live
-- ----------------------------
DROP TABLE IF EXISTS `live`;
CREATE TABLE `live`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `dormitory_id` int(11) NOT NULL,
  `live_date` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `student_id_live_fk`(`student_id`) USING BTREE,
  INDEX `dormitory_id_live_fk`(`dormitory_id`) USING BTREE,
  CONSTRAINT `dormitory_id_live_fk` FOREIGN KEY (`dormitory_id`) REFERENCES `dormitory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_id_live_fk` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of live
-- ----------------------------
INSERT INTO `live` VALUES (6, 7, 1, '2018-09-28');
INSERT INTO `live` VALUES (7, 8, 5, '2020-07-15');
INSERT INTO `live` VALUES (8, 18, 1, '2018-09-29');
INSERT INTO `live` VALUES (9, 19, 1, '2018-09-29');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (7, '18024040224', '何俊言', '000', '男');
INSERT INTO `student` VALUES (8, '18024040225', '李四', '123456', '男');
INSERT INTO `student` VALUES (9, '18024040220', '马冬梅', '123456789', '女');
INSERT INTO `student` VALUES (18, '18123456780', '晓明', '123', '男');
INSERT INTO `student` VALUES (19, '18123456781', '张军', '123456', '男');
INSERT INTO `student` VALUES (20, '18123456782', '黎明', '123456', '男');

SET FOREIGN_KEY_CHECKS = 1;
