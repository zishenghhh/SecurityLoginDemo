/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50521
Source Host           : 127.0.0.1:3306
Source Database       : securitylogindemo

Target Server Type    : MYSQL
Target Server Version : 50521
File Encoding         : 65001

Date: 2018-05-10 11:17:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for system_oper
-- ----------------------------
DROP TABLE IF EXISTS `system_oper`;
CREATE TABLE `system_oper` (
  `oper_id` int(11) NOT NULL AUTO_INCREMENT,
  `oper_name` varchar(20) DEFAULT NULL,
  `oper_password` varchar(40) DEFAULT NULL,
  `oper_nikename` varchar(20) DEFAULT NULL,
  `oper_city` varchar(20) DEFAULT NULL,
  `oper_status` varchar(20) DEFAULT NULL COMMENT '0：正常  1：禁用：  2：删除',
  `last_login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后登陆时间',
  `remark` varchar(500) DEFAULT NULL,
  `history_password` varchar(80) DEFAULT NULL COMMENT '历史密码，以逗号隔开，仅保留最近的两次历史使用密码，排在前面时间大',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_oper
-- ----------------------------
INSERT INTO `system_oper` VALUES ('88', 'admin', '21232f297a57a5a743894a0e4a801fc3', '路通', null, '0', '2018-05-10 11:15:50', '', '128a2f804d36cfc37a8aec1b67ccaee0,21232f297a57a5a743894a0e4a801fc3');
