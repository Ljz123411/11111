/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2018-04-15 20:41:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `adminId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '123456',
  `teacherId` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`adminId`),
  KEY `teacherId` (`teacherId`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`teacherId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'super_admin', null, '12345678952', '123456', '2');
INSERT INTO `admin` VALUES ('34', '??', null, '12312345698', '123456', '1');
INSERT INTO `admin` VALUES ('36', '??', null, '12345698745', '123456', '2');

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `classId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `grade` varchar(50) NOT NULL,
  `collegeId` int(20) unsigned NOT NULL,
  `mainTeacherId` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`classId`),
  KEY `class_ibfk_1` (`collegeId`),
  KEY `mainTeacherId` (`mainTeacherId`),
  CONSTRAINT `class_ibfk_1` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('1', '计算机科学与技术', '2014', '1', null);
INSERT INTO `class` VALUES ('2', '网络信息', '2014', '1', null);
INSERT INTO `class` VALUES ('3', '小学教育', '2015', '2', null);
INSERT INTO `class` VALUES ('4', '戏剧影视文学', '2016', '2', null);
INSERT INTO `class` VALUES ('5', '数学与应用数学', '2016', '3', null);

-- ----------------------------
-- Table structure for classcourse
-- ----------------------------
DROP TABLE IF EXISTS `classcourse`;
CREATE TABLE `classcourse` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `classId` int(10) unsigned NOT NULL,
  `courseId` int(20) unsigned NOT NULL,
  `courseName` varchar(255) CHARACTER SET utf8 NOT NULL,
  `obligatory` tinyint(1) unsigned DEFAULT '1' COMMENT '是否是必修',
  PRIMARY KEY (`id`),
  KEY `classId` (`classId`),
  KEY `courseId` (`courseId`),
  KEY `courseName` (`courseName`),
  CONSTRAINT `classcourse_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`classId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `classcourse_ibfk_2` FOREIGN KEY (`courseId`) REFERENCES `course` (`courseId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `classcourse_ibfk_3` FOREIGN KEY (`courseName`) REFERENCES `course` (`courseName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of classcourse
-- ----------------------------
INSERT INTO `classcourse` VALUES ('1', '1', '1001', '高等数学', '1');
INSERT INTO `classcourse` VALUES ('3', '1', '1002', '线性代数', '1');
INSERT INTO `classcourse` VALUES ('10', '1', '1004', '计算机原理', '1');
INSERT INTO `classcourse` VALUES ('12', '1', '1005', '网络原理', '1');
INSERT INTO `classcourse` VALUES ('13', '1', '1006', '英语', '1');
INSERT INTO `classcourse` VALUES ('14', '2', '1006', '英语', '1');
INSERT INTO `classcourse` VALUES ('15', '3', '1007', '汉语言文学', '1');
INSERT INTO `classcourse` VALUES ('16', '3', '1008', '小学教育', '1');
INSERT INTO `classcourse` VALUES ('17', '2', '1010', '近代史', '1');
INSERT INTO `classcourse` VALUES ('18', '2', '1001', '高等数学', '1');
INSERT INTO `classcourse` VALUES ('19', '2', '1002', '线性代数', '1');
INSERT INTO `classcourse` VALUES ('20', '2', '1005', '网络原理', '1');
INSERT INTO `classcourse` VALUES ('21', '3', '1011', '公共心理学', '1');
INSERT INTO `classcourse` VALUES ('22', '3', '1012', '公共教育学', '1');
INSERT INTO `classcourse` VALUES ('23', '3', '1017', '写作学', '1');
INSERT INTO `classcourse` VALUES ('24', '3', '1024', '古代汉语', '1');
INSERT INTO `classcourse` VALUES ('25', '4', '1007', '汉语言文学', '1');
INSERT INTO `classcourse` VALUES ('26', '4', '1010', '近代史', '1');
INSERT INTO `classcourse` VALUES ('27', '4', '1011', '公共心理学', '1');
INSERT INTO `classcourse` VALUES ('28', '4', '1016', '外国文学史', '1');
INSERT INTO `classcourse` VALUES ('29', '4', '1017', '写作学', '1');
INSERT INTO `classcourse` VALUES ('30', '4', '1024', '古代汉语', '1');
INSERT INTO `classcourse` VALUES ('31', '4', '1025', '文学理论', '1');

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `size` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of classroom
-- ----------------------------
INSERT INTO `classroom` VALUES ('1', '2教101', '50');
INSERT INTO `classroom` VALUES ('2', '2教102', '60');
INSERT INTO `classroom` VALUES ('3', '2教103', '55');
INSERT INTO `classroom` VALUES ('4', '2教104', '60');
INSERT INTO `classroom` VALUES ('5', '2教105', '60');
INSERT INTO `classroom` VALUES ('6', '2教106', '60');
INSERT INTO `classroom` VALUES ('7', '2教201', '55');
INSERT INTO `classroom` VALUES ('8', '2教202', '60');
INSERT INTO `classroom` VALUES ('9', '2教203', '60');
INSERT INTO `classroom` VALUES ('10', '2教204', '60');
INSERT INTO `classroom` VALUES ('11', '2教205', '70');
INSERT INTO `classroom` VALUES ('12', '2教206', '60');
INSERT INTO `classroom` VALUES ('13', '4教101', '40');
INSERT INTO `classroom` VALUES ('14', '4教102', '50');
INSERT INTO `classroom` VALUES ('15', '4教103', '50');
INSERT INTO `classroom` VALUES ('16', '4教104', '60');
INSERT INTO `classroom` VALUES ('17', '4教105', '55');

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college` (
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `collegeId` int(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`collegeId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES ('电子信息与电气工程学院', '1');
INSERT INTO `college` VALUES ('教育学院', '2');
INSERT INTO `college` VALUES ('数学统计学院', '3');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `courseId` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `courseName` varchar(255) CHARACTER SET utf8 NOT NULL,
  `collegeId` int(20) unsigned NOT NULL,
  `credit` int(10) DEFAULT NULL,
  PRIMARY KEY (`courseId`),
  KEY `collegeId` (`collegeId`),
  KEY `courseName` (`courseName`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1027 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1001', '高等数学', '3', '3');
INSERT INTO `course` VALUES ('1002', '线性代数', '3', '4');
INSERT INTO `course` VALUES ('1004', '计算机原理', '1', '3');
INSERT INTO `course` VALUES ('1005', '网络原理', '1', '2');
INSERT INTO `course` VALUES ('1006', '英语', '2', '3');
INSERT INTO `course` VALUES ('1007', '汉语言文学', '2', '4');
INSERT INTO `course` VALUES ('1008', '小学教育', '2', '3');
INSERT INTO `course` VALUES ('1009', '计算机导论', '1', '4');
INSERT INTO `course` VALUES ('1010', '近代史', '2', '3');
INSERT INTO `course` VALUES ('1011', '公共心理学', '2', '2');
INSERT INTO `course` VALUES ('1012', '公共教育学', '2', '2');
INSERT INTO `course` VALUES ('1013', '数学分析', '3', '4');
INSERT INTO `course` VALUES ('1015', '常微分方程', '3', '4');
INSERT INTO `course` VALUES ('1016', '外国文学史', '2', '2');
INSERT INTO `course` VALUES ('1017', '写作学', '2', '3');
INSERT INTO `course` VALUES ('1020', '电路分析', '1', '3');
INSERT INTO `course` VALUES ('1021', 'C语言程序设计', '1', '3');
INSERT INTO `course` VALUES ('1022', '微机原理与接口技术', '1', '4');
INSERT INTO `course` VALUES ('1023', '概率统计', '3', '3');
INSERT INTO `course` VALUES ('1024', '古代汉语', '2', '2');
INSERT INTO `course` VALUES ('1025', '文学理论', '2', '2');
INSERT INTO `course` VALUES ('1026', '中国古代诗歌史论', '2', '3');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `studentId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `collegeId` int(20) unsigned DEFAULT NULL,
  `classId` int(10) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `sex` int(11) unsigned DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '123456',
  `idCardNo` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`studentId`),
  KEY `student_ibfk_1` (`classId`),
  KEY `collegeId` (`collegeId`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`classId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20141030106 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('20141030101', '1', '1', '张良', '1', '1993-07-16', null, '123456', '');
INSERT INTO `student` VALUES ('20141030102', '1', '1', '刘云', '2', '1995-07-13', null, '123456', '');
INSERT INTO `student` VALUES ('20141030103', '1', '1', '李丽', '2', '1995-06-23', null, '123456', '');
INSERT INTO `student` VALUES ('20141030104', '2', '2', '张丽丽', '2', null, null, '123456', '');
INSERT INTO `student` VALUES ('20141030105', '1', '2', '李元芳', '1', '1995-06-16', null, '123456', '');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `collegeId` int(20) unsigned NOT NULL,
  `teacherId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `joindate` date DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  `sex` int(2) unsigned DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '123456',
  `idCardNo` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`teacherId`),
  KEY `collegeId` (`collegeId`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '1', '王萍', '2000-06-28', '12312345698', '2', '1978-04-07', '123456', '123456788');
INSERT INTO `teacher` VALUES ('1', '2', '李翔', '2010-07-21', '12345698745', '1', '1975-06-24', '123456', '123456787');
INSERT INTO `teacher` VALUES ('1', '3', '马丽', '2004-01-13', '12352647856', '2', '1973-04-15', '123456', '123456786');
INSERT INTO `teacher` VALUES ('2', '4', '袁莉', '2009-10-10', '12354785236', '2', '1980-10-15', '123456', '123456789');
INSERT INTO `teacher` VALUES ('2', '5', '王芳', '2001-07-11', '12345695648', '2', '1980-07-23', '123456', '123456785');
INSERT INTO `teacher` VALUES ('3', '6', '李兵', '2005-04-15', '14526325879', '1', '1985-05-01', '123456', '123456789');
