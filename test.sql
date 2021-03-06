/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2018-05-09 18:58:17
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('1', '????????????????????????', '2014', '1', null);
INSERT INTO `class` VALUES ('2', '????????????', '2014', '1', null);
INSERT INTO `class` VALUES ('3', '????????????', '2015', '2', null);
INSERT INTO `class` VALUES ('4', '??????????????????', '2016', '2', null);
INSERT INTO `class` VALUES ('5', '?????????????????????', '2016', '3', null);
INSERT INTO `class` VALUES ('8', '????????????', '2015', '3', null);

-- ----------------------------
-- Table structure for classcourse
-- ----------------------------
DROP TABLE IF EXISTS `classcourse`;
CREATE TABLE `classcourse` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `classId` int(10) unsigned NOT NULL,
  `courseId` int(20) unsigned NOT NULL,
  `courseName` varchar(255) CHARACTER SET utf8 NOT NULL,
  `obligatory` tinyint(1) unsigned DEFAULT '1' COMMENT '???????????????',
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
INSERT INTO `classcourse` VALUES ('1', '1', '1001', '????????????', '1');
INSERT INTO `classcourse` VALUES ('3', '1', '1002', '????????????', '1');
INSERT INTO `classcourse` VALUES ('10', '1', '1004', '???????????????', '1');
INSERT INTO `classcourse` VALUES ('12', '1', '1005', '????????????', '1');
INSERT INTO `classcourse` VALUES ('13', '1', '1006', '??????', '1');
INSERT INTO `classcourse` VALUES ('14', '2', '1006', '??????', '1');
INSERT INTO `classcourse` VALUES ('15', '3', '1007', '???????????????', '1');
INSERT INTO `classcourse` VALUES ('16', '3', '1008', '????????????', '1');
INSERT INTO `classcourse` VALUES ('17', '2', '1010', '?????????', '1');
INSERT INTO `classcourse` VALUES ('18', '2', '1001', '????????????', '1');
INSERT INTO `classcourse` VALUES ('19', '2', '1002', '????????????', '1');
INSERT INTO `classcourse` VALUES ('20', '2', '1005', '????????????', '1');
INSERT INTO `classcourse` VALUES ('21', '3', '1011', '???????????????', '1');
INSERT INTO `classcourse` VALUES ('22', '3', '1012', '???????????????', '1');
INSERT INTO `classcourse` VALUES ('23', '3', '1017', '?????????', '1');
INSERT INTO `classcourse` VALUES ('24', '3', '1024', '????????????', '1');
INSERT INTO `classcourse` VALUES ('25', '4', '1007', '???????????????', '1');
INSERT INTO `classcourse` VALUES ('26', '4', '1010', '?????????', '1');
INSERT INTO `classcourse` VALUES ('27', '4', '1011', '???????????????', '1');
INSERT INTO `classcourse` VALUES ('28', '4', '1016', '???????????????', '1');
INSERT INTO `classcourse` VALUES ('29', '4', '1017', '?????????', '1');
INSERT INTO `classcourse` VALUES ('30', '4', '1024', '????????????', '1');
INSERT INTO `classcourse` VALUES ('31', '4', '1025', '????????????', '1');

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `size` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of classroom
-- ----------------------------
INSERT INTO `classroom` VALUES ('1', '2???101', '50');
INSERT INTO `classroom` VALUES ('2', '2???102', '60');
INSERT INTO `classroom` VALUES ('3', '2???103', '55');
INSERT INTO `classroom` VALUES ('4', '2???104', '60');
INSERT INTO `classroom` VALUES ('5', '2???105', '60');
INSERT INTO `classroom` VALUES ('6', '2???106', '60');
INSERT INTO `classroom` VALUES ('7', '2???201', '55');
INSERT INTO `classroom` VALUES ('8', '2???202', '60');
INSERT INTO `classroom` VALUES ('9', '2???203', '60');
INSERT INTO `classroom` VALUES ('10', '2???204', '60');
INSERT INTO `classroom` VALUES ('11', '2???205', '70');
INSERT INTO `classroom` VALUES ('12', '2???206', '60');
INSERT INTO `classroom` VALUES ('13', '4???101', '40');
INSERT INTO `classroom` VALUES ('14', '4???102', '50');
INSERT INTO `classroom` VALUES ('15', '4???103', '50');
INSERT INTO `classroom` VALUES ('16', '4???104', '60');
INSERT INTO `classroom` VALUES ('17', '4???105', '55');

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
INSERT INTO `college` VALUES ('?????????????????????????????????', '1');
INSERT INTO `college` VALUES ('????????????', '2');
INSERT INTO `college` VALUES ('??????????????????', '3');

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
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1027 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1001', '????????????', '3', '3');
INSERT INTO `course` VALUES ('1002', '????????????', '3', '4');
INSERT INTO `course` VALUES ('1004', '???????????????', '1', '3');
INSERT INTO `course` VALUES ('1005', '????????????', '1', '2');
INSERT INTO `course` VALUES ('1006', '??????', '2', '3');
INSERT INTO `course` VALUES ('1007', '???????????????', '2', '4');
INSERT INTO `course` VALUES ('1008', '????????????', '2', '3');
INSERT INTO `course` VALUES ('1009', '???????????????', '1', '4');
INSERT INTO `course` VALUES ('1010', '?????????', '2', '3');
INSERT INTO `course` VALUES ('1011', '???????????????', '2', '2');
INSERT INTO `course` VALUES ('1012', '???????????????', '2', '2');
INSERT INTO `course` VALUES ('1013', '????????????', '3', '4');
INSERT INTO `course` VALUES ('1015', '???????????????', '3', '4');
INSERT INTO `course` VALUES ('1016', '???????????????', '2', '2');
INSERT INTO `course` VALUES ('1017', '?????????', '2', '3');
INSERT INTO `course` VALUES ('1020', '????????????', '1', '3');
INSERT INTO `course` VALUES ('1021', 'C??????????????????', '1', '3');
INSERT INTO `course` VALUES ('1022', '???????????????????????????', '1', '4');
INSERT INTO `course` VALUES ('1023', '????????????', '3', '3');
INSERT INTO `course` VALUES ('1024', '????????????', '2', '2');
INSERT INTO `course` VALUES ('1025', '????????????', '2', '2');
INSERT INTO `course` VALUES ('1026', '????????????????????????', '2', '3');

