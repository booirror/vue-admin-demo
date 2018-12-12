/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : tpapi3

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-12-10 13:28:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tp_admin
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin`;
CREATE TABLE `tp_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `userName` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `realName` varchar(50) NOT NULL COMMENT '姓名',
  `phone` char(15) NOT NULL COMMENT '用户手机',
  `img` varchar(255) DEFAULT NULL,
  `regTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `regIp` varchar(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `loginTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `loginIp` varchar(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `isEnabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户状态  0 禁用，1正常',
  `groupId` mediumint(8) NOT NULL DEFAULT '0' COMMENT '权限组',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`userName`) USING BTREE,
  KEY `status` (`isEnabled`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='管理员用户表';

-- ----------------------------
-- Records of tp_admin
-- ----------------------------
INSERT INTO `tp_admin` VALUES ('1', 'admin', '227af9354aef4e7d4050b1043d5be6b7', '123@163.com', '123', '15237156573', 'http://api.hardphp.com/uploads/images/20181210/60b35d8a51a99cb0ced7ffefbd557ffc.png', '1498276451', '127.0.0.1', '1544418999', '39.149.12.184', '1544419461', '1', '1');
INSERT INTO `tp_admin` VALUES ('2', 'admina', '227af9354aef4e7d4050b1043d5be6b7', '123@163.com', '王五一', '15237156573', 'http://api.hardphp.com/uploads/images/20181031/042adb39755351c39233681bee2b9ad9.jpg', '1498276451', '127.0.0.1', '1521449129', '123.149.208.76', '1540975213', '1', '1');
INSERT INTO `tp_admin` VALUES ('60', 'test', '', '', '', '', 'http://api.hardphp.com/uploads/images/20181210/065d268d935b6e4823129b0d6bb2e119.jpg', '1542787693', '127.0.0.1', '0', '0', '1544419554', '1', '2');

-- ----------------------------
-- Table structure for tp_app
-- ----------------------------
DROP TABLE IF EXISTS `tp_app`;
CREATE TABLE `tp_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `appId` char(18) NOT NULL COMMENT '应用id',
  `appSecret` char(32) NOT NULL COMMENT '应用密钥',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `phone` char(15) NOT NULL COMMENT '用户手机',
  `img` varchar(255) DEFAULT NULL,
  `regTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `regIp` varchar(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `loginTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `loginIp` varchar(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `isEnabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户状态  0 禁用，1正常',
  `groupId` mediumint(8) NOT NULL DEFAULT '0' COMMENT '权限组',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='app应用表';

-- ----------------------------
-- Records of tp_app
-- ----------------------------
INSERT INTO `tp_app` VALUES ('1', 'ty9fd2848a039ab554', 'ec32286d0718118861afdbf6e401ee81', '', '', '/uploads/image/20170714/logo.jpg', '1498276451', '127.0.0.1', '1521305444', '123.149.208.76', '1514962598', '1', '1');

-- ----------------------------
-- Table structure for tp_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `tp_auth_group`;
CREATE TABLE `tp_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '为1正常，为0禁用',
  `rules` text NOT NULL COMMENT '用户组拥有的规则id， 多个规则","隔开',
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of tp_auth_group
-- ----------------------------
INSERT INTO `tp_auth_group` VALUES ('1', '超级管理员', '1', '1,38,7,2', '1542786894');
INSERT INTO `tp_auth_group` VALUES ('2', '普通管理员', '1', '1,2', '1542787522');

-- ----------------------------
-- Table structure for tp_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `tp_auth_rule`;
CREATE TABLE `tp_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '为1正常，为0禁用',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 正常，0=禁用',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证',
  `pid` mediumint(8) NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `sorts` mediumint(8) NOT NULL DEFAULT '0' COMMENT '升序',
  `icon` varchar(50) NOT NULL,
  `updateTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `path` varchar(255) NOT NULL COMMENT '路经',
  `component` varchar(255) NOT NULL COMMENT '组件',
  `hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '左侧菜单 0==显示,1隐藏',
  `noCache` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=不缓存，0=缓存',
  `alwaysShow` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1= 总显示,0=否 依据子菜单个数',
  `redirect` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of tp_auth_rule
-- ----------------------------
INSERT INTO `tp_auth_rule` VALUES ('1', 'manage', '权限管理', '1', '1', '', '0', '0', 'component', '1542602916', '/manage', 'layout/Layout', '0', '0', '1', '');
INSERT INTO `tp_auth_rule` VALUES ('2', 'manage/admin', '管理员列表', '1', '1', '', '1', '0', 'user', '1541666364', 'admin', 'manage/admin', '0', '0', '0', '');
INSERT INTO `tp_auth_rule` VALUES ('7', 'manage/rules', '权限列表', '1', '1', '', '1', '0', 'lock', '1542353476', 'rules', 'manage/rules', '0', '0', '0', '');
INSERT INTO `tp_auth_rule` VALUES ('38', 'manage/roles', '角色列表', '1', '1', '', '1', '0', 'list', '1542602805', 'roles', 'manage/roles', '0', '1', '1', '');

-- ----------------------------
-- Table structure for tp_login_log
-- ----------------------------
DROP TABLE IF EXISTS `tp_login_log`;
CREATE TABLE `tp_login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `userName` char(16) NOT NULL COMMENT '用户名',
  `loginIp` varchar(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `loginTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `roles` varchar(50) NOT NULL DEFAULT '0' COMMENT '角色',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=495 DEFAULT CHARSET=utf8 COMMENT='管理员登录';

-- ----------------------------
-- Records of tp_login_log
-- ----------------------------
INSERT INTO `tp_login_log` VALUES ('493', '1', 'admin', '115.60.16.69', '1544418872', '超级管理员');
INSERT INTO `tp_login_log` VALUES ('494', '1', 'admin', '115.60.16.69', '1544418999', '超级管理员');