-- ----------------------------
-- Table structure for exams
-- ----------------------------
DROP TABLE IF EXISTS `exams`;
CREATE TABLE `exams` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `examId` bigint(20) NOT NULL,
  `startTime` varchar(255) DEFAULT NULL,
  `roomId` bigint(20) DEFAULT NULL,
  `teacherIds` varchar(255) DEFAULT NULL,
  `endTime` varchar(255) DEFAULT NULL,
  `classId` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`,`examId`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of exams
-- ----------------------------
INSERT INTO `exams` VALUES ('1', '1', '1526256000000', '7', '10,6', '1526261400000', '1');
INSERT INTO `exams` VALUES ('2', '18', '1526256000000', '10', '18,1', '1526261400000', '2');
INSERT INTO `exams` VALUES ('3', '16', '1526263200000', '11', '12,5', '1526268600000', '3');
INSERT INTO `exams` VALUES ('4', '13', '1526277600000', '10', '14,15', '1526283000000', '1');
INSERT INTO `exams` VALUES ('5', '14', '1526277600000', '2', '13,2', '1526283000000', '2');
INSERT INTO `exams` VALUES ('6', '28', '1526284800000', '12', '4,11', '1526290200000', '4');
INSERT INTO `exams` VALUES ('7', '17', '1526342400000', '3', '9,3', '1526347800000', '2');
INSERT INTO `exams` VALUES ('8', '26', '1526342400000', '8', '15,9', '1526347800000', '4');
INSERT INTO `exams` VALUES ('9', '23', '1526349600000', '16', '14,13', '1526355000000', '3');
INSERT INTO `exams` VALUES ('10', '29', '1526349600000', '6', '2,12', '1526355000000', '4');
INSERT INTO `exams` VALUES ('11', '24', '1526364000000', '13', '4,5', '1526369400000', '3');
INSERT INTO `exams` VALUES ('12', '30', '1526364000000', '17', '3,11', '1526369400000', '4');
INSERT INTO `exams` VALUES ('13', '15', '1526371200000', '13', '10,6', '1526376600000', '3');
INSERT INTO `exams` VALUES ('14', '25', '1526371200000', '15', '18,1', '1526376600000', '4');
INSERT INTO `exams` VALUES ('15', '21', '1526428800000', '2', '1,10', '1526434200000', '3');
INSERT INTO `exams` VALUES ('16', '27', '1526428800000', '7', '6,15', '1526434200000', '4');
INSERT INTO `exams` VALUES ('17', '12', '1526436000000', '13', '5,2', '1526441400000', '1');
INSERT INTO `exams` VALUES ('18', '20', '1526436000000', '12', '13,12', '1526441400000', '2');
INSERT INTO `exams` VALUES ('19', '3', '1526450400000', '11', '3,18', '1526455800000', '1');
INSERT INTO `exams` VALUES ('20', '19', '1526450400000', '7', '11,14', '1526455800000', '2');
INSERT INTO `exams` VALUES ('21', '31', '1526457600000', '8', '4,9', '1526463000000', '4');
INSERT INTO `exams` VALUES ('22', '22', '1526515200000', '10', '11,13', '1526520600000', '3');
INSERT INTO `exams` VALUES ('23', '10', '1526522400000', '2', '2,12', '1526527800000', '1');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `studentId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `collegeId` int(20) unsigned DEFAULT NULL,
  `classId` int(10) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `sex` int(2) unsigned DEFAULT '1',
  `birthday` timestamp NULL DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '123456',
  `idCardNo` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`studentId`),
  KEY `student_ibfk_1` (`classId`),
  KEY `collegeId` (`collegeId`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`classId`) REFERENCES `class` (`classId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20141030112 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('20141030101', '1', '1', '??????', '1', '1995-07-18 18:36:26', null, '123456', '');
INSERT INTO `student` VALUES ('20141030102', '1', '1', '??????', '2', '1995-07-13 00:00:00', null, '123456', '');
INSERT INTO `student` VALUES ('20141030103', '1', '1', '??????', '2', '1995-06-23 00:00:00', null, '123456', '');
INSERT INTO `student` VALUES ('20141030104', '2', '3', '?????????', '2', '1996-07-12 18:40:34', null, '123456', '');
INSERT INTO `student` VALUES ('20141030105', '1', '2', '?????????', '1', '1995-06-16 00:00:00', null, '123456', '');
INSERT INTO `student` VALUES ('20141030108', '2', '3', '??????', '2', null, null, '123456', '');
INSERT INTO `student` VALUES ('20141030110', '3', '5', '?????????', '1', null, '0', '123456', '353451');
INSERT INTO `student` VALUES ('20141030111', '3', '5', '?????????', '1', null, '0', '123456', '2421514513');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `collegeId` int(20) unsigned NOT NULL,
  `teacherId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `joindate` timestamp NULL DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  `sex` int(2) unsigned DEFAULT '1',
  `birthday` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '123456',
  `idCardNo` varchar(255) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`teacherId`),
  KEY `collegeId` (`collegeId`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`collegeId`) REFERENCES `college` (`collegeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '1', '??????', '2000-06-28 00:00:00', '12312345698', '2', '1978-04-07 00:00:00', '123456', '123456788');
INSERT INTO `teacher` VALUES ('1', '2', '??????', '2010-07-21 00:00:00', '12345698745', '1', '1975-06-24 00:00:00', '123456', '123456787');
INSERT INTO `teacher` VALUES ('1', '3', '??????', '2004-01-13 00:00:00', '12352647856', '2', '1973-04-15 00:00:00', '123456', '123456786');
INSERT INTO `teacher` VALUES ('2', '4', '??????', '2009-10-10 00:00:00', '12354785236', '2', '1980-10-15 00:00:00', '123456', '123456789');
INSERT INTO `teacher` VALUES ('2', '5', '??????', '2001-07-11 00:00:00', '12345695648', '2', '1980-07-23 00:00:00', '123456', '123456785');
INSERT INTO `teacher` VALUES ('3', '6', '??????', '2005-04-15 00:00:00', '14526325879', '1', '1985-05-01 00:00:00', '123456', '123456789');
INSERT INTO `teacher` VALUES ('1', '9', '?????????', null, '23423523535', '2', null, '123456', '3306237461973423');
INSERT INTO `teacher` VALUES ('3', '10', '?????????', null, '737567563', '1', null, '123456', '25432155145');
INSERT INTO `teacher` VALUES ('3', '11', '?????????', null, '45214553', '1', null, '123456', '324215154');
INSERT INTO `teacher` VALUES ('3', '12', '????????????', '2018-02-22 15:39:48', '4362', '1', '1989-11-16 15:39:57', '123456', '54622562');
INSERT INTO `teacher` VALUES ('3', '13', '?????????', null, '234234', '2', null, '123456', '2345252');
INSERT INTO `teacher` VALUES ('2', '14', '?????????', null, '13246548456', '2', null, '123456', '345687413214545');
INSERT INTO `teacher` VALUES ('2', '15', '?????????', null, '213412434', '1', null, '123456', '123123412354123');
INSERT INTO `teacher` VALUES ('1', '18', '????????????', '2017-06-07 00:00:00', '134112342341', '1', '1989-11-17 00:00:00', '123456', '2341234123414');
