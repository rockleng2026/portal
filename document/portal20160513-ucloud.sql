/*
 Navicat Premium Data Transfer

 Source Server         : 113.31.111.39-ucloud
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : 113.31.111.39:3306
 Source Schema         : portal20160513

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 22/10/2026 14:39:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for addserver
-- ----------------------------
DROP TABLE IF EXISTS `addserver`;
CREATE TABLE `addserver`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleOrderID` int(11) NULL DEFAULT NULL,
  `pro_Server_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addProid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `Time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `employee` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `AddServer_fk`(`saleOrderID`) USING BTREE,
  CONSTRAINT `AddServer_fk` FOREIGN KEY (`saleOrderID`) REFERENCES `saleorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of addserver
-- ----------------------------

-- ----------------------------
-- Table structure for alltype
-- ----------------------------
DROP TABLE IF EXISTS `alltype`;
CREATE TABLE `alltype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of alltype
-- ----------------------------
INSERT INTO `alltype` VALUES (1, 0, '上架出库');
INSERT INTO `alltype` VALUES (2, 0, '销售出库');
INSERT INTO `alltype` VALUES (3, 0, '报损出库');
INSERT INTO `alltype` VALUES (4, 0, '盘亏出库');
INSERT INTO `alltype` VALUES (5, 0, '借出出库');
INSERT INTO `alltype` VALUES (6, 1, '客户商品入库');
INSERT INTO `alltype` VALUES (7, 1, '报益入库');
INSERT INTO `alltype` VALUES (8, 1, '其他入库');
INSERT INTO `alltype` VALUES (9, 1, '新购入库');
INSERT INTO `alltype` VALUES (10, 1, '返还入库');
INSERT INTO `alltype` VALUES (11, 2, '服务器租用');
INSERT INTO `alltype` VALUES (12, 2, '服务器托管');
INSERT INTO `alltype` VALUES (13, 2, 'VPS主机');
INSERT INTO `alltype` VALUES (14, 2, '虚拟空间');
INSERT INTO `alltype` VALUES (15, 3, '月付');
INSERT INTO `alltype` VALUES (16, 3, '季付');
INSERT INTO `alltype` VALUES (17, 3, '半年付');
INSERT INTO `alltype` VALUES (18, 3, '年付');
INSERT INTO `alltype` VALUES (19, 4, '正常使用');
INSERT INTO `alltype` VALUES (20, 4, '等待续费');
INSERT INTO `alltype` VALUES (21, 4, '欠费停机');
INSERT INTO `alltype` VALUES (22, 5, '损坏下架');
INSERT INTO `alltype` VALUES (23, 5, '更换配置下架');
INSERT INTO `alltype` VALUES (24, 2, '代理专区');
INSERT INTO `alltype` VALUES (25, 2, '自由主机');
INSERT INTO `alltype` VALUES (26, 5, '客户下架');

-- ----------------------------
-- Table structure for applybuy
-- ----------------------------
DROP TABLE IF EXISTS `applybuy`;
CREATE TABLE `applybuy`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `employeeId` int(11) NULL DEFAULT NULL,
  `approve` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `applyBuy` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `approveEmp` int(11) NULL DEFAULT NULL,
  `approveTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `applyBuy_fk`(`approveEmp`) USING BTREE,
  INDEX `applyBuy_fk3`(`employeeId`) USING BTREE,
  CONSTRAINT `applyBuy_fk3` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `applybuy_ibfk_1` FOREIGN KEY (`approveEmp`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of applybuy
-- ----------------------------

-- ----------------------------
-- Table structure for applybuyinfo
-- ----------------------------
DROP TABLE IF EXISTS `applybuyinfo`;
CREATE TABLE `applybuyinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pplyBuyNo` int(11) NOT NULL,
  `typeId` int(11) NULL DEFAULT NULL,
  `Model` int(11) NULL DEFAULT NULL,
  `Count` int(11) NULL DEFAULT NULL,
  `del` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `applyBuyinfo_fk`(`pplyBuyNo`) USING BTREE,
  INDEX `applyBuyinfo_fk2`(`typeId`) USING BTREE,
  INDEX `applyBuyinfo_fk3`(`Model`) USING BTREE,
  CONSTRAINT `applyBuyinfo_fk2` FOREIGN KEY (`typeId`) REFERENCES `commoditytpye` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `applyBuyinfo_fk3` FOREIGN KEY (`Model`) REFERENCES `model` (`model`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `applybuyinfo_ibfk_1` FOREIGN KEY (`pplyBuyNo`) REFERENCES `applybuy` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of applybuyinfo
-- ----------------------------

-- ----------------------------
-- Table structure for approverecord
-- ----------------------------
DROP TABLE IF EXISTS `approverecord`;
CREATE TABLE `approverecord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `approveemp` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批人',
  `applypeople` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `apptime` date NULL DEFAULT NULL COMMENT '审批时间',
  `approveinfo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '审批意见',
  `ispass` int(11) NULL DEFAULT NULL COMMENT '是否通过(0拒绝，１通过)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of approverecord
-- ----------------------------

-- ----------------------------
-- Table structure for assemblyserver
-- ----------------------------
DROP TABLE IF EXISTS `assemblyserver`;
CREATE TABLE `assemblyserver`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpuId` int(11) NULL DEFAULT NULL,
  `mainBoardId` int(11) NULL DEFAULT NULL,
  `memoryId` int(11) NULL DEFAULT NULL,
  `powerId` int(11) NULL DEFAULT NULL,
  `networkCardId` int(11) NULL DEFAULT NULL,
  `hdId` int(11) NULL DEFAULT NULL,
  `crateId` int(11) NULL DEFAULT NULL,
  `depotId` int(11) NULL DEFAULT NULL,
  `modelId` int(11) NULL DEFAULT NULL,
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` int(11) NULL DEFAULT NULL,
  `empId` int(11) NULL DEFAULT NULL,
  `assemblyNo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `atime` datetime NULL DEFAULT NULL,
  `serverId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_assemblyServer_cpu`(`cpuId`) USING BTREE,
  INDEX `FK_assemblyServer_crate`(`crateId`) USING BTREE,
  INDEX `FK_assemblyServer_depot`(`depotId`) USING BTREE,
  INDEX `FK_assemblyServer_employee`(`empId`) USING BTREE,
  INDEX `FK_assemblyServer_HD`(`hdId`) USING BTREE,
  INDEX `FK_assemblyServer_mainBoard`(`mainBoardId`) USING BTREE,
  INDEX `FK_assemblyServer_memory`(`memoryId`) USING BTREE,
  INDEX `FK_assemblyServer_model`(`modelId`) USING BTREE,
  INDEX `FK_assemblyServer_networkCardId`(`networkCardId`) USING BTREE,
  INDEX `FK_assemblyServer_power`(`powerId`) USING BTREE,
  INDEX `FK_assemblyServer_server`(`serverId`) USING BTREE,
  CONSTRAINT `FK_assemblyServer_HD` FOREIGN KEY (`hdId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_cpu` FOREIGN KEY (`cpuId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_crate` FOREIGN KEY (`crateId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_depot` FOREIGN KEY (`depotId`) REFERENCES `depot` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_employee` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_mainBoard` FOREIGN KEY (`mainBoardId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_memory` FOREIGN KEY (`memoryId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_model` FOREIGN KEY (`modelId`) REFERENCES `model` (`model`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_networkCardId` FOREIGN KEY (`networkCardId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_power` FOREIGN KEY (`powerId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_assemblyServer_server` FOREIGN KEY (`serverId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of assemblyserver
-- ----------------------------

-- ----------------------------
-- Table structure for auditingordertab
-- ----------------------------
DROP TABLE IF EXISTS `auditingordertab`;
CREATE TABLE `auditingordertab`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '审核顺序表',
  `departId` int(11) NULL DEFAULT NULL COMMENT '部门ID',
  `orderNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单号',
  `empId` int(11) NULL DEFAULT NULL COMMENT '员工ID',
  `auditingtime` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `auditingFlag` int(11) NULL DEFAULT NULL COMMENT '审核标识',
  `auditingOrder` int(11) NULL DEFAULT NULL COMMENT '审核顺序',
  `entityId` int(11) NULL DEFAULT NULL COMMENT '实体引用id，为了确认是什么类型的.verifyorder表ID',
  `handlestate` int(11) NULL DEFAULT NULL COMMENT '处理状态 （0：未审  1：审核中 2 ：已审）',
  `employees` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工集合',
  `tmp` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '是否通过',
  `inceptemp` int(11) NULL DEFAULT NULL COMMENT '接收人',
  `incepttime` datetime NULL DEFAULT NULL COMMENT '接收时间',
  `sbh` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '识别号',
  `mark` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标识 1：该员工审核后跟他同时审核的人无需审核，2该员工审核后跟该员工同时审核的员工也必须审核猜通过',
  `grade` double(5, 0) NULL DEFAULT NULL,
  `rvid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empOrdept` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `deldate` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_auditingOrderTab_department`(`departId`) USING BTREE,
  INDEX `FK_auditingOrderTab_employee`(`empId`) USING BTREE,
  INDEX `inceptemp`(`inceptemp`) USING BTREE,
  INDEX `FK_entity_id`(`entityId`) USING BTREE,
  CONSTRAINT `FK_auditingOrderTab_employee` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_entity_id` FOREIGN KEY (`entityId`) REFERENCES `verifyorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auditingordertab_ibfk_1` FOREIGN KEY (`inceptemp`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 8192 kB; (`inceptemp`) REFER `fajxc/employee`(`' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of auditingordertab
-- ----------------------------

-- ----------------------------
-- Table structure for auditline
-- ----------------------------
DROP TABLE IF EXISTS `auditline`;
CREATE TABLE `auditline`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `foreignId` int(11) NULL DEFAULT NULL COMMENT '外键部门或员工id',
  `Januarymoney` double NULL DEFAULT NULL COMMENT '1月',
  `Februarymoney` double NULL DEFAULT NULL COMMENT '2月',
  `marchmoney` double NULL DEFAULT NULL COMMENT '3月',
  `Aprilmoney` double NULL DEFAULT NULL COMMENT '4月',
  `Maymoney` double NULL DEFAULT NULL COMMENT '5月',
  `Junemoney` double NULL DEFAULT NULL COMMENT '六月',
  `Julymoney` double NULL DEFAULT NULL COMMENT '七月',
  `Augustmoney` double NULL DEFAULT NULL COMMENT '八月',
  `Septembermoney` double NULL DEFAULT NULL COMMENT '九月',
  `Octobermoney` double NULL DEFAULT NULL COMMENT '十月',
  `Novembermoney` double NULL DEFAULT NULL COMMENT '十一月',
  `Decembermoney` double NULL DEFAULT NULL COMMENT '十二月',
  `Firstquarter` double NULL DEFAULT NULL COMMENT '第一季度',
  `Twoquarter` double NULL DEFAULT NULL COMMENT '第二季度',
  `Threequarter` double NULL DEFAULT NULL COMMENT '第三季度',
  `Fourquarter` double NULL DEFAULT NULL COMMENT '第四季度',
  `Halfyear1` double NULL DEFAULT NULL COMMENT '上半年',
  `Halfyear2` double NULL DEFAULT NULL COMMENT '下半年',
  `Yearmoney` double NULL DEFAULT NULL COMMENT '全年',
  `temp` int(11) NULL DEFAULT NULL COMMENT '标识部门还是员工业务',
  `isflag` int(11) NULL DEFAULT NULL COMMENT '标识是否部门转入业务',
  `creatTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of auditline
-- ----------------------------
INSERT INTO `auditline` VALUES (1, 36, 20000, 20000, 20000, 20000, 20000, 20000, 20000, 20000, 20000, 20000, 20000, 20000, 60000, 60000, 60000, 60000, 120000, 120000, 240000, 2, 0, '2013-05-20 ');
INSERT INTO `auditline` VALUES (2, 37, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 3000, 3000, 3000, 3000, 6000, 6000, 12000, 2, 0, '2013-05-20 ');

-- ----------------------------
-- Table structure for batch
-- ----------------------------
DROP TABLE IF EXISTS `batch`;
CREATE TABLE `batch`  (
  `batchId` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` float NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `delflag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`batchId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of batch
-- ----------------------------

-- ----------------------------
-- Table structure for batchexp
-- ----------------------------
DROP TABLE IF EXISTS `batchexp`;
CREATE TABLE `batchexp`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `toOrderId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `modelId` int(11) NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `Count` int(11) NULL DEFAULT NULL,
  `purcount` int(11) NULL DEFAULT NULL,
  `discount` float NULL DEFAULT NULL,
  `sum` float NULL DEFAULT NULL,
  `remark` int(11) NULL DEFAULT NULL,
  `allTypeId` int(11) NOT NULL,
  `audit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `batchexp_allTypeId`(`allTypeId`) USING BTREE,
  INDEX `batchexp_toOrderId`(`toOrderId`) USING BTREE,
  INDEX `batchexp_typeId`(`typeId`) USING BTREE,
  INDEX `FK_batchexp_model`(`modelId`) USING BTREE,
  CONSTRAINT `FK_batchexp_model` FOREIGN KEY (`modelId`) REFERENCES `model` (`model`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `batchexp_allTypeId` FOREIGN KEY (`allTypeId`) REFERENCES `alltype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `batchexp_toOrderId` FOREIGN KEY (`toOrderId`) REFERENCES `toorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `batchexp_typeId` FOREIGN KEY (`typeId`) REFERENCES `commoditytpye` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of batchexp
-- ----------------------------

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderdataid` int(11) NULL DEFAULT NULL COMMENT '订单类型数据表id外键',
  `typeid` int(11) NULL DEFAULT NULL COMMENT '模板id外键',
  `typename` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名',
  `cacheflag` int(11) NULL DEFAULT 0 COMMENT '0缓存    1不缓存',
  `cachecontent` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缓存内容',
  `contentime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缓存时间',
  `timeunit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缓存时间单位',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cache_orderdata`(`orderdataid`) USING BTREE,
  INDEX `cache_type`(`typeid`) USING BTREE,
  CONSTRAINT `cache_orderdata` FOREIGN KEY (`orderdataid`) REFERENCES `cdnsaleorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cache_type` FOREIGN KEY (`typeid`) REFERENCES `type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_area_dis
-- ----------------------------
DROP TABLE IF EXISTS `cdn_area_dis`;
CREATE TABLE `cdn_area_dis`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '域名',
  `rqtime` int(11) NULL DEFAULT NULL COMMENT '时间戳',
  `arear` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源　如山东SD　未识别用OT',
  `no` int(11) NULL DEFAULT NULL COMMENT '量数',
  `flow` int(11) NULL DEFAULT NULL COMMENT '流量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_area_dis
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_dir_refresh
-- ----------------------------
DROP TABLE IF EXISTS `cdn_dir_refresh`;
CREATE TABLE `cdn_dir_refresh`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` int(10) NOT NULL,
  `url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `datetime` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  CONSTRAINT `cdn_dir_refresh_ibfk_1` FOREIGN KEY (`username`) REFERENCES `cdn_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_dir_refresh
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_domain
-- ----------------------------
DROP TABLE IF EXISTS `cdn_domain`;
CREATE TABLE `cdn_domain`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userid`(`userid`) USING BTREE,
  CONSTRAINT `cdn_domain_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `cdn_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_domain
-- ----------------------------
INSERT INTO `cdn_domain` VALUES (1, 'www.youku.com', 1);
INSERT INTO `cdn_domain` VALUES (2, 'www.baidu.com', 1);

-- ----------------------------
-- Table structure for cdn_flow
-- ----------------------------
DROP TABLE IF EXISTS `cdn_flow`;
CREATE TABLE `cdn_flow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `traffic` int(11) NULL DEFAULT NULL,
  `userId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `cdn_flow_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `cdn_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_flow
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_flow_dis
-- ----------------------------
DROP TABLE IF EXISTS `cdn_flow_dis`;
CREATE TABLE `cdn_flow_dis`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '域名',
  `rqtime` int(11) NULL DEFAULT NULL COMMENT '时间戳',
  `source` int(11) NULL DEFAULT NULL COMMENT '请求回源数',
  `cache` int(11) NULL DEFAULT NULL COMMENT '请求CACHE数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_flow_dis
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_isp_dis
-- ----------------------------
DROP TABLE IF EXISTS `cdn_isp_dis`;
CREATE TABLE `cdn_isp_dis`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '域名',
  `rqtime` int(11) NULL DEFAULT NULL COMMENT '时间戳',
  `telecom` int(11) NULL DEFAULT NULL COMMENT '联通',
  `unicom` int(11) NULL DEFAULT NULL COMMENT '电信',
  `chinamobile` int(11) NULL DEFAULT NULL COMMENT '移动',
  `chinatietong` int(11) NULL DEFAULT NULL COMMENT '铁通',
  `edu` int(11) NULL DEFAULT NULL COMMENT '教育网',
  `other` int(11) NULL DEFAULT NULL COMMENT '其他',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_isp_dis
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_log_node
-- ----------------------------
DROP TABLE IF EXISTS `cdn_log_node`;
CREATE TABLE `cdn_log_node`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `btime` int(11) NULL DEFAULT NULL COMMENT '取截开始时间',
  `etime` int(11) NULL DEFAULT NULL COMMENT '截取日志结束时间',
  `a` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Client source IP address(%>a)',
  `a2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Client FQDN(%>A)',
  `p` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Client source port(%>p)',
  `a3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Server IP address or peer name(%<A)',
  `la` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Local IP address where the request was accepted(%la)',
  `lp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Local port where the request was accepted(%lp)',
  `la2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Local port name where the request was accepted(%lA)',
  `ts` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Date of request, seconds since epoch(%ts)',
  `tl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Date of request, strftime format (localtime)(%{format}tl)',
  `tg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Date of request, strftime format (gmt)(%{formate}tg)',
  `tu` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Date of request, sub-second component(%tu)',
  `tr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Time to serve the request, in milliseconds(%tr)',
  `h` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request header(%{header}>h)',
  `h2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Named request header field element (list headers)(%{header:element}>h)',
  `h3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Named request header field element, using \"separator\" as field separator (it can be any non-alphanumeric single character)(%{header:separator element}>h)',
  `h4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'All request header(%>h)',
  `h5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request headers, as for <..h above(%{header}<h)',
  `un` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Authenticated user name or dash(%un)',
  `ur` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Authenticated user realm or dash(%ur)',
  `us` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Authenticated user scheme or dash(%us)',
  `ui` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Ident user name(%ui)',
  `hs` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'HTTP status code (200, 404, 407, etc)(%Hs)',
  `ht` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'HTTP status text (Not found, etc)(%Ht)',
  `ss` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Squid status code (TCP_HIT, TCP_MISS etc))(%Ss)',
  `se` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Squid error code (ERR_DENIED, ERR_...)(%Ss)',
  `sh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Squid hierarchy code (FIRST_UP_PARENT, etc)(%sh)',
  `mt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'MIME type of the request(%mt)',
  `rm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request method(%rm)',
  `ru` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request URL, without the query string(%ru)',
  `rq` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request query string, including ?(%rq)',
  `rp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request protocol (i.e. HTTP/1.1)(%rp)',
  `ps` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Peer selection status (DIRECT, PARENT, CD_PARENT_HIT, etc. including the TIMEDOUT_ variant)(%ps)',
  `sl` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request line(%>sl)',
  `sh2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request headers, including request line(%>sh)',
  `sh3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request headers, excluding request line(%>sH)',
  `sb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request body, raw received bytes(%>sb)',
  `sb2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request body, excluding transfer encoding(%>sB)',
  `st` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Total size of request(%>st)',
  `sl2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply status line(%<sl)',
  `sh4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply headers, including status line(%<sh)',
  `sh5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply headers, excluding status line',
  `sb3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply body, raw transmitted bytes(%<sb)',
  `sb4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply body, excluding transfer encoding(%<sB)',
  `st2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Total size of reply(%<st)',
  `rv` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '%rv referer verion',
  `h_referer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头部信息中referer的值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_log_node
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_log_node2
-- ----------------------------
DROP TABLE IF EXISTS `cdn_log_node2`;
CREATE TABLE `cdn_log_node2`  (
  ` id` int(11) NOT NULL AUTO_INCREMENT,
  `btime` int(11) NULL DEFAULT NULL COMMENT '取截开始时间',
  `etime` int(11) NULL DEFAULT NULL COMMENT '截取日志结束时间',
  `a` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Client source IP address(%>a)',
  `a2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Client FQDN(%>A)',
  `p` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Client source port(%>p)',
  `a3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Server IP address or peer name(%<A)',
  `la` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Local IP address where the request was accepted(%la)',
  `lp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Local port where the request was accepted(%lp)',
  `la2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Local port name where the request was accepted(%lA)',
  `ts` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Date of request, seconds since epoch(%ts)',
  `tl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Date of request, strftime format (localtime)(%{format}tl)',
  `tg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Date of request, strftime format (gmt)(%{formate}tg)',
  `tu` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Date of request, sub-second component(%tu)',
  `tr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Time to serve the request, in milliseconds(%tr)',
  `h` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request header(%{header}>h)',
  `h2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Named request header field element (list headers)(%{header:element}>h)',
  `h3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Named request header field element, using \"separator\" as field separator (it can be any non-alphanumeric single character)(%{header:separator element}>h)',
  `h4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'All request header(%>h)',
  `h5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request headers, as for <..h above(%{header}<h)',
  `un` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Authenticated user name or dash(%un)',
  `ur` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Authenticated user realm or dash(%ur)',
  `us` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Authenticated user scheme or dash(%us)',
  `ui` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Ident user name(%ui)',
  `hs` int(11) NULL DEFAULT NULL COMMENT 'HTTP status code (200, 404, 407, etc)(%Hs)',
  `ht` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'HTTP status text (Not found, etc)(%Ht)',
  `ss` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Squid status code (TCP_HIT, TCP_MISS etc))(%Ss)',
  `se` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Squid error code (ERR_DENIED, ERR_...)(%Ss)',
  `sh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Squid hierarchy code (FIRST_UP_PARENT, etc)(%sh)',
  `mt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'MIME type of the request(%mt)',
  `rm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request method(%rm)',
  `ru` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request URL, without the query string(%ru)',
  `rq` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request query string, including ?(%rq)',
  `rp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Request protocol (i.e. HTTP/1.1)(%rp)',
  `ps` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Peer selection status (DIRECT, PARENT, CD_PARENT_HIT, etc. including the TIMEDOUT_ variant)(%ps)',
  `sl` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request line(%>sl)',
  `sh2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request headers, including request line(%>sh)',
  `sh3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request headers, excluding request line(%>sH)',
  `sb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request body, raw received bytes(%>sb)',
  `sb2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of request body, excluding transfer encoding(%>sB)',
  `st` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Total size of request(%>st)',
  `sl2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply status line(%<sl)',
  `sh4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply headers, including status line(%<sh)',
  `sh5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply headers, excluding status line',
  `sb3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply body, raw transmitted bytes(%<sb)',
  `sb4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Size of reply body, excluding transfer encoding(%<sB)',
  `st2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Total size of reply(%<st)',
  PRIMARY KEY (` id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_log_node2
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_log_server
-- ----------------------------
DROP TABLE IF EXISTS `cdn_log_server`;
CREATE TABLE `cdn_log_server`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '服务器端流量统计表',
  `nodestr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CDN节点标识-改为映射节点表id',
  `domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被访问域名-改成映射cdn订单表外键',
  `bandwidth` int(11) NULL DEFAULT NULL COMMENT '统计带宽',
  `flow` int(11) NULL DEFAULT NULL COMMENT '统计流量',
  `rqtime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问时间',
  `rqnum` int(11) NULL DEFAULT NULL COMMENT '访问次数(hits数)',
  `ipsstr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '访问的来源IP ; 分割',
  `wtime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '写入时间',
  `temp` int(100) NULL DEFAULT 0,
  `hynum` int(11) NULL DEFAULT 0 COMMENT '回源次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_log_server
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_log_time_stat
-- ----------------------------
DROP TABLE IF EXISTS `cdn_log_time_stat`;
CREATE TABLE `cdn_log_time_stat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '时间统计表',
  `stime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开始时间',
  `etime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束时间',
  `rtime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '取读时间',
  `wtime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '写入时间',
  `ptime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分析时间',
  `nodestr` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CDN节点标识',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_log_time_stat
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_logs
-- ----------------------------
DROP TABLE IF EXISTS `cdn_logs`;
CREATE TABLE `cdn_logs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datetime` int(11) NULL DEFAULT NULL,
  `logfile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_logs
-- ----------------------------

-- ----------------------------
-- Table structure for cdn_referer
-- ----------------------------
DROP TABLE IF EXISTS `cdn_referer`;
CREATE TABLE `cdn_referer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rqtime` int(11) NULL DEFAULT NULL,
  `referer` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `num` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6041 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_referer
-- ----------------------------
INSERT INTO `cdn_referer` VALUES (6040, 'www_litscloud_com', 1366710542, 'http://www_im286_com', 1);

-- ----------------------------
-- Table structure for cdn_url_refresh
-- ----------------------------
DROP TABLE IF EXISTS `cdn_url_refresh`;
CREATE TABLE `cdn_url_refresh`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` int(11) NULL DEFAULT NULL,
  `url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `datetime` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  CONSTRAINT `cdn_url_refresh_ibfk_1` FOREIGN KEY (`username`) REFERENCES `cdn_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_url_refresh
-- ----------------------------
INSERT INTO `cdn_url_refresh` VALUES (1, 1, 'www.baidu.com', '7天', 0);
INSERT INTO `cdn_url_refresh` VALUES (2, 1, 'www.youku.com', '7天', 0);
INSERT INTO `cdn_url_refresh` VALUES (15, 1, 'www.baidu.com', '1000毫秒', 0);
INSERT INTO `cdn_url_refresh` VALUES (16, 1, 'www.baidu1.com', '12小时', 0);
INSERT INTO `cdn_url_refresh` VALUES (17, 1, 'www.xuyuan.com.cn', '7天', 0);
INSERT INTO `cdn_url_refresh` VALUES (18, 1, 'www.xy.net', '12小时', 0);

-- ----------------------------
-- Table structure for cdn_user
-- ----------------------------
DROP TABLE IF EXISTS `cdn_user`;
CREATE TABLE `cdn_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginUserName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apiPassword` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userCompany` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userPost` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` int(11) NULL DEFAULT NULL,
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fax` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `QQ` int(30) NULL DEFAULT NULL,
  `mark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_user
-- ----------------------------
INSERT INTO `cdn_user` VALUES (1, 'xuyuan', '123456', '123456', '重庆福奥', '随便', '随便', 152, '11', '', 0, '');

-- ----------------------------
-- Table structure for cdn_visits
-- ----------------------------
DROP TABLE IF EXISTS `cdn_visits`;
CREATE TABLE `cdn_visits`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rqtime` int(11) NULL DEFAULT NULL,
  `click` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdn_visits
-- ----------------------------

-- ----------------------------
-- Table structure for cdnarea
-- ----------------------------
DROP TABLE IF EXISTS `cdnarea`;
CREATE TABLE `cdnarea`  (
  `id` int(100) NOT NULL AUTO_INCREMENT COMMENT '省份表ID',
  `province` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '省份',
  `mark` int(100) NULL DEFAULT 0 COMMENT '省份标识（0默认，1坏掉，2修改、、、）',
  `del` int(100) NOT NULL DEFAULT 0 COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdnarea
-- ----------------------------
INSERT INTO `cdnarea` VALUES (1, '暂没有地区', 0, 0);
INSERT INTO `cdnarea` VALUES (2, '北京', 0, 0);
INSERT INTO `cdnarea` VALUES (3, '天津', 0, 0);
INSERT INTO `cdnarea` VALUES (4, '上海', 0, 0);
INSERT INTO `cdnarea` VALUES (5, '重庆', 0, 0);
INSERT INTO `cdnarea` VALUES (6, '河北', 0, 0);
INSERT INTO `cdnarea` VALUES (7, '河南', 0, 0);
INSERT INTO `cdnarea` VALUES (8, '云南', 0, 0);
INSERT INTO `cdnarea` VALUES (9, '辽宁', 0, 0);
INSERT INTO `cdnarea` VALUES (10, '黑龙江', 0, 0);
INSERT INTO `cdnarea` VALUES (11, '湖南', 0, 0);
INSERT INTO `cdnarea` VALUES (12, '安徽', 0, 0);
INSERT INTO `cdnarea` VALUES (13, '山东', 0, 0);
INSERT INTO `cdnarea` VALUES (14, '新疆维吾尔', 0, 0);
INSERT INTO `cdnarea` VALUES (15, '江苏', 0, 0);
INSERT INTO `cdnarea` VALUES (16, '浙江', 0, 0);
INSERT INTO `cdnarea` VALUES (17, '江西', 0, 0);
INSERT INTO `cdnarea` VALUES (18, '湖北', 0, 0);
INSERT INTO `cdnarea` VALUES (19, '广西壮族', 0, 0);
INSERT INTO `cdnarea` VALUES (20, '甘肃', 0, 0);
INSERT INTO `cdnarea` VALUES (21, '山西', 0, 0);
INSERT INTO `cdnarea` VALUES (22, '内蒙', 0, 0);
INSERT INTO `cdnarea` VALUES (23, '陕西', 0, 0);
INSERT INTO `cdnarea` VALUES (24, '吉林', 0, 0);
INSERT INTO `cdnarea` VALUES (25, '福建', 0, 0);
INSERT INTO `cdnarea` VALUES (26, '贵州', 0, 0);
INSERT INTO `cdnarea` VALUES (27, '广东', 0, 0);
INSERT INTO `cdnarea` VALUES (28, '青海', 0, 0);
INSERT INTO `cdnarea` VALUES (29, '西藏', 0, 0);
INSERT INTO `cdnarea` VALUES (30, '四川', 0, 0);
INSERT INTO `cdnarea` VALUES (31, '宁夏回族', 0, 0);
INSERT INTO `cdnarea` VALUES (32, '海南', 0, 0);
INSERT INTO `cdnarea` VALUES (33, '香港', 0, 0);
INSERT INTO `cdnarea` VALUES (34, '澳门', 0, 0);

-- ----------------------------
-- Table structure for cdngroup
-- ----------------------------
DROP TABLE IF EXISTS `cdngroup`;
CREATE TABLE `cdngroup`  (
  `id` int(30) NOT NULL AUTO_INCREMENT COMMENT '分组表',
  `groupName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组名',
  `panelPointId` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点表ID(1,2,3,)',
  `mark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del` int(10) NOT NULL DEFAULT 0 COMMENT '删除标识0默认，1使用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdngroup
-- ----------------------------
INSERT INTO `cdngroup` VALUES (1, '优质组', '11,13,', NULL, 0);
INSERT INTO `cdngroup` VALUES (2, '差等组', '21,22', NULL, 0);
INSERT INTO `cdngroup` VALUES (3, '测试组', '15,16,19,', '0', 0);
INSERT INTO `cdngroup` VALUES (6, '测试123', '15,16,18,19,', '0', 0);
INSERT INTO `cdngroup` VALUES (7, '测试22', '16,18,19,', '0', 0);
INSERT INTO `cdngroup` VALUES (8, '测试232', '15,', '0', 0);
INSERT INTO `cdngroup` VALUES (9, '测试数据', '15,16,18,19,', '0', 0);

-- ----------------------------
-- Table structure for cdnip
-- ----------------------------
DROP TABLE IF EXISTS `cdnip`;
CREATE TABLE `cdnip`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderdataid` int(11) NULL DEFAULT NULL COMMENT '订单类型数据表id',
  `IP` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `port` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '端口',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `tmoblie` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '运营商电信或网通',
  `delflag` int(11) NULL DEFAULT 0 COMMENT '删除标记  0正常的   1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cdnip_orderdata`(`orderdataid`) USING BTREE,
  CONSTRAINT `cdnip_orderdata` FOREIGN KEY (`orderdataid`) REFERENCES `cdnsaleorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdnip
-- ----------------------------

-- ----------------------------
-- Table structure for cdnpanelpoint
-- ----------------------------
DROP TABLE IF EXISTS `cdnpanelpoint`;
CREATE TABLE `cdnpanelpoint`  (
  `id` int(100) NOT NULL AUTO_INCREMENT COMMENT '节点表ID',
  `panelPointIp` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP',
  `cdnTypeId` int(100) NULL DEFAULT NULL COMMENT 'cdnTypeID',
  `cdnAreaId` int(100) NULL DEFAULT NULL COMMENT 'cdnAreaID',
  `mark` int(100) NOT NULL DEFAULT 0 COMMENT '标识（0.默认，1损坏，2删除。。。）',
  `del` int(100) NOT NULL DEFAULT 0 COMMENT '删除标识（0默认，1删除）',
  `address` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机房地址',
  `duankou` int(100) NULL DEFAULT 8080 COMMENT '端口',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cdnTypeId`(`cdnTypeId`) USING BTREE,
  INDEX `cdnAreaId`(`cdnAreaId`) USING BTREE,
  CONSTRAINT `cdnPanelPoint_ibfk_1` FOREIGN KEY (`cdnTypeId`) REFERENCES `cdntype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cdnPanelPoint_ibfk_2` FOREIGN KEY (`cdnAreaId`) REFERENCES `cdnarea` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdnpanelpoint
-- ----------------------------
INSERT INTO `cdnpanelpoint` VALUES (10, '58.59.97.37', 18, 1, 0, 0, '珠江省', 8088);
INSERT INTO `cdnpanelpoint` VALUES (11, '183.61.13.171', 18, 27, 0, 0, '珠江省', 8080);
INSERT INTO `cdnpanelpoint` VALUES (12, '58.59.97.37', 1, 1, 2, 1, '不知道', 8080);
INSERT INTO `cdnpanelpoint` VALUES (13, '192.1.1.168', 3, 1, 2, 0, '深圳', 8080);
INSERT INTO `cdnpanelpoint` VALUES (14, '182.3.3.23', 3, 1, 0, 0, ' 我也不知道', 8080);
INSERT INTO `cdnpanelpoint` VALUES (15, '192.1.1.168', 1, 1, 0, 0, '1212', 8080);
INSERT INTO `cdnpanelpoint` VALUES (16, '192.6.3.3', 1, 1, 0, 0, '不知道', 8080);
INSERT INTO `cdnpanelpoint` VALUES (17, '192.1.1.173', 1, 1, 0, 0, '000', 8080);
INSERT INTO `cdnpanelpoint` VALUES (18, '192.3.6.9', 1, 1, 0, 0, '4', 8080);
INSERT INTO `cdnpanelpoint` VALUES (19, '192.1.1.112', 1, 1, 0, 0, '1244', 8080);
INSERT INTO `cdnpanelpoint` VALUES (20, '192.6.3.3', 1, 1, 0, 0, '000', 8080);
INSERT INTO `cdnpanelpoint` VALUES (21, '182.3.23.3', 1, 1, 2, 0, '不知道', 8080);
INSERT INTO `cdnpanelpoint` VALUES (22, '182.1.1.16', 1, 1, 2, 0, '不摘掉', 8080);
INSERT INTO `cdnpanelpoint` VALUES (23, '1.1.1.1', 1, 1, 0, 0, '中国', 8081);
INSERT INTO `cdnpanelpoint` VALUES (24, '1.1.2.2', 1, 1, 0, 0, '中', 8085);

-- ----------------------------
-- Table structure for cdnprice
-- ----------------------------
DROP TABLE IF EXISTS `cdnprice`;
CREATE TABLE `cdnprice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productpropertyid` int(11) NULL DEFAULT NULL COMMENT '产品属性表id',
  `realmtypeid` int(11) NULL DEFAULT NULL COMMENT '域名类型静动态id',
  `flow` float(11, 0) NULL DEFAULT NULL COMMENT '流量计费价格',
  `bandwidth` float(11, 0) NULL DEFAULT NULL COMMENT '带宽计费价格',
  `hitnum` float(11, 0) NULL DEFAULT NULL COMMENT 'Hit连接数计费价格',
  `delflag` int(11) NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cdnprice_product`(`productpropertyid`) USING BTREE,
  INDEX `cdnprice_realmtype`(`realmtypeid`) USING BTREE,
  CONSTRAINT `cdnprice_ibfk_1` FOREIGN KEY (`productpropertyid`) REFERENCES `productproperty` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cdnprice_ibfk_2` FOREIGN KEY (`realmtypeid`) REFERENCES `realmtype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdnprice
-- ----------------------------

-- ----------------------------
-- Table structure for cdnrealmnameip
-- ----------------------------
DROP TABLE IF EXISTS `cdnrealmnameip`;
CREATE TABLE `cdnrealmnameip`  (
  `id` int(100) NOT NULL AUTO_INCREMENT COMMENT '域名对应的IP',
  `cusID` int(100) NOT NULL COMMENT '客户ID',
  `cuRealmName` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户域名',
  `cdnPanelPointID` int(100) NOT NULL COMMENT '节点表ID',
  `mark` int(100) NOT NULL DEFAULT 0 COMMENT '标识(0默认，1损坏,2暂停)',
  `del` int(100) NOT NULL DEFAULT 0 COMMENT '删除标识0默认 1删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cusID`(`cusID`) USING BTREE,
  INDEX `cdnPanelPointID`(`cdnPanelPointID`) USING BTREE,
  CONSTRAINT `cdnRealmNameIP_ibfk_1` FOREIGN KEY (`cusID`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cdnRealmNameIP_ibfk_2` FOREIGN KEY (`cdnPanelPointID`) REFERENCES `cdnpanelpoint` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdnrealmnameip
-- ----------------------------

-- ----------------------------
-- Table structure for cdnsaleorder
-- ----------------------------
DROP TABLE IF EXISTS `cdnsaleorder`;
CREATE TABLE `cdnsaleorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标识符',
  `saleOrderNo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CDN编号（CDN）',
  `customerId` int(11) NULL DEFAULT NULL COMMENT '客户id',
  `employeeId` int(11) NULL DEFAULT NULL COMMENT '(员工)接收人id',
  `setmealId` int(11) NULL DEFAULT NULL COMMENT '餐套id',
  `time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请时间',
  `starttime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开始运行时间',
  `endtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束运行时间',
  `price` float(11, 0) NULL DEFAULT NULL COMMENT '实际价格',
  `delFlag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除标记     0没有删除文件                    1为已经删除',
  `recordsNO` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备案号',
  `writeflag` int(10) NULL DEFAULT 0 COMMENT '写入文件标记，0没有写入，1已经写入',
  `cuRealmName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户申请域名',
  `syRealmName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统域名',
  `serverFlag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务状态',
  `auditingState` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `IPinterval` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP区间数',
  `PVinterval` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'PV区间数',
  `accessoryfile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件文件平均大小',
  `mostfile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多数文件平均大小',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cdnsale_customer`(`customerId`) USING BTREE,
  INDEX `cdnsale_employee`(`employeeId`) USING BTREE,
  INDEX `cdnsale_setmeal`(`setmealId`) USING BTREE,
  CONSTRAINT `cdnsaleorder_ibfk_1` FOREIGN KEY (`setmealId`) REFERENCES `setmeal` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cdnsaleorder_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cdnsaleorder_ibfk_3` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdnsaleorder
-- ----------------------------

-- ----------------------------
-- Table structure for cdntype
-- ----------------------------
DROP TABLE IF EXISTS `cdntype`;
CREATE TABLE `cdntype`  (
  `id` int(100) NOT NULL AUTO_INCREMENT COMMENT '类型表',
  `typeName` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型名称',
  `mark` int(100) NOT NULL DEFAULT 0 COMMENT '标识默认0',
  `del` int(100) NULL DEFAULT 0 COMMENT '删除标识（0默认，1删除）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cdnAreaId`(`mark`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 149 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cdntype
-- ----------------------------
INSERT INTO `cdntype` VALUES (1, '默认', 0, 0);
INSERT INTO `cdntype` VALUES (3, '移动', 0, 0);
INSERT INTO `cdntype` VALUES (4, '联通', 0, 0);
INSERT INTO `cdntype` VALUES (5, '360搜索', 0, 0);
INSERT INTO `cdntype` VALUES (6, '搜狗', 0, 0);
INSERT INTO `cdntype` VALUES (7, '搜搜', 0, 0);
INSERT INTO `cdntype` VALUES (8, '必应', 0, 0);
INSERT INTO `cdntype` VALUES (9, '有道', 0, 0);
INSERT INTO `cdntype` VALUES (10, '百度', 0, 0);
INSERT INTO `cdntype` VALUES (11, '搜索引擎', 0, 0);
INSERT INTO `cdntype` VALUES (12, '国外', 0, 0);
INSERT INTO `cdntype` VALUES (18, '电信', 0, 0);
INSERT INTO `cdntype` VALUES (35, '国内', 0, 1);
INSERT INTO `cdntype` VALUES (36, '铁通', 0, 1);
INSERT INTO `cdntype` VALUES (37, '教育网', 0, 1);
INSERT INTO `cdntype` VALUES (41, '国内', 0, 0);
INSERT INTO `cdntype` VALUES (42, '铁通', 0, 0);
INSERT INTO `cdntype` VALUES (43, '教育网', 0, 0);
INSERT INTO `cdntype` VALUES (44, '西藏移动', 0, 0);
INSERT INTO `cdntype` VALUES (45, '青海移动', 0, 0);
INSERT INTO `cdntype` VALUES (46, '宁夏移动', 0, 0);
INSERT INTO `cdntype` VALUES (47, '海南移动', 0, 0);
INSERT INTO `cdntype` VALUES (48, '甘肃移动', 0, 0);
INSERT INTO `cdntype` VALUES (49, '贵州移动', 0, 0);
INSERT INTO `cdntype` VALUES (50, '新疆移动', 0, 0);
INSERT INTO `cdntype` VALUES (51, '内蒙移动', 0, 0);
INSERT INTO `cdntype` VALUES (52, '云南移动', 0, 0);
INSERT INTO `cdntype` VALUES (53, '天津移动', 0, 0);
INSERT INTO `cdntype` VALUES (54, '广西移动', 0, 0);
INSERT INTO `cdntype` VALUES (55, '吉林移动', 0, 0);
INSERT INTO `cdntype` VALUES (56, '黑龙江移动', 0, 0);
INSERT INTO `cdntype` VALUES (57, '陕西移动', 0, 0);
INSERT INTO `cdntype` VALUES (58, '山西移动', 0, 0);
INSERT INTO `cdntype` VALUES (59, '安徽移动', 0, 0);
INSERT INTO `cdntype` VALUES (60, '江西移动', 0, 0);
INSERT INTO `cdntype` VALUES (61, '重庆移动', 0, 0);
INSERT INTO `cdntype` VALUES (62, '福建移动', 0, 0);
INSERT INTO `cdntype` VALUES (63, '湖南移动', 0, 0);
INSERT INTO `cdntype` VALUES (64, '湖北移动', 0, 0);
INSERT INTO `cdntype` VALUES (65, '河南移动', 0, 0);
INSERT INTO `cdntype` VALUES (66, '河北移动', 0, 0);
INSERT INTO `cdntype` VALUES (67, '辽宁移动', 0, 0);
INSERT INTO `cdntype` VALUES (68, '四川移动', 0, 0);
INSERT INTO `cdntype` VALUES (69, '上海移动', 0, 0);
INSERT INTO `cdntype` VALUES (70, '江苏移动', 0, 0);
INSERT INTO `cdntype` VALUES (71, '山东移动', 0, 0);
INSERT INTO `cdntype` VALUES (72, '浙江移动', 0, 0);
INSERT INTO `cdntype` VALUES (73, '广东移动', 0, 0);
INSERT INTO `cdntype` VALUES (74, '北京移动', 0, 0);
INSERT INTO `cdntype` VALUES (75, '杭州华数', 0, 0);
INSERT INTO `cdntype` VALUES (76, '长城宽带', 0, 0);
INSERT INTO `cdntype` VALUES (77, '南美洲', 0, 0);
INSERT INTO `cdntype` VALUES (78, '大洋洲', 0, 0);
INSERT INTO `cdntype` VALUES (79, '北美洲', 0, 0);
INSERT INTO `cdntype` VALUES (80, '欧洲', 0, 0);
INSERT INTO `cdntype` VALUES (81, '亚洲', 0, 0);
INSERT INTO `cdntype` VALUES (82, '南极洲', 0, 0);
INSERT INTO `cdntype` VALUES (83, '非洲', 0, 0);
INSERT INTO `cdntype` VALUES (84, '台湾', 0, 0);
INSERT INTO `cdntype` VALUES (85, '澳门', 0, 0);
INSERT INTO `cdntype` VALUES (86, '香港', 0, 0);
INSERT INTO `cdntype` VALUES (87, '浙江联通', 0, 0);
INSERT INTO `cdntype` VALUES (88, '浙江电信', 0, 0);
INSERT INTO `cdntype` VALUES (89, '云南联通', 0, 0);
INSERT INTO `cdntype` VALUES (90, '云南电信', 0, 0);
INSERT INTO `cdntype` VALUES (91, '新疆联通', 0, 0);
INSERT INTO `cdntype` VALUES (92, '新疆电信', 0, 0);
INSERT INTO `cdntype` VALUES (93, '西藏联通', 0, 0);
INSERT INTO `cdntype` VALUES (94, '西藏电信', 0, 0);
INSERT INTO `cdntype` VALUES (95, '天津联通', 0, 0);
INSERT INTO `cdntype` VALUES (96, '天津电信', 0, 0);
INSERT INTO `cdntype` VALUES (97, '四川联通', 0, 0);
INSERT INTO `cdntype` VALUES (98, '四川电信', 0, 0);
INSERT INTO `cdntype` VALUES (99, '上海联通', 0, 0);
INSERT INTO `cdntype` VALUES (100, '上海电信', 0, 0);
INSERT INTO `cdntype` VALUES (101, '陕西联通', 0, 0);
INSERT INTO `cdntype` VALUES (102, '陕西电信', 0, 0);
INSERT INTO `cdntype` VALUES (103, '山西联通', 0, 0);
INSERT INTO `cdntype` VALUES (104, '山西电信', 0, 0);
INSERT INTO `cdntype` VALUES (105, '山东联通', 0, 0);
INSERT INTO `cdntype` VALUES (106, '山东电信', 0, 0);
INSERT INTO `cdntype` VALUES (107, '青海联通', 0, 0);
INSERT INTO `cdntype` VALUES (108, '青海电信', 0, 0);
INSERT INTO `cdntype` VALUES (109, '宁夏联通', 0, 0);
INSERT INTO `cdntype` VALUES (110, '宁夏电信', 0, 0);
INSERT INTO `cdntype` VALUES (111, '内蒙联通', 0, 0);
INSERT INTO `cdntype` VALUES (112, '内蒙电信', 0, 0);
INSERT INTO `cdntype` VALUES (113, '辽宁联通', 0, 0);
INSERT INTO `cdntype` VALUES (114, '辽宁电信', 0, 0);
INSERT INTO `cdntype` VALUES (115, '江西联通', 0, 0);
INSERT INTO `cdntype` VALUES (116, '江西电信', 0, 0);
INSERT INTO `cdntype` VALUES (117, '江苏联通', 0, 0);
INSERT INTO `cdntype` VALUES (118, '江苏电信', 0, 0);
INSERT INTO `cdntype` VALUES (119, '吉林联通', 0, 0);
INSERT INTO `cdntype` VALUES (120, '吉林电信', 0, 0);
INSERT INTO `cdntype` VALUES (121, '湖南联通', 0, 0);
INSERT INTO `cdntype` VALUES (122, '湖南电信', 0, 0);
INSERT INTO `cdntype` VALUES (123, '湖北联通', 0, 0);
INSERT INTO `cdntype` VALUES (124, '湖北电信', 0, 0);
INSERT INTO `cdntype` VALUES (125, '黑龙江联通', 0, 0);
INSERT INTO `cdntype` VALUES (126, '黑龙江电信', 0, 0);
INSERT INTO `cdntype` VALUES (127, '河南联通', 0, 0);
INSERT INTO `cdntype` VALUES (128, '河南电信', 0, 0);
INSERT INTO `cdntype` VALUES (129, '河北联通', 0, 0);
INSERT INTO `cdntype` VALUES (130, '河北电信', 0, 0);
INSERT INTO `cdntype` VALUES (131, '海南联通', 0, 0);
INSERT INTO `cdntype` VALUES (132, '海南电信', 0, 0);
INSERT INTO `cdntype` VALUES (133, '贵州联通', 0, 0);
INSERT INTO `cdntype` VALUES (134, '贵州电信', 0, 0);
INSERT INTO `cdntype` VALUES (135, '广西联通', 0, 0);
INSERT INTO `cdntype` VALUES (136, '广西电信', 0, 0);
INSERT INTO `cdntype` VALUES (137, '广东联通', 0, 0);
INSERT INTO `cdntype` VALUES (138, '广东电信', 0, 0);
INSERT INTO `cdntype` VALUES (139, '甘肃联通', 0, 0);
INSERT INTO `cdntype` VALUES (140, '甘肃电信', 0, 0);
INSERT INTO `cdntype` VALUES (141, '福建联通', 0, 0);
INSERT INTO `cdntype` VALUES (142, '福建电信', 0, 0);
INSERT INTO `cdntype` VALUES (143, '重庆联通', 0, 0);
INSERT INTO `cdntype` VALUES (144, '重庆电信', 0, 0);
INSERT INTO `cdntype` VALUES (145, '北京联通', 0, 0);
INSERT INTO `cdntype` VALUES (146, '北京电信', 0, 0);
INSERT INTO `cdntype` VALUES (147, '安徽联通', 0, 0);
INSERT INTO `cdntype` VALUES (148, '安徽电信', 0, 0);

-- ----------------------------
-- Table structure for charge
-- ----------------------------
DROP TABLE IF EXISTS `charge`;
CREATE TABLE `charge`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `saleOrderId` int(11) NULL DEFAULT NULL,
  `PaymentAmount` double NULL DEFAULT NULL,
  `payCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `collectionTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isAuditing` int(11) NULL DEFAULT NULL,
  `defrayMode` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `accountPayable` float NULL DEFAULT NULL,
  `del` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inputTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `employeeID` int(11) NULL DEFAULT NULL,
  `chargeNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empID` int(11) NULL DEFAULT NULL,
  `payerName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `accountNumber` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payStat` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1',
  `soid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `charge_fk`(`saleOrderId`) USING BTREE,
  INDEX `charge_fk2`(`empID`) USING BTREE,
  INDEX `charge_fk3`(`employeeID`) USING BTREE,
  CONSTRAINT `charge_fk` FOREIGN KEY (`saleOrderId`) REFERENCES `saleorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `charge_fk2` FOREIGN KEY (`empID`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `charge_fk3` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of charge
-- ----------------------------

-- ----------------------------
-- Table structure for commoditytpye
-- ----------------------------
DROP TABLE IF EXISTS `commoditytpye`;
CREATE TABLE `commoditytpye`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `superid` int(11) NULL DEFAULT NULL COMMENT '商品父类型id',
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empId` int(11) NULL DEFAULT NULL,
  `fieldId` int(11) NULL DEFAULT NULL,
  `del` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ischeckbox` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否多选',
  `ico` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片路径',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `commodityTpye_fk`(`empId`) USING BTREE,
  INDEX `FK_commodityTpye_field`(`fieldId`) USING BTREE,
  INDEX `superid`(`superid`) USING BTREE,
  CONSTRAINT `FK_commodityTpye_field` FOREIGN KEY (`fieldId`) REFERENCES `field` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of commoditytpye
-- ----------------------------
INSERT INTO `commoditytpye` VALUES (1, 1, '商品列表', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `commoditytpye` VALUES (36, 61, 'CPU', '2011-12-18', 94, 21, '1', '1', '');
INSERT INTO `commoditytpye` VALUES (55, 61, '主板', '2011-12-18', 94, 22, '1', '1', '');
INSERT INTO `commoditytpye` VALUES (57, 61, '电源', '2011-12-18', 94, 23, '1', '1', '/file/2011121822484628852.jpg');
INSERT INTO `commoditytpye` VALUES (60, 61, '硬盘', '2011-12-07', 90, 24, '1', '1', '');
INSERT INTO `commoditytpye` VALUES (61, 1, '商品', '2011-10-04', 9, 1, '0', NULL, NULL);
INSERT INTO `commoditytpye` VALUES (62, 61, '服务器', '2011-11-08', 11, 2, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (72, 61, '办公电脑', '2011-12-16', 93, 20, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (77, 61, '组装产品', '2011-12-30', 15, 25, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (78, 61, 'IP', '2012-02-21', 100, 26, '1', '1', '');
INSERT INTO `commoditytpye` VALUES (79, 61, '机房', '2012-02-21', 13, 27, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (80, 61, '招聘类', '2012-07-19', 13, 28, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (81, 61, 'VPS服务器', '2012-07-12', 13, 29, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (82, 62, '客户服务器', '2012-09-21', 100, 30, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (83, 62, '公司服务器', '2012-09-21', 100, 31, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (84, 61, '带宽', '2012-10-11', 13, 32, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (85, 79, '滨州双线机房', '2012-10-16', 100, 33, '1', '1', '');
INSERT INTO `commoditytpye` VALUES (86, 61, '办公类', '2012-11-22', 13, 34, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (87, 86, '房租', '2012-11-22', 13, 35, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (88, 86, '办公桌-椅子', '2012-11-22', 13, 36, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (89, 86, '投影仪', '2012-11-22', 13, 37, '0', '1', '');
INSERT INTO `commoditytpye` VALUES (90, 86, '打印机(一体机)', '2012-11-22', 13, 38, '0', '1', '');

-- ----------------------------
-- Table structure for common_scfjb
-- ----------------------------
DROP TABLE IF EXISTS `common_scfjb`;
CREATE TABLE `common_scfjb`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '通用上传附件表',
  `fjmc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件名称',
  `fjhz` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件后缀',
  `fjxh` int(11) NULL DEFAULT NULL COMMENT '附件序号',
  `fjlj` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件路径',
  `sbh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '识别号(唯一标识)',
  `fbsbh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外键sbh',
  `shzt` int(11) NULL DEFAULT NULL COMMENT '审核状态',
  `build_time` datetime NULL DEFAULT NULL COMMENT '上传时间',
  `shsj` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of common_scfjb
-- ----------------------------

-- ----------------------------
-- Table structure for conkout
-- ----------------------------
DROP TABLE IF EXISTS `conkout`;
CREATE TABLE `conkout`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) NULL DEFAULT NULL COMMENT '户客ID',
  `conkOutNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障单号',
  `Descs` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障描述',
  `State` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '-1退回单据;0 初始状态;1接收成功;2转接给其他部门;3本部门处理;4处理完成交给客户;5.客户评价',
  `faultTime` datetime NULL DEFAULT NULL COMMENT '障故申报时间',
  `EndTim` datetime NULL DEFAULT NULL COMMENT '解决故障时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'jie',
  `issueType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题类型 外键  问题ID',
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `productId` int(20) NULL DEFAULT NULL COMMENT '产品Id',
  `solveDepict` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '解决问题描述',
  `customerphone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户手机号码',
  `wdnr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网站域名',
  `proudcotType` int(11) NULL DEFAULT NULL COMMENT '产品类型',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户邮箱',
  `appraise` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评价',
  `empid` int(11) NULL DEFAULT NULL COMMENT '最后一个部门Id',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip或者帐号',
  `leavess` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '意见已经建议',
  `ispay` int(11) NULL DEFAULT NULL COMMENT '是否产生费用(0:未产生,1:产生)',
  `isdeclare` int(11) NULL DEFAULT NULL COMMENT '责任声明(0:不声明,1:声明)',
  `sure` int(11) NULL DEFAULT NULL COMMENT '确认勾选(0:不产生,1:产生)',
  `upserverid` int(11) NULL DEFAULT NULL COMMENT '上架单id',
  `receiveTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `groupid` int(11) NULL DEFAULT NULL COMMENT '运维组id',
  `emp` int(11) NULL DEFAULT NULL COMMENT '回复人',
  `status` int(11) NULL DEFAULT NULL COMMENT '新状态',
  `grades` int(11) NULL DEFAULT NULL COMMENT '满意度()',
  `bzf` int(11) NULL DEFAULT NULL COMMENT '标识符(避免重复接收用 默认为0)',
  `handleemp` int(11) NULL DEFAULT NULL COMMENT '处理人',
  `temp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客服备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `conkOut_fk2`(`customerId`) USING BTREE,
  INDEX `productId`(`productId`) USING BTREE,
  INDEX `proudcotType`(`proudcotType`) USING BTREE,
  INDEX `empid`(`empid`) USING BTREE,
  INDEX `qid`(`issueType`) USING BTREE,
  CONSTRAINT `conkOut_fk2` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `conkout_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `conkout_ibfk_4` FOREIGN KEY (`proudcotType`) REFERENCES `alltype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `conkout_ibfk_6` FOREIGN KEY (`empid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 207 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of conkout
-- ----------------------------
INSERT INTO `conkout` VALUES (204, 1206, '2024102900003', 'xxxxxxx', '0', '2024-10-29 01:27:07', '2024-10-29 01:45:08', NULL, '8', '0', NULL, '', '13923461123', '', 3, '13923461123@qq.com', NULL, NULL, '-1', NULL, 0, 1, 1, NULL, '2024-10-29', 2, 13, 6, NULL, 1, 13, '');
INSERT INTO `conkout` VALUES (205, 1206, '2024102900004', 'yyyyy', '0', '2024-10-29 01:41:09', NULL, NULL, '9', '0', NULL, NULL, '13923461123', '', 3, '13923461123@qq.com', NULL, NULL, '-1', NULL, 0, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO `conkout` VALUES (206, 1206, '2024102900005', 'asdfasdfdasdfa', '0', NULL, NULL, NULL, '10', '0', NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for conkoutask
-- ----------------------------
DROP TABLE IF EXISTS `conkoutask`;
CREATE TABLE `conkoutask`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '有问必答问题问答记录表',
  `conkuutid` int(11) NULL DEFAULT NULL COMMENT '外键 问题表ID',
  `descs` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '题问描述',
  `faultTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '障故申报时间',
  `EndTim` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '解决故障时间',
  `Emp_take_id` int(11) NULL DEFAULT NULL COMMENT '接收员工',
  `inceptTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收时间',
  `propellingTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推送时间',
  `resolveTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关人员解决时间',
  `depId` int(11) NULL DEFAULT NULL COMMENT '转接部门Id',
  `empId` int(21) NULL DEFAULT NULL COMMENT '解决问题员工',
  `solveDepict` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '解决问题描述',
  `appraise` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评价',
  `isMain` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是最主问题',
  `yawp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '不满意原因',
  `corrincomTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相应部门接收时间',
  `parentId` int(11) NULL DEFAULT NULL COMMENT '转接多个部门的时候记录第一条转接记录',
  `state` int(11) NULL DEFAULT NULL COMMENT '标识该问题的状态（0.未解决 1.已解决）',
  `missiontypeid` int(11) NULL DEFAULT NULL COMMENT '运维组id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `conkuutid`(`conkuutid`) USING BTREE,
  INDEX `Emp_take_id`(`Emp_take_id`) USING BTREE,
  INDEX `empId`(`empId`) USING BTREE,
  INDEX `depId`(`depId`) USING BTREE,
  CONSTRAINT `conkoutask_ibfk_1` FOREIGN KEY (`conkuutid`) REFERENCES `conkout` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `conkoutask_ibfk_2` FOREIGN KEY (`Emp_take_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `conkoutask_ibfk_3` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `conkoutask_ibfk_4` FOREIGN KEY (`depId`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 198 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of conkoutask
-- ----------------------------
INSERT INTO `conkoutask` VALUES (193, 204, 'xxxxxxx', '2024-10-29 01:27:07', '2024-10-29', 13, '2024-10-29', '2024-10-29 01:43:40', '2024-10-29', NULL, 13, '处理完结，你验证下', NULL, NULL, NULL, NULL, 0, 0, 2);
INSERT INTO `conkoutask` VALUES (194, 205, 'yyyyy', '2024-10-29 01:41:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `conkoutask` VALUES (195, 204, 'xxxxxxx', NULL, '2024-10-29 01:45:08', NULL, NULL, NULL, '2024-10-29 01:45:08', NULL, 13, '', NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `conkoutask` VALUES (196, 204, 'xxxxxxx', NULL, '2024-10-29 01:52:15', NULL, NULL, NULL, '2024-10-29', NULL, 13, '', NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `conkoutask` VALUES (197, 206, 'asdfasdfdasdfa', '2024-10-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);

-- ----------------------------
-- Table structure for contract
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT ' 合同表',
  `contractNO` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同编号',
  `contractName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同名称',
  `signupTime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '签约时间',
  `customerId` int(11) NULL DEFAULT NULL COMMENT '客户ID 外键  引用客户表id',
  `empId` int(11) NULL DEFAULT NULL COMMENT '我方代表',
  `comeTime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同生效日期',
  `endTime` date NULL DEFAULT NULL COMMENT '合同到期时间',
  `contractContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '同合内容',
  `contractAccessory` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '同合附件',
  `contractMoney` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同金额',
  `isInvoice` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否开发票',
  `gatheringTime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收款时间',
  `salesmanEmp` int(11) NULL DEFAULT NULL COMMENT '务业员',
  `contractState` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同状态外键allType表ID',
  `repliedEmp` int(11) NULL DEFAULT NULL COMMENT '添加合同的员工',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `repliedTime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加时间',
  `auditState` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `delflag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除标记',
  `temp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `temp4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `empId`(`empId`) USING BTREE,
  INDEX `salesmanEmp`(`salesmanEmp`) USING BTREE,
  INDEX `repliedEmp`(`repliedEmp`) USING BTREE,
  INDEX `customerId`(`customerId`) USING BTREE,
  INDEX `contractState`(`contractState`) USING BTREE,
  CONSTRAINT `contract_ibfk_1` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `contract_ibfk_2` FOREIGN KEY (`salesmanEmp`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `contract_ibfk_3` FOREIGN KEY (`repliedEmp`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `contract_ibfk_4` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of contract
-- ----------------------------

-- ----------------------------
-- Table structure for currencyprocess
-- ----------------------------
DROP TABLE IF EXISTS `currencyprocess`;
CREATE TABLE `currencyprocess`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pstat` int(10) NULL DEFAULT NULL COMMENT '对应流程的审核状态',
  `begintime` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应时间',
  `pname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应流程名字',
  `pnum` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '对应编号，唯一对应',
  `temp1` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of currencyprocess
-- ----------------------------

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `customer_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `customer_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_type2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `vendition` int(11) NULL DEFAULT NULL,
  `cardid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `customer_company` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `bank_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Customer_origin` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `realName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `mobile_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `zip_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qq` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ号码',
  `facsimile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `admin` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isLoginAccount` int(11) NULL DEFAULT NULL,
  `user_from` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调查',
  `user_from2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调查说明',
  `user_notes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注说明',
  `customer_company_yw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位（英文）',
  `realName_pinyin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名（拼音）',
  `customer_country` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '国家',
  `customer_province` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省份',
  `customer_city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 城市',
  `address_yw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址（英文）',
  `businesslinkpersion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '务业联系人',
  `dobusinesscode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '营业执照',
  `questionid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密保问题',
  `answervalue` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密保问题答案',
  `issetmibao` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否已经设置密保（0：未设置，1：已设置）',
  `authorization` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权码授',
  `cusClass` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `card_photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `license` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `historytime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `localip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `companyadress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customerexplain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `companyScale` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `companyphone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customerfj` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `def` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NULL' COMMENT '默认',
  `phoneIsOk` int(10) NULL DEFAULT 0 COMMENT '是否设置为登录手机',
  `cuSFZTime` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证有效期',
  `customer_tx` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  PRIMARY KEY (`customer_id`) USING BTREE,
  INDEX `FK_customer_customer`(`vendition`) USING BTREE,
  CONSTRAINT `FK_customer_customer` FOREIGN KEY (`vendition`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1207 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1206, '张三20241029', NULL, NULL, '3', 13, '513821199907226292', '暂无', NULL, NULL, NULL, '张三20241029', '13823215959', '13923461123', '13923461123@qq.com', NULL, '2024-10-29', '13823215959', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '', '', '1-50', '', NULL, 'NULL', 0, NULL, NULL);

-- ----------------------------
-- Table structure for customerauditing
-- ----------------------------
DROP TABLE IF EXISTS `customerauditing`;
CREATE TABLE `customerauditing`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NULL DEFAULT NULL,
  `Auditcontent` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Auditdate` datetime NULL DEFAULT NULL,
  `empID` int(11) NULL DEFAULT NULL,
  `isOk` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Auditresult` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customerAuditing_fk`(`customer_id`) USING BTREE,
  INDEX `customerAuditing_fk2`(`empID`) USING BTREE,
  CONSTRAINT `customerAuditing_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `customerAuditing_fk2` FOREIGN KEY (`empID`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of customerauditing
-- ----------------------------

-- ----------------------------
-- Table structure for customercommodity
-- ----------------------------
DROP TABLE IF EXISTS `customercommodity`;
CREATE TABLE `customercommodity`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `customerID` int(11) NULL DEFAULT NULL,
  `CommodityName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isSendBack` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `commodityInfo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `EmpID` int(11) NULL DEFAULT NULL,
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `barCode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sendBacktime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `customerCommodity_fk`(`customerID`) USING BTREE,
  INDEX `customerCommodity_fk2`(`EmpID`) USING BTREE,
  CONSTRAINT `customerCommodity_fk` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `customerCommodity_fk2` FOREIGN KEY (`EmpID`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of customercommodity
-- ----------------------------

-- ----------------------------
-- Table structure for customermove
-- ----------------------------
DROP TABLE IF EXISTS `customermove`;
CREATE TABLE `customermove`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) NULL DEFAULT NULL,
  `oldPrincipal` int(11) NULL DEFAULT NULL,
  `newPrincipal` int(11) NULL DEFAULT NULL,
  `moveCause` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `movetime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Delflag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_customerMove_customer`(`customerId`) USING BTREE,
  INDEX `FK_customerMove_employee`(`newPrincipal`) USING BTREE,
  INDEX `FK_customerMove_employee1`(`oldPrincipal`) USING BTREE,
  CONSTRAINT `FK_customerMove_customer` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_customerMove_employee` FOREIGN KEY (`newPrincipal`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_customerMove_employee1` FOREIGN KEY (`oldPrincipal`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of customermove
-- ----------------------------

-- ----------------------------
-- Table structure for customertryout
-- ----------------------------
DROP TABLE IF EXISTS `customertryout`;
CREATE TABLE `customertryout`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_id` int(11) NOT NULL,
  `IP` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `servercollocate` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bandwidth` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tryoutBeginDate` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tryoutEndDate` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isPurchase` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customerTryout_fk`(`Customer_id`) USING BTREE,
  CONSTRAINT `customerTryout_fk` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of customertryout
-- ----------------------------

-- ----------------------------
-- Table structure for delivery_address
-- ----------------------------
DROP TABLE IF EXISTS `delivery_address`;
CREATE TABLE `delivery_address`  (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `particular_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `netherlands` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地区',
  `consignee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人',
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机',
  `cusid` int(10) NULL DEFAULT NULL,
  `postalcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `def` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NULL' COMMENT '地址的默认值的标识',
  PRIMARY KEY (`address_id`) USING BTREE,
  INDEX `delivery_address`(`cusid`) USING BTREE,
  CONSTRAINT `cusid` FOREIGN KEY (`cusid`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of delivery_address
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Time` datetime NULL DEFAULT NULL,
  `directorId` int(11) NULL DEFAULT NULL COMMENT '部门主管',
  `delflag` int(11) NULL DEFAULT NULL,
  `tel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `depNo` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parentId` int(11) NULL DEFAULT NULL,
  `orderno` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '序排',
  `filialemark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分公司标识',
  `fiiale` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为分公司（1.是 空.否）',
  `islevel` int(10) NULL DEFAULT NULL,
  `squnum` int(10) NULL DEFAULT NULL,
  `ordernum` tinyint(4) NULL DEFAULT NULL,
  `isbj` int(10) NULL DEFAULT NULL,
  `gradeid` int(11) NULL DEFAULT 7,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 173 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (0, '新质', '2011-12-12 16:58:30', NULL, 0, '13655219061', '000', -1, NULL, NULL, NULL, 1, 7, NULL, NULL, NULL);
INSERT INTO `department` VALUES (1, '集团', '2011-11-08 11:22:23', NULL, 0, '1111111111', '111', 0, NULL, 'FA', NULL, 2, 1, NULL, NULL, NULL);
INSERT INTO `department` VALUES (28, '控股集团', '2011-10-25 14:20:18', 99, 0, '111111111111', '110', 1, NULL, 'FA-XZ-01', NULL, 3, 1, NULL, NULL, NULL);
INSERT INTO `department` VALUES (29, '总裁办公室', '2011-10-25 14:20:18', 74, 0, '13643033721', '104', 28, NULL, 'FA-XZ', '0', 3, 0, NULL, 1, 1);
INSERT INTO `department` VALUES (30, '研发中心', '2011-10-31 16:46:12', 13, 0, '18654300883', '140', 28, NULL, 'FA-XZ-01-01', '0', 4, 2, NULL, 0, 1);
INSERT INTO `department` VALUES (31, '财务中心', '2011-10-31 16:46:42', 166, 0, '11111111111', '002', 28, NULL, 'FA-XZ-01-01', '0', 4, 3, NULL, 0, 1);
INSERT INTO `department` VALUES (33, '营销中心', '2011-11-07 19:12:27', 100, 0, '13430337211', '141', 28, NULL, 'FA-XZ-01-03', NULL, 3, 4, NULL, NULL, 1);
INSERT INTO `department` VALUES (74, '运营支撑中心', '2011-12-12 16:29:26', 85, 0, '18605597894', '130', 28, NULL, 'FA-XZ-01-01', NULL, 4, 5, NULL, NULL, 1);
INSERT INTO `department` VALUES (76, '行政中心', '2011-12-12 16:34:47', 166, 0, '18605597894', '120', 28, NULL, 'FA-XZ-01-01', '0', 4, 6, NULL, 0, 1);
INSERT INTO `department` VALUES (80, '深圳销售部', '2011-12-12 16:51:05', 124, 0, '13534231397', '135', 91, NULL, 'FA-XZ-002-01-01', '0', 6, 0, NULL, 0, 7);
INSERT INTO `department` VALUES (81, '网络销售部', '2011-12-12 16:51:51', 119, 0, '13530705154', '130', 80, NULL, 'FA-XZ-002-01-01-01', NULL, 7, 1, NULL, NULL, NULL);
INSERT INTO `department` VALUES (82, '山东调度监控中心', '2011-12-12 16:52:16', 84, 0, '13534231397', '140', 74, NULL, 'FA-XZ-13-14', NULL, 5, 1, NULL, NULL, NULL);
INSERT INTO `department` VALUES (83, '珠海值班运维', '2011-12-12 16:53:06', 84, 0, '13534231397', '150', 120, NULL, 'FA-XZ-01-01-03-01', NULL, 6, 1, NULL, NULL, NULL);
INSERT INTO `department` VALUES (87, '法务部', '2011-12-12 16:58:30', 75, 0, '13655219061', '180', 28, NULL, 'FA-XZ-01-03', '0', 4, 7, NULL, 0, 1);
INSERT INTO `department` VALUES (88, '综合管理办公室', '2011-12-29 10:07:43', 99, 0, '13643033721', '190', 29, NULL, 'FA-XZ-01', '0', 5, 0, NULL, 1, 2);
INSERT INTO `department` VALUES (91, '销售中心', '2012-02-19 01:25:24', 124, 0, '29558715', '160', 33, NULL, 'FA-XZ-01-03-01', '0', 5, 0, NULL, 0, 3);
INSERT INTO `department` VALUES (92, '人力资源中心', '2012-02-22 16:50:58', 151, 0, '12311111111', '120', 76, NULL, 'FA-XZ-12-12', NULL, 5, 0, NULL, NULL, NULL);
INSERT INTO `department` VALUES (108, '滨州销售分部', '2012-11-06 04:00:28', 84, 0, '18654300060', '231', 106, NULL, 'FA-XZ-002-01-02', NULL, 7, 2, NULL, NULL, NULL);
INSERT INTO `department` VALUES (110, '北京销售部', '2012-11-06 04:03:33', 185, 0, '18654300060', '511', 91, NULL, '', NULL, 6, 0, NULL, NULL, NULL);
INSERT INTO `department` VALUES (112, '外包技术中心', '2012-11-06 04:14:27', 145, 0, '18654300060', '190', 30, NULL, '', NULL, 5, 4, NULL, NULL, NULL);
INSERT INTO `department` VALUES (114, '产品研究室', NULL, 187, 0, '18654300060', '191', 30, NULL, '', NULL, 4, 5, NULL, NULL, NULL);
INSERT INTO `department` VALUES (115, '核心系统部', '2012-11-06 04:17:28', 13, 0, '18654300060', '181', 30, NULL, 'FA-XZ-01-01-01', NULL, 5, 6, NULL, NULL, NULL);
INSERT INTO `department` VALUES (116, '深圳销售一组', '2012-11-06 04:27:01', 157, 0, '18654300060', '161', 80, NULL, '', NULL, 7, 2, NULL, NULL, NULL);
INSERT INTO `department` VALUES (117, '深圳销售二组', '2012-11-06 04:27:47', 162, 0, '18654300061', '162', 80, NULL, '', NULL, 7, 3, NULL, NULL, NULL);
INSERT INTO `department` VALUES (119, '深圳调度监控中心', '2012-11-06 04:33:33', 100, 0, '18654300060', '151', 74, NULL, 'FA-XZ-01-01-01', NULL, 5, 2, NULL, NULL, NULL);
INSERT INTO `department` VALUES (120, '运机房值班技术组', '2012-11-06 04:36:14', 84, 0, '18654300060', '242', 74, NULL, 'FA-XZ-01-01-03', NULL, 5, 3, NULL, NULL, NULL);
INSERT INTO `department` VALUES (122, '滨州值班运维', '2012-11-06 04:41:04', 80, 0, '18654300060', '262', 120, NULL, 'FA-XZ-01-01-03-03', NULL, 6, 3, NULL, NULL, NULL);
INSERT INTO `department` VALUES (125, '山西销售部', '2012-11-06 06:49:30', NULL, 0, '18654300061', '811', 91, NULL, '', NULL, 6, 0, NULL, NULL, NULL);
INSERT INTO `department` VALUES (129, '海外控股公司(香港.筹)', '2012-11-06 07:02:15', NULL, 0, '18654300060', '020', 1, NULL, 'HK.A', NULL, 3, 6, NULL, NULL, NULL);
INSERT INTO `department` VALUES (136, '管理办公室', NULL, NULL, 0, '18654300883', '121', 30, NULL, '', '0', 4, 0, NULL, 1, 2);
INSERT INTO `department` VALUES (149, '集团创意中心', '2012-12-29 19:28:44', NULL, 0, '', '', 28, NULL, '', '0', 3, 8, NULL, 0, 1);
INSERT INTO `department` VALUES (150, '战略研究中心', '2013-01-24 04:34:43', NULL, 0, NULL, NULL, 29, NULL, NULL, NULL, 4, 5, NULL, NULL, NULL);
INSERT INTO `department` VALUES (151, '项目经营部', '2013-01-24 04:36:06', NULL, 0, NULL, NULL, 29, NULL, NULL, NULL, 4, 6, NULL, NULL, NULL);
INSERT INTO `department` VALUES (153, '深圳设计室', '2013-01-24 04:45:31', NULL, 0, '', '', 149, NULL, '', '0', 4, 2, NULL, 0, 6);
INSERT INTO `department` VALUES (154, '德州设计室', '2013-01-24 04:46:29', NULL, 0, '', '', 149, NULL, '', '0', 4, 3, NULL, 0, 7);
INSERT INTO `department` VALUES (155, '投资管理部', '2013-01-24 04:49:02', NULL, 0, NULL, NULL, 29, NULL, NULL, NULL, 4, 7, NULL, NULL, NULL);
INSERT INTO `department` VALUES (156, '客户服务中心', '2013-01-24 04:51:38', NULL, 0, NULL, NULL, 28, NULL, NULL, NULL, 3, 9, NULL, NULL, 1);
INSERT INTO `department` VALUES (157, '南方客服部', '2013-01-24 04:52:12', NULL, 0, NULL, NULL, 156, NULL, NULL, NULL, 4, 2, NULL, NULL, NULL);
INSERT INTO `department` VALUES (158, '北方客服部', '2013-01-24 04:52:38', NULL, 0, NULL, NULL, 156, NULL, NULL, NULL, 4, 3, NULL, NULL, NULL);
INSERT INTO `department` VALUES (159, '北京客服部', '2013-01-24 04:53:29', NULL, 0, NULL, NULL, 156, NULL, NULL, NULL, 4, 4, NULL, NULL, NULL);
INSERT INTO `department` VALUES (160, '深圳分部', '2013-01-24 04:55:48', NULL, 0, NULL, NULL, 157, NULL, NULL, NULL, 5, 2, NULL, NULL, NULL);
INSERT INTO `department` VALUES (161, '山东分部', '2013-01-24 04:56:47', NULL, 0, NULL, NULL, 158, NULL, NULL, NULL, 5, 2, NULL, NULL, NULL);
INSERT INTO `department` VALUES (162, '行政部', '2013-01-24 05:07:33', NULL, 0, NULL, NULL, 76, NULL, NULL, NULL, 5, 3, NULL, NULL, NULL);
INSERT INTO `department` VALUES (163, '市场部', '2013-01-24 05:07:58', NULL, 0, NULL, NULL, 33, NULL, NULL, NULL, 4, 6, NULL, NULL, NULL);
INSERT INTO `department` VALUES (164, '山东行政部', '2013-01-24 05:13:23', NULL, 0, NULL, NULL, 162, NULL, NULL, NULL, 6, 2, NULL, NULL, NULL);
INSERT INTO `department` VALUES (170, 'ssss', '2025-06-08 10:04:45', NULL, 0, '18612345678', 'dept-mark', 29, NULL, 'sub_company', '1', 4, 8, NULL, 0, 2);
INSERT INTO `department` VALUES (171, '11111', '2025-06-08 10:27:17', NULL, 0, NULL, NULL, 29, NULL, NULL, NULL, 4, 9, NULL, NULL, NULL);
INSERT INTO `department` VALUES (172, '2222', NULL, NULL, 1, '18612345671', '170', 170, NULL, 'sub_company-1', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for department_grade
-- ----------------------------
DROP TABLE IF EXISTS `department_grade`;
CREATE TABLE `department_grade`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门级别表',
  `dg_num` tinyint(4) NULL DEFAULT NULL COMMENT '部门等级数字',
  `dg_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门等级名称',
  `dg_desc` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门等级描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of department_grade
-- ----------------------------
INSERT INTO `department_grade` VALUES (1, 1, '一级', NULL);
INSERT INTO `department_grade` VALUES (2, 2, '二级', NULL);
INSERT INTO `department_grade` VALUES (3, 3, '三级', NULL);
INSERT INTO `department_grade` VALUES (4, 4, '四级', NULL);
INSERT INTO `department_grade` VALUES (5, 5, '五级', NULL);
INSERT INTO `department_grade` VALUES (6, 6, '六级', NULL);
INSERT INTO `department_grade` VALUES (7, 7, '七级', NULL);

-- ----------------------------
-- Table structure for depot
-- ----------------------------
DROP TABLE IF EXISTS `depot`;
CREATE TABLE `depot`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `capacity` int(11) NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `admin` int(11) NULL DEFAULT NULL,
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of depot
-- ----------------------------
INSERT INTO `depot` VALUES (40, '滨州仓库', 2000, '滨州', 15, '2011-12-17', '0');
INSERT INTO `depot` VALUES (41, '滨州联通库房', 1000, '山东滨州联通', 15, '2012-05-20', '0');
INSERT INTO `depot` VALUES (42, '秦皇岛电信库房', 1000, '河北秦皇岛', 15, '2012-05-20', '0');
INSERT INTO `depot` VALUES (43, '珠海电信库房', 1000, '广东珠海', 15, '2012-05-20', '0');
INSERT INTO `depot` VALUES (44, '德州联通库房', 1000, '山东联通', 15, '2012-05-20', '0');
INSERT INTO `depot` VALUES (45, '滨州双线仓库', 1000, '滨州', 15, '2012-10-16', '0');
INSERT INTO `depot` VALUES (46, '北京石景山库房', 1000, '北京石景山', 15, '2012-10-16', '0');
INSERT INTO `depot` VALUES (47, '深圳仓库', 1000, '广东省深圳市f518创意园', 15, '2013-05-31', '0');

-- ----------------------------
-- Table structure for district
-- ----------------------------
DROP TABLE IF EXISTS `district`;
CREATE TABLE `district`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderdataid` int(11) NULL DEFAULT NULL COMMENT '订单类型数据表id',
  `tmoblie` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '运营商',
  `districtName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所在地区',
  `IP` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回源IP',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `district_orderdata`(`orderdataid`) USING BTREE,
  CONSTRAINT `district_orderdata` FOREIGN KEY (`orderdataid`) REFERENCES `cdnsaleorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of district
-- ----------------------------

-- ----------------------------
-- Table structure for docmark
-- ----------------------------
DROP TABLE IF EXISTS `docmark`;
CREATE TABLE `docmark`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `mark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单据标识',
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `otype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of docmark
-- ----------------------------
INSERT INTO `docmark` VALUES (1, '销售订单', 'XSDD', 'SaleOrder', 'selectsaleOrder.do?marker=SaleOrder', NULL, '99');
INSERT INTO `docmark` VALUES (2, '服务器上架单', 'SJ', 'UpServer', 'selectUpserver.do?marker=UpServer', NULL, '99');
INSERT INTO `docmark` VALUES (3, '服务器下架单', 'XJ', 'DownServer', 'selectDownserver.do?marker=DownServer', NULL, '99');
INSERT INTO `docmark` VALUES (4, '采购订单', 'CGO', 'PurOrder', 'getPurchaseOrder.do?marker=PurOrder', NULL, '99');
INSERT INTO `docmark` VALUES (5, '付款单', 'FK', 'PaymentLog', 'selectpay.do?marker=PaymentLog', NULL, '99');
INSERT INTO `docmark` VALUES (6, '收款单', 'SK', 'Charge', 'selectcharge.do?marker=Charge', NULL, '99');
INSERT INTO `docmark` VALUES (7, '请购单', 'QG', 'ApplyBuy', 'getRejectioning.do?marker=ApplyBuy', NULL, '99');
INSERT INTO `docmark` VALUES (8, '采购到货单', 'DH', 'ToOrder', 'getpageToOrder.do?marker=ToOrder', NULL, '99');
INSERT INTO `docmark` VALUES (9, '采购退货单', 'CGTH', NULL, 'returnOrderListRejection.do?marker=ReturnOrder', NULL, '99');
INSERT INTO `docmark` VALUES (10, '到货入库单', 'RK', 'Storage', 'warehousingInfoWarehousing.do?marker=Storage', NULL, '99');
INSERT INTO `docmark` VALUES (11, '出库单', 'CK', 'Outbound', 'outBoundInfoOutbound.do?marker=', NULL, '99');
INSERT INTO `docmark` VALUES (12, '库存盘点单', 'PD', 'Stat', 'selectStat.do?marker=Stat', NULL, '99');
INSERT INTO `docmark` VALUES (13, '报损单', 'PorL', 'Ruin', 'queryTheDamage.do?marker=Ruin', NULL, '99');
INSERT INTO `docmark` VALUES (14, '报溢单', 'BY', 'Income', 'selectincome.do?marker=Income', NULL, '99');
INSERT INTO `docmark` VALUES (15, '价格调整记录单', 'PR', 'Priceregulation', 'selectpriceReg.do?marker=Priceregulation', NULL, '99');
INSERT INTO `docmark` VALUES (16, '组装服务器单', 'AS', 'AssemblyServer', 'selectAssemblyServer.do?marker=AssemblyServer', NULL, '99');
INSERT INTO `docmark` VALUES (18, '安徽分公司销售订单', 'AH-XSDD', 'SaleOrder', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (19, '安徽销售1部订单', 'AHXS1-XSDD', '', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (21, '技术部销售订单', 'JS-XSDD', 'SaleOrder', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (22, '销售订单1部', 'xx-XSDD', 'SaleOrder', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (23, '合同', 'HT', 'ReturnOrder', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (24, '收款', 'SK', NULL, NULL, NULL, '99');
INSERT INTO `docmark` VALUES (26, '客户退单', 'KHTD', NULL, NULL, NULL, '99');
INSERT INTO `docmark` VALUES (27, '员工请假单', 'YGQJD', 'FormTemp', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (28, '变更工资审批表', 'BGGZSPB', 'FormTemp', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (29, '住宿申请单', 'ZSSQD', 'FormTemp', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (30, '辞职申请表', 'CZSQB', 'FormTemp', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (31, '员工罚单', 'YGFD', 'FormTemp', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (32, '出差申请单', 'CCQJD', 'FormTemp', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (33, '员工离职单', 'YGLZD', 'FormTemp', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (34, '试用期员工考核', 'SYKH', 'FormTemp', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (35, 'CDN订单', 'CDN', 'CDNsaleOrder', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (36, '添加商品', 'xxttjsp', 'sale_goods', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (37, '新系统销售订单', 'XXTXSDD', 'Sale_orders', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (38, '资源核查单', 'zyhcd', 'CSDN', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (39, '资源核实单', 'CSDN', 't_resourceCheck', NULL, NULL, '99');
INSERT INTO `docmark` VALUES (40, '系统公告', 'GG', 'Notice', NULL, NULL, '98');

-- ----------------------------
-- Table structure for downserver
-- ----------------------------
DROP TABLE IF EXISTS `downserver`;
CREATE TABLE `downserver`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empId` int(11) NULL DEFAULT NULL,
  `dtime` datetime NULL DEFAULT NULL,
  `downFlag` int(11) NULL DEFAULT NULL,
  `auditingFlag` int(11) NULL DEFAULT NULL,
  `alltypeId` int(11) NULL DEFAULT NULL,
  `downNo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` int(11) NULL DEFAULT NULL,
  `serverId` int(11) NULL DEFAULT NULL,
  `businesstype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务类型',
  `customerId` int(11) NULL DEFAULT NULL COMMENT '户客id',
  `system` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统显示',
  `configurationinfo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置详情信息',
  `bandwidthflow` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '带宽流量',
  `downcause` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下架原因',
  `returnAmout` float(11, 0) NULL DEFAULT NULL COMMENT '退返金额',
  `settlementAccount` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结算账号',
  `costFlag` int(11) NULL DEFAULT NULL COMMENT '费用结清    0为已    1为否',
  `serverIP` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址集合',
  `serverLocation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '//服务器存放的机房位置，防止服务器换了机房后，下架上的机房位置也会变',
  `upNo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上架单号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_downServer_allType`(`alltypeId`) USING BTREE,
  INDEX `FK_downServer_employee`(`empId`) USING BTREE,
  INDEX `serverId`(`serverId`) USING BTREE,
  CONSTRAINT `FK_downServer_allType` FOREIGN KEY (`alltypeId`) REFERENCES `alltype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_downServer_employee` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `downserver_ibfk_2` FOREIGN KEY (`serverId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of downserver
-- ----------------------------

-- ----------------------------
-- Table structure for e_exammodel
-- ----------------------------
DROP TABLE IF EXISTS `e_exammodel`;
CREATE TABLE `e_exammodel`  (
  `e_modid` int(11) NOT NULL AUTO_INCREMENT,
  `e_modname` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `e_modtype` varchar(30) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_modgrade` int(11) NULL DEFAULT NULL,
  `e_modorder` varchar(30) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_modinfo` text CHARACTER SET gbk COLLATE gbk_chinese_ci NULL,
  `e_modstat` int(11) NULL DEFAULT NULL,
  `e_modwritetime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`e_modid`) USING BTREE,
  UNIQUE INDEX `AK_Key_3`(`e_modname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_exammodel
-- ----------------------------

-- ----------------------------
-- Table structure for e_exampaper
-- ----------------------------
DROP TABLE IF EXISTS `e_exampaper`;
CREATE TABLE `e_exampaper`  (
  `e_papid` int(11) NOT NULL AUTO_INCREMENT,
  `id` int(11) NULL DEFAULT NULL,
  `e_modid` int(11) NULL DEFAULT NULL,
  `e_paname` varchar(150) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `e_ptyid` int(11) NULL DEFAULT NULL,
  `e_papstat` int(11) NULL DEFAULT NULL,
  `e_papdesc` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_paptime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`e_papid`) USING BTREE,
  INDEX `FK_Relationship_4`(`id`) USING BTREE,
  INDEX `FK_Relationship_9`(`e_ptyid`) USING BTREE,
  INDEX `FK_relationship_200`(`e_modid`) USING BTREE,
  CONSTRAINT `FK_Relationship_100` FOREIGN KEY (`e_ptyid`) REFERENCES `e_examtitleclass` (`e_ptyid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_4` FOREIGN KEY (`id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_relationship_200` FOREIGN KEY (`e_modid`) REFERENCES `e_exammodel` (`e_modid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_exampaper
-- ----------------------------

-- ----------------------------
-- Table structure for e_examroles
-- ----------------------------
DROP TABLE IF EXISTS `e_examroles`;
CREATE TABLE `e_examroles`  (
  `e_rolid` int(11) NOT NULL AUTO_INCREMENT,
  `e_papid` int(11) NULL DEFAULT NULL,
  `e_roltotal` int(11) NULL DEFAULT NULL,
  `e_rolcount` int(11) NULL DEFAULT NULL,
  `e_rolong` int(11) NULL DEFAULT NULL,
  `e_roltime` datetime NULL DEFAULT NULL,
  `e_roltype1` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_roltype2` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_roltype3` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_roltype4` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_roltype5` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`e_rolid`) USING BTREE,
  INDEX `FK_Relationship_3`(`e_papid`) USING BTREE,
  CONSTRAINT `FK_Relationship_3` FOREIGN KEY (`e_papid`) REFERENCES `e_exampaper` (`e_papid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_examroles
-- ----------------------------

-- ----------------------------
-- Table structure for e_examscore
-- ----------------------------
DROP TABLE IF EXISTS `e_examscore`;
CREATE TABLE `e_examscore`  (
  `e_ansid` int(11) NOT NULL AUTO_INCREMENT,
  `e_papid` int(11) NULL DEFAULT NULL,
  `id` int(11) NULL DEFAULT NULL,
  `e_ansmenname` varchar(30) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_ansalls` varchar(400) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_anstime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`e_ansid`) USING BTREE,
  INDEX `FK_Relationship_10`(`e_papid`) USING BTREE,
  INDEX `FK_Relationship_8`(`id`) USING BTREE,
  CONSTRAINT `FK_Relationship_10` FOREIGN KEY (`e_papid`) REFERENCES `e_exampaper` (`e_papid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_8` FOREIGN KEY (`id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_examscore
-- ----------------------------

-- ----------------------------
-- Table structure for e_examtabchoce
-- ----------------------------
DROP TABLE IF EXISTS `e_examtabchoce`;
CREATE TABLE `e_examtabchoce`  (
  `e_tchid` int(11) NOT NULL AUTO_INCREMENT,
  `e_papid` int(11) NULL DEFAULT NULL,
  `e_tchall` varchar(400) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`e_tchid`) USING BTREE,
  INDEX `FK_Relationship_2`(`e_papid`) USING BTREE,
  CONSTRAINT `FK_Relationship_2` FOREIGN KEY (`e_papid`) REFERENCES `e_exampaper` (`e_papid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_examtabchoce
-- ----------------------------

-- ----------------------------
-- Table structure for e_examtabscore
-- ----------------------------
DROP TABLE IF EXISTS `e_examtabscore`;
CREATE TABLE `e_examtabscore`  (
  `e_scoid` int(11) NOT NULL AUTO_INCREMENT,
  `e_papid` int(11) NULL DEFAULT NULL,
  `id` int(11) NULL DEFAULT NULL,
  `e_menname` varchar(30) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_scocorrent` float NULL DEFAULT NULL,
  `e_sconums` float NULL DEFAULT NULL,
  `e_scotime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`e_scoid`) USING BTREE,
  INDEX `FK_Relationship_11`(`e_papid`) USING BTREE,
  INDEX `FK_Relationship_7`(`id`) USING BTREE,
  CONSTRAINT `FK_Relationship_11` FOREIGN KEY (`e_papid`) REFERENCES `e_exampaper` (`e_papid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_7` FOREIGN KEY (`id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_examtabscore
-- ----------------------------

-- ----------------------------
-- Table structure for e_examtitle
-- ----------------------------
DROP TABLE IF EXISTS `e_examtitle`;
CREATE TABLE `e_examtitle`  (
  `e_titid` int(11) NOT NULL AUTO_INCREMENT,
  `e_ptyid` int(11) NULL DEFAULT NULL,
  `e_titmain` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_tittype` int(11) NULL DEFAULT NULL,
  `e_titstat` int(11) NULL DEFAULT NULL,
  `e_titcorrent` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `e_titwritetime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`e_titid`) USING BTREE,
  INDEX `FK_Relationship_1`(`e_ptyid`) USING BTREE,
  CONSTRAINT `FK_Relationship_1` FOREIGN KEY (`e_ptyid`) REFERENCES `e_examtitleclass` (`e_ptyid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_examtitle
-- ----------------------------

-- ----------------------------
-- Table structure for e_examtitleclass
-- ----------------------------
DROP TABLE IF EXISTS `e_examtitleclass`;
CREATE TABLE `e_examtitleclass`  (
  `e_ptyid` int(11) NOT NULL AUTO_INCREMENT,
  `e_ptyclass` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `e_ptydes` varchar(150) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`e_ptyid`) USING BTREE,
  UNIQUE INDEX `AK_Identifier_1`(`e_ptyclass`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_examtitleclass
-- ----------------------------

-- ----------------------------
-- Table structure for e_titleandpaper
-- ----------------------------
DROP TABLE IF EXISTS `e_titleandpaper`;
CREATE TABLE `e_titleandpaper`  (
  `e_patid` int(11) NOT NULL AUTO_INCREMENT,
  `e_titid` int(11) NOT NULL,
  `e_papid` int(11) NOT NULL,
  `e_modid` int(11) NOT NULL,
  PRIMARY KEY (`e_patid`) USING BTREE,
  INDEX `FK_Reference_12`(`e_modid`) USING BTREE,
  INDEX `FK_Relationship_5`(`e_titid`) USING BTREE,
  INDEX `FK_Relationship_6`(`e_papid`) USING BTREE,
  CONSTRAINT `FK_Reference_12` FOREIGN KEY (`e_modid`) REFERENCES `e_exammodel` (`e_modid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_5` FOREIGN KEY (`e_titid`) REFERENCES `e_examtitle` (`e_titid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Relationship_6` FOREIGN KEY (`e_papid`) REFERENCES `e_exampaper` (`e_papid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of e_titleandpaper
-- ----------------------------

-- ----------------------------
-- Table structure for empassess
-- ----------------------------
DROP TABLE IF EXISTS `empassess`;
CREATE TABLE `empassess`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工考核表',
  `questionId` int(11) NULL DEFAULT NULL COMMENT '问题ID 外键',
  `depId` int(11) NULL DEFAULT NULL COMMENT '部门ID 外键',
  `duration` int(11) NULL DEFAULT NULL COMMENT '处理问题时间',
  `assess` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考核描述',
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '展扩字段',
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `questionId`(`questionId`) USING BTREE,
  INDEX `depId`(`depId`) USING BTREE,
  CONSTRAINT `empassess_ibfk_1` FOREIGN KEY (`questionId`) REFERENCES `questioncategory` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `empassess_ibfk_2` FOREIGN KEY (`depId`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of empassess
-- ----------------------------

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工表（自动增长ID）',
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'UUID唯一标识符',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名姓',
  `birth` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日生',
  `sex` int(11) NULL DEFAULT NULL COMMENT '别性',
  `age` int(11) NULL DEFAULT NULL COMMENT '龄年',
  `cardid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `department` int(11) NULL DEFAULT NULL COMMENT '门部ID',
  `education` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学历',
  `Tel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '定电话固',
  `empNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工编号',
  `isLoginAccount` int(11) NULL DEFAULT NULL COMMENT '是否有登录帐号',
  `nation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '族民',
  `health` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '康状况健',
  `stature` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '高身',
  `heft` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体重',
  `married` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否婚结',
  `censusreg` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户籍地',
  `engleve` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语水平英',
  `place` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位',
  `nowplace` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '居住地现',
  `urgenttel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '急紧电话',
  `specialty` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '技能特长',
  `computeleve` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '算机计水平',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `position` int(11) NULL DEFAULT NULL COMMENT '职位',
  `workposition` int(11) NULL DEFAULT NULL,
  `msqk` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试情况面',
  `jtcy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭成员',
  `isLeave` int(255) NULL DEFAULT NULL COMMENT '否是离职（0离职、1在职）',
  `leaveReason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '离职原因',
  `entryTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '入职时间',
  `leaveTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '离职时间',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '否是删除（0没删除、1删除）',
  `isqj` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否请假。(1请假)null没请假',
  `approvemoney` double NULL DEFAULT NULL COMMENT '审批最大金额',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工头像',
  `gradeid` int(11) NULL DEFAULT NULL COMMENT '员工等级',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_employee_department`(`department`) USING BTREE,
  INDEX `fk_employee_group`(`position`) USING BTREE,
  INDEX `workposition`(`workposition`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`department`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`position`) REFERENCES `groups` (`groupID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`workposition`) REFERENCES `workposition` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 324 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (13, 'aab055e4-891b-4de4-9566-a96eaf5c4527', '冷志勇', '1986-07-22', 1, 26, '513821198607226191', '2011-10-31 16:50:10', 30, '本科', '18654300883', '14001', 1, '汉', '良好', '168', '55', '1', '四川眉山', '良', '四川眉山', '公司宿舍：新乐社区', '8888888888', '', '良好', 'lengzhiyong@fuaotech.com', 35, NULL, NULL, NULL, 1, '', '2009-03-09', '', 0, NULL, NULL, NULL, NULL);
INSERT INTO `employee` VALUES (15, '63c3e504-f0fd-46af-89dd-5dbe07071903', 'admin', '2011-12-10', 1, NULL, '440508199002086398', '2011-11-07 10:44:24', 1, '', '13643033721', 'admin', 1, '汉', '啊啊', '176', '54', '2', '', '', '', '', '', '', '', '545', 12, NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, 1000, NULL, NULL);
INSERT INTO `employee` VALUES (323, '306bd0f2-d199-4c04-8445-1535739deecf', '客服一', '2001-10-29', 2, 25, '523321200103226393', '2024-10-29 12:31:40', 156, '本科', '18612345678', '20001', 1, '汉', '良好', '172', '45', '2', '深圳', 'XXXXX', 'XXXXX', 'XXXXX', '18612345678', 'XSSXXXX', '良好', 'XCXXXXX@qq.com', 10, NULL, NULL, NULL, 1, '', '2024-10-01', '', 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for employee_fjfb
-- ----------------------------
DROP TABLE IF EXISTS `employee_fjfb`;
CREATE TABLE `employee_fjfb`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工附件附表_键主ID',
  `employeeId` int(11) NULL DEFAULT NULL COMMENT '员工表(employee)外键ID',
  `attachmentSerialNumber` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件序列号',
  `attachmentName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件名称',
  `attachmentSuffix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件后缀名',
  `attachmentPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件路径',
  `uploadTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传时间',
  `examineVerifyTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核时间',
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段1',
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段2',
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段3',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employeeId`(`employeeId`) USING BTREE,
  CONSTRAINT `employee_fjfb_ibfk_1` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of employee_fjfb
-- ----------------------------

-- ----------------------------
-- Table structure for employee_grade
-- ----------------------------
DROP TABLE IF EXISTS `employee_grade`;
CREATE TABLE `employee_grade`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工员级别表',
  `grade_num` tinyint(4) NULL DEFAULT NULL,
  `grade_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `grade_desc` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of employee_grade
-- ----------------------------
INSERT INTO `employee_grade` VALUES (1, 1, '一级', NULL);
INSERT INTO `employee_grade` VALUES (2, 2, '二级', NULL);
INSERT INTO `employee_grade` VALUES (3, 3, '三级', NULL);
INSERT INTO `employee_grade` VALUES (4, 4, '四级', NULL);
INSERT INTO `employee_grade` VALUES (5, 5, '五级', NULL);
INSERT INTO `employee_grade` VALUES (6, 6, '六级', NULL);
INSERT INTO `employee_grade` VALUES (7, 7, '七级', NULL);
INSERT INTO `employee_grade` VALUES (8, 8, '8级', NULL);
INSERT INTO `employee_grade` VALUES (9, 9, '九级', NULL);
INSERT INTO `employee_grade` VALUES (10, 10, '十级', NULL);
INSERT INTO `employee_grade` VALUES (11, 11, '十一级', NULL);

-- ----------------------------
-- Table structure for executerecord
-- ----------------------------
DROP TABLE IF EXISTS `executerecord`;
CREATE TABLE `executerecord`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `empId` int(10) NULL DEFAULT NULL COMMENT '外键   员工ID',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行内容',
  `executeTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行执的时间  插入此数据时间',
  `entityId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'entityname实体表的id  ',
  `entityName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实体名',
  `seenEmpId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '已经查看过此信息的员工id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `empId`(`empId`) USING BTREE,
  CONSTRAINT `executerecord_ibfk_1` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 54778 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of executerecord
-- ----------------------------
INSERT INTO `executerecord` VALUES (54713, 15, '登陆了系统。', '2016-04-13 14:57:54', '1', 'Users', '');
INSERT INTO `executerecord` VALUES (54714, 15, '登陆了系统。', '2016-04-13 16:59:18', '1', 'Users', '');
INSERT INTO `executerecord` VALUES (54715, 13, '登陆了系统。', '2016-04-13 17:35:56', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54716, 13, '登陆了系统。', '2016-04-13 17:36:19', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54717, 13, '登陆了系统。', '2016-04-13 18:19:04', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54718, 13, '登陆了系统。', '2016-04-15 18:11:00', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54719, 13, '登陆了系统。', '2016-04-15 18:22:27', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54720, 13, '登陆了系统。', '2016-04-18 15:46:39', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54721, 13, '登陆了系统。', '2016-04-19 16:09:42', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54722, 13, '登陆了系统。', '2016-04-23 05:06:23', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54723, 13, '登陆了系统。', '2016-05-04 13:10:25', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54724, 13, '登陆了系统。', '2016-05-04 13:11:37', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54725, 13, '登陆了系统。', '2024-10-29 01:22:55', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54726, 13, '登陆了系统。', '2024-10-29 01:30:39', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54727, 13, '登陆了系统。', '2024-10-29 01:35:25', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54728, 13, '登陆了系统。', '2024-10-29 01:52:51', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54729, 15, '登陆了系统。', '2024-10-29 10:29:12', '1', 'Users', '');
INSERT INTO `executerecord` VALUES (54730, 15, '添加了一个员工信息。', '2024-10-29 12:35:31', '323', 'Employee', '');
INSERT INTO `executerecord` VALUES (54731, 15, '登陆了系统。', '2024-10-29 12:51:54', '1', 'Users', '');
INSERT INTO `executerecord` VALUES (54732, 15, '修改了一个员工的信息。', '2024-10-29 15:05:04', '323', 'Employee', '');
INSERT INTO `executerecord` VALUES (54733, 323, '登陆了系统。', '2024-10-29 15:06:07', '292', 'Users', '');
INSERT INTO `executerecord` VALUES (54734, 323, '登陆了系统。', '2024-10-29 15:06:58', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54735, 323, '登陆了系统。', '2024-10-29 15:20:26', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54736, 323, '登陆了系统。', '2024-10-29 15:27:33', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54737, 323, '登陆了系统。', '2024-10-29 15:29:18', '292', 'Users', '');
INSERT INTO `executerecord` VALUES (54738, 15, '登陆了系统。', '2024-10-29 15:38:41', '1', 'Users', '');
INSERT INTO `executerecord` VALUES (54739, 15, '登陆了系统。', '2024-10-29 15:45:13', '1', 'Users', '');
INSERT INTO `executerecord` VALUES (54740, 13, '登陆了系统。', '2024-10-29 15:45:51', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54741, 13, '登陆了系统。', '2024-10-29 15:52:01', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54742, 323, '登陆了系统。', '2024-10-29 16:02:16', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54743, 323, '登陆了系统。', '2024-10-29 16:22:36', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54744, 323, '登陆了系统。', '2024-10-29 16:27:03', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54745, 323, '登陆了系统。', '2024-10-29 16:27:14', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54746, 323, '登陆了系统。', '2024-10-29 16:28:55', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54747, 323, '登陆了系统。', '2024-10-29 16:29:37', '292', 'Users', '');
INSERT INTO `executerecord` VALUES (54748, 15, '登陆了系统。', '2025-01-08 12:54:34', '1', 'Users', '');
INSERT INTO `executerecord` VALUES (54749, 13, '登陆了系统。', '2025-01-08 12:55:57', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54750, 13, '登陆了系统。', '2025-06-04 09:09:32', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54751, 13, '登陆了系统。', '2025-06-04 09:10:14', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54752, 13, '登陆了系统。', '2025-06-06 10:01:12', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54753, 13, '登陆了系统。', '2025-06-06 15:22:12', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54754, 13, '登陆了系统。', '2025-06-06 17:29:16', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54755, 13, '登陆了系统。', '2025-06-06 17:30:01', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54756, 323, '登陆了系统。', '2025-06-06 17:35:32', '292', 'Users', '');
INSERT INTO `executerecord` VALUES (54757, 323, '登陆了系统。', '2025-06-06 17:45:20', '292', 'Users', '');
INSERT INTO `executerecord` VALUES (54758, 323, '登陆了系统。', '2025-06-06 17:46:01', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54759, 13, '登陆了系统。', '2025-06-06 17:52:24', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54760, 13, '登陆了系统。', '2025-06-07 11:13:24', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54761, 13, '登陆了系统。', '2025-06-07 12:04:06', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54762, 13, '登陆了系统。', '2025-06-07 12:24:21', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54763, 13, '登陆了系统。', '2025-06-07 13:18:34', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54764, 13, '登陆了系统。', '2025-06-08 10:16:12', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54765, 13, '添加了一个部门信息。', '2025-06-08 10:28:35', '172', 'Department', '');
INSERT INTO `executerecord` VALUES (54766, 13, '修改了一个员工的信息。', '2025-06-08 14:43:22', '323', 'Employee', '');
INSERT INTO `executerecord` VALUES (54767, 13, '修改了一个员工的信息。', '2025-06-08 14:45:45', '13', 'Employee', '');
INSERT INTO `executerecord` VALUES (54768, 13, '登陆了系统。', '2025-06-12 14:18:25', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54769, 13, '登陆了系统。', '2025-06-16 14:32:09', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54770, 13, '登陆了系统。', '2025-06-16 14:40:32', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54771, 13, '登陆了系统。', '2025-06-23 12:53:37', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54772, 13, '登陆了系统。', '2025-06-24 23:27:48', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54773, 13, '登陆了系统。', '2025-06-30 16:16:01', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54774, 13, '登陆了系统。', '2025-06-30 16:16:14', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54775, 13, '登陆了系统。', '2025-06-30 16:18:39', NULL, 'Users', '');
INSERT INTO `executerecord` VALUES (54776, 13, '登陆了系统。', '2025-07-30 13:05:59', '291', 'Users', '');
INSERT INTO `executerecord` VALUES (54777, 13, '登陆了系统。', '2026-10-21 19:08:11', '291', 'Users', '');

-- ----------------------------
-- Table structure for fa_cms_admin
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_admin`;
CREATE TABLE `fa_cms_admin`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `admin_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `flag` int(11) NULL DEFAULT NULL COMMENT '删除标识',
  `admin_status` int(11) NULL DEFAULT NULL COMMENT '开通标识0 1',
  `righttree` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `regdate` datetime NULL DEFAULT NULL,
  `deptid` int(11) NULL DEFAULT NULL,
  `id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_admin
-- ----------------------------
INSERT INTO `fa_cms_admin` VALUES (1, 'zhangsan', 'f71BjFfPqgdRbRNi3LIn5Q%3D%3D', 0, 0, '', 'aa@163.com', '2011-12-12 00:00:00', 1, NULL);
INSERT INTO `fa_cms_admin` VALUES (2, 'admin', 'f71BjFfPqgdRbRNi3LIn5Q%3D%3D', 0, 0, NULL, 'bbc@163.com', '2013-07-22 10:23:45', 29, NULL);
INSERT INTO `fa_cms_admin` VALUES (3, 'lisi', 'f71BjFfPqgdRbRNi3LIn5Q%3D%3D', 0, 1, '0', '163@.com', '2012-09-04 00:00:00', 29, NULL);
INSERT INTO `fa_cms_admin` VALUES (4, 'wangbadan', 'f71BjFfPqgdRbRNi3LIn5Q%3D%3D', 0, 1, '1', '222@aa.com', '2012-09-07 10:46:08', 29, NULL);
INSERT INTO `fa_cms_admin` VALUES (5, 'mazi', 'f71BjFfPqgdRbRNi3LIn5Q%3D%3D', 0, 0, NULL, '123@qq.com', '2012-09-07 10:45:42', 29, NULL);
INSERT INTO `fa_cms_admin` VALUES (6, 'wwu', 'GxM98ybiwY9z3M%2B%2BpAcZwQ%3D%3D', 0, 0, NULL, 'ww@fd.com', '2012-09-07 17:08:29', 33, NULL);
INSERT INTO `fa_cms_admin` VALUES (7, 'zhaoliu', 'GxM98ybiwY9z3M%2B%2BpAcZwQ%3D%3D', 0, 0, NULL, 'zh@sina.com', '2012-09-07 17:07:33', 80, NULL);
INSERT INTO `fa_cms_admin` VALUES (8, '14001', 'f71BjFfPqgdRbRNi3LIn5Q%3D%3D', 0, 0, NULL, '419718285@qq.com', '2013-03-23 00:00:00', 30, NULL);
INSERT INTO `fa_cms_admin` VALUES (9, 'zy', 'f71BjFfPqgdRbRNi3LIn5Q%3D%3D', 0, 0, NULL, '1194922384@qq.com', '2013-07-16 14:27:31', 1, NULL);
INSERT INTO `fa_cms_admin` VALUES (10, 'zhansan', 'f71BjFfPqgdRbRNi3LIn5Q%3D%3D', 0, 1, NULL, 'zhansan@163.com', '2013-07-16 22:04:01', 79, NULL);
INSERT INTO `fa_cms_admin` VALUES (11, 'lengfeng1', 'f71BjFfPqgc%2F%2FV22BSeTSg%3D%3D', 0, 0, NULL, 'leng1@qq.com', '2013-07-16 22:47:03', 116, NULL);

-- ----------------------------
-- Table structure for fa_cms_adminmenu
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_adminmenu`;
CREATE TABLE `fa_cms_adminmenu`  (
  `menuid` int(11) NOT NULL AUTO_INCREMENT,
  `superid` int(11) NULL DEFAULT NULL,
  `modelid` int(11) NULL DEFAULT NULL,
  `menuname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menuengname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menuico` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menuurl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menutarget` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `memo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `regdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editdate` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`menuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_adminmenu
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_adminmodel
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_adminmodel`;
CREATE TABLE `fa_cms_adminmodel`  (
  `modelid` int(11) NOT NULL AUTO_INCREMENT,
  `modelname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modelalias` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modelico` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modelurl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `regdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editdate` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`modelid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_adminmodel
-- ----------------------------
INSERT INTO `fa_cms_adminmodel` VALUES (6, '管理员列表', 'glytj', '010101', 'sysAdmin.jsp', NULL, '2012-09-04 00:00:00');
INSERT INTO `fa_cms_adminmodel` VALUES (31, '技术部', 'jsb', '010000', '', NULL, '2012-09-05 00:00:00');
INSERT INTO `fa_cms_adminmodel` VALUES (32, '系统管理', 'xtgl', '010100', '', NULL, '2012-09-05 00:00:00');
INSERT INTO `fa_cms_adminmodel` VALUES (33, '个人资料', 'grzl', '010104', 'selfinfo.jsp', NULL, '2013-07-18 00:00:00');
INSERT INTO `fa_cms_adminmodel` VALUES (56, '添加模块', 'tjmk', '010102', 'modeladd.jsp', NULL, '2012-10-22 18:53:37');
INSERT INTO `fa_cms_adminmodel` VALUES (57, '模块管理', 'mkgl', '010103', 'adminmodel.jsp', NULL, '2012-10-22 18:57:02');
INSERT INTO `fa_cms_adminmodel` VALUES (58, '信息管理', 'lxsl', '010200', '', NULL, '2012-10-22 00:00:00');
INSERT INTO `fa_cms_adminmodel` VALUES (59, '文章管理', 'wzgl', '010201', 'paperManage.jsp', NULL, '2012-10-22 19:14:03');
INSERT INTO `fa_cms_adminmodel` VALUES (60, '栏目管理', 'lmgl', '010202', 'titleManage.jsp', NULL, '2012-10-22 19:15:38');
INSERT INTO `fa_cms_adminmodel` VALUES (61, '文章发布', 'wzfb', '010203', 'paperOut.jsp', NULL, '2012-10-22 19:17:17');
INSERT INTO `fa_cms_adminmodel` VALUES (62, '留言审核', 'lysh', '010204', 'commentsCheck.jsp', NULL, '2012-10-22 00:00:00');
INSERT INTO `fa_cms_adminmodel` VALUES (63, '推荐配置', 'tjpz', '010205', 'putDeploy.jsp', NULL, '2012-10-22 19:21:24');
INSERT INTO `fa_cms_adminmodel` VALUES (64, '模板列表', 'mmvv', '010206', '../getAllListTemplate.do', NULL, '2012-10-22 19:23:10');
INSERT INTO `fa_cms_adminmodel` VALUES (65, '推荐列表', 'xxtj', '010207', 'infomationOut.jsp', NULL, '2012-10-23 14:41:58');
INSERT INTO `fa_cms_adminmodel` VALUES (67, '文章审核', 'wzsh', '010208', 'paperCheck.jsp', NULL, '2013-07-18 00:00:00');
INSERT INTO `fa_cms_adminmodel` VALUES (68, '模板编辑', 'mbbj', '010209', 'templateconfig.jsp', NULL, '2013-07-23 00:00:00');

-- ----------------------------
-- Table structure for fa_cms_adminright
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_adminright`;
CREATE TABLE `fa_cms_adminright`  (
  `rightid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `modelid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menuid` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editdate` date NULL DEFAULT NULL,
  PRIMARY KEY (`rightid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 158 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_adminright
-- ----------------------------
INSERT INTO `fa_cms_adminright` VALUES (88, 2, '6', NULL, '2012-09-06');
INSERT INTO `fa_cms_adminright` VALUES (89, 2, '32', NULL, '2012-09-06');
INSERT INTO `fa_cms_adminright` VALUES (90, 2, '31', NULL, '2012-09-06');
INSERT INTO `fa_cms_adminright` VALUES (125, 2, '56', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (126, 2, '57', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (127, 2, '58', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (128, 2, '59', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (129, 2, '60', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (130, 2, '61', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (131, 2, '62', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (132, 2, '63', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (133, 2, '64', NULL, '2012-10-22');
INSERT INTO `fa_cms_adminright` VALUES (134, 2, '65', NULL, '2012-10-23');
INSERT INTO `fa_cms_adminright` VALUES (135, 9, '59', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (136, 9, '58', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (137, 9, '57', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (138, 9, '56', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (139, 9, '6', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (140, 9, '32', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (141, 9, '31', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (142, 9, '64', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (143, 9, '65', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (144, 9, '62', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (145, 9, '63', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (146, 9, '60', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (147, 9, '61', NULL, '2013-07-16');
INSERT INTO `fa_cms_adminright` VALUES (148, 10, '59', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (149, 10, '58', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (150, 10, '6', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (151, 10, '32', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (152, 10, '62', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (153, 10, '60', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (154, 10, '61', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (155, 2, '67', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (156, 2, '33', NULL, '2013-07-17');
INSERT INTO `fa_cms_adminright` VALUES (157, 2, '68', NULL, '2013-07-17');

-- ----------------------------
-- Table structure for fa_cms_classes
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_classes`;
CREATE TABLE `fa_cms_classes`  (
  `classid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'CMS类型表',
  `userid` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `superid` int(11) NULL DEFAULT NULL COMMENT '父ID',
  `isout` int(11) NULL DEFAULT 0 COMMENT '是否外链',
  `showflag` int(11) NULL DEFAULT 0 COMMENT '是否显示',
  `classname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名',
  `outpath` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外链路径',
  `engname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文名',
  `sonclass` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子类|id|id|id|',
  `namedrules` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '态静文件命名规则',
  `fatherclass` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父类型类型|fid|fid|fid|',
  `fatherpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `regdate` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册日期',
  `editdate` datetime NULL DEFAULT NULL COMMENT '编辑日期',
  `islastest` int(11) NULL DEFAULT 0 COMMENT '是否最新 默认为0',
  `delflag` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除',
  `ismember` tinyint(4) NULL DEFAULT 0 COMMENT '0 是否是客户发表 ',
  PRIMARY KEY (`classid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_classes
-- ----------------------------
INSERT INTO `fa_cms_classes` VALUES (1, 1, 0, 0, 0, '恩德', '', 'ender', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (38, NULL, 1, 0, 0, '首页', '输入外链地址', 'firstpage', NULL, NULL, NULL, NULL, '2013-07-08 14:59:15', '2013-07-08 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (39, NULL, 1, 0, 0, '产品中心', '输入外链地址', 'productcenter', NULL, NULL, NULL, NULL, '2013-07-08 15:00:26', '2013-07-08 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (40, NULL, 1, 0, 0, '关于我们', '输入外链地址', 'aboutus', NULL, NULL, NULL, NULL, '2013-07-08 15:00:59', '2013-07-08 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (41, NULL, 1, 0, 0, '行业动态', '输入外链地址', 'industrynews', NULL, NULL, NULL, NULL, '2013-07-08 15:11:03', '2013-07-08 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (42, NULL, 39, 0, 0, '酒店地毯', '输入外链地址', 'htotelcarpet', NULL, NULL, NULL, NULL, NULL, '2013-08-03 10:51:00', 199, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (43, NULL, 39, 0, 0, 'KTV地毯', '输入外链地址', 'ktv', NULL, NULL, NULL, NULL, NULL, '2013-08-03 10:26:00', 199, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (44, NULL, 39, 0, 0, 'S型防滑地毯', '输入外链地址', 'scarpet', NULL, NULL, NULL, NULL, '2013-07-09 10:03:40', '2013-08-14 14:37:00', 6, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (45, NULL, 39, 0, 0, '3A地毯', '输入外链地址', 'acarpet', NULL, NULL, NULL, NULL, NULL, '2013-08-03 10:19:00', 199, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (46, NULL, 39, 0, 0, '花底地毯', '输入外链地址', 'bottomcarpet', NULL, NULL, NULL, NULL, NULL, '2013-08-03 10:20:00', 198, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (47, NULL, 39, 0, 0, '坑纹地毯', '输入外链地址', 'pitcarpet', NULL, NULL, NULL, NULL, NULL, '2013-08-03 10:20:00', 197, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (48, NULL, 39, 0, 1, '汽车地毯', '输入外链地址', 'carcarpet', NULL, NULL, NULL, NULL, NULL, '2013-08-03 10:20:00', 196, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (49, NULL, 39, 0, 0, '3M地毯', '输入外链地址', '3mcarpet', NULL, NULL, NULL, NULL, '2013-07-09 10:03:40', '2013-07-09 10:14:17', 127, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (50, NULL, 41, 0, 0, '地毯文化', '输入外链地址', 'carpetcultures', NULL, NULL, NULL, NULL, '2013-07-09 10:03:40', '2013-07-09 10:14:17', NULL, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (51, NULL, 41, 0, 0, '地毯知识', '输入外链地址', 'carpetknow', NULL, NULL, NULL, NULL, '2013-07-09 10:03:40', '2013-07-09 10:14:17', NULL, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (53, NULL, 41, 0, 0, '行业新闻', '输入外链地址', 'industrynews', NULL, NULL, NULL, NULL, '2013-07-16 00:25:37', '2013-07-16 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (66, NULL, 39, 0, 0, '办公室地毯', '输入外链地址', 'office', NULL, NULL, NULL, NULL, '2013-07-16 16:45:31', '2013-07-16 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes` VALUES (75, NULL, 1, 0, 0, '1231434', '输入外链地址', 'aaass', NULL, NULL, NULL, NULL, NULL, '2013-08-03 10:16:00', 88, 1, NULL);
INSERT INTO `fa_cms_classes` VALUES (76, NULL, 39, 0, 1, '测试', '输入外链地址', 'ces', NULL, NULL, NULL, NULL, '2013-08-14 14:32', '2013-08-14 14:34:00', 0, 1, NULL);

-- ----------------------------
-- Table structure for fa_cms_classes_copy
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_classes_copy`;
CREATE TABLE `fa_cms_classes_copy`  (
  `classid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'CMS类型表',
  `userid` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `superid` int(11) NULL DEFAULT NULL COMMENT '父ID',
  `isout` int(11) NULL DEFAULT 0 COMMENT '是否外链',
  `showflag` int(11) NULL DEFAULT 0 COMMENT '是否显示',
  `classname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名',
  `outpath` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外链路径',
  `engname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文名',
  `sonclass` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子类|id|id|id|',
  `namedrules` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '态静文件命名规则',
  `fatherclass` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父类型类型|fid|fid|fid|',
  `fatherpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `regdate` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册日期',
  `editdate` datetime NULL DEFAULT NULL COMMENT '编辑日期',
  `islastest` tinyint(4) NULL DEFAULT 0 COMMENT '是否最新 默认为0',
  `delflag` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除',
  `ismember` tinyint(4) NULL DEFAULT 0 COMMENT '0 是否是客户发表 ',
  PRIMARY KEY (`classid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_classes_copy
-- ----------------------------
INSERT INTO `fa_cms_classes_copy` VALUES (1, 1, 0, 0, 0, '新闻', '', 'news', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (2, 1, 0, 0, 0, '产品', '', 'product', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (3, 1, 0, 0, 0, '影视', '', 'movie', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (4, 1, 0, 0, 0, '音乐', '', 'music', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (5, 1, 0, 0, 0, '下载', '', 'download', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (10, NULL, 0, 0, 0, 'fdsafdsa', NULL, 'fdsafdsa', NULL, NULL, NULL, NULL, '2012-08-24 19:04:32', '2012-08-24 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (11, NULL, 0, 0, 0, 'fdsafdsa', NULL, 'fdsafdsa', NULL, NULL, NULL, NULL, '2012-08-24 19:06:43', '2012-08-24 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (12, NULL, 0, 0, 0, '综艺节目', NULL, 'abc', NULL, NULL, NULL, NULL, '2012-08-24 19:07:23', '2012-08-24 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (13, NULL, 0, 0, 0, '综艺节目', NULL, 'abc', NULL, NULL, NULL, NULL, '2012-08-24 19:21:31', '2012-08-24 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (14, NULL, 0, 0, 0, '科技教育', NULL, 'tech', NULL, NULL, NULL, NULL, '2012-08-25 09:10:59', '2012-08-25 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (15, NULL, 410, 0, 0, 'dstg', NULL, 'ertge', NULL, NULL, NULL, NULL, '2012-08-25 14:55:34', '2012-08-25 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (16, NULL, 5, 1, 1, '让他一人', 'www.baidu.com', 'fdhdfhdh', NULL, NULL, NULL, NULL, '2012-08-25 16:52:26', '2012-08-25 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (17, NULL, NULL, 1, 0, '明星动态', '', 'aa', NULL, NULL, NULL, NULL, '2012-08-27 09:23:52', '2012-08-27 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (18, NULL, 1, 0, 1, '新影片发布', '', 'asd', NULL, NULL, NULL, NULL, '2012-08-27 09:24:48', '2012-08-27 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (19, NULL, 1, 1, 0, 'qqq', 'qq', 'qqq', NULL, NULL, NULL, NULL, '2012-08-27 09:27:32', '2012-08-27 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (20, NULL, 1, 0, 1, 'JDK', '', 'JDK', NULL, NULL, NULL, NULL, '2012-08-27 09:37:44', '2012-08-27 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (21, NULL, 11, NULL, 0, 'sd', '输入外链地址', 'asda', NULL, NULL, NULL, NULL, '2012-08-27 10:11:49', '2012-08-27 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (22, NULL, 23, 0, 0, 'sdd', '输入外链地址', 'dsfs', NULL, NULL, NULL, NULL, '2012-08-27 10:14:36', '2012-08-27 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (23, NULL, NULL, 0, 0, '新', '输入外链地址', 'as', NULL, NULL, NULL, NULL, '2012-08-31 10:31:42', '2012-08-31 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (24, NULL, NULL, 0, 1, '新', '输入外链地址', 'as', NULL, NULL, NULL, NULL, '2012-08-31 10:32:26', '2012-08-31 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (25, NULL, NULL, 1, 1, '明星', '输入外链地址', 'axx', NULL, NULL, NULL, NULL, '2012-08-31 10:32:45', '2012-08-31 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (26, NULL, NULL, 1, 0, '明星的', '输入外链地址', 'ssss', NULL, NULL, NULL, NULL, '2012-08-31 11:30:44', '2012-08-31 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (27, NULL, NULL, 0, 0, '三星', '输入外链地址', 'sx', NULL, NULL, NULL, NULL, '2012-08-31 11:31:29', '2012-08-31 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (28, NULL, NULL, 0, 1, '下载', '输入外链地址', 'download', NULL, NULL, NULL, NULL, '2012-09-01 10:32:18', '2012-09-01 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy` VALUES (29, NULL, NULL, 0, 1, '玩儿', '输入外链地址', 'ewstwwer', NULL, NULL, NULL, NULL, '2012-09-01 10:49:12', '2012-09-01 00:00:00', NULL, 0, NULL);

-- ----------------------------
-- Table structure for fa_cms_classes_copy1
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_classes_copy1`;
CREATE TABLE `fa_cms_classes_copy1`  (
  `classid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'CMS类型表',
  `userid` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `superid` int(11) NULL DEFAULT NULL COMMENT '父ID',
  `isout` int(11) NULL DEFAULT 0 COMMENT '是否外链',
  `showflag` int(11) NULL DEFAULT 0 COMMENT '是否显示',
  `classname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名',
  `outpath` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外链路径',
  `engname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文名',
  `sonclass` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子类|id|id|id|',
  `namedrules` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '态静文件命名规则',
  `fatherclass` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父类型类型|fid|fid|fid|',
  `fatherpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `regdate` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册日期',
  `editdate` datetime NULL DEFAULT NULL COMMENT '编辑日期',
  `islastest` tinyint(4) NULL DEFAULT 0 COMMENT '是否最新 默认为0',
  `delflag` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除',
  `ismember` tinyint(4) NULL DEFAULT 0 COMMENT '0 是否是客户发表 ',
  PRIMARY KEY (`classid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_classes_copy1
-- ----------------------------
INSERT INTO `fa_cms_classes_copy1` VALUES (1, 1, 0, 0, 0, '新闻', '', 'news', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (2, 1, 0, 0, 0, '产品', '', 'product', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (3, 1, 0, 0, 0, '影视', '', 'movie', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (4, 1, 0, 0, 0, '音乐', '', 'music', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (5, 1, 0, 0, 0, '下载', '', 'download', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (10, NULL, 0, 0, 0, 'fdsafdsa', NULL, 'fdsafdsa', NULL, NULL, NULL, NULL, '2012-08-24 19:04:32', '2012-08-24 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (11, NULL, 0, 0, 0, 'fdsafdsa', NULL, 'fdsafdsa', NULL, NULL, NULL, NULL, '2012-08-24 19:06:43', '2012-08-24 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (12, NULL, 0, 0, 0, '综艺节目', NULL, 'abc', NULL, NULL, NULL, NULL, '2012-08-24 19:07:23', '2012-08-24 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (13, NULL, 0, 0, 0, '综艺节目', NULL, 'abc', NULL, NULL, NULL, NULL, '2012-08-24 19:21:31', '2012-08-24 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (14, NULL, 0, 0, 0, '科技教育', NULL, 'tech', NULL, NULL, NULL, NULL, '2012-08-25 09:10:59', '2012-08-25 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (15, NULL, 410, 0, 0, 'dstg', NULL, 'ertge', NULL, NULL, NULL, NULL, '2012-08-25 14:55:34', '2012-08-25 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (16, NULL, 5, 1, 1, '让他一人', 'www.baidu.com', 'fdhdfhdh', NULL, NULL, NULL, NULL, '2012-08-25 16:52:26', '2012-08-25 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (17, NULL, NULL, 1, 0, '明星动态', '', 'aa', NULL, NULL, NULL, NULL, '2012-08-27 09:23:52', '2012-08-27 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (18, NULL, 1, 0, 1, '新影片发布', '', 'asd', NULL, NULL, NULL, NULL, '2012-08-27 09:24:48', '2012-08-27 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (19, NULL, 1, 1, 0, 'qqq', 'qq', 'qqq', NULL, NULL, NULL, NULL, '2012-08-27 09:27:32', '2012-08-27 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (20, NULL, 1, 0, 1, 'JDK', '', 'JDK', NULL, NULL, NULL, NULL, '2012-08-27 09:37:44', '2012-08-27 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (21, NULL, 11, NULL, 0, 'sd', '输入外链地址', 'asda', NULL, NULL, NULL, NULL, '2012-08-27 10:11:49', '2012-08-27 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (22, NULL, 23, 0, 0, 'sdd', '输入外链地址', 'dsfs', NULL, NULL, NULL, NULL, '2012-08-27 10:14:36', '2012-08-27 00:00:00', NULL, NULL, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (23, NULL, NULL, 0, 0, '新', '输入外链地址', 'as', NULL, NULL, NULL, NULL, '2012-08-31 10:31:42', '2012-08-31 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (24, NULL, NULL, 0, 1, '新', '输入外链地址', 'as', NULL, NULL, NULL, NULL, '2012-08-31 10:32:26', '2012-08-31 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (25, NULL, NULL, 1, 1, '明星', '输入外链地址', 'axx', NULL, NULL, NULL, NULL, '2012-08-31 10:32:45', '2012-08-31 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (26, NULL, NULL, 1, 0, '明星的', '输入外链地址', 'ssss', NULL, NULL, NULL, NULL, '2012-08-31 11:30:44', '2012-08-31 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (27, NULL, NULL, 0, 0, '三星', '输入外链地址', 'sx', NULL, NULL, NULL, NULL, '2012-08-31 11:31:29', '2012-08-31 00:00:00', NULL, 0, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (28, NULL, NULL, 0, 1, '下载', '输入外链地址', 'download', NULL, NULL, NULL, NULL, '2012-09-01 10:32:18', '2012-09-01 00:00:00', NULL, 1, NULL);
INSERT INTO `fa_cms_classes_copy1` VALUES (29, NULL, NULL, 0, 1, '玩儿', '输入外链地址', 'ewstwwer', NULL, NULL, NULL, NULL, '2012-09-01 10:49:12', '2012-09-01 00:00:00', NULL, 0, NULL);

-- ----------------------------
-- Table structure for fa_cms_content_comment
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_content_comment`;
CREATE TABLE `fa_cms_content_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `cid` int(11) NULL DEFAULT NULL COMMENT '文章id',
  `sid` int(11) NULL DEFAULT NULL COMMENT '用户id(发送者id)为空为匿名',
  `sname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `is_self` tinyint(4) NULL DEFAULT NULL COMMENT '是否是对评论进行回复 默认 0 不是 1是',
  `tid` int(11) NULL DEFAULT NULL COMMENT '目标id(默认是文章id,其次是评论id)',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复内容',
  `sendtime` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `ipaddress` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址 记录用户ip',
  `score` int(11) NULL DEFAULT NULL COMMENT '如csdn可以评分',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '审核状态，某些不合法的需要屏蔽 管理员操作 默认0待审核(初始提交) 1 审核中(如有有接受功能的话) 2 审核失败(禁言)  9审核通过',
  `auditname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_content_comment
-- ----------------------------
INSERT INTO `fa_cms_content_comment` VALUES (2, 1, 1, '客户', NULL, 0, '空间', '2012-08-29 00:00:00', NULL, NULL, 2, NULL);
INSERT INTO `fa_cms_content_comment` VALUES (3, 2, 1, '非同凡响', NULL, 0, '可耕地', '2012-08-29 00:00:00', NULL, NULL, 2, NULL);
INSERT INTO `fa_cms_content_comment` VALUES (4, 3, 1, '额', NULL, 0, '染发', '2012-08-27 00:00:00', NULL, NULL, 2, NULL);
INSERT INTO `fa_cms_content_comment` VALUES (5, 5, 1, '俄国人', NULL, 0, '儿童', '2012-08-27 16:47:45', NULL, NULL, 2, NULL);

-- ----------------------------
-- Table structure for fa_cms_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_guestbook`;
CREATE TABLE `fa_cms_guestbook`  (
  `gid` int(11) NOT NULL AUTO_INCREMENT COMMENT '作者',
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ipaddr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `contents` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `datetime` datetime NULL DEFAULT NULL,
  `vid` int(11) NULL DEFAULT NULL,
  `isshow` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否显示',
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_guestbook
-- ----------------------------

-- ----------------------------
-- Table structure for fa_cms_member
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_member`;
CREATE TABLE `fa_cms_member`  (
  `userid` int(11) NOT NULL AUTO_INCREMENT COMMENT '成员表',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `rnd` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `registertime` datetime NOT NULL DEFAULT '1900-01-01 00:00:00' COMMENT '注册时间',
  `groupid` smallint(6) NOT NULL DEFAULT 0 COMMENT '组ID',
  `userfen` int(11) NOT NULL DEFAULT 0,
  `userdate` int(11) NOT NULL DEFAULT 0 COMMENT '用户创建时间',
  `money` float(11, 2) NOT NULL DEFAULT 0.00 COMMENT '金额',
  `havemsg` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否有消息',
  `checked` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否查看',
  `salt` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_cms_member
-- ----------------------------
INSERT INTO `fa_cms_member` VALUES (1, 'lengfeng847', 'b206e95a4384298962649e58dc7b39d4', 'u4CKciq8989Z', 'lengzhiyong847@163.com', '2011-04-27 11:17:45', 1, 0, 0, 0.00, 0, 1, '');

-- ----------------------------
-- Table structure for fa_cms_memberfp
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_memberfp`;
CREATE TABLE `fa_cms_memberfp`  (
  `fid` smallint(6) NOT NULL AUTO_INCREMENT,
  `f` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fform` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fhtml` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fzs` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `myorder` smallint(6) NOT NULL DEFAULT 0,
  `ftype` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `flen` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fvalue` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fformsize` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`fid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_cms_memberfp
-- ----------------------------
INSERT INTO `fa_cms_memberfp` VALUES (1, 'truename', '真实姓名', 'text', '\r\n<input name=\"truename\" type=\"text\" id=\"truename\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($addr[truename]))?>\">\r\n', '', 1, 'VARCHAR', '20', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (2, 'oicq', 'QQ号码', 'text', '<input name=\\\"oicq\\\" type=\\\"text\\\" id=\\\"oicq\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($addr[oicq]))?>\\\">\r\n', '', 5, 'VARCHAR', '25', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (3, 'msn', 'MSN', 'text', '<input name=\\\"msn\\\" type=\\\"text\\\" id=\\\"msn\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($addr[msn]))?>\\\">\r\n', '', 6, 'VARCHAR', '120', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (4, 'call', '联系电话', 'text', '<input name=\\\"call\\\" type=\\\"text\\\" id=\\\"call\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($addr[call]))?>\\\">\r\n', '', 2, 'VARCHAR', '30', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (5, 'phone', '手机', 'text', '<input name=\\\"phone\\\" type=\\\"text\\\" id=\\\"phone\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($addr[phone]))?>\\\">\r\n', '', 4, 'VARCHAR', '30', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (6, 'address', '联系地址', 'text', '<input name=\\\"address\\\" type=\\\"text\\\" id=\\\"address\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($addr[address]))?>\\\" size=\\\"50\\\">\r\n', '', 9, 'VARCHAR', '255', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (7, 'zip', '邮编', 'text', '<input name=\\\"zip\\\" type=\\\"text\\\" id=\\\"zip\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($addr[zip]))?>\\\" size=\\\"8\\\">\r\n', '', 10, 'VARCHAR', '8', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (9, 'homepage', '网址', 'text', '\r\n<input name=\"homepage\" type=\"text\" id=\"homepage\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($addr[homepage]))?>\">\r\n', '', 7, 'VARCHAR', '200', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (10, 'saytext', '简介', 'textarea', '<textarea name=\\\"saytext\\\" cols=\\\"65\\\" rows=\\\"10\\\" id=\\\"saytext\\\"><?=$ecmsfirstpost==1?\\\"\\\":stripSlashes($addr[saytext])?></textarea>\r\n', '', 11, 'TEXT', '', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (11, 'company', '公司名称', 'text', '<input name=\\\"company\\\" type=\\\"text\\\" id=\\\"company\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($addr[company]))?>\\\" size=\\\"38\\\">\r\n', '', 0, 'VARCHAR', '255', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (12, 'fax', '传真', 'text', '\r\n<input name=\"fax\" type=\"text\" id=\"fax\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($addr[fax]))?>\">\r\n', '', 3, 'VARCHAR', '30', '', '', NULL);
INSERT INTO `fa_cms_memberfp` VALUES (13, 'userpic', '会员头像', 'img', '<input type=\\\"file\\\" name=\\\"userpicfile\\\">&nbsp;&nbsp;\r\n<?=empty($addr[userpic])?\\\"\\\":\\\"<img src=\\\'\\\".htmlspecialchars(stripSlashes($addr[userpic])).\\\"\\\' border=0>\\\"?>', '', 8, 'VARCHAR', '200', '', '', NULL);

-- ----------------------------
-- Table structure for fa_cms_membergroup
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_membergroup`;
CREATE TABLE `fa_cms_membergroup`  (
  `groupid` smallint(6) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `level` smallint(6) NOT NULL DEFAULT 0,
  `checked` tinyint(1) NOT NULL DEFAULT 0,
  `favanum` smallint(6) NOT NULL DEFAULT 0,
  `daydown` int(11) NOT NULL DEFAULT 0,
  `msglen` int(11) NOT NULL DEFAULT 0,
  `msgnum` int(11) NOT NULL DEFAULT 0,
  `canreg` tinyint(1) NOT NULL DEFAULT 0,
  `formid` smallint(6) NOT NULL DEFAULT 0,
  `regchecked` tinyint(1) NOT NULL DEFAULT 0,
  `spacestyleid` smallint(6) NOT NULL DEFAULT 0,
  `dayaddinfo` smallint(6) NOT NULL DEFAULT 0,
  `infochecked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`groupid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_cms_membergroup
-- ----------------------------
INSERT INTO `fa_cms_membergroup` VALUES (1, '普通会员', 1, 0, 240, 222, 254, 50, 1, 2, 1, 1, 50, 1);
INSERT INTO `fa_cms_membergroup` VALUES (2, 'VIP会员', 2, 0, 200, 0, 255, 120, 0, 1, 0, 1, 0, 0);
INSERT INTO `fa_cms_membergroup` VALUES (3, '企业会员', 1, 0, 120, 0, 255, 50, 1, 2, 0, 2, 0, 0);
INSERT INTO `fa_cms_membergroup` VALUES (4, '企业VIP会员', 2, 0, 200, 0, 255, 120, 0, 2, 0, 2, 0, 0);

-- ----------------------------
-- Table structure for fa_cms_news
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_news`;
CREATE TABLE `fa_cms_news`  (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `sequence` int(11) NULL DEFAULT 0 COMMENT '排序',
  `classid` int(11) NULL DEFAULT 0 COMMENT 'CMS类型表ID',
  `readnum` char(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阅读数量',
  `keyboard` char(160) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '按键板',
  `userid` int(11) NULL DEFAULT 0 COMMENT '用户ID',
  `username` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户姓名',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '核审状态 0未审核 1审合通过 2审核失败',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `titlepic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头部图片 多个用|分割',
  `titlepic_thumb` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片缩略图 多个用|分割 与上传图片对应',
  `title` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标题',
  `istop` tinyint(1) NULL DEFAULT 0 COMMENT '是否置顶',
  `ismember` tinyint(1) NULL DEFAULT 0 COMMENT '0为管理员 1为会员(默认为0)',
  `ftitle` char(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '副标题',
  `smalltext` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '简介',
  `contents` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `source` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '新闻来源',
  `delflag` tinyint(1) NULL DEFAULT 0 COMMENT '删除限制 1为删除  0 为恢复',
  `showflag` tinyint(1) NULL DEFAULT 1,
  `senddate` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章第一次发布时间',
  `newsdate` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `editdate` datetime NULL DEFAULT NULL COMMENT '编辑日期',
  `hasFile` tinyint(1) NULL DEFAULT NULL,
  `temp` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE,
  INDEX `checked`(`status`) USING BTREE,
  INDEX `classid`(`classid`) USING BTREE,
  CONSTRAINT `FK_class_content` FOREIGN KEY (`classid`) REFERENCES `fa_cms_classes` (`classid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 186 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_news
-- ----------------------------
INSERT INTO `fa_cms_news` VALUES (52, NULL, 51, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '地毯的清理与保养', NULL, NULL, '', '地毯的优点很多，如弹性好、美观、吸音等等，虽然地毯最大的缺点就是打理起来有些麻烦，不过只要及时清理灰尘，保养得当，地毯的使用寿命还是相当长的', '<p><span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">■去污窍门&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　(1)茶水、咖啡、酱油或啤酒等污物：可使用地毯专用清洗液、硼砂液或洗涤液等清洁剂，用毛刷反复清刷即可除掉，然后用清水清洗干净即可。&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　(2)番茄酱、酱汁等黏稠物：可利用餐巾纸之类的吸水性强的物体把污渍吸收、除净，之后用毛刷反复清刷，清水洗净即可。&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　(3)蛋清、牛奶、冰淇淋等脂类物体：先用温水和洗涤液洗刷，然后使用专门的挥发性去油剂除去脂肪。提醒：不能使用热水。因为蛋白质受热容易固化，不易除去积垢，还会使地毯变形。&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　■日常养护&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　在家具的腿部接触地毯处，应放置垫层或经常移动家具；对磨损严重的部位，除采取用覆盖物加以保护外，还可调换位置使用。由于地毯的面层纤维内，易积聚灰尘，最好的方法就是经常用吸尘器沿着顺毛方向吸尘，这样就能保持地毯清洁。&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　专家建议，每周为地毯进行一次吸尘，目前的真空吸尘器有纯粹抽吸式、拍打杆式和鬃刷旋转式三种吸尘方式，均适用于绒头紧密的地毯；而毛圈地毯，只能用有抽吸功能的吸尘器。此外，使用真空吸尘器时的最后一次推动应该顺着绒头方向进行。&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　<br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n值得注意的是，清理时千万别用齿状或边缘粗糙的工具，这样会损坏地毯面层纤维。如地毯出现戗毛，则需用干净毛巾浸湿热水擦拭，并用梳子梳理顺直，用熨斗垫湿布顺毛熨烫，可恢复原状</span></p>', ' ', 0, 1, '2013-07-09 11:01:23', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (53, NULL, 51, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '汽车地毯清洗方法', NULL, NULL, '', ' 汽车里面最容易脏的就是地毯，如果使用毛刷头的吸尘机进行吸尘处理的话，可以使较脏的地毯看上去不那么脏。对于更加脏一些的地毯，就只能动用专用洗涤剂了。', '<p><span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;&nbsp;&nbsp;&nbsp;汽车里面最容易脏的就是地毯，如果使用毛刷头的吸尘机进行吸尘处理的话，可以使较脏的地毯看上去不那么脏。对于更加脏一些的地毯，就只能动用专用洗涤剂了。　&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　一般是在用洗涤剂前先进行上述两项除尘工作，然后喷洒适量的洗涤剂，用刷子刷洗干净，最后用干净的抹布将多余的洗涤剂吸掉就可以了，这样可以使洗后的地毯既干净又跟以前一样的柔软。&nbsp;</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　最需要注意的就是地毯不要完全放入水中浸泡刷洗，一方面会破坏地毯内部几层不同材质的粘接，另一方面会使地毯在很长时间内不能干透而影响使用效果，引起车内潮湿</span></p>', ' ', 0, 1, '2013-07-09 11:03:58', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (54, NULL, 51, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '如何延长地毯的使用寿命', NULL, NULL, '', '在家具的腿部接触地毯处，应放置垫层或经常移动家具;对磨损严重的部位，除采取用覆盖物加以保护外，还可调换位置使用。由于地毯的面层纤维内，易积聚灰尘，最好的方法就是经常用吸尘器沿着顺毛方向吸尘，这样就能保持地毯清洁', '<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">在家具的腿部接触地毯处，应放置垫层或经常移动家具;对磨损严重的部位，除采取用覆盖物加以保护外，还可调换位置使用。由于地毯的面层纤维内，易积聚灰尘，最好的方法就是经常用吸尘器沿着顺毛方向吸尘，这样就能保持地毯清洁。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　专家建议，每周为地毯进行一次吸尘，目前的真空吸尘器有纯粹抽吸式、拍打杆式和鬃刷旋转式三种吸尘方式，均适用于绒头紧密的地毯;而毛圈地毯，只能用有抽吸功能的吸尘器。此外，使用真空吸尘器时的最后一次推动应该顺着绒头方向进行。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　值得注意的是，清理时千万别用齿状或边缘粗糙的工具，这样会损坏地毯面层纤维。如地毯出现戗毛，则需用干净毛巾浸湿热水擦拭，并用梳子梳理顺直，用熨斗垫湿布顺毛熨烫，可恢复原状。</p>', ' ', 0, 0, '2013-07-09 11:05:26', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (55, NULL, 51, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '地毯改变家居风水', NULL, NULL, '', '地毯是改变家居风水最简单的饰品，由于地毯经常覆盖大片面积，在整体效果上占有主导地位，所以除了利用地毯的花色和图案引进好的气场来提升财气外，对于地毯摆放的方位也要特别讲究。', '<p><span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">地毯是改变家居风水最简单的饰品，由于地毯经常覆盖大片面积，在整体效果上占有主导地位，所以除了利用地毯的花色和图案引进好的气场来提升财气外，对于地毯摆放的方位也要特别讲究。</span></p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">沙发前的地毯，其重要性相当于住宅前用以纳气的明堂，也相当于屋前的一块青草地，设置时有以下几点需要注意:</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">１宜选用色彩缤纷的地毯，忌颜色单调的地毯，以红色或金黄色为主色较为吉利；</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">２构图和谐、色彩鲜艳明快的地毯，令人赏心悦目，为最佳选择；</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">３尽量不用色彩单一的地毯，过于冷清，会使客厅显得毫无生气，不利于气的聚集。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><strong>&nbsp;&nbsp;&nbsp;&nbsp; 质地</strong></p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">地毯若采用致密厚实的质地，在冬季能减缓空气的流动，调节室内小气候。地毯的颜色、花样若能搭配得宜，会使厅堂产生不同的气场与空间上的变化。同时，也可运用地毯的色彩使家宅开运。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><strong>&nbsp;&nbsp;&nbsp;&nbsp; 图案</strong></p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">一般图案都有自己的五行属性，如波浪形状五行属水，直条纹属木，星状、棱锥状图案属或，格子图案属土，圆形属金，配合方位与颜色的放置可带来好运势。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><strong>&nbsp;&nbsp;&nbsp; 大门对应方位</strong></p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">如果大门开在南方，开运颜色是红色，因为南方属火，因而在此方摆放直条纹或星状图案的红色地毯，可使家人充满干劲，带来名利双收之效。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">如果大门开在东方、东南方，开运颜色是绿色，因为东方与东南方五行属木，绿色是树木的主颜色，有生气勃勃的意义。在此方铺设波浪图案或直条图案的绿色地毯，对家运与财运有正面的催化作用。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">如果大门开在西南方、东北方，开运颜色是黄色，因为西南方、东北方五行属土，黄色在中国代表着尊贵、财富，同时这个方位是主导智慧与婚姻的，若能在此方位放上星状或各自图案的黄地毯，即能带来旺盛的财运，使婚姻和美。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">如果大门开在西方、西北方，开运颜色是白色、金色，因为白色与金色象征高贵与纯洁，若能在此方位铺放格子图纹或图形的白色或金色地毯，可带来好的贵人运与财运，也可增加小孩的读书运。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">如果大门开在北方，开运颜色是蓝色，因为北方掌管事业，若想找个好工作或想增进事业运，可在客厅的北方放置圆形或波浪圆形的蓝色地毯，有利事业的蓬勃发展。</p>', ' ', 0, 0, '2013-07-09 11:10:43', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (56, NULL, 51, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '选购地毯常识', NULL, NULL, '', '地毯的价格因其所选材质及制作工艺的不同而相差数十倍甚至上百倍，购毯之前若没有一点地毯质料常识，被“斩”的概率可就高了。地毯质料简单说就是三种：天然纤维、人工纤维、天然人工纤维混合。天然纤维有羊毛、真丝、麻、草编等；人造的则以尼龙和聚丙烯较为常见。', '<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">地毯的价格因其所选材质及制作工艺的不同而相差数十倍甚至上百倍，购毯之前若没有一点地毯质料常识，被&ldquo;斩&rdquo;的概率可就高了。地毯质料简单说就是三种：天然纤维、人工纤维、天然人工纤维混合。天然纤维有羊毛、真丝、麻、草编等；人造的则以尼龙和聚丙烯较为常见。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">羊毛、丝质等天然材料手工制作的地毯，具有良好的质感，用起来非常舒适；而化纤地毯则价格实惠，比如埃及进口的优质化纤地毯。脚感最佳的：按传统被视为家居地毯最佳选择的纯羊毛地毯，回弹性最强，能阻挡尘埃，具有防油、阻燃、无毒、无静电的特性，一般附有纯羊毛标记的地毯，均已经过防虫处理，清洁方便。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">价格低廉的：普通人工纤维地毯价格低廉，但往往有易燃和产生静电、吸附尘埃的缺点；但经特殊加工处理的优质人工纤维地毯，如优质尼龙地毯，其柔软的质感和不俗的回弹力，足可媲美羊毛。而且人工纤维不易掉毛，不易吸收液体，质地亦颇坚韧耐磨，而尼龙更因容易染色，所以织造的地毯可以有丰富的图案和色彩变化。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">手工真丝地毯价格最贵，动辄上万，其光泽动人，但牢度欠佳，多用于壁挂装饰，或卧室行走量极少的地方。</p>', ' ', 0, 0, '2013-07-09 11:17:24', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (57, NULL, 51, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '过期牛奶不要扔 保养家具去污又滋润', NULL, NULL, '', '家居生活总能给人带来无限乐趣，但家具保养也往往让人略显劳累。如果略加留心牢记几个家居小常识，生活就会变得趣味横生。\r\n', '<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">家居生活总能给人带来无限乐趣，但家具保养也往往让人略显劳累。如果略加留心牢记几个家居小常识，生活就会变得趣味横生。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">过期牛奶不要扔：保养家具去污又滋润</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">家里常有过期的牛奶，弃之可惜，怎么办呢?用它来保养家具再合适不过，因为牛奶中含有一定量的油脂，因此对于皮具或是木质家具确实有一定的去污、滋润效果。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">操作方法：用一块干净的抹布放到牛奶里浸一下，然后用此抹布擦桌、椅、电视柜等，家具会很有光泽。等牛奶渗透一会儿后，您一定要记得再用清水擦一遍，不然会有牛奶残留的奶臭味。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">酒精用处大：可清洗毛绒沙发</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">毛绒沙发有污渍，清洗起来麻烦不少，现在家居小贴士告诉您：用毛刷蘸少许稀释的酒精扫刷一遍，再用电吹风吹干，如遇上果汁污渍，用1茶匙苏打粉与清水调匀，再用布蘸上擦抹，污渍便会减退。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">在污渍处撒盐：去地毯上的汤汁</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 24px; margin: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">地毯上滴上汤汁或许是常有的事，斑斑点点看起来甚不美观，但千万不可着急用湿布去擦。应先后用洁净的干布或手巾吸干水分，然后在污渍处撒些食盐，待盐面渗入吸收后，用吸尘器将盐吸走，再用刷子整平地毯即可。</p>', '  ', 0, 0, '2013-07-09 11:36:21', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (58, NULL, 51, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '区别地毯好坏的主要参数', NULL, NULL, '', '区别地毯好坏的主要参数：1) 耐倒伏性 2) 色牢度 3) 抗静电性\r\n4) 绒毛的密度，重量和拔出力 5) 抗污性 6) 耐磨性 7) 耐然性\r\n8) 耐菌性\r\n\r\n\r\n\r\n', '<p><font color=\"#333333\"><strong><font size=\"3\">1) 耐倒伏性<br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n</font></strong><span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">倒伏是指地毯在静，动负载的作用下，其厚度减小的现象。耐倒伏性是指地毯不易倒伏的性能。</span></font><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">耐倒伏性与什么有关？</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　a) 纤维熔点</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">当人在地毯上行走的时候，或物品与地毯面运动接触的时候，会因磨擦而产生瞬间高温，由此而倒伏。所以，纤维熔点越高，地毯的耐倒伏性越好，相反，纤维纤维熔点越低，地毯的耐倒伏性越差。各类地毯比较，晴纶地毯的倒伏性最厉害，故它已慢慢退出地毯的历史舞台。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　b) 回弹性</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">即衡量地毯绒面层的弹性，即地毯在动力荷载作用下，其厚度损失的百分率。回弹性与纤维的密度和硬度有关。密度高的地毯一般不会发生倒伏，而密度小的绒头较高的簇绒地毯则较易发生倒伏。纤维的回弹性越好，地毯的耐倒伏性越好，相反，纤维的回弹性越差，地毯的耐倒伏性越差。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"text-align: left; line-height: 25px; widows: 2; text-transform: none; background-color: rgb(255,255,255); font-variant: normal; font-style: normal; text-indent: 0px; font-family: Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 14px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">2) 色牢度</strong><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">色牢度为地毯经受光照，水洗，以及各种清洗剂的作用而保持其颜色的能力。最高色牢度为6级．</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">色牢度共分为三种：（1）光照色牢度　（2）干磨擦色牢度　（3）湿磨擦色牢度</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">相比之下，色牢度最差的为丙纶地毯。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">关于染色：一般来说，多色毯，由色纱直接编制制成，而纯色毯，由编制程毯后经染色形成。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"text-align: left; line-height: 25px; widows: 2; text-transform: none; background-color: rgb(255,255,255); font-variant: normal; font-style: normal; text-indent: 0px; font-family: Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 14px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">3) 抗静电性<br />\r\n</strong><span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">抗静电性表示化纤地毯在使用时表面由于摩擦产生的静电积累和放电性能。化学纤维未经处理时容易积累静电，到一定程度可能会放电。静电积累一方面造成易吸尘，另一方面放电对某些场合可能会造成危害，如对电脑的性能影响等。按照材质来分别详细说明：</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">a) 丙纶：其本身具备了抗静电性</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">b) 尼龙：在制造过程中，掺加了抗静电碳丝，此方法所获得的为永久抗静电性。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">c) 羊毛：在制造过程中，喷涂了抗静电剂，此方法所获得的为暂时抗静电性。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"text-align: left; line-height: 25px; widows: 2; text-transform: none; background-color: rgb(255,255,255); font-variant: normal; font-style: normal; text-indent: 0px; font-family: Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 14px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">4) 绒毛的密度，重量和拔出力</strong><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">b) 地毯的绒头密度：可用手去触摸地毯，其产品的绒头质量高，毯面的密度就丰满，这样的地毯弹性好、耐踩踏、耐磨损、舒适耐用。一般来说，绒毛越高，绒重就越重，档次越高。目前世界上最高的绒毛为9CM，国内最高为5CM。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">c) 绒毛重量有二种表示参数，换算公式：1盎司/平方码＝34克/平方米</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">d) 绒毛的拔出力，决定了地毯易不易掉毛，拔出力越大，地毯越不易掉毛，相反，拔出力越小，地毯越易掉毛。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"text-align: left; line-height: 25px; widows: 2; text-transform: none; background-color: rgb(255,255,255); font-variant: normal; font-style: normal; text-indent: 0px; font-family: Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 14px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">5) 抗污性</strong><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">地毯的污染有两种可能，一是灰尘、砂粒等固体污物，另一种是含有固体或颜色的液体污物，如酒、调料、果汁、墨水等。化纤地毯对于固体污物有很强的藏污性，即尘土砂粒能隐藏在绒头底部而地毯表面则仍清洁如新。对液体污染物，尤其是有色的液体，由于毯面纤维有吸收性，表面较易沾污和着色，这就对地毯的保养提出了较高的要求，对它的使用环境也提出了限制，在保养较差的公共建筑、住宅中的厨房等地面是不宜使用化纤地毯的。化纤地毯的耐污和藏污性主要决定于毯面纤维的结构、性质和毯面的结构。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"text-align: left; line-height: 25px; widows: 2; text-transform: none; background-color: rgb(255,255,255); font-variant: normal; font-style: normal; text-indent: 0px; font-family: Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 14px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">6) 耐磨性</strong><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">地毯在固定压力下，经磨损露出背衬所需要的次数。地毯的耐磨性与原材料的品种有关，也与地毯编织厚度有关，越厚越耐磨。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"text-align: left; line-height: 25px; widows: 2; text-transform: none; background-color: rgb(255,255,255); font-variant: normal; font-style: normal; text-indent: 0px; font-family: Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 14px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">7) 耐然性</strong><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">耐燃性是装饰材料的重要指标，对于化纤地毯，凡燃烧时间在12分钟之内，燃烧面积的直径在17.96厘米之内的，耐燃性就为合格。比较起来，丙纶地毯耐燃烧较差，其它地毯的耐燃性指标相关不多。</span><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"text-align: left; line-height: 25px; widows: 2; text-transform: none; background-color: rgb(255,255,255); font-variant: normal; font-style: normal; text-indent: 0px; font-family: Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 14px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">8) 耐菌性</strong><br style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; font: 14px/25px Simsun; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 0px; display: inline !important; font: 14px/25px Simsun; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">地毯作为地面覆盖物，在使用过程中，易被虫、菌所侵蚀且发生霉烂变质。凡能耐受8种常见的霉菌和5种常见的细菌的侵蚀而不长菌和霉变的均认为合格。</span></p>', ' ', 0, 0, '2013-07-09 11:24:22', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (59, NULL, 53, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '白宫装修换地毯拒绝透露价格', NULL, NULL, '', '美国总统奥巴马31日晚在白宫椭圆形办公室发表全国讲话，细心的美国观众发现，总统办公室经过重新装饰，换了新模样！沙发、壁纸、地毯，全部焕然一新，入住18个月来，奥巴马在白宫留下了自己的印记', '<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(248,248,248); text-indent: 0px; font: 14px/23px Arial, Helvetica, sans-serif; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(0,0,0); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">美国总统奥巴马31日晚在白宫椭圆形办公室发表全国讲话，细心的美国观众发现，总统办公室经过重新装饰，换了新模样！沙发、壁纸、地毯，全部焕然一新，入住18个月来，奥巴马在白宫留下了自己的印记。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(248,248,248); text-indent: 0px; font: 14px/23px Arial, Helvetica, sans-serif; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(0,0,0); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　从最新照片看来，两排深黄色的新沙发占据了中心位置，中间是一个大理石咖啡桌。布什时期苍白的墙纸已被撕去，换以米色和金色条纹交错的新墙纸。前第一夫人劳拉-布什选择的带有太阳光线设计图案的地毯也已然不见了，取而代之的是一块黄色新地毯，上面织有4位美国前总统以及民权领袖马丁-路德-金的名言。</p>\r\n<p style=\"text-align: left; widows: 2; text-transform: none; background-color: rgb(248,248,248); text-indent: 0px; font: 14px/23px Arial, Helvetica, sans-serif; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(0,0,0); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　小布什使用过的旧座椅被收进了白宫库房，奥巴马换上了办公室风格的新座椅。另外，邱吉尔的铜质头像也被马丁-路德-金的头像取代。这次装修设计究竟是奥巴马亲历亲为还是出自第一夫人米歇尔之手，目前不得而知。白宫官员拒绝透露新装修究竟花了多少钱。</p>', ' ', 0, 0, '2013-07-09 11:35:56', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (60, NULL, 53, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '最古老的手织地毯', NULL, NULL, '', '没有人知道第一张手织地毯是在何时何处产生的。因为任何事物都有它天然的寿命，随着时间推移，手织地毯自身亦会损耗并逐渐消失。保养好的高品质手织地毯通常都能够很容易的使用几十甚至几百年。\r\n', '<p><span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 15px/20px 宋体; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;&nbsp;&nbsp; 没有人知道第一张手织地毯是在何时何处产生的。因为任何事物都有它天然的寿命，随着时间推移，手织地毯自身亦会损耗并逐渐消失。保养好的高品质手织地毯通常都能够很容易的使用几十甚至几百年。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 15px/20px 宋体; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;&nbsp;&nbsp;&nbsp;现今最古老的，保存最完好的东方手织地毯是保存在俄罗斯圣彼得堡国家文化遗产博物馆的2500年前的巴泽雷克(Pyzyryk)手织地毯。1949年俄罗斯考古学家卢登科博士率领的考古探险队，在南西伯里亚巴泽雷克山谷挖掘一处2500多年前的阿尔泰王子墓穴时，幸运的发现这张保存很好的手织地毯。这张地毯是保存在一个永冻冰层中。一个合理的假设是盗墓贼访问了这个墓穴，他们偷走了金银珠宝，但是没有带走墓穴里的地毯，后来雨水灌进了墓穴，形成了这个自然保护冰窖。这张手织地毯6尺6英寸见方，编织密度为每平方英寸220个结点，这种编织密度按照现在的标准也是不低的。图案设计细致精美，中间是由小方块组成的几何图案，有两个主边界，一个边界中有曾经生活在伊朗北部里海地区南端灭绝已久的黄斑鹿，在另一个边界里有骑在马背上的勇士，显示出了2500年前手织地毯编织工艺的高水平，也证明了手织地毯编织是一门古老的艺术。在这张手织地毯被发现以前，专家们主要是依靠文字记载去证明历史上某些手织地毯的存在，但是无法说明它们的编织方法。这张地毯所用的编织方法是双结点的对称结也叫土耳其结，这种对称结的打法和今天对称结的打法完全一样。这张地毯的图案设计说明早期地毯的图案设计是以几何图形为主，包括抽象图案和形象图案。<span class=\"Apple-converted-space\">&nbsp;</span></span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"line-height: 20px; widows: 2; text-transform: none; font-variant: normal; font-style: normal; text-indent: 0px; font-family: 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 15px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">传说中最大的东方手织地毯</strong><span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 15px/20px 宋体; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><span class=\"Apple-converted-space\">&nbsp;</span></span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 15px/20px 宋体; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;&nbsp;&nbsp; 在公元531年到公元579年，波斯帝国打败罗马军队, 占领了阿拉伯南部地区。为了庆祝这一胜利，波斯国王考斯罗一世下令生产一块巨大的地毯, 史称&ldquo;考斯罗的春天毯&ldquo;。 该毯是用羊毛和真丝织成，并镶嵌有金、银、贵重金属和宝石, 尺寸长为400英尺(121.92米), 宽为100英尺(30.48米), 是一张巨大的地毯。这张地毯采用经典的花园图案设计，表现出在沙漠地区少见的绿色植物、流水与花鸟景象, 被用在塞锡封宫殿巨大的会议厅里。这张光彩异常的大型地毯，具有重要的政治意义，象征着国王的权力和经济实力。公元651年, 阿拉伯人打败波斯人，占领了塞锡封。这张神话般的地毯被当作战利品掠走，并最终被切割成碎块分给打了胜仗的战士们。尽管如此，这张富丽堂皇的地毯在后来的几个世纪仍鼓舞了波斯人民的信心,更激发了波斯民族在以后创造出辉煌的历史、诗歌和艺术。 这张地毯也成为后世波斯地毯图案设计的灵感源泉。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<strong style=\"line-height: 20px; widows: 2; text-transform: none; font-variant: normal; font-style: normal; text-indent: 0px; font-family: 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); font-size: 15px; word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">阿德比尔地毯 THE ARDABIL CARPET</strong><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 15px/20px 宋体; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&nbsp;&nbsp;&nbsp;&nbsp;现今，波斯萨法维王朝以前所生产的手织地毯，至今完整保存的仅存有一块, 是目前存放在英国伦敦维多利亚阿尔伯特美术馆的&ldquo;阿德比尔地毯&rdquo;。 传说1893年一位不知名的英国人从伊朗带回来一对制作于十六世纪的波斯手织地毯, 为完整修复其中一张, 而将一对中的另一张地毯牺牲。现在展示在该馆东方展示厅内就是那张被修复的阿德比尔手织地毯, 长38 英尺(15.59米), 宽18英尺(5.49米), 是一张制作于1539年大尺寸的羊毛喀桑手织地毯， 在这张手织地毯的毯面最下方织有制作人的名字和制作年代。 另一张用于修复而不完整的手织地毯现存于美国洛杉矶州立美术馆.</span></p>', '  ', 0, 0, '2013-07-09 11:47:24', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (61, NULL, 53, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '我国集团购买力上升 推动地毯市场升温', NULL, NULL, '', '我国地毯市场全面升温的主要原因是', '<p><span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 15px/20px 宋体; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">我国地毯市场全面升温的主要原因是：</span></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　生活提高：人民生活质量逐年提高，住房条件进一步改善，面积扩大，房屋装饰装修讲究新颖配套，而地毯是房间装饰配套产品之一，购房热拉动了地毯销售旺。</p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　集团购买：据市场调查，集团购买地毯近几年呈现逐步上升趋势，数量占地毯总销量的30%以上，推动了地毯市场升温。</p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　款式新颖：近些年来，地毯款式一改往年那种花色、规格、材质单一的&ldquo;老三样&rdquo;，设计生产出材质多样、品质优良、图案多彩、规格齐全的新型地毯，具有柔软、舒适、不蛀、易收藏、携带方便、易洗、不掉毛、不产生静电，科技含量高等特点，并增加了锦纶、毛麻、混纺、真丝、涤毛等新材质，规格大至100平方米，小至1平方米，迎合了消费者求新、求美、求舒适的消费理念，适应了不同消费者的不同需求，拉动了地毯升温。</p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　业内人士称，入关后外企大量涌入我国，写字楼装饰装修将进一步拉动地毯市场升温，地毯行业应抓住这个良机，加快新产品开发，提高地毯科技含量，增加附加值，生产出适应国内外消费者需求的外型地毯，保持地毯畅销不衰。</p>', ' ', 0, 0, '2013-07-09 11:49:51', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (62, NULL, 53, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '中国藏毯在全球地毯业寻求“新地位”', NULL, NULL, '', '“第一次举办这个展览会时，印度人不打算来这里，最后只来了12个商家。而今年仅印度商家已经有100多个了，伊朗的商务副部长也在这里。8年了，你可以想象，这已经发展成为了一个国际地毯产业界重要的盛会。”正在此间举行的2011青海藏毯博览会上，世界手工地毯协会主席阿赫塔尔·纳兹尔·库克说。\r\n\r\n', '<p><span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 15px/20px 宋体; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">&ldquo;第一次举办这个展览会时，印度人不打算来这里，最后只来了12个商家。而今年仅印度商家已经有100多个了，伊朗的商务副部长也在这里。8年了，你可以想象，这已经发展成为了一个国际地毯产业界重要的盛会。&rdquo;正在此间举行的2011青海藏毯博览会上，世界手工地毯协会主席阿赫塔尔&middot;纳兹尔&middot;库克说。</span></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 已经连续举办八届的青海藏毯国际展览会，是目前由地毯生产加工国举办的最具影响的国际性地毯产业盛会。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 在库克和许多业界人士看来，青海藏毯国际展览会是中国藏毯发展的一个缩影，通过这一展会带动和多方培育，藏毯有望在全球地毯业寻找到&ldquo;新地位&rdquo;。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 来自青海省湟中县的中国藏毯国家级非物质文化传承人杨永良告诉记者，藏毯起源于青海，已经有2000多年历史。藏毯是以羊毛为原料，制作中要先后经过尺寸定制、图案设计、花色搭配、植物染色、手工捻线、编织等工序。一块50厘米见方的传统手工编制藏毯需要一名技师工作一个月。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &ldquo;在我们国家，没有人从事手工地毯的编织工作，我们只有机器制造出来的地毯。德国还有欧洲其他国家的人们很青睐传统手工制作的藏毯。我们尊重这种传统工艺和那些编制工，这是一种珍贵的艺术。&rdquo;德国商人卡尔&middot;高曼的这番话代表了欧美市场对藏毯的认可。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 正是藏毯具有浓郁文化特色、手工编织的特点，进入新世纪以来，藏毯便在世界地毯产业中展露出强劲的发展势头。而这其中，作为藏毯起源地和最佳原料地的青海省更是异军突起。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 据中国藏毯协会统计，经过十余年发展，青海的藏毯品种已发展到15个系列84个品种、1000多个花色图案。涌现出了藏羊集团等国内藏毯生产龙头企业，和&ldquo;藏羊&rdquo;、&ldquo;藏之梦&rdquo;、&ldquo;青海湖&rdquo;、&ldquo;圣源&rdquo;等具有较高知名度的藏毯商标。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 青海藏毯产业已形成一定规模，初步显现区域性产业集聚趋势，在国际藏毯业界产生了重要影响。2004年举办至今，青海藏毯国际展览会规模和影响不断扩大，地毯贸易成交额也从最初的800万美元增加2010年的5860万美元。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 青海省副省长王令浚向媒体介绍，2010年，青海藏毯累计完成出口3500万美元，同比增长24%，藏毯企业实现销售收入9.48亿元人民币，同比增长37。7%。青海省会西宁市正离自身设定的&ldquo;世界藏毯之都&rdquo;目标渐行渐近。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 由于看到藏毯富含的商机，河北、山东等中国其他地区的地毯企业也投入到藏毯研发、生产中，出于满足市场需求和寻求利润，机织藏毯也已问世。河北宏兴集团总裁徐宏忠告诉记者，他们企业目前主要致力于机织藏毯的生产，年产值已突破1亿元。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&ldquo;按照现在的市场行情，机织藏毯每平方米价格在60到200元左右，虽然远低于手工藏毯每平方米500到1000元的价格，但是公共场所、机构和低端客户的需求很大，机织藏毯的市场非常吸引人。&rdquo;徐宏忠说。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 由于藏毯属劳动密集型产业，据测算，藏毯产业出口额每增加1万美元，就可创造出16个用工岗位。作为目前国内最大的藏毯生产企业－青海藏羊集团已经为青海农牧区创造出了16000个就业岗位。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;西宁市大堡子镇二十里铺村村民张发兰说，她编织藏毯已经11年了，现在每月能有100多元的收入。编织藏毯已经是她们村妇女农闲时主要的收入来源。企业在藏毯加工集中的村落设立车间，并派出技术指导，农牧民到车间&ldquo;上班&rdquo;，如今，藏毯生产&ldquo;公司＋农户&rdquo;组织模式不仅有效扩大了藏毯产出数量，也使藏毯质量得到了有效管控。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 然而，作为地毯产业的新锐，想要&ldquo;洗牌&rdquo;市场眼下还面临不少挑战。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &ldquo;我认为，中国藏毯产业目前面临的最大的问题是劳动力短缺。市场需要更多真正的手工藏毯，能够有更多的人从事这种传统工艺才能使藏毯在世界市场上处于优势。&rdquo;美国客商保罗&middot;施普尔说。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp; &nbsp; 山东海盛恒业制毯有限公司总经理赵士海非常认同保罗&middot;施普尔的观点。赵士海告诉记者，由于用工不足，他们企业的生产和销售收入已经比鼎盛时期缩减了一半以上，有订单不敢接成为他现在最大的烦恼。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 此外，不少业界人士还认为，受原材料价格上涨影响，藏毯的加工成本也明显增加，就价格而言，与占据国际地毯高端市场的土耳其、比利时等国产品相比，藏毯的价格优势逐渐在丧失。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 青海藏羊集团副总经理陈学武则认为，机器取代了手工制毯对传统手工织成的藏毯也产生了不可忽视的影响，藏毯要想在国际地毯市场中不断开拓，最终还是要在产业高端占有一席之地。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 据了解，目前，世界地毯产业市值为90亿美元，而中国的市场份额仅为4亿美元。国际上，人均地毯消费为每人3平方米，而消费市场潜力巨大的中国人均地毯消费则不足0.1平方米。这些数据表明，只要藏毯产业不断健康开拓、发展，将具有丰富市场前景。</font></p>\r\n<p style=\"padding-bottom: 0px; widows: 2; text-transform: none; text-indent: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 15px/20px 宋体; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><font face=\"Verdana\">&nbsp;&nbsp;&nbsp;&nbsp; &ldquo;藏毯要真正在国际市场上有所作为，还有一个关键就是亟待提升产品的研发能力。传统藏毯虽然历史悠久、经典耐用，但花色、品种还是显得单调。必须按照现代人的审美眼光，在保持传统特色的基础上赋予藏毯新的&lsquo;外表&rsquo;和内涵。&rdquo;陈学武说。</font></p>', ' ', 0, 0, '2013-07-09 14:17:50', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (63, NULL, 53, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '故宫国内地毯收藏级别最高之地', NULL, NULL, '', '2001年一天，一位英国的地毯收藏家来到了故宫博物馆，他向工作人员提出请求，想看一下故宫的地毯。这让工作人员很为难，因为在故宫，地毯那时候还不算“宝贝”，都堆在原来的御茶膳房楼上库房中，从1925年起，就没有人动过它了，里面满是灰尘。\r\n', '<p><span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">2001年一天，一位英国的地毯收藏家来到了故宫博物馆，他向工作人员提出请求，想看一下故宫的地毯。这让工作人员很为难，因为在故宫，地毯那时候还不算&ldquo;宝贝&rdquo;，都堆在原来的御茶膳房楼上库房中，从1925年起，就没有人动过它了，里面满是灰尘。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　在这位叫麦克的收藏家一再的请求下，故宫的工作人员打开了尘封已久的库房，当库房门打开的时候，这位收藏家看到堆积如山的皇家地毯时，据故宫的工作人员回忆，麦克&ldquo;刷&rdquo;地跪在地上，对着堆积如山的地毯泪如雨下：&ldquo;我终于见到了最古老的皇家地毯了！&rdquo;这件事对故宫的工作人员触动很大，2001年，御茶膳房将要维修，保存在里面的地毯必须搬走。故宫博物馆对地毯进行了清理，先后共清理出各种地毯800余块。研究发现，绝大多数地毯的年代都在200多年前的清代中、前期，一些是更早的明代中晚期，晚清的是极少数。这一发现使故宫成为国内最丰富、最全面、级别最高的地毯收藏之地。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　在国外，地毯收藏和研究比较早，在国际拍卖市场上，有收藏价值的古董地毯可以拍卖到几百万美元，而我国的地毯收藏因为缺乏理论支持，人们对好的地毯缺乏认识，存在鉴定、研究等困难，使国内的精品地毯得不到足够的认识，可以说是非常令人惋惜。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　1996年，在中国嘉德拍卖会上，清晚期宁夏织花蝶纹地毯、民国初期包头织瓶花八吉祥纹地毯、清晚期宁夏织花卉纹地毯和民国初期青海织藏式地毯分别以11万元、3.08万元、1.98万元和1.65万元成交，价格相对低迷。那时候，国内收藏界对中国地毯的价值认识不够，国内研究地毯的专家和学者几乎没有，也没有地毯类有影响的专着出版，喜欢地毯的人们，只能拿着国外的出版物，望&ldquo;洋&rdquo;兴叹！</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　2003年香港佳士拍卖会上，一件清乾隆御用龙纹丝绒地毯以77.062万元的高价成交。2006年，在东方博物拍卖会上，一件清中期丝制地毯以220万元的成交。而在国际上，地毯专场拍卖会盛行的时候，中国竟然没有一家拍卖公司组织过中国地毯的专场拍卖会。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　1994年起，故宫陆续编辑出版了《故宫博物院藏文物珍品全集(大系)》(60卷)，几乎囊括了故宫全部文物的精华，但惟独没有收录地毯。直到2010年6月，由紫禁城出版社出版的《故宫藏毯图典》才填补了这一空白；而此时，其他收藏门类已经进入了亿元时代。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　有识之士走到了前面，他们因为喜欢地毯而收藏，因收藏而了解中国地毯的魅力；而一些地毯收藏家，开始了恢复和复制中国宫廷地毯的行动，其中&ldquo;匠心纺&rdquo;就是其中为数不多的一家。他们选用最名贵的宁夏滩羊毛，采用传统编织方法，用植物染色，所产的地毯达到了中国皇家用毯水准，部分地毯还被故宫使用。正是在专家和学者以及企业家的共同努力下，中国宫廷地毯重焕光彩</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　中国地毯和波斯地毯在织法和用色上有很大不同。清代不同时期的地毯在纹样、用色、丝毛质量上有其各自的特点，最好的当然是雍乾时期宫廷用的&ldquo;宫毯&rdquo;，其中也分几等(皇帝办公，起居处的最好)。其他在京官员为了充门面，家里也购置地毯，但质量等级相差很大。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　中国地毯因其优质的染色和独特的工艺，见证了它的收藏和使用价值。在一些高收入消费者中，不乏以中国古董地毯作为现代家居的高档装饰品。世界上很多着名的博物馆、学术机构都大量收藏了中国地毯，并进行了专门的研究。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　清康熙时期所织作的&ldquo;老宁夏&rdquo;地毯，就是闻名于世的古典中式地毯 。然而，在宁夏织作地毯的历史从明朝以前就开始了，&ldquo;宁夏&rdquo;式也成为皇家专供地毯的代名词。 康熙皇帝幼年时，明朝的地毯早已在紫禁城里。1696年，康熙因一次军事远征而在宁夏停留，他把许多织毯师带回北京，专为宫廷织毯。当时，只有显贵才能用得起一块地毯。今天，现存的制作于康熙时期的地毯不超过500块，它们在拍卖会上的平均售价在10万到30万美元之间。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　&ldquo;匠心纺&rdquo;制作的地毯与康熙时期的地毯制作方式相同，也采用高品质的原材料，使用宁夏土种羊毛，完全仿古，以使地毯在几方面达到光泽、强度及柔软度均衡的效果，即手感。这样的地毯，如果不受损伤，能用百年以上而成为一件传家宝。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　&ldquo;匠心纺&rdquo;复制的古毯中的杰作原件资料主要来自西方几个重要的博物馆，如纽约大都会博物馆、着名的古董艺术品拍卖会， Christie 和 Sotheby。复制中国古毯的项目也许肇始于华盛顿的纺织博物馆，大约在上世纪70年代，他们雇佣一家有名的西方生产商来复制他们自己的地毯展品。在随后数年中，几家西方公司也在此领域做过尝试，但都没有达到我们先前努力所获致的水准。</span><br style=\"widows: 2; text-transform: none; text-indent: 0px; font: 14px/25px Verdana; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\" />\r\n<span style=\"widows: 2; text-transform: none; text-indent: 0px; display: inline !important; font: 14px/25px Verdana; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(68,68,68); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">　　而现在，越来越多的人们开始复制宫廷地毯，终于，皇家的爱物，在历经波折后，可以重现它的光彩，也可以走进现代中国人的生活。</span></p>', ' ', 0, 0, '2013-07-09 14:34:39', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (64, NULL, 50, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '中国地毯的发展', NULL, NULL, '', '地毯有多种功能，在皇宫、贵族、商人家庭和寺院，地毯作为主要的地面装饰。马鞍毯普遍使用于北方游牧民族，祈祷与墩毯使用于寺庙与修行人的生活中，炕毯则使用在气候寒冷的中国北方。十九世纪，许多美丽的地毯作品出产在中国，并具有鲜明的特点。\r\n\r\n', '<p><span style=\"widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 28px; display: inline !important; font: 14px/20px 微软雅黑, Verdana, 宋体, 新宋体, Arial, Helvetica, sans-serif; white-space: normal; orphans: 2; float: none; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">地毯有多种功能，在皇宫、贵族、商人家庭和寺院，地毯作为主要的地面装饰。马鞍毯普遍使用于北方游牧民族，祈祷与墩毯使用于寺庙与修行人的生活中，炕毯则使用在气候寒冷的中国北方。十九世纪，许多美丽的地毯作品出产在中国，并具有鲜明的特点。</span></p>\r\n<div id=\"mainCnt\" class=\"block mainCnt\" style=\"padding-bottom: 0px; widows: 2; text-transform: none; background-color: rgb(255,255,255); text-indent: 28px; margin: 0px; padding-left: 0px; padding-right: 0px; font: 14px/20px 微软雅黑, Verdana, 宋体, 新宋体, Arial, Helvetica, sans-serif; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(51,51,51); word-spacing: 0px; padding-top: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\">\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\"><a class=\"jkey\" href=\"http://www.jc001.cn/tag-ditan/\" target=\"_blank\" style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; color: rgb(0,0,0); text-decoration: none; padding-top: 0px\">地毯</a>有多种功能，在皇宫、贵族、商人家庭和寺院，<a class=\"jkey\" href=\"http://news.jc001.cn/keyId-1001/\" target=\"_blank\" style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; color: rgb(0,0,0); text-decoration: none; padding-top: 0px\">地毯</a>作为主要的地面装饰。马鞍毯普遍使用于北方游牧民族，祈祷与墩毯使用于寺庙与修行人的生活中，炕毯则使用在气候寒冷的中国北方。十九世纪，许多美丽的地毯作品出产在中国，并具有鲜明的特点。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\"><strong style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">历史上的中国地毯</strong></p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">在我们谈论中国地毯的现况时，应该先回头看看历史。已知的最古老的毛织地毯可追溯到大约2500年前，在今天的新疆曾发现汉代毛织地毯的碎片。当时中国人已与中亚的游牧部落进行贸易联系，从早期的书面记录看，地毯曾沿着古老的丝绸之路进行交易。到目前为止，还没有确认这些地毯碎片是在中国织造还是由交易得来的。下一个现存最古老地毯出自明代后期，距今超过1200年。这期间不乏绘画与文学的文献，幸存的毛织地毯却很稀有(虽然有一些幸存的毛毡地毯)。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">中国唐代文献有地毯在寺庙与道观中使用的记录，大多是由皇家捐赠的。在日本朝圣者圆仁的描述中，我们还可以看到皇帝在祭祀和郊游中使用地毯的情形。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">在宋朝，地毯主要是作为礼品，来维持与西部游牧民族之间的和平。蔡文姬被匈奴绑架后又被释放的着名故事，经常被描绘在绘画里，其中不乏地毯在军营使用的情景。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">当蒙古人建立元朝后，他们承袭了使用地毯的传统。从文献考证已知，在北京北部郊区已存在地毯制造车间，这表明地毯织造的传统从那个时期开始出现。地毯的使用，与宫廷和贵族阶层财富的增加有着密切的联系。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">明代紫禁城开始建造与装饰时，地毯是专门为宫廷定制的。明朝皇帝的肖像中不乏设计华丽的红地毯，而皇帝专用的甬道也设计成地毯的样子。从紫禁城现存的明朝地毯中可以看出，这些具有独特的中国设计和高超工艺的地毯，出自高度熟练的工匠，并具有很高的艺术价值。从稀有的书面记录来看，这些地毯只提供给皇帝和高级官员，在正式的宫廷仪式中使用。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">随着满清王朝统治的到来，又一个游牧民族背景让地毯的使用成为在所难免。皇宫里的地毯在皇家专用车间定制。康熙皇帝，以长期稳定的需求与规则，催生了中国艺术中最好的地毯作品，他高度赞赏地毯制作艺术，还亲自造访宁夏的地毯制造中心观看打样。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">虽然只有极少数几件十八世纪出品的毛织地毯幸存下来，现有的例子表明，这是一项高度成熟的艺术，可以轻松地与其他中国艺术门类相提并论。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">清朝乾隆皇帝，珍惜祖父康熙的遗产，特别是皇宫地毯并继续织造优良的地毯，不断提高其艺术价值。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\"><strong style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">中国地毯的织造</strong></p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">中国的地毯织造中心在北部和西部地区，特别是内蒙古、宁夏、青海、甘肃、西藏和新疆，是生产高质量的传统<a class=\"jkey\" href=\"http://www.jc001.cn/tag-ymditan/\" target=\"_blank\" style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; color: rgb(0,0,0); text-decoration: none; padding-top: 0px\">羊毛地毯</a>的地区。那时，一个织造车间通常可以容纳10~30人，织造工人通常为男性 。大多数车间不仅为宫廷和寺院提供，也为当地人和出口贸易提供产品。大多数中国地毯图案具有精神或宗教信仰的涵义，或是代表主人独特的吉祥祝福。图案涉及植物、花鸟、动物(龙、凤、鹿、狗&hellip;&hellip;)或是佛教、道教中具有特殊寓意的图案。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\"><strong style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">19世纪的重大变化</strong></p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">19世纪60年代，对美丽地毯的需求不断增加，导致更多的地毯作坊在北京建立。得益于中国的开放，富有的商人们开始用地毯装饰自己的家园。地毯作坊继续向朝廷提供定制地毯的同时，也开始向富裕阶层提供地毯。另一方面，社会延续着以地毯做为变通方式向寺庙捐款的传统。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">随着中国对外贸易的开放，19世纪60年代，第一批地毯也慢慢出现在西方。十八世纪以来，中国的艺术和文化一直被西方世界推崇与向往，而这些罕见的地毯立刻得到富人们的共鸣与青睐。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\"><strong style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">现代地毯作品在西方</strong></p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">中国高古地毯在1891维也纳地毯展览中第一次展示。1903 年 4月在圣路易斯世博会上，新的中国地毯荣获众多奖项。1900年义和团运动之后，清王朝的持续衰退，更多的古董地毯流入美国和欧洲市场。宫殿、庙宇、贵族的庄园都成为古董地毯进入西方市场的场所。1909年，福田公司在巴黎举行了第一个中国古董地毯的商业展览，同时，他们也是当代中国地毯市场的主要参与者。1908～1910年之间，美国艺术协会在纽约的一系列古董地毯拍卖会取得了创纪录的价格，其中很多拍品来自皇宫。这些年间，着名收藏者包括蒂凡尼和摩根大通。着名建筑师弗兰克&middot;劳埃德&middot;赖特也在他出版的第一本书中使用了以中国地毯装饰的案例。1911年，中国古董地毯展在巴黎瑟纳斯基博物馆举行。这一系列事件创造了对中国地毯的美好认识，尤其是在美国，富人们产生了极大的兴趣和需求。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">在中国，地毯生产的规模迅速扩大，新的织造中心包括天津和济南等涌现出来以满足不断扩大的需求。20世纪20年代，天津做为出口城市，同时也成为国内和国际地毯织造最重要的基地。他们继续沿用几十年来被广为赞誉的古典设计，还聘请了曾留学西方的中国地毯设计师，他们将东方与西方的审美糅合到他们的设计中，制造出结合了最好的东方文化与西方文化的美丽地毯。20世纪30年代，各种图案和颜色，富于变化，炫目多姿。生产一直持续到20世纪30年代初，却因日本侵略和二战开始而急转直下。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">直到今天，尽管进行了一些尝试来重新启动这个行业，但它从未达到昔日品质与技艺的高度。没有什么可以与过去的优秀作品做技术竞争，羊毛的质量和艺术性等已经失传。实际上，很难再有人能够恢复这一传统，达到类似的水平。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\"><strong style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">高古地毯的价值</strong></p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">由于历史的原因，在当代的中国，没有多少人知道如此辉煌的地毯艺术曾经存在于自己的家乡，因此大多数人没有开始收藏这些地毯。许多地毯在一百年前离开了中国，这可能正是为什么它们能幸存至今的原因。</p>\r\n<p style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; padding-top: 0px\">高古地毯真正的美和价值在中国还没有被认知，在这个被忽视的领域，我们希望可以帮助创造更多的认知。收藏家应明白一个古董地毯不仅是一个<a class=\"jkey\" href=\"http://www.jc001.cn/diban/\" target=\"_blank\" style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; color: rgb(0,0,0); text-decoration: none; padding-top: 0px\">地板</a>覆盖物，而是一种地面艺术品，非常适合于古典和现代的环境。</p>\r\n</div>', ' ', 0, 0, '2013-07-09 14:37:43', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (65, NULL, 50, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '地毯文化', NULL, NULL, '', '中国编织地毯已有2000多年的历史。中国新疆是世界地毯的发祥地发祥地之一，新疆维吾尔族素有家庭织毯的传统，和田盛产美玉之外，还素有东方地毯故乡的美誉。随着河西走廊丝绸之路的发展，新疆地毯也传到了波斯，为波斯地毯编织艺术注入了中国智慧和元素。同时，逐渐传播到了甘肃，陕西，宁夏，内蒙古，青海，西藏等省市，1860年到北京。其中宁夏地毯由于做工精细、色彩均匀，质地优良而一举成名，价格不菲。\r\n', '<p><span style=\"font-size: medium\">&nbsp;&nbsp; 中国编织地毯已有2000多年的历史。中国新疆是世界地毯的发祥地发祥地之一，新疆维吾尔族素有家庭织毯的传统，和田盛产美玉之外，还素有东方地毯故乡的美誉。随着河西走廊丝绸之路的发展，新疆地毯也传到了波斯，为波斯地毯编织艺术注入了中国智慧和元素。同时，逐渐传播到了甘肃，陕西，宁夏，内蒙古，青海，西藏等省市，1860年到北京。其中宁夏地毯由于做工精细、色彩均匀，质地优良而一举成名，价格不菲。<br />\r\n&nbsp;&nbsp;&nbsp; 地毯作为软质地面材料，其发展历史过程非常悠久，可以追溯到古巴比伦和古埃及时代。伊朗高原上的游牧民族为御寒冬而用羊毛编织成厚实的垫子，就开始了地毯文化的发展历程，2006年，权威资料显示，占有全球地毯市场41%的份额。伊朗地毯、土耳其地毯、印度地毯、阿富汗地毯统称为著名&ldquo;波斯地毯&rdquo;，声名远播。<br />\r\n&nbsp;&nbsp;&nbsp; 地毯真正快速发展还是在18世纪。此前均为手工地毯的生产方式。英国的工业革命推动了机械动力，并深入到各行各业，地毯业也不例外。18世纪末出现了第一台布鲁塞尔机，随后进一步改造成为著名的威尔顿织机和阿克明斯特织机，此后这两款织机竟一直被使用至今。至20世纪40年代英国发明了簇绒机，采用类似缝纫机那样用绒纱植入已有织物之上的方法，改变了织机即织布又植绒的传统方式。大大提高了生产速度，是地毯机械化方面的一大突破。至今簇绒地毯已占地毯总产量的90%左右。<br />\r\n&nbsp;&nbsp; 不管是手工地毯，还是工业地毯，深厚的文化底蕴给现代社会留下深刻的印象。以至于把地毯视为奢侈品，古董地毯更因其优质的染色和独特的工艺，见证了它的收藏和使用价值。2006年，在东方博物拍卖会上，一件罕见的清中期丝制地毯以220万人民币成交，其惊罕价格让人不得不对地毯文化刮目相看。<br />\r\n&nbsp;&nbsp;&nbsp; 高档生活元素的体现。现代家居讲究用饰物提升品味、提高档次，古董地毯作为古代文化的传承，因其自身特有的文化内涵和艺术价值，对美化家居、体现装修风格起到了画龙点睛的作用。一幅古色古香、图案精美、质地精良的古董地毯可以让家居更富文化气息。在北京的许多使馆、高级酒店、宾馆里及一些&ldquo;金领人士&rdquo;的家中，古董地毯作为现代家居的高档装饰品，正越来越受到欢迎。&nbsp; <br />\r\n&nbsp;&nbsp;&nbsp; 地毯是文化不是商品。已成为人们的共识。研究地毯的发展史、染色、制作工艺、拼图艺术及相关产业链，对发展现代地毯工业、地毯文化、地毯经济有着不一样的意义。<br />\r\n&nbsp;&nbsp;&nbsp; 北京有众多的文化创意产业园区，也是地毯消费大都市，能否有个地毯文化交流、交易场所？值得期待！</span></p>', ' ', 0, 0, '2013-07-09 14:49:42', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (66, NULL, 50, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '手工地毯传承千年受青睐', NULL, NULL, '', '不远万里从新西兰购置羊毛，精心独到的制图外加细腻的剪裁，一朵朵富贵牡丹和一簇簇铃兰水仙便跃然于甘肃穆斯林民众使用的地毯上面。 记者14日走访了甘肃穆斯林群众的聚居区——临夏回族自治州，“触摸”了这道传承千年的手工地毯制作工艺。\r\n\r\n', '<p><span style=\"font-size: medium\">不远万里从新西兰购置羊毛，精心独到的制图外加细腻的剪裁，一朵朵富贵牡丹和一簇簇铃兰水仙便跃然于甘肃穆斯林民众使用的地毯上面。 记者14日走访了甘肃穆斯林群众的聚居区&mdash;&mdash;临夏回族自治州，&ldquo;触摸&rdquo;了这道传承千年的手工地毯制作工艺。</span></p>\r\n<p><span style=\"font-size: medium\">临夏是古丝绸之路南道要冲，也是明代著名的四大茶马司之一，早在唐代，伴随着丝绸之路的悠悠驼铃，伊斯兰教就在这里扎根，历经多 个朝代。如今，这里生活着回族、东乡族、保安族、撒拉族等穆斯林民众，此地已逐渐成为中国伊斯兰教的繁盛之地。</span></p>\r\n<p><span style=\"font-size: medium\">古稀之年的达乌代儿孙满堂，在他家的客厅里，悬挂着一张绣有中国长城的挂毯，这件挂毯是多年前达乌代从当地一家地毯厂定制的。&ldquo; 我家这件挂毯值好几万元呢！&rdquo;达乌代说，长城是中国古人创造的伟大奇迹，是中国的象征，最能代表中国文化。</span></p>\r\n<p><span style=\"font-size: medium\">达乌代告诉记者，早在千年前，手工地毯工艺就从西域经丝绸之路传入临夏，如今，这里的家 家户户都有使用地毯的习惯，无论是家庭使用，还是朝觐做礼拜，都格外地偏爱，不过更多的穆斯林现在都喜欢收藏。</span></p>\r\n<p><span style=\"font-size: medium\">时下的临夏，浓郁的春节气息还未散去，但此地多个地毯企业生产车间里已是目不暇接，工人们正紧张地编织地毯，成品的地毯被整齐地 码放在仓库，等待进入市场。</span></p>\r\n<p><span style=\"font-size: medium\">这些充满异域风格的手工地毯，有些是精心钩织的&ldquo;皇宫&rdquo;图案，彰显雍容和典雅；一些颜色较深、代表中国文化的龙凤图案，艳丽缤纷 ，尽显富贵华丽；而最有异域特色的当数阿拉伯民族风情的地毯，风格迥异的清真寺建筑风格，令人无不叹服。</span></p>\r\n<p><span style=\"font-size: medium\">&ldquo;当地经济落后，文化封闭，手工织毯工艺没有受到外来文化的冲击，才得以保存传承。&rdquo;临夏市兴强地毯有限责任公司负责人王丽琴说 ，这里的民众喜好毯子由来已久，而生产的地毯、挂毯做工精细，质地牢固，美观大方受到海内外青睐，尤其是艺术挂毯，以其独特的艺术形 式表现了生活美，极具艺术品味和文化内涵。</span></p>\r\n<p><span style=\"font-size: medium\">当地制作手工地毯大多需要纺纱、染线、缠线、绘图、织毯、片剪、洗毯、平毯等十多道工序。王丽琴说，&ldquo;手工地毯有着机织地毯无法 比拟的优势，它的生产工序复杂，工艺严苛，生产周期长，售价自然要比机织毯高出很多。</span></p>\r\n<p><span style=\"font-size: medium\">记者采访获悉，这里生产的手工毯售价没有上限，一块地毯少则卖到几千元人民币，多则卖到10余万元，由于其原料纯正、工艺精良、花 色品种多、收藏价值高等诸多特点，吸引了越来越多的外商。目前，已远销美国、日本、德国、法国等国家，尤其受到阿拉伯国家的青睐。 </span></p>', ' ', 0, 0, '2013-07-09 14:51:41', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (67, NULL, 50, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '中国手工地毯历史', NULL, NULL, '', '地毯编织是中国的一项传统手工工艺，具有悠久的历史。\r\n', '<p style=\"widows: 2; text-transform: none; text-indent: 0px; font: 12px/24px Verdana, Arial, Helvetica, sans-serif; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(0,0,0); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><span style=\"line-height: 24px; color: rgb(51,51,51); font-size: 9pt\">地毯编织是中国的一项传统手工工艺，具有悠久的历史。<span lang=\"EN-US\"><br />\r\n</span>　　新疆是中国地毯的主要发源地之一。那里气候高寒，人们过着游牧生活，需要大量的手织品以防湿御寒和美化生活，因而出现了用羊毛或驼毛捻成线，按照古老的编席方法编织出有美丽花纹衬托的各种毯类，即组织结构为平纹的编织地毯，后来发明了过粗细纬、栽绒组织结构，更加厚密的栽绒地毯即手工打结地毯。<span lang=\"EN-US\"><br />\r\n</span>　　<span lang=\"EN-US\">2000<span class=\"Apple-converted-space\">&nbsp;</span></span>多 年前，中国的地毯编织工艺就已经达到了十分成熟的水平。玄奘的《大唐西域记》里，记录着一千多年前当地地毯业兴盛的情况。<span lang=\"EN-US\"><span class=\"Apple-converted-space\">&nbsp;</span>1959<span class=\"Apple-converted-space\">&nbsp;</span></span>年，从和田地区民丰县出土的古代地毯残片，便是最好的证明，它的编织方法与现在当地民间地毯编织工艺基本相似，结扣采用细致的马蹄扣（土耳其结法），经纬密度为<span lang=\"EN-US\"><span class=\"Apple-converted-space\">&nbsp;</span>330<span class=\"Apple-converted-space\">&nbsp;</span></span>道，仅比现在和田地毯经纬密度<span lang=\"EN-US\"><span class=\"Apple-converted-space\">&nbsp;</span>360<span class=\"Apple-converted-space\">&nbsp;</span></span>道少<span lang=\"EN-US\"><span class=\"Apple-converted-space\">&nbsp;</span>30<span class=\"Apple-converted-space\">&nbsp;</span></span>道左右。到了汉代，随着汉武大帝消灭了匈奴人，一条通往西亚、欧洲的贸易通路<span lang=\"EN-US\"><span class=\"Apple-converted-space\">&nbsp;</span>----<span class=\"Apple-converted-space\">&nbsp;</span></span>丝绸之路开通了，丝绸之路不仅运载了丝绸、地毯、瓷器、茶叶和香料，也促使了东西方文化的交流和传播，中国地毯编织工艺从而随着中国的丝绸之路经过中亚带到了中东和欧洲，同时也让中国人见识了代表波斯文明的波斯地毯，在波斯地毯图案中，至今仍然保留着许多与中国地毯图案完全相同的花纹。也有人认为这类地毯起源于中国，只是在波斯设计师的手中，经过精心的修改并加进了波斯的色彩，从而成为具有中东风格的图案。从哪时起这两个文明古国不断相互学习、交流与借鉴<span lang=\"EN-US\">,</span>传 统的中国图案和传统的波斯图案，以及编织工艺在天长日久的相互融合，从而成就了一项高雅细腻的地毯艺术。<span lang=\"EN-US\"><br />\r\n</span>　　在十七、十八世纪的明末清初，中国手工地毯制造工艺达到了前所未有的高度，且消费多在宫廷和寺庙中。在这期间产生了大量美伦美焕的地毯，在许多国家，中国地毯被作为永久的艺术品而收藏。比如：纽约的大都会博物馆、华盛顿特区纺织博物馆、加拿大皇家昂特里奥博物馆、伦敦维多利亚博物馆等都藏有中国地毯。但是进入二十世纪以后，中国地毯自古以来所使用的手纺纱被机器纺纱代替，天然植物染料被合成的化学染料取代，采用现代手段批量加工地毯，摒弃了传统手工工艺。<span lang=\"EN-US\"><br />\r\n</span>　　中国改革开放以后，由于外贸出口的需要，特别是近几年来，中国国力的增强，人民安居乐业，沿海及大中城市中追逐高档古典的装饰风格也有不同程度的需要，因此中国手制地毯出现了前所未有的发展，涌现出许许多多的手工制毯中心，中国真丝地毯、新疆羊毛地毯、西藏羊毛地毯便是其中的代表。<span lang=\"EN-US\"><o:p></o:p></span></span></p>\r\n<p style=\"widows: 2; text-transform: none; text-indent: 0px; font: 12px/24px Verdana, Arial, Helvetica, sans-serif; white-space: normal; orphans: 2; letter-spacing: normal; color: rgb(0,0,0); word-spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px\"><span lang=\"EN-US\" style=\"line-height: 24px; color: rgb(51,51,51); font-size: 9pt\">&nbsp;</span><span class=\"style31\"><b><span style=\"line-height: 24px; font-size: 9pt\"><font color=\"#ff0000\">丝绸之路</font></span></b></span><strong><span style=\"line-height: 24px; font-family: 宋体; color: rgb(51,51,51); font-size: 9pt\"><span class=\"Apple-converted-space\">&nbsp;</span></span></strong><b><span lang=\"EN-US\" style=\"line-height: 24px; color: rgb(51,51,51); font-size: 9pt\"><br />\r\n</span></b><span style=\"line-height: 24px; color: rgb(51,51,51); font-size: 9pt\">　　古代丝绸之路长约六千公里，起点是中国长安<span lang=\"EN-US\"><span class=\"Apple-converted-space\">&nbsp;</span>(<span class=\"Apple-converted-space\">&nbsp;</span></span>今西安<span lang=\"EN-US\"><span class=\"Apple-converted-space\">&nbsp;</span>)<span class=\"Apple-converted-space\">&nbsp;</span></span>，途经西北、帕米尔高原，越过喀拉昆仑山脉，经过萨玛甘和波斯的哈马丹，到达地中海港口亚利山大。丝绸之路在公元前一百年汉武帝征服西亚大片地区以后开始使用，十三世纪蒙古帝国时期意大利商人马可波罗经丝绸之路来到中国</span><span lang=\"EN-US\" style=\"line-height: 24px; font-size: 9pt\"><o:p><font face=\"Times New Roman\">&nbsp;</font></o:p></span></p>', ' ', 0, 0, '2013-07-09 14:54:37', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (68, NULL, 50, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '中国地毯发展前景广阔', NULL, NULL, '', '说起方块地毯，大家并不陌生。地毯作为一种普通的地面装饰材料，在全世界范围内却有着非常庞 大的消费群体。在西方国家，家用地毯销售占到地毯销售总量的70％左右，据相关统计显示，发达国家地毯的铺设面积占室内可使用面积的90% 以上。 \r\n', '<p><span style=\"font-size: small\">说起方块地毯，大家并不陌生。地毯作为一种普通的地面装饰材料，在全世界范围内却有着非常庞 大的消费群体。在西方国家，家用地毯销售占到地毯销售总量的70％左右，据相关统计显示，发达国家地毯的铺设面积占室内可使用面积的90% 以上。 <br />\r\n中国地毯已有两千多年的历史，主要是以手工地毯著称。地毯在我国兴起的比较早，手工地毯一直占据主导地位。由于手工地毯价格较高，所 以人们一直认为地毯是一种奢侈品，致使地毯行业发展比较缓慢，直到机制手工地毯的产生，中国 地毯才开始有所发展。 <br />\r\n近年来，随着我国经济的迅速发展，人们开始追求时尚健康舒适的生活理念。与地板相比，地毯具有吸音、保温、防潮、防静电、脚感舒适等 一系列优点。而且地毯图案精美、价格较低、铺装简单，易于更换。因此，地毯越来越受到国内消费者的青睐。尤其是宾馆酒店地毯、家用地 毯、办公地毯，颜色多样，价格较低，适合大面积铺设。现在铺设地毯已经不是一种奢侈的表现。在不久的将来，地毯就会成为主要的地面装 饰材料。<br />\r\n地毯成为现代家居装饰中的佼佼者<br />\r\n在现代社会，地毯具有其无可替代的功能，如保暖防潮、脚感柔软、装饰等。对人的身体地毯也有显著的保护功能，特别是对儿童和老人，有 助于人们身体健康。随着地毯的制作工艺的提高，其清洗的难易程度也得到了改善。<br />\r\n随着生活水平的提高，进入空调时代之后，对北京方块地毯的选择早已没有了季节的限制。地毯和 那些瓷砖、大理石、木板等硬质材料有所不同，它所具有的特殊软质和千变万化的图案艺术中所蕴含的文化品位正使它逐渐成为现代家居装饰 品中的佼佼者。<br />\r\n纯毛地毯脚感舒适适用高档地面<br />\r\n地毯是用动物毛、植物麻、合成纤维等为原料，经过编织、裁剪等加工过程制造的一种高档地面装饰材料。地毯具有质地柔软、脚感舒适、使 用安全的特点，特别适宜于家庭中的卧室、客厅、书房处的地面装饰。北京手工地毯具 有很高的艺术价值，装饰后能够体现高贵、华丽、美观、气派的风格，同时具有隔热、防潮的作用。在家庭装修中地毯满铺或作为地面的局部 装饰，都能达到满意的装饰效果。随着我国人民生活水平的提高，地毯在家庭中的选用比例越来越高。 <br />\r\n纯毛地毯的手感柔和，拉力大，弹性好，图案优美，色彩鲜艳，质地厚实，脚感舒适，并具有抗静电性能好、不易老化、不褪色等特点，是高 档的地面装饰材料，也是高档装修中地面装饰的主要材料。但纯毛地毯的耐菌性、耐虫蛙性和耐潮湿性较差，价格昂贵，多用于高级别墅住宅 的客厅、卧室等处。<br />\r\n</span></p>', '  ', 0, 0, '2013-07-09 15:04:24', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (69, NULL, 53, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '玉米皮编制地毯技术', NULL, NULL, '', '近年来，随着人们生活条件的不断提高，住房条件得到很大改善。绿色消费、环保产品成为大家日益关注的话题。室内装饰因化工产品含有高 浓度的挥发性物质，影响人们呼吸系统，危害身体健康，正逐步被人们摒弃。全天然绿色产品越来越受到大家的欢迎。用玉米皮编织地毯以其适度的弹性、美丽的纹样，给室内创造清爽宜人的环境，且绿色环保，受到美、日、法等国 家的广泛欢迎。\r\n\r\n', '<p>近年来，随着人们生活条件的不断提高，住房条件得到很大改善。绿色消费、环保产品成为大家日益关注的话题。室内装饰因化工产品含有高 浓度的挥发性物质，影响人们呼吸系统，危害身体健康，正逐步被人们摒弃。全天然绿色产品越来越受到大家的欢迎。用玉米皮编织地毯以其适度的弹性、美丽的纹样，给室内创造清爽宜人的环境，且绿色环保，受到美、日、法等国 家的广泛欢迎。</p>\r\n<p>下面介绍玉米皮编制地毯的方法：</p>\r\n<p>１、玉米皮的漂白处理：为了使玉米皮更洁白，可用硫磺熏蒸法将玉米皮漂白。硫磺熏制的玉米皮，不但洁白柔软，而且不易霉变虫蛀。 熏蒸方法是：将选好的玉米皮用水湿润，甩净水，放在大缸或密闭的熏蒸室内，熏蒸1-2小时，取出均匀摊开晾干。</p>\r\n<p>２、玉米皮绳的加工：玉米皮单股绳是用纺车纺制而成。玉米皮辫可用手工编制，方法是将玉米皮劈成１厘米宽的小条，用三股编成小辫 ，同女孩子编发辫的方法相似。可编成折边辫子、拧边辫子。折边辫子效果平整，拧边辫子则比较圆凸。不论是折边辫子还是拧边辫子，编成 后都有正反之分，正面平整，有光泽；反面因接头多，有毛茬，使用时应使正面露在外面。</p>\r\n<p>３、盘钉：编织地毯是由若干个单独纹样组成的，每个单元是靠盘钉的方法做成，单元的形状有圆、方、三角形等，都可以拼合成地毯。</p>\r\n<p>盘钉的方法是：选择宽窄一致、厚薄均匀、颜色相同的辫子，正面朝外，顺时针方向盘转，每转2-3圈用针手工缝钉一圈。盘钉法分单盘与 双盘两种。单盘是从辫子的一端开始，顺序盘钉，呈单色，效果细致；双色盘是指用两条不同颜色的辫子同时盘出含有两种颜色的图案。单色 双盘则将草辫从中间结折，从速头出起盘，这种办法速度快，但不易捏平。通过这些方法，可以盘出圆、椭圆、方、三角、菱形等多种形状的 单独纹样单元，连起来便是完整而美丽的地毯。</p>\r\n<p>４、拼连：就是把缝钉好的单元纹样拼连在一起，缝钉成大小不同、规格各异的地毯或门毯。每个单元的面积约为0.1&times;0.9米，用６块拼 连在一起，面积约0.6&times;0.9米，适合作门毯使用。地毯可根据房间的大小灵活拼连，通常做成1.2&times;1.8米的规格出售，便于拼接使用。</p>\r\n<p>５、缝边：拼接完毕的地毯，一般要缝边，以加固边沿，达到规整美观的效果。</p>', ' ', 0, 0, '2013-07-09 15:06:41', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (70, NULL, 53, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '中国真丝手工地毯的历史', NULL, NULL, '', '早在西汉时（两千年前）中国已出现了编织地毯。在公元八世纪时的唐王朝毡毯颇为流行。那时曾出现用银线织成的毡毯。在17，18世纪，以 龙为图样的地毯在皇宫中使用，那时是中国编织地毯的顶盛时期。但很少清朝以前编织的地毯被保存下来。在二十世纪初欧美商人在天津，包 头，北京和青岛设厂编织地毯，但是那时大多用毛线为原料，很少用丝线。\r\n', '<p><span style=\"font-size: small\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 早在西汉时（两千年前）中国已出现了编织地毯。在公元八世纪时的唐王朝毡毯颇为流行。那时曾出现用银线织成的毡毯。在17，18世纪，以 龙为图样的地毯在皇宫中使用，那时是中国编织地毯的顶盛时期。但很少清朝以前编织的地毯被保存下来。在二十世纪初欧美商人在天津，包 头，北京和青岛设厂编织地毯，但是那时大多用毛线为原料，很少用丝线。<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 公元1949年解放后，中国的织毯业讯速发展起来，多种样式的地毯出现了。例如京式，美术式，大花式，片剪式，仿古式 和波斯式。特 别是波斯图案被引进后，加上中国工艺师的改良和创新，中国波丝地毯倍受国际市场的青睐。在八十年代中国成为东方地毯的主要生产基地。 在1998年第一块1，000道挂毯首先在河南省镇平县织成。它是一块最高档的挂毯，被列为纪尼斯世界纪录。<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 真丝手工地毯用天然丝线为原料，以传统的复杂的打结方法编织而成，在编织前需要大量的准备工作。<br />\r\n1.首先在表格上勾图并在每一个坐标点上用不同的符号代表不同颜色的线标示出来，以便织工依图编织。此为一种很有创意性的工作。 工艺师必需胸有成竹。实际织成的丝毯是原图样的再现。在某种意义上讲，此为第一道极为重要之工序，因为图样和丝毯的价值有极为重要的 关系。<br />\r\n2.把丝从蚕茧中抽出来。一个蚕茧中仅有三分之一的丝可供织丝毯所用。把细丝合成小股，并把它们放入沸腾的碱水中煮三四十分钟， 使其柔软.而后用清水漂去碱和杂质。使用天然的植物颜料把丝线染色。例如用蓝靛，红花，橡壳等。一般而言，一块丝毯要用上三十来种不同 颜色的丝线。<br />\r\n3.经线将被自上而下地绕在由两个横梁和两根立柱做成的架子上。综线将被缠绕在另一个横木和经线之间。底子用白色丝线编织成之后 ，手工打结即可开始。<br />\r\n4.把丝线缠绕在相邻的两根经线上打成双结（土耳其结，图2）或单结（波斯结，图1）。线头用刀割断。每当一行结打完时，纬线从前 经和后经的中间穿过。并用梳子将其砸实，使丝结牢固地拴在经上。<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 历经数月或数载的工作，一整块真丝手工地毯织成电脑一体机，它将被从架子上割下来，经线的末端 将被挽成穗子以增加美感。织成的真丝地毯在出售前将被整齐地剪平，并水洗去污。<br />\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 一个技工熟练的女孩在半年中能织成一块2英尺乘3英尺的300线（90，000个结每平方英尺）的真丝地毯；一年半的时间能织起一块2乘3英尺500 道（250，000个结每平方英尺）的真丝地毯；两年时间能织成一块800道（640，000个结每平方英尺）的真丝地毯；三年的时间织成一块1.2乘 1.5 英尺的确1，000道（1，000，000个结每平方英尺）的真丝挂毯。编织高档挂毯的丝线细如毛发，当织高道数丝毯时，甚至用得上放大镜。 由于编织时对眼睛的伤害很大，织工很难织第二块高道数的丝毯。故而高道数的丝毯（尤其是挂毯被世人称为软黄金）。 </span></p>', ' ', 0, 0, '2013-07-09 15:09:45', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (71, NULL, 53, NULL, '', NULL, NULL, 1, NULL, NULL, NULL, '世界各国最古老的手工地毯大揭秘', NULL, NULL, '', '手工地毯在西方通常称为东方地毯，在他们的眼中，这已不只是安放在家居中的地毯，而是有着三 千多年历史的古老东方手工艺术品。然而，在二十一世纪高度化的社会里，手织地毯的古老手艺正在逐渐失传，而手织地毯的文化也在逐渐消失。\r\n', '<p><span style=\"font-size: x-small\">手工地毯在西方通常称为东方地毯，在他们的眼中，这已不只是安放在家居中的地毯，而是有着三 千多年历史的古老东方手工艺术品。然而，在二十一世纪高度化的社会里，手织地毯的古老手艺正在逐渐失传，而手织地毯的文化也在逐渐消失。<br />\r\n伊斯法罕---世界的一半<br />\r\n查看全部纺织面料精彩图片<br />\r\n古老的波斯谚语说：伊斯法罕是半个世界。典型的伊斯法罕地毯是由花草、中心葵、阿哈巴斯棕榈叶、卷曲的树叶和缠绕的藤蔓构成主要图案 ，采用世界上最好的羊毛---科尔克羊毛，编织在真丝的经纬线上，伊斯法罕地毯现在仍被认为是世界上最好的波斯地毯。<br />\r\n印度地毯---卧莫尔王朝的艺术传承<br />\r\n查看全部纺织面料精彩图片<br />\r\n各类波斯、土耳其、高加索、土库曼、法国奥泊桑及中国图案设计，均被印度地毯采用，这是印度地毯的最大特点。<br />\r\n巴基斯坦地毯---源于印度自成一派<br />\r\n查看全部纺织面料精彩图片<br />\r\n巴基斯坦地毯与印度师出同门，共享四百年的历史。<br />\r\n1947年，英国人将印度次大陆一分为三，北面部分就是现在的巴基斯坦。虽然是源于印度，但是独立后的巴基斯坦地毯却自成一派，如：经常 使用的土库曼设计便是印度地毯中很少涉及的。<br />\r\n阿富汗---幸存的手织艺术品<br />\r\n查看全部纺织面料精彩图片<br />\r\n阿富汗地毯的风格和高加索地毯相似，多采用几何图形，质地优良、羊毛柔软,色彩对比鲜明。在过去的二十多年里，阿富汗的政治和经济始终 处在动荡之中，对阿富汗的部落地毯编织艺术同样造成沉重打击。今天的阿富汗地毯工业就像是系在一根细线上的古老艺术，正在奋力地寻求 生存的机会。尤其是阿富汗生产的一些美丽的部落地毯，在世界各地已较为稀少且昂贵。<br />\r\n观无量寿经变---敦煌壁画中的瑰宝<br />\r\n查看全部纺织面料精彩图片<br />\r\n图案取自于敦煌榆林窟25窟南壁《观无量寿经变壁画》。古马隆树脂在仙界众菩萨的正中威 坐着的是观无量寿佛，前方歌舞台上八位伎乐天正在演奏优美仙乐，舞伎在中央翩翩起舞，怀抱琵琶的人面鸟迦陵频迦弹奏着世间最动人的旋 律。七宝池、功德水、黄金的地面、红色的栅栏、大殿巍峨雄伟、宝树环绕四周&hellip;&hellip;传递了人们从未生怨中解脱出的佛教思想。<br />\r\n中国丝毯的主要产地是在湖南和四川，湖南镇平素有&ldquo;中国地毯之乡&rdquo;的美誉。因为中国丝毯大多采用传统的波斯图案，并常年销往国外市场 ，所以中国丝毯巧夺天工的手工编织艺术反而鲜为国人所知。<br />\r\n狩猎图---中国丝毯上的异域风情<br />\r\n查看全部纺织面料精彩图片<br />\r\n《狩猎图》丝毯反映了当时波斯人狩猎时的场景，其图案属于典型的波斯库姆风格。</span></p>', ' ', 0, 0, '2013-07-09 15:11:41', NULL, '2013-07-09 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (119, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A1350-G1.jpg', '|/FAJxc/cms/pic_thumb/0A1350-G1.jpg', '酒店地毯(Hotel-002)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"533\" src=\"cms/pic/0A1350-G1.jpg\" /></p>\r\n<p>&nbsp;</p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:31:41', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (120, NULL, NULL, NULL, '', NULL, NULL, 0, NULL, '|/FAJxc/cms/pic/0A1405-1.jpg', '|/FAJxc/cms/pic_thumb/0A1405-1.jpg', '酒店地毯(Hotel-003)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"547\" src=\"cms/pic/0A1405-1.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德地毯', 0, 0, '2013-07-18 10:15:01', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (121, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A1484-40.jpg', '|/FAJxc/cms/pic_thumb/0A1484-40.jpg', '酒店地毯(Hotel-004)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"536\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A1484-40.jpg\" /></p>\r\n<p style=\"text-align: left\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德地毯', 0, 0, '2013-07-17 16:38:11', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (122, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A1575-4.jpg', '|/FAJxc/cms/pic_thumb/0A1575-4.jpg', '酒店地毯(Hotel-005)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"534\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A1575-4.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:40:49', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (123, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A1587-41 .jpg', '|/FAJxc/cms/pic_thumb/0A1587-41 .jpg', '酒店地毯(Hotel-006)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"534\" src=\"cms/pic/0A1587-41%20.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:44:12', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (124, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A1749-42.jpg', '|/FAJxc/cms/pic_thumb/0A1749-42.jpg', '酒店地毯(Hotel-007)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"531\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A1749-42.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:45:41', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (125, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A1750-41 .jpg', '|/FAJxc/cms/pic_thumb/0A1750-41 .jpg', '酒店地毯(Hotel-008)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"549\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A1750-41%20.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德地毯', 0, 0, '2013-07-17 16:47:45', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (126, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A1763-60.jpg', '|/FAJxc/cms/pic_thumb/0A1763-60.jpg', '酒店地毯(Hotel-009)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"546\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A1763-60.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:51:32', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (127, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A2248-40.jpg', '|/FAJxc/cms/pic_thumb/0A2248-40.jpg', '酒店地毯(Hotel-010)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"554\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A2248-40.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。<br />\r\n&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 16:56:09', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (128, NULL, NULL, NULL, '', NULL, NULL, 0, NULL, '|/FAJxc/cms/pic/0B822-30.jpg', '|/FAJxc/cms/pic_thumb/0B822-30.jpg', '酒店地毯(Hotel-011)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"561\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0B822-30.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-18 10:13:11', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (129, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A2763-60 .jpg', '|/FAJxc/cms/pic_thumb/0A2763-60 .jpg', '酒店地毯(Hotel-012)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"548\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A2763-60%20.jpg\" /></p>\r\n<p style=\"text-align: center\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 16:59:15', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (130, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A3532-50.jpg', '|/FAJxc/cms/pic_thumb/0A3532-50.jpg', '酒店地毯(Hotel-013)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"544\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A3532-50.jpg\" /></p>\r\n<p style=\"text-align: center\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:00:31', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (131, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0A3579-60.jpg', '|/FAJxc/cms/pic_thumb/0A3579-60.jpg', '酒店地毯(Hotel-014)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"546\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0A3579-60.jpg\" /></p>\r\n<p style=\"text-align: center\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德出品', 0, 1, '2013-07-17 17:02:03', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (132, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0B161-13.jpg', '|/FAJxc/cms/pic_thumb/0B161-13.jpg', '酒店地毯(Hotel-015)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"538\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0B161-13.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:04:21', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (133, 999, NULL, '', '', NULL, '', 0, '', '|/FAJxc/cms/pic/0B2670-60.jpg', '|/FAJxc/cms/pic_thumb/0B2670-60.jpg', 'KTV地毯(KTV-001)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"481\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0B2670-60.jpg\" /></p>\r\n<p style=\"text-align: center\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-08-02 18:47:36', NULL, '2013-08-02 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (134, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/0E863-260.jpg', '|/FAJxc/cms/pic_thumb/0E863-260.jpg', 'KTV地毯(KTV-002)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"800\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0E863-260.jpg\" /></p>\r\n<p style=\"text-align: center\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:35:18', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (135, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/0I077-60.jpg', '|/FAJxc/cms/pic_thumb/0I077-60.jpg', 'KTV地毯(KTV-003)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"481\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0I077-60.jpg\" /></p>\r\n<p style=\"text-align: center\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:36:41', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (136, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3A1637-42 .jpg', '|/FAJxc/cms/pic_thumb/3A1637-42 .jpg', 'KTV地毯(KTV-004)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"559\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3A1637-42%20.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:46:19', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (137, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3E577-64.jpg', '|/FAJxc/cms/pic_thumb/3E577-64.jpg', 'KTV地毯(KTV-005)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"1357\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3E577-64.jpg\" /></p>\r\n<p><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:47:23', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (138, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3F524-60.jpg', '|/FAJxc/cms/pic_thumb/3F524-60.jpg', 'KTV地毯(KTV-006)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"1357\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3F524-60.jpg\" /></p>\r\n<p><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p>&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 17:48:44', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (139, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3F1764-60.jpg', '|/FAJxc/cms/pic_thumb/3F1764-60.jpg', 'KTV地毯(KTV-007)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3F1764-60.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:49:31', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (140, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3H378-6.jpg', '|/FAJxc/cms/pic_thumb/3H378-6.jpg', 'KTV地毯(KTV-008)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"1357\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3H378-6.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:50:33', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (141, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3H2214-10 .jpg', '|/FAJxc/cms/pic_thumb/3H2214-10 .jpg', 'KTV地毯(KTV-009)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"640\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3H2214-10%20.jpg\" /></p>\r\n<p><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:51:32', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (142, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3H2345-40 .jpg', '|/FAJxc/cms/pic_thumb/3H2345-40 .jpg', 'KTV地毯(KTV-010)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"667\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3H2345-40%20.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p>&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 17:52:41', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (143, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3I1717-10 .jpg', '|/FAJxc/cms/pic_thumb/3I1717-10 .jpg', 'KTV地毯(KTV-011)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"747\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3I1717-10%20.jpg\" /></p>\r\n<p><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:53:46', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (144, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3I1718-60 .jpg', '|/FAJxc/cms/pic_thumb/3I1718-60 .jpg', 'KTV地毯(KTV-012)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"747\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3I1718-60%20.jpg\" /><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:54:46', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (145, NULL, NULL, '', '', NULL, '', 0, '', '|/FAJxc/cms/pic/3L734-10 .jpg', '|/FAJxc/cms/pic_thumb/3L734-10 .jpg', 'KTV地毯(KTV-013)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"718\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3L734-10%20.jpg\" /></p>\r\n<p><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-18 10:17:13', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (146, NULL, NULL, '', '', NULL, '', 1, '', '|/FAJxc/cms/pic/3Q663-60 .jpg', '|/FAJxc/cms/pic_thumb/3Q663-60 .jpg', 'KTV地毯(KTV-014)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"751\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3Q663-60%20.jpg\" /><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:57:03', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (147, NULL, NULL, '', '', NULL, '', 0, '', '|/FAJxc/cms/pic/3R909-30.jpg', '|/FAJxc/cms/pic_thumb/006.jpg', 'KTV地毯(KTV-015)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"481\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/3R909-30.jpg\" /><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-18 10:16:10', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (148, 99, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/006.jpg', '|/FAJxc/cms/pic_thumb/006.jpg', '酒店地毯(Hotel-016)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"533\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/006.jpg\" /></p>\r\n<p>&nbsp;</p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-18 11:11:07', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (149, 98, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/0B879-G24.jpg', '|/FAJxc/cms/pic_thumb/0B879-G24.jpg', '酒店地毯(Hotel-017)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"547\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/0B879-G24.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德地毯', 0, 0, '2013-07-18 10:15:01', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (150, 97, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/047.jpg', '|/FAJxc/cms/pic_thumb/047.jpg', '酒店地毯(Hotel-018)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"536\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/047.jpg\" /></p>\r\n<p style=\"text-align: left\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德地毯', 0, 0, '2013-07-17 16:38:11', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (151, 96, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/046.jpg', '|/FAJxc/cms/pic_thumb/046.jpg', '酒店地毯(Hotel-019)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"534\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/046.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:40:49', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (152, 95, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/045.jpg', '|/FAJxc/cms/pic_thumb/045.jpg', '酒店地毯(Hotel-020)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"534\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/045.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:44:12', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (153, 94, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/044.jpg', '|/FAJxc/cms/pic_thumb/044.jpg', '酒店地毯(Hotel-021)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"531\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/044.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:45:41', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (154, 93, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/043.jpg', '|/FAJxc/cms/pic_thumb/043.jpg', '酒店地毯(Hotel-022)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"549\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/043.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德地毯', 0, 0, '2013-07-17 16:47:45', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (155, 92, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/042.jpg', '|/FAJxc/cms/pic_thumb/042.jpg', '酒店地毯(Hotel-023)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"546\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/042.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:51:32', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (156, 91, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/040.jpg', '|/FAJxc/cms/pic_thumb/040.jpg', '酒店地毯(Hotel-024)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"554\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/040.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。<br />\r\n&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 16:56:09', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (157, 90, 42, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/037.jpg', '|/FAJxc/cms/pic_thumb/037.jpg', '酒店地毯(Hotel-025)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"561\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/037.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 1, 0, '2013-07-18 10:13:11', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (158, 89, 42, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/036.jpg', '|/FAJxc/cms/pic_thumb/036.jpg', '酒店地毯(Hotel-026)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"548\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/036.jpg\" /></p>\r\n<p style=\"text-align: center\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 16:59:15', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (159, 88, 42, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/035.jpg', '|/FAJxc/cms/pic_thumb/035.jpg', '酒店地毯(Hotel-027)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"544\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/035.jpg\" /></p>\r\n<p style=\"text-align: center\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:00:31', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (160, 87, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/034.jpg', '|/FAJxc/cms/pic_thumb/034.jpg', '酒店地毯(Hotel-028)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"546\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/034.jpg\" /></p>\r\n<p style=\"text-align: center\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德出品', 0, 1, '2013-07-17 17:02:03', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (161, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/028.jpg', '|/FAJxc/cms/pic_thumb/028.jpg', '酒店地毯(Hotel-028)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"533\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/028.jpg\" /></p>\r\n<p>&nbsp;</p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:31:41', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (162, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/027.jpg', '|/FAJxc/cms/pic_thumb/027.jpg', '酒店地毯(Hotel-029)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"547\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/027.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德地毯', 0, 0, '2013-07-18 10:15:01', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (163, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/026.jpg', '|/FAJxc/cms/pic_thumb/026.jpg', '酒店地毯(Hotel-030)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"536\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/026.jpg\" /></p>\r\n<p style=\"text-align: left\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德地毯', 0, 0, '2013-07-17 16:38:11', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (164, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/025.jpg', '|/FAJxc/cms/pic_thumb/025.jpg', '酒店地毯(Hotel-031)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"534\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/025.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:40:49', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (165, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/024.jpg', '|/FAJxc/cms/pic_thumb/024.jpg', '酒店地毯(Hotel-032)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"534\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/024.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:44:12', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (166, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/023.jpg', '|/FAJxc/cms/pic_thumb/023.jpg', '酒店地毯(Hotel-033)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"531\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/023.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:45:41', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (167, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/022.jpg', '|/FAJxc/cms/pic_thumb/022.jpg', '酒店地毯(Hotel-034)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"549\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/022.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德地毯', 0, 0, '2013-07-17 16:47:45', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (168, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/021.jpg', '|/FAJxc/cms/pic_thumb/021.jpg', '酒店地毯(Hotel-035)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"546\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/021.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:51:32', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (169, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/018.jpg', '|/FAJxc/cms/pic_thumb/018.jpg', '酒店地毯(Hotel-036)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"554\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/018.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。<br />\r\n&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 16:56:09', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (170, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/017.jpg', '|/FAJxc/cms/pic_thumb/017.jpg', '酒店地毯(Hotel-037)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"561\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/017.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-18 10:13:11', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (171, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/016.jpg', '|/FAJxc/cms/pic_thumb/016.jpg', '酒店地毯(Hotel-038)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"548\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/016.jpg\" /></p>\r\n<p style=\"text-align: center\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 16:59:15', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (172, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/015.jpg', '|/FAJxc/cms/pic_thumb/015.jpg', '酒店地毯(Hotel-039)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"544\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/015.jpg\" /></p>\r\n<p style=\"text-align: center\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:00:31', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (173, NULL, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/009.jpg', '|/FAJxc/cms/pic_thumb/009.jpg', '酒店地毯(Hotel-040)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"546\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/009.jpg\" /></p>\r\n<p style=\"text-align: center\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德出品', 0, 1, '2013-07-17 17:02:03', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (174, 45, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/013.jpg', '|/FAJxc/cms/pic_thumb/013.jpg', '酒店地毯(Hotel-041)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"549\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/013.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德地毯', 0, 0, '2013-07-17 16:47:45', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (175, 75, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/012.jpg', '|/FAJxc/cms/pic_thumb/012.jpg', '酒店地毯(Hotel-042)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"546\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/012.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 16:51:32', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (176, 77, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/011.jpg', '|/FAJxc/cms/pic_thumb/011.jpg', '酒店地毯(Hotel-043)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"554\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/011.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。<br />\r\n&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 16:56:09', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (177, 77, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/010.jpg', '|/FAJxc/cms/pic_thumb/010.jpg', '酒店地毯(Hotel-044)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"561\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/010.jpg\" /></p>\r\n<p style=\"text-align: left\">此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-18 10:13:11', NULL, '2013-07-18 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (178, 89, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/008.jpg', '|/FAJxc/cms/pic_thumb/008.jpg', '酒店地毯(Hotel-045)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"548\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/008.jpg\" /></p>\r\n<p style=\"text-align: center\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>\r\n<p style=\"text-align: center\">&nbsp;</p>', '恩德出品', 0, 0, '2013-07-17 16:59:15', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (179, 9, NULL, NULL, '', NULL, NULL, 1, NULL, '|/FAJxc/cms/pic/007.jpg', '|/FAJxc/cms/pic_thumb/007.jpg', '酒店地毯(Hotel-046)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：酒店地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p style=\"text-align: center\"><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"544\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/007.jpg\" /></p>\r\n<p style=\"text-align: center\"><br />\r\n此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-17 17:00:31', NULL, '2013-07-17 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (180, 99, NULL, '', '', NULL, '', 0, '', '|/FAJxc/cms/pic/029.jpg', '|/FAJxc/cms/pic_thumb/029.jpg', 'KTV地毯(KTV-016)', NULL, NULL, '', '当前价格：暂无\r\n最小起订量：面议\r\n供应总量：面议\r\n发货日期：面议\r\n品 牌：恩元地毯\r\n\r\n型 号：KTV地毯\r\n材 质：可选\r\n规 格：可选\r\n用 途：公共设施用\r\n厚 度：可选\r\n幅 宽：可选', '<p><em>测试</em></p>\r\n<p style=\"text-align: center;\"><strong><span style=\"font-size: xx-large;\"><span style=\"font-family: Tahoma;\">测试</span></span></strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\">aaaaasdf</p>\r\n<p><u>测试</u></p>\r\n<p>测试</p>\r\n<p><img id=\"imga1\" alt=\"图片规格\" width=\"1000\" height=\"678\" src=\"http://192.168.1.13:8080/FAJxc/cms/pic/029.jpg\" /></p>\r\n<p>此款地毯毯面平整、丰满，风格富丽堂皇，达到国际商业重量级地毯标准。具有卓越的外观保持性、耐用性、稳定性、舒适性，经久耐用。适用于酒店餐厅、走道、宴会厅、酒吧、会议室等公共场所。欢迎广大客户来电咨询。</p>', '恩德出品', 0, 0, '2013-07-26 17:58:13', NULL, '2013-07-26 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (181, 2, 46, '', 'aa', NULL, '', 0, '', '|/FAJxc_V4/cms/pic/222.jpg|/FAJxc_V4/cms/pic/222.jpg', '|/FAJxc_V4/cms/pic_thumb/222.jpg|/FAJxc_V4/cms/pic_thumb/222.jpg', '111', NULL, NULL, '222', '<p>aafsadfsadf</p>', '<p>asdfgagasdgasdfg</p>', '4234', 1, 0, '2013-08-14 14:45:32', NULL, '2013-08-14 14:45:42', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (182, NULL, NULL, NULL, '', NULL, NULL, 0, NULL, '|/FAJxc/cms/pic/021.jpg', '|/FAJxc/cms/pic_thumb/021.jpg', '测试', NULL, NULL, '测试', '测试\r\n\r\n测试', '<p>safsafsdfasfd</p>', '测试', 0, 0, '2013-08-02 16:41:49', NULL, '2013-08-02 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (183, NULL, NULL, NULL, '', NULL, NULL, 0, NULL, '|/FAJxc/cms/pic/022.jpg', '|/FAJxc/cms/pic_thumb/022.jpg', 'fsad', NULL, NULL, 'fsaf', 'fasfd', '<p>fasfasfd</p>', 'dsfas', 1, 0, '2013-08-02 16:42:20', NULL, '2013-08-02 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (184, NULL, NULL, NULL, '', NULL, NULL, 0, NULL, '|/FAJxc/cms/pic/024.jpg', '|/FAJxc/cms/pic_thumb/024.jpg', 'fasfa', NULL, NULL, 'fa', 'fsadf', '<p>fsafdasfd</p>', 'fasdf', 1, 0, '2013-08-02 16:42:44', NULL, '2013-08-02 00:00:00', NULL, NULL, NULL, NULL);
INSERT INTO `fa_cms_news` VALUES (185, NULL, NULL, NULL, '', NULL, NULL, 0, NULL, '|/FAJxc/cms/pic/026.jpg', '|/FAJxc/cms/pic_thumb/026.jpg', 'dfaav', NULL, NULL, 'fdsaf', 'fasfd', '<p>fsafdsaf</p>', 'sadf', 1, 0, '2013-08-02 16:43:08', NULL, '2013-08-02 00:00:00', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for fa_cms_newsfp
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_newsfp`;
CREATE TABLE `fa_cms_newsfp`  (
  `fid` smallint(6) NOT NULL AUTO_INCREMENT,
  `f` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fform` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `fhtml` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fzs` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `isadd` tinyint(1) NOT NULL DEFAULT 0,
  `isshow` tinyint(1) NOT NULL DEFAULT 0,
  `iscj` tinyint(1) NOT NULL DEFAULT 0,
  `myorder` smallint(6) NOT NULL DEFAULT 0,
  `ftype` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `flen` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `dotemp` tinyint(1) NOT NULL DEFAULT 0,
  `tid` smallint(6) NOT NULL DEFAULT 0,
  `tbname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `savetxt` tinyint(1) NOT NULL DEFAULT 0,
  `iskey` tinyint(1) NOT NULL DEFAULT 0,
  `tobr` tinyint(1) NOT NULL DEFAULT 0,
  `dohtml` tinyint(1) NOT NULL DEFAULT 0,
  `isonly` tinyint(1) NOT NULL DEFAULT 0,
  `linkfieldval` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `samedata` tinyint(1) NOT NULL DEFAULT 0,
  `fformsize` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tbdataf` tinyint(1) NOT NULL DEFAULT 0,
  `ispage` tinyint(1) NOT NULL DEFAULT 0,
  `adddofun` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `editdofun` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `qadddofun` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `qeditdofun` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `linkfieldtb` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `linkfieldshow` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `editorys` tinyint(1) NOT NULL DEFAULT 0,
  `issmalltext` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`fid`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 123 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_cms_newsfp
-- ----------------------------
INSERT INTO `fa_cms_newsfp` VALUES (1, 'title', '标题', 'text', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">\r\n<?=$tts?\\\"<select name=\\\'ttid\\\'><option value=\\\'0\\\'>标题分类</option>$tts</select>\\\":\\\"\\\"?>\r\n	<input type=text name=title value=\\\"<?=htmlspecialchars(stripSlashes($r[title]))?>\\\" size=\\\"60\\\"> \r\n	<input type=\\\"button\\\" name=\\\"button\\\" value=\\\"图文\\\" onclick=\\\"document.add.title.value=document.add.title.value+\\\'(图文)\\\';\\\"> \r\n  </td>\r\n</tr>\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">属性: \r\n	<input name=\\\"titlefont[b]\\\" type=\\\"checkbox\\\" value=\\\"b\\\"<?=$titlefontb?>>粗体\r\n	<input name=\\\"titlefont[i]\\\" type=\\\"checkbox\\\" value=\\\"i\\\"<?=$titlefonti?>>斜体\r\n	<input name=\\\"titlefont[s]\\\" type=\\\"checkbox\\\" value=\\\"s\\\"<?=$titlefonts?>>删除线\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;颜色: <input name=\\\"titlecolor\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titlecolor])?>\\\" size=\\\"10\\\"><a onclick=\\\"foreColor();\\\"><img src=\\\"../data/images/color.gif\\\" width=\\\"21\\\" height=\\\"21\\\" align=\\\"absbottom\\\"></a>\r\n  </td>\r\n</tr>\r\n</table>', '标题', 0, 1, 1, 0, 'CHAR', '200', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (2, 'special.field', '特殊属性', '', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">信息属性: \r\n      <input name=\\\"checked\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[checked]?\\\' checked\\\':\\\'\\\'?>>\r\n      审核 &nbsp;&nbsp; 推荐 \r\n      <select name=\\\"isgood\\\" id=\\\"isgood\\\">\r\n        <option value=\\\"0\\\"<?=$r[isgood]==0?\\\' selected\\\':\\\'\\\'?>>不推荐</option>\r\n        <option value=\\\"1\\\"<?=$r[isgood]==1?\\\' selected\\\':\\\'\\\'?>>一级推荐</option>\r\n        <option value=\\\"2\\\"<?=$r[isgood]==2?\\\' selected\\\':\\\'\\\'?>>二级推荐</option>\r\n        <option value=\\\"3\\\"<?=$r[isgood]==3?\\\' selected\\\':\\\'\\\'?>>三级推荐</option>\r\n        <option value=\\\"4\\\"<?=$r[isgood]==4?\\\' selected\\\':\\\'\\\'?>>四级推荐</option>\r\n        <option value=\\\"5\\\"<?=$r[isgood]==5?\\\' selected\\\':\\\'\\\'?>>五级推荐</option>\r\n        <option value=\\\"6\\\"<?=$r[isgood]==6?\\\' selected\\\':\\\'\\\'?>>六级推荐</option>\r\n        <option value=\\\"7\\\"<?=$r[isgood]==7?\\\' selected\\\':\\\'\\\'?>>七级推荐</option>\r\n        <option value=\\\"8\\\"<?=$r[isgood]==8?\\\' selected\\\':\\\'\\\'?>>八级推荐</option>\r\n        <option value=\\\"9\\\"<?=$r[isgood]==9?\\\' selected\\\':\\\'\\\'?>>九级推荐</option>\r\n      </select>\r\n      &nbsp;&nbsp; 头条 \r\n      <select name=\\\"firsttitle\\\" id=\\\"firsttitle\\\">\r\n        <option value=\\\"0\\\"<?=$r[firsttitle]==0?\\\' selected\\\':\\\'\\\'?>>非头条</option>\r\n        <option value=\\\"1\\\"<?=$r[firsttitle]==1?\\\' selected\\\':\\\'\\\'?>>一级头条</option>\r\n        <option value=\\\"2\\\"<?=$r[firsttitle]==2?\\\' selected\\\':\\\'\\\'?>>二级头条</option>\r\n        <option value=\\\"3\\\"<?=$r[firsttitle]==3?\\\' selected\\\':\\\'\\\'?>>三级头条</option>\r\n        <option value=\\\"4\\\"<?=$r[firsttitle]==4?\\\' selected\\\':\\\'\\\'?>>四级头条</option>\r\n        <option value=\\\"5\\\"<?=$r[firsttitle]==5?\\\' selected\\\':\\\'\\\'?>>五级头条</option>\r\n        <option value=\\\"6\\\"<?=$r[firsttitle]==6?\\\' selected\\\':\\\'\\\'?>>六级头条</option>\r\n        <option value=\\\"7\\\"<?=$r[firsttitle]==7?\\\' selected\\\':\\\'\\\'?>>七级头条</option>\r\n        <option value=\\\"8\\\"<?=$r[firsttitle]==8?\\\' selected\\\':\\\'\\\'?>>八级头条</option>\r\n        <option value=\\\"9\\\"<?=$r[firsttitle]==9?\\\' selected\\\':\\\'\\\'?>>九级头条</option>\r\n      </select></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">关键字&nbsp;&nbsp;&nbsp;: \r\n      <input name=\\\"keyboard\\\" type=\\\"text\\\" size=\\\"52\\\" value=\\\"<?=stripSlashes($r[keyboard])?>\\\">\r\n      <font color=\\\"#666666\\\">(多个请用&quot;,&quot;隔开)</font></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">外部链接: \r\n      <input name=\\\"titleurl\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titleurl])?>\\\" size=\\\"52\\\">\r\n      <font color=\\\"#666666\\\">(填写后信息连接地址将为此链接)</font></td>\r\n  </tr>\r\n</table>\r\n', '特殊属性', 0, 1, 0, 1, '', '', 0, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (3, 'titlepic', '标题图片', 'img', '\r\n<input name=\\\"titlepic\\\" type=\\\"text\\\" id=\\\"titlepic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[titlepic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=titlepic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '标题图片', 0, 1, 1, 2, 'CHAR', '200', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (4, 'newstime', '发布时间', 'text', '<input name=\\\"newstime\\\" type=\\\"text\\\" value=\\\"<?=$r[newstime]?>\\\"><input type=button name=button value=\\\"设为当前时间\\\" onclick=\\\"document.add.newstime.value=\\\'<?=$todaytime?>\\\'\\\">', '发布时间', 0, 1, 1, 1, 'INT', '10', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (5, 'ftitle', '副标题', 'text', '<input name=\\\"ftitle\\\" type=\\\"text\\\" size=60 id=\\\"ftitle\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[ftitle]))?>\\\">\r\n', '副标题', 1, 1, 1, 0, 'CHAR', '120', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (6, 'smalltext', '内容简介', 'textarea', '<textarea name=\\\"smalltext\\\" cols=\\\"80\\\" rows=\\\"10\\\" id=\\\"smalltext\\\"><?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[smalltext]))?></textarea>\r\n', '内容简介', 1, 1, 1, 2, 'CHAR', '255', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 1);
INSERT INTO `fa_cms_newsfp` VALUES (7, 'writer', '作者', 'text', '\r\n<?php\r\n$writer_sql=$empire->query(\\\"select writer from {$dbtbpre}enewswriter\\\");\r\nwhile($w_r=$empire->fetch($writer_sql))\r\n{\r\n	$w_class.=\\\"<option value=\\\'\\\".$w_r[writer].\\\"\\\'>\\\".$w_r[writer].\\\"</option>\\\";\r\n}\r\n?>\r\n<input type=text name=writer value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[writer]))?>\\\" size=\\\"\\\"> \r\n        <select name=\\\"w_id\\\" id=\\\"select7\\\" onchange=\\\"document.add.writer.value=document.add.w_id.value\\\">\r\n          <option>选择作者</option>\r\n		  <?=$w_class?>\r\n        </select>\r\n<input type=\\\"button\\\" name=\\\"wbutton\\\" value=\\\"增加作者\\\" onclick=\\\"window.open(\\\'NewsSys/writer.php?addwritername=\\\'+document.add.writer.value);\\\">\r\n', '作者', 1, 1, 1, 2, 'VARCHAR', '30', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (8, 'befrom', '信息来源', 'text', '\r\n<?php\r\n$befrom_sql=$empire->query(\\\"select sitename from {$dbtbpre}enewsbefrom\\\");\r\nwhile($b_r=$empire->fetch($befrom_sql))\r\n{\r\n	$b_class.=\\\"<option value=\\\'\\\".$b_r[sitename].\\\"\\\'>\\\".$b_r[sitename].\\\"</option>\\\";\r\n}\r\n?>\r\n<input type=\\\"text\\\" name=\\\"befrom\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[befrom]))?>\\\" size=\\\"\\\"> \r\n        <select name=\\\"befrom_id\\\" id=\\\"befromid\\\" onchange=\\\"document.add.befrom.value=document.add.befrom_id.value\\\">\r\n          <option>选择信息来源</option>\r\n          <?=$b_class?>\r\n        </select>\r\n<input type=\\\"button\\\" name=\\\"wbutton\\\" value=\\\"增加来源\\\" onclick=\\\"window.open(\\\'NewsSys/BeFrom.php?addsitename=\\\'+document.add.befrom.value);\\\">\r\n', '信息来源', 1, 1, 1, 2, 'VARCHAR', '60', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (9, 'newstext', '新闻正文', 'editor', '<?=ECMS_ShowEditorVar(\\\"newstext\\\",$ecmsfirstpost==1?\\\"\\\":stripSlashes($r[newstext]),\\\"Default\\\",\\\"\\\",\\\"300\\\",\\\"100%\\\")?>\r\n<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"3\\\" cellspacing=\\\"1\\\" bgcolor=\\\"#DBEAF5\\\">\r\n          <tr> \r\n            <td bgcolor=\\\"#FFFFFF\\\"> <input name=\\\"dokey\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[dokey]==1?\\\' checked\\\':\\\'\\\'?>>\r\n              关键字替换&nbsp;&nbsp; <input name=\\\"copyimg\\\" type=\\\"checkbox\\\" id=\\\"copyimg\\\" value=\\\"1\\\">\r\n      远程保存图片(\r\n      <input name=\\\"mark\\\" type=\\\"checkbox\\\" id=\\\"mark\\\" value=\\\"1\\\">\r\n      <a href=\\\"SetEnews.php\\\" target=\\\"_blank\\\">加水印</a>)&nbsp;&nbsp; \r\n      <input name=\\\"copyflash\\\" type=\\\"checkbox\\\" id=\\\"copyflash\\\" value=\\\"1\\\">\r\n      远程保存FLASH(地址前缀： \r\n      <input name=\\\"qz_url\\\" type=\\\"text\\\" id=\\\"qz_url\\\" size=\\\"\\\">\r\n              )</td>\r\n          </tr>\r\n          <tr>\r\n            \r\n    <td bgcolor=\\\"#FFFFFF\\\"><input name=\\\"repimgnexturl\\\" type=\\\"checkbox\\\" id=\\\"repimgnexturl\\\" value=\\\"1\\\"> 图片链接转为下一页&nbsp;&nbsp; <input name=\\\"autopage\\\" type=\\\"checkbox\\\" id=\\\"autopage\\\" value=\\\"1\\\">自动分页\r\n      ,每 \r\n      <input name=\\\"autosize\\\" type=\\\"text\\\" id=\\\"autosize\\\" value=\\\"5000\\\" size=\\\"5\\\">\r\n      个字节为一页&nbsp;&nbsp; 取第 \r\n      <input name=\\\"getfirsttitlepic\\\" type=\\\"text\\\" id=\\\"getfirsttitlepic\\\" value=\\\"\\\" size=\\\"1\\\">\r\n      张上传图为标题图片( \r\n      <input name=\\\"getfirsttitlespic\\\" type=\\\"checkbox\\\" id=\\\"getfirsttitlespic\\\" value=\\\"1\\\">\r\n      缩略图: 宽 \r\n      <input name=\\\"getfirsttitlespicw\\\" type=\\\"text\\\" id=\\\"getfirsttitlespicw\\\" size=\\\"3\\\" value=\\\"<?=$public_r[spicwidth]?>\\\">\r\n      *高\r\n      <input name=\\\"getfirsttitlespich\\\" type=\\\"text\\\" id=\\\"getfirsttitlespich\\\" size=\\\"3\\\" value=\\\"<?=$public_r[spicheight]?>\\\">\r\n      )</td>\r\n          </tr>\r\n        </table>\r\n', '新闻正文', 1, 1, 1, 2, 'MEDIUMTEXT', '', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 1, 1, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (10, 'title', '标题', 'text', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">\r\n<?=$tts?\\\"<select name=\\\'ttid\\\'><option value=\\\'0\\\'>标题分类</option>$tts</select>\\\":\\\"\\\"?>\r\n	<input type=text name=title value=\\\"<?=htmlspecialchars(stripSlashes($r[title]))?>\\\" size=\\\"60\\\"> \r\n	<input type=\\\"button\\\" name=\\\"button\\\" value=\\\"图文\\\" onclick=\\\"document.add.title.value=document.add.title.value+\\\'(图文)\\\';\\\"> \r\n  </td>\r\n</tr>\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">属性: \r\n	<input name=\\\"titlefont[b]\\\" type=\\\"checkbox\\\" value=\\\"b\\\"<?=$titlefontb?>>粗体\r\n	<input name=\\\"titlefont[i]\\\" type=\\\"checkbox\\\" value=\\\"i\\\"<?=$titlefonti?>>斜体\r\n	<input name=\\\"titlefont[s]\\\" type=\\\"checkbox\\\" value=\\\"s\\\"<?=$titlefonts?>>删除线\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;颜色: <input name=\\\"titlecolor\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titlecolor])?>\\\" size=\\\"10\\\"><a onclick=\\\"foreColor();\\\"><img src=\\\"../data/images/color.gif\\\" width=\\\"21\\\" height=\\\"21\\\" align=\\\"absbottom\\\"></a>\r\n  </td>\r\n</tr>\r\n</table>', '标题', 0, 1, 1, 0, 'VARCHAR', '200', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (11, 'special.field', '特殊属性', '', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">信息属性: \r\n      <input name=\\\"checked\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[checked]?\\\' checked\\\':\\\'\\\'?>>\r\n      审核 &nbsp;&nbsp; 推荐 \r\n      <select name=\\\"isgood\\\" id=\\\"isgood\\\">\r\n        <option value=\\\"0\\\"<?=$r[isgood]==0?\\\' selected\\\':\\\'\\\'?>>不推荐</option>\r\n        <option value=\\\"1\\\"<?=$r[isgood]==1?\\\' selected\\\':\\\'\\\'?>>一级推荐</option>\r\n        <option value=\\\"2\\\"<?=$r[isgood]==2?\\\' selected\\\':\\\'\\\'?>>二级推荐</option>\r\n        <option value=\\\"3\\\"<?=$r[isgood]==3?\\\' selected\\\':\\\'\\\'?>>三级推荐</option>\r\n        <option value=\\\"4\\\"<?=$r[isgood]==4?\\\' selected\\\':\\\'\\\'?>>四级推荐</option>\r\n        <option value=\\\"5\\\"<?=$r[isgood]==5?\\\' selected\\\':\\\'\\\'?>>五级推荐</option>\r\n        <option value=\\\"6\\\"<?=$r[isgood]==6?\\\' selected\\\':\\\'\\\'?>>六级推荐</option>\r\n        <option value=\\\"7\\\"<?=$r[isgood]==7?\\\' selected\\\':\\\'\\\'?>>七级推荐</option>\r\n        <option value=\\\"8\\\"<?=$r[isgood]==8?\\\' selected\\\':\\\'\\\'?>>八级推荐</option>\r\n        <option value=\\\"9\\\"<?=$r[isgood]==9?\\\' selected\\\':\\\'\\\'?>>九级推荐</option>\r\n      </select>\r\n      &nbsp;&nbsp; 头条 \r\n      <select name=\\\"firsttitle\\\" id=\\\"firsttitle\\\">\r\n        <option value=\\\"0\\\"<?=$r[firsttitle]==0?\\\' selected\\\':\\\'\\\'?>>非头条</option>\r\n        <option value=\\\"1\\\"<?=$r[firsttitle]==1?\\\' selected\\\':\\\'\\\'?>>一级头条</option>\r\n        <option value=\\\"2\\\"<?=$r[firsttitle]==2?\\\' selected\\\':\\\'\\\'?>>二级头条</option>\r\n        <option value=\\\"3\\\"<?=$r[firsttitle]==3?\\\' selected\\\':\\\'\\\'?>>三级头条</option>\r\n        <option value=\\\"4\\\"<?=$r[firsttitle]==4?\\\' selected\\\':\\\'\\\'?>>四级头条</option>\r\n        <option value=\\\"5\\\"<?=$r[firsttitle]==5?\\\' selected\\\':\\\'\\\'?>>五级头条</option>\r\n        <option value=\\\"6\\\"<?=$r[firsttitle]==6?\\\' selected\\\':\\\'\\\'?>>六级头条</option>\r\n        <option value=\\\"7\\\"<?=$r[firsttitle]==7?\\\' selected\\\':\\\'\\\'?>>七级头条</option>\r\n        <option value=\\\"8\\\"<?=$r[firsttitle]==8?\\\' selected\\\':\\\'\\\'?>>八级头条</option>\r\n        <option value=\\\"9\\\"<?=$r[firsttitle]==9?\\\' selected\\\':\\\'\\\'?>>九级头条</option>\r\n      </select></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">关键字&nbsp;&nbsp;&nbsp;: \r\n      <input name=\\\"keyboard\\\" type=\\\"text\\\" size=\\\"52\\\" value=\\\"<?=stripSlashes($r[keyboard])?>\\\">\r\n      <font color=\\\"#666666\\\">(多个请用&quot;,&quot;隔开)</font></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">外部链接: \r\n      <input name=\\\"titleurl\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titleurl])?>\\\" size=\\\"52\\\">\r\n      <font color=\\\"#666666\\\">(填写后信息连接地址将为此链接)</font></td>\r\n  </tr>\r\n</table>\r\n', '特殊属性', 0, 1, 0, 0, '', '', 0, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (12, 'titlepic', '标题图片', 'img', '\r\n<input name=\\\"titlepic\\\" type=\\\"text\\\" id=\\\"titlepic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[titlepic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=titlepic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '标题图片', 0, 1, 1, 1, 'VARCHAR', '200', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (13, 'newstime', '发布时间', 'text', '<input name=\\\"newstime\\\" type=\\\"text\\\" value=\\\"<?=$r[newstime]?>\\\"><input type=button name=button value=\\\"设为当前时间\\\" onclick=\\\"document.add.newstime.value=\\\'<?=$todaytime?>\\\'\\\">', '发布时间', 0, 1, 1, 0, 'INT', '10', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (14, 'softwriter', '作者', 'text', '<input name=\\\"softwriter\\\" type=\\\"text\\\" size=60 id=\\\"softwriter\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[softwriter]))?>\\\">\r\n', '作者', 1, 1, 1, 1, 'VARCHAR', '30', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (15, 'homepage', '官方网站', 'text', '<input name=\\\"homepage\\\" type=\\\"text\\\" size=60 id=\\\"homepage\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"http://\\\":htmlspecialchars(stripSlashes($r[homepage]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '80', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (16, 'demo', '系统演示', 'text', '<input name=\\\"demo\\\" type=\\\"text\\\" size=60 id=\\\"demo\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"http://\\\":htmlspecialchars(stripSlashes($r[demo]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '120', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (17, 'softfj', '运行环境', 'text', '<input name=\\\"softfj\\\" type=\\\"text\\\" size=60 id=\\\"softfj\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[softfj]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '255', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (18, 'language', '软件语言', 'select', '<select name=\\\"language\\\" id=\\\"language\\\"><option value=\\\"简体中文\\\"<?=$r[language]==\\\"简体中文\\\"?\\\' selected\\\':\\\'\\\'?>>简体中文</option><option value=\\\"繁体中文\\\"<?=$r[language]==\\\"繁体中文\\\"?\\\' selected\\\':\\\'\\\'?>>繁体中文</option><option value=\\\"英文\\\"<?=$r[language]==\\\"英文\\\"?\\\' selected\\\':\\\'\\\'?>>英文</option><option value=\\\"多国语言\\\"<?=$r[language]==\\\"多国语言\\\"?\\\' selected\\\':\\\'\\\'?>>多国语言</option></select>', '', 1, 1, 1, 1, 'VARCHAR', '16', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (19, 'softtype', '软件类型', 'select', '<select name=\\\"softtype\\\" id=\\\"softtype\\\"><option value=\\\"国产软件\\\"<?=$r[softtype]==\\\"国产软件\\\"?\\\' selected\\\':\\\'\\\'?>>国产软件</option><option value=\\\"汉化软件\\\"<?=$r[softtype]==\\\"汉化软件\\\"?\\\' selected\\\':\\\'\\\'?>>汉化软件</option><option value=\\\"国外软件\\\"<?=$r[softtype]==\\\"国外软件\\\"?\\\' selected\\\':\\\'\\\'?>>国外软件</option></select>', '', 1, 1, 1, 1, 'VARCHAR', '16', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (20, 'softsq', '授权形式', 'select', '<select name=\\\"softsq\\\" id=\\\"softsq\\\"><option value=\\\"共享软件\\\"<?=$r[softsq]==\\\"共享软件\\\"?\\\' selected\\\':\\\'\\\'?>>共享软件</option><option value=\\\"免费软件\\\"<?=$r[softsq]==\\\"免费软件\\\"?\\\' selected\\\':\\\'\\\'?>>免费软件</option><option value=\\\"自由软件\\\"<?=$r[softsq]==\\\"自由软件\\\"?\\\' selected\\\':\\\'\\\'?>>自由软件</option><option value=\\\"试用软件\\\"<?=$r[softsq]==\\\"试用软件\\\"?\\\' selected\\\':\\\'\\\'?>>试用软件</option><option value=\\\"演示软件\\\"<?=$r[softsq]==\\\"演示软件\\\"?\\\' selected\\\':\\\'\\\'?>>演示软件</option><option value=\\\"商业软件\\\"<?=$r[softsq]==\\\"商业软件\\\"?\\\' selected\\\':\\\'\\\'?>>商业软件</option></select>', '', 1, 1, 1, 1, 'VARCHAR', '16', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (21, 'star', '软件等级', 'select', '<select name=\\\"star\\\" id=\\\"star\\\"><option value=\\\"1\\\"<?=$r[star]==\\\"1\\\"?\\\' selected\\\':\\\'\\\'?>>1星</option><option value=\\\"2\\\"<?=$r[star]==\\\"2\\\"||$ecmsfirstpost==1?\\\' selected\\\':\\\'\\\'?>>2星</option><option value=\\\"3\\\"<?=$r[star]==\\\"3\\\"?\\\' selected\\\':\\\'\\\'?>>3星</option><option value=\\\"4\\\"<?=$r[star]==\\\"4\\\"?\\\' selected\\\':\\\'\\\'?>>4星</option><option value=\\\"5\\\"<?=$r[star]==\\\"5\\\"?\\\' selected\\\':\\\'\\\'?>>5星</option></select>', '', 1, 1, 1, 1, 'TINYINT', '1', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (22, 'filetype', '文件类型', 'text', '<input name=\\\"filetype\\\" type=\\\"text\\\" id=\\\"filetype\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[filetype]))?>\\\">\r\n<select name=\\\"select2\\\" onchange=\\\"document.add.filetype.value=this.value\\\">\r\n        <option value=\\\"\\\">类型</option>\r\n        <option value=\\\".zip\\\">.zip</option>\r\n        <option value=\\\".rar\\\">.rar</option>\r\n        <option value=\\\".exe\\\">.exe</option>\r\n      </select>', '', 1, 1, 1, 1, 'VARCHAR', '10', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (23, 'filesize', '文件大小', 'text', '<input name=\\\"filesize\\\" type=\\\"text\\\" id=\\\"filesize\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[filesize]))?>\\\">\r\n<select name=\\\"select\\\" onchange=\\\"document.add.filesize.value+=this.value\\\">\r\n        <option value=\\\"\\\">单位</option>\r\n        <option value=\\\" MB\\\">MB</option>\r\n        <option value=\\\" KB\\\">KB</option>\r\n        <option value=\\\" GB\\\">GB</option>\r\n        <option value=\\\" BYTES\\\">BYTES</option>\r\n      </select>', '', 1, 1, 1, 1, 'VARCHAR', '16', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (24, 'downpath', '下载地址', 'text', '<script>\r\nfunction doadd()\r\n{var i;\r\nvar str=\\\"\\\";\r\nvar oldi=0;\r\nvar j=0;\r\noldi=parseInt(document.add.editnum.value);\r\nfor(i=1;i<=document.add.downnum.value;i++)\r\n{\r\nj=i+oldi;\r\nstr=str+\\\"<tr><td width=7%> <div align=center>\\\"+j+\\\"</div></td><td width=19%><div align=left><input name=downname[] type=text id=downname[] value=下载地址\\\"+j+\\\" size=17></div></td><td width=40%><input name=downpath[] type=text size=36 id=downpath\\\"+j+\\\" ondblclick=SpOpenChFile(0,\\\'downpath\\\"+j+\\\"\\\')><select name=thedownqz[]><option value=\\\'\\\'>--地址前缀--</option><?=$newdownqz?></select></td><td width=21%><div align=center><select name=downuser[] id=select><option value=0>游客</option><?=$ygroup?></select></div></td><td width=13%><div align=center><input name=fen[] type=text id=fen[] value=0 size=6></div></td></tr>\\\";\r\n}\r\ndocument.getElementById(\\\"adddown\\\").innerHTML=\\\"<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\\\"+str+\\\"</table>\\\";\r\n}\r\n</script>\r\n<table width=\\\"100%\\\" border=\\\"0\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\">下载地址前缀&nbsp;:\r\n      <input name=\\\"downurl_qz\\\" type=\\\"text\\\" size=\\\"32\\\">\r\n      <select name=\\\"changeurl_qz\\\" onchange=\\\"document.add.downurl_qz.value=document.add.changeurl_qz.value\\\">\r\n        <option value=\\\"\\\" selected>选择前缀</option>\r\n        <?=$downurlqz?>\r\n      </select>\r\n	  </td>\r\n  </tr>\r\n  <tr>\r\n    <td height=\\\"25\\\">选择/上传附件:\r\n      <input name=\\\"changedown_url\\\" id=\\\"changedown_url\\\" type=\\\"text\\\" size=\\\"32\\\">\r\n      <input type=\\\"button\\\" name=\\\"Submit\\\" value=\\\"选择\\\" onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=0&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=changedown_url\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\">&nbsp;\r\n	  <input type=\\\"button\\\" name=\\\"Submit\\\" value=\\\"复制\\\" onclick=\\\"document.getElementById(\\\'changedown_url\\\').focus();document.getElementById(\\\'changedown_url\\\').select();clipboardData.setData(\\\'text\\\',document.getElementById(\\\'changedown_url\\\').value);\\\"></td>\r\n  </tr>\r\n  <tr> \r\n    <td><table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"3\\\" cellspacing=\\\"1\\\" bgcolor=\\\"#DBEAF5\\\">\r\n        <tr> \r\n          <td width=\\\"7%\\\"> <div align=\\\"center\\\">编号</div></td>\r\n          <td width=\\\"19%\\\"><div align=\\\"left\\\">下载名称</div></td>\r\n          <td width=\\\"40%\\\">下载地址 <font color=\\\"#666666\\\">(双击选择)</font></td>\r\n          <td width=\\\"21%\\\"> <div align=\\\"center\\\">权限</div></td>\r\n          <td width=\\\"13%\\\"> <div align=\\\"center\\\">点数</div></td>\r\n        </tr>\r\n      </table></td>\r\n  </tr>\r\n  <tr> \r\n    <td>\r\n    <?php\r\n    if($ecmsfirstpost==1)\r\n    {\r\n    ?>\r\n	<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\r\n	<?php\r\n	$editnum=3;\r\n	for($pathi=1;$pathi<=$editnum;$pathi++)\r\n	{\r\n	?>\r\n           <tr> \r\n              <td width=\\\'7%\\\'> <div align=center><?=$pathi?></div></td>\r\n              <td width=\\\'19%\\\'> <div align=left> \r\n                  <input name=downname[] type=text value=\\\'下载地址<?=$pathi?>\\\' size=17>\r\n                    </div></td>\r\n              <td width=\\\'40%\\\'>\r\n	      <input name=downpath[] type=text size=36 id=\\\'downpath<?=$pathi?>\\\' ondblclick=\\\"SpOpenChFile(0,\\\'downpath<?=$pathi?>\\\');\\\">\r\n	      <select name=thedownqz[]><option value=\\\'\\\'>--地址前缀--</option><?=$newdownqz?></select> \r\n                  </td>\r\n                  <td width=\\\'21%\\\'><div align=center> \r\n                      <select name=downuser[]>\r\n                        <option value=0>游客</option>\r\n                        <?=$ygroup?>\r\n                      </select>\r\n                    </div></td>\r\n                  <td width=\\\'13%\\\'> <div align=center> \r\n                      <input name=fen[] type=text value=0 size=6>\r\n                    </div></td>\r\n            </tr>\r\n	<?php\r\n	}\r\n	?>\r\n	</table>\r\n    <?php\r\n    }\r\n    else\r\n    {\r\n	$editnum=0;\r\n	$downloadpath=\\\"\\\";\r\n	if($r[downpath])\r\n	{\r\n		$r[downpath]=stripSlashes($r[downpath]);\r\n		//下载地址\r\n		$j=0;\r\n		$d_record=explode(\\\"\\\\r\\\\n\\\",$r[downpath]);\r\n		for($i=0;$i<count($d_record);$i++)\r\n		{\r\n			$j=$i+1;\r\n			$d_field=explode(\\\"::::::\\\",$d_record[$i]);\r\n			//权限\r\n			$tgroup=str_replace(\\\" value=\\\".$d_field[2].\\\">\\\",\\\" value=\\\".$d_field[2].\\\" selected>\\\",$ygroup);\r\n			//地址前缀\r\n			$tnewdownqz=str_replace(\\\" value=\\\'\\\".$d_field[4].\\\"\\\'>\\\",\\\" value=\\\'\\\".$d_field[4].\\\"\\\' selected>\\\",$newdownqz);\r\n			$downloadpath.=\\\"<tr><td width=\\\'7%\\\'><div align=center>\\\".$j.\\\"</div></td><td width=\\\'19%\\\'><div align=left><input name=downname[] type=text id=downname[] value=\\\'\\\".$d_field[0].\\\"\\\' size=17></div></td><td width=\\\'40%\\\'><input name=downpath[] type=text id=downpath\\\".$j.\\\" value=\\\'\\\".$d_field[1].\\\"\\\' size=36 ondblclick=\\\\\\\"SpOpenChFile(0,\\\'downpath\\\".$j.\\\"\\\');\\\\\\\"><select name=thedownqz[]><option value=\\\'\\\'>--地址前缀--</option>\\\".$tnewdownqz.\\\"</select><input type=hidden name=pathid[] value=\\\".$j.\\\"><input type=checkbox name=delpathid[] value=\\\".$j.\\\">删</td><td width=\\\'21%\\\'><div align=center><select name=downuser[] id=select><option value=0>游客</option>\\\".$tgroup.\\\"</select></div></td><td width=\\\'13%\\\'><div align=center><input name=fen[] type=text id=fen[] value=\\\'\\\".$d_field[3].\\\"\\\' size=6></div></td></tr>\\\";\r\n		}\r\n		$editnum=$j;\r\n		$downloadpath=\\\"<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\\\".$downloadpath.\\\"</table>\\\";\r\n	}\r\n	echo $downloadpath;\r\n    }\r\n    ?>\r\n    </td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\">下载地址扩展数量: <input name=\\\"editnum\\\" type=\\\"hidden\\\" id=\\\"editnum\\\" value=\\\"<?=$editnum?>\\\">\r\n      <input name=\\\"downnum\\\" type=\\\"text\\\" id=\\\"downnum\\\" value=\\\"1\\\" size=\\\"6\\\"> <input type=\\\"button\\\" name=\\\"Submit5\\\" value=\\\"输出地址\\\" onclick=\\\"javascript:doadd();\\\"></td>\r\n  </tr>\r\n  <tr> \r\n    <td id=adddown></td>\r\n  </tr>\r\n</table>\r\n', '', 1, 1, 1, 1, 'MEDIUMTEXT', '', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (25, 'softsay', '软件简介', 'textarea', '<textarea name=\\\"softsay\\\" cols=\\\"80\\\" rows=\\\"10\\\" id=\\\"softsay\\\"><?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[softsay]))?></textarea>\r\n', '', 1, 1, 1, 1, 'TEXT', '', 1, 2, 'download', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 1);
INSERT INTO `fa_cms_newsfp` VALUES (26, 'title', '标题', 'text', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">\r\n<?=$tts?\\\"<select name=\\\'ttid\\\'><option value=\\\'0\\\'>标题分类</option>$tts</select>\\\":\\\"\\\"?>\r\n	<input type=text name=title value=\\\"<?=htmlspecialchars(stripSlashes($r[title]))?>\\\" size=\\\"60\\\"> \r\n	<input type=\\\"button\\\" name=\\\"button\\\" value=\\\"图文\\\" onclick=\\\"document.add.title.value=document.add.title.value+\\\'(图文)\\\';\\\"> \r\n  </td>\r\n</tr>\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">属性: \r\n	<input name=\\\"titlefont[b]\\\" type=\\\"checkbox\\\" value=\\\"b\\\"<?=$titlefontb?>>粗体\r\n	<input name=\\\"titlefont[i]\\\" type=\\\"checkbox\\\" value=\\\"i\\\"<?=$titlefonti?>>斜体\r\n	<input name=\\\"titlefont[s]\\\" type=\\\"checkbox\\\" value=\\\"s\\\"<?=$titlefonts?>>删除线\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;颜色: <input name=\\\"titlecolor\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titlecolor])?>\\\" size=\\\"10\\\"><a onclick=\\\"foreColor();\\\"><img src=\\\"../data/images/color.gif\\\" width=\\\"21\\\" height=\\\"21\\\" align=\\\"absbottom\\\"></a>\r\n  </td>\r\n</tr>\r\n</table>', '标题', 0, 1, 1, 0, 'VARCHAR', '200', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (27, 'special.field', '特殊属性', '', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">信息属性: \r\n      <input name=\\\"checked\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[checked]?\\\' checked\\\':\\\'\\\'?>>\r\n      审核 &nbsp;&nbsp; 推荐 \r\n      <select name=\\\"isgood\\\" id=\\\"isgood\\\">\r\n        <option value=\\\"0\\\"<?=$r[isgood]==0?\\\' selected\\\':\\\'\\\'?>>不推荐</option>\r\n        <option value=\\\"1\\\"<?=$r[isgood]==1?\\\' selected\\\':\\\'\\\'?>>一级推荐</option>\r\n        <option value=\\\"2\\\"<?=$r[isgood]==2?\\\' selected\\\':\\\'\\\'?>>二级推荐</option>\r\n        <option value=\\\"3\\\"<?=$r[isgood]==3?\\\' selected\\\':\\\'\\\'?>>三级推荐</option>\r\n        <option value=\\\"4\\\"<?=$r[isgood]==4?\\\' selected\\\':\\\'\\\'?>>四级推荐</option>\r\n        <option value=\\\"5\\\"<?=$r[isgood]==5?\\\' selected\\\':\\\'\\\'?>>五级推荐</option>\r\n        <option value=\\\"6\\\"<?=$r[isgood]==6?\\\' selected\\\':\\\'\\\'?>>六级推荐</option>\r\n        <option value=\\\"7\\\"<?=$r[isgood]==7?\\\' selected\\\':\\\'\\\'?>>七级推荐</option>\r\n        <option value=\\\"8\\\"<?=$r[isgood]==8?\\\' selected\\\':\\\'\\\'?>>八级推荐</option>\r\n        <option value=\\\"9\\\"<?=$r[isgood]==9?\\\' selected\\\':\\\'\\\'?>>九级推荐</option>\r\n      </select>\r\n      &nbsp;&nbsp; 头条 \r\n      <select name=\\\"firsttitle\\\" id=\\\"firsttitle\\\">\r\n        <option value=\\\"0\\\"<?=$r[firsttitle]==0?\\\' selected\\\':\\\'\\\'?>>非头条</option>\r\n        <option value=\\\"1\\\"<?=$r[firsttitle]==1?\\\' selected\\\':\\\'\\\'?>>一级头条</option>\r\n        <option value=\\\"2\\\"<?=$r[firsttitle]==2?\\\' selected\\\':\\\'\\\'?>>二级头条</option>\r\n        <option value=\\\"3\\\"<?=$r[firsttitle]==3?\\\' selected\\\':\\\'\\\'?>>三级头条</option>\r\n        <option value=\\\"4\\\"<?=$r[firsttitle]==4?\\\' selected\\\':\\\'\\\'?>>四级头条</option>\r\n        <option value=\\\"5\\\"<?=$r[firsttitle]==5?\\\' selected\\\':\\\'\\\'?>>五级头条</option>\r\n        <option value=\\\"6\\\"<?=$r[firsttitle]==6?\\\' selected\\\':\\\'\\\'?>>六级头条</option>\r\n        <option value=\\\"7\\\"<?=$r[firsttitle]==7?\\\' selected\\\':\\\'\\\'?>>七级头条</option>\r\n        <option value=\\\"8\\\"<?=$r[firsttitle]==8?\\\' selected\\\':\\\'\\\'?>>八级头条</option>\r\n        <option value=\\\"9\\\"<?=$r[firsttitle]==9?\\\' selected\\\':\\\'\\\'?>>九级头条</option>\r\n      </select></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">关键字&nbsp;&nbsp;&nbsp;: \r\n      <input name=\\\"keyboard\\\" type=\\\"text\\\" size=\\\"52\\\" value=\\\"<?=stripSlashes($r[keyboard])?>\\\">\r\n      <font color=\\\"#666666\\\">(多个请用&quot;,&quot;隔开)</font></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">外部链接: \r\n      <input name=\\\"titleurl\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titleurl])?>\\\" size=\\\"52\\\">\r\n      <font color=\\\"#666666\\\">(填写后信息连接地址将为此链接)</font></td>\r\n  </tr>\r\n</table>\r\n', '特殊属性', 0, 1, 0, 0, '', '', 0, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (28, 'titlepic', '标题图片', 'img', '\r\n<input name=\\\"titlepic\\\" type=\\\"text\\\" id=\\\"titlepic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[titlepic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=titlepic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '标题图片', 0, 1, 1, 2, 'VARCHAR', '200', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (29, 'newstime', '发布时间', 'text', '<input name=\\\"newstime\\\" type=\\\"text\\\" value=\\\"<?=$r[newstime]?>\\\"><input type=button name=button value=\\\"设为当前时间\\\" onclick=\\\"document.add.newstime.value=\\\'<?=$todaytime?>\\\'\\\">', '发布时间', 0, 1, 1, 0, 'INT', '10', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (30, 'filesize', '文件大小', 'text', '<input name=\\\"filesize\\\" type=\\\"text\\\" size=60 id=\\\"filesize\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[filesize]))?>\\\">\r\n<select name=\\\"select\\\" onchange=\\\"document.add.filesize.value+=this.value\\\">\r\n        <option value=\\\"\\\">单位</option>\r\n        <option value=\\\" MB\\\">MB</option>\r\n        <option value=\\\" KB\\\">KB</option>\r\n        <option value=\\\" GB\\\">GB</option>\r\n        <option value=\\\" BYTES\\\">BYTES</option>\r\n      </select>', '', 1, 1, 1, 1, 'VARCHAR', '10', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (31, 'picsize', '图片尺寸', 'text', '<input name=\\\"picsize\\\" type=\\\"text\\\" id=\\\"picsize\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[picsize]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '20', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (32, 'picfbl', '图片分辨率', 'text', '<input name=\\\"picfbl\\\" type=\\\"text\\\" id=\\\"picfbl\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[picfbl]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '20', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (33, 'picfrom', '来源', 'text', '<input name=\\\"picfrom\\\" type=\\\"text\\\" size=60 id=\\\"picfrom\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[picfrom]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '120', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (34, 'picurl', '图片大图', 'img', '\r\n<input name=\\\"picurl\\\" type=\\\"text\\\" id=\\\"picurl\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[picurl]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=picurl\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '', 1, 1, 1, 2, 'VARCHAR', '200', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (35, 'morepic', '图片集', 'text', '<script>\r\nfunction dopicadd()\r\n{var i;\r\nvar str=\\\"\\\";\r\nvar oldi=0;\r\nvar j=0;\r\noldi=parseInt(document.add.morepicnum.value);\r\nfor(i=1;i<=document.add.downmorepicnum.value;i++)\r\n{\r\nj=i+oldi;\r\nstr=str+\\\"<tr><td width=7%><div align=center>\\\"+j+\\\"</div></td><td width=33%><div align=center><input name=msmallpic[] type=text size=28 id=msmallpic\\\"+j+\\\" ondblclick=SpOpenChFile(1,\\\'msmallpic\\\"+j+\\\"\\\')><br><input type=file name=msmallpfile[] size=15></div></td><td width=30%><div align=center><input name=mbigpic[] type=text size=28 id=mbigpic\\\"+j+\\\" ondblclick=SpOpenChFile(1,\\\'mbigpic\\\"+j+\\\"\\\')><br><input type=file name=mbigpfile[] size=15></div></td><td width=30%><div align=center><input name=mpicname[] type=text></div></td></tr>\\\";\r\n}\r\ndocument.getElementById(\\\"addpicdown\\\").innerHTML=\\\"<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\\\"+str+\\\"</table>\\\";\r\n}\r\n</script>\r\n<table width=\\\"100%\\\" border=\\\"0\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\">\r\n	图片地址前缀:\r\n      <input name=\\\"mpicurl_qz\\\" type=\\\"text\\\" id=\\\"mpicurl_qz\\\">&nbsp;&nbsp;\r\n	  <input type=\\\"checkbox\\\" name=\\\"msavepic\\\" value=\\\"1\\\">远程保存&nbsp;<input type=\\\"checkbox\\\" name=\\\"mcreatespic\\\" value=\\\"1\\\" onclick=\\\"if(this.checked){setmcreatespic.style.display=\\\'\\\';}else{setmcreatespic.style.display=\\\'none\\\';}\\\">生成缩图\r\n	  <span id=\\\"setmcreatespic\\\" style=\\\"display=none\\\">：<input type=text name=\\\"mcreatespicwidth\\\" size=4 value=\\\"<?=$public_r[spicwidth]?>\\\">*<input type=text name=\\\"mcreatespicheight\\\" size=4 value=\\\"<?=$public_r[spicheight]?>\\\">(宽*高)</span>\r\n </td>\r\n  </tr>\r\n  <tr> \r\n    <td><table width=\\\"100%\\\" border=0 align=center cellpadding=3 cellspacing=1>\r\n  <tr bgcolor=\\\"#DBEAF5\\\"> \r\n    <td width=\\\"7%\\\"><div align=center>编号</div></td>\r\n    <td width=\\\"33%\\\"><div align=center>缩图 <font color=\\\"#666666\\\">(双击选择)</font></div></td>\r\n    <td width=\\\"30%\\\"><div align=center>大图 <font color=\\\"#666666\\\">(双击选择)</font></div></td>\r\n    <td width=\\\"30%\\\"><div align=center>图片说明</div></td>\r\n  </tr>\r\n</table></td>\r\n  </tr>\r\n  <tr> \r\n    <td>\r\n    <?php\r\n    if($ecmsfirstpost==1)\r\n    {\r\n	?>\r\n	<table width=\\\'100%\\\' border=0 align=center cellpadding=3 cellspacing=1>\r\n	<?php\r\n	$morepicnum=3;\r\n	for($mppathi=1;$mppathi<=$morepicnum;$mppathi++)\r\n	{\r\n	?>\r\n	<tr> \r\n		<td width=\\\'7%\\\'><div align=center><?=$mppathi?></div></td>\r\n		<td width=\\\'33%\\\'><div align=center>\r\n		<input name=msmallpic[] type=text id=\\\'msmallpic<?=$mppathi?>\\\' size=28 ondblclick=\\\"SpOpenChFile(1,\\\'msmallpic<?=$mppathi?>\\\');\\\">\r\n		<br><input type=file name=msmallpfile[] size=15>\r\n		</div></td>\r\n		<td width=\\\'30%\\\'><div align=center>\r\n		<input name=mbigpic[] type=text id=\\\'mbigpic<?=$mppathi?>\\\' size=28 ondblclick=\\\"SpOpenChFile(1,\\\'mbigpic<?=$mppathi?>\\\');\\\">\r\n		<br><input type=file name=mbigpfile[] size=15>\r\n		</div></td>\r\n		<td width=\\\'30%\\\'><div align=center>\r\n		<input name=mpicname[] type=text id=\\\'mpicname<?=$mppathi?>\\\'>\r\n		</div></td>\r\n	</tr>\r\n	<?php\r\n	}\r\n	?>\r\n	</table>\r\n	<?php\r\n    }\r\n    else\r\n    {\r\n	$morepicpath=\\\"\\\";\r\n	$morepicnum=0;\r\n	if($r[morepic])\r\n    	{\r\n    		$r[morepic]=stripSlashes($r[morepic]);\r\n    		//地址\r\n    		$j=0;\r\n    		$pd_record=explode(\\\"\\\\r\\\\n\\\",$r[morepic]);\r\n    		for($i=0;$i<count($pd_record);$i++)\r\n    		{\r\n			$j=$i+1;\r\n    			$pd_field=explode(\\\"::::::\\\",$pd_record[$i]);\r\n			$morepicpath.=\\\"<tr> \r\n    <td width=\\\'7%\\\'><div align=center>\\\".$j.\\\"</div></td>\r\n    <td width=\\\'33%\\\'><div align=center>\r\n        <input name=msmallpic[] type=text value=\\\'\\\".$pd_field[0].\\\"\\\' size=28 id=msmallpic\\\".$j.\\\" ondblclick=\\\\\\\"SpOpenChFile(1,\\\'msmallpic\\\".$j.\\\"\\\');\\\\\\\">\r\n		<br><input type=file name=msmallpfile[] size=15>\r\n      </div></td>\r\n    <td width=\\\'30%\\\'><div align=center>\r\n        <input name=mbigpic[] type=text value=\\\'\\\".$pd_field[1].\\\"\\\' size=28 id=mbigpic\\\".$j.\\\" ondblclick=\\\\\\\"SpOpenChFile(1,\\\'mbigpic\\\".$j.\\\"\\\');\\\\\\\">\r\n		<br><input type=file name=mbigpfile[] size=15>\r\n      </div></td>\r\n    <td width=\\\'30%\\\'><div align=center>\r\n        <input name=mpicname[] type=text value=\\\'\\\".$pd_field[2].\\\"\\\'><input type=hidden name=mpicid[] value=\\\".$j.\\\"><input type=checkbox name=mdelpicid[] value=\\\".$j.\\\">删\r\n      </div></td>\r\n  </tr>\\\";\r\n    		}\r\n    		$morepicnum=$j;\r\n    		$morepicpath=\\\"<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\\\".$morepicpath.\\\"</table>\\\";\r\n    	}\r\n	echo $morepicpath;\r\n    }\r\n    ?>\r\n    </td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\">地址扩展数量: <input name=\\\"morepicnum\\\" type=\\\"hidden\\\" id=\\\"morepicnum\\\" value=\\\"<?=$morepicnum?>\\\">\r\n      <input name=\\\"downmorepicnum\\\" type=\\\"text\\\" value=\\\"1\\\" size=\\\"6\\\"> <input type=\\\"button\\\" name=\\\"Submit5\\\" value=\\\"输出地址\\\" onclick=\\\"javascript:dopicadd();\\\"></td>\r\n  </tr>\r\n  <tr> \r\n    <td id=addpicdown></td>\r\n  </tr>\r\n</table>\r\n', '', 1, 1, 1, 2, 'MEDIUMTEXT', '', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (36, 'num', '每行显示条数', 'text', '<input name=\\\"num\\\" type=\\\"text\\\" size=3 id=\\\"num\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"3\\\":htmlspecialchars(stripSlashes($r[num]))?>\\\">\r\n', '', 1, 1, 1, 2, 'TINYINT', '', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (37, 'width', '缩图宽度', 'text', '<input name=\\\"width\\\" type=\\\"text\\\" size=6 id=\\\"width\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[width]))?>\\\">\r\n', '', 1, 1, 1, 2, 'VARCHAR', '12', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (38, 'height', '缩图高度', 'text', '<input name=\\\"height\\\" type=\\\"text\\\" size=6 id=\\\"height\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[height]))?>\\\">\r\n', '', 1, 1, 1, 2, 'VARCHAR', '12', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (39, 'picsay', '图片简介', 'textarea', '<textarea name=\\\"picsay\\\" cols=\\\"80\\\" rows=\\\"10\\\" id=\\\"picsay\\\"><?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[picsay]))?></textarea>\r\n', '', 1, 1, 1, 2, 'TEXT', '', 1, 3, 'photo', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 1);
INSERT INTO `fa_cms_newsfp` VALUES (40, 'title', '标题', 'text', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">\r\n<?=$tts?\\\"<select name=\\\'ttid\\\'><option value=\\\'0\\\'>标题分类</option>$tts</select>\\\":\\\"\\\"?>\r\n	<input type=text name=title value=\\\"<?=htmlspecialchars(stripSlashes($r[title]))?>\\\" size=\\\"60\\\"> \r\n	<input type=\\\"button\\\" name=\\\"button\\\" value=\\\"图文\\\" onclick=\\\"document.add.title.value=document.add.title.value+\\\'(图文)\\\';\\\"> \r\n  </td>\r\n</tr>\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">属性: \r\n	<input name=\\\"titlefont[b]\\\" type=\\\"checkbox\\\" value=\\\"b\\\"<?=$titlefontb?>>粗体\r\n	<input name=\\\"titlefont[i]\\\" type=\\\"checkbox\\\" value=\\\"i\\\"<?=$titlefonti?>>斜体\r\n	<input name=\\\"titlefont[s]\\\" type=\\\"checkbox\\\" value=\\\"s\\\"<?=$titlefonts?>>删除线\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;颜色: <input name=\\\"titlecolor\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titlecolor])?>\\\" size=\\\"10\\\"><a onclick=\\\"foreColor();\\\"><img src=\\\"../data/images/color.gif\\\" width=\\\"21\\\" height=\\\"21\\\" align=\\\"absbottom\\\"></a>\r\n  </td>\r\n</tr>\r\n</table>', '标题', 0, 1, 1, 0, 'VARCHAR', '200', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (41, 'special.field', '特殊属性', '', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">信息属性: \r\n      <input name=\\\"checked\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[checked]?\\\' checked\\\':\\\'\\\'?>>\r\n      审核 &nbsp;&nbsp; 推荐 \r\n      <select name=\\\"isgood\\\" id=\\\"isgood\\\">\r\n        <option value=\\\"0\\\"<?=$r[isgood]==0?\\\' selected\\\':\\\'\\\'?>>不推荐</option>\r\n        <option value=\\\"1\\\"<?=$r[isgood]==1?\\\' selected\\\':\\\'\\\'?>>一级推荐</option>\r\n        <option value=\\\"2\\\"<?=$r[isgood]==2?\\\' selected\\\':\\\'\\\'?>>二级推荐</option>\r\n        <option value=\\\"3\\\"<?=$r[isgood]==3?\\\' selected\\\':\\\'\\\'?>>三级推荐</option>\r\n        <option value=\\\"4\\\"<?=$r[isgood]==4?\\\' selected\\\':\\\'\\\'?>>四级推荐</option>\r\n        <option value=\\\"5\\\"<?=$r[isgood]==5?\\\' selected\\\':\\\'\\\'?>>五级推荐</option>\r\n        <option value=\\\"6\\\"<?=$r[isgood]==6?\\\' selected\\\':\\\'\\\'?>>六级推荐</option>\r\n        <option value=\\\"7\\\"<?=$r[isgood]==7?\\\' selected\\\':\\\'\\\'?>>七级推荐</option>\r\n        <option value=\\\"8\\\"<?=$r[isgood]==8?\\\' selected\\\':\\\'\\\'?>>八级推荐</option>\r\n        <option value=\\\"9\\\"<?=$r[isgood]==9?\\\' selected\\\':\\\'\\\'?>>九级推荐</option>\r\n      </select>\r\n      &nbsp;&nbsp; 头条 \r\n      <select name=\\\"firsttitle\\\" id=\\\"firsttitle\\\">\r\n        <option value=\\\"0\\\"<?=$r[firsttitle]==0?\\\' selected\\\':\\\'\\\'?>>非头条</option>\r\n        <option value=\\\"1\\\"<?=$r[firsttitle]==1?\\\' selected\\\':\\\'\\\'?>>一级头条</option>\r\n        <option value=\\\"2\\\"<?=$r[firsttitle]==2?\\\' selected\\\':\\\'\\\'?>>二级头条</option>\r\n        <option value=\\\"3\\\"<?=$r[firsttitle]==3?\\\' selected\\\':\\\'\\\'?>>三级头条</option>\r\n        <option value=\\\"4\\\"<?=$r[firsttitle]==4?\\\' selected\\\':\\\'\\\'?>>四级头条</option>\r\n        <option value=\\\"5\\\"<?=$r[firsttitle]==5?\\\' selected\\\':\\\'\\\'?>>五级头条</option>\r\n        <option value=\\\"6\\\"<?=$r[firsttitle]==6?\\\' selected\\\':\\\'\\\'?>>六级头条</option>\r\n        <option value=\\\"7\\\"<?=$r[firsttitle]==7?\\\' selected\\\':\\\'\\\'?>>七级头条</option>\r\n        <option value=\\\"8\\\"<?=$r[firsttitle]==8?\\\' selected\\\':\\\'\\\'?>>八级头条</option>\r\n        <option value=\\\"9\\\"<?=$r[firsttitle]==9?\\\' selected\\\':\\\'\\\'?>>九级头条</option>\r\n      </select></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">关键字&nbsp;&nbsp;&nbsp;: \r\n      <input name=\\\"keyboard\\\" type=\\\"text\\\" size=\\\"52\\\" value=\\\"<?=stripSlashes($r[keyboard])?>\\\">\r\n      <font color=\\\"#666666\\\">(多个请用&quot;,&quot;隔开)</font></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">外部链接: \r\n      <input name=\\\"titleurl\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titleurl])?>\\\" size=\\\"52\\\">\r\n      <font color=\\\"#666666\\\">(填写后信息连接地址将为此链接)</font></td>\r\n  </tr>\r\n</table>\r\n', '特殊属性', 0, 1, 0, 0, '', '', 0, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (42, 'titlepic', '标题图片', 'img', '\r\n<input name=\\\"titlepic\\\" type=\\\"text\\\" id=\\\"titlepic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[titlepic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=titlepic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '标题图片', 0, 1, 1, 1, 'VARCHAR', '200', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (43, 'newstime', '发布时间', 'text', '<input name=\\\"newstime\\\" type=\\\"text\\\" value=\\\"<?=$r[newstime]?>\\\"><input type=button name=button value=\\\"设为当前时间\\\" onclick=\\\"document.add.newstime.value=\\\'<?=$todaytime?>\\\'\\\">', '发布时间', 0, 1, 1, 0, 'INT', '10', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (44, 'flashwriter', '作者', 'text', '<input name=\\\"flashwriter\\\" type=\\\"text\\\" size=60 id=\\\"flashwriter\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[flashwriter]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '30', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (45, 'email', '作者邮箱', 'text', '<input name=\\\"email\\\" type=\\\"text\\\" size=60 id=\\\"email\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[email]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '80', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (46, 'star', '作品等级', 'select', '<select name=\\\"star\\\" id=\\\"star\\\"><option value=\\\"1\\\"<?=$r[star]==\\\"1\\\"?\\\' selected\\\':\\\'\\\'?>>1星</option><option value=\\\"2\\\"<?=$r[star]==\\\"2\\\"||$ecmsfirstpost==1?\\\' selected\\\':\\\'\\\'?>>2星</option><option value=\\\"3\\\"<?=$r[star]==\\\"3\\\"?\\\' selected\\\':\\\'\\\'?>>3星</option><option value=\\\"4\\\"<?=$r[star]==\\\"4\\\"?\\\' selected\\\':\\\'\\\'?>>4星</option><option value=\\\"5\\\"<?=$r[star]==\\\"5\\\"?\\\' selected\\\':\\\'\\\'?>>5星</option></select>', '', 1, 1, 1, 1, 'TINYINT', '1', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (47, 'filesize', '文件大小', 'text', '<input name=\\\"filesize\\\" type=\\\"text\\\" size=60 id=\\\"filesize\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[filesize]))?>\\\">\r\n<select name=\\\"select\\\" onchange=\\\"document.add.filesize.value+=this.value\\\">\r\n        <option value=\\\"\\\">单位</option>\r\n        <option value=\\\" MB\\\">MB</option>\r\n        <option value=\\\" KB\\\">KB</option>\r\n        <option value=\\\" GB\\\">GB</option>\r\n        <option value=\\\" BYTES\\\">BYTES</option>\r\n      </select>', '', 1, 1, 1, 1, 'VARCHAR', '16', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (48, 'flashurl', 'Flash地址', 'flash', '\r\n<input name=\\\"flashurl\\\" type=\\\"text\\\" id=\\\"flashurl\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[flashurl]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=2&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=flashurl\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的FLASH\\\"><img src=\\\"../data/images/changeflash.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '', 1, 1, 1, 1, 'VARCHAR', '255', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (49, 'width', 'Flash宽度', 'text', '<input name=\\\"width\\\" type=\\\"text\\\" size=6 id=\\\"width\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"600\\\":htmlspecialchars(stripSlashes($r[width]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '12', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (50, 'height', 'Flash高度', 'text', '<input name=\\\"height\\\" type=\\\"text\\\" size=6 id=\\\"height\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"450\\\":htmlspecialchars(stripSlashes($r[height]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '12', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (51, 'flashsay', '作品简介', 'textarea', '<textarea name=\\\"flashsay\\\" cols=\\\"80\\\" rows=\\\"10\\\" id=\\\"flashsay\\\"><?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[flashsay]))?></textarea>\r\n', '', 1, 1, 1, 1, 'TEXT', '', 1, 4, 'flash', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 1);
INSERT INTO `fa_cms_newsfp` VALUES (52, 'title', '标题', 'text', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">\r\n<?=$tts?\\\"<select name=\\\'ttid\\\'><option value=\\\'0\\\'>标题分类</option>$tts</select>\\\":\\\"\\\"?>\r\n	<input type=text name=title value=\\\"<?=htmlspecialchars(stripSlashes($r[title]))?>\\\" size=\\\"60\\\"> \r\n	<input type=\\\"button\\\" name=\\\"button\\\" value=\\\"图文\\\" onclick=\\\"document.add.title.value=document.add.title.value+\\\'(图文)\\\';\\\"> \r\n  </td>\r\n</tr>\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">属性: \r\n	<input name=\\\"titlefont[b]\\\" type=\\\"checkbox\\\" value=\\\"b\\\"<?=$titlefontb?>>粗体\r\n	<input name=\\\"titlefont[i]\\\" type=\\\"checkbox\\\" value=\\\"i\\\"<?=$titlefonti?>>斜体\r\n	<input name=\\\"titlefont[s]\\\" type=\\\"checkbox\\\" value=\\\"s\\\"<?=$titlefonts?>>删除线\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;颜色: <input name=\\\"titlecolor\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titlecolor])?>\\\" size=\\\"10\\\"><a onclick=\\\"foreColor();\\\"><img src=\\\"../data/images/color.gif\\\" width=\\\"21\\\" height=\\\"21\\\" align=\\\"absbottom\\\"></a>\r\n  </td>\r\n</tr>\r\n</table>', '标题', 0, 1, 1, 0, 'VARCHAR', '200', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (53, 'special.field', '特殊属性', '', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">信息属性: \r\n      <input name=\\\"checked\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[checked]?\\\' checked\\\':\\\'\\\'?>>\r\n      审核 &nbsp;&nbsp; 推荐 \r\n      <select name=\\\"isgood\\\" id=\\\"isgood\\\">\r\n        <option value=\\\"0\\\"<?=$r[isgood]==0?\\\' selected\\\':\\\'\\\'?>>不推荐</option>\r\n        <option value=\\\"1\\\"<?=$r[isgood]==1?\\\' selected\\\':\\\'\\\'?>>一级推荐</option>\r\n        <option value=\\\"2\\\"<?=$r[isgood]==2?\\\' selected\\\':\\\'\\\'?>>二级推荐</option>\r\n        <option value=\\\"3\\\"<?=$r[isgood]==3?\\\' selected\\\':\\\'\\\'?>>三级推荐</option>\r\n        <option value=\\\"4\\\"<?=$r[isgood]==4?\\\' selected\\\':\\\'\\\'?>>四级推荐</option>\r\n        <option value=\\\"5\\\"<?=$r[isgood]==5?\\\' selected\\\':\\\'\\\'?>>五级推荐</option>\r\n        <option value=\\\"6\\\"<?=$r[isgood]==6?\\\' selected\\\':\\\'\\\'?>>六级推荐</option>\r\n        <option value=\\\"7\\\"<?=$r[isgood]==7?\\\' selected\\\':\\\'\\\'?>>七级推荐</option>\r\n        <option value=\\\"8\\\"<?=$r[isgood]==8?\\\' selected\\\':\\\'\\\'?>>八级推荐</option>\r\n        <option value=\\\"9\\\"<?=$r[isgood]==9?\\\' selected\\\':\\\'\\\'?>>九级推荐</option>\r\n      </select>\r\n      &nbsp;&nbsp; 头条 \r\n      <select name=\\\"firsttitle\\\" id=\\\"firsttitle\\\">\r\n        <option value=\\\"0\\\"<?=$r[firsttitle]==0?\\\' selected\\\':\\\'\\\'?>>非头条</option>\r\n        <option value=\\\"1\\\"<?=$r[firsttitle]==1?\\\' selected\\\':\\\'\\\'?>>一级头条</option>\r\n        <option value=\\\"2\\\"<?=$r[firsttitle]==2?\\\' selected\\\':\\\'\\\'?>>二级头条</option>\r\n        <option value=\\\"3\\\"<?=$r[firsttitle]==3?\\\' selected\\\':\\\'\\\'?>>三级头条</option>\r\n        <option value=\\\"4\\\"<?=$r[firsttitle]==4?\\\' selected\\\':\\\'\\\'?>>四级头条</option>\r\n        <option value=\\\"5\\\"<?=$r[firsttitle]==5?\\\' selected\\\':\\\'\\\'?>>五级头条</option>\r\n        <option value=\\\"6\\\"<?=$r[firsttitle]==6?\\\' selected\\\':\\\'\\\'?>>六级头条</option>\r\n        <option value=\\\"7\\\"<?=$r[firsttitle]==7?\\\' selected\\\':\\\'\\\'?>>七级头条</option>\r\n        <option value=\\\"8\\\"<?=$r[firsttitle]==8?\\\' selected\\\':\\\'\\\'?>>八级头条</option>\r\n        <option value=\\\"9\\\"<?=$r[firsttitle]==9?\\\' selected\\\':\\\'\\\'?>>九级头条</option>\r\n      </select></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">关键字&nbsp;&nbsp;&nbsp;: \r\n      <input name=\\\"keyboard\\\" type=\\\"text\\\" size=\\\"52\\\" value=\\\"<?=stripSlashes($r[keyboard])?>\\\">\r\n      <font color=\\\"#666666\\\">(多个请用&quot;,&quot;隔开)</font></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">外部链接: \r\n      <input name=\\\"titleurl\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titleurl])?>\\\" size=\\\"52\\\">\r\n      <font color=\\\"#666666\\\">(填写后信息连接地址将为此链接)</font></td>\r\n  </tr>\r\n</table>\r\n', '特殊属性', 0, 1, 0, 0, '', '', 0, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (54, 'titlepic', '标题图片', 'img', '\r\n<input name=\\\"titlepic\\\" type=\\\"text\\\" id=\\\"titlepic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[titlepic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=titlepic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '标题图片', 0, 1, 1, 1, 'VARCHAR', '200', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (55, 'newstime', '发布时间', 'text', '<input name=\\\"newstime\\\" type=\\\"text\\\" value=\\\"<?=$r[newstime]?>\\\"><input type=button name=button value=\\\"设为当前时间\\\" onclick=\\\"document.add.newstime.value=\\\'<?=$todaytime?>\\\'\\\">', '发布时间', 0, 1, 1, 0, 'INT', '10', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (56, 'movietype', '影片类型', 'select', '<select name=\\\"movietype\\\" id=\\\"movietype\\\"><option value=\\\"港台影视\\\"<?=$r[movietype]==\\\"港台影视\\\"?\\\' selected\\\':\\\'\\\'?>>港台影视</option><option value=\\\"海外影视\\\"<?=$r[movietype]==\\\"海外影视\\\"?\\\' selected\\\':\\\'\\\'?>>海外影视</option><option value=\\\"大陆影视\\\"<?=$r[movietype]==\\\"大陆影视\\\"?\\\' selected\\\':\\\'\\\'?>>大陆影视</option><option value=\\\"日韩影视\\\"<?=$r[movietype]==\\\"日韩影视\\\"?\\\' selected\\\':\\\'\\\'?>>日韩影视</option></select>', '', 1, 1, 1, 1, 'VARCHAR', '16', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (57, 'company', '出品公司', 'text', '\r\n<input name=\"company\" type=\"text\" id=\"company\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($r[company]))?>\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '200', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (58, 'movietime', '出品时间', 'text', '\r\n<input name=\"movietime\" type=\"text\" id=\"movietime\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($r[movietime]))?>\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '20', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (59, 'player', '主演', 'text', '\r\n<input name=\"player\" type=\"text\" id=\"player\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($r[player]))?>\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '255', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (60, 'playadmin', '导演', 'text', '\r\n<input name=\"playadmin\" type=\"text\" id=\"playadmin\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($r[playadmin]))?>\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '255', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (61, 'filetype', '影片格式', 'text', '<input name=\\\"filetype\\\" type=\\\"text\\\" size=8 id=\\\"filetype\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[filetype]))?>\\\">\r\n<select name=\\\"select2\\\" onchange=\\\"document.add.filetype.value=this.value\\\">\r\n        <option value=\\\"\\\">类型</option>\r\n        <option value=\\\".rm\\\">.rm</option>\r\n        <option value=\\\".rmvb\\\">.rmvb</option>\r\n        <option value=\\\".mp3\\\">.mp3</option>\r\n        <option value=\\\".asf\\\">.asf</option>\r\n        <option value=\\\".wmv\\\">.wmv</option>\r\n        <option value=\\\".avi\\\">.avi</option>\r\n      </select>', '', 1, 1, 1, 1, 'VARCHAR', '10', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (62, 'filesize', '影片大小', 'text', '<input name=\\\"filesize\\\" type=\\\"text\\\" size=12 id=\\\"filesize\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[filesize]))?>\\\">\r\n<select name=\\\"select\\\" onchange=\\\"document.add.filesize.value+=this.value\\\">\r\n        <option value=\\\"\\\">单位</option>\r\n        <option value=\\\" MB\\\">MB</option>\r\n        <option value=\\\" KB\\\">KB</option>\r\n        <option value=\\\" GB\\\">GB</option>\r\n        <option value=\\\" BYTES\\\">BYTES</option>\r\n      </select>', '', 1, 1, 1, 1, 'VARCHAR', '16', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (63, 'star', '推荐等级', 'select', '<select name=\\\"star\\\" id=\\\"star\\\"><option value=\\\"1\\\"<?=$r[star]==\\\"1\\\"?\\\' selected\\\':\\\'\\\'?>>1星</option><option value=\\\"2\\\"<?=$r[star]==\\\"2\\\"||$ecmsfirstpost==1?\\\' selected\\\':\\\'\\\'?>>2星</option><option value=\\\"3\\\"<?=$r[star]==\\\"3\\\"?\\\' selected\\\':\\\'\\\'?>>3星</option><option value=\\\"4\\\"<?=$r[star]==\\\"4\\\"?\\\' selected\\\':\\\'\\\'?>>4星</option><option value=\\\"5\\\"<?=$r[star]==\\\"5\\\"?\\\' selected\\\':\\\'\\\'?>>5星</option></select>', '', 1, 1, 1, 1, 'TINYINT', '1', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (64, 'playdk', '带宽要求', 'text', '<input name=\\\"playdk\\\" type=\\\"text\\\" id=\\\"playdk\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[playdk]))?>\\\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '30', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (65, 'playtime', '片长', 'text', '\r\n<input name=\"playtime\" type=\"text\" id=\"playtime\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($r[playtime]))?>\">\r\n', '', 1, 1, 1, 1, 'VARCHAR', '20', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (66, 'moviefen', '扣除点数', 'text', '\r\n<input name=\"moviefen\" type=\"text\" id=\"moviefen\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($r[moviefen]))?>\">\r\n', '', 1, 1, 1, 1, 'INT', '', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (67, 'downpath', '下载地址', 'text', '<script>\r\nfunction doadd()\r\n{var i;\r\nvar str=\\\"\\\";\r\nvar oldi=0;\r\nvar j=0;\r\noldi=parseInt(document.add.editnum.value);\r\nfor(i=1;i<=document.add.downnum.value;i++)\r\n{\r\nj=i+oldi;\r\nstr=str+\\\"<tr><td width=7%> <div align=center>\\\"+j+\\\"</div></td><td width=19%><div align=left><input name=downname[] type=text id=downname[] value=下载地址\\\"+j+\\\" size=17></div></td><td width=40%><input name=downpath[] type=text size=36 id=downpath\\\"+j+\\\" ondblclick=SpOpenChFile(0,\\\'downpath\\\"+j+\\\"\\\')><select name=thedownqz[]><option value=\\\'\\\'>--地址前缀--</option><?=$newdownqz?></select></td><td width=21%><div align=center><select name=downuser[] id=select><option value=0>游客</option><?=$ygroup?></select></div></td><td width=13%><div align=center><input name=fen[] type=text id=fen[] value=0 size=6></div></td></tr>\\\";\r\n}\r\ndocument.getElementById(\\\"adddown\\\").innerHTML=\\\"<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\\\"+str+\\\"</table>\\\";\r\n}\r\n</script>\r\n<table width=\\\"100%\\\" border=\\\"0\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\">下载地址前缀&nbsp;:\r\n      <input name=\\\"downurl_qz\\\" type=\\\"text\\\" size=\\\"32\\\">\r\n      <select name=\\\"changeurl_qz\\\" onchange=\\\"document.add.downurl_qz.value=document.add.changeurl_qz.value\\\">\r\n        <option value=\\\"\\\" selected>选择前缀</option>\r\n        <?=$downurlqz?>\r\n      </select>\r\n	  </td>\r\n  </tr>\r\n  <tr>\r\n    <td height=\\\"25\\\">选择/上传附件:\r\n      <input name=\\\"changedown_url\\\" id=\\\"changedown_url\\\" type=\\\"text\\\" size=\\\"32\\\">\r\n      <input type=\\\"button\\\" name=\\\"Submit\\\" value=\\\"选择\\\" onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=0&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=changedown_url\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\">&nbsp;\r\n	  <input type=\\\"button\\\" name=\\\"Submit\\\" value=\\\"复制\\\" onclick=\\\"document.getElementById(\\\'changedown_url\\\').focus();document.getElementById(\\\'changedown_url\\\').select();clipboardData.setData(\\\'text\\\',document.getElementById(\\\'changedown_url\\\').value);\\\"></td>\r\n  </tr>\r\n  <tr> \r\n    <td><table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"3\\\" cellspacing=\\\"1\\\" bgcolor=\\\"#DBEAF5\\\">\r\n        <tr> \r\n          <td width=\\\"7%\\\"> <div align=\\\"center\\\">编号</div></td>\r\n          <td width=\\\"19%\\\"><div align=\\\"left\\\">下载名称</div></td>\r\n          <td width=\\\"40%\\\">下载地址 <font color=\\\"#666666\\\">(双击选择)</font></td>\r\n          <td width=\\\"21%\\\"> <div align=\\\"center\\\">权限</div></td>\r\n          <td width=\\\"13%\\\"> <div align=\\\"center\\\">点数</div></td>\r\n        </tr>\r\n      </table></td>\r\n  </tr>\r\n  <tr> \r\n    <td>\r\n    <?php\r\n    if($ecmsfirstpost==1)\r\n    {\r\n    ?>\r\n	<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\r\n	<?php\r\n	$editnum=3;\r\n	for($pathi=1;$pathi<=$editnum;$pathi++)\r\n	{\r\n	?>\r\n           <tr> \r\n              <td width=\\\'7%\\\'> <div align=center><?=$pathi?></div></td>\r\n              <td width=\\\'19%\\\'> <div align=left> \r\n                  <input name=downname[] type=text value=\\\'下载地址<?=$pathi?>\\\' size=17>\r\n                    </div></td>\r\n              <td width=\\\'40%\\\'>\r\n	      <input name=downpath[] type=text size=36 id=\\\'downpath<?=$pathi?>\\\' ondblclick=\\\"SpOpenChFile(0,\\\'downpath<?=$pathi?>\\\');\\\">\r\n	      <select name=thedownqz[]><option value=\\\'\\\'>--地址前缀--</option><?=$newdownqz?></select> \r\n                  </td>\r\n                  <td width=\\\'21%\\\'><div align=center> \r\n                      <select name=downuser[]>\r\n                        <option value=0>游客</option>\r\n                        <?=$ygroup?>\r\n                      </select>\r\n                    </div></td>\r\n                  <td width=\\\'13%\\\'> <div align=center> \r\n                      <input name=fen[] type=text value=0 size=6>\r\n                    </div></td>\r\n            </tr>\r\n	<?php\r\n	}\r\n	?>\r\n	</table>\r\n    <?php\r\n    }\r\n    else\r\n    {\r\n	$editnum=0;\r\n	$downloadpath=\\\"\\\";\r\n	if($r[downpath])\r\n	{\r\n		$r[downpath]=stripSlashes($r[downpath]);\r\n		//下载地址\r\n		$j=0;\r\n		$d_record=explode(\\\"\\\\r\\\\n\\\",$r[downpath]);\r\n		for($i=0;$i<count($d_record);$i++)\r\n		{\r\n			$j=$i+1;\r\n			$d_field=explode(\\\"::::::\\\",$d_record[$i]);\r\n			//权限\r\n			$tgroup=str_replace(\\\" value=\\\".$d_field[2].\\\">\\\",\\\" value=\\\".$d_field[2].\\\" selected>\\\",$ygroup);\r\n			//地址前缀\r\n			$tnewdownqz=str_replace(\\\" value=\\\'\\\".$d_field[4].\\\"\\\'>\\\",\\\" value=\\\'\\\".$d_field[4].\\\"\\\' selected>\\\",$newdownqz);\r\n			$downloadpath.=\\\"<tr><td width=\\\'7%\\\'><div align=center>\\\".$j.\\\"</div></td><td width=\\\'19%\\\'><div align=left><input name=downname[] type=text id=downname[] value=\\\'\\\".$d_field[0].\\\"\\\' size=17></div></td><td width=\\\'40%\\\'><input name=downpath[] type=text id=downpath\\\".$j.\\\" value=\\\'\\\".$d_field[1].\\\"\\\' size=36 ondblclick=\\\\\\\"SpOpenChFile(0,\\\'downpath\\\".$j.\\\"\\\');\\\\\\\"><select name=thedownqz[]><option value=\\\'\\\'>--地址前缀--</option>\\\".$tnewdownqz.\\\"</select><input type=hidden name=pathid[] value=\\\".$j.\\\"><input type=checkbox name=delpathid[] value=\\\".$j.\\\">删</td><td width=\\\'21%\\\'><div align=center><select name=downuser[] id=select><option value=0>游客</option>\\\".$tgroup.\\\"</select></div></td><td width=\\\'13%\\\'><div align=center><input name=fen[] type=text id=fen[] value=\\\'\\\".$d_field[3].\\\"\\\' size=6></div></td></tr>\\\";\r\n		}\r\n		$editnum=$j;\r\n		$downloadpath=\\\"<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\\\".$downloadpath.\\\"</table>\\\";\r\n	}\r\n	echo $downloadpath;\r\n    }\r\n    ?>\r\n    </td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\">下载地址扩展数量: <input name=\\\"editnum\\\" type=\\\"hidden\\\" id=\\\"editnum\\\" value=\\\"<?=$editnum?>\\\">\r\n      <input name=\\\"downnum\\\" type=\\\"text\\\" id=\\\"downnum\\\" value=\\\"1\\\" size=\\\"6\\\"> <input type=\\\"button\\\" name=\\\"Submit5\\\" value=\\\"输出地址\\\" onclick=\\\"javascript:doadd();\\\"></td>\r\n  </tr>\r\n  <tr> \r\n    <td id=adddown></td>\r\n  </tr>\r\n</table>\r\n', '', 1, 1, 1, 1, 'MEDIUMTEXT', '', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (68, 'onlinepath', '在线观看地址', 'text', '<script>\r\nfunction dooadd()\r\n{var i;\r\nvar str=\\\"\\\";\r\nvar oldi=0;\r\nvar j=0;\r\noldi=parseInt(document.add.oeditnum.value);\r\nfor(i=1;i<=document.add.odownnum.value;i++)\r\n{\r\nj=i+oldi;\r\nstr=str+\\\"<tr><td width=7%> <div align=center>\\\"+j+\\\"</div></td><td width=19%><div align=left><input name=odownname[] type=text value=\\\"+j+\\\" size=17></div></td><td width=40%><input name=odownpath[] type=text size=36 id=odownpath\\\"+j+\\\" ondblclick=SpOpenChFile(0,\\\'odownpath\\\"+j+\\\"\\\')><select name=othedownqz[]><option value=\\\'\\\'>--地址前缀--</option><?=$newdownqz?></select></td><td width=21%><div align=center><select name=odownuser[] id=select><option value=0>游客</option><?=$ygroup?></select></div></td><td width=13%><div align=center><input name=ofen[] type=text value=0 size=6></div></td></tr>\\\";\r\n}\r\ndocument.getElementById(\\\"addonline\\\").innerHTML=\\\"<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\\\"+str+\\\"</table>\\\";\r\n}\r\n</script>\r\n<table width=\\\"100%\\\" border=\\\"0\\\" cellspacing=\\\"0\\\" cellpadding=\\\"0\\\">\r\n  <tr> \r\n    <td height=\\\"25\\\">观看地址前缀&nbsp;: \r\n      <input name=\\\"onlineurl_qz\\\" type=\\\"text\\\" size=\\\"32\\\"> <select name=\\\"changeonlineurl_qz\\\" onchange=\\\"document.add.onlineurl_qz.value=document.add.changeonlineurl_qz.value\\\">\r\n        <option value=\\\"\\\" selected>选择前缀</option>\r\n        <?=$downurlqz?>\r\n      </select>\r\n      </td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\">选择/上传附件: \r\n      <input name=\\\"changeonline_url\\\" id=\\\"changeonline_url\\\" type=\\\"text\\\" size=\\\"32\\\"> <input type=\\\"button\\\" name=\\\"Submit\\\" value=\\\"选择\\\" onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=0&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=changeonline_url\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\">&nbsp;\r\n	  <input type=\\\"button\\\" name=\\\"Submit\\\" value=\\\"复制\\\" onclick=\\\"document.getElementById(\\\'changeonline_url\\\').focus();document.getElementById(\\\'changeonline_url\\\').select();clipboardData.setData(\\\'text\\\',document.getElementById(\\\'changeonline_url\\\').value);\\\"></td>\r\n  </tr>\r\n  <tr> \r\n    <td><table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"3\\\" cellspacing=\\\"1\\\" bgcolor=\\\"#DBEAF5\\\">\r\n        <tr> \r\n          <td width=\\\"7%\\\"> <div align=\\\"center\\\">编号</div></td>\r\n          <td width=\\\"19%\\\"><div align=\\\"left\\\">观看名称</div></td>\r\n          <td width=\\\"40%\\\">观看地址 <font color=\\\"#666666\\\">(双击选择)</font></td>\r\n          <td width=\\\"21%\\\"> <div align=\\\"center\\\">权限</div></td>\r\n          <td width=\\\"13%\\\"> <div align=\\\"center\\\">点数</div></td>\r\n        </tr>\r\n      </table></td>\r\n  </tr>\r\n  <tr> \r\n    <td>\r\n    <?php\r\n    if($ecmsfirstpost==1)\r\n    {\r\n	?>\r\n	<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\r\n	<?php\r\n	$oeditnum=3;\r\n	for($opathi=1;$opathi<=$oeditnum;$opathi++)\r\n	{\r\n	?>\r\n		<tr> \r\n                  <td width=\\\'7%\\\'> <div align=center><?=$opathi?></div></td>\r\n                  <td width=\\\'19%\\\'> <div align=left> \r\n                      <input name=odownname[] type=text value=\\\'<?=$opathi?>\\\' size=17>\r\n                    </div></td>\r\n                  <td width=\\\'40%\\\'> \r\n		  <input name=odownpath[] type=text id=\\\'odownpath<?=$opathi?>\\\' size=36 ondblclick=\\\"SpOpenChFile(0,\\\'odownpath<?=$opathi?>\\\');\\\">\r\n		  <select name=othedownqz[]><option value=\\\'\\\'>--地址前缀--</option><?=$newdownqz?></select> \r\n                  </td>\r\n                  <td width=\\\'21%\\\'><div align=center> \r\n                      <select name=odownuser[] id=select>\r\n                        <option value=0>游客</option>\r\n                        <?=$ygroup?>\r\n                      </select>\r\n                    </div></td>\r\n                  <td width=\\\'13%\\\'> <div align=center> \r\n                      <input name=ofen[] type=text id=ofen[] value=0 size=6>\r\n                    </div></td>\r\n                </tr>\r\n	<?php\r\n	}\r\n	?>\r\n	</table>\r\n	<?php\r\n    }\r\n    else\r\n    {\r\n	$oeditnum=0;\r\n	$onlinemoviepath=\\\"\\\";\r\n	if($r[onlinepath])\r\n	{\r\n		$j=0;\r\n		$od_record=explode(\\\"\\\\r\\\\n\\\",$r[onlinepath]);\r\n		for($i=0;$i<count($od_record);$i++)\r\n		{\r\n			$j=$i+1;\r\n			$od_field=explode(\\\"::::::\\\",$od_record[$i]);\r\n			//权限\r\n			$tgroup=str_replace(\\\" value=\\\".$od_field[2].\\\">\\\",\\\" value=\\\".$od_field[2].\\\" selected>\\\",$ygroup);\r\n			//地址前缀\r\n			$tnewdownqz=str_replace(\\\" value=\\\'\\\".$od_field[4].\\\"\\\'>\\\",\\\" value=\\\'\\\".$od_field[4].\\\"\\\' selected>\\\",$newdownqz);\r\n			$onlinemoviepath.=\\\"<tr><td width=\\\'7%\\\'><div align=center>\\\".$j.\\\"</div></td><td width=\\\'19%\\\'><div align=left><input name=odownname[] type=text value=\\\'\\\".$od_field[0].\\\"\\\' size=17></div></td><td width=\\\'40%\\\'><input name=odownpath[] type=text value=\\\'\\\".$od_field[1].\\\"\\\' size=36 id=odownpath\\\".$j.\\\" ondblclick=\\\\\\\"SpOpenChFile(0,\\\'odownpath\\\".$j.\\\"\\\');\\\\\\\"><select name=othedownqz[]><option value=\\\'\\\'>--地址前缀--</option>\\\".$tnewdownqz.\\\"</select><input type=hidden name=opathid[] value=\\\".$j.\\\"><input type=checkbox name=odelpathid[] value=\\\".$j.\\\">删</td><td width=\\\'21%\\\'><div align=center><select name=odownuser[] id=select><option value=0>游客</option>\\\".$tgroup.\\\"</select></div></td><td width=\\\'13%\\\'><div align=center><input name=ofen[] type=text value=\\\'\\\".$od_field[3].\\\"\\\' size=6></div></td></tr>\\\";\r\n		}\r\n		$oeditnum=$j;\r\n		$onlinemoviepath=\\\"<table width=\\\'100%\\\' border=0 cellspacing=1 cellpadding=3>\\\".$onlinemoviepath.\\\"</table>\\\";\r\n	}\r\n	echo $onlinemoviepath;\r\n    }\r\n    ?>\r\n    </td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\">在线地址扩展数量: <input name=\\\"oeditnum\\\" type=\\\"hidden\\\" id=\\\"oeditnum\\\" value=\\\"<?=$oeditnum?>\\\">\r\n      <input name=\\\"odownnum\\\" type=\\\"text\\\" id=\\\"odownnum\\\" value=\\\"1\\\" size=\\\"6\\\"> <input type=\\\"button\\\" name=\\\"Submit5\\\" value=\\\"输出地址\\\" onclick=\\\"javascript:dooadd();\\\"></td>\r\n  </tr>\r\n  <tr> \r\n    <td id=addonline></td>\r\n  </tr>\r\n</table>\r\n', '', 1, 1, 1, 2, 'MEDIUMTEXT', '', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (69, 'moviesay', '影片简介', 'textarea', '<textarea name=\\\"moviesay\\\" cols=\\\"80\\\" rows=\\\"10\\\" id=\\\"moviesay\\\"><?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[moviesay]))?></textarea>\r\n', '', 1, 1, 1, 2, 'TEXT', '', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 1);
INSERT INTO `fa_cms_newsfp` VALUES (70, 'title', '标题', 'text', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">\r\n<?=$tts?\\\"<select name=\\\'ttid\\\'><option value=\\\'0\\\'>标题分类</option>$tts</select>\\\":\\\"\\\"?>\r\n	<input type=text name=title value=\\\"<?=htmlspecialchars(stripSlashes($r[title]))?>\\\" size=\\\"60\\\"> \r\n	<input type=\\\"button\\\" name=\\\"button\\\" value=\\\"图文\\\" onclick=\\\"document.add.title.value=document.add.title.value+\\\'(图文)\\\';\\\"> \r\n  </td>\r\n</tr>\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">属性: \r\n	<input name=\\\"titlefont[b]\\\" type=\\\"checkbox\\\" value=\\\"b\\\"<?=$titlefontb?>>粗体\r\n	<input name=\\\"titlefont[i]\\\" type=\\\"checkbox\\\" value=\\\"i\\\"<?=$titlefonti?>>斜体\r\n	<input name=\\\"titlefont[s]\\\" type=\\\"checkbox\\\" value=\\\"s\\\"<?=$titlefonts?>>删除线\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;颜色: <input name=\\\"titlecolor\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titlecolor])?>\\\" size=\\\"10\\\"><a onclick=\\\"foreColor();\\\"><img src=\\\"../data/images/color.gif\\\" width=\\\"21\\\" height=\\\"21\\\" align=\\\"absbottom\\\"></a>\r\n  </td>\r\n</tr>\r\n</table>', '标题', 0, 1, 1, 0, 'VARCHAR', '200', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (71, 'special.field', '特殊属性', '', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">信息属性: \r\n      <input name=\\\"checked\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[checked]?\\\' checked\\\':\\\'\\\'?>>\r\n      审核 &nbsp;&nbsp; 推荐 \r\n      <select name=\\\"isgood\\\" id=\\\"isgood\\\">\r\n        <option value=\\\"0\\\"<?=$r[isgood]==0?\\\' selected\\\':\\\'\\\'?>>不推荐</option>\r\n        <option value=\\\"1\\\"<?=$r[isgood]==1?\\\' selected\\\':\\\'\\\'?>>一级推荐</option>\r\n        <option value=\\\"2\\\"<?=$r[isgood]==2?\\\' selected\\\':\\\'\\\'?>>二级推荐</option>\r\n        <option value=\\\"3\\\"<?=$r[isgood]==3?\\\' selected\\\':\\\'\\\'?>>三级推荐</option>\r\n        <option value=\\\"4\\\"<?=$r[isgood]==4?\\\' selected\\\':\\\'\\\'?>>四级推荐</option>\r\n        <option value=\\\"5\\\"<?=$r[isgood]==5?\\\' selected\\\':\\\'\\\'?>>五级推荐</option>\r\n        <option value=\\\"6\\\"<?=$r[isgood]==6?\\\' selected\\\':\\\'\\\'?>>六级推荐</option>\r\n        <option value=\\\"7\\\"<?=$r[isgood]==7?\\\' selected\\\':\\\'\\\'?>>七级推荐</option>\r\n        <option value=\\\"8\\\"<?=$r[isgood]==8?\\\' selected\\\':\\\'\\\'?>>八级推荐</option>\r\n        <option value=\\\"9\\\"<?=$r[isgood]==9?\\\' selected\\\':\\\'\\\'?>>九级推荐</option>\r\n      </select>\r\n      &nbsp;&nbsp; 头条 \r\n      <select name=\\\"firsttitle\\\" id=\\\"firsttitle\\\">\r\n        <option value=\\\"0\\\"<?=$r[firsttitle]==0?\\\' selected\\\':\\\'\\\'?>>非头条</option>\r\n        <option value=\\\"1\\\"<?=$r[firsttitle]==1?\\\' selected\\\':\\\'\\\'?>>一级头条</option>\r\n        <option value=\\\"2\\\"<?=$r[firsttitle]==2?\\\' selected\\\':\\\'\\\'?>>二级头条</option>\r\n        <option value=\\\"3\\\"<?=$r[firsttitle]==3?\\\' selected\\\':\\\'\\\'?>>三级头条</option>\r\n        <option value=\\\"4\\\"<?=$r[firsttitle]==4?\\\' selected\\\':\\\'\\\'?>>四级头条</option>\r\n        <option value=\\\"5\\\"<?=$r[firsttitle]==5?\\\' selected\\\':\\\'\\\'?>>五级头条</option>\r\n        <option value=\\\"6\\\"<?=$r[firsttitle]==6?\\\' selected\\\':\\\'\\\'?>>六级头条</option>\r\n        <option value=\\\"7\\\"<?=$r[firsttitle]==7?\\\' selected\\\':\\\'\\\'?>>七级头条</option>\r\n        <option value=\\\"8\\\"<?=$r[firsttitle]==8?\\\' selected\\\':\\\'\\\'?>>八级头条</option>\r\n        <option value=\\\"9\\\"<?=$r[firsttitle]==9?\\\' selected\\\':\\\'\\\'?>>九级头条</option>\r\n      </select></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">关键字&nbsp;&nbsp;&nbsp;: \r\n      <input name=\\\"keyboard\\\" type=\\\"text\\\" size=\\\"52\\\" value=\\\"<?=stripSlashes($r[keyboard])?>\\\">\r\n      <font color=\\\"#666666\\\">(多个请用&quot;,&quot;隔开)</font></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">外部链接: \r\n      <input name=\\\"titleurl\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titleurl])?>\\\" size=\\\"52\\\">\r\n      <font color=\\\"#666666\\\">(填写后信息连接地址将为此链接)</font></td>\r\n  </tr>\r\n</table>\r\n', '特殊属性', 0, 1, 0, 0, '', '', 0, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (72, 'titlepic', '标题图片', 'img', '\r\n<input name=\\\"titlepic\\\" type=\\\"text\\\" id=\\\"titlepic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[titlepic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=titlepic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '标题图片', 0, 1, 1, 1, 'VARCHAR', '200', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (73, 'newstime', '发布时间', 'text', '<input name=\\\"newstime\\\" type=\\\"text\\\" value=\\\"<?=$r[newstime]?>\\\"><input type=button name=button value=\\\"设为当前时间\\\" onclick=\\\"document.add.newstime.value=\\\'<?=$todaytime?>\\\'\\\">', '发布时间', 0, 1, 1, 0, 'INT', '10', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (74, 'productno', '商品编号', 'text', '<input name=\\\"productno\\\" type=\\\"text\\\" size=60 id=\\\"productno\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[productno]))?>\\\">\r\n', '', 1, 1, 1, 0, 'VARCHAR', '30', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (75, 'pbrand', '品牌', 'text', '<input name=\\\"pbrand\\\" type=\\\"text\\\" size=60 id=\\\"pbrand\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[pbrand]))?>\\\">\r\n', '', 1, 1, 1, 0, 'VARCHAR', '30', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (76, 'intro', '简单描述', 'textarea', '<textarea name=\\\"intro\\\" cols=\\\"80\\\" rows=\\\"10\\\" id=\\\"intro\\\"><?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[intro]))?></textarea>\r\n', '', 1, 1, 1, 0, 'TEXT', '', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (77, 'unit', '计量单位', 'text', '<input name=\\\"unit\\\" type=\\\"text\\\" size=60 id=\\\"unit\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[unit]))?>\\\">\r\n', '', 1, 1, 1, 0, 'VARCHAR', '16', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (78, 'weight', '单位重量', 'text', '<input name=\\\"weight\\\" type=\\\"text\\\" size=60 id=\\\"weight\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[weight]))?>\\\">\r\n', '', 1, 1, 1, 0, 'VARCHAR', '20', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (79, 'tprice', '市场价格', 'text', '<input name=\\\"tprice\\\" type=\\\"text\\\" size=60 id=\\\"tprice\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[tprice]))?>\\\">\r\n', '', 1, 1, 1, 0, 'FLOAT', '11,2', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (80, 'price', '购买价格', 'text', '<input name=\\\"price\\\" type=\\\"text\\\" size=60 id=\\\"price\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[price]))?>\\\">\r\n', '', 1, 1, 1, 0, 'FLOAT', '11,2', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (81, 'buyfen', '积分购买', 'text', '<input name=\\\"buyfen\\\" type=\\\"text\\\" size=60 id=\\\"buyfen\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[buyfen]))?>\\\">\r\n', '', 1, 1, 1, 0, 'INT', '', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (82, 'pmaxnum', '库存', 'text', '<input name=\\\"pmaxnum\\\" type=\\\"text\\\" size=60 id=\\\"pmaxnum\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[pmaxnum]))?>\\\">\r\n', '', 1, 1, 1, 0, 'INT', '', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (83, 'productpic', '商品大图', 'img', '\r\n<input name=\\\"productpic\\\" type=\\\"text\\\" id=\\\"productpic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[productpic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=productpic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '', 1, 1, 1, 1, 'VARCHAR', '255', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (84, 'newstext', '商品介绍', 'editor', '<?=ECMS_ShowEditorVar(\\\"newstext\\\",$ecmsfirstpost==1?\\\"\\\":stripSlashes($r[newstext]),\\\"Default\\\",\\\"\\\",\\\"300\\\",\\\"100%\\\")?>\r\n<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"3\\\" cellspacing=\\\"1\\\" bgcolor=\\\"#DBEAF5\\\">\r\n          <tr> \r\n            <td bgcolor=\\\"#FFFFFF\\\"> <input name=\\\"dokey\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[dokey]==1?\\\' checked\\\':\\\'\\\'?>>\r\n              关键字替换&nbsp;&nbsp; <input name=\\\"copyimg\\\" type=\\\"checkbox\\\" id=\\\"copyimg\\\" value=\\\"1\\\">\r\n      远程保存图片(\r\n      <input name=\\\"mark\\\" type=\\\"checkbox\\\" id=\\\"mark\\\" value=\\\"1\\\">\r\n      <a href=\\\"SetEnews.php\\\" target=\\\"_blank\\\">加水印</a>)&nbsp;&nbsp; \r\n      <input name=\\\"copyflash\\\" type=\\\"checkbox\\\" id=\\\"copyflash\\\" value=\\\"1\\\">\r\n      远程保存FLASH(地址前缀： \r\n      <input name=\\\"qz_url\\\" type=\\\"text\\\" id=\\\"qz_url\\\" size=\\\"\\\">\r\n              )</td>\r\n          </tr>\r\n          <tr>\r\n            \r\n    <td bgcolor=\\\"#FFFFFF\\\"><input name=\\\"repimgnexturl\\\" type=\\\"checkbox\\\" id=\\\"repimgnexturl\\\" value=\\\"1\\\"> 图片链接转为下一页&nbsp;&nbsp; <input name=\\\"autopage\\\" type=\\\"checkbox\\\" id=\\\"autopage\\\" value=\\\"1\\\">自动分页 \r\n      ,每 \r\n      <input name=\\\"autosize\\\" type=\\\"text\\\" id=\\\"autosize\\\" value=\\\"5000\\\" size=\\\"5\\\">\r\n      个字节为一页&nbsp;&nbsp; 取第 \r\n      <input name=\\\"getfirsttitlepic\\\" type=\\\"text\\\" id=\\\"getfirsttitlepic\\\" value=\\\"\\\" size=\\\"1\\\">\r\n      张上传图为标题图片( \r\n      <input name=\\\"getfirsttitlespic\\\" type=\\\"checkbox\\\" id=\\\"getfirsttitlespic\\\" value=\\\"1\\\">\r\n      缩略图: 宽 \r\n      <input name=\\\"getfirsttitlespicw\\\" type=\\\"text\\\" id=\\\"getfirsttitlespicw\\\" size=\\\"3\\\" value=\\\"<?=$public_r[spicwidth]?>\\\">\r\n      *高\r\n      <input name=\\\"getfirsttitlespich\\\" type=\\\"text\\\" id=\\\"getfirsttitlespich\\\" size=\\\"3\\\" value=\\\"<?=$public_r[spicheight]?>\\\">\r\n      )</td>\r\n          </tr>\r\n        </table>\r\n', '', 1, 1, 1, 1, 'MEDIUMTEXT', '', 1, 6, 'shop', 0, 0, 1, 1, 0, '', 0, '', 0, 1, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (85, 'title', '标题', 'text', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">\r\n<?=$tts?\\\"<select name=\\\'ttid\\\'><option value=\\\'0\\\'>标题分类</option>$tts</select>\\\":\\\"\\\"?>\r\n	<input type=text name=title value=\\\"<?=htmlspecialchars(stripSlashes($r[title]))?>\\\" size=\\\"60\\\"> \r\n	<input type=\\\"button\\\" name=\\\"button\\\" value=\\\"图文\\\" onclick=\\\"document.add.title.value=document.add.title.value+\\\'(图文)\\\';\\\"> \r\n  </td>\r\n</tr>\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">属性: \r\n	<input name=\\\"titlefont[b]\\\" type=\\\"checkbox\\\" value=\\\"b\\\"<?=$titlefontb?>>粗体\r\n	<input name=\\\"titlefont[i]\\\" type=\\\"checkbox\\\" value=\\\"i\\\"<?=$titlefonti?>>斜体\r\n	<input name=\\\"titlefont[s]\\\" type=\\\"checkbox\\\" value=\\\"s\\\"<?=$titlefonts?>>删除线\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;颜色: <input name=\\\"titlecolor\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titlecolor])?>\\\" size=\\\"10\\\"><a onclick=\\\"foreColor();\\\"><img src=\\\"../data/images/color.gif\\\" width=\\\"21\\\" height=\\\"21\\\" align=\\\"absbottom\\\"></a>\r\n  </td>\r\n</tr>\r\n</table>', '标题', 0, 1, 1, 0, 'CHAR', '200', 1, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (86, 'special.field', '特殊属性', '', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">信息属性: \r\n      <input name=\\\"checked\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[checked]?\\\' checked\\\':\\\'\\\'?>>\r\n      审核 &nbsp;&nbsp; 推荐 \r\n      <select name=\\\"isgood\\\" id=\\\"isgood\\\">\r\n        <option value=\\\"0\\\"<?=$r[isgood]==0?\\\' selected\\\':\\\'\\\'?>>不推荐</option>\r\n        <option value=\\\"1\\\"<?=$r[isgood]==1?\\\' selected\\\':\\\'\\\'?>>一级推荐</option>\r\n        <option value=\\\"2\\\"<?=$r[isgood]==2?\\\' selected\\\':\\\'\\\'?>>二级推荐</option>\r\n        <option value=\\\"3\\\"<?=$r[isgood]==3?\\\' selected\\\':\\\'\\\'?>>三级推荐</option>\r\n        <option value=\\\"4\\\"<?=$r[isgood]==4?\\\' selected\\\':\\\'\\\'?>>四级推荐</option>\r\n        <option value=\\\"5\\\"<?=$r[isgood]==5?\\\' selected\\\':\\\'\\\'?>>五级推荐</option>\r\n        <option value=\\\"6\\\"<?=$r[isgood]==6?\\\' selected\\\':\\\'\\\'?>>六级推荐</option>\r\n        <option value=\\\"7\\\"<?=$r[isgood]==7?\\\' selected\\\':\\\'\\\'?>>七级推荐</option>\r\n        <option value=\\\"8\\\"<?=$r[isgood]==8?\\\' selected\\\':\\\'\\\'?>>八级推荐</option>\r\n        <option value=\\\"9\\\"<?=$r[isgood]==9?\\\' selected\\\':\\\'\\\'?>>九级推荐</option>\r\n      </select>\r\n      &nbsp;&nbsp; 头条 \r\n      <select name=\\\"firsttitle\\\" id=\\\"firsttitle\\\">\r\n        <option value=\\\"0\\\"<?=$r[firsttitle]==0?\\\' selected\\\':\\\'\\\'?>>非头条</option>\r\n        <option value=\\\"1\\\"<?=$r[firsttitle]==1?\\\' selected\\\':\\\'\\\'?>>一级头条</option>\r\n        <option value=\\\"2\\\"<?=$r[firsttitle]==2?\\\' selected\\\':\\\'\\\'?>>二级头条</option>\r\n        <option value=\\\"3\\\"<?=$r[firsttitle]==3?\\\' selected\\\':\\\'\\\'?>>三级头条</option>\r\n        <option value=\\\"4\\\"<?=$r[firsttitle]==4?\\\' selected\\\':\\\'\\\'?>>四级头条</option>\r\n        <option value=\\\"5\\\"<?=$r[firsttitle]==5?\\\' selected\\\':\\\'\\\'?>>五级头条</option>\r\n        <option value=\\\"6\\\"<?=$r[firsttitle]==6?\\\' selected\\\':\\\'\\\'?>>六级头条</option>\r\n        <option value=\\\"7\\\"<?=$r[firsttitle]==7?\\\' selected\\\':\\\'\\\'?>>七级头条</option>\r\n        <option value=\\\"8\\\"<?=$r[firsttitle]==8?\\\' selected\\\':\\\'\\\'?>>八级头条</option>\r\n        <option value=\\\"9\\\"<?=$r[firsttitle]==9?\\\' selected\\\':\\\'\\\'?>>九级头条</option>\r\n      </select></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">关键字&nbsp;&nbsp;&nbsp;: \r\n      <input name=\\\"keyboard\\\" type=\\\"text\\\" size=\\\"52\\\" value=\\\"<?=stripSlashes($r[keyboard])?>\\\">\r\n      <font color=\\\"#666666\\\">(多个请用&quot;,&quot;隔开)</font></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">外部链接: \r\n      <input name=\\\"titleurl\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titleurl])?>\\\" size=\\\"52\\\">\r\n      <font color=\\\"#666666\\\">(填写后信息连接地址将为此链接)</font></td>\r\n  </tr>\r\n</table>\r\n', '特殊属性', 0, 1, 0, 1, '', '', 0, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (87, 'titlepic', '标题图片', 'img', '\r\n<input name=\\\"titlepic\\\" type=\\\"text\\\" id=\\\"titlepic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[titlepic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=titlepic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '标题图片', 0, 1, 1, 2, 'CHAR', '200', 1, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (88, 'newstime', '发布时间', 'text', '<input name=\\\"newstime\\\" type=\\\"text\\\" value=\\\"<?=$r[newstime]?>\\\"><input type=button name=button value=\\\"设为当前时间\\\" onclick=\\\"document.add.newstime.value=\\\'<?=$todaytime?>\\\'\\\">', '发布时间', 0, 1, 1, 1, 'INT', '10', 1, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (89, 'ftitle', '副标题', 'text', '<input name=\\\"ftitle\\\" type=\\\"text\\\" size=60 id=\\\"ftitle\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[ftitle]))?>\\\">\r\n', '', 1, 1, 1, 0, 'CHAR', '120', 1, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (90, 'smalltext', '内容简介', 'textarea', '<textarea name=\\\"smalltext\\\" cols=\\\"80\\\" rows=\\\"10\\\" id=\\\"smalltext\\\"><?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[smalltext]))?></textarea>\r\n', '', 1, 1, 1, 2, 'CHAR', '255', 1, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 1);
INSERT INTO `fa_cms_newsfp` VALUES (91, 'writer', '作者', 'text', '\r\n<?php\r\n$writer_sql=$empire->query(\\\"select writer from {$dbtbpre}enewswriter\\\");\r\nwhile($w_r=$empire->fetch($writer_sql))\r\n{\r\n	$w_class.=\\\"<option value=\\\'\\\".$w_r[writer].\\\"\\\'>\\\".$w_r[writer].\\\"</option>\\\";\r\n}\r\n?>\r\n<input type=text name=writer value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[writer]))?>\\\" size=\\\"\\\"> \r\n        <select name=\\\"w_id\\\" id=\\\"select7\\\" onchange=\\\"document.add.writer.value=document.add.w_id.value\\\">\r\n          <option>选择作者</option>\r\n		  <?=$w_class?>\r\n        </select>\r\n<input type=\\\"button\\\" name=\\\"wbutton\\\" value=\\\"增加作者\\\" onclick=\\\"window.open(\\\'NewsSys/writer.php?addwritername=\\\'+document.add.writer.value);\\\">\r\n', '', 1, 1, 1, 2, 'CHAR', '30', 1, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (92, 'befrom', '信息来源', 'text', '\r\n<?php\r\n$befrom_sql=$empire->query(\\\"select sitename from {$dbtbpre}enewsbefrom\\\");\r\nwhile($b_r=$empire->fetch($befrom_sql))\r\n{\r\n	$b_class.=\\\"<option value=\\\'\\\".$b_r[sitename].\\\"\\\'>\\\".$b_r[sitename].\\\"</option>\\\";\r\n}\r\n?>\r\n<input type=\\\"text\\\" name=\\\"befrom\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[befrom]))?>\\\" size=\\\"\\\"> \r\n        <select name=\\\"befrom_id\\\" id=\\\"befromid\\\" onchange=\\\"document.add.befrom.value=document.add.befrom_id.value\\\">\r\n          <option>选择信息来源</option>\r\n          <?=$b_class?>\r\n        </select>\r\n<input type=\\\"button\\\" name=\\\"wbutton\\\" value=\\\"增加来源\\\" onclick=\\\"window.open(\\\'NewsSys/BeFrom.php?addsitename=\\\'+document.add.befrom.value);\\\">\r\n', '', 1, 1, 1, 2, 'CHAR', '60', 1, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (93, 'newstext', '新闻正文', 'editor', '<?=ECMS_ShowEditorVar(\\\"newstext\\\",$ecmsfirstpost==1?\\\"\\\":stripSlashes($r[newstext]),\\\"Default\\\",\\\"\\\",\\\"300\\\",\\\"100%\\\")?>\r\n<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"3\\\" cellspacing=\\\"1\\\" bgcolor=\\\"#DBEAF5\\\">\r\n          <tr> \r\n            <td bgcolor=\\\"#FFFFFF\\\"> <input name=\\\"dokey\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[dokey]==1?\\\' checked\\\':\\\'\\\'?>>\r\n              关键字替换&nbsp;&nbsp; <input name=\\\"copyimg\\\" type=\\\"checkbox\\\" id=\\\"copyimg\\\" value=\\\"1\\\">\r\n      远程保存图片(\r\n      <input name=\\\"mark\\\" type=\\\"checkbox\\\" id=\\\"mark\\\" value=\\\"1\\\">\r\n      <a href=\\\"SetEnews.php\\\" target=\\\"_blank\\\">加水印</a>)&nbsp;&nbsp; \r\n      <input name=\\\"copyflash\\\" type=\\\"checkbox\\\" id=\\\"copyflash\\\" value=\\\"1\\\">\r\n      远程保存FLASH(地址前缀： \r\n      <input name=\\\"qz_url\\\" type=\\\"text\\\" id=\\\"qz_url\\\" size=\\\"\\\">\r\n              )</td>\r\n          </tr>\r\n          <tr>\r\n            \r\n    <td bgcolor=\\\"#FFFFFF\\\"><input name=\\\"repimgnexturl\\\" type=\\\"checkbox\\\" id=\\\"repimgnexturl\\\" value=\\\"1\\\"> 图片链接转为下一页&nbsp;&nbsp; <input name=\\\"autopage\\\" type=\\\"checkbox\\\" id=\\\"autopage\\\" value=\\\"1\\\">自动分页\r\n      ,每 \r\n      <input name=\\\"autosize\\\" type=\\\"text\\\" id=\\\"autosize\\\" value=\\\"5000\\\" size=\\\"5\\\">\r\n      个字节为一页&nbsp;&nbsp; 取第 \r\n      <input name=\\\"getfirsttitlepic\\\" type=\\\"text\\\" id=\\\"getfirsttitlepic\\\" value=\\\"\\\" size=\\\"1\\\">\r\n      张上传图为标题图片( \r\n      <input name=\\\"getfirsttitlespic\\\" type=\\\"checkbox\\\" id=\\\"getfirsttitlespic\\\" value=\\\"1\\\">\r\n      缩略图: 宽 \r\n      <input name=\\\"getfirsttitlespicw\\\" type=\\\"text\\\" id=\\\"getfirsttitlespicw\\\" size=\\\"3\\\" value=\\\"<?=$public_r[spicwidth]?>\\\">\r\n      *高\r\n      <input name=\\\"getfirsttitlespich\\\" type=\\\"text\\\" id=\\\"getfirsttitlespich\\\" size=\\\"3\\\" value=\\\"<?=$public_r[spicheight]?>\\\">\r\n      )</td>\r\n          </tr>\r\n        </table>\r\n', '', 1, 1, 1, 2, 'CHAR', '50', 1, 7, 'article', 1, 0, 1, 1, 0, '', 0, '', 0, 1, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (94, 'title', '标题', 'text', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">\r\n<?=$tts?\\\"<select name=\\\'ttid\\\'><option value=\\\'0\\\'>标题分类</option>$tts</select>\\\":\\\"\\\"?>\r\n	<input type=text name=title value=\\\"<?=htmlspecialchars(stripSlashes($r[title]))?>\\\" size=\\\"60\\\"> \r\n	<input type=\\\"button\\\" name=\\\"button\\\" value=\\\"图文\\\" onclick=\\\"document.add.title.value=document.add.title.value+\\\'(图文)\\\';\\\"> \r\n  </td>\r\n</tr>\r\n<tr> \r\n  <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">属性: \r\n	<input name=\\\"titlefont[b]\\\" type=\\\"checkbox\\\" value=\\\"b\\\"<?=$titlefontb?>>粗体\r\n	<input name=\\\"titlefont[i]\\\" type=\\\"checkbox\\\" value=\\\"i\\\"<?=$titlefonti?>>斜体\r\n	<input name=\\\"titlefont[s]\\\" type=\\\"checkbox\\\" value=\\\"s\\\"<?=$titlefonts?>>删除线\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;颜色: <input name=\\\"titlecolor\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titlecolor])?>\\\" size=\\\"10\\\"><a onclick=\\\"foreColor();\\\"><img src=\\\"../data/images/color.gif\\\" width=\\\"21\\\" height=\\\"21\\\" align=\\\"absbottom\\\"></a>\r\n  </td>\r\n</tr>\r\n</table>', '标题', 0, 1, 1, 0, 'VARCHAR', '200', 1, 8, 'info', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (95, 'special.field', '特殊属性', '', '<table width=\\\"100%\\\" border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" bgcolor=\\\"#DBEAF5\\\">\r\n  <tr>\r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">信息属性: \r\n      <input name=\\\"checked\\\" type=\\\"checkbox\\\" value=\\\"1\\\"<?=$r[checked]?\\\' checked\\\':\\\'\\\'?>>\r\n      审核 &nbsp;&nbsp; 推荐 \r\n      <select name=\\\"isgood\\\" id=\\\"isgood\\\">\r\n        <option value=\\\"0\\\"<?=$r[isgood]==0?\\\' selected\\\':\\\'\\\'?>>不推荐</option>\r\n        <option value=\\\"1\\\"<?=$r[isgood]==1?\\\' selected\\\':\\\'\\\'?>>一级推荐</option>\r\n        <option value=\\\"2\\\"<?=$r[isgood]==2?\\\' selected\\\':\\\'\\\'?>>二级推荐</option>\r\n        <option value=\\\"3\\\"<?=$r[isgood]==3?\\\' selected\\\':\\\'\\\'?>>三级推荐</option>\r\n        <option value=\\\"4\\\"<?=$r[isgood]==4?\\\' selected\\\':\\\'\\\'?>>四级推荐</option>\r\n        <option value=\\\"5\\\"<?=$r[isgood]==5?\\\' selected\\\':\\\'\\\'?>>五级推荐</option>\r\n        <option value=\\\"6\\\"<?=$r[isgood]==6?\\\' selected\\\':\\\'\\\'?>>六级推荐</option>\r\n        <option value=\\\"7\\\"<?=$r[isgood]==7?\\\' selected\\\':\\\'\\\'?>>七级推荐</option>\r\n        <option value=\\\"8\\\"<?=$r[isgood]==8?\\\' selected\\\':\\\'\\\'?>>八级推荐</option>\r\n        <option value=\\\"9\\\"<?=$r[isgood]==9?\\\' selected\\\':\\\'\\\'?>>九级推荐</option>\r\n      </select>\r\n      &nbsp;&nbsp; 头条 \r\n      <select name=\\\"firsttitle\\\" id=\\\"firsttitle\\\">\r\n        <option value=\\\"0\\\"<?=$r[firsttitle]==0?\\\' selected\\\':\\\'\\\'?>>非头条</option>\r\n        <option value=\\\"1\\\"<?=$r[firsttitle]==1?\\\' selected\\\':\\\'\\\'?>>一级头条</option>\r\n        <option value=\\\"2\\\"<?=$r[firsttitle]==2?\\\' selected\\\':\\\'\\\'?>>二级头条</option>\r\n        <option value=\\\"3\\\"<?=$r[firsttitle]==3?\\\' selected\\\':\\\'\\\'?>>三级头条</option>\r\n        <option value=\\\"4\\\"<?=$r[firsttitle]==4?\\\' selected\\\':\\\'\\\'?>>四级头条</option>\r\n        <option value=\\\"5\\\"<?=$r[firsttitle]==5?\\\' selected\\\':\\\'\\\'?>>五级头条</option>\r\n        <option value=\\\"6\\\"<?=$r[firsttitle]==6?\\\' selected\\\':\\\'\\\'?>>六级头条</option>\r\n        <option value=\\\"7\\\"<?=$r[firsttitle]==7?\\\' selected\\\':\\\'\\\'?>>七级头条</option>\r\n        <option value=\\\"8\\\"<?=$r[firsttitle]==8?\\\' selected\\\':\\\'\\\'?>>八级头条</option>\r\n        <option value=\\\"9\\\"<?=$r[firsttitle]==9?\\\' selected\\\':\\\'\\\'?>>九级头条</option>\r\n      </select></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">关键字&nbsp;&nbsp;&nbsp;: \r\n      <input name=\\\"keyboard\\\" type=\\\"text\\\" size=\\\"52\\\" value=\\\"<?=stripSlashes($r[keyboard])?>\\\">\r\n      <font color=\\\"#666666\\\">(多个请用&quot;,&quot;隔开)</font></td>\r\n  </tr>\r\n  <tr> \r\n    <td height=\\\"25\\\" bgcolor=\\\"#FFFFFF\\\">外部链接: \r\n      <input name=\\\"titleurl\\\" type=\\\"text\\\" value=\\\"<?=stripSlashes($r[titleurl])?>\\\" size=\\\"52\\\">\r\n      <font color=\\\"#666666\\\">(填写后信息连接地址将为此链接)</font></td>\r\n  </tr>\r\n</table>\r\n', '特殊属性', 0, 1, 0, 0, '', '', 0, 8, 'info', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (96, 'titlepic', '标题图片', 'img', '\r\n<input name=\\\"titlepic\\\" type=\\\"text\\\" id=\\\"titlepic\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[titlepic]))?>\\\" size=\\\"45\\\">\r\n<a onclick=\\\"window.open(\\\'ecmseditor/FileMain.php?type=1&classid=<?=$classid?>&filepass=<?=$filepass?>&doing=1&field=titlepic\\\',\\\'\\\',\\\'width=700,height=550,scrollbars=yes\\\');\\\" title=\\\"选择已上传的图片\\\"><img src=\\\"../data/images/changeimg.gif\\\" border=\\\"0\\\" align=\\\"absbottom\\\"></a> \r\n', '标题图片', 0, 1, 1, 1, 'VARCHAR', '200', 1, 8, 'info', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (97, 'newstime', '发布时间', 'text', '<input name=\\\"newstime\\\" type=\\\"text\\\" value=\\\"<?=$r[newstime]?>\\\"><input type=button name=button value=\\\"设为当前时间\\\" onclick=\\\"document.add.newstime.value=\\\'<?=$todaytime?>\\\'\\\">', '发布时间', 0, 1, 1, 0, 'INT', '10', 1, 8, 'info', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (98, 'smalltext', '信息内容', 'textarea', '<textarea name=\\\"smalltext\\\" cols=\\\"80\\\" rows=\\\"10\\\" id=\\\"smalltext\\\"><?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[smalltext]))?></textarea>\r\n', '', 1, 1, 1, 0, 'TEXT', '', 1, 8, 'info', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 1);
INSERT INTO `fa_cms_newsfp` VALUES (99, 'myarea', '所在地', 'select', '<select name=\\\"myarea\\\" id=\\\"myarea\\\" size=6 style=\\\"width=150\\\"><option value=\\\"东城区\\\"<?=$r[myarea]==\\\"东城区\\\"||$ecmsfirstpost==1?\\\' selected\\\':\\\'\\\'?>>东城区</option><option value=\\\"西城区\\\"<?=$r[myarea]==\\\"西城区\\\"?\\\' selected\\\':\\\'\\\'?>>西城区</option><option value=\\\"崇文区\\\"<?=$r[myarea]==\\\"崇文区\\\"?\\\' selected\\\':\\\'\\\'?>>崇文区</option><option value=\\\"宣武区\\\"<?=$r[myarea]==\\\"宣武区\\\"?\\\' selected\\\':\\\'\\\'?>>宣武区</option><option value=\\\"朝阳区\\\"<?=$r[myarea]==\\\"朝阳区\\\"?\\\' selected\\\':\\\'\\\'?>>朝阳区</option><option value=\\\"海淀区\\\"<?=$r[myarea]==\\\"海淀区\\\"?\\\' selected\\\':\\\'\\\'?>>海淀区</option><option value=\\\"丰台区\\\"<?=$r[myarea]==\\\"丰台区\\\"?\\\' selected\\\':\\\'\\\'?>>丰台区</option><option value=\\\"石景山区\\\"<?=$r[myarea]==\\\"石景山区\\\"?\\\' selected\\\':\\\'\\\'?>>石景山区</option><option value=\\\"通州区\\\"<?=$r[myarea]==\\\"通州区\\\"?\\\' selected\\\':\\\'\\\'?>>通州区</option><option value=\\\"昌平区\\\"<?=$r[myarea]==\\\"昌平区\\\"?\\\' selected\\\':\\\'\\\'?>>昌平区</option><option value=\\\"大兴区\\\"<?=$r[myarea]==\\\"大兴区\\\"?\\\' selected\\\':\\\'\\\'?>>大兴区</option><option value=\\\"其它\\\"<?=$r[myarea]==\\\"其它\\\"?\\\' selected\\\':\\\'\\\'?>>其它</option></select>', '', 1, 1, 1, 1, 'VARCHAR', '30', 1, 8, 'info', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (100, 'email', '邮箱', 'text', '<input name=\\\"email\\\" type=\\\"text\\\" id=\\\"email\\\" value=\\\"<?=$ecmsfirstpost==1?$memberinfor[$user_email]:htmlspecialchars(stripSlashes($r[email]))?>\\\" size=\\\"60\\\">\r\n', '', 1, 1, 1, 2, 'VARCHAR', '80', 1, 8, 'info', 0, 0, 1, 1, 0, '', 0, '46', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (101, 'mycontact', '联系方式', 'text', '<input name=\\\"mycontact\\\" type=\\\"text\\\" size=60 id=\\\"mycontact\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[mycontact]))?>\\\">\r\n', '', 1, 1, 1, 2, 'VARCHAR', '255', 1, 8, 'info', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (102, 'address', '联系地址', 'text', '<input name=\\\"address\\\" type=\\\"text\\\" id=\\\"address\\\" value=\\\"<?=$ecmsfirstpost==1?$memberinfor[address]:htmlspecialchars(stripSlashes($r[address]))?>\\\" size=\\\"60\\\">\r\n', '', 1, 1, 1, 2, 'VARCHAR', '255', 1, 8, 'info', 0, 0, 1, 1, 0, '', 0, '46', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (103, 'playerid', '播放器', 'text', '\r\n<?php\r\n$player_sql=$empire->query(\\\"select id,player from {$dbtbpre}enewsplayer\\\");\r\nwhile($player_r=$empire->fetch($player_sql))\r\n{\r\n	$select_player=\\\'\\\';\r\n	if($r[playerid]==$player_r[id])\r\n	{\r\n		$select_player=\\\' selected\\\';\r\n	}\r\n	$player_class.=\\\"<option value=\\\'\\\".$player_r[id].\\\"\\\'\\\".$select_player.\\\">\\\".$player_r[player].\\\"</option>\\\";\r\n}\r\n?>\r\n<select name=\\\"playerid\\\">\r\n<option value=0>自动识别</option>\r\n<?=$player_class?>\r\n</select>\r\n', '视频播放器', 1, 1, 1, 1, 'SMALLINT', '', 1, 5, 'movie', 0, 0, 1, 1, 0, '', 0, '', 1, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (104, 'diggtop', '顶', 'text', '<input name=\\\"diggtop\\\" type=\\\"text\\\" id=\\\"diggtop\\\" value=\\\"<?=$ecmsfirstpost==1?\\\"\\\":htmlspecialchars(stripSlashes($r[diggtop]))?>\\\">\r\n', '', 1, 1, 1, 3, 'INT', '', 1, 1, 'news', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (105, 'diggtop', '顶', 'text', '\r\n<input name=\"diggtop\" type=\"text\" id=\"diggtop\" value=\"<?=$ecmsfirstpost==1?\"\":htmlspecialchars(stripSlashes($r[diggtop]))?>\" size=\"\">\r\n', '', 1, 1, 1, 3, 'INT', '', 1, 7, 'article', 0, 0, 1, 1, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (115, 'tmp9', 'tmp0', 'tmp0', 'tmp9', '', 0, 0, 0, 0, 'CHAR', '90', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (112, 'readnum1', '浏览次数1', 'text', '<input type=\'hidend\' value=\'${readnum}\' name=\'readnum\' id=\'readnum\'/>', '', 0, 0, 0, 0, 'CHAR', '11', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (113, 'newspath', '新闻路径', 'text', '无', '', 0, 0, 0, 0, 'CHAR', '20', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (114, 'keyboard', '关键词', 'text', '<input type=\'text\' id=\'keyboard\' name=\'keyboard\' value=\'\'/>', '', 0, 0, 0, 0, 'CHAR', '160', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (116, 't10', 't', 't', 't', '', 0, 0, 0, 0, 'CHAR', '222', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (117, 'tmp11', 'tmp11', 'area', 'html', '', 0, 0, 0, 0, 'CHAR', '222', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (118, 'tmp1', '临时字段', 'text', 'html', '', 0, 0, 0, 0, 'CHAR', '255', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (119, 'tmp2', 'tmp2', 'tmp2', 'tmp2', '', 0, 0, 0, 0, 'CHAR', '255', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (120, 'readnum1', '浏览数', 'text', 'html', '', 0, 0, 0, 0, 'CHAR', '11', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (121, 'readnum2', '浏览次数', 'ssas', 'ssas', '', 0, 0, 0, 0, 'CHAR', '11', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);
INSERT INTO `fa_cms_newsfp` VALUES (122, 'readnum2', '浏览量', 'ttt', 'tttts', '', 0, 0, 0, 0, 'CHAR', '22', 0, 1, '', 0, 0, 0, 0, 0, '', 0, '', 0, 0, '', '', '', '', '', '', 0, 0);

-- ----------------------------
-- Table structure for fa_cms_rec_info
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_rec_info`;
CREATE TABLE `fa_cms_rec_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `info_seq` int(11) NULL DEFAULT NULL COMMENT '推荐部位中的第几个位置',
  `info_vid` int(11) NOT NULL COMMENT 'FK,来自contents 文章ID',
  `info_pid` int(11) NOT NULL COMMENT '推荐显示位置(外键)',
  `info_pname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推荐位置名称',
  `is_img` tinyint(10) NULL DEFAULT NULL COMMENT '是否图片推荐',
  `info_imgSrc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片路径 默认是在/ upload/recpic/',
  `info_recdate` datetime NOT NULL COMMENT '对应rec_info  推荐时间',
  `temp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_info_vid`(`info_vid`) USING BTREE,
  INDEX `fk_info_pid`(`info_pid`) USING BTREE,
  CONSTRAINT `fk_info_pid` FOREIGN KEY (`info_pid`) REFERENCES `fa_cms_rec_part` (`pid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_info_vid` FOREIGN KEY (`info_vid`) REFERENCES `fa_cms_news` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_rec_info
-- ----------------------------
INSERT INTO `fa_cms_rec_info` VALUES (3, NULL, 180, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/1376057694375.jpg', '2013-08-09 22:17:29', '');
INSERT INTO `fa_cms_rec_info` VALUES (4, NULL, 178, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/1376057708937.jpg', '2013-08-09 22:17:29', '');
INSERT INTO `fa_cms_rec_info` VALUES (5, NULL, 159, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/1376124422640.gif', '2013-08-10 16:47:20', '');
INSERT INTO `fa_cms_rec_info` VALUES (6, NULL, 158, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/1376124434359.gif', '2013-08-10 16:47:20', '');
INSERT INTO `fa_cms_rec_info` VALUES (7, NULL, 63, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/1376124631062.gif', '2013-08-10 16:50:38', '');
INSERT INTO `fa_cms_rec_info` VALUES (8, NULL, 180, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/1376125193875.gif', '2013-08-10 17:00:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (9, NULL, 180, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/1376125193875.gif', '2013-08-10 17:03:30', '');
INSERT INTO `fa_cms_rec_info` VALUES (10, NULL, 180, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/1376125193875.gif', '2013-08-10 17:03:54', '');
INSERT INTO `fa_cms_rec_info` VALUES (11, NULL, 180, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081017053795214.gif', '2013-08-10 17:05:50', '');
INSERT INTO `fa_cms_rec_info` VALUES (12, NULL, 157, 17, '首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081017373029729.gif', '2013-08-10 17:38:28', '');
INSERT INTO `fa_cms_rec_info` VALUES (13, NULL, 180, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209091926074.gif', '2013-08-12 09:09:53', '');
INSERT INTO `fa_cms_rec_info` VALUES (14, NULL, 178, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209093276529.gif', '2013-08-12 09:09:53', '');
INSERT INTO `fa_cms_rec_info` VALUES (15, NULL, 159, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209094238770.gif', '2013-08-12 09:09:53', '');
INSERT INTO `fa_cms_rec_info` VALUES (16, NULL, 158, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209094928085.gif', '2013-08-12 09:09:53', '');
INSERT INTO `fa_cms_rec_info` VALUES (17, NULL, 180, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209103564718.gif', '2013-08-12 09:10:38', '');
INSERT INTO `fa_cms_rec_info` VALUES (18, NULL, 180, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209164139166.gif', '2013-08-12 09:18:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (19, NULL, 180, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209191170158.gif', '2013-08-12 09:19:22', '');
INSERT INTO `fa_cms_rec_info` VALUES (20, NULL, 178, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209210836242.gif', '2013-08-12 09:21:25', '');
INSERT INTO `fa_cms_rec_info` VALUES (21, NULL, 180, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209224743144.gif', '2013-08-12 09:23:10', '');
INSERT INTO `fa_cms_rec_info` VALUES (22, NULL, 178, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209225544520.gif', '2013-08-12 09:23:10', '');
INSERT INTO `fa_cms_rec_info` VALUES (23, NULL, 159, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209230215839.gif', '2013-08-12 09:23:10', '');
INSERT INTO `fa_cms_rec_info` VALUES (24, NULL, 158, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081209230884933.gif', '2013-08-12 09:23:10', '');
INSERT INTO `fa_cms_rec_info` VALUES (25, NULL, 180, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081209544630427.gif', '2013-08-12 09:54:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (26, NULL, 178, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081209543869882.jpg', '2013-08-12 09:54:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (27, NULL, 159, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081209542652871.jpg', '2013-08-12 09:54:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (28, NULL, 158, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081209541485780.jpg', '2013-08-12 09:54:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (29, NULL, 157, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081209535591817.gif', '2013-08-12 09:54:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (30, NULL, 156, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081209533864068.png', '2013-08-12 09:54:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (31, NULL, 155, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081209525641648.gif', '2013-08-12 09:54:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (32, NULL, 180, 18, NULL, 0, 'cms/ender/upload/recpic/2013081209592410016.gif', '2013-08-12 09:59:30', '');
INSERT INTO `fa_cms_rec_info` VALUES (33, NULL, 180, 18, NULL, 0, 'cms/ender/upload/recpic/2013081210125559923.gif', '2013-08-12 10:12:59', '');
INSERT INTO `fa_cms_rec_info` VALUES (34, NULL, 180, 18, '头部banner', 0, 'cms/ender/upload/recpic/2013081210141456593.gif', '2013-08-12 10:14:17', '');
INSERT INTO `fa_cms_rec_info` VALUES (35, NULL, 140, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081214394751418.jpg', '2013-08-12 14:40:30', '');
INSERT INTO `fa_cms_rec_info` VALUES (36, NULL, 139, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081214395751671.jpg', '2013-08-12 14:40:30', '');
INSERT INTO `fa_cms_rec_info` VALUES (37, NULL, 138, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081214400913083.jpg', '2013-08-12 14:40:30', '');
INSERT INTO `fa_cms_rec_info` VALUES (38, NULL, 137, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081214402224866.jpg', '2013-08-12 14:40:30', '');
INSERT INTO `fa_cms_rec_info` VALUES (39, NULL, 151, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081214535424674.jpg', '2013-08-12 14:54:24', '');
INSERT INTO `fa_cms_rec_info` VALUES (40, NULL, 150, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081214540157967.jpg', '2013-08-12 14:54:24', '');
INSERT INTO `fa_cms_rec_info` VALUES (41, NULL, 149, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081214540834618.jpg', '2013-08-12 14:54:24', '');
INSERT INTO `fa_cms_rec_info` VALUES (42, NULL, 148, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081214541828436.jpg', '2013-08-12 14:54:25', '');
INSERT INTO `fa_cms_rec_info` VALUES (43, NULL, 152, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081214592318087.jpg', '2013-08-12 14:59:26', '');
INSERT INTO `fa_cms_rec_info` VALUES (44, NULL, 158, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081215003768214.jpg', '2013-08-12 15:00:41', '');
INSERT INTO `fa_cms_rec_info` VALUES (45, NULL, 149, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081215031669446.jpg', '2013-08-12 15:03:33', '');
INSERT INTO `fa_cms_rec_info` VALUES (46, NULL, 148, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081215032874541.jpg', '2013-08-12 15:03:33', '');
INSERT INTO `fa_cms_rec_info` VALUES (47, NULL, 155, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081215080113133.png', '2013-08-12 15:08:07', '');
INSERT INTO `fa_cms_rec_info` VALUES (48, NULL, 154, 17, '首页 -首页-热门推荐', 1, NULL, '2013-08-12 15:08:07', '');
INSERT INTO `fa_cms_rec_info` VALUES (49, NULL, 153, 17, '首页 -首页-热门推荐', 1, NULL, '2013-08-12 15:08:07', '');
INSERT INTO `fa_cms_rec_info` VALUES (50, NULL, 152, 17, '首页 -首页-热门推荐', 1, NULL, '2013-08-12 15:08:07', '');
INSERT INTO `fa_cms_rec_info` VALUES (51, NULL, 151, 17, '首页 -首页-热门推荐', 1, NULL, '2013-08-12 15:08:07', '');
INSERT INTO `fa_cms_rec_info` VALUES (52, NULL, 150, 17, '首页 -首页-热门推荐', 1, NULL, '2013-08-12 15:08:07', '');
INSERT INTO `fa_cms_rec_info` VALUES (53, NULL, 149, 17, '首页 -首页-热门推荐', 1, NULL, '2013-08-12 15:08:07', '');
INSERT INTO `fa_cms_rec_info` VALUES (54, NULL, 178, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081215203637068.gif', '2013-08-12 15:20:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (55, NULL, 180, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081215202741497.gif', '2013-08-12 15:20:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (56, NULL, 156, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081215233139386.png', '2013-08-12 15:23:36', '');
INSERT INTO `fa_cms_rec_info` VALUES (57, NULL, 157, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081215232527614.png', '2013-08-12 15:23:36', '');
INSERT INTO `fa_cms_rec_info` VALUES (58, NULL, 158, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081215231452866.jpg', '2013-08-12 15:23:36', '');
INSERT INTO `fa_cms_rec_info` VALUES (59, NULL, 159, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081215230270910.jpg', '2013-08-12 15:23:36', '');
INSERT INTO `fa_cms_rec_info` VALUES (60, NULL, 157, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081215423884353.jpg', '2013-08-12 15:42:44', '');
INSERT INTO `fa_cms_rec_info` VALUES (61, NULL, 158, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081215421742746.jpg', '2013-08-12 15:42:44', '');
INSERT INTO `fa_cms_rec_info` VALUES (62, NULL, 159, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081215384045062.png', '2013-08-12 15:42:44', '');
INSERT INTO `fa_cms_rec_info` VALUES (63, NULL, 178, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081215383596558.png', '2013-08-12 15:42:44', '');
INSERT INTO `fa_cms_rec_info` VALUES (64, NULL, 180, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081215383054676.png', '2013-08-12 15:42:44', '');
INSERT INTO `fa_cms_rec_info` VALUES (65, NULL, 155, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081216285382932.jpg', '2013-08-12 16:28:59', '');
INSERT INTO `fa_cms_rec_info` VALUES (66, NULL, 156, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081216284843819.jpg', '2013-08-12 16:28:59', '');
INSERT INTO `fa_cms_rec_info` VALUES (67, NULL, 157, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081216284244030.jpg', '2013-08-12 16:28:59', '');
INSERT INTO `fa_cms_rec_info` VALUES (68, NULL, 158, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081216283724251.jpg', '2013-08-12 16:28:59', '');
INSERT INTO `fa_cms_rec_info` VALUES (69, NULL, 159, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081216283116674.jpg', '2013-08-12 16:28:59', '');
INSERT INTO `fa_cms_rec_info` VALUES (70, NULL, 178, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081216282666251.jpg', '2013-08-12 16:29:00', '');
INSERT INTO `fa_cms_rec_info` VALUES (71, NULL, 180, 20, '新品上市', 0, 'cms/ender/upload/recpic/2013081216282164378.jpg', '2013-08-12 16:29:00', '');
INSERT INTO `fa_cms_rec_info` VALUES (72, NULL, 133, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081216303887235.jpg', '2013-08-12 16:30:45', '');
INSERT INTO `fa_cms_rec_info` VALUES (73, NULL, 148, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081216303491165.jpg', '2013-08-12 16:30:45', '');
INSERT INTO `fa_cms_rec_info` VALUES (74, NULL, 149, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081216302941225.jpg', '2013-08-12 16:30:45', '');
INSERT INTO `fa_cms_rec_info` VALUES (75, NULL, 150, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081216302450522.jpg', '2013-08-12 16:30:45', '');
INSERT INTO `fa_cms_rec_info` VALUES (76, NULL, 151, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081216301959736.jpg', '2013-08-12 16:30:45', '');
INSERT INTO `fa_cms_rec_info` VALUES (77, NULL, 159, 17, '首页 -首页-热门推荐', 0, NULL, '2013-08-12 17:10:48', '');
INSERT INTO `fa_cms_rec_info` VALUES (78, NULL, 159, 17, '首页 -首页-热门推荐', 0, NULL, '2013-08-12 17:12:24', '');
INSERT INTO `fa_cms_rec_info` VALUES (79, NULL, 180, 17, '首页 -首页-热门推荐', 0, NULL, '2013-08-12 17:12:38', '');
INSERT INTO `fa_cms_rec_info` VALUES (80, 6, 180, 17, '首页 -首页-热门推荐', 0, NULL, '2013-08-12 17:17:06', '');
INSERT INTO `fa_cms_rec_info` VALUES (81, 5, 180, 17, '首页 -首页-热门推荐', 0, NULL, '2013-08-12 17:18:33', '');
INSERT INTO `fa_cms_rec_info` VALUES (82, 4, 180, 17, '首页 -首页-热门推荐', 0, NULL, '2013-08-12 17:19:14', '');
INSERT INTO `fa_cms_rec_info` VALUES (83, 1, 180, 17, '首页 -首页-热门推荐', 1, NULL, '2013-08-12 17:36:46', '');
INSERT INTO `fa_cms_rec_info` VALUES (84, 1, 159, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081217543170401.jpg', '2013-08-12 17:54:43', '');
INSERT INTO `fa_cms_rec_info` VALUES (85, 2, 178, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081217542257767.jpg', '2013-08-12 17:54:43', '');
INSERT INTO `fa_cms_rec_info` VALUES (86, 3, 180, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081217540971672.jpg', '2013-08-12 17:54:43', '');
INSERT INTO `fa_cms_rec_info` VALUES (87, 1, 180, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081219274842588.jpg', '2013-08-12 19:27:51', '');
INSERT INTO `fa_cms_rec_info` VALUES (88, 4, 178, 19, '推荐产品', 0, 'cms/ender/upload/recpic/2013081219283490175.jpg', '2013-08-12 19:28:37', '');
INSERT INTO `fa_cms_rec_info` VALUES (89, 1, 180, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081219293425301.jpg', '2013-08-12 19:29:37', '');
INSERT INTO `fa_cms_rec_info` VALUES (90, 3, 156, 17, '首页 -首页-热门推荐', 0, 'cms/ender/upload/recpic/2013081310540936870.jpg', '2013-08-13 10:54:12', '');
INSERT INTO `fa_cms_rec_info` VALUES (91, 4, 157, 20, '首页 -新品上市', 0, 'cms/ender/upload/recpic/2013081310572682724.jpg', '2013-08-13 10:57:29', '');

-- ----------------------------
-- Table structure for fa_cms_rec_part
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_rec_part`;
CREATE TABLE `fa_cms_rec_part`  (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `part_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '位置名字',
  `part_num` int(11) NULL DEFAULT NULL COMMENT '位置显示的数量',
  `part_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '位置描述',
  `temp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '位置类别(此处还没用到)\r\nA:类别位置\r\n programs\r\n tv\r\n movie\r\nB:今日关注\r\n programs\r\ntv\r\nmovie\r\ngame\r\nmusic\r\nlive\r\n',
  `typeid` int(11) NULL DEFAULT NULL COMMENT '类别id对应',
  `mid` tinyint(4) NULL DEFAULT NULL COMMENT '模块id(0 首页 1 栏目页 2内容页 3 最新页面 先定死的',
  `eng_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_rec_part
-- ----------------------------
INSERT INTO `fa_cms_rec_part` VALUES (17, '首页-热门推荐', 4, '首页-首页-热门推荐', '首页第一栏,大家好', 1, 1, 'syrmtj');
INSERT INTO `fa_cms_rec_part` VALUES (18, '头部banner', 4, '首页-头部banner', '头部baner变量', 1, 1, 'topbanner');
INSERT INTO `fa_cms_rec_part` VALUES (19, '推荐产品', 5, '首页-推荐产品', '推荐推荐推荐地工革', 1, 1, 'sytjcp');
INSERT INTO `fa_cms_rec_part` VALUES (20, '新品上市', 7, '首页-新品上市', '新品上市大家快来塔顶抢呀塔顶奔载载载地区圭亚那式样 fasfdasfdafdafdasdfsfadfdasfadfsaf工', 1, 1, 'syxpss');

-- ----------------------------
-- Table structure for fa_cms_tagclass
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_tagclass`;
CREATE TABLE `fa_cms_tagclass`  (
  `classid` smallint(6) NOT NULL AUTO_INCREMENT,
  `classname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`classid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_cms_tagclass
-- ----------------------------
INSERT INTO `fa_cms_tagclass` VALUES (1, '信息调用');
INSERT INTO `fa_cms_tagclass` VALUES (2, '栏目调用');
INSERT INTO `fa_cms_tagclass` VALUES (3, '非信息调用');
INSERT INTO `fa_cms_tagclass` VALUES (4, '其它标签');

-- ----------------------------
-- Table structure for fa_cms_tags
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_tags`;
CREATE TABLE `fa_cms_tags`  (
  `bqid` smallint(6) NOT NULL AUTO_INCREMENT,
  `bqname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `bqsay` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `funname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `bq` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `issys` tinyint(1) NOT NULL DEFAULT 0,
  `bqgs` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `isclose` tinyint(1) NOT NULL DEFAULT 0,
  `classid` smallint(6) NOT NULL DEFAULT 0,
  `myorder` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`bqid`) USING BTREE,
  INDEX `classid`(`classid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fa_cms_tags
-- ----------------------------
INSERT INTO `fa_cms_tags` VALUES (1, '文字调用标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">栏目ID/专题ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a>，查看专题ID点<a onclick=\\\"window.open(\\\'../ListZt.php\\\');\\\"><strong><u>这里</u></strong></a>,当前ID=\\\'selfinfo\\\'<br />\r\n            多个栏目ID与专题ID可用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示前几条记录</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示时间</div>\r\n            </td>\r\n            <td height=\\\"25\\\">是否在标题后显示时间，0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">操作类型</div>\r\n            </td>\r\n            <td height=\\\"25\\\">具体看操作类型说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示栏目名</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">时间格式化</div>\r\n            </td>\r\n            <td height=\\\"25\\\">形式：Y-m-d H:i:s．默认为：\\\'(m-d)\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">附加SQL条件</div>\r\n            </td>\r\n            <td height=\\\"25\\\">附加调用条件，如：&quot;title=\\\'帝国\\\'&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示排序</div>\r\n            </td>\r\n            <td height=\\\"25\\\">可指定按相应的字段排序，如：&quot;id desc&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td colspan=\\\"2\\\">\r\n            <div align=\\\"center\\\">（注：在栏目ID中写大栏目，系统会自己搜索子栏目的信息）</div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetClassNews', 'phomenews', 1, '[phomenews]栏目ID/专题ID,显示条数,标题截取数,是否显示时间,操作类型,是否显示栏目名,\\\'时间格式化\\\',附加SQL条件,显示排序[/phomenews]', 0, 1, 9);
INSERT INTO `fa_cms_tags` VALUES (22, '留言板调用', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\\\"40%\\\">\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td width=\\\"60%\\\">参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示信息数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示记录数</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标签模板ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"left\\\">查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a></div>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">&nbsp;</div>\r\n            </td>\r\n            <td height=\\\"25\\\">模板标签变量说明：<br />\r\n            留言ID：[!--lyid--]，留言内容：[!--lytext--]<br />\r\n            回复内容：[!--retext--]，留言时间：[!--lytime--]<br />\r\n            留言者：[!--name--]，留言者邮箱：[!--email--]<br />\r\n            序号：[!--no--]</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">留言分类ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"left\\\">点击<strong><a onclick=\\\"window.open(\\\'../tool/GbookClass.php\\\');\\\">这里</a></strong>查看分类ID，0为不限制</div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_ShowLyInfo', 'gbookinfo', 1, '[gbookinfo]显示信息数,标签模板ID,留言分类ID[/gbookinfo]', 0, 3, 5);
INSERT INTO `fa_cms_tags` VALUES (23, '专题调用标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">\r\n            <div align=\\\"center\\\">标签模板ID</div>\r\n            </div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">&nbsp;</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <p>模板标签变量说明：(list.var)<br />\r\n            [!--classurl--]：专题链接，[!--classname--]：专题名称<br />\r\n            [!--classid--]：专题id，[!--classimg--]：专题图片<br />\r\n            [!--intro--]：专题简介,[!--no--]：序号</p>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">专题类别ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"left\\\">点击<strong><a onclick=\\\"window.open(\\\'../ListZtClass.php\\\');\\\">这里</a></strong>查看分类ID，0为不限制，多个分类ID用逗号隔开，如\\\'1,2\\\'</div>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示专题数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不限制</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">所属栏目ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">点击<strong><a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\">这里</a></strong>查看栏目ID，0为不限制，多个栏目ID用逗号隔开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_ShowZtData', 'eshowzt', 1, '[eshowzt]标签模板ID,专题类别ID,显示专题数,所属栏目ID[/eshowzt]', 0, 2, 6);
INSERT INTO `fa_cms_tags` VALUES (2, '图文信息调用(标题图片的信息)', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">栏目ID/专题ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a>，查看专题ID点<a onclick=\\\"window.open(\\\'../ListZt.php\\\');\\\"><strong><u>这里</u></strong></a>,当前ID=\\\'selfinfo\\\'<br />\r\n            多个栏目ID与专题ID可用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">每行显示条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">每行显示几个图片</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示总信息数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示信息总数</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">图片宽度，图片高度</div>\r\n            </td>\r\n            <td height=\\\"25\\\">图文信息图片大小</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示标题</div>\r\n            </td>\r\n            <td height=\\\"25\\\">是否在图片下显示标题，0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">操作类型说明</div>\r\n            </td>\r\n            <td height=\\\"25\\\">具体看操作类型说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">附加SQL条件</div>\r\n            </td>\r\n            <td height=\\\"25\\\">附加调用条件，如：&quot;title=\\\'帝国\\\'&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示排序</div>\r\n            </td>\r\n            <td height=\\\"25\\\">可指定按相应的字段排序，如：&quot;id desc&quot;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetClassNewsPic', 'phomenewspic', 1, '[phomenewspic]栏目ID/专题ID,每行显示条数,显示总信息数,图片宽度,图片高度,是否显示标题,标题截取数,操作类型,附加SQL条件,显示排序[/phomenewspic]', 0, 1, 9);
INSERT INTO `fa_cms_tags` VALUES (3, '图片信息标签(调用单个)', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">图片信息ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看图片信息ID点<a onclick=\\\"window.open(\\\'../NewsSys/ListPicNews.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示标题</div>\r\n            </td>\r\n            <td height=\\\"25\\\">是否在图片下显示标题，0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示简介</div>\r\n            </td>\r\n            <td height=\\\"25\\\">是否在图片下显示简介，0为不显示，1为显示</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetPicNews', 'phomepic', 1, '[phomepic]图片信息ID,是否显示标题,是否显示简介[/phomepic]', 1, 4, 4);
INSERT INTO `fa_cms_tags` VALUES (4, '图片信息标签(调用多个)', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">图片信息类别ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看图片信息类别ID点<a onclick=\\\"window.open(\\\'../NewsSys/PicClass.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">每行显示条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">每行显示几个图片</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">调用总条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示新闻总数</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">图片宽度，图片高度</div>\r\n            </td>\r\n            <td height=\\\"25\\\">图片信息图片大小</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示标题</div>\r\n            </td>\r\n            <td height=\\\"25\\\">是否在图片下显示标题，0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示原链接</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为显示,1为不显示</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetMorePicNews', 'phomemorepic', 1, '[phomemorepic]图片信息类别ID,每行显示条数,调用总条数,图片宽度,图片高度,是否显示标题,标题截取数,是否显示原链接[/phomemorepic]', 1, 4, 4);
INSERT INTO `fa_cms_tags` VALUES (5, '广告标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">广告ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看广告ID点<a onclick=\\\"window.open(\\\'../tool/ListAd.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetAd', 'phomead', 1, '[phomead]广告ID[/phomead]', 0, 3, 5);
INSERT INTO `fa_cms_tags` VALUES (6, '投票标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">投票ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看投票ID点<a onclick=\\\"window.open(\\\'../tool/ListVote.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetVote', 'phomevote', 1, '[phomevote]投票ID[/phomevote]', 0, 3, 5);
INSERT INTO `fa_cms_tags` VALUES (7, '简介型调用信息标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">栏目ID/专题ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a>，查看专题ID点<a onclick=\\\"window.open(\\\'../ListZt.php\\\');\\\"><strong><u>这里</u></strong></a>,当前ID=\\\'selfinfo\\\'<br />\r\n            多个栏目ID与专题ID可用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示信息记录数</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">表格颜色</div>\r\n            </td>\r\n            <td height=\\\"25\\\">请加上\\\'\\\'(单引号)</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">操作类型</div>\r\n            </td>\r\n            <td height=\\\"25\\\">具体看操作类型说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示栏目名</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">附加SQL条件</div>\r\n            </td>\r\n            <td height=\\\"25\\\">附加调用条件，如：&quot;title=\\\'帝国\\\'&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示排序</div>\r\n            </td>\r\n            <td height=\\\"25\\\">可指定按相应的字段排序，如：&quot;id desc&quot;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetClassNewsText', 'phomenewstext', 1, '[phomenewstext]栏目ID/专题ID,显示条数,\\\'表格颜色\\\',操作类型,是否显示栏目名,附加SQL条件,显示排序[/phomenewstext]', 1, 1, 7);
INSERT INTO `fa_cms_tags` VALUES (11, '带模板的信息调用标签[万能标签]', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">栏目ID/专题ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a>，查看专题ID点<a onclick=\\\"window.open(\\\'../ListZt.php\\\');\\\"><strong><u>这里</u></strong></a>,当前ID=\\\'selfinfo\\\'<br />\r\n            多个栏目ID与专题ID可用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示前几条记录</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示栏目名</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">操作类型</div>\r\n            </td>\r\n            <td height=\\\"25\\\">具体看操作类型说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标签模板ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">只显示有标题图片</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不限制，1为只显示有标题图片的信息</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">附加SQL条件</div>\r\n            </td>\r\n            <td height=\\\"25\\\">附加调用条件，如：&quot;title=\\\'帝国\\\'&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示排序</div>\r\n            </td>\r\n            <td height=\\\"25\\\">可指定按相应的字段排序，如：&quot;id desc&quot;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetEcmsInfo', 'ecmsinfo', 1, '[ecmsinfo]栏目ID/专题ID,显示条数,标题截取数,是否显示栏目名,操作类型,模板ID,只显示有标题图片,附加SQL条件,显示排序[/ecmsinfo]', 0, 1, 10);
INSERT INTO `fa_cms_tags` VALUES (10, '滚动图片信息标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">栏目ID/专题ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a>，查看专题ID点<a onclick=\\\"window.open(\\\'../ListZt.php\\\');\\\"><strong><u>这里</u></strong></a>,当前ID=\\\'selfinfo\\\'<br />\r\n            多个栏目ID与专题ID可用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示总数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示信息总数</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">图片宽度，图片高度</div>\r\n            </td>\r\n            <td height=\\\"25\\\">图文信息图片大小</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示标题</div>\r\n            </td>\r\n            <td height=\\\"25\\\">是否在图片下显示标题，0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示速度</div>\r\n            </td>\r\n            <td height=\\\"25\\\">默认值为5000毫秒(5秒)</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">操作类型说明</div>\r\n            </td>\r\n            <td height=\\\"25\\\">具体看操作类型说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">附加SQL条件</div>\r\n            </td>\r\n            <td height=\\\"25\\\">附加调用条件，如：&quot;title=\\\'帝国\\\'&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示排序</div>\r\n            </td>\r\n            <td height=\\\"25\\\">可指定按相应的字段排序，如：&quot;id desc&quot;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetAutoPic', 'phomeautopic', 1, '[phomeautopic]栏目ID/专题ID,显示总数,图片宽度,图片高度,是否显示标题,标题截取数,显示速度,操作类型,附加SQL条件,显示排序[/phomeautopic]', 1, 1, 8);
INSERT INTO `fa_cms_tags` VALUES (12, '友情链接标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td width=\\\"40%\\\">\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td width=\\\"60%\\\">参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">每行显示记录数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">每行显示记录数</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示总记录数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"left\\\">总记录数</div>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">操作类型</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"left\\\">0为所有记录，1为图片链接，2为文字链接</div>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">分类ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"left\\\">点击<strong><a onclick=\\\"window.open(\\\'../tool/LinkClass.php\\\');\\\">这里</a></strong>查看分类ID，0为不限制</div>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示原链接</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"left\\\">0为统计点击链接，1为显示原链接</div>\r\n            </td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_GetSitelink', 'phomelink', 1, '[phomelink]每行显示数,显示总数,操作类型,分类id,是否显示原链接[/phomelink]', 0, 3, 5);
INSERT INTO `fa_cms_tags` VALUES (13, '显示栏目导航标签', '<p>[phomeshowclass]是否显示栏目记录数[/phomeshowclass]</p>', 'sys_ShowClass', 'phomeshowclass', 1, '[phomeshowclass]是否显示栏目记录数[/phomeshowclass]', 1, 2, 6);
INSERT INTO `fa_cms_tags` VALUES (14, '显示网站地图标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">栏目ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">子栏目每行显示记录数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">子栏目每行显示多少个栏目</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">大栏目颜色</div>\r\n            </td>\r\n            <td height=\\\"25\\\">大栏目单元格颜色,记得加上单引号</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">子栏目颜色</div>\r\n            </td>\r\n            <td height=\\\"25\\\">子栏目表格颜色,记得加上单引号</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示栏目记录数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不显示，1为显示.如显示效率比较低</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_ShowMap', 'phomeshowmap', 1, '[phomeshowmap]栏目ID,子栏目每行显示记录数,\\\'大栏目颜色\\\',\\\'子栏目颜色\\\',是否显示栏目记录数[/phomeshowmap]', 1, 2, 6);
INSERT INTO `fa_cms_tags` VALUES (15, '引用文件标签', '<p>[includefile]\\\'文件地址\\\'[/includefile]<br />\r\n文件地址需要为相对地址,并且从后台目录算起：&quot;../../header.html&quot;（这个地址的header.html是放在ecms根目录）</p>', 'sys_IncludeFile', 'includefile', 1, '[includefile]\\\'文件地址\\\'[/includefile]', 1, 4, 4);
INSERT INTO `fa_cms_tags` VALUES (16, '读取远程页面', '<p>[readhttp]\\\'页面地址\\\'[/readhttp]</p>', 'sys_ReadFile', 'readhttp', 1, '[readhttp]\\\'页面地址\\\'[/readhttp]', 1, 4, 4);
INSERT INTO `fa_cms_tags` VALUES (17, '网站信息统计', '<p>操作类型说明：\r\n<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr bgcolor=\\\"#dbeaf5\\\">\r\n            <td width=\\\"25%\\\">\r\n            <div align=\\\"center\\\">操作类型</div>\r\n            </td>\r\n            <td width=\\\"75%\\\">内容</td>\r\n        </tr>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">0</div>\r\n            </td>\r\n            <td>统计栏目数据</td>\r\n        </tr>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">1</div>\r\n            </td>\r\n            <td>统计专题</td>\r\n        </tr>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">2</div>\r\n            </td>\r\n            <td>统计数据表</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<br />\r\n时间范围：0为不限；1为今日；2为本月；3为本年<br />\r\n如果操作类型是&ldquo;统计数据表&rdquo;，栏目ID=\\\'数据表名\\\'</p>', 'sys_TotalData', 'totaldata', 1, '[totaldata]栏目ID,操作类型,时间范围[/totaldata]', 0, 1, 7);
INSERT INTO `fa_cms_tags` VALUES (18, 'FLASH幻灯信息调用', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">\r\n            <div align=\\\"center\\\">栏目ID/专题ID</div>\r\n            </div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a>，查看专题ID点<a onclick=\\\"window.open(\\\'../ListZt.php\\\');\\\"><strong><u>这里</u></strong></a>,当前ID=\\\'selfinfo\\\'<br />\r\n            多个栏目ID与专题ID可用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示总数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示信息总数</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">图片宽度，图片高度</div>\r\n            </td>\r\n            <td height=\\\"25\\\">图文信息图片大小</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示标题</div>\r\n            </td>\r\n            <td height=\\\"25\\\">是否在图片下显示标题，0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td bgcolor=\\\"#ffffff\\\" height=\\\"25\\\">\r\n            <div align=\\\"center\\\">操作类型说明</div>\r\n            </td>\r\n            <td height=\\\"25\\\">具体看操作类型说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">附加SQL条件</div>\r\n            </td>\r\n            <td height=\\\"25\\\">附加调用条件，如：&quot;title=\\\'帝国\\\'&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示排序</div>\r\n            </td>\r\n            <td height=\\\"25\\\">可指定按相应的字段排序，如：&quot;id desc&quot;</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_FlashPixpic', 'phomeflashpic', 1, '[phomeflashpic]栏目ID/专题ID,显示总数,图片宽度,图片高度,是否显示标题,标题截取数,操作类型,停顿秒数,附加SQL条件,显示排序[/phomeflashpic]', 0, 1, 9);
INSERT INTO `fa_cms_tags` VALUES (19, '搜索关键字调用标签', '<p>栏目id为0，则显示所有栏目的关键字</p>\r\n<p>操作类型：0为搜索热门排行，1为最新搜索排行</p>', 'sys_ShowSearchKey', 'showsearch', 1, '[showsearch]每行显示条数,总条数,栏目id,操作类型[/showsearch]', 0, 1, 7);
INSERT INTO `fa_cms_tags` VALUES (20, '循环子栏目数据标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">栏目ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a>，单个为父栏目ID，多栏目可用&quot;,&quot;格开<br />\r\n            当前栏目ID用：\\\'selfinfo\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示前几条记录</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示栏目名</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">操作类型</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0：栏目最新<br />\r\n            1：栏目热门<br />\r\n            2：栏目推荐<br />\r\n            3：栏目评论排行<br />\r\n            4：栏目头条<br />\r\n            5：栏目下载排行</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标签模板ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">只显示有标题图片</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不限制，1为只显示有标题图片的信息</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示栏目数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不限制</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示头条操作类型</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0：不显示栏目头条<br />\r\n            1：栏目内容简介<br />\r\n            2：栏目推荐信息<br />\r\n            3：栏目头条信息<br />\r\n            4：栏目最新信息</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">头条标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">头条简介截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">头条只显示有标题图片</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不限制，1为只显示有标题图片的信息</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">附加SQL条件</div>\r\n            </td>\r\n            <td height=\\\"25\\\">附加调用条件，如：&quot;title=\\\'帝国\\\'&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示排序</div>\r\n            </td>\r\n            <td height=\\\"25\\\">可指定按相应的字段排序，如：&quot;id desc&quot;</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">头条的模板变量<br />\r\n            (标签模板的页面模板内容中使用)</div>\r\n            </td>\r\n            <td height=\\\"25\\\">[!--sonclass.id--]：信息ID<br />\r\n            [!--sonclass.title--]：信息标题<br />\r\n            [!--sonclass.oldtitle--]：信息标题(不截取字数)<br />\r\n            [!--sonclass.titlepic--]：标题图片<br />\r\n            [!--sonclass.titleurl--]：信息链接<br />\r\n            [!--sonclass.text--]：信息简介</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_ForSonclassData', 'listsonclass', 1, '[listsonclass]栏目ID,显示条数,标题截取数,是否显示栏目名,操作类型,模板ID,只显示有标题图片,显示栏目数,显示头条操作类型,头条标题截取数,头条简介截取数,头条只显示有标题图片,附加SQL条件,显示排序[/listsonclass]', 0, 1, 9);
INSERT INTO `fa_cms_tags` VALUES (21, '带模板的栏目导航标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">父栏目ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a><br />\r\n            \\\'0\\\'为显示所有一级栏目<br />\r\n            \\\'selfinfo\\\'显示本栏目下级栏目</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">\r\n            <div align=\\\"center\\\">标签模板ID</div>\r\n            </div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">&nbsp;</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <p>模板标签变量说明：[!--bclassname--]：父栏目名,[!--bclassurl--]：父栏目链接,[!--bclassid--]：父栏目id</p>\r\n            <p>list.var模板标签：<br />\r\n            [!--classurl--]：栏目链接,[!--classname--]：栏目名称,[!--classid--]：栏目id,[!--classimg--]：栏目图片,[!--intro--]：栏目简介,[!--num--]：信息数,[!--no--]：序号</p>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示栏目信息数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示栏目数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不限制</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_ShowClassByTemp', 'showclasstemp', 1, '[showclasstemp]父栏目ID,标签模板ID,是否显示栏目信息数,显示栏目数[/showclasstemp]', 0, 2, 6);
INSERT INTO `fa_cms_tags` VALUES (24, '图库模型分页标签', '<p>\r\n<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">\r\n            <div align=\\\"center\\\">标签模板ID</div>\r\n            </div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">&nbsp;</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <p><strong>模板标签变量说明：</strong><br />\r\n            图片集JS数组：[!--photor--]，缩略图导航：[!--smalldh--]<br />\r\n            分页导航：[!--select--]，标题分页导航：[!--titleselect--]，分页列表式导航：[!--listpage--]</p>\r\n            <p><strong>list.var模板标签：</strong><br />\r\n            图片名称：[!--picname--]，图片地址：[!--picurl--]</p>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">导航图片宽度<br />\r\n            导航图片高度</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为按原图大小</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', 'sys_PhotoMorepage', 'eshowphoto', 1, '[eshowphoto]标签模板ID,导航图片宽度,导航图片高度[/eshowphoto]', 0, 1, 7);
INSERT INTO `fa_cms_tags` VALUES (25, '复选项输出函数', '<p>如：[echocheckbox]\\\'title\\\',\\\'&lt;br&gt;\\\'[/echocheckbox]：表示按回车分隔输出title字段的项</p>', 'sys_EchoCheckboxFValue', 'echocheckbox', 1, '[echocheckbox]\\\'字段\\\',\\\'分隔符\\\'[/echocheckbox]', 0, 3, 5);
INSERT INTO `fa_cms_tags` VALUES (26, '相关链接标签', '<p><strong>标签模板ID</strong>：查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a><br />\r\n<strong>操作类型</strong>：0为默认；1为按表；2为按栏目；3为按专题<br />\r\n<strong>操作对象</strong>：对应操作类型的表/栏目/专题。空则为默认。<br />\r\n<strong>是否显示栏目名</strong>：0为不显示；1为显示<br />\r\n<strong>只显示标题图片的信息</strong>：0为不限；1为只显示标题图片的信息</p>', 'sys_GetOtherLinkInfo', 'otherlink', 1, '[otherlink]标签模板ID,操作对象,调用条数,标题截取字数,是否显示栏目名,操作类型,只显示标题图片的信息[/otherlink]', 0, 1, 9);
INSERT INTO `fa_cms_tags` VALUES (27, '评论调用标签', '<p><strong>标签模板ID</strong>：查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a><br />\r\n<strong>栏目ID</strong>：0为不限调用栏目，父栏目会应用于子栏目<br />\r\n<strong>信息ID</strong>：0为不限<br />\r\n<strong>显示推荐评论</strong>：0为不限；1为只显示推荐评论<br />\r\n<strong>操作类型</strong>：0为按发布时间；1为按支持数；2为按反对数<br />\r\n<strong>标签模板说明</strong>：[!--title--]:信息标题；[!--titleurl--]:信息链接；[!--id--]:信息ID<br />\r\n[!--classid--]:栏目ID；[!--plid--]:评论ID；[!--username--]:发表者；[!--no--]:编号<br />\r\n[!--pltext--]:评论内容；[!--pltime--]:评论时间；[!--zcnum--]:支持数；[!--fdnum--]:反对数</p>', 'sys_ShowPlInfo', 'showplinfo', 1, '[showplinfo]调用条数,标签模板ID,栏目ID,信息ID,显示推荐评论,操作类型[/showplinfo]', 0, 3, 5);
INSERT INTO `fa_cms_tags` VALUES (28, '循环栏目导航标签', '<p>\r\n<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">父栏目ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看栏目ID点<a onclick=\\\"window.open(\\\'../ListClass.php\\\');\\\"><strong><u>这里</u></strong></a><br />\r\n            \\\'0\\\'为显示所有一级栏目<br />\r\n            \\\'selfinfo\\\'显示本栏目下级栏目<br />\r\n            多栏目固定调用可用&quot;,&quot;格开</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">\r\n            <div align=\\\"center\\\">标签模板ID</div>\r\n            </div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">&nbsp;</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\r\n            <p>模板标签变量说明：[!--bclassname--]：父栏目名,[!--bclassurl--]：父栏目链接,[!--bclassid--]：父栏目id，[!--bclassimg--]：父栏目图片,[!--bintro--]：父栏目简介,[!--bnum--]：父栏目信息数,[!--bno--]：父栏目序号</p>\r\n            <p>list.var模板标签：<br />\r\n            [!--classurl--]：栏目链接,[!--classname--]：栏目名称,[!--classid--]：栏目id,[!--classimg--]：栏目图片,[!--intro--]：栏目简介,[!--num--]：信息数,[!--no--]：序号</p>\r\n            </td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示栏目信息数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不显示，1为显示</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示栏目数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">0为不限制</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n</p>', 'sys_ForShowSonClass', 'listshowclass', 1, '[listshowclass]父栏目ID,标签模板ID,是否显示栏目信息数,显示栏目数[/listshowclass]', 0, 2, 6);
INSERT INTO `fa_cms_tags` VALUES (29, '调用TAGS的信息标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">TAGS的ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看TAGS的ID点<a onclick=\\\"window.open(\\\'../tags/ListTags.php\\\');\\\"><strong><u>这里</u></strong></a><br />\r\n            多个ID可以用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示前几条记录</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标签模板ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看标签模板ID点<a onclick=\\\"window.open(\\\'ListBqtemp.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">栏目ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">限制只调用某一个或多个栏目的信息<br />\r\n            多个ID可以用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">系统模型ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">限制只调用某一个或多个系统模型的信息<br />\r\n            多个ID可以用,号格开，如\\\'1,2\\\'</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_eShowTagsInfo', 'tagsinfo', 0, '[tagsinfo]TAGS的ID,显示条数,标题截取数,标签模板ID,栏目ID,系统模型ID[/tagsinfo]', 0, 0, 9);
INSERT INTO `fa_cms_tags` VALUES (30, '调用碎片的信息标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">碎片变量名</div>\r\n            </td>\r\n            <td height=\\\"25\\\">查看碎片变量名点<a onclick=\\\"window.open(\\\'../sp/ListSp.php\\\');\\\"><strong><u>这里</u></strong></a></td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示条数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示前几条记录</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">标题截取数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">截取几个字符</td>\r\n        </tr>\r\n    </tbody>\r\n</table>\r\n<br>\r\n<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n  <tbody>\r\n    <tr> \r\n      <td colspan=\\\"2\\\"> <div align=\\\"center\\\">碎片标签模板变量说明</div></td>\r\n    </tr>\r\n    <tr bgcolor=\\\"#ffffff\\\"> \r\n      <td width=\\\"34%\\\" height=\\\"25\\\"> \r\n        <div align=\\\"center\\\">静态碎片</div></td>\r\n      <td width=\\\"66%\\\" height=\\\"25\\\">模板标签变量说明：[!--the.spname--]：碎片名称,[!--the.spid--]：碎片ID,[!--the.sppic--]：碎片效果图,[!--the.spsay--]：碎片描述 \r\n        <p>list.var模板标签：<br>\r\n          [!--title--]：标题,[!--oldtitle--]：标题ALT,[!--newstime--]：发布时间,[!--id--]：碎片信息ID,[!--titleurl--]：标题链接,[!--titlepic--]：标题缩图,[!--bigpic--]：标题大图,[!--titlepre--]：标题左边,[!--titlenext--]：标题右边,[!--smalltext--]：内容简介,[!--no.num--]：编号</p></td>\r\n    </tr>\r\n    <tr bgcolor=\\\"#ffffff\\\"> \r\n      <td height=\\\"25\\\"> <div align=\\\"center\\\">动态碎片</div></td>\r\n      <td height=\\\"25\\\">模板标签变量说明：[!--the.spname--]：碎片名称,[!--the.spid--]：碎片ID,[!--the.sppic--]：碎片效果图,[!--the.spsay--]：碎片描述 \r\n        <p>list.var模板标签：<br>\r\n          支持变量同模型信息调用</p></td>\r\n    </tr>\r\n    <tr bgcolor=\\\"#ffffff\\\"> \r\n      <td height=\\\"25\\\"> <div align=\\\"center\\\">代码碎片</div></td>\r\n      <td height=\\\"25\\\">无需标签模板，直接显示代码内容</td>\r\n    </tr>\r\n  </tbody>\r\n</table>\r\n', 'sys_eShowSpInfo', 'spinfo', 0, '[spinfo]碎片变量名,显示条数,标题截取数[/spinfo]', 0, 0, 9);
INSERT INTO `fa_cms_tags` VALUES (31, '调用TAGS标签', '<table cellspacing=\\\"1\\\" cellpadding=\\\"3\\\" width=\\\"100%\\\" bgcolor=\\\"#dbeaf5\\\" border=\\\"0\\\">\r\n    <tbody>\r\n        <tr>\r\n            <td>\r\n            <div align=\\\"center\\\">参数</div>\r\n            </td>\r\n            <td>参数说明</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">分类ID</div>\r\n            </td>\r\n            <td height=\\\"25\\\">\\\'\\\'空为不限制，查看TAGS分类ID点<a onclick=\\\"window.open(\\\'../tags/TagsClass.php\\\');\\\"><strong><u>这里</u></strong></a><br />\r\n            多个可以用,号格开，如\\\'1,2\\\'<br />\r\n            内容页显示当前TAGS可以用\\\'selfinfo\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示数量</div>\r\n            </td>\r\n            <td height=\\\"25\\\">显示前几条记录，0为显示所有（\\\'selfinfo\\\'本设置无效）</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">每行显示数量</div>\r\n            </td>\r\n            <td height=\\\"25\\\">一行显示多少个TAGS，0为不换行</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示排序</div>\r\n            </td>\r\n            <td height=\\\"25\\\">使用默认设置\\\'\\\'空就可以，默认是\\\'tagid desc\\\'（\\\'selfinfo\\\'本设置无效）</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">只显示推荐</div>\r\n            </td>\r\n            <td height=\\\"25\\\">只显示推荐的TAGS，0为不限制，1为限制（\\\'selfinfo\\\'本设置无效）</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">推荐TAGS属性</div>\r\n            </td>\r\n            <td height=\\\"25\\\">如果是推荐的TAGS，内容是否要加粗或加红（\\\'selfinfo\\\'本设置无效）<br />\r\n            设置\\\'s\\\'表示加粗、\\\'r\\\'表示加红、同时加粗加红用\\\'s,r\\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">显示间隔符</div>\r\n            </td>\r\n            <td height=\\\"25\\\">TAGS之间显示间隔符，默认是\\\' &amp;nbsp; \\\'</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">是否显示信息数量</div>\r\n            </td>\r\n            <td height=\\\"25\\\">是否在TAGS后显示信息数量，0为不显示，1为显示（\\\'selfinfo\\\'本设置无效）</td>\r\n        </tr>\r\n        <tr bgcolor=\\\"#ffffff\\\">\r\n            <td height=\\\"25\\\">\r\n            <div align=\\\"center\\\">链接附加参数</div>\r\n            </td>\r\n            <td height=\\\"25\\\">可指定在TAGS链接后面增加参数，比如：\\\'&amp;tempid=模板ID\\\'</td>\r\n        </tr>\r\n    </tbody>\r\n</table>', 'sys_eShowTags', 'showtags', 0, '[showtags]分类ID,显示数量,每行显示数量,显示排序,只显示推荐,推荐TAGS属性,显示间隔符,是否显示信息数,链接附加参数[/showtags]', 0, 0, 9);

-- ----------------------------
-- Table structure for fa_cms_template
-- ----------------------------
DROP TABLE IF EXISTS `fa_cms_template`;
CREATE TABLE `fa_cms_template`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板名称',
  `classid` int(11) NULL DEFAULT NULL COMMENT '类型ID  类别名称关联ctyp',
  `contents` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `editdate` datetime NULL DEFAULT NULL COMMENT '编辑日期',
  `temp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板类型',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '删除标识0正常，1删除',
  `fdir` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板文件输出目录',
  `fname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板文件输出名字',
  `do_action` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成静态页面操作方法',
  `mid` tinyint(4) NULL DEFAULT NULL COMMENT '模型id(0 首页 1 列表页 2 内容页 3活动页面)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_template_class`(`classid`) USING BTREE,
  CONSTRAINT `fk_template_class` FOREIGN KEY (`classid`) REFERENCES `fa_cms_classes` (`classid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of fa_cms_template
-- ----------------------------
INSERT INTO `fa_cms_template` VALUES (8, '首页', 1, '啊啊啊', '2013-08-13 14:47:03', '新风格', 0, '/cms/ender/', 'index.jsp', 'http://192.168.1.13:8080/FAJxc_V4/cms/web/indextohtml2webexcute.Action', 1);

-- ----------------------------
-- Table structure for field
-- ----------------------------
DROP TABLE IF EXISTS `field`;
CREATE TABLE `field`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp4` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp6` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp7` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp8` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp9` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp10` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp11` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp12` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp13` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp14` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp15` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp16` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp17` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp18` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp19` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp20` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of field
-- ----------------------------
INSERT INTO `field` VALUES (1, 'cpu', '内存', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (2, 'CPU', '内存', '硬盘', '硬盘1', '硬盘2', '硬盘3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (20, '名称', 'cpu类型', 'cpu大小', '内存型号', '内存大小', '硬盘型号', '硬盘大小', '显示器', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (23, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (25, '商品名称', '录入时间', '商品备注（说明）', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (26, '运营商', '机房位置', 'IP地址', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (27, '机房名称', '机房位置', '负责人', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (28, '招聘单位', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (29, '服务器标识', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (30, 'CPU', '内存', '硬盘', '硬盘1', '硬盘2', '硬盘3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (31, 'CPU', '内存', '硬盘', '硬盘1', '硬盘2', '硬盘3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (32, '带宽名称', '提供商', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (35, '名称', '地址', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (36, '名称', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (37, '名称', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field` VALUES (38, '名称', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for field_property
-- ----------------------------
DROP TABLE IF EXISTS `field_property`;
CREATE TABLE `field_property`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '段字表附表_字段属性表ID',
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'UUID',
  `fieldId` int(11) NULL DEFAULT NULL COMMENT '字段表ID(fields表ID)',
  `beanName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体类实名',
  `beanUuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实体类具体数据UUID',
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp6` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp7` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp8` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp9` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp10` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp11` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp12` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp13` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp14` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp15` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp16` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp17` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp18` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp19` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp20` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fieldId`(`fieldId`) USING BTREE,
  CONSTRAINT `field_property_ibfk_1` FOREIGN KEY (`fieldId`) REFERENCES `field_remark` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1002 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of field_property
-- ----------------------------
INSERT INTO `field_property` VALUES (1000, '4a83b307-5e28-4227-9280-f04132ee614f', 1, 'Employee', '306bd0f2-d199-4c04-8445-1535739deecf', '111', '111', '111', '1111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field_property` VALUES (1001, 'ff98a930-0f2f-4630-972e-b6bc8089dbaa', 3, 'Employee', 'aab055e4-891b-4de4-9566-a96eaf5c4527', '111', '111', '222', '222', '1111', '222', '沾不上', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for field_remark
-- ----------------------------
DROP TABLE IF EXISTS `field_remark`;
CREATE TABLE `field_remark`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '段字表ID自增长',
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'UUID',
  `beanNames` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体类名实（多个实体类用逗号隔开）',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '称名',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `inputTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录入时间',
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp6` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp7` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp8` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp9` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp10` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp11` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp12` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp13` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp14` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp15` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp16` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp17` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp18` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp19` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp20` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of field_remark
-- ----------------------------
INSERT INTO `field_remark` VALUES (1, '62cb5907-4759-410a-abb4-581db79a931a', 'Employee', '家庭成员', '家庭成员备注信息（可为空）', '2011-12-05 10:45:25', '姓名', '关系', '职位', '工作单位', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field_remark` VALUES (2, '21f6aa09-c423-48fa-8a8a-cda34d13e510', 'Employee', '教育经历', '教育经历备注信息（可为空）', '2011-12-05 10:50:18', '毕业院校', '开始时间', '结束时间', '专业', '证书', '证明人', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field_remark` VALUES (3, '800c8f3e-1575-43f7-93b3-0bcfce4014bf', 'Employee', '工作经验', '工作经验备注信息（可为空）', '2011-12-05 15:14:50', '公司', '开始时间', '结束时间', '职务', '收入', '离职原因', '证明人', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field_remark` VALUES (4, '4dwb5907-d539-410a-abb4-581db79a521a', '', '语言', '会说的语言熟练程度', '2011-12-05 17:33:10', '普通话', '英语', '粤语', '其他', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `field_remark` VALUES (5, '465f5rd7-d539-410a-abb4-dfa356352dfed', '', '掌握技能', '所掌握的技能熟练程度', '2011-12-05 17:34:20', 'Office', 'CorelDRAW', 'Flash', 'Photoshop', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for filed
-- ----------------------------
DROP TABLE IF EXISTS `filed`;
CREATE TABLE `filed`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp4` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp6` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp7` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp8` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp9` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp10` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp11` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp12` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp13` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp14` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp15` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp16` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp17` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp18` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp19` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp20` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of filed
-- ----------------------------

-- ----------------------------
-- Table structure for formdetail
-- ----------------------------
DROP TABLE IF EXISTS `formdetail`;
CREATE TABLE `formdetail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `formtempId` int(11) NOT NULL COMMENT '单据模板id',
  `employeeId` int(11) NOT NULL COMMENT '填表人',
  `orderNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单据编号',
  `audtitingFlag` int(11) NULL DEFAULT NULL COMMENT '审核标识',
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加表单时间',
  `delflag` int(11) NULL DEFAULT 0 COMMENT '删除标识0未删除，1已删除',
  `temp` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of formdetail
-- ----------------------------
INSERT INTO `formdetail` VALUES (38, 11, 67, 'JKD2012011600017', 1, '2012-01-16 11:06:37', 0, '游戏部#赵六#2012-1-18#现金#八百八十八#888#可以#主管#哦哦哦#');
INSERT INTO `formdetail` VALUES (42, 11, 67, 'JKD2012011600021', 1, '2012-01-16 12:04:39', 0, ' 技术部#你是谁#2012-1-18#我要现金#八百八十八#888#总经理#主管#呖呖  可以#');
INSERT INTO `formdetail` VALUES (44, 11, 67, 'JKD2012011600022', 0, '2012-01-16 17:13:09', 0, '技术部#杨威#2012-01-18#现金#八百八十八#888#总经理#你好，主管，请审核#通过讨论  审核通过#');
INSERT INTO `formdetail` VALUES (45, 11, 67, 'JKD2012011800001', 1, '2012-01-18 15:26:46', 0, '运维部#何况#2012-01-18#现金#999#999#总经理#主管#');
INSERT INTO `formdetail` VALUES (46, 11, 67, 'JKD2012011800002', 1, '2012-01-18 15:27:38', 0, '运维部#何况#2012-01-19#现金#999#999#总经理##大家');

-- ----------------------------
-- Table structure for formtemp
-- ----------------------------
DROP TABLE IF EXISTS `formtemp`;
CREATE TABLE `formtemp`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `mark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标识符',
  `typeName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单据表名',
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建模板时间',
  `empId` int(11) NULL DEFAULT NULL COMMENT '创建模板的员工的id',
  `code` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'html页面代码',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '删除标识0未删除，1已删除',
  `temp` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of formtemp
-- ----------------------------
INSERT INTO `formtemp` VALUES (11, 'JKD', '员工借款单', '2012-01-16 09:56:18', 13, '<p><style type=\"text/css\">\r\nbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n<!--txt{ width:10%; height:20px; border:1px #F6F6F6 solid; background:#FFFFFF;}-->\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #F6F6F6;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}</style></p>\r\n<p>&nbsp;</p>\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 650px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">员工借款单</div>\r\n<div class=\"line\" style=\"width: 650px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">部门：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp1\" name=\"temp1\" value=\"#temp1#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">姓名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp2\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" name=\"temp3\" onclick=\"WdatePicker()\"  value=\"#temp3#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 650px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">借款方式：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp4\" style=\"width: 250px\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 650px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 54px; height: 54px\">借款金额：</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 381px; height: 27px; clear: both\">人民币（大写）：<input id=\"temp5\" style=\"width: 250px\" name=\"temp5\" value=\"#temp5#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 381px; height: 27px; clear: both\">人民币（小写）：<input id=\"temp6\" style=\"width: 250px\" name=\"temp6\" value=\"#temp6#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 650px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">总经理审批：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp7\" name=\"temp7\" value=\"#temp7#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">财务主管：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp8\" name=\"temp8\" value=\"#temp8#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 650px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 45px; height: 45px\">备注：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 500px; height: 36px\"><textarea id=\"temp9\" style=\"width: 500px; height: 36px\" name=\"temp9\">#temp9#</textarea></div>\r\n</div>\r\n</div>\r\n</div>', 0, '部门#姓名#日期#借款方式#人民币（大写）#人民币（小写）#总经理审批#财务主管#备注');
INSERT INTO `formtemp` VALUES (12, 'YGQJD', '员工请假单', '2012-01-16 05:57:20', 13, '<p><style type=\"text/css\">\r\nbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n<!--txt{ width:10%; height:20px; border:1px #F6F6F6 solid; background:#FFFFFF;}-->\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #F6F6F6;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}\r\n.topline_cellB{float:left; width:200px; height:40px;line-height:40px;text-align:center;}</style></p>\r\n<div class=\"line\" style=\"border-bottom: #cccccc 2px solid; border-left: #cccccc 2px solid; width: 620px; border-top: #cccccc 2px solid; border-right: #cccccc 2px solid\">\r\n<div class=\"main_leirong_title\">员工请假单</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">职务：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp1\" name=\"temp1\" value=\"#temp1#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">姓名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp2\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">时间：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" onclick=\"WdatePicker()\" name=\"temp3\" value=\"#temp3#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">请假类型：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 400px\"><input id=\"temp4\" name=\"temp4\" value=\"#temp4#\" type=\"text\" />休假（或假）/病假/事假/其他（请说明)</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"ziduan_ming\">请假时间：</div>\r\n<div class=\"ziduan_ming_leirong\">自</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp5\" onclick=\"WdatePicker()\" name=\"temp5\" value=\"#temp5#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming_leirong\">到</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp6\" onclick=\"WdatePicker()\" name=\"temp6\" value=\"#temp6#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming_leirong\">总共请假</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp7\" style=\"width: 40px\" name=\"temp7\" value=\"#temp7#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming_leirong\">天</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; height: 50px\">请假事由：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 500px; height: 42px\"><textarea id=\"temp8\" style=\"width: 500px; height: 42px\" name=\"temp8\">#temp8#</textarea></div>\r\n</div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">总经理签字：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp9\"  name=\"temp9\" value=\"#temp9#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">主管签字：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp10\"  name=\"temp10\" value=\"#temp10#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"float: left; \">\r\n<div class=\"ziduan_ming\">行政签字：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp11\" name=\"temp11\" value=\"#temp11#\" type=\"text\" /></div>\r\n</div>\r\n</div>', 0, '职务#姓名#时间#请假类型#请假开始时间#请假结束时间#天数#请假事由#总经理签字#主管签字#行政签字');
INSERT INTO `formtemp` VALUES (13, 'BGGZSPB', '变更工资审批表', '2012-01-17 10:20:03', 13, '<p><style type=\"text/css\">\r\n.outbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #F6F6F6;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; \r\n\r\nclear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; \r\n\r\nheight:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; \r\n\r\nbackground:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}</style></p>\r\n<div class=\"outbody\">\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 684px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">变更工资审批表</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 100%; background: #ebebeb\"><label style=\"width: 100px; float: left\">&nbsp;&nbsp;&nbsp;&nbsp;填表日期:</label> <input id=\"temp1\" name=\"temp1\" value=\"#temp1#\" type=\"text\" onclick=\"WdatePicker()\" /></div>\r\n<div class=\" line\" style=\"width: 684px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">姓名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp2\" style=\"width: 100px\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">性别：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" style=\"width: 100px\" name=\"temp3\" value=\"#temp3#\" type=\"text\" /></div>\r\n<div class=\"cells\">&nbsp;</div>\r\n<div class=\"ziduan_ming\">职务：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp4\" style=\"width: 100px\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 280px\">\r\n<div class=\"ziduan_ming\">受聘日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp5\" style=\"width: 150px\" name=\"temp5\" value=\"#temp5#\" type=\"text\" onclick=\"WdatePicker()\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">工作描述：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp6\" style=\"width: 200px\" name=\"temp6\" value=\"#temp6#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 684px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">记录：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 380px\"><input id=\"temp7\" name=\"temp7\" value=\"#temp7#\" type=\"text\" />优/好/普通</div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 684px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">理由（任选一种）</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 400px\"><input id=\"temp8\" name=\"temp8\" value=\"#temp8#\" type=\"text\" />晋升/调整工作/工作考绩优良/年资增加</div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 684px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">现在工资：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 188px\"><input id=\"temp9\" name=\"temp9\" value=\"#temp9#\" type=\"text\" />RMB</div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">将调整工资：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 188px\"><input id=\"temp10\" name=\"temp10\" value=\"#temp10#\" type=\"text\" />RMB</div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 684px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; height: 50px\">备注：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 60%; height: 42px\"><textarea id=\"temp11\" name=\"temp11\">#temp11#</textarea></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 684px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">填表人：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp12\" name=\"temp12\" value=\"#temp12#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">经理审批：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp13\" name=\"temp13\" value=\"#temp13#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 684px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp14\" name=\"temp14\" value=\"#temp14#\" type=\"text\" onclick=\"WdatePicker()\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp15\" name=\"temp15\" value=\"#temp15#\" type=\"text\" onclick=\"WdatePicker()\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 0, '填表日期#姓名#性别#职务#受聘日期#工作描述#记录#理由#现在工资#将调整工资#备注#填表人#经理审批#日期#日期');
INSERT INTO `formtemp` VALUES (14, 'ZSSQD', '住宿申请单', '2012-01-17 11:37:31', 13, '<p><style type=\"text/css\">\r\n.outbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n<!--txt{ width:10%; height:20px; border:1px #F6F6F6 solid; background:#FFFFFF;}-->\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #F6F6F6;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}</style></p>\r\n<div class=\"outbody\">\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 630px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">住宿申请单</div>\r\n<div class=\"line\" style=\"width: 630px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">部门：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp1\" name=\"temp1\" value=\"#temp1#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">姓名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp2\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 630px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">职务：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" name=\"temp3\" value=\"#temp3#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">性别：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp4\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 630px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">住宿事由：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp5\" style=\"width: 300px\" name=\"temp5\" value=\"#temp5#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 630px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">主管签字：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp6\" name=\"temp6\" value=\"#temp6#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">总经理签字：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp7\" name=\"temp7\" value=\"#temp7#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 0, '部门#姓名#职务#性别#住宿事由#主管签字#总经理签字');
INSERT INTO `formtemp` VALUES (15, 'CZSQB', '辞职申请表', '2012-01-17 12:07:24', 13, '<p><style type=\"text/css\">\r\n.outbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n<!--txt{ width:10%; height:20px; border:1px #F6F6F6 solid; background:#FFFFFF;}-->\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #F6F6F6;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}</style></p>\r\n<div class=\"outbody\">\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 620px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">辞职申请表</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 100%; background: #ebebeb\"><label style=\"width: 100px; float: left\">&nbsp;&nbsp;&nbsp;&nbsp;申请日期:</label> <input id=\"temp1\" title=\"请填写  年  月  日\" onclick=\"WdatePicker()\" name=\"temp1\" value=\"#temp1#\" type=\"text\" /></div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">姓名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp2\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">部门：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" name=\"temp3\" value=\"#temp3#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">职位：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp4\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; height: 50px\">辞职原因：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 500px; height: 42px\"><span class=\"ziduan_ming_leirong\" style=\"width: 500px; height: 42px\"><textarea id=\"temp5\" name=\"temp5\">#temp5#</textarea> </span></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"cells\" style=\"padding-right: 20px; float: right\">\r\n<div class=\"ziduan_ming\">申请人：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp6\" name=\"temp6\" value=\"#temp6#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; height: 50px\">部门意见：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 500px; height: 42px\"><textarea id=\"temp7\" name=\"temp7\">#temp7#</textarea></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"cells\" style=\"padding-right: 20px; float: right\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp8\" onclick=\"WdatePicker()\" name=\"temp8\" value=\"#temp8#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"ziduan_ming\" style=\"text-align: center; width: 300px\">行政意见：</div>\r\n<div class=\"ziduan_ming\" style=\"text-align: center; width: 300px\">总经理意见：</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 620px\">\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 290px; height: 150px\"><textarea id=\"temp9\" style=\"width: 290px; height: 150px\" name=\"temp9\">#temp9#</textarea></div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 290px; height: 150px; margin-left:5px\"><textarea id=\"temp10\" style=\"width: 290px; height: 150px\" name=\"temp10\">#temp10#</textarea></div>\r\n</div>\r\n<div class=\"line\" style=\"margin-top: 8px; width: 620px\">\r\n<div class=\"cells\" style=\"width: 300px\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp11\" onclick=\"WdatePicker()\" name=\"temp11\" value=\"#temp11#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 300px\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp12\" onclick=\"WdatePicker()\" name=\"temp12\" value=\"#temp12#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div>&nbsp;</div>', 0, '申请日期#姓名#部门#职位#辞职原因#申请人#部门意见#日期#行政意见#总经理意见#日期#日期');
INSERT INTO `formtemp` VALUES (16, 'YGFD', '员工罚单', '2012-01-18 11:49:25', 13, '<p><style type=\"text/css\">\r\n.outbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #F6F6F6;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}</style></p>\r\n<div class=\"outbody\">\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 650px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">员工罚单</div>\r\n<div class=\"line\" style=\"width: 680px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">部门：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 500px\"><input id=\"temp1\" name=\"temp1\" value=\"#temp1#\" type=\"text\" />员工，&nbsp;于 <input id=\"temp2\" title=\"请输入日期\" onclick=\"WdatePicker()\" name=\"temp2\" value=\"#temp2#\" type=\"text\" />迟到，依</div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"line-height: 30px; width: 650px\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;《考勤管理制度》对个人进行警告处罚并处20元罚金，罚款以现金形式递交。</div>\r\n<div class=\"line\" style=\"width: 650px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 200px\">违纪员工签字：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" name=\"temp3\" value=\"#temp3#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"float: left; clear: both\">\r\n<div class=\"ziduan_ming\" style=\"width: 200px\">违纪员工所在部门主管签字：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"float:right;clear: both\"><input id=\"temp4\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 0, '员工#日期#违纪员工签字#违纪员工所在部门主管签字');
INSERT INTO `formtemp` VALUES (17, 'CCQJD', '出差申请单', '2012-01-18 02:16:59', 13, '<p><style type=\"text/css\">\r\n.outbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #F6F6F6;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}</style></p>\r\n<div class=\"outbody\">\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 550px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">出差申请单（二）</div>\r\n<div class=\"line\" style=\"width: 550px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">出差人姓名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp1\" name=\"temp1\" value=\"#temp1#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">服务部门：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp2\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">职称：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" name=\"temp3\" value=\"#temp3#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">职务代理人：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp4\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 550px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; height: 50px\">事由：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 350px; height: 42px\"><textarea id=\"temp5\" name=\"temp5\">#temp5#</textarea></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 550px\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 400px\">自<input id=\"temp6\" title=\"日期要细写 如2011-12-4 5：00\" onclick=\"WdatePicker()\" name=\"temp6\" value=\"#temp6#\" type=\"text\" /> 起至 <input id=\"temp7\" title=\"日期要细写 如2011-12-4 5：00\" onclick=\"WdatePicker()\" name=\"temp7\" value=\"#temp7#\" type=\"text\" />止 共计 <input id=\"temp8\" style=\"width: 60px\" name=\"temp8\" value=\"#temp8#\" type=\"text\" />天</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 550px\">\r\n<div class=\"ziduan_ming\">地点：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp9\" style=\"width: 300px\" name=\"temp9\" value=\"#temp9#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 550px\">\r\n<div class=\"ziduan_ming\">预支旅费：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp10\" title=\"请以\'  万   千  佰  拾  元整\'的格式填写\" style=\"width: 200px\" name=\"temp10\" value=\"#temp10#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 550px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; height: 50px\">备注：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 350px; height: 42px\"><textarea id=\"temp11\" style=\"width: 350px; height: 42px\" name=\"temp11\">#temp11#</textarea></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 550px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">经理：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp12\" name=\"temp12\" value=\"#temp12#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">人事：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp13\" name=\"temp13\" value=\"#temp13#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">主管：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp14\" name=\"temp14\" value=\"#temp14#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">出差人：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp15\" name=\"temp15\" value=\"#temp15#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 0, '出差人姓名#服务部门#职称#职务代理人#事由#日期开始#日期结束#天数#地点#预支旅费#备注#经理#人事#主管#出差人');
INSERT INTO `formtemp` VALUES (18, 'YGLZD', '员工离职单', '2012-01-18 02:43:44', 13, '<p><style type=\"text/css\">\r\n.outbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n<!--txt{ width:10%; height:20px; border:1px #F6F6F6 solid; background:#FFFFFF;}-->\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}</style></p>\r\n<div class=\"outbody\">\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 723px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">员工离职单</div>\r\n<div class=\"line\" style=\"width: 723px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">部门：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp1\" class=\"smallInput\" name=\"temp1\" value=\"#temp1#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">姓名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp2\" class=\"smallInput\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">职位：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" class=\"smallInput\" name=\"temp3\" value=\"#temp3#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 723px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">到职日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp4\" class=\"smallInput\" onclick=\"WdatePicker()\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">离职日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp5\" class=\"smallInput\" onclick=\"WdatePicker()\" name=\"temp5\" value=\"#temp5#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 723px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; height: 50px\">离职原因：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 550px; height: 42px\"><textarea id=\"temp6\" style=\"width: 550px; height: 42px\" name=\"temp6\">#temp6#</textarea></div>\r\n</div>\r\n<div class=\"line\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; width: 723px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 100px; height: 100px\">所属部门：</div>\r\n<div class=\"cells\">\r\n<div class=\"cells\" style=\"width: 492px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; background: #fafafa; height: 50px\">工作交接：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 370px; height: 42px\"><textarea id=\"temp7\" style=\"width: 370px; height: 42px\" name=\"temp7\">#temp7#</textarea></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; background: #fafafa; height: 50px\">交接物品：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 370px; height: 42px\"><textarea id=\"temp8\" style=\"width: 370px; height: 42px\" name=\"temp8\">#temp8#</textarea></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 723px\">\r\n<div class=\"ziduan_ming\">财务部：</div>\r\n<div class=\"cells\">\r\n<div class=\"cells\" style=\"width: 623px\">\r\n<div class=\"cells\" style=\"width: 200px\">\r\n<div class=\"ziduan_ming\" style=\"background: #fafafa\">应领薪资：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp9\" class=\"smallInput\" name=\"temp9\" value=\"#temp9#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 200px\">\r\n<div class=\"ziduan_ming\" style=\"background: #fafafa\">扣缴金额：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp10\" class=\"smallInput\" name=\"temp10\" value=\"#temp10#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 200px\">\r\n<div class=\"ziduan_ming\" style=\"background: #fafafa\">实发薪资：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp11\" class=\"smallInput\" name=\"temp11\" value=\"#temp11#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 723px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; height: 50px\">备注：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 60%; height: 42px\"><textarea id=\"temp12\" style=\"width: 550px; height: 42px\" name=\"temp12\">#temp12#</textarea></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 723px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">总经理签字：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp13\" name=\"temp13\" value=\"#temp13#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 180px\">被交接工作员工签字：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp14\" name=\"temp14\" value=\"#temp14#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 0, '部门#姓名#职位#到职日期#离职日期#离职原因#工作交接#交接物品#应领薪资#扣缴金额#实发薪资#备注#总经理签字#被交接工作员工签字');
INSERT INTO `formtemp` VALUES (19, 'CZSQB', '财产移交表', '2012-01-18 03:56:25', 13, '<p><style type=\"text/css\">\r\n.outbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n<!--txt{ width:10%; height:20px; border:1px #F6F6F6 solid; background:#FFFFFF;}-->\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #6f6f6f;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:100px; line-height:18px;;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto 0;clear:both;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}\r\n.topline_cellB{float:left; width:200px; height:40px;line-height:40px;text-align:center;}</style></p>\r\n<div class=\"outbody\">\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 700px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">财产移交表</div>\r\n<div class=\"line\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; width: 700px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">移交人:</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp1\" class=\"smallInput\" name=\"temp1\" value=\"#temp1#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"float: right\">\r\n<div class=\"ziduan_ming\">移交物品名称:</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 350px\"><input id=\"temp2\" class=\"smallInput\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 700px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 40px; height: 40px\">部门</div>\r\n<div class=\"ziduan_ming topline_cellB\" style=\"width: 398px\">移交物品名称、数量</div>\r\n<div class=\"ziduan_ming topline_cellB\">接收人签名</div>\r\n</div>\r\n<div class=\"line\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; width: 700px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 40px; height: 40px\">1.本部门：</div>\r\n<div class=\" topline_cellB\" style=\"width: 398px\"><textarea id=\"temp3\" name=\"temp3\">#temp3#</textarea></div>\r\n<div class=\" topline_cellB\"><input id=\"temp4\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 700px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 40px; height: 40px\">2.财务部：</div>\r\n<div class=\" topline_cellB\" style=\"width: 398px\"><textarea id=\"temp5\" name=\"temp5\">#temp5#</textarea></div>\r\n<div class=\" topline_cellB\"><input id=\"temp6\" name=\"temp6\" value=\"#temp6#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"line\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; width: 700px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 40px; height: 40px\">3.行政部：</div>\r\n<div class=\" topline_cellB\" style=\"width: 398px\"><textarea id=\"temp7\" name=\"temp7\">#temp7#</textarea></div>\r\n<div class=\" topline_cellB\"><input id=\"temp8\" name=\"temp8\" value=\"#temp8#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 700px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">经理签名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp9\" class=\"smallInput\" name=\"temp9\" value=\"#temp9#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp10\" class=\"smallInput\" onclick=\"WdatePicker()\" name=\"temp10\" value=\"#temp10#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>', 0, '移交人#移交物品名称#本部门移交物品名称、数量#本部门接收人签名#财务部移交物品名称、数量#财务部接收人签名#行政部移交物品名称、数量#行政部接收人签名#经理签名#日期');
INSERT INTO `formtemp` VALUES (20, 'SYKH', '试用期员工考核表', '2012-01-19 10:39:33', 13, '<p><style type=\"text/css\">\r\n.outbody{margin:0 0 0 0; font-size:13px; font-family:\"宋体\"; color:#000066;}\r\na img {border: 1px solid #d4d4d4; width:20px; height:20px;}\r\na:hover img {border: 1px solid #999999;}\r\n.radio{margin:0px; width:13px; height:13px; line-height:27px;}\r\ninput.smallInput{border:1 solid #6F6F6F;font-size:13px;font-style:normal;font-weight:normal; height:18px;width:98px; line-height:18px;}\r\ninput.smallInput2{border:1 solid #6F6F6F;font-size:13px;font-style:normal;font-weight:normal; height:14px;width:45px; line-height:15px;}\r\ninput.smallInput3{border:1 solid #6F6F6F;font-size:13px;font-style:normal;font-weight:normal; height:14px;width:35px; line-height:15px;}\r\na{text-decoration:none;}\r\nselect{line-height:25px;border:1px #CCCCCC solid; background:#FFFFFF; height:25px;}\r\ntextarea{width:100%; height:99%;}\r\n.con{margin:0 auto; width:100%;}\r\n.header{ float:left;margin:auto 0;width:100%; height:125px; clear:both;}\r\n.lefter{ float:left;margin:auto 0px;width:23%; margin-top:10px;}\r\n.righter{ float:right;margin:auto 0; width:77%;margin-top:10px;}\r\n.main_leirong_title{float:left; text-align:center; font-family:\"黑体\"; font-size:18px; color:#408080; background:#F6F6F6; width:100%; clear:both;padding-top:8px;padding-bottom:8px;}\r\n.ziduan_title{float:left; text-align:left; font-family:\"黑体\"; font-weight:bold;font-size:15px; background-color:#FFFFF0;clear:both; width:100%; height:25px; padding-top:8px;}\r\n.line{float:left; margin:auto;width:100%;clear:both;;}\r\n.cells{float:left; margin:auto 0;}\r\n.ziduan_ming{ float:left; text-align:right; width:100px; font-size:15px; height:27px; line-height:27px;color:#000066;font-family:\"黑体\"; background:#F6F6F6;}\r\n.ziduan_ming_leirong{float:left;text-align:left; height:27px;line-height:27px;}\r\n.ziduan_ming2{width:250px; height:17px; line-height:17px; font-size:13px;text-align:left;}\r\n.ziduan_ming_leirong2{width:50px; text-align:center;}\r\n.ziduan_ming_leirong3{width:40px; text-align:center;}</style></p>\r\n<div class=\"outbody\">\r\n<div class=\"line\" style=\"border-bottom: #999999 2px solid; border-left: #999999 2px solid; width: 820px; border-top: #999999 2px solid; border-right: #999999 2px solid\">\r\n<div class=\"main_leirong_title\">新质科技有限公司</div>\r\n<div class=\"line\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; width: 820px; border-top: #999999 1px solid; border-right: #999999 1px solid; padding-top: 3px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 50px\">姓名：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp1\" class=\"smallInput\" name=\"temp1\" value=\"#temp1#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 50px\">部门：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp2\" class=\"smallInput\" name=\"temp2\" value=\"#temp2#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 50px\">职务：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp3\" class=\"smallInput\" name=\"temp3\" value=\"#temp3#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 50px\">学历：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp4\" class=\"smallInput\" name=\"temp4\" value=\"#temp4#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 50px\">专业：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp5\" class=\"smallInput\" name=\"temp5\" value=\"#temp5#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 140px\">毕业院校及时间：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp6\" class=\"smallInput\" style=\"width: 310px\" name=\"temp6\" value=\"#temp6#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 320px\">\r\n<div class=\"ziduan_ming\">试用期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp7\" class=\"smallInput\" title=\"请填写日期\" onclick=\"WdatePicker()\" name=\"temp7\" value=\"#temp7#\" type=\"text\" />-<input id=\"temp8\" class=\"smallInput\" title=\"请填写日期\" onclick=\"WdatePicker()\" name=\"temp8\" value=\"#temp8#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"ziduan_title\">试用期工作小结（本人填写）</div>\r\n<div class=\"line\" style=\"width: 800px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">申请人：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp9\" class=\"smallInput\" name=\"temp9\" value=\"#temp9#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp10\" class=\"smallInput\" onclick=\"WdatePicker()\" name=\"temp10\" value=\"#temp10#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"ziduan_title\">考评内容（主管填写）</div>\r\n<div class=\"line\" style=\"width: 815px\">\r\n<div class=\"cells\" style=\"width: 50px\">\r\n<div class=\"ziduan_ming\" style=\"border-bottom: #999999 1px solid; text-align: center; border-left: #999999 1px solid; width: 50px; height: 52px; border-top: #999999 1px solid; border-right: #999999 1px solid\">考评<br />\r\n内容</div>\r\n<div class=\"ziduan_ming\" style=\"text-align: center; width: 50px; height: 52px\">工作<br />\r\n业绩</div>\r\n<div class=\"ziduan_ming\" style=\"border-bottom: #999999 1px solid; text-align: center; border-left: #999999 1px solid; width: 50px; height: 238px; border-top: #999999 1px solid; border-right: #999999 1px solid\"><br />\r\n<br />\r\n<br />\r\n称职<br />\r\n能力</div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 250px\">\r\n<div class=\"ziduan_ming ziduan_ming2\" style=\"border-bottom: #999999 1px solid; text-align: center; border-left: #999999 1px solid; line-height: 52px; height: 52px; border-top: #999999 1px solid; border-right: #999999 1px solid\">评估要点</div>\r\n<div class=\"cells\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming ziduan_ming2\">及时、保持完成工作</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">高效开展工作</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">工作方法</div>\r\n</div>\r\n<div class=\"cells\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming ziduan_ming2\">良好的职业道德，品德端正</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">岗位专业知识拥有程度</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">实际工作经验以及解决岗位问题能力</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">对西山位职能与职责的认识程度</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">工作中能提出创新的见解和方法</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">善于学习，提高自身的知识水平和技能</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">务实与敬业精神，热爱本位工作</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">日常工作管理及自我管理</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">乐意与人协调、沟通，具有团队协作精神</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">工作计划与条理必，由项目目标意识</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">工作主动性与积极性</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">工作的服从与配合情况</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">遵守公司名项规章制度及出勤情况</div>\r\n<div class=\"ziduan_ming ziduan_ming2\">对公司及企业文化的认识程度</div>\r\n</div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 51px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming ziduan_ming2\" style=\"border-bottom: #999999 1px solid; text-align: center; border-left: #999999 1px solid; line-height: 52px; width: 50px; height: 52px; border-top: #999999 1px solid; border-right: #999999 1px solid\">权重</div>\r\n</div>\r\n<div class=\"cells\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; width: 50px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">10</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">10</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">10</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">8</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">8</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">8</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">4</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">3</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">5</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">5</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">3</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">5</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">3</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">5</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">5</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\">5</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height: 19px\">3</div>\r\n</div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 201px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming ziduan_ming2\" style=\"border-bottom: #999999 1px solid; text-align: center; border-left: #999999 1px solid; line-height: 30px; width: 200px; height: 30px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 200px\">员工自评</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height:50px;width: 49px\">A</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height:50px;width: 49px\">B</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height:50px;width: 49px\">C</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height:50px;width: 49px\">D</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height:50px;width: 49px\">4</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height:50px;width: 49px\">3</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height:50px;width: 49px\">2</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"height:50px;width: 49px\">1</div>\r\n</div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 200px\">\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp11\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp11\" value=\"#temp11#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp12\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp12\" value=\"#temp12#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp13\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp13\" value=\"#temp13#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp14\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp14\" value=\"#temp14#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp15\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp15\" value=\"#temp15#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp16\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp16\" value=\"#temp16#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp17\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp17\" value=\"#temp17#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp18\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp18\" value=\"#temp18#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp19\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp19\" value=\"#temp19#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp20\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp20\" value=\"#temp20#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp21\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp21\" value=\"#temp21#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp22\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp22\" value=\"#temp22#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp23\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp23\" value=\"#temp23#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp24\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp24\" value=\"#temp24#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp25\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp25\" value=\"#temp25#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp26\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp26\" value=\"#temp26#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px; height: 21px\"><input id=\"temp27\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp27\" value=\"#temp27#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 201px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming ziduan_ming2\" style=\"border-bottom: #999999 1px solid; text-align: center; border-left: #999999 1px solid; line-height: 52px; width: 200px; height: 52px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 200px\">主管评估</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 49px\">A</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 49px\">B</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 49px\">C</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 49px\">D</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 49px\">4</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 49px\">3</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 49px\">2</div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 49px\">1</div>\r\n</div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 200px\">\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp28\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp28\" value=\"#temp28#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp29\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp29\" value=\"#temp29#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp30\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp30\" value=\"#temp30#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp31\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp31\" value=\"#temp31#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp32\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp32\" value=\"#temp32#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp33\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp33\" value=\"#temp33#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp34\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp34\" value=\"#temp34#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp35\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp35\" value=\"#temp35#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp36\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp36\" value=\"#temp36#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp37\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp37\" value=\"#temp37#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp38\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp38\" value=\"#temp38#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp39\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp39\" value=\"#temp39#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp40\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp40\" value=\"#temp40#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp41\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp41\" value=\"#temp41#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp42\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp42\" value=\"#temp42#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px\"><input id=\"temp43\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp43\" value=\"#temp43#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong2\" style=\"width: 180px; height: 21px\"><input id=\"temp44\" class=\"smallInput2\" style=\"width: 138px\" name=\"temp44\" value=\"#temp44#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"cells\" style=\"width: 40px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming ziduan_ming2\" style=\"border-bottom: #999999 1px solid; text-align: center; border-left: #999999 1px solid; line-height: 20px; width: 40px; height: 52px; border-top: #999999 1px solid; border-right: #999999 1px solid\">评估<br />\r\n得分</div>\r\n</div>\r\n<div class=\"cells\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; width: 40px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp45\" class=\"smallInput3\" name=\"temp45\" value=\"#temp45#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp46\" class=\"smallInput3\" name=\"temp46\" value=\"#temp46#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp47\" class=\"smallInput3\" name=\"temp47\" value=\"#temp47#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp48\" class=\"smallInput3\" name=\"temp48\" value=\"#temp48#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp49\" class=\"smallInput3\" name=\"temp49\" value=\"#temp49#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp50\" class=\"smallInput3\" name=\"temp50\" value=\"#temp50#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp51\" class=\"smallInput3\" name=\"temp51\" value=\"#temp51#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp52\" class=\"smallInput3\" name=\"temp52\" value=\"#temp52#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp53\" class=\"smallInput3\" name=\"temp53\" value=\"#temp53#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp54\" class=\"smallInput3\" name=\"temp54\" value=\"#temp54#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp55\" class=\"smallInput3\" name=\"temp55\" value=\"#temp55#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp56\" class=\"smallInput3\" name=\"temp56\" value=\"#temp56#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp57\" class=\"smallInput3\" name=\"temp57\" value=\"#temp57#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp58\" class=\"smallInput3\" name=\"temp58\" value=\"#temp58#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp59\" class=\"smallInput3\" name=\"temp59\" value=\"#temp59#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\"><input id=\"temp60\" class=\"smallInput3\" name=\"temp60\" value=\"#temp60#\" type=\"text\" /></div>\r\n<div class=\"ziduan_ming ziduan_ming2 ziduan_ming_leirong3\" style=\"height: 19px\"><input id=\"temp61\" class=\"smallInput3\" name=\"temp61\" value=\"#temp61#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 800px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">考核等级：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp62\" class=\"smallInput\" title=\"90-100 优秀  80-89 良好  66-79  合格  65以下  较差\" name=\"temp62\" value=\"#temp62#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\">合计得分：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp63\" class=\"smallInput\" name=\"temp63\" value=\"#temp63#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"width: 800px\">\r\n<div class=\"ziduan_title\">部门主管简评：</div>\r\n<div class=\"line\" style=\"width: 723px\">\r\n<div class=\"ziduan_ming\" style=\"line-height: 50px; width: 120px; height: 50px\">试用期考核情况：</div>\r\n<div class=\"ziduan_ming_leirong\" style=\"width: 70%; height: 42px\"><textarea id=\"temp64\" style=\"width: 550px; height: 42px\" name=\"temp64\">#temp64#</textarea></div>\r\n</div>\r\n<div class=\"line\" style=\"width: 800px\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 120px\">建议转正类别：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp65\" class=\"smallInput\" title=\"请填写 &ldquo;提前转正&rdquo;、&ldquo;按期转正&rdquo;&ldquo;延长___的试用期&rdquo;或&ldquo;辞退&rdquo;\" name=\"temp65\" value=\"#temp65#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\" style=\"float: right\">\r\n<div class=\"ziduan_ming\" style=\"width: 50px\">日期：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp66\" class=\"smallInput\" onclick=\"WdatePicker()\" name=\"temp66\" value=\"#temp66#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line\" style=\"border-bottom: #999999 1px solid; border-left: #999999 1px solid; width: 800px; border-top: #999999 1px solid; border-right: #999999 1px solid\">\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 120px\">主管审批：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp67\" class=\"smallInput\" name=\"temp67\" value=\"#temp67#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 120px\">行政人事部审批：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp68\" class=\"smallInput\" name=\"temp68\" value=\"#temp68#\" type=\"text\" /></div>\r\n</div>\r\n<div class=\"cells\">\r\n<div class=\"ziduan_ming\" style=\"width: 120px\">经理审批：</div>\r\n<div class=\"ziduan_ming_leirong\"><input id=\"temp69\" class=\"smallInput\" name=\"temp69\" value=\"#temp69#\" type=\"text\" /></div>\r\n</div>\r\n</div>\r\n<div class=\"line STYLE1\" style=\"margin-top: 3px\">备注：1.此表适用试用期员工，考核由业绩考核及称职能力考核两部分分组成，考核评估分员工自评和主管考评，其中员工自评不计入得分，公司供参考。 2.本表交行政人事部备案。</div>\r\n</div>\r\n</div>\r\n</div>', 0, '');

-- ----------------------------
-- Table structure for freeze
-- ----------------------------
DROP TABLE IF EXISTS `freeze`;
CREATE TABLE `freeze`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '冻结表',
  `productId` int(11) NULL DEFAULT NULL COMMENT '冻结商品',
  `upNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上架单号',
  `freezeFlag` int(11) NULL DEFAULT NULL COMMENT '状态(0解冻，1冻结)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of freeze
-- ----------------------------

-- ----------------------------
-- Table structure for functioninfo
-- ----------------------------
DROP TABLE IF EXISTS `functioninfo`;
CREATE TABLE `functioninfo`  (
  `FunctionID` int(11) NOT NULL AUTO_INCREMENT COMMENT '功能节点/节点拥有的详细权限表',
  `linkFunctionName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '连接功能名称',
  `SuperID` int(11) NOT NULL COMMENT '父级id',
  `linkFunctionPage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接功能页面',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `imagepath` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片路径',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '删除标识',
  `versionFlag` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`FunctionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 497 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of functioninfo
-- ----------------------------
INSERT INTO `functioninfo` VALUES (1, '基本资料', 0, '', '1,2,3,4', '', 1, 1);
INSERT INTO `functioninfo` VALUES (2, '财务管理', 0, '', '1,2,3,4', '', 2, 1);
INSERT INTO `functioninfo` VALUES (3, '采购管理', 0, '', '1,2,3,4', '', 3, 1);
INSERT INTO `functioninfo` VALUES (4, '库存管理', 0, '', '1,2,3,4', '', 4, 1);
INSERT INTO `functioninfo` VALUES (5, '客服中心', 0, '', '1,2,3,4', '', 5, 1);
INSERT INTO `functioninfo` VALUES (7, ' 库存产品', 0, '', '1,2,3,4', '', 7, 1);
INSERT INTO `functioninfo` VALUES (8, '系统管理', 0, '', '1,2,3,4', '', 10, 1);
INSERT INTO `functioninfo` VALUES (9, '员工信息', 1, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (10, '供应商信息', 1, '', '', 'img/shield__minus.png', 0, 1);
INSERT INTO `functioninfo` VALUES (11, '客户信息', 1, '', '', 'img/shield__pencil.png', 0, 1);
INSERT INTO `functioninfo` VALUES (12, '仓库信息', 1, '', '', 'img/shield__exclamation.png', 0, 1);
INSERT INTO `functioninfo` VALUES (13, '添加员工', 9, 'addShowemp.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (14, '员工信息管理', 9, 'selectemp.do?deptid=all', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (15, '添加供应商', 10, 'goaddsupplierr.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (16, '供应商信息管理', 10, 'selectsupplierr.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (17, '操作客户信息', 11, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (21, '仓库的 增删改 以及 综合查询', 12, 'selectdepot.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (22, '客户信息列表', 17, 'getpageCustomer.do?type2=1', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (24, '正式客户的增删改查', 18, 'formalClient.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (25, '正式客户移交', 18, 'officialClientTransfer.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (26, '正式客户联系记录', 18, 'officialClientContactRecord.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (27, '需要审核客户的增删改查', 19, 'waitAuditingClient.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (28, '审核客户', 19, 'auditingClient.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (29, '试用记录的增删改查', 20, 'tryoutClient.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (32, '收款单', 2, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (33, '付款单', 2, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (39, '新增收款单', 32, 'addPagecharge.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (40, '收款单列表', 32, 'selectcharge.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (41, '新增付款单', 33, 'addShowpay.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (42, '付款单列表', 33, 'selectpay.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (44, '待采购单查询', 3, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (45, '请购单', 3, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (46, '采购合同', 3, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (47, '采购订单', 3, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (48, '到货单', 3, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (49, '采购退货单', 3, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (50, '采购价格一览表', 3, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (51, '待采购请购单列表', 44, 'getRejectioning.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (52, '请购单明细', 45, 'getRejectioning.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (53, '采购合同明细', 46, 'getContract.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (54, '采购订单明细', 47, 'getPurchaseOrder.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (56, '采购退货单明细', 49, 'returnOrderListRejection.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (57, '采购商品价格明细', 50, 'getScheduleOfValues.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (58, '入库', 4, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (59, '出库', 4, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (60, '库存明细', 4, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (61, '库存盘点', 4, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (62, '报损单', 4, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (63, '客户资产', 4, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (64, '库存报警', 4, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (65, '入库单列表', 58, 'warehousingInfoWarehousing.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (66, '商品入库', 58, 'addshowWarehousing.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (69, '出库单列表', 59, 'outBoundInfoOutbound.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (73, '仓库综合查询', 60, 'storageQueryStockpileDetails.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (74, '架上库存', 60, 'useCommodityStockpileDetails.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (75, '架下库存', 60, 'untappeCommodityStockpileDetails.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (76, '添加库存盘点', 61, 'addshowStat.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (77, '盘点单综合查询', 61, 'selectStat.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (78, '报损明细', 62, 'queryTheDamage.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (79, '新增报损单', 62, 'addPorLossTheDamage.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (81, '客户资产托管明细', 63, 'getCustomerAsset.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (82, '仓库商品报警提示', 64, 'getWarning.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (83, '客户故障申报', 5, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (84, '故障处理', 5, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (85, '服务器监控记录', 5, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (86, '填写故障单', 83, 'gosubnote2MalfunctionDeclare.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (87, '查询未处理故障', 84, 'selectMalfunctionDeclare.do?tag=0', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (88, '查询已处理故障', 84, 'selectMalfunctionDeclare.do?tag=1', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (89, '服务器监控记录查询', 85, 'selectServerMonitoring.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (90, '临时统计', 6, 'getTemporarilyStat.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (91, '月统计', 6, 'getUptoSnuffStat.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (92, '季度统计', 6, 'getUptoSnuffStat.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (93, '年统计', 6, 'getUptoSnuffStat.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (94, '历史统计', 6, 'getAnnalsStat.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (95, '产品类型', 7, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (96, '添加产品类型', 95, 'commodity/addCommodityType.jsp', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (97, '产品类型信息', 95, 'selectPagecommodityTpye.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (100, '权限管理', 8, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (101, '修改密码', 8, 'editPassSystem.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (103, '模块列表', 100, 'selectFunctionsSystem.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (104, '菜单管理', 100, 'menuManagerMenu.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (105, '客户列表', 100, 'customerListSystem.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (106, '角色列表', 100, 'roleListSystemRole.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (107, '组/成员列表', 100, 'groupListGroup.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (109, '添加产品', 7, 'addPageCommodity.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (110, '产品信息', 7, 'selectCommodity.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (113, 'vps', 111, 'selectatherProduct.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (114, '部门信息', 1, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (115, '添加部门', 114, 'showempDepartment.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (116, '部门信息管理', 114, 'getAllstatisticsDepartment.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (117, '添加客户信息', 11, 'Basic/customer/ClientwillMessage.jsp', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (118, '添加请购单', 45, 'addpageRejectioning.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (140, '添加采购订单', 47, 'addShowPurchaseOrder.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (141, 'sdfs', 121, 'sdf', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (143, '到货单添加', 48, 'skippageToOrder.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (144, '到货单列表', 48, 'getpageToOrder.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (145, '新增采购退货单', 49, 'skippageRejection.do?returnorderid=0&&mark=add', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (151, '试用功能1', 150, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (157, '速度', 155, '闃挎柉', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (161, '添加出库单', 59, 'addshowOutbound.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (164, 'd', 162, 'd', 'df', 'd', 0, 1);
INSERT INTO `functioninfo` VALUES (174, '故障单据查询', 83, 'getMalfunctionDeclare.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (175, '添加记录', 85, 'addpageServerMonitoring.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (176, '销售管理', 0, '', '', '', 8, 1);
INSERT INTO `functioninfo` VALUES (177, '销售订单', 176, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (178, '添加订单', 177, 'addpagesaleOrder.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (179, '订单列表', 177, 'selectsaleOrder.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (180, '订单续费', 177, 'sale/saleorder/orderRenew.jsp', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (181, '客户退单', 5, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (182, '添加退单', 181, 'skippageClientOrder.do?mark=add', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (183, '退单列表', 181, 'getAllListClientOrder.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (184, '价格调整', 176, '', '价格调整模块', '', 0, 1);
INSERT INTO `functioninfo` VALUES (185, '价格记录一览', 184, 'selectpriceReg.do', '查询价格调整记录', '', 0, 1);
INSERT INTO `functioninfo` VALUES (186, '添加价格记录', 184, 'addShowpriceReg.do', '添加型号价格记录', '', 0, 1);
INSERT INTO `functioninfo` VALUES (187, '批量处理', 181, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (188, '批量审批', 187, 'approveClientOrder.do?mark=approve', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (189, '批量取消审批', 187, 'approveClientOrder.do?mark=cancel', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (191, '服务器管理', 0, '', '', '', 9, 1);
INSERT INTO `functioninfo` VALUES (192, '上架管理', 191, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (193, '上架单列表', 192, 'selectUpserver.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (194, '新增上架单', 192, 'addShowUpserver.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (196, '订单续费', 195, 'add.d', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (197, '续费列表', 195, 'select', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (198, '下架管理', 191, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (199, '下架单列表', 198, 'selectDownserver.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (200, '新增下架单', 198, 'addShowDownserver.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (201, '组装管理', 191, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (202, '组装服务器记录', 201, 'selectAssemblyServer.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (203, '新增组装服务器记录', 201, 'addShowAssemblyServer.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (205, '服务器状态管理', 191, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (206, '服务器使用状态', 205, 'selectServerState.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (207, '审核流程', 100, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (208, '新增审核流程', 207, 'skippageVerify.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (209, '审核流程列表', 207, 'pageslistVerify.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (210, '报溢单', 4, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (212, '报溢明细', 210, 'selectincome.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (213, '添加报溢单', 210, '', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (241, '续费详细', 177, 'selectrlsaleOrder.do', '', '', 0, 1);
INSERT INTO `functioninfo` VALUES (242, '故障转接', 83, 'commutatorMalfunctionDeclare.do', NULL, NULL, NULL, 1);
INSERT INTO `functioninfo` VALUES (243, '站内通讯', 0, '', '消息交互', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (244, '短消息', 243, '', ' 短消息', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (245, '发送员工消息', 244, 'messtypemessage.do', '发送客户消息', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (246, '已发短消息', 244, 'messendmessage.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (247, '已读短信息', 244, 'selmessbyreadflagmessage.do?restypeid=1&readflag=1', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (248, '未读短信息', 244, 'selmessbyreadflagmessage.do?restypeid=1&readflag=0', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (249, '消息草稿箱', 244, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (250, '发送客户消息', 244, 'message/customermessage.jsp', '发送员工消息', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (251, '消息类型控制', 243, '', '消息类型描述管理', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (252, '提醒设置', 8, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (253, '新增提醒功能', 252, 'System/msgRemind/addRemindFunction.jsp', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (254, '更改提醒设置', 252, 'getMessageremind.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (255, '添加消息类型', 251, 'getmessagetype.do', NULL, NULL, NULL, 1);
INSERT INTO `functioninfo` VALUES (256, '消息类型列表', 251, 'getpagemessagetype.do', NULL, NULL, NULL, 1);
INSERT INTO `functioninfo` VALUES (257, '工单配置', 8, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (258, '新增工单配置', 257, 'System/WorkOrderConfiguration/addWorkorderconfiguration.jsp', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (259, '更改工单配置', 257, 'getWorkOrderCfigur.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (260, '任务管理', 0, '', '/', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (261, '发布任务', 260, 'buildmission.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (262, '我收到的任务', 260, 'getmyreceivemission.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (263, '任务列表', 260, 'gettypeparammission.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (264, '任务类型', 260, 'getallmissiontype.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (265, '任务类别', 260, 'pdm/toaddpage2productManager.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (266, '我发布的任务', 260, 'getmybuildmission.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (267, '日程计划', 0, '', '描述工作任务和计划', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (268, '工作记事', 267, 'goListworknotepad.do?planStyle=0', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (269, '添加工作便签', 267, 'goAddworknotepad.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (270, '工作计划', 267, 'goListworknotepad.do?planStyle=1', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (271, '合同管理', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (272, '新增合同', 271, 'contract/addContract.jsp', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (273, '合同列表', 271, 'selectContracta.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (274, '单据类型管理', 100, '', NULL, NULL, NULL, 1);
INSERT INTO `functioninfo` VALUES (275, '单据类型添加', 274, 'addpagedocmark.do', NULL, NULL, NULL, 1);
INSERT INTO `functioninfo` VALUES (276, '单据类型列表', 274, 'getpagedocmark.do', NULL, NULL, NULL, 1);
INSERT INTO `functioninfo` VALUES (277, 'CDN管理', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (278, '缓存更新', 277, 'selectJieDianmission.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (285, '单据管理', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (286, '单据模板', 285, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (287, '详细单据', 285, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (288, '添加单据模板', 286, 'readaddFormTempAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (289, '单据模板信息', 286, 'selectmoreFormTempAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (290, '添加详细单据', 287, 'readaddFormDetailAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (291, '工作日志', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (292, '我的日志', 291, 'selectWorkLog.do?clear=0', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (293, '新建日志', 291, '', '新建一个日志', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (294, '查看详细单据', 287, 'selectformmoreFormDetailAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (295, '他人日志', 291, 'selectOtherWorkLog.do?clear=0', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (296, 'CDN套餐管理', 277, 'getAllCDNSetMealAction.do', '对CDN套餐进行增删改查', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (297, 'CDN套餐属性管理', 277, 'getAllCDNSetMealPropertyAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (298, 'CDN域名类型管理', 277, 'getAllCDNRealmTypeAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (299, 'CDN列表', 277, 'showcdnlist1CDNsaleOrderAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (300, '全部日志', 291, 'allListWorkLog.do?clear=0', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (301, '订单类型', 176, 'orderTypeListorderAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (302, '库存总览', 4, 'selectStocksWarehousing.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (303, '流程总括', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (304, '财务流程', 303, 'zwlc/caiwu.jsp', '财务流程', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (305, '销售流程', 303, 'zwlc/xiaos.jsp', '销售流程', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (306, '运维流程', 303, 'zwlc/yunwei.jsp', '运维流程', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (307, '部门员工', 9, 'departmentemp.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (308, '今日日志', 293, 'goAddWorkLog.do?mark=0', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (309, '本周总结', 293, 'goAddWorkLog.do?mark=1', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (310, '本月总结', 293, 'goAddWorkLog.do?mark=2', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (311, '用户列表', 100, 'userListSystem.do?mark=employee', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (312, '工作提醒', 267, 'goListworknotepad.do?planStyle=2', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (313, '订单查询', 32, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (314, '订单查询', 2, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (315, '快到期', 314, 'kdqsaleOrder.do?allTypeByPayStatus.type=1', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (316, '已到期', 314, 'kdqsaleOrder.do?allTypeByPayStatus.type=0', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (317, '项目管理', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (318, '我的项目', 317, 'listnewProject.do', '与我相关的项目(我发起的、我参与的)', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (319, '项目总览', 317, 'fusionChartsQuestionProject.do', '所有项目列表', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (320, '日志管理', 291, 'emplogByRjWorkLog.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (321, '库存统计', 4, 'stores/selProperty.jsp', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (322, '分仓统计', 4, 'stores/stormRoom.jsp', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (323, '财务统计', 2, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (324, '员工业绩', 323, 'ygyjsaleOrder.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (325, '成单量分析', 323, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (326, '全体成单量', 323, 'tjByMonthsaleOrder.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (327, 'IP管理', 191, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (328, '新增IP', 327, 'addUImanager.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (329, 'IP列表', 327, 'selectIpmanager.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (330, '部门信息管理-新', 114, 'getallmissiontype.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (331, '发起项目', 317, 'loadApprovernewProject.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (332, '分配任务', 317, 'publishtaskTaskProject.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (333, '我的任务', 317, 'selectTaskProject.do?pid=-2', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (334, '待批项目', 317, 'waitProjectApprovalProject.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (335, '问题模块', 317, 'QuestionListQuestionProject.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (336, '讨论社区', 317, 'selectQuestionProject.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (337, '项目消息', 317, 'showMessagenewProject.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (338, '商品管理', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (339, '待批任务', 317, 'waitapptaskTaskProject.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (340, '甘特图', 317, 'projectGTTnewProject.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (341, '新增上架单2', 192, 'addShow2Upserver.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (342, '资源核查管理', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (343, '资源核查列表', 342, 'selectReCheck.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (344, '商品管理', 0, NULL, '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (345, '发布商品', 344, 'pdm/toaddpage2productManager.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (346, '出售中的商品', 344, 'pdm/List1productManager.do?v=3', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (347, '仓库中的商品', 344, 'product_manage/page/test.jsp', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (348, '商品类目字典', 344, 'pdm/splitpagesClassprojt.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (349, '运维组管理', 0, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (350, '运维组列表', 349, 'getOperationsmissiontype.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (351, '岗位管理', 100, 'positionListPosition.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (352, '页面功能列表', 100, 'newmenuManagerNewManager.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (353, '业务管理', 1, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (354, '部门业务', 353, 'listDepartmentOperation.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (355, '员工业务', 353, 'listEmployeeOperation.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (356, '员工信息管理_new', 9, 'select2emp.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (357, '订单管理', 344, '', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (358, '订单信息', 357, 'pdm/getsaleproductManager.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (438, '部门办公', 0, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (439, '个人办公', 0, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (440, '商品管理', 0, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (441, '消息管理', 0, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (442, '全部员工', 438, 'getEmplistemp.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (443, '部门日志', 438, 'selectOtherWorkLogNewportal.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (444, '部门订单', 438, 'selectdeptsgsalegoods.do?demo=deptsg', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (445, '部门客户', 438, 'deptcustomerlistNewportalCustomer1.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (446, '部门工单', 438, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (447, '部门核查单', 438, 'selectdeptrcsalegoods.do?demo=deptrc', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (448, '我的资料', 439, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (449, '我的核查单', 439, 'selectmyrcsalegoods.do?demo=myrc', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (450, '我的日志', 439, 'selectDayWorkLogNewportal.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (451, '我的订单', 439, 'selectmysgsalegoods.do?demo=mysg', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (452, '我的客户', 439, 'mycustomerlistNewportalCustomer1.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (453, '我的工单', 439, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (454, '出售中的商品', 440, 'selectsalegoods.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (455, '仓库中的商品', 440, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (456, '发布商品', 440, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (457, '未读消息', 441, 'aaa.jsp', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (458, '已读消息', 441, 'returnForeLogin.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (459, '销售订单', 440, 'selectsordersalegoods.do?demo=sg', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (460, '资源核实单', 440, 'selectReourcesalegoods.do?demo=rc', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (461, '客服管理', 0, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (462, '代客填写工单', 461, 'goAddFault.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (463, '客服工单', 461, 'pdm/conkoutListFault.do?flag=1&zt=1', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (464, '运维工单', 461, 'pdm/toreceiveFault.do?flag=1&zt=1', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (468, '发布公告', 461, 'sendnotice.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (469, '公告列表', 461, 'listNtnotice.do?flag=0', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (470, '部门员工', 438, 'getEmplistbydeptemp.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (471, '客服工单', 439, 'pdm/conkoutListFault.do?flag=1&zt=1', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (472, '消息 ', 441, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (473, '出库单列表', 344, 'outBoundInfoOutbound.do?potalckd=potal', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (474, '出库单列表', 440, 'outBoundInfoOutbound.do?potalckd=potal', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (475, 'CDN线路类型列表', 277, 'cdnTypeListCDNsaleOrderAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (476, '业务审核', 439, 'waitauditAuditing.do?flag=0', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (477, '入库列表', 440, 'newwarehousingInfoWarehousing.do?potalckd=potal', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (480, 'CDN节点管理', 277, 'selectIpAreaTypeCDNsaleOrderAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (481, 'CDN分组管理', 277, 'selectGroupCDNsaleOrderAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (482, 'CDN流量监控', 277, 'CDNFlowControlCDNsaleOrderAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (484, '仓库列表', 440, 'seldepotWarehousing.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (485, '全部日志', 438, 'allListWorkLog.do?clear=0&funid=300&potal=potal', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (486, '新项目管理', 0, '', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (487, '发起项目', 486, 'loadApprovernewProject.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (488, '我的项目', 486, 'listnewProject.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (489, '我的任务', 486, 'selectTaskProject.do?pid=-2', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (490, '项目总览', 486, 'fusionChartsQuestionProject.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (491, '项目消息', 486, 'showMessagenewProject.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (492, '问题模块', 486, 'QuestionListQuestionProject.do', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (493, '运维工单', 439, 'pdm/toreceiveFault.do?flag=1&zt=1', '', '', NULL, 2);
INSERT INTO `functioninfo` VALUES (494, 'CDN流量统计', 277, 'CDNFlowControl1CDNsaleOrderAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (495, 'CDN请求统计', 277, 'CDNFlowControl2CDNsaleOrderAction.do', '', '', NULL, 1);
INSERT INTO `functioninfo` VALUES (496, '部门成员项目', 317, 'http://localhost:8080/FAJxc/EmpPojListbyDeptnewProject.do?funid=318', '', '', NULL, 1);

-- ----------------------------
-- Table structure for goodsClass_expand
-- ----------------------------
DROP TABLE IF EXISTS `goodsClass_expand`;
CREATE TABLE `goodsClass_expand`  (
  `ge_id` int(11) NOT NULL AUTO_INCREMENT,
  `gd_id` int(11) NULL DEFAULT NULL,
  `ge_temp1` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp2` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp3` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp4` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp5` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp6` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp7` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp8` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp9` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp10` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp11` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp12` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp13` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp14` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ge_temp15` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ge_id`) USING BTREE,
  INDEX `gd_id`(`gd_id`) USING BTREE,
  CONSTRAINT `goodsClass_expand_ibfk_1` FOREIGN KEY (`gd_id`) REFERENCES `goods_dict` (`gd_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 351 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of goodsClass_expand
-- ----------------------------
INSERT INTO `goodsClass_expand` VALUES (78, 139, '2;线路环境：;请选择;1-2-3-4-5-7-;电信-网通-铁通-双线切换(电信 网通)-三线切换(电信 网通 铁通)-海外-', '2;带宽标准：;请选择;1-2-3-4-5-;5M及以下-6-10M-11-50M-51-100M-100M以上-', '2;付费方式：;请选择;1-2-3-4-;月付-季付-半年付-年付-', '2;省市：;请选择;1-2-3-4-5-6-7-;上海-北京-天津-重庆-安徽-珠海-德州-', '2;服务器结构：;请选择;1-2-3-4-5-6-7-8-;1U-2U-3U-4U-5U-6U-7U-8U-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (105, 144, '2;尺码;请选择;1-2-3-4-5-;MML-ML-L-S-M-', '4;种类;单向选择;1-2-3-;西服-衬衫-羽绒服-', '3;颜色;请选择;1-2-3-4-5-;红色-黄色-绿色-蓝色-紫色-', '1;是否免邮;请填写;1-;免邮-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (107, 151, '1;任汝芬;得到;1-;为-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (108, 152, '2;大肠杆菌;可耕地;1-2-;大起大落-成都市-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (117, 158, '2;测试一;请选择;1-2-3-4-;11111111111111111-阿萨德广东省给-前儿童热问题-34台热天微热一天-', '3;测试二;请选择;1-2-3-4-;阿萨德广东省-阿萨德国法-阿斯顿和规范化-官方尽快-', '4;测试三;请选择;1-2-3-4-;啊上的广泛地-德国汉高-飞脚后跟-二院体育-', '1;测试四;请填写;1-;阿萨德国法-', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (135, 160, '1;测试1;111111111;1-;1111111111-', '2;测试2;222;1-2-3-;222222222222-3333333333333333-44444444444444444-', '3;测试3;33;1-2-3-;11111-22222-33333-', '4;测试4;44444;1-2-3-;1111111-2222222-3333333-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (149, 168, '1;属性5;填写;1-;值11-', '2;属性6;选择;1-2-3-;值12-值13-值14-', '3;属性7;选择;1-2-3-;值15-值16-值17-', '4;属性8;选择;1-2-3-;值18-值19-值20-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (150, 166, '1;属性1;填写;1-;值1-', '2;属性2;选择;1-2-3-;值2-值3-值4-', '3;属性3;选择;1-2-3-;值5-值6-值7-', '4;属性4;选择;1-2-3-;值8-值9-值10-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (151, 163, '2;aaaaaaa;aaa;1-2-3-;pppp-bbbbbb-cccccc-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (152, 164, '1;测试5;aa;1-;ooo-', '2;测试6;bb;1-2-3-;aaaaaa-bbbbbb-cccccc-', '3;测试7;cc;1-2-3-;aaaaa-bbbbb-ccccc-', '4;测试8;dd;1-2-3-4-;aaaaa-bbbbb-ccccc-ddddd-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (157, 169, '1;测试属性1;请填写;1-;属性值1-', '2;测试属性2;请选择;1-2-3-;属性值2-属性值3-属性值4-', '3;测试属性3;多选;1-2-3-;属性值5-属性值6-属性值7-', '4;测试属性4;单选;1-2-3-;属性值8-属性值9-属性值10-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (162, 171, '1;测试属性5;请填写;1-;属性值11-', '2;测试属性6;请选择;1-2-3-;属性值12-属性值13-属性值14-', '3;测试属性7;多选;1-2-3-;属性值15-属性值16-属性值17-', '4;测试属性8;单选;1-2-3-;属性值18-属性值19-属性值20-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (221, 138, '1;IP地址;请填写;1-;一个免费IP1-', '3;机房;请选择;1-2-;广东电信-山东联通-', '1;网卡;请填写;1-;双千兆网卡-', '2;服务器所在地;请选择;1-2-3-4-5-6-7-8-;北京1-上海-重庆-珠海-德州-深圳-山东-广东-', '2;服务器支出CPU个数;请选择;1-2-3-4-5-6-7-8-9-;1个-2个-3个-4个-5个-6个-7个-8个-9个-', '2;服务器CPU类型;请选择;1-2-3-4-5-6-7-8-9-10-;Xeon E5310-Xeon X5460-Xeon 5110-Xeon 3040-Xeon E5320-奔腾4-奔腾双核-AMD Athlon-I3 530-inter I3 2.8GHz-', '2;服务器硬盘类型;请选择;1-2-3-4-5-6-7-;IDE-SATA-SATAII-SCSI-SAS-光纤-其他服务器硬盘类型-', '2;服务器硬盘容量;请选择;1-2-3-4-5-6-7-;80G-146G-300G-320G-500G-700G-1T-', '2;服务器内存大小;请选择;1-2-3-4-5-6-;1G-2G-4G-8G-16G-512M-', '3;价格;请选择;1-2-3-4-5-;1200元/月-1300元/月-480元/月-1400元/季-4999元/年-', '2;付费方式;请选择;1-2-3-4-5-;请选择-月付-季付-半年付-年付-', '1;含税价;请填写;1-;5350元/月-', '2;服务器线路环境;请选择;1-2-3-4-5-6-7-;电信-网通-铁通-联通-双线切换（电信 网通）-三线切换（电信 网通 铁通）-海外-', '2;带宽标准;请选择;1-2-3-4-5-;5M及以下-6M-10M-50M-百兆独享（99%可用）-', NULL);
INSERT INTO `goodsClass_expand` VALUES (257, 178, '2;服务器所在地;请选择;1-2-3-4-5-6-7-8-;北京-上海-重庆-珠海-德州-深圳-山东-广东-', '2;服务器支持CPU个数;请选择;1-2-3-4-5-6-7-8-9-;1个-2个-3个-4个-5个-6个-7个-8个-9个-', '2;服务器CPU类型;请选择;1-2-3-4-5-6-7-8-9-10-11-12-;无-Xeon E5310-Xeon X5460-Xeon 5110-Xeon 3040-Xeon E5320-奔腾4-奔腾双核-AMD Athlon-I3 530-inter I3 2.8GHz-Intel酷睿2双核 E5200-', '2;服务器硬盘类型;请选择;1-2-3-4-5-6-7-8-;无-IDE-SATA-SATAII-SCSI-SAS-光纤-其他服务器硬盘类型-', '2;硬盘容量;请选择;1-2-3-4-5-6-7-8-;80G-146G-300G-320G-500G-700G-1T-160GB 7200RPM SAT-', '2;服务器内存大小;请选择;1-2-3-4-5-6-;512M-1G-2G DDR800 KinSton-4G-8G-16G-', '2;付费方式;请选择;1-2-3-4-;月付-季付-半年付-年付-', '1;含税价;请填写;1-;5350元/年-', '2;服务器结构;请选择;1-2-3-4-5-6-7-8-9-;无-1U-2U-3U-4U-5U-6U-7U-8U-', '2;服务器线路环境;请选择;1-2-3-4-5-6-7-;电信-网通-铁通-联通-双线切换（电信 网通）-三线切换（电信 网通 铁通）-海外-', '2;带宽标准;请选择;1-2-3-4-;5M及以下-10M-50M-百兆独享（99%可用）-', '3;操作系统;请选择;1-2-;windows -linux-', '1;IP地址;请填写;1-;一个免费IP-', '1;网卡;请填写;1-;双千兆网卡-', '');
INSERT INTO `goodsClass_expand` VALUES (258, 180, '2;线路环境;请选择;1-2-3-4-5-6-;电信-网通-铁通-双线切换（电信 网通）-三线切换（电信 网通 铁通）-海外-', '2;带宽标准;请选择;1-2-3-4-5-;5M及以下-10M-50M-100M-100M以上-', '2;付费方式;请选择;1-2-3-4-;月付-季付-半年付-年付-', '2;省市;请选择;1-2-3-4-5-6-7-;上海-北京-天津-重庆-珠海-德州-广东-', '2;服务器结构;请选择;1-2-3-4-5-6-7-8-;1U-2U-3U-4U-5U-6U-7U-8U-', '2;CPU;请选择;1-;Intel Pentium G620(双核,64位处理器)-', '2;内存;请选择;1-;DDR3 1333 2G高速内存-', '2;CPU;请选择;1-;Intel Pentium G620(双核,64位处理器)-', '2;内存;请选择;1-;DDR3 1333 2G高速内存-', '2;问题;额外前台人;1-2-;人士广泛地-是对方回复-', '2;按时到岗;大方广;1-2-;丰东股份-是对方回复-', '2;啊的萨嘎多少;大商股份;1-;阿萨德股份给-', NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (270, 184, '2;品牌;请选择;1-2-3-;三星-天宇-魅族-', '2;操作系统;请选择;1-2-3-;安卓-iphone-windows-', '2;主屏尺寸;请选择;1-2-3-;3.5英寸-4.3英寸-4.5英寸-', '2;摄像头像素;请选择;1-2-3-;800万-500万-1300万-', '3;商品价格;请选择;1-2-3-;0-1000-1000-2000-2000-3000-', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (273, 186, '2;cpu;xx;1-;i3-', '1;neic;xx;1-;DDR3 2G-', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (275, 187, '2;cpu;请选择;1-2-3-4-;interlA001-interlA002-酷睿1001-酷睿1002-;0', '2;内存;请选择;1-2-3-4-;1G-2G-3G-4G-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (277, 188, '2;硬盘;请选择;1-2-3-;50G-100G-200G-;0', '2;带宽;请选择;1-2-3-4-;10M-20M-50M-100M-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (283, 190, '2;测试1;请选择;1-2-;11-22-;0', '3;测试2;请选择;1-2-;11-22-;0', '4;测试3;请选择;1-2-;11-22-;0', '1;测试4;请填写;1-;11-;0', '2;测试5;请选择;1-2-3-4-;11-22-33-44-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (285, 192, '2;测试;111;1-2-;3太热犹太人-暗钢飞刀-;0', '3;撒的韩国放到;的萨芬很过分;1-2-3-;阿萨德股份-是的符合规范化-放到回复过后-;1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (286, 195, '1;1;123;1-;123-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (290, 197, '2;cpu;xxxx;1-2-3-4-;i3-i5-i7-至强2.0-;0', '2;内存;yyyy;1-2-3-4-;2G-4G-8G-16G-;0', '3;机房;请选择机房;1-2-3-4-;北京石景山机房-滨州电信机房-湖北电信机房-深圳电信机房-;1', '3;带宽;zzzzz;1-2-3-4-5-;5M内-10M内-20M内-50M内-100M内-;1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (294, 198, '2;运营商;请选择;1-2-3-;3G无线网卡-0元购机-购机送费-;0', '', '3;手机配件;请选择;1-2-3-4-5-6-7-;手机保护套-手机电池-手机充电器-手机耳机-手机贴膜-手机存储卡-手写笔-;1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (304, 199, '4;品牌;请选择;1-2-3-4-5-6-7-8-;诺基亚-三星-联想-华为-中兴-苹果-HTC-小米-;0', '4;网络制式;请选择;1-2-3-4-5-6-7-;联通3G-移动3G-电信3G-GSM-双卡-双模-三网合一-;0', '4;系统;请选择;1-2-3-4-5-6-;Android-IOS-Windows-Symbian-其他智能手机-非智能手机-;0', '4;cpu;请选择;1-2-3-4-;单核-双核-四核-其他-;0', '4;外观;请选择;1-2-3-4-;直板-滑盖-翻盖-旋盖-;0', '4;操控;请选择;1-2-3-4-5-;标准键盘-全键盘-电阻屏触屏-电容屏触屏-触屏加键盘-;0', '4;屏幕尺寸;请选择;1-2-3-4-5-6-;2.7寸以下-3.5英寸-4英寸-5英寸-7英寸-7英寸以上-;0', '3;颜色;请选择;1-2-3-4-5-6-;黑色-白色-银白色-红色-粉色-银灰色-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (309, 200, '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (310, 201, '2;种类;请选择;1-2-3-4-5-6-7-8-9-10-11-12-13-;洁面-面霜-精油-爽肤水-精华-眼部保养-面膜-乳液-护肤套装-防嗮-卸妆-润唇膏-喷雾-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (311, 202, '2;种类;请选择;1-2-3-4-5-6-;指甲油-面部-眼部-唇膏-眉部-睫毛膏-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (334, 209, '4;品牌;请选择;1-2-3-;迪奥-贝玲妃-CLIO-;0', '4;色系;请选择;1-2-;自然色-象牙白-;0', '3;功效;请选择;1-2-3-4-5-;保湿-控油-遮瑕-干湿两用-防晒-;0', '4;类别;请选择;1-2-;粉底霜-粉饼-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (335, 208, '4;品牌;请选择;1-2-;植村秀-格兰玛-;0', '3;功效;请选择;1-2-3-4-5-6-7-;抗辐射-遮瑕-保湿-防晒-美白-提亮肤色-控油-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (336, 205, '2;品牌;请选择;1-2-3-4-5-6-;资生堂-雅诗兰-娇韵诗-碧欧泉-植村秀-科颜氏-;0', '4;防晒部位;请选择;1-2-3-;全身皆可-仅面部可用-面部皆可-;0', '3;功能;请选择;1-2-3-4-5-6-7-8-9-;晒后修复-美白-抗氧化-眼部防晒-提亮肤色-保湿-补水-提拉紧致-其他-;0', '4;原产区;请选择;1-2-;日系品牌-欧美品牌-;0', '4;防晒指数;请选择;1-2-3-4-;SPF15-SPF20-SPF30-SPF40-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (339, 204, '4;品牌;请选择;1-2-3-4-;蝶翠诗-奥丽肤-朵拉朵尚-帕蒂卡-;0', '3;功能;请选择;1-2-3-4-5-6-7-8-9-;去角质-收缩毛孔-去黑头-抗氧化-深层清洁-提亮肤色-控油-抗敏感-其他-;0', '2;原产区;;1-2-3-;日系品牌-国货精品-欧美品牌-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (340, 203, '2;品牌;请选择;1-2-3-4-5-6-7-8-;朵拉朵尚-露得清-雅诗兰-碧欧泉-倩碧-娇韵诗-兰芝-相宜本草-;0', '4;质地;请选择;1-2-3-4-5-;洁面乳-洁面泡沫-洁面皂-洁面啫喱-其他-;0', '3;功效;请选择;1-2-3-4-5-6-7-8-9-10-11-12-13-;去角质-抗氧化-提亮肤色-细致毛孔-抗痘-保湿-控油-去黑头-深层清洁-补水-美白-抗敏感-其他-;0', '4;类别;请选择;1-2-3-;无泡沫-有泡沫-其他-;0', '2;适用肤质;请选择;1-2-3-4-5-6-;混合性-干性-油性-中性-敏感性-所有肤质-;0', '4;原产区;请选择;1-2-3-4-;日系品牌-国货精品-欧美品牌-韩系品牌-;0', '1;简单描述;请填写;1-;请填写-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (342, 211, '3;第一规格;xxxx;1-2-3-;选项一-选项二-选项三-;1', '3;第二规格;yyyy;1-2-3-4-;A-B-C-D-;1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (343, 212, '3;规格1;TTTTT;1-2-3-4-;A-B-C-D-;0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `goodsClass_expand` VALUES (350, 181, '2;CPU;请选择;1-2-;Intel酷睿2双核 E5200-至强5520-;0', '2;内存;请选择;1-2-;2G DDR800 KinSton-8G DDR800 KinSton-;0', '2;硬盘;请选择;1-2-;160G 7200RPM SAT-256G 7200RPM SAT-;0', '2;主板;请选择;1-;Gigabyte G31-ES2C-;0', '2;标准;请选择;1-;1U IOK 服务器机箱-;0', '2;网络;请选择;1-;百兆共享/15M独享/1个IP-;0', '2;防护;请选择;1-;金盾8GB防火墙实时防护-;0', '2;带宽;请选择;1-2-3-;10M独享（99%可用）-50M独享（99%可用）-百M独享（99%可用）-;0', '2;CDN带宽;请选择;1-;10M-;0', '3;付费周期;请选择付费周期;1-2-3-4-;月付-季付-半年付-年付-;1', '2;网卡;请选择网卡;1-;双千兆网卡-;0', '2;机房;请选择机房;1-;广东电信-;0', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for goods_dict
-- ----------------------------
DROP TABLE IF EXISTS `goods_dict`;
CREATE TABLE `goods_dict`  (
  `gd_id` int(11) NOT NULL AUTO_INCREMENT,
  `gd_superID` int(11) NULL DEFAULT NULL,
  `gd_schilds` int(11) NULL DEFAULT NULL,
  `gdnames` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gdcodes` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gd_writename` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gd_writeTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`gd_id`) USING BTREE,
  UNIQUE INDEX `AK_Key_2`(`gdcodes`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 213 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of goods_dict
-- ----------------------------
INSERT INTO `goods_dict` VALUES (136, NULL, 1, '网店/网络服务/软件', '00010000', '0', '2013-02-01 16:14:23');
INSERT INTO `goods_dict` VALUES (137, 136, 1, '网络服务', '00010001', '0', '2013-02-01 16:17:52');
INSERT INTO `goods_dict` VALUES (138, 136, 1, '服务器租用', '00010002', '1', '2013-04-01 16:16:52');
INSERT INTO `goods_dict` VALUES (139, 137, 1, '服务器托管', '000100010001', '1', '2013-02-01 17:03:50');
INSERT INTO `goods_dict` VALUES (143, NULL, NULL, '服装', '00020000', '0', '2013-03-03 16:15:08');
INSERT INTO `goods_dict` VALUES (144, 143, NULL, '男士服装', '00020001', '1', '2013-03-03 16:15:37');
INSERT INTO `goods_dict` VALUES (151, NULL, NULL, 'kkk', '00040000', '1', '2013-03-06 15:47:21');
INSERT INTO `goods_dict` VALUES (152, 151, NULL, '人', '00040001', '1', '2013-03-08 11:11:50');
INSERT INTO `goods_dict` VALUES (155, NULL, 1, '测试', '00060000', '0', '2013-03-09 10:27:10');
INSERT INTO `goods_dict` VALUES (157, 155, NULL, '测试商类目', '00060001', '0', '2013-03-09 10:27:35');
INSERT INTO `goods_dict` VALUES (158, 157, NULL, '商品类目', '000600010001', '1', '2013-03-09 10:28:18');
INSERT INTO `goods_dict` VALUES (160, NULL, NULL, 'aaaaaaaaaaaaa', '00070000', '1', '2013-03-11 11:56:56');
INSERT INTO `goods_dict` VALUES (163, 160, NULL, 'bbbbb', '00070001', '1', '2013-03-11 12:04:58');
INSERT INTO `goods_dict` VALUES (164, 163, NULL, 'ccccc', '000700010001', '1', '2013-03-11 12:17:33');
INSERT INTO `goods_dict` VALUES (166, NULL, NULL, '总类目', '00080000', '1', '2013-03-11 13:39:09');
INSERT INTO `goods_dict` VALUES (167, 166, NULL, '子类目', '00080001', '0', '2013-03-11 14:46:26');
INSERT INTO `goods_dict` VALUES (168, 167, NULL, '根类目', '000800010001', '1', '2013-03-11 13:42:08');
INSERT INTO `goods_dict` VALUES (169, NULL, NULL, '测试总类目', '00090000', '1', '2013-03-13 16:32:37');
INSERT INTO `goods_dict` VALUES (170, 169, NULL, '测试子类目', '00090001', '0', '2013-03-12 10:08:32');
INSERT INTO `goods_dict` VALUES (171, 170, NULL, '测试根类目', '000900010001', '1', '2013-03-12 10:08:43');
INSERT INTO `goods_dict` VALUES (176, NULL, 1, '网店/网络服务/正式数据', '00100000', '1', '2013-06-19 17:41:01');
INSERT INTO `goods_dict` VALUES (177, 176, NULL, '网络服务1', '00100001', '0', '2013-04-01 11:00:26');
INSERT INTO `goods_dict` VALUES (178, 176, NULL, '服务器租用', '00100002', '1', '2013-04-03 10:31:08');
INSERT INTO `goods_dict` VALUES (180, 177, NULL, '服务器托管', '001000010001', '1', '2013-04-09 10:38:06');
INSERT INTO `goods_dict` VALUES (181, 176, NULL, '服务器租用-立云推荐', '00100003', '1', '2013-04-03 10:47:25');
INSERT INTO `goods_dict` VALUES (183, NULL, NULL, '手机数码', '00110000', '0', '2013-04-15 17:07:05');
INSERT INTO `goods_dict` VALUES (184, 183, NULL, '手机', '00110001', '1', '2013-04-15 17:10:15');
INSERT INTO `goods_dict` VALUES (186, NULL, NULL, 'leng1', '00120000', '1', '2013-04-19 10:26:09');
INSERT INTO `goods_dict` VALUES (187, NULL, NULL, '检测父类', '00130000', '1', '2013-05-10 15:33:20');
INSERT INTO `goods_dict` VALUES (188, 187, NULL, '检测子类', '00130001', '1', '2013-05-23 15:26:42');
INSERT INTO `goods_dict` VALUES (189, NULL, NULL, '测试父类', '00140000', '0', '2013-05-25 18:18:12');
INSERT INTO `goods_dict` VALUES (190, 189, NULL, '测试子类', '00140001', '1', '2013-05-25 18:18:27');
INSERT INTO `goods_dict` VALUES (192, NULL, NULL, '测试11', '00150000', '1', '2013-05-27 15:58:10');
INSERT INTO `goods_dict` VALUES (193, NULL, NULL, '增加超类', '00160000', '1', '2013-05-28 11:50:51');
INSERT INTO `goods_dict` VALUES (194, NULL, NULL, 'idc', '00170000', '0', '2013-05-28 11:51:32');
INSERT INTO `goods_dict` VALUES (195, NULL, NULL, 'idc2', '00180000', '1', '2013-05-28 11:51:58');
INSERT INTO `goods_dict` VALUES (196, 139, 1, '百独', '0001000100010001', '1', '2013-05-29 11:51:58');
INSERT INTO `goods_dict` VALUES (197, 137, NULL, 'leng', '000100010002', '1', '2013-06-03 20:52:00');
INSERT INTO `goods_dict` VALUES (198, NULL, NULL, '手机通讯', '00190000', '1', '2013-06-07 11:15:41');
INSERT INTO `goods_dict` VALUES (199, 198, NULL, '手机', '00190001', '1', '2013-06-07 11:15:43');
INSERT INTO `goods_dict` VALUES (200, NULL, 1, '美容化妆', '00200000', '1', '2013-06-05 10:50:01');
INSERT INTO `goods_dict` VALUES (201, 200, 1, '面部护肤', '00200001', '1', '2013-06-05 11:06:29');
INSERT INTO `goods_dict` VALUES (202, 200, 1, '缤纷彩妆', '00200002', '1', '2013-06-05 11:13:47');
INSERT INTO `goods_dict` VALUES (203, 201, NULL, '洁面', '002000010001', '1', '2013-06-05 11:15:11');
INSERT INTO `goods_dict` VALUES (204, 201, NULL, '卸妆', '002000010002', '1', '2013-06-05 11:26:10');
INSERT INTO `goods_dict` VALUES (205, 201, NULL, '防嗮', '002000010003', '1', '2013-06-05 11:31:07');
INSERT INTO `goods_dict` VALUES (206, 202, 1, '面部', '002000020001', '0', '2013-06-05 11:40:09');
INSERT INTO `goods_dict` VALUES (207, 206, NULL, 'BB霜', '0020000200010001', '1', '2013-06-06 19:42:41');
INSERT INTO `goods_dict` VALUES (208, 206, NULL, '妆前隔离', '0020000200010002', '1', '2013-06-05 11:42:13');
INSERT INTO `goods_dict` VALUES (209, 206, NULL, '粉底', '0020000200010003', '1', '2013-06-05 11:45:39');
INSERT INTO `goods_dict` VALUES (210, NULL, NULL, '服饰', '00210000', '1', '2013-06-05 16:49:21');
INSERT INTO `goods_dict` VALUES (211, 137, NULL, 'leng66', '000100010003', '1', '2013-06-06 18:32:14');
INSERT INTO `goods_dict` VALUES (212, 137, NULL, 'leng662', '000100010004', '1', '2013-06-07 11:36:55');

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups`  (
  `groupID` int(11) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `superGroupID` int(11) NOT NULL,
  `permissionGrade` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `grade` float NULL DEFAULT NULL,
  `startTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`groupID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO `groups` VALUES (1, '管理部', 0, '0', 0, '2011-07-25 10:34:56', '顶级权限  ', '');
INSERT INTO `groups` VALUES (2, '客户部', 1, '0', 0, '2011-07-25 10:34:56', '客户权限 ', '');
INSERT INTO `groups` VALUES (3, '销售部', 1, '0', 0, '2011-07-25 10:34:56', '销售权限  ', '');
INSERT INTO `groups` VALUES (4, '客服部', 1, '0', 0, '2011-07-25 10:34:56', '客服权限  ', '');
INSERT INTO `groups` VALUES (5, '重要客户', 2, '28', 0, '2011-07-25 10:34:56', '重要客户 ', '');
INSERT INTO `groups` VALUES (6, '普通客户', 2, '28', 1, '2011-07-25 10:34:56', '普通客户', '');
INSERT INTO `groups` VALUES (7, '部门经理', 4, '26', 4, '2011-07-25 10:34:56', '经理级别', '');
INSERT INTO `groups` VALUES (8, '运维主管', 4, '27', 3, '2011-07-25 10:34:56', '运维主管', '');
INSERT INTO `groups` VALUES (9, '行政主管', 4, '27', 3, '2011-07-25 10:34:56', '行政主管', '');
INSERT INTO `groups` VALUES (10, '成员', 4, '28', 1.5, '2011-07-25 10:34:56', '成员', '');
INSERT INTO `groups` VALUES (11, '超级管理员', 1, '14', 5, '2011-07-25 10:34:56', '顶级权限', '');
INSERT INTO `groups` VALUES (12, '管理员', 1, '14', 5, '2011-07-25 10:34:56', '顶级权限', '');
INSERT INTO `groups` VALUES (14, '总经理级别', 0, '0', 5, '2011-07-25 10:34:56', '顺达副食店 ', '');
INSERT INTO `groups` VALUES (26, '经理级别', 0, '0', 4, '2011-07-27 14:26:07', '请选择', '');
INSERT INTO `groups` VALUES (27, '主管级别', 0, '0', 3, '2011-07-27 14:30:59', '请选择', '');
INSERT INTO `groups` VALUES (28, '普通员工', 0, '0', 1.5, '2011-07-27 16:05:15', '请选择 ', '');
INSERT INTO `groups` VALUES (29, '普通客户', 2, '0', 1, '2011-07-29 11:49:21', '请选择', '');
INSERT INTO `groups` VALUES (32, '技术部', 1, '0', 0, '2011-08-18 16-45-08', '技术部门', '');
INSERT INTO `groups` VALUES (33, '技术主管', 32, '27', 3, '2011-08-18 16:55:10', '顺达副食店', '');
INSERT INTO `groups` VALUES (34, '技术成员', 32, '28', 1.5, '2011-08-18 17:02:41', '两市大幅减少到了', '');
INSERT INTO `groups` VALUES (35, '技术经理', 32, '26', 2, '2011-08-18 17:11:22', '松岛枫', '');
INSERT INTO `groups` VALUES (38, '销售主管', 3, '27', 3, '2011-11-24 09:43:48', '  是打发士大夫', NULL);
INSERT INTO `groups` VALUES (40, '销售经理', 3, '26', 4, '2011-11-24 09:46:43', '  ssss', NULL);
INSERT INTO `groups` VALUES (41, '成员', 3, '28', 1.5, '2011-11-24 09:46:56', '  1123233', NULL);
INSERT INTO `groups` VALUES (42, '运维部', 1, '0', 0, '2011-11-24 09-50-08', '  运维。。。。', NULL);
INSERT INTO `groups` VALUES (43, '运维经理', 42, '26', 4, '2011-11-24 09:50:27', '  level', NULL);
INSERT INTO `groups` VALUES (44, '运维主管', 42, '27', 3, '2011-11-24 09:50:42', '  fssd', NULL);
INSERT INTO `groups` VALUES (45, '运维成员', 42, '28', 1.5, '2011-11-24 09:50:59', '  123456', NULL);
INSERT INTO `groups` VALUES (46, '行政组', 1, '0', 0, '2011-11-24 09-51-48', '  行政。。。。', NULL);
INSERT INTO `groups` VALUES (47, '行政主管', 46, '27', 3, '2011-11-24 09:54:33', '  2121212', NULL);
INSERT INTO `groups` VALUES (48, '行政前台', 46, '28', 1.5, '2011-11-24 09:54:50', '  说的说法是大法师', NULL);
INSERT INTO `groups` VALUES (49, '游戏部', 1, '0', 0, '2011-12-12 18-19-54', '  ', NULL);
INSERT INTO `groups` VALUES (50, '游戏主管', 49, '27', 3, '2011-12-12 18:20:17', '  ', NULL);
INSERT INTO `groups` VALUES (51, '游戏成员', 49, '28', 1.5, '2011-12-12 18:20:47', '  ', NULL);
INSERT INTO `groups` VALUES (52, '财务部', 1, '0', 0, '2011-12-12 18-35-58', '  ', NULL);
INSERT INTO `groups` VALUES (53, '财务主管', 52, '27', 3, '2011-12-12 18:36:13', '  ', NULL);
INSERT INTO `groups` VALUES (54, '财务成员', 52, '28', 1.5, '2011-12-12 18:36:45', '  ', NULL);
INSERT INTO `groups` VALUES (55, '行政助理', 46, '28', 1.5, '2011-12-21 15:36:08', '  ', NULL);
INSERT INTO `groups` VALUES (56, '客服中心', 1, '0', 0, '2012-02-02 19-18-37', '  ', NULL);
INSERT INTO `groups` VALUES (57, '客服中心主任', 56, '27', 3, '2012-02-02 19:19:05', '  ', NULL);
INSERT INTO `groups` VALUES (58, '项目助理', 32, '28', 1.5, '2012-02-15 17:21:42', '  ', NULL);
INSERT INTO `groups` VALUES (59, '客服主管', 4, '27', 3, '2012-07-17 18:46:51', '  ', NULL);
INSERT INTO `groups` VALUES (61, '省级负责人', 1, '26', 4, '2012-11-18 09:22:01', '省级公司', NULL);
INSERT INTO `groups` VALUES (62, '地区负责人', 1, '26', 4, '2012-11-18 09:22:35', '  ', NULL);
INSERT INTO `groups` VALUES (63, '行政总监', 1, '14', 5, '2012-11-18 09:24:05', '  ', NULL);

-- ----------------------------
-- Table structure for income
-- ----------------------------
DROP TABLE IF EXISTS `income`;
CREATE TABLE `income`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empId` int(11) NULL DEFAULT NULL,
  `itime` datetime NULL DEFAULT NULL,
  `incomeNo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auditingState` int(11) NULL DEFAULT NULL,
  `allSum` double NULL DEFAULT NULL,
  `inmark` int(11) NULL DEFAULT NULL,
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of income
-- ----------------------------

-- ----------------------------
-- Table structure for incomeinfo
-- ----------------------------
DROP TABLE IF EXISTS `incomeinfo`;
CREATE TABLE `incomeinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incomeId` int(11) NULL DEFAULT NULL,
  `modelId` int(11) NULL DEFAULT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `sum` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of incomeinfo
-- ----------------------------

-- ----------------------------
-- Table structure for intentfollow_up
-- ----------------------------
DROP TABLE IF EXISTS `intentfollow_up`;
CREATE TABLE `intentfollow_up`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_id` int(11) NOT NULL,
  `_date_` datetime NULL DEFAULT NULL,
  `detail` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empID` int(11) NULL DEFAULT NULL,
  `del` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `followtype` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `intentFollow-up_fk`(`Customer_id`) USING BTREE,
  INDEX `intentFollow-up_fk2`(`empID`) USING BTREE,
  CONSTRAINT `intentFollow-up_fk` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `intentFollow-up_fk2` FOREIGN KEY (`empID`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of intentfollow_up
-- ----------------------------

-- ----------------------------
-- Table structure for job
-- ----------------------------
DROP TABLE IF EXISTS `job`;
CREATE TABLE `job`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of job
-- ----------------------------
INSERT INTO `job` VALUES (1, '下啊苏打水');
INSERT INTO `job` VALUES (2, '相册vxc');

-- ----------------------------
-- Table structure for knowledgelib
-- ----------------------------
DROP TABLE IF EXISTS `knowledgelib`;
CREATE TABLE `knowledgelib`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `libType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '知识库类型',
  `libTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `libContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `libAccessory` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `empid` int(11) NULL DEFAULT NULL COMMENT '上传人',
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `lib_emp_id`(`empid`) USING BTREE,
  CONSTRAINT `lib_emp_id` FOREIGN KEY (`empid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of knowledgelib
-- ----------------------------

-- ----------------------------
-- Table structure for leavesimple
-- ----------------------------
DROP TABLE IF EXISTS `leavesimple`;
CREATE TABLE `leavesimple`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empid` int(11) NULL DEFAULT NULL COMMENT '请假人',
  `begintime` date NULL DEFAULT NULL COMMENT '请假开始时间',
  `endtime` date NULL DEFAULT NULL COMMENT '请假结束时间',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请假内容',
  `manager` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '经理签字',
  `superson` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主管签字',
  `admin` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行政签字',
  `leavetype` int(11) NULL DEFAULT NULL COMMENT '请假类型(0休假,1病假,2事假,3其他)',
  `temp` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注字段(不用添加)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of leavesimple
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `messageid` int(11) NOT NULL AUTO_INCREMENT,
  `sendertype` int(11) NULL DEFAULT NULL,
  `sender` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `messagetype` int(11) NULL DEFAULT NULL,
  `messagecontent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `accessory` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `titleweb` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `repealfalg` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否撤销	（0为否，1为是）',
  `delfalg` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否删除。0未删除，1已删除，2彻底删除，3草搞箱',
  `draftfalg` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `releasetime` datetime NULL DEFAULT NULL,
  `deltime` date NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `superid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`messageid`) USING BTREE,
  INDEX `metype`(`messagetype`) USING BTREE,
  INDEX `sendertype`(`sendertype`) USING BTREE,
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`sendertype`) REFERENCES `messagetype` (`messagetypeid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `metype` FOREIGN KEY (`messagetype`) REFERENCES `messagetype` (`messagetypeid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 10240 kB; (`messagetype`) REFER `fajxc/commodit' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for messagehistory
-- ----------------------------
DROP TABLE IF EXISTS `messagehistory`;
CREATE TABLE `messagehistory`  (
  `Mhistoryid` int(11) NOT NULL AUTO_INCREMENT,
  `receivertype` int(11) NULL DEFAULT NULL,
  `receiverid` int(11) NULL DEFAULT NULL,
  `contactTime` date NULL DEFAULT NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Mhistoryid`) USING BTREE,
  INDEX `messageReceiver`(`receiverid`) USING BTREE,
  CONSTRAINT `messageReceiver` FOREIGN KEY (`receiverid`) REFERENCES `messagereceiver` (`receiverid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of messagehistory
-- ----------------------------

-- ----------------------------
-- Table structure for messagereceiver
-- ----------------------------
DROP TABLE IF EXISTS `messagereceiver`;
CREATE TABLE `messagereceiver`  (
  `receiverid` int(11) NOT NULL AUTO_INCREMENT,
  `receivertype` int(11) NULL DEFAULT NULL,
  `receiverer` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` int(11) NULL DEFAULT NULL,
  `receivetime` date NULL DEFAULT NULL,
  `readfalg` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delfalg` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否删除。0未删除，1已删除，2彻底删除，3草搞箱',
  `requestTime` date NULL DEFAULT NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` int(11) NULL DEFAULT NULL,
  `tmp4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `planid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`receiverid`) USING BTREE,
  INDEX `rtype`(`receiverer`) USING BTREE,
  INDEX `mreceiver`(`message`) USING BTREE,
  INDEX `receivertype`(`receivertype`) USING BTREE,
  CONSTRAINT `messagereceiver_ibfk_1` FOREIGN KEY (`receivertype`) REFERENCES `messagetype` (`messagetypeid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `mreceiver` FOREIGN KEY (`message`) REFERENCES `message` (`messageid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of messagereceiver
-- ----------------------------

-- ----------------------------
-- Table structure for messageremind
-- ----------------------------
DROP TABLE IF EXISTS `messageremind`;
CREATE TABLE `messageremind`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息提醒配置',
  `typeName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需要设置提醒的消息名称',
  `isEmailRemind` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '否是邮件提醒',
  `isPhoneRemind` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '否是手机提醒',
  `mark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息标记',
  `temp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部消息提醒',
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of messageremind
-- ----------------------------

-- ----------------------------
-- Table structure for messagetype
-- ----------------------------
DROP TABLE IF EXISTS `messagetype`;
CREATE TABLE `messagetype`  (
  `messagetypeid` int(11) NOT NULL AUTO_INCREMENT,
  `superid` int(11) NULL DEFAULT NULL,
  `voname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tablename` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `describetype` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `delflag` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp1` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`messagetypeid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of messagetype
-- ----------------------------
INSERT INTO `messagetype` VALUES (1, 11, '', '', '员工消息', '员工消息父类', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (2, 11, NULL, NULL, '客户消息', '客户消息父类', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (3, 1, '类型对象实体类名称', '类型对象数据库表名称', '部门消息', '部门消息备注', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (4, 1, '类型对象实体类名称', '类型对象数据库表名称', '系统公告', '类型备注1', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (5, 2, NULL, NULL, '客户公告', '客户公告', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (6, 2, NULL, NULL, '催款通知', '催款通知', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (7, 2, NULL, NULL, '下架通知', '下架通知', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (8, 1, NULL, NULL, '任命公告', '任命公告', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (9, 1, NULL, NULL, '行政通知', '行政通知', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (10, 2, NULL, NULL, '活动通知', '活动通知', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (11, 0, '1', '1', '个人消息', '1', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (16, 12, 'Employee', 'employee', '员工', '', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (17, 12, 'customer', 'Customer', '客户', '', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (18, 1, '', NULL, '放假通知', '放假通知', '1', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (19, 2, '', NULL, '处理工单提醒', '当有客户提交工单是给予提醒', '0', NULL, NULL, NULL);
INSERT INTO `messagetype` VALUES (20, 1, '活动消息', NULL, '活动通知', '公司的所有活动通知通过活动通知发送。v2.0', '1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mission
-- ----------------------------
DROP TABLE IF EXISTS `mission`;
CREATE TABLE `mission`  (
  `task_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务表',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `exp_start_time` datetime NULL DEFAULT NULL COMMENT '预计开始时间',
  `exp_end_time` datetime NULL DEFAULT NULL COMMENT '预计结束时间',
  `build_emp` int(11) NULL DEFAULT NULL COMMENT '任务发起人',
  `build_time` datetime NULL DEFAULT NULL COMMENT '任务创建时间',
  `is_single` int(11) NULL DEFAULT 0 COMMENT '是单人任务还是多人任务  默认0是单人 1是多人',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '任务描述',
  `type_id` int(11) NULL DEFAULT NULL COMMENT '任务类别id',
  `status` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '任务状态 0未结束 -1已结束(初期)',
  `end_time` datetime NULL DEFAULT NULL COMMENT '任务结束时间',
  `sbh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '识别号(唯一标识)',
  `dueTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '定时任务到期时间',
  `cycleType` int(11) NULL DEFAULT NULL COMMENT '周期类型 ex：日 周 月。。。',
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`task_id`) USING BTREE,
  INDEX `mission_ibfk_3`(`type_id`) USING BTREE,
  INDEX `fk_mission_emp`(`build_emp`) USING BTREE,
  CONSTRAINT `fk_mission_emp` FOREIGN KEY (`build_emp`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_mission_type` FOREIGN KEY (`type_id`) REFERENCES `missiontype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of mission
-- ----------------------------

-- ----------------------------
-- Table structure for mission_emp
-- ----------------------------
DROP TABLE IF EXISTS `mission_emp`;
CREATE TABLE `mission_emp`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务和员工多对多表',
  `taskid` int(11) NULL DEFAULT NULL,
  `empid` int(11) NULL DEFAULT NULL,
  `build_time` datetime NULL DEFAULT NULL COMMENT '建立时间',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '务任接受时间',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '任务完成时间',
  `status` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务状态',
  `complete_describe` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '任务完成描述',
  `sbh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sbh唯一标识',
  `complete_fjbs` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '完成状态附件标识(对应去查完成时提交的附件)',
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_emp`(`empid`) USING BTREE,
  INDEX `fk_tasks`(`taskid`) USING BTREE,
  CONSTRAINT `fk_emp` FOREIGN KEY (`empid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_tasks` FOREIGN KEY (`taskid`) REFERENCES `mission` (`task_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of mission_emp
-- ----------------------------

-- ----------------------------
-- Table structure for missiontype
-- ----------------------------
DROP TABLE IF EXISTS `missiontype`;
CREATE TABLE `missiontype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计划类别名称',
  `superid` int(11) NULL DEFAULT NULL COMMENT '计划类别父类id',
  `describes` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '计划类别描述',
  `build_time` datetime NULL DEFAULT NULL COMMENT '类别创建时间',
  `sbh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '识别号(唯一标识)',
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段',
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段1',
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段2',
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段3',
  `isflag` int(11) NULL DEFAULT NULL,
  `spellflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of missiontype
-- ----------------------------
INSERT INTO `missiontype` VALUES (1, '任务类型', -1, '任务类型', '2011-11-19 15:45:56', NULL, NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `missiontype` VALUES (2, '研发中心任务', 1, '研发中心任务', '2011-12-21 10:08:59', NULL, NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `missiontype` VALUES (3, '客服中心', 1, '客服中心任务', '2011-12-22 10:08:59', NULL, NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `missiontype` VALUES (4, '项目任务', -1, '项目类型', '2012-11-06 17:32:11', NULL, NULL, NULL, NULL, NULL, -1, 'xmlx');
INSERT INTO `missiontype` VALUES (5, '部门类型', -2, '部门类型', '2012-11-06 17:32:11', NULL, NULL, NULL, NULL, NULL, -1, 'bmlx');
INSERT INTO `missiontype` VALUES (6, '网站管理项目', 4, 'xxx', '2012-11-06 17:32:11', NULL, NULL, NULL, NULL, NULL, 2, 'cmsxtgl');
INSERT INTO `missiontype` VALUES (7, 'IDC项目', 4, 'yyy', '2012-11-06 17:32:11', NULL, NULL, NULL, NULL, NULL, 2, 'xmgl');
INSERT INTO `missiontype` VALUES (8, '软件研发项目', 4, 'zzz', '2012-11-06 17:32:11', NULL, NULL, NULL, NULL, NULL, 2, 'rjxm');
INSERT INTO `missiontype` VALUES (9, '系统任务', 1, '系统任务', '2012-11-29 18:54:34', NULL, NULL, NULL, NULL, NULL, 0, 'xtrw');
INSERT INTO `missiontype` VALUES (96, '业务类型', -1, NULL, '2012-12-24 11:06:23', NULL, NULL, NULL, NULL, NULL, -1, NULL);
INSERT INTO `missiontype` VALUES (97, '采购', 96, '', '2012-12-24 11:06:26', '', '', '', '', '', 96, '');
INSERT INTO `missiontype` VALUES (98, '投资', 96, '', '2012-12-24 11:06:17', '', '', '', '', '', 96, '');
INSERT INTO `missiontype` VALUES (99, '销售', 96, '', '2012-12-20 15:02:48', '', '', '', '', '', 96, '');
INSERT INTO `missiontype` VALUES (100, '运维部', -3, '管理所有运维业务', '2013-01-06 11:15:44', '', '', '', '', '', -3, 'ywb');
INSERT INTO `missiontype` VALUES (101, '深圳运维一组', 103, '深圳分组', '2013-05-25 15:10:08', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (102, '深圳运维二组', 103, '深圳分组', '2013-01-14 16:57:03', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (103, '深圳运维部', 100, '深圳管理运维业务分支', '2013-01-06 12:01:07', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (104, '深圳运维三组', 103, '', '2013-01-14 16:57:02', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (105, '山东运维部', 100, '', '2013-01-06 17:36:29', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (106, '山东运维三组', 105, '', '2013-01-15 11:06:03', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (107, '山东运维二组', 105, '', '2013-01-14 16:57:09', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (108, '系统运算坏', 103, '', '2013-01-11 10:10:25', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (111, '珠海运维部', 100, '', '2013-01-12 09:58:48', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (112, '珠海运维一组', 111, '', '2013-01-15 10:46:04', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (113, '珠海运维二组', 111, '', '2013-01-12 10:04:30', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (114, '1111', 100, '', '2013-01-14 17:03:50', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (115, '珠海运维三组', 111, '', '2013-01-15 11:19:36', '', '', '', '', '', 100, '');
INSERT INTO `missiontype` VALUES (116, '公司任务', 1, '公司总体协调任务', '2013-01-17 09:50:21', '', '', '', '', '', 1, 'gsrw');
INSERT INTO `missiontype` VALUES (117, '客户退款', 116, '', '2013-01-16 20:08:31', '', '', '', '', '', 116, '');
INSERT INTO `missiontype` VALUES (118, '采购退款', 116, '', '2013-01-16 20:08:46', '', '', '', '', '', 116, '');
INSERT INTO `missiontype` VALUES (119, '其他退款', 116, '', '2013-01-16 20:08:58', '', '', '', '', '', 116, '');
INSERT INTO `missiontype` VALUES (120, '公司任务', 1, '公司总体协调任务', '2011-11-19 15:45:56', NULL, NULL, NULL, NULL, NULL, 1, 'gsrw');

-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS `model`;
CREATE TABLE `model`  (
  `model` int(11) NOT NULL AUTO_INCREMENT,
  `typeID` int(11) NULL DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`model`) USING BTREE,
  INDEX `model_fk`(`typeID`) USING BTREE,
  CONSTRAINT `model_fk` FOREIGN KEY (`typeID`) REFERENCES `commoditytpye` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of model
-- ----------------------------

-- ----------------------------
-- Table structure for new_approve
-- ----------------------------
DROP TABLE IF EXISTS `new_approve`;
CREATE TABLE `new_approve`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK 项目审批表',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'FK  项目编号',
  `applypeople` int(11) NULL DEFAULT NULL COMMENT 'FK 申请人',
  `begintime` date NULL DEFAULT NULL COMMENT '项目开始时间',
  `endtime` date NULL DEFAULT NULL COMMENT '项目结束时间',
  `appstatus` int(11) NULL DEFAULT NULL COMMENT '审批状态 审批状态0拒决1通过',
  `approveinfo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '审批意见',
  `approveemp` int(11) NULL DEFAULT NULL COMMENT 'FK   审批人',
  `appLD` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用：有内容就是自己审核，上面没有人能审批',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_approve
-- ----------------------------

-- ----------------------------
-- Table structure for new_document
-- ----------------------------
DROP TABLE IF EXISTS `new_document`;
CREATE TABLE `new_document`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK 项目文档表(一个项目可以上传多个文档。)',
  `filepath` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'FK 项目编号',
  `filename` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_document
-- ----------------------------

-- ----------------------------
-- Table structure for new_function
-- ----------------------------
DROP TABLE IF EXISTS `new_function`;
CREATE TABLE `new_function`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK  项目功能表',
  `functionname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '功能名称',
  `pid` int(11) NULL DEFAULT NULL COMMENT '功能所属项目',
  `begintime` date NULL DEFAULT NULL COMMENT '功能创建时间',
  `functioninfo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '功能描述',
  `fj` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `fstate` int(10) NULL DEFAULT NULL COMMENT '任务进度',
  `endtime` date NULL DEFAULT NULL COMMENT '结束时间',
  `finishtasktype` int(11) NULL DEFAULT NULL,
  `parentid` int(11) NULL DEFAULT NULL,
  `flag` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_function
-- ----------------------------

-- ----------------------------
-- Table structure for new_function_delrecord
-- ----------------------------
DROP TABLE IF EXISTS `new_function_delrecord`;
CREATE TABLE `new_function_delrecord`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '删除任务记录表',
  `fid` int(11) NULL DEFAULT NULL COMMENT '任务外键字段',
  `flag` int(11) NULL DEFAULT NULL COMMENT '标识字段',
  `deldate` date NULL DEFAULT NULL COMMENT '删除任务时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_function_delrecord
-- ----------------------------

-- ----------------------------
-- Table structure for new_function_record
-- ----------------------------
DROP TABLE IF EXISTS `new_function_record`;
CREATE TABLE `new_function_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '移交任务记录表',
  `fid` int(11) NULL DEFAULT NULL COMMENT '所属任务编号',
  `oldempid` int(11) NULL DEFAULT NULL COMMENT '移交前的任务负责人',
  `newempid` int(11) NULL DEFAULT NULL COMMENT '移交后的任务负责人',
  `turntime` date NULL DEFAULT NULL COMMENT '移交时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_function_record
-- ----------------------------

-- ----------------------------
-- Table structure for new_historyquestion
-- ----------------------------
DROP TABLE IF EXISTS `new_historyquestion`;
CREATE TABLE `new_historyquestion`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK 问题历史记录表',
  `qid` int(11) NULL DEFAULT NULL COMMENT 'FK 问题编号',
  `solver` int(11) NULL DEFAULT NULL COMMENT 'FK 问题解决人',
  `solveresult` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '解决结果',
  `fj` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `solvetime` date NULL DEFAULT NULL COMMENT '解决时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_historyquestion
-- ----------------------------

-- ----------------------------
-- Table structure for new_participator
-- ----------------------------
DROP TABLE IF EXISTS `new_participator`;
CREATE TABLE `new_participator`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK 项目参与人表',
  `pid` int(11) NOT NULL COMMENT 'FK 参与的项目',
  `invitetime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邀请时间',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '邀请内容',
  `inviteemp` int(11) NULL DEFAULT NULL COMMENT 'FK 邀请人',
  `isagree` int(11) NULL DEFAULT NULL COMMENT '是否同意默认为0，1邀请，2邀请成功。',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_participator
-- ----------------------------

-- ----------------------------
-- Table structure for new_prjdept
-- ----------------------------
DROP TABLE IF EXISTS `new_prjdept`;
CREATE TABLE `new_prjdept`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参与部门表',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'FK  项目ID',
  `deptid` int(11) NULL DEFAULT NULL COMMENT 'FK  部门ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_prjdept
-- ----------------------------

-- ----------------------------
-- Table structure for new_prjtresource
-- ----------------------------
DROP TABLE IF EXISTS `new_prjtresource`;
CREATE TABLE `new_prjtresource`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键：任务审批与项目消费记录表',
  `fid` int(20) NULL DEFAULT NULL COMMENT '外键任务id(newtask表)',
  `empid` int(20) NULL DEFAULT NULL COMMENT '提交人id',
  `eid` int(20) NULL DEFAULT NULL COMMENT '审批人id',
  `tplan` int(20) NULL DEFAULT NULL COMMENT '任务进度',
  `subtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_czech_ci NULL DEFAULT NULL COMMENT '办理任务提交的时间',
  `nfj` varchar(500) CHARACTER SET utf8 COLLATE utf8_czech_ci NULL DEFAULT NULL COMMENT '附件',
  `remakes` text CHARACTER SET utf8 COLLATE utf8_czech_ci NULL COMMENT '描述',
  `nmoney` double NULL DEFAULT NULL COMMENT '提交金额',
  `temp1` varchar(200) CHARACTER SET utf8 COLLATE utf8_czech_ci NULL DEFAULT NULL COMMENT '领导评价的信息',
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_czech_ci NULL DEFAULT NULL COMMENT '备用字段2',
  `temp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_czech_ci NULL DEFAULT NULL COMMENT '备用字段3',
  `appstatus` int(11) NULL DEFAULT NULL COMMENT '审批状态。0,3未通过审批，1通过审批，2正在审批',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_czech_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_prjtresource
-- ----------------------------

-- ----------------------------
-- Table structure for new_problem
-- ----------------------------
DROP TABLE IF EXISTS `new_problem`;
CREATE TABLE `new_problem`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK 问题、领导评价表',
  `contents` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '评论内容',
  `empid` int(11) NOT NULL COMMENT 'FK 评论人',
  `time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论时间',
  `problemortask` int(11) NULL DEFAULT NULL COMMENT '属于问题还是任务,1问题，2员工任务，默认是0',
  `isend` int(11) NULL DEFAULT 0 COMMENT '是否结贴 默认是0，1结贴',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'FK 所属项目',
  `count` int(11) NULL DEFAULT NULL COMMENT '评论次数',
  `temp1` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备1',
  `temp2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备2',
  `sid` int(20) NULL DEFAULT NULL COMMENT '便签外键schadulplan',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_problem
-- ----------------------------

-- ----------------------------
-- Table structure for new_project
-- ----------------------------
DROP TABLE IF EXISTS `new_project`;
CREATE TABLE `new_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `projectname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `schedule` int(11) NULL DEFAULT NULL COMMENT '项目进度',
  `projecttype` int(11) NOT NULL COMMENT '项目类型',
  `launcher` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目发起人',
  `begintime` date NOT NULL COMMENT '项目开始时间',
  `endtime` date NOT NULL COMMENT '项目结束时间',
  `projectinfo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '项目描述',
  `approver` int(11) NOT NULL COMMENT '审批人',
  `projectstatus` int(11) NOT NULL DEFAULT 0 COMMENT '项目状态(项目状态有五种状态。默认为0，0立项中，1审批中，2进行中，3已超时，4已结束。)',
  `isdel` int(11) NULL DEFAULT NULL COMMENT '是否删除(默认为0，1已删除)',
  `money` double NULL DEFAULT NULL,
  `temp1` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp4` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_project
-- ----------------------------

-- ----------------------------
-- Table structure for new_question
-- ----------------------------
DROP TABLE IF EXISTS `new_question`;
CREATE TABLE `new_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK 项目问题表',
  `questionname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题名称',
  `quizpeople` int(11) NULL DEFAULT NULL COMMENT 'FK 提出问题人员',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'FK 问题所属项目',
  `lastdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后处理期限',
  `questioninfo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '问题描述',
  `handlestatus` int(11) NULL DEFAULT NULL COMMENT '处理状态 0未提交，1未反馈，2已反馈。',
  `fj` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `indexdemos` int(20) NULL DEFAULT 0 COMMENT '属于问题还是任务,1问题，2员工任务，默认是0',
  `temp1` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用字段1',
  `temp2` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用字段2',
  `temp3` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用字段3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_question
-- ----------------------------

-- ----------------------------
-- Table structure for new_task
-- ----------------------------
DROP TABLE IF EXISTS `new_task`;
CREATE TABLE `new_task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK  项目任务表',
  `fid` int(11) NOT NULL COMMENT 'FK  任务功能ID',
  `execute` int(11) NOT NULL COMMENT 'FK  任务执行人',
  `begintime` date NULL DEFAULT NULL COMMENT '分配任务开始时间',
  `endtime` date NULL DEFAULT NULL COMMENT '分配任务结束时间',
  `schedule` int(11) NULL DEFAULT 0 COMMENT '任务进度',
  `fj` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `temp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用字段,备用日志名称。不用写任何数据',
  `temp1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用字段,备用日志编号。不用写任何数据',
  `flag` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_task
-- ----------------------------

-- ----------------------------
-- Table structure for new_watch
-- ----------------------------
DROP TABLE IF EXISTS `new_watch`;
CREATE TABLE `new_watch`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '项目查着者',
  `pid` int(11) NULL DEFAULT NULL COMMENT 'FK 项目ID',
  `empid` int(11) NULL DEFAULT NULL COMMENT '评价人',
  `suid` int(20) NULL DEFAULT NULL COMMENT '所属**的ID',
  `wdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评价的时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of new_watch
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告表(新portal 袁天龙)',
  `noticeNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告单号',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主题',
  `typeid` int(11) NULL DEFAULT NULL COMMENT '类型',
  `sendTime` date NULL DEFAULT NULL COMMENT '发布时间',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `audtitingFlag` int(11) NULL DEFAULT NULL COMMENT '审核标识(0未审核,1审核通过,2审核失败,3已撤销,8已接收)',
  `draftFlag` int(11) NULL DEFAULT NULL COMMENT '是否存入草稿箱(0不存入，1存入)',
  `isRead` int(11) NULL DEFAULT NULL COMMENT '是否读取(0,未读取/ 1已读取)',
  `startDept` int(11) NULL DEFAULT NULL COMMENT '发起部门id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for notice_dept
-- ----------------------------
DROP TABLE IF EXISTS `notice_dept`;
CREATE TABLE `notice_dept`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告的参与部门(袁天龙)',
  `nid` int(11) NULL DEFAULT NULL COMMENT '公告id',
  `dept` int(11) NULL DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of notice_dept
-- ----------------------------

-- ----------------------------
-- Table structure for operate
-- ----------------------------
DROP TABLE IF EXISTS `operate`;
CREATE TABLE `operate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK,运维表',
  `upserverId` int(11) NULL DEFAULT NULL COMMENT '上架单ID',
  `operateNo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '运维单号',
  `saleorderId` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '销售订单ID',
  `upEmp` int(11) NULL DEFAULT NULL COMMENT '上架员工',
  `uptime` date NULL DEFAULT NULL COMMENT '上架时间',
  `downtime` date NULL DEFAULT NULL COMMENT '下架时间',
  `depotId` int(11) NULL DEFAULT NULL COMMENT '商品所属仓库',
  `serverId` int(100) NULL DEFAULT NULL COMMENT '商品名字',
  `ipAddress` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `cabinet` int(11) NULL DEFAULT NULL COMMENT '机柜',
  `markNum` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机柜柜号',
  `jhj` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交换机',
  `port` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '端口',
  `temp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `housesAndRooms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `saleorder` int(10) NULL DEFAULT NULL,
  `jgh` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of operate
-- ----------------------------

-- ----------------------------
-- Table structure for operationdepartmatch
-- ----------------------------
DROP TABLE IF EXISTS `operationdepartmatch`;
CREATE TABLE `operationdepartmatch`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `typeid` int(20) NULL DEFAULT NULL,
  `departid` int(20) NULL DEFAULT NULL,
  `money` double NULL DEFAULT NULL,
  `creatTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `explaines` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of operationdepartmatch
-- ----------------------------

-- ----------------------------
-- Table structure for operationdepartmatch_copy
-- ----------------------------
DROP TABLE IF EXISTS `operationdepartmatch_copy`;
CREATE TABLE `operationdepartmatch_copy`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `typeid` int(20) NULL DEFAULT NULL,
  `departid` int(20) NULL DEFAULT NULL,
  `money` double NULL DEFAULT NULL,
  `creatTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `explaines` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of operationdepartmatch_copy
-- ----------------------------

-- ----------------------------
-- Table structure for operationemployeematch
-- ----------------------------
DROP TABLE IF EXISTS `operationemployeematch`;
CREATE TABLE `operationemployeematch`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `typeid` int(20) NULL DEFAULT NULL,
  `empid` int(20) NULL DEFAULT NULL,
  `money` double NULL DEFAULT NULL,
  `creatTime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `explaines` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of operationemployeematch
-- ----------------------------

-- ----------------------------
-- Table structure for operationemployeematch_copy
-- ----------------------------
DROP TABLE IF EXISTS `operationemployeematch_copy`;
CREATE TABLE `operationemployeematch_copy`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `typeid` int(20) NULL DEFAULT NULL,
  `empid` int(20) NULL DEFAULT NULL,
  `money` double NULL DEFAULT NULL,
  `creatTime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `explaines` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp` int(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of operationemployeematch_copy
-- ----------------------------

-- ----------------------------
-- Table structure for operationgroup
-- ----------------------------
DROP TABLE IF EXISTS `operationgroup`;
CREATE TABLE `operationgroup`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operId` int(11) NULL DEFAULT NULL,
  `empids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empnames` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creatdate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of operationgroup
-- ----------------------------
INSERT INTO `operationgroup` VALUES (2, 101, '13,', '冷志勇,', '2024-10-29 01:34:49');

-- ----------------------------
-- Table structure for ordertype
-- ----------------------------
DROP TABLE IF EXISTS `ordertype`;
CREATE TABLE `ordertype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型类名称',
  `super_id` int(11) NULL DEFAULT NULL COMMENT '父类id',
  `temp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp4` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp6` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp7` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp8` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp9` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp10` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp11` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp12` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp13` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp14` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp15` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of ordertype
-- ----------------------------
INSERT INTO `ordertype` VALUES (1, '销售订单', NULL, 'xiaoshoudingdan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `ordertype` VALUES (46, 'VPS', NULL, '44545袁琴远', '2012-02-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `ordertype` VALUES (47, 'cdn', NULL, 'dingdan', '2012-02-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `ordertype` VALUES (48, 'CDN订单', NULL, '主要复责CDN', '2012-02-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `ordertype` VALUES (49, '测试', NULL, '测试', '2012-03-14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `ordertype` VALUES (50, 'IDC测试单', NULL, '', '2012-10-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for outbound
-- ----------------------------
DROP TABLE IF EXISTS `outbound`;
CREATE TABLE `outbound`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `allTypeId` int(11) NULL DEFAULT NULL,
  `empID` int(11) NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `outboundNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `depotId` int(11) NULL DEFAULT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auditingState` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_outbound_allType`(`allTypeId`) USING BTREE,
  INDEX `FK_outbound_depot`(`depotId`) USING BTREE,
  INDEX `FK_outbound_employee`(`empID`) USING BTREE,
  CONSTRAINT `FK_outbound_allType` FOREIGN KEY (`allTypeId`) REFERENCES `alltype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_outbound_depot` FOREIGN KEY (`depotId`) REFERENCES `depot` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_outbound_employee` FOREIGN KEY (`empID`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of outbound
-- ----------------------------

-- ----------------------------
-- Table structure for outboundinfo
-- ----------------------------
DROP TABLE IF EXISTS `outboundinfo`;
CREATE TABLE `outboundinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `outboundId` int(11) NULL DEFAULT NULL,
  `productId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_outboundInfo_outboundInfo`(`outboundId`) USING BTREE,
  INDEX `productId`(`productId`) USING BTREE,
  CONSTRAINT `FK_outboundInfo_outboundInfo` FOREIGN KEY (`outboundId`) REFERENCES `outbound` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `outboundinfo_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of outboundinfo
-- ----------------------------

-- ----------------------------
-- Table structure for pagefunction
-- ----------------------------
DROP TABLE IF EXISTS `pagefunction`;
CREATE TABLE `pagefunction`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '页面功能表',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面功能名称',
  `funcitonid` int(11) NULL DEFAULT NULL COMMENT '菜单外键表',
  `linkFunctionPage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接功能页面',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '删除标识',
  `onlyflag` int(11) NULL DEFAULT NULL COMMENT '唯一标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of pagefunction
-- ----------------------------
INSERT INTO `pagefunction` VALUES (38, '新增', 352, NULL, NULL, 0, 1);
INSERT INTO `pagefunction` VALUES (39, '修改', 352, NULL, NULL, 0, 2);

-- ----------------------------
-- Table structure for paymentlog
-- ----------------------------
DROP TABLE IF EXISTS `paymentlog`;
CREATE TABLE `paymentlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Purid` int(11) NULL DEFAULT NULL,
  `defrayMode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PaymentAmount` float NULL DEFAULT NULL,
  `Account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Emp_id` int(11) NULL DEFAULT NULL,
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inputTime` datetime NULL DEFAULT NULL,
  `auditingState` int(11) NOT NULL,
  `gatheringname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bankname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of paymentlog
-- ----------------------------
INSERT INTO `paymentlog` VALUES (1, 1, '现金支付', 2000, '200000000000000000000', 132, '2012-04-03', NULL, '1', 'FK-2012040700008', '2012-04-07 14:04:23', 0, NULL, NULL);
INSERT INTO `paymentlog` VALUES (2, 4, '其他', 500, '6225887839540727', 166, '2012-10-12', NULL, '0', 'FK-2012101200005', '2012-10-12 16:19:22', 0, NULL, NULL);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `PermissionID` int(11) NOT NULL,
  `permissionName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permissionDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PermissionID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of permission
-- ----------------------------

-- ----------------------------
-- Table structure for plans
-- ----------------------------
DROP TABLE IF EXISTS `plans`;
CREATE TABLE `plans`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `task_id` int(11) NULL DEFAULT NULL,
  `status` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isfeedback` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `feedback` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `exp_end_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sbh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '识别号(唯一标识)',
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `plan_task_fk`(`task_id`) USING BTREE,
  CONSTRAINT `plan_ibfk_3` FOREIGN KEY (`task_id`) REFERENCES `mission` (`task_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of plans
-- ----------------------------

-- ----------------------------
-- Table structure for priceregulation
-- ----------------------------
DROP TABLE IF EXISTS `priceregulation`;
CREATE TABLE `priceregulation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modelId` int(11) NULL DEFAULT NULL,
  `importprice` float NULL DEFAULT NULL,
  `saleprice` float NULL DEFAULT NULL,
  `rtime` datetime NULL DEFAULT NULL,
  `delflag` int(11) NULL DEFAULT NULL,
  `empId` int(11) NULL DEFAULT NULL,
  `auditingState` int(11) NULL DEFAULT NULL,
  `priceRegNo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_priceregulation_employee`(`empId`) USING BTREE,
  CONSTRAINT `FK_priceregulation_employee` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of priceregulation
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `propertyId` int(11) NULL DEFAULT NULL,
  `barcode` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `depotId` int(11) NULL DEFAULT NULL,
  `storageInfoId` int(11) NULL DEFAULT NULL,
  `useSum` int(11) NULL DEFAULT NULL,
  `usestate` int(11) NULL DEFAULT NULL COMMENT '使用状态（1.使用，2.未使用，3.入库未审核4.出库未审核）',
  `parentId` int(11) NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_id` int(11) NULL DEFAULT NULL,
  `tmp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isfreeze` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_product_depot`(`parentId`) USING BTREE,
  INDEX `FK_product_property`(`propertyId`) USING BTREE,
  INDEX `FK_product_storageInfo`(`storageInfoId`) USING BTREE,
  INDEX `depotId`(`depotId`) USING BTREE,
  CONSTRAINT `FK_product_property` FOREIGN KEY (`propertyId`) REFERENCES `property` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_product_storageInfo` FOREIGN KEY (`storageInfoId`) REFERENCES `storageinfo` (`storageInfoId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`depotId`) REFERENCES `depot` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of product
-- ----------------------------

-- ----------------------------
-- Table structure for productproperty
-- ----------------------------
DROP TABLE IF EXISTS `productproperty`;
CREATE TABLE `productproperty`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '命名',
  `ordertypeid` int(11) NULL DEFAULT NULL COMMENT '订单类型表id外键',
  `productid` int(11) NULL DEFAULT NULL COMMENT '外键关连产品表',
  `price` float(11, 0) NULL DEFAULT NULL COMMENT '价格',
  `flow` float(11, 0) NULL DEFAULT NULL COMMENT '流量（cdn专用）',
  `bandwidth` float(11, 0) NULL DEFAULT NULL COMMENT '带宽（cdn专用）',
  `hitnum` int(11) NULL DEFAULT NULL COMMENT 'Hti连接数(cdn专用)',
  `temp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` int(11) NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `productproperty_product`(`productid`) USING BTREE,
  INDEX `productproperty_ordertype`(`ordertypeid`) USING BTREE,
  CONSTRAINT `productproperty_ibfk_1` FOREIGN KEY (`ordertypeid`) REFERENCES `ordertype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `productproperty_ibfk_2` FOREIGN KEY (`productid`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of productproperty
-- ----------------------------

-- ----------------------------
-- Table structure for producttype
-- ----------------------------
DROP TABLE IF EXISTS `producttype`;
CREATE TABLE `producttype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of producttype
-- ----------------------------

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prjname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `deptid` int(11) NULL DEFAULT NULL COMMENT '目项所属部门',
  `prjmanager` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目管理人',
  `prjtype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目类型',
  `begintime` date NULL DEFAULT NULL COMMENT '项目开始时间',
  `endtime` date NULL DEFAULT NULL COMMENT '项目结束时间',
  `yjendtime` date NULL DEFAULT NULL COMMENT '预计结束时间',
  `prjplan` int(11) NULL DEFAULT NULL COMMENT '项目进度(默认为0)',
  `leadname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '领导名称',
  `leadevaluate` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '导领评价',
  `prjdes` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '项目描述',
  `prjfunction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '项目功能',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '否是删除(1为删除，0不删除 默认0)',
  `isapproval` int(11) NULL DEFAULT NULL COMMENT '审批',
  `startperson` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发起人',
  `annex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES (1, '项目管理', 30, '潘嫦玲', 'OA', '2012-09-10', '2012-09-25', '2012-09-20', 4, '王雄', '', '每个功能都很重要', '发起项目，项目列表，跟进项目，项目详情。', 0, 0, '冷志勇', '项目管理需要页面.doc');
INSERT INTO `project` VALUES (2, 'OA自动办公系统', 30, '朱传文', 'OA', '2012-09-25', '2012-09-25', '2012-09-25', 1, '冷志勇', '', '321', '123', 0, 0, '袁天龙', '11.txt');
INSERT INTO `project` VALUES (3, 'CDN系统测试布点采购', 29, '张海军', '公司内部采购', '2012-10-07', '2012-10-31', '2012-10-26', 9, '朱传文', '', '具体定向采购：\r\n电信节点：\r\n陕西、四川、重庆、云南、贵州、江苏、浙江、福建\r\n联通节点：\r\n东三省任一节点、南方联通、西南联通、西北联通、华中联通\r\n\r\n采购要求：\r\n1、服务器配置不低于E5200/4G/300G\r\n2、带宽不低于10M；价格不高于500元/月；\r\n3、同时记录100M价格，1G2台的月付价格；\r\n4、安装CENTOS5.5或者5.8系统，64位；\r\n6、系统安装要求简化安装。\r\n7、按以下表张海军负责整理上报\r\n8、运维部门负责完成节点稳定性测试、下载及响应时间测试、覆盖面测试报告。', '第一批全国CDN系统测试用节点采购', 0, 0, '东风', '游戏idc采购-成都机房.doc');

-- ----------------------------
-- Table structure for projectemp
-- ----------------------------
DROP TABLE IF EXISTS `projectemp`;
CREATE TABLE `projectemp`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prjid` int(11) NULL DEFAULT NULL COMMENT '项目编号',
  `empid` int(11) NULL DEFAULT NULL COMMENT '项目参与人员',
  `prjrw` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '项目任务',
  `prjbegintime` date NULL DEFAULT NULL COMMENT '分配项目的开始时间',
  `prjendtime` date NULL DEFAULT NULL COMMENT '分配项目的完成时间',
  `prjyjendtime` date NULL DEFAULT NULL COMMENT '分配项目的预计完成时间',
  `isinvite` int(11) NULL DEFAULT NULL COMMENT '是否发送邀请（０邀请不成功，１发出邀请，２邀请成功）',
  `invite` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '邀请备注',
  `prjempplan` int(11) NULL DEFAULT NULL COMMENT '每个员工执行的项目进度',
  `warn` int(11) NULL DEFAULT NULL COMMENT '预警级别，0绿灯，１黄灯，２红灯',
  `leadname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '领导名称',
  `leadevaluate` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '领导评价',
  `jobdes` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '任务描述',
  `prjuptime` date NULL DEFAULT NULL COMMENT '更新项目的时间',
  `prjvitetime` date NULL DEFAULT NULL COMMENT '邀请参与人员的时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of projectemp
-- ----------------------------
INSERT INTO `projectemp` VALUES (1, 1, 181, '项目列表', '2012-09-25', NULL, '2012-09-25', NULL, NULL, 4, 1, '王雄', '好好好', '速度好快。', '2012-09-25', NULL);
INSERT INTO `projectemp` VALUES (2, 1, 145, NULL, '2012-09-25', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2012-09-25', NULL);
INSERT INTO `projectemp` VALUES (3, 1, 165, NULL, '2012-09-25', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2012-09-25', NULL);
INSERT INTO `projectemp` VALUES (4, 1, 169, NULL, '2012-09-25', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, '2012-09-25', NULL);
INSERT INTO `projectemp` VALUES (5, 1, 178, NULL, NULL, NULL, NULL, 2, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-09-25');
INSERT INTO `projectemp` VALUES (6, 1, 175, 'fdsafds', NULL, NULL, '2012-09-25', 2, NULL, 4, 0, '陈红杏', '魂牵梦萦', 'fdsa', '2012-09-25', '2012-09-25');
INSERT INTO `projectemp` VALUES (7, 2, 165, NULL, '2012-09-25', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-09-25');
INSERT INTO `projectemp` VALUES (8, 2, 171, NULL, '2012-09-25', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-09-25');
INSERT INTO `projectemp` VALUES (9, 3, 145, NULL, '2012-10-07', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-10-07');
INSERT INTO `projectemp` VALUES (10, 3, 166, NULL, '2012-10-07', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-10-07');
INSERT INTO `projectemp` VALUES (11, 3, 100, NULL, '2012-10-07', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-10-07');
INSERT INTO `projectemp` VALUES (12, 3, 140, NULL, '2012-10-07', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-10-07');
INSERT INTO `projectemp` VALUES (13, 3, 119, NULL, '2012-10-07', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-10-07');
INSERT INTO `projectemp` VALUES (14, 3, 154, NULL, '2012-10-07', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-10-07');
INSERT INTO `projectemp` VALUES (15, 3, 134, NULL, '2012-10-07', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-10-07');
INSERT INTO `projectemp` VALUES (16, 3, 124, NULL, '2012-10-07', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '2012-10-07');

-- ----------------------------
-- Table structure for projectemplead
-- ----------------------------
DROP TABLE IF EXISTS `projectemplead`;
CREATE TABLE `projectemplead`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prjempid` int(11) NULL DEFAULT NULL COMMENT '员工任务表编号，外键',
  `leadname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '领导名称',
  `leadevaluate` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '领导评价',
  `pjtime` date NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of projectemplead
-- ----------------------------
INSERT INTO `projectemplead` VALUES (1, 1, '王雄', '好好好', '2012-09-25');
INSERT INTO `projectemplead` VALUES (2, 6, '潘嫦玲', 'fdsa', '2012-09-25');
INSERT INTO `projectemplead` VALUES (3, 6, '潘嫦玲', '魂牵梦萦', '2012-09-25');
INSERT INTO `projectemplead` VALUES (4, 6, '朱稳', '魂牵梦萦', '2012-09-25');
INSERT INTO `projectemplead` VALUES (5, 6, '陈红杏', '魂牵梦萦', '2012-09-25');

-- ----------------------------
-- Table structure for projectlead
-- ----------------------------
DROP TABLE IF EXISTS `projectlead`;
CREATE TABLE `projectlead`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prjid` int(11) NULL DEFAULT NULL COMMENT '项目外键编号',
  `leadname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '领导名称',
  `leadevaluate` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '领导评价',
  `pjtime` date NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of projectlead
-- ----------------------------
INSERT INTO `projectlead` VALUES (1, 1, '冷志勇', '速度快点。', '2012-09-25');
INSERT INTO `projectlead` VALUES (2, 1, '冷志勇', 'sdafdsa', '2012-09-25');
INSERT INTO `projectlead` VALUES (3, 1, '冷志勇', 'fdsafdsa', '2012-09-25');
INSERT INTO `projectlead` VALUES (4, 1, '冷志勇', 'null', '2012-09-25');
INSERT INTO `projectlead` VALUES (5, 1, '东风', 'null', '2012-09-25');
INSERT INTO `projectlead` VALUES (6, 1, '胡宝林', 'null', '2012-09-26');
INSERT INTO `projectlead` VALUES (7, 1, '袁天龙', 'null', '2012-09-26');
INSERT INTO `projectlead` VALUES (8, 1, '袁天龙', 'null', '2012-09-26');
INSERT INTO `projectlead` VALUES (9, 1, '东风', 'null', '2012-09-26');
INSERT INTO `projectlead` VALUES (10, 1, '王雄', 'null', '2012-10-09');
INSERT INTO `projectlead` VALUES (11, 1, '王雄', 'null', '2012-10-09');
INSERT INTO `projectlead` VALUES (12, 1, '王雄', 'null', '2012-10-09');
INSERT INTO `projectlead` VALUES (13, 1, '王雄', 'null', '2012-10-09');
INSERT INTO `projectlead` VALUES (14, 1, '王雄', 'null', '2012-10-09');
INSERT INTO `projectlead` VALUES (15, 1, '朱传文', 'null', '2012-10-12');
INSERT INTO `projectlead` VALUES (16, 1, '周燕', 'null', '2012-10-19');

-- ----------------------------
-- Table structure for property
-- ----------------------------
DROP TABLE IF EXISTS `property`;
CREATE TABLE `property`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `modelId` int(11) NULL DEFAULT NULL,
  `pcode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `specifications` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pprice` float NULL DEFAULT 0,
  `temp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp4` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp5` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp6` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp7` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp8` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp9` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp10` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp11` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp12` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp13` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp14` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp15` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp16` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp17` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp18` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp19` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp20` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `img` varchar(101) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `property_fk2`(`modelId`) USING BTREE,
  CONSTRAINT `property_fk2` FOREIGN KEY (`modelId`) REFERENCES `model` (`model`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of property
-- ----------------------------

-- ----------------------------
-- Table structure for purorder
-- ----------------------------
DROP TABLE IF EXISTS `purorder`;
CREATE TABLE `purorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '采购单id',
  `applyBuyId` int(11) NULL DEFAULT NULL COMMENT '请购单Id(请购单表)',
  `auditingState` int(11) NULL DEFAULT NULL COMMENT '审核标识',
  `supplier_id` int(11) NULL DEFAULT NULL COMMENT '供应商ID',
  `orderTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订货时间',
  `deliveryTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '到货时间',
  `price` float NULL DEFAULT NULL COMMENT '总价格',
  `empID` int(11) NULL DEFAULT NULL COMMENT '接收商品员工',
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除标识',
  `purOrderNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '采购订单号',
  `applyArray` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请数量列表',
  `remarks` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `accountName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `accountType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PurOrder_fk`(`applyBuyId`) USING BTREE,
  INDEX `PurOrder_fk2`(`supplier_id`) USING BTREE,
  INDEX `PurOrder_fk3`(`empID`) USING BTREE,
  CONSTRAINT `PurOrder_fk` FOREIGN KEY (`applyBuyId`) REFERENCES `applybuy` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `PurOrder_fk2` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `PurOrder_fk3` FOREIGN KEY (`empID`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of purorder
-- ----------------------------

-- ----------------------------
-- Table structure for purorderinfo
-- ----------------------------
DROP TABLE IF EXISTS `purorderinfo`;
CREATE TABLE `purorderinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '采购订单详细id',
  `purOrderId` int(11) NULL DEFAULT NULL COMMENT '采购订单id(采购订单表)',
  `modelId` int(11) NULL DEFAULT NULL COMMENT '型号id(型号表)',
  `count` int(11) NULL DEFAULT NULL COMMENT '数量',
  `price` float NULL DEFAULT NULL COMMENT '单价',
  `discount` float NULL DEFAULT NULL COMMENT '折扣',
  `sum` float NULL DEFAULT NULL COMMENT '总和',
  `priceDelflag` int(11) NULL DEFAULT NULL,
  `actualcounnt` int(11) NULL DEFAULT NULL COMMENT '实到数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `FK_purOrderInfo_model`(`modelId`) USING BTREE,
  INDEX `FK_purOrderInfo_purOrder`(`purOrderId`) USING BTREE,
  CONSTRAINT `FK_purOrderInfo_model` FOREIGN KEY (`modelId`) REFERENCES `model` (`model`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_purOrderInfo_purOrder` FOREIGN KEY (`purOrderId`) REFERENCES `purorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of purorderinfo
-- ----------------------------

-- ----------------------------
-- Table structure for questioncategory
-- ----------------------------
DROP TABLE IF EXISTS `questioncategory`;
CREATE TABLE `questioncategory`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '问题类别表',
  `superid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `questionName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '题问名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注备',
  `isAssess` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `superid`(`superid`) USING BTREE,
  CONSTRAINT `questioncategory_ibfk_1` FOREIGN KEY (`superid`) REFERENCES `questioncategory` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 7168 kB; (`superid`) REFER `fajxc/questioncateg' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of questioncategory
-- ----------------------------
INSERT INTO `questioncategory` VALUES (1, NULL, '--请选择--', '--请选择--', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (2, 1, '自由主机', '自由主机', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (3, 1, '虚拟空间', '虚拟空间', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (4, 1, '租用主机', '租用主机', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (5, 1, '托管主机', '托管主机', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (6, 1, 'VPS主机', 'VPS主机', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (7, 1, '代理专区', '代理专区', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (8, 2, '其他', '其他', NULL, '20', NULL, NULL);
INSERT INTO `questioncategory` VALUES (9, 3, '程序预装/调试', '程序预装/调试', NULL, '21', NULL, NULL);
INSERT INTO `questioncategory` VALUES (10, 3, '程序解压/备份', '程序解压/备份', NULL, '22', NULL, NULL);
INSERT INTO `questioncategory` VALUES (11, 3, '数据库导入/导出', '数据库导入/导出', NULL, '23', NULL, NULL);
INSERT INTO `questioncategory` VALUES (12, 3, '域名解析/绑定', '域名解析/绑定', NULL, '24', NULL, NULL);
INSERT INTO `questioncategory` VALUES (14, 3, '非法信息处理协助', '非法信息处理协助', NULL, '25', NULL, NULL);
INSERT INTO `questioncategory` VALUES (15, 3, '网站被挂马协助', '网站被挂马协助', NULL, '26', NULL, NULL);
INSERT INTO `questioncategory` VALUES (16, 3, '空间使用其他协助', '空间使用其他协助', NULL, '27', NULL, NULL);
INSERT INTO `questioncategory` VALUES (17, 3, 'Asp类网站访问报错协助', 'Asp类网站访问报错协助', NULL, '28', NULL, NULL);
INSERT INTO `questioncategory` VALUES (18, 3, 'Net类网站访问报错协助', 'Net类网站访问报错协助', NULL, '209', NULL, NULL);
INSERT INTO `questioncategory` VALUES (19, 3, 'PHP类网站访问报错协助', 'PHP类网站访问报错协助', NULL, '30', NULL, NULL);
INSERT INTO `questioncategory` VALUES (20, 3, 'FTP连接故障申告', 'FTP连接故障申告', NULL, '320', NULL, NULL);
INSERT INTO `questioncategory` VALUES (21, 3, '主机访问故障申告', '主机访问故障申告', NULL, '420', NULL, NULL);
INSERT INTO `questioncategory` VALUES (22, 3, '数据库连接故障申告', '数据库连接故障申告', NULL, '520', NULL, NULL);
INSERT INTO `questioncategory` VALUES (23, 3, '空间解封/关闭申请', '空间解封/关闭申请', NULL, '20', NULL, NULL);
INSERT INTO `questioncategory` VALUES (24, 3, '空间升级/更换申请', '空间升级/更换申请', NULL, '20', NULL, NULL);
INSERT INTO `questioncategory` VALUES (25, 3, '域名备案咨询/协助', '域名备案咨询/协助', NULL, '20', NULL, NULL);
INSERT INTO `questioncategory` VALUES (26, 3, '产品咨询', '产品咨询', NULL, '20', NULL, NULL);
INSERT INTO `questioncategory` VALUES (27, 3, '其他', '其他', NULL, '20', NULL, NULL);
INSERT INTO `questioncategory` VALUES (28, 4, '协助重启4', '协助重启', NULL, '20', NULL, NULL);
INSERT INTO `questioncategory` VALUES (29, 4, '系统重装', '系统重装', NULL, '20', NULL, NULL);
INSERT INTO `questioncategory` VALUES (30, 4, '密码破解', '密码破解', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (31, 4, '无法远程协助', '无法远程协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (32, 4, '环境配置协助', '环境配置协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (33, 4, '主机使用其他协助', '主机使用其他协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (34, 4, 'WEB环境故障协助', 'WEB环境故障协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (35, 4, '系统安全协助', '系统安全协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (36, 4, '屏蔽端口/IP协助', '屏蔽端口/IP协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (37, 4, '主机解封申请', '主机解封申请', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (38, 4, '主机升级', '主机升级', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (39, 4, '域名白名单协助', '域名白名单协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (40, 4, '域名备案咨询/协助', '域名备案咨询/协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (41, 4, '产品咨询', '产品咨询', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (42, 4, '其他', '其他', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (43, 5, '协助重启5', '协助重启', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (44, 5, '系统重装', '系统重装', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (45, 5, '密码破解', '密码破解', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (46, 5, '环境配置协助', '环境配置协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (47, 5, '主机其他协助', '主机其他协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (48, 5, 'WEB环境故障协助', 'WEB环境故障协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (49, 5, '系统安全协助', '系统安全协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (50, 5, '屏蔽端口/IP协助', '屏蔽端口/IP协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (51, 5, '主机解封申请', '主机解封申请', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (52, 5, '主机硬件添加/更换', '主机硬件添加/更换', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (53, 5, '托管机器上架/发回', '托管机器上架/发回', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (54, 5, '域名白名单协助', '域名白名单协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (55, 5, '域名备案咨询/协助', '域名备案咨询/协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (56, 5, '产品咨询', '产品咨询', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (57, 5, '其他', '其他', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (58, 6, '协助重启6', '协助重启', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (59, 6, '系统重装', '系统重装', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (60, 6, '密码破解', '密码破解', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (61, 6, '无法远程协助', '无法远程协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (62, 6, '环境配置协助', '环境配置协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (63, 6, '主机其他协助', '主机其他协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (64, 6, 'WEB环境故障协助', 'WEB环境故障协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (65, 6, '系统安全协助', '系统安全协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (66, 6, '屏蔽端口/IP协助', '屏蔽端口/IP协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (67, 6, '主机解封申请', '主机解封申请', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (68, 6, '主机升级', '主机升级', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (69, 6, '域名白名单协助', '域名白名单协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (70, 6, '域名备案咨询/协助', '域名备案咨询/协助', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (71, 6, '产品咨询', '产品咨询', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (72, 6, '其他', '其他', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (73, 7, '代理平台故障', '代理平台故障', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (74, 7, '其他', '其他', 'N', '500', NULL, NULL);
INSERT INTO `questioncategory` VALUES (76, 3, '虚礼空间下', '没有用的', 'N', '200', NULL, NULL);
INSERT INTO `questioncategory` VALUES (77, 1, '客户测试', '客户测试', NULL, NULL, NULL, NULL);
INSERT INTO `questioncategory` VALUES (78, 1, '代理测试', '代理测试', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for realmtype
-- ----------------------------
DROP TABLE IF EXISTS `realmtype`;
CREATE TABLE `realmtype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名',
  `temp` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段',
  `temp1` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delFlag` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of realmtype
-- ----------------------------
INSERT INTO `realmtype` VALUES (1, '纯静态', '#jingtai', 'null client.leccnet.com client.leccnet.com client.leccnet.com client.leccnet.com client.leccnet.com client.leccnet.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.com www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net www.30.net client.leccnet.com client.leccnet.com client.leccnet.com client.leccnet.com www.xuyuan.cesi www.xuyuan.cesi', 0);
INSERT INTO `realmtype` VALUES (2, '动态含静态', '#dong_jing', 'www.dzxw.net dzxw.net www.youku.com www.youku.com www.youku.com www.baidu.com www.baidu.com www.29.com www.29.com www.29.com www.29.com www.29.com www.29.com www.29.com www.29.com www.29.com www.29.com www.29.com www.29.com www.29.com www.baidu.com', 0);
INSERT INTO `realmtype` VALUES (3, '纯动态', '#dongtai', 'www2.zjbdt.com', 0);
INSERT INTO `realmtype` VALUES (4, '下载', '#download', 'bbs.verypsp.com', 0);
INSERT INTO `realmtype` VALUES (5, '论坛伪静态', '#bbs_rewrite', 'bbs.verypsp.com', 0);
INSERT INTO `realmtype` VALUES (6, '纯静态', '#jingtai', NULL, 1);

-- ----------------------------
-- Table structure for rechargelog
-- ----------------------------
DROP TABLE IF EXISTS `rechargelog`;
CREATE TABLE `rechargelog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户充值记录',
  `customerId` int(11) NULL DEFAULT NULL COMMENT '客户ID',
  `rechargeTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '充值时间',
  `rechargemonery` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '充值金额',
  `orderno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `balanc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '余额',
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customerId`(`customerId`) USING BTREE,
  CONSTRAINT `rechargeLog_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of rechargelog
-- ----------------------------

-- ----------------------------
-- Table structure for refundmentlog
-- ----------------------------
DROP TABLE IF EXISTS `refundmentlog`;
CREATE TABLE `refundmentlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientOrderNum` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `saleOrderid` int(11) NULL DEFAULT NULL,
  `Emp_id` int(11) NULL DEFAULT NULL,
  `account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `returnReason` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `returnTime` datetime NULL DEFAULT NULL,
  `returnLimitTime` datetime NULL DEFAULT NULL,
  `returnId` int(11) NULL DEFAULT NULL,
  `money` float NULL DEFAULT NULL,
  `approvePresonId` int(11) NULL DEFAULT NULL,
  `approveTime` datetime NULL DEFAULT NULL,
  `approveState` int(11) NULL DEFAULT NULL,
  `financingId` int(11) NULL DEFAULT NULL,
  `financingState` int(11) NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `emp_reundement_approvePresonId`(`approvePresonId`) USING BTREE,
  INDEX `emp_reundement_financingId`(`financingId`) USING BTREE,
  INDEX `emp_reundement_returnId`(`returnId`) USING BTREE,
  INDEX `refundmentLog_fk`(`saleOrderid`) USING BTREE,
  INDEX `refundmentLog_fk2`(`Emp_id`) USING BTREE,
  CONSTRAINT `emp_reundement_approvePresonId` FOREIGN KEY (`approvePresonId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `emp_reundement_financingId` FOREIGN KEY (`financingId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `emp_reundement_returnId` FOREIGN KEY (`returnId`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `refundmentLog_fk` FOREIGN KEY (`saleOrderid`) REFERENCES `saleorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `refundmentLog_fk2` FOREIGN KEY (`Emp_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of refundmentlog
-- ----------------------------

-- ----------------------------
-- Table structure for renewlog
-- ----------------------------
DROP TABLE IF EXISTS `renewlog`;
CREATE TABLE `renewlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) NULL DEFAULT NULL,
  `orderEndTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `renewTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `renewMoner` float NULL DEFAULT NULL,
  `nextRenewTime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `financeaffirm` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `affirmemp` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inputTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inputAdmin` int(11) NULL DEFAULT NULL,
  `del` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_renewLog_saleOrder`(`orderid`) USING BTREE,
  CONSTRAINT `FK_renewLog_saleOrder` FOREIGN KEY (`orderid`) REFERENCES `saleorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of renewlog
-- ----------------------------

-- ----------------------------
-- Table structure for returnorder
-- ----------------------------
DROP TABLE IF EXISTS `returnorder`;
CREATE TABLE `returnorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purReturnNO` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `purOrderId` int(11) NOT NULL,
  `toOrderId` int(11) NOT NULL,
  `returnTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `returnStyle` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `returnReason` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `returnDescription` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `returnTimeLimit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplierId` int(11) NOT NULL,
  `payappoint` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isBilling` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `billingType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payAppointType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `paytraffic` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trafficOrdernum` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `orderGross` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trafficcompany` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trafficLinkman` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trafficphone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `grossmoney` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transacter` int(11) NULL DEFAULT NULL,
  `transactdept` int(11) NULL DEFAULT NULL,
  `delflag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `buytype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `returnOrderVerify` int(11) NULL DEFAULT NULL,
  `isReturn` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK__returnOrd__purOr__1E3A7A34`(`purOrderId`) USING BTREE,
  INDEX `FK__returnOrd__toOrd__0662F0A311`(`toOrderId`) USING BTREE,
  INDEX `FK__returnOrd__suppl__1D4655`(`supplierId`) USING BTREE,
  INDEX `FK__returnOrd__trans__26CFC035`(`transactdept`) USING BTREE,
  INDEX `FK__returnOrd__trans__27C3E46E`(`transacter`) USING BTREE,
  CONSTRAINT `FK__returnOrd__purOr__1E3A7A34` FOREIGN KEY (`purOrderId`) REFERENCES `purorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK__returnOrd__suppl__1D4655` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK__returnOrd__toOrd__0662F0A311` FOREIGN KEY (`toOrderId`) REFERENCES `toorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK__returnOrd__trans__26CFC035` FOREIGN KEY (`transactdept`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK__returnOrd__trans__27C3E46E` FOREIGN KEY (`transacter`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 3072 kB; (`supplierId`) REFER `fajxc/supplier`(' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of returnorder
-- ----------------------------

-- ----------------------------
-- Table structure for returnorderinfo
-- ----------------------------
DROP TABLE IF EXISTS `returnorderinfo`;
CREATE TABLE `returnorderinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `returnOrderId` int(11) NULL DEFAULT NULL,
  `batchexpId` int(11) NULL DEFAULT NULL,
  `modeId` int(11) NULL DEFAULT NULL,
  `count` int(11) NULL DEFAULT NULL,
  `returnprice` float NULL DEFAULT NULL,
  `discount` float NULL DEFAULT NULL,
  `sum` float NULL DEFAULT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of returnorderinfo
-- ----------------------------

-- ----------------------------
-- Table structure for role_function_info
-- ----------------------------
DROP TABLE IF EXISTS `role_function_info`;
CREATE TABLE `role_function_info`  (
  `Role_function_id` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `functionIDs` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `permissions` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Role_function_id`) USING BTREE,
  INDEX `FK__Role_Func__UserI__57DD0BE4`(`UserID`) USING BTREE,
  CONSTRAINT `FK__Role_Func__UserI__57DD0BE4` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of role_function_info
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `RoleID` int(11) NOT NULL AUTO_INCREMENT,
  `SuperID` int(11) NOT NULL,
  `roleName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Role_function_id` int(11) NOT NULL,
  `createTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Roledescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `functionIDs` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `permissions` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`RoleID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 0, '管理员', 0, '2011-07-11 00:00:0', 'sds', '', '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,10,15,16,11,17,22,117,12,21,114,115,116,330,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,198,199,200,201,202,203,205,206,8,100,103,104,105,106,107,207,208,209,274,275,276,311,101,252,253,254,257,258,259,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,263.1,263.2,263.3,263.4,264.1,264.2,264.3,264.4,265.1,265.2,265.3,265.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,272.1,272.2,272.3,272.4,273.1,273.2,273.3,273.4,278.1,278.2,278.3,278.4,296.1,296.2,296.3,296.4,297.1,297.2,297.3,297.4,298.1,298.2,298.3,298.4,299.1,299.2,299.3,299.4,288.1,288.2,288.3,288.4,289.1,289.2,289.3,289.4,290.1,290.2,290.3,290.4,294.1,294.2,294.3,294.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,300.1,300.2,300.3,300.4,320.1,320.2,320.3,320.4,304.1,304.2,304.3,304.4,305.1,305.2,305.3,305.4,306.1,306.2,306.3,306.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,331.1,331.2,331.3,331.4,332.1,332.2,332.3,332.4,333.1,333.2,333.3,333.4,334.1,334.2,334.3,335.1,335.2,335.3,335.4,336.1,336.2,336.3,336.4,337.1,337.2,337.3,337.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,255.1,255.2,255.3,255.4,256.1,256.2,256.3,256.4,13.1,13.2,13.3,13.4,14.1,14.2,14.3,14.4,307.1,307.2,307.3,307.4,15.1,15.2,15.3,15.4,16.1,16.2,16.3,16.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,21.1,21.2,21.3,21.4,115.1,115.2,115.3,115.4,116.1,116.2,116.3,116.4,330.1,330.2,330.3,330.4,39.1,39.2,39.3,39.4,40.1,40.2,40.3,40.4,41.1,41.2,41.3,41.4,42.1,42.2,42.3,42.4,315.1,315.2,315.3,315.4,316.1,316.2,316.3,316.4,324.1,324.2,324.3,324.4,326.1,326.2,326.3,326.4,51.1,51.2,51.3,51.4,52.1,52.2,52.3,52.4,118.1,118.2,118.3,118.4,53.1,53.2,53.3,53.4,54.1,54.2,54.3,54.4,140.1,140.2,140.3,140.4,143.1,143.2,143.3,143.4,144.1,144.2,144.3,144.4,56.1,56.2,56.3,56.4,145.1,145.2,145.3,145.4,57.1,57.2,57.3,57.4,65.1,65.2,65.3,65.4,66.1,66.2,66.3,66.4,69.1,69.2,69.3,69.4,161.1,161.2,161.3,161.4,73.1,73.2,73.3,73.4,74.1,74.2,74.3,74.4,75.1,75.2,75.3,75.4,76.1,76.2,76.3,76.4,');
INSERT INTO `roles` VALUES (2, 1, '销售人员', 0, '2011-07-11 00:00:0', '', '', '260,262,267,268,269,270,312,271,272,273,285,288,289,291,292,293,308,309,310,295,303,305,317,318,319,243,244,245,246,247,248,249,251,1,10,15,16,11,17,22,117,3,47,54,140,4,60,73,74,75,5,83,86,174,242,84,87,88,85,89,181,182,183,176,177,178,179,180,184,185,186,191,192,193,8,101,', '262.1,262.4,268.1,268.2,268.4,269.1,269.2,269.4,270.1,270.2,270.4,312.1,312.2,312.3,312.4,272.1,272.2,272.4,273.1,273.2,273.4,288.1,288.4,289.1,289.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,305.1,305.2,305.3,305.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,245.1,245.2,246.1,246.2,247.1,247.2,248.1,248.2,15.1,15.2,15.3,16.1,16.2,16.3,16.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,54.1,54.2,54.3,54.4,140.2,140.3,140.4,73.4,74.4,75.4,82.4,86.1,86.2,86.3,86.4,174.1,174.4,242.1,242.2,242.3,242.4,87.4,88.4,89.4,182.1,182.4,183.1,183.4,178.1,178.2,178.4,179.1,179.2,179.4,180.1,180.2,180.4,241.4,193.4,');
INSERT INTO `roles` VALUES (3, 1, '运维人员', 0, '2011-07-11 00:00:0', 'sdds', '', '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,339,340,338,342,343,344,345,346,347,348,357,358,349,350,438,442,443,444,445,446,447,439,448,449,450,451,452,453,440,454,455,456,459,460,441,457,458,461,462,463,464,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,356,10,15,16,11,17,22,117,12,21,114,115,116,330,353,354,355,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,341,198,199,200,201,202,203,205,206,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,351,352,101,252,253,254,257,258,259,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,263.1,263.2,263.3,263.4,264.1,264.2,264.3,264.4,265.1,265.2,265.3,265.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,272.1,272.2,272.3,272.4,273.1,273.2,273.3,273.4,278.1,278.2,278.3,278.4,296.1,296.2,296.3,296.4,297.1,297.2,297.3,297.4,298.1,298.2,298.3,298.4,299.1,299.2,299.3,299.4,288.1,288.2,288.3,288.4,289.1,289.2,289.3,289.4,290.1,290.2,290.3,290.4,294.1,294.2,294.3,294.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,300.1,300.2,300.3,300.4,320.1,320.2,320.3,320.4,304.1,304.2,304.3,304.4,305.1,305.2,305.3,305.4,306.1,306.2,306.3,306.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,331.1,331.2,331.3,331.4,332.1,332.2,332.3,332.4,333.1,333.2,333.3,333.4,334.1,334.2,334.3,334.4,335.1,335.2,335.3,335.4,336.1,336.2,336.3,336.4,337.1,337.2,337.3,337.4,339.1,339.2,339.3,339.4,340.1,340.2,340.3,340.4,343.1,343.2,343.3,343.4,345.1,345.2,345.3,345.4,346.1,346.2,346.3,346.4,347.1,347.2,347.3,347.4,348.1,348.2,348.3,348.4,358.1,358.2,358.3,358.4,350.1,350.2,350.3,350.4,443.1,443.2,443.3,443.4,444.1,444.2,444.3,444.4,447.1,447.2,447.3,447.4,449.1,449.2,449.3,449.4,450.1,450.2,450.3,450.4,451.1,451.2,451.3,451.4,452.1,452.2,452.3,452.4,454.1,454.2,454.3,454.4,459.1,459.2,459.3,459.4,460.1,460.2,460.3,460.4,457.1,457.2,457.3,457.4,458.1,458.2,458.3,458.4,462.1,462.2,462.3,462.4,463.1,463.2,463.3,463.4,464.1,464.2,464.3,464.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,255.1,255.2,255.3,255.4,256.1,256.2,256.3,256.4,13.1,13.2,13.3,13.4,14.1,14.2,14.3,14.4,307.1,307.2,307.3,307.4,356.1,356.2,356.3,356.4,15.1,15.2,15.3,15.4,16.1,16.2,16.3,16.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,21.1,21.2,21.3,21.4,115.1,115.2,115.3,115.4,116.1,116.2,116.3,116.4,330.1,330.2,330.3,330.4,354.1,354.2,354.3,354.4,355.1,355.2,355.3,355.4,39.1,39.2,39.3,39.4,40.1,40.2,40.3,40.4,41.1,41.2,41.3,41.4,42.1,42.2,42.3,42.4,315.1,315.2,315.3,315.4,316.1,316.2,316.3,316.4,324.1,324.2,324.3,324.4,326.1,326.2,326.3,326.4,51.1,51.2,51.3,51.4,52.1,52.2,52.3,52.4,118.1,118.2,118.3,118.4,53.1,53.2,53.3,53.4,54.1,54.2,54.3,54.4,140.1,140.2,140.3,140.4,143.1,143.2,143.3,143.4,144.1,144.2,144.3,144.4,56.1,56.2,56.3,56.4,145.1,145.2,145.3,145.4,57.1,57.2,57.3,57.4,65.1,65.2,65.3,65.4,66.1,66.2,66.3,66.4,69.1,69.2,69.3,69.4,161.1,161.2,161.3,161.4,73.1,73.2,73.3,73.4,74.1,74.2,74.3,74.4,75.1,75.2,75.3,75.4,76.1,76.2,76.3,76.4,77.1,77.2,77.3,77.4,78.1,78.2,78.3,78.4,79.1,79.2,79.3,79.4,81.1,81.2,81.3,81.4,82.1,82.2,82.3,82.4,212.1,212.2,212.3,212.4,302.1,302.2,302.3,302.4,321.1,321.2,321.3,321.4,322.1,322.2,322.3,322.4,86.1,86.2,86.3,86.4,174.1,174.2,174.3,174.4,242.1,242.2,242.3,242.4,87.1,87.2,87.3,87.4,88.1,88.2,88.3,88.4,89.1,89.2,89.3,89.4,175.1,175.2,175.3,175.4,182.1,182.2,182.3,182.4,183.1,183.2,183.3,183.4,188.1,188.2,188.3,188.4,189.1,189.2,189.3,189.4,96.1,96.2,96.3,96.4,97.1,97.2,97.3,97.4,109.1,109.2,109.3,109.4,110.1,110.2,110.3,110.4,178.1,178.2,178.3,178.4,179.1,179.2,179.3,179.4,180.1,180.2,180.3,180.4,241.1,241.2,241.3,241.4,185.1,185.2,185.3,185.4,186.1,186.2,186.3,186.4,301.1,301.2,301.3,301.4,193.1,193.2,193.3,193.4,194.1,194.2,194.3,194.4,341.1,341.2,341.3,341.4,199.1,199.2,199.3,199.4,200.1,200.2,200.3,200.4,202.1,202.2,202.3,202.4,203.1,203.2,203.3,203.4,206.1,206.2,206.3,206.4,328.1,328.2,328.3,328.4,329.1,329.2,329.3,329.4,103.1,103.2,103.3,103.4,104.1,104.2,104.3,104.4,105.1,105.2,105.3,105.4,106.1,106.2,106.3,106.4,107.1,107.2,107.3,107.4,208.1,208.2,208.3,208.4,209.1,209.2,209.3,209.4,275.1,275.2,275.3,275.4,276.1,276.2,276.3,276.4,311.1,311.2,311.3,311.4,351.1,351.2,351.3,351.4,352.1,352.2,352.3,352.4,101.1,101.2,101.3,101.4,253.1,253.2,253.3,253.4,254.1,254.2,254.3,254.4,258.1,258.2,258.3,258.4,259.1,259.2,259.3,259.4,');
INSERT INTO `roles` VALUES (4, 2, '客户', 0, '2011-07-11 00:00:0', 'kehu', '', '267,268,269,270,271,273,243,244,246,247,248,249,2,33,42,5,83,86,174,84,87,88,191,205,206,8,101,', '268.1,268.2,268.4,269.1,269.2,269.4,270.1,270.2,270.4,273.1,273.4,246.1,246.2,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,42.3,42.4,86.1,86.2,86.3,86.4,174.1,174.2,174.3,174.4,206.3,206.4,101.1,101.2,101.3,101.4,');
INSERT INTO `roles` VALUES (17, 4, '试用客户', 0, '2011-07-28 18:45:58', '试用产品的客户', '', '2,33,42,5,83,86,174,84,87,88,191,205,206,8,101,', '42.1,42.2,42.3,42.4,86.1,86.2,86.3,86.4,174.1,174.2,174.3,174.4,87.1,87.2,87.3,87.4,88.1,88.2,88.3,88.4,206.4,101.1,101.2,101.3,101.4,');
INSERT INTO `roles` VALUES (27, 1, '超级管理员', 0, '2011-09-15 10:45:10', '', '', '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,10,15,16,11,17,22,117,12,21,114,115,116,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,198,199,200,201,202,203,205,206,8,100,103,104,105,106,107,207,208,209,274,275,276,311,101,252,253,254,257,258,259,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,263.1,263.2,263.3,263.4,264.1,264.2,264.3,264.4,265.1,265.2,265.3,265.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,272.1,272.2,272.3,272.4,273.1,273.2,273.3,273.4,278.1,278.2,278.3,278.4,296.1,296.2,296.3,296.4,297.1,297.2,297.3,297.4,298.1,298.2,298.3,298.4,299.1,299.2,299.3,299.4,288.1,288.2,288.3,288.4,289.1,289.2,289.3,289.4,290.1,290.2,290.3,290.4,294.1,294.2,294.3,294.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,300.1,300.2,300.3,300.4,320.1,320.2,320.3,320.4,304.1,304.2,304.3,304.4,305.1,305.2,305.3,305.4,306.1,306.2,306.3,306.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,331.1,331.2,331.3,331.4,332.1,332.2,332.3,332.4,333.1,333.3,333.4,334.1,334.2,334.3,334.4,335.1,335.2,335.3,335.4,336.1,336.2,336.3,336.4,337.1,337.2,337.3,337.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,255.1,255.2,255.3,255.4,256.1,256.2,256.3,256.4,13.1,13.2,13.3,13.4,14.1,14.2,14.3,14.4,307.1,307.2,307.3,307.4,15.1,15.2,15.3,15.4,16.1,16.2,16.3,16.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,21.1,21.2,21.3,21.4,115.1,115.2,115.3,115.4,116.1,116.2,116.3,116.4,39.1,39.2,39.3,39.4,40.1,40.2,40.3,40.4,41.1,41.2,41.3,41.4,42.1,42.2,42.3,42.4,315.1,315.2,315.3,315.4,316.1,316.2,316.3,316.4,324.1,324.2,324.3,324.4,326.1,326.2,326.3,326.4,51.1,51.2,51.3,51.4,52.1,52.2,52.3,52.4,118.1,118.2,118.3,118.4,53.1,53.2,53.3,53.4,54.1,54.2,54.3,54.4,140.1,140.2,140.3,140.4,143.1,143.2,143.3,143.4,144.1,144.2,144.3,144.4,56.1,56.2,56.3,56.4,145.1,145.2,145.3,145.4,57.1,57.2,57.3,57.4,65.1,65.2,65.3,65.4,66.1,66.2,66.3,66.4,69.1,69.2,69.3,69.4,161.1,161.2,161.3,161.4,73.1,73.2,73.3,73.4,74.1,74.2,74.3,74.4,75.1,75.2,75.3,75.4,76.1,76.2,76.3,76.4,77.1,77.2,77.3,77.4,78.1,78.2,78.3,78.4,79.1,79.2,79.3,79.4,81.1,81.2,81.3,81.4,82.1,82.2,82.3,82.4,212.1,212.2,212.3,212.4,302.1,302.2,302.3,302.4,321.1,321.2,321.3,321.4,322.1,322.2,322.3,322.4,86.1,86.2,86.3,86.4,174.1,174.2,174.3,174.4,242.1,242.2,242.3,242.4,87.1,87.2,87.3,87.4,88.1,88.2,88.3,88.4,89.1,89.2,89.3,89.4,175.1,175.2,175.3,175.4,182.1,182.2,182.3,182.4,183.1,183.2,183.3,183.4,188.1,188.2,188.3,188.4,189.1,189.2,189.3,189.4,96.1,96.2,96.3,96.4,97.1,97.2,97.3,97.4,109.1,109.2,109.3,109.4,110.1,110.2,110.3,110.4,178.1,178.2,178.3,178.4,179.1,179.2,179.3,179.4,180.1,180.2,180.3,180.4,241.1,241.2,241.3,241.4,185.1,185.2,185.3,185.4,186.1,186.2,186.3,186.4,301.1,301.2,301.3,301.4,193.1,193.2,193.3,193.4,194.1,194.2,194.3,194.4,199.1,199.2,199.3,199.4,200.1,200.2,200.3,200.4,202.1,202.2,202.3,202.4,203.1,203.2,203.3,203.4,206.1,206.2,206.3,206.4,103.1,103.2,103.3,103.4,104.1,104.2,104.3,104.4,105.1,105.2,105.3,105.4,106.1,106.2,106.3,106.4,107.1,107.2,107.3,107.4,208.1,208.2,208.3,208.4,209.1,209.2,209.3,209.4,275.1,275.2,275.3,275.4,276.1,276.2,276.3,276.4,311.1,311.2,311.3,311.4,101.1,101.2,101.3,101.4,253.1,253.2,253.3,253.4,254.1,254.2,254.3,254.4,258.1,258.2,258.3,258.4,259.1,259.2,259.3,259.4,');
INSERT INTO `roles` VALUES (28, 1, '销售主管', 0, '2011-10-31 17:36:10', 'sdf', NULL, '260,261,262,266,267,268,269,270,285,288,289,291,292,293,308,309,310,295,303,305,317,318,319,243,244,245,246,247,248,249,250,1,9,13,307,11,17,22,117,176,177,178,179,180,241,191,205,206,8,101,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,288.1,288.4,289.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,305.1,305.2,305.3,305.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,13.1,13.2,13.4,307.1,307.2,307.3,307.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,178.1,178.2,178.3,178.4,179.1,179.2,179.3,179.4,180.1,180.2,180.3,180.4,241.1,241.2,241.3,241.4,206.4,');
INSERT INTO `roles` VALUES (29, 1, '财务', 0, '2011-12-12 17:52:25', '', NULL, '267,268,269,270,312,291,292,293,308,309,310,295,300,317,318,319,1,9,13,14,307,11,17,22,117,2,32,39,40,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,8,101,', '268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,300.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,13.1,13.2,13.3,13.4,14.1,14.2,14.3,14.4,307.1,307.2,307.3,307.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,39.1,39.2,39.3,39.4,40.1,40.2,40.3,40.4,41.1,41.2,41.3,41.4,42.1,42.2,42.3,42.4,315.1,315.2,315.3,315.4,316.1,316.2,316.3,316.4,324.1,324.2,324.3,324.4,326.1,326.2,326.3,326.4,51.1,51.2,51.3,51.4,52.1,52.2,52.3,52.4,118.1,118.2,118.3,118.4,53.1,53.2,53.3,53.4,54.1,54.2,54.3,54.4,140.1,140.2,140.3,140.4,143.1,143.2,143.3,143.4,144.1,144.2,144.3,144.4,56.1,56.2,56.3,56.4,145.1,145.2,145.3,145.4,57.1,57.2,57.3,57.4,101.1,101.2,101.3,101.4,');
INSERT INTO `roles` VALUES (30, 1, '运维主管', 0, '2011-12-12 17:53:57', '', NULL, '260,261,262,263,264,265,266,267,268,269,270,271,272,273,277,299,291,292,293,308,309,310,295,303,306,243,244,245,246,247,248,250,1,9,14,11,17,22,117,4,58,65,66,59,69,161,60,73,74,75,63,81,64,82,302,321,322,5,83,174,242,84,87,88,85,89,175,7,109,110,176,177,178,179,180,241,191,192,193,198,199,8,101,252,253,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,265.3,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,272.1,272.2,272.3,272.4,273.1,273.2,273.3,273.4,299.1,299.2,299.3,299.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,306.1,306.2,306.3,306.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,14.1,14.2,14.3,14.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,65.1,65.2,65.3,65.4,66.1,66.2,66.3,66.4,69.1,69.2,69.3,69.4,161.1,161.2,161.3,161.4,73.1,73.2,73.3,73.4,74.1,74.2,74.3,74.4,75.1,75.2,75.3,75.4,81.1,81.2,81.3,81.4,82.1,82.2,82.3,82.4,302.1,302.2,302.3,302.4,321.1,321.2,321.3,321.4,322.1,322.2,322.3,322.4,174.1,174.2,174.3,174.4,242.1,242.2,242.3,242.4,87.4,88.4,89.1,89.2,89.3,89.4,175.1,175.2,175.3,175.4,109.1,109.2,109.3,109.4,110.1,110.2,110.3,110.4,178.1,178.2,178.3,178.4,179.1,179.2,179.3,179.4,180.1,180.2,180.3,180.4,241.1,241.2,241.3,241.4,193.1,193.2,193.3,193.4,199.1,199.2,199.3,199.4,');
INSERT INTO `roles` VALUES (31, 1, '技术部', 0, '2011-12-18 14:43:40', '', NULL, '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,339,340,338,342,343,344,345,346,347,348,357,358,349,350,438,442,443,444,445,446,447,439,448,449,450,451,452,453,440,454,455,456,459,460,441,457,458,461,462,463,464,468,469,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,356,10,15,16,11,17,22,117,12,21,114,115,116,330,353,354,355,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,341,198,199,200,201,202,203,205,206,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,351,352,101,252,253,254,257,258,259,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,263.1,263.2,263.3,263.4,264.1,264.2,264.3,264.4,265.1,265.2,265.3,265.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,272.1,272.2,272.3,272.4,273.1,273.2,273.3,273.4,278.1,278.2,278.3,278.4,296.1,296.2,296.3,296.4,297.1,297.2,297.3,297.4,298.1,298.2,298.3,298.4,299.1,299.2,299.3,299.4,288.1,288.2,288.3,288.4,289.1,289.2,289.3,289.4,290.1,290.2,290.3,290.4,294.1,294.2,294.3,294.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,300.1,300.2,300.3,300.4,320.1,320.2,320.3,320.4,304.1,304.2,304.3,304.4,305.1,305.2,305.3,305.4,306.1,306.2,306.3,306.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,331.1,331.2,331.3,331.4,332.1,332.2,332.3,332.4,333.1,333.2,333.3,333.4,334.1,334.2,334.3,334.4,335.1,335.2,335.3,335.4,336.1,336.2,336.3,336.4,337.1,337.2,337.3,337.4,339.1,339.2,339.3,339.4,340.1,340.2,340.3,340.4,343.1,343.2,343.3,343.4,345.1,345.2,345.3,345.4,346.1,346.2,346.3,346.4,347.1,347.2,347.3,347.4,348.1,348.2,348.3,348.4,358.1,358.2,358.3,358.4,350.1,350.2,350.3,350.4,442.1,442.2,442.3,442.4,443.1,443.2,443.3,443.4,444.1,444.2,444.3,444.4,445.1,445.2,445.3,445.4,447.1,447.2,447.3,447.4,449.1,449.2,449.3,449.4,450.1,450.2,450.3,450.4,451.1,451.2,451.3,451.4,452.1,452.2,452.3,452.4,454.1,454.2,454.3,454.4,459.1,459.2,459.3,459.4,460.1,460.2,460.3,460.4,457.1,457.2,457.3,457.4,458.1,458.2,458.3,458.4,462.1,462.2,462.3,462.4,463.1,463.2,463.3,463.4,464.1,464.2,464.3,464.4,468.1,468.2,468.3,468.4,469.1,469.2,469.3,469.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,255.1,255.2,255.3,255.4,256.1,256.2,256.3,256.4,13.1,13.2,13.3,13.4,14.1,14.2,14.3,14.4,307.1,307.2,307.3,307.4,356.1,356.2,356.3,356.4,15.1,15.2,15.3,15.4,16.1,16.2,16.3,16.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,21.1,21.2,21.3,21.4,115.1,115.2,115.3,115.4,116.1,116.2,116.3,116.4,330.1,330.2,330.3,330.4,354.1,354.2,354.3,354.4,355.1,355.2,355.3,355.4,39.1,39.2,39.3,39.4,40.1,40.2,40.3,40.4,41.1,41.2,41.3,41.4,42.1,42.2,42.3,42.4,315.1,315.2,315.3,315.4,316.1,316.2,316.3,316.4,324.1,324.2,324.3,324.4,326.1,326.2,326.3,326.4,51.1,51.2,51.3,51.4,52.1,52.2,52.3,52.4,118.1,118.2,118.3,118.4,53.1,53.2,53.3,53.4,54.1,54.2,54.3,54.4,140.1,140.2,140.3,140.4,143.1,143.2,143.3,143.4,144.1,144.2,144.3,144.4,56.1,56.2,56.3,56.4,145.1,145.2,145.3,145.4,57.1,57.2,57.3,57.4,65.1,65.2,65.3,65.4,66.1,66.2,66.3,66.4,69.1,69.2,69.3,69.4,161.1,161.2,161.3,161.4,73.1,73.2,73.3,73.4,74.1,74.2,74.3,74.4,75.1,75.2,75.3,75.4,76.1,76.2,76.3,76.4,77.1,77.2,77.3,77.4,78.1,78.2,78.3,78.4,79.1,79.2,79.3,79.4,81.1,81.2,81.3,81.4,82.1,82.2,82.3,82.4,212.1,212.2,212.3,212.4,302.1,302.2,302.3,302.4,321.1,321.2,321.3,321.4,322.1,322.2,322.3,322.4,86.1,86.2,86.3,86.4,174.1,174.2,174.3,174.4,242.1,242.2,242.3,242.4,87.1,87.2,87.3,87.4,88.1,88.2,88.3,88.4,89.1,89.2,89.3,89.4,175.1,175.2,175.3,175.4,182.1,182.2,182.3,182.4,183.1,183.2,183.3,183.4,188.1,188.2,188.3,188.4,189.1,189.2,189.3,189.4,96.1,96.2,96.3,96.4,97.1,97.2,97.3,97.4,109.1,109.2,109.3,109.4,110.1,110.2,110.3,110.4,178.1,178.2,178.3,178.4,179.1,179.2,179.3,179.4,180.1,180.2,180.3,180.4,241.1,241.2,241.3,241.4,185.1,185.2,185.3,185.4,186.1,186.2,186.3,186.4,301.1,301.2,301.3,301.4,193.1,193.2,193.3,193.4,194.1,194.2,194.3,194.4,341.1,341.2,341.3,341.4,199.1,199.2,199.3,199.4,200.1,200.2,200.3,200.4,202.1,202.2,202.3,202.4,203.1,203.2,203.3,203.4,206.1,206.2,206.3,206.4,328.1,328.2,328.3,328.4,329.1,329.2,329.3,329.4,103.1,103.2,103.3,103.4,104.1,104.2,104.3,104.4,105.1,105.2,105.3,105.4,106.1,106.2,106.3,106.4,107.1,107.2,107.3,107.4,208.1,208.2,208.3,208.4,209.1,209.2,209.3,209.4,275.1,275.2,275.3,275.4,276.1,276.2,276.3,276.4,311.1,311.2,311.3,311.4,351.1,351.2,351.3,351.4,352.1,352.2,352.3,352.4,101.1,101.2,101.3,101.4,253.1,253.2,253.3,253.4,254.1,254.2,254.3,254.4,258.1,258.2,258.3,258.4,259.1,259.2,259.3,259.4,');
INSERT INTO `roles` VALUES (32, 1, '游戏部', 0, '2011-12-18 14:45:10', '', NULL, '260,262,291,292,293,308,309,310,295,243,244,246,247,248,8,101,', '262.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,246.1,246.4,247.4,248.4,101.1,101.2,101.3,101.4,');
INSERT INTO `roles` VALUES (33, 1, '销售部二组', 0, '2011-12-18 14:53:16', '', NULL, '260,261,262,263,264,265,266,267,268,269,270,312,291,292,293,308,309,310,295,317,318,319,243,244,245,246,247,248,249,250,251,256,1,114,116,3,45,52,118,50,57,176,177,178,179,180,241,184,186,191,192,193,194,205,206,8,101,', '261.1,261.2,261.3,261.4,262.3,262.4,263.1,263.2,263.3,263.4,264.1,264.2,264.3,264.4,265.1,265.2,265.3,265.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,256.4,116.4,57.4,178.1,178.2,178.3,178.4,179.4,180.1,180.2,180.3,180.4,241.1,241.2,241.3,241.4,186.4,193.1,193.2,193.4,194.1,194.2,194.3,194.4,206.4,101.1,101.2,101.3,101.4,');
INSERT INTO `roles` VALUES (34, 1, '销售一组', 0, '2011-12-18 14:53:29', '', NULL, '260,261,262,263,264,265,266,267,268,269,270,312,291,292,293,308,309,310,295,317,318,319,243,244,245,246,247,248,249,250,251,256,1,9,11,17,22,117,5,83,86,174,242,84,87,88,85,89,175,181,182,183,176,177,178,179,180,241,184,185,186,8,101,', '261.1,261.2,261.3,261.4,262.3,262.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,245.1,245.2,245.3,245.4,246.3,246.4,247.1,247.2,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,256.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,174.1,174.4,242.1,242.2,242.4,87.3,87.4,88.3,88.4,89.4,182.1,182.2,182.3,182.4,183.1,183.2,183.3,183.4,188.4,189.4,178.1,178.2,178.3,178.4,179.1,179.2,179.3,179.4,180.1,180.2,180.3,180.4,241.1,241.2,241.3,241.4,185.4,186.4,101.1,101.2,101.3,101.4,');
INSERT INTO `roles` VALUES (35, 27, '行政部', 0, '2011-12-18 14:54:03', '', '', '260,261,262,263,264,265,266,267,268,269,270,312,291,292,293,308,309,310,295,300,320,317,318,319,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,10,15,16,11,17,22,117,114,115,116,2,32,39,40,33,41,42,3,45,52,118,47,54,140,176,177,179,191,205,206,8,101,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,263.1,263.2,263.3,263.4,264.1,264.2,264.3,264.4,265.1,265.2,265.3,265.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,300.1,300.2,300.3,300.4,320.1,320.2,320.3,320.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,255.1,255.2,255.3,255.4,256.1,256.2,256.3,256.4,13.1,13.2,13.3,13.4,14.1,14.2,14.4,307.1,307.2,307.3,307.4,15.1,15.2,15.3,15.4,16.1,16.2,16.3,16.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,115.1,115.2,115.3,115.4,116.1,116.2,116.3,116.4,39.1,39.4,40.4,41.1,41.4,42.4,52.1,52.2,52.3,52.4,118.1,118.2,118.3,118.4,54.1,54.2,54.3,54.4,140.1,140.3,140.4,179.1,179.2,179.3,179.4,206.4,');
INSERT INTO `roles` VALUES (36, 1, '客服部', 0, '2011-12-18 15:43:02', '', NULL, '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,339,340,338,342,343,344,345,346,347,348,357,358,349,350,438,442,443,444,445,446,447,439,448,449,450,451,452,453,440,454,455,456,459,460,441,457,458,461,462,463,464,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,356,10,15,16,11,17,22,117,12,21,114,115,116,330,353,354,355,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,341,198,199,200,201,202,203,205,206,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,351,352,101,252,253,254,257,258,259,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,263.1,263.2,263.3,263.4,264.1,264.2,264.3,264.4,265.1,265.2,265.3,265.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,272.1,272.2,272.3,272.4,273.1,273.2,273.3,273.4,278.1,278.2,278.3,278.4,296.1,296.2,296.3,296.4,297.1,297.2,297.3,297.4,298.1,298.2,298.3,298.4,299.1,299.2,299.3,299.4,288.1,288.2,288.3,288.4,289.1,289.2,289.3,289.4,290.1,290.2,290.3,290.4,294.1,294.2,294.3,294.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,300.1,300.2,300.3,300.4,320.1,320.2,320.3,320.4,304.1,304.2,304.3,304.4,305.1,305.2,305.3,305.4,306.1,306.2,306.3,306.4,318.1,318.2,318.3,318.4,319.1,319.2,319.3,319.4,331.1,331.2,331.3,331.4,332.1,332.2,332.3,332.4,333.1,333.2,333.3,333.4,334.1,334.2,334.3,334.4,335.1,335.2,335.3,335.4,336.1,336.2,336.3,336.4,337.1,337.2,337.3,337.4,339.1,339.2,339.3,339.4,340.1,340.2,340.3,340.4,343.1,343.2,343.3,343.4,345.1,345.2,345.3,345.4,346.1,346.2,346.3,346.4,347.1,347.2,347.3,347.4,348.1,348.2,348.3,348.4,358.1,358.2,358.3,358.4,350.1,350.2,350.3,350.4,443.1,443.2,443.3,443.4,444.1,444.2,444.3,444.4,447.1,447.2,447.3,447.4,449.1,449.2,449.3,449.4,450.1,450.2,450.3,450.4,451.1,451.2,451.3,451.4,452.1,452.2,452.3,452.4,454.1,454.2,454.3,454.4,459.1,459.2,459.3,459.4,460.1,460.2,460.3,460.4,457.1,457.2,457.3,457.4,458.1,458.2,458.3,458.4,462.1,462.2,462.3,462.4,463.1,463.2,463.3,463.4,464.1,464.2,464.3,464.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,255.1,255.2,255.3,255.4,256.1,256.2,256.3,256.4,13.1,13.2,13.3,13.4,14.1,14.2,14.3,14.4,307.1,307.2,307.3,307.4,356.1,356.2,356.3,356.4,15.1,15.2,15.3,15.4,16.1,16.2,16.3,16.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,21.1,21.2,21.3,21.4,115.1,115.2,115.3,115.4,116.1,116.2,116.3,116.4,330.1,330.2,330.3,330.4,354.1,354.2,354.3,354.4,355.1,355.2,355.3,355.4,39.1,39.2,39.3,39.4,40.1,40.2,40.3,40.4,41.1,41.2,41.3,41.4,42.1,42.2,42.3,42.4,315.1,315.2,315.3,315.4,316.1,316.2,316.3,316.4,324.1,324.2,324.3,324.4,326.1,326.2,326.3,326.4,51.1,51.2,51.3,51.4,52.1,52.2,52.3,52.4,118.1,118.2,118.3,118.4,53.1,53.2,53.3,53.4,54.1,54.2,54.3,54.4,140.1,140.2,140.3,140.4,143.1,143.2,143.3,143.4,144.1,144.2,144.3,144.4,56.1,56.2,56.3,56.4,145.1,145.2,145.3,145.4,57.1,57.2,57.3,57.4,65.1,65.2,65.3,65.4,66.1,66.2,66.3,66.4,69.1,69.2,69.3,69.4,161.1,161.2,161.3,161.4,73.1,73.2,73.3,73.4,74.1,74.2,74.3,74.4,75.1,75.2,75.3,75.4,76.1,76.2,76.3,76.4,77.1,77.2,77.3,77.4,78.1,78.2,78.3,78.4,79.1,79.2,79.3,79.4,81.1,81.2,81.3,81.4,82.1,82.2,82.3,82.4,212.1,212.2,212.3,212.4,302.1,302.2,302.3,302.4,321.1,321.2,321.3,321.4,322.1,322.2,322.3,322.4,86.1,86.2,86.3,86.4,174.1,174.2,174.3,174.4,242.1,242.2,242.3,242.4,87.1,87.2,87.3,87.4,88.1,88.2,88.3,88.4,89.1,89.2,89.3,89.4,175.1,175.2,175.3,175.4,182.1,182.2,182.3,182.4,183.1,183.2,183.3,183.4,188.1,188.2,188.3,188.4,189.1,189.2,189.3,189.4,96.1,96.2,96.3,96.4,97.1,97.2,97.3,97.4,109.1,109.2,109.3,109.4,110.1,110.2,110.3,110.4,178.1,178.2,178.3,178.4,179.1,179.2,179.3,179.4,180.1,180.2,180.3,180.4,241.1,241.2,241.3,241.4,185.1,185.2,185.3,185.4,186.1,186.2,186.3,186.4,301.1,301.2,301.3,301.4,193.1,193.2,193.3,193.4,194.1,194.2,194.3,194.4,341.1,341.2,341.3,341.4,199.1,199.2,199.3,199.4,200.1,200.2,200.3,200.4,202.1,202.2,202.3,202.4,203.1,203.2,203.3,203.4,206.1,206.2,206.3,206.4,328.1,328.2,328.3,328.4,329.1,329.2,329.3,329.4,103.1,103.2,103.3,103.4,104.1,104.2,104.3,104.4,105.1,105.2,105.3,105.4,106.1,106.2,106.3,106.4,107.1,107.2,107.3,107.4,208.1,208.2,208.3,208.4,209.1,209.2,209.3,209.4,275.1,275.2,275.3,275.4,276.1,276.2,276.3,276.4,311.1,311.2,311.3,311.4,351.1,351.2,351.3,351.4,352.1,352.2,352.3,352.4,101.1,101.2,101.3,101.4,253.1,253.2,253.3,253.4,254.1,254.2,254.3,254.4,258.1,258.2,258.3,258.4,259.1,259.2,259.3,259.4,');
INSERT INTO `roles` VALUES (37, 1, '地区公司总经理', 0, '2012-06-30 10:13:38', '', NULL, '260,261,262,266,267,268,269,270,312,291,292,293,308,309,310,295,243,244,245,246,247,248,249,250,1,9,307,11,17,22,117,5,83,86,174,242,84,87,88,176,177,178,179,', '261.1,261.2,261.3,261.4,262.1,262.2,262.3,262.4,266.1,266.2,266.3,266.4,268.1,268.2,268.3,268.4,269.1,269.2,269.3,269.4,270.1,270.2,270.3,270.4,312.1,312.2,312.3,312.4,292.1,292.2,292.3,292.4,308.1,308.2,308.3,308.4,309.1,309.2,309.3,309.4,310.1,310.2,310.3,310.4,295.1,295.2,295.3,295.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.2,248.3,248.4,250.1,250.2,250.3,250.4,307.1,307.2,307.3,307.4,22.1,22.2,22.3,22.4,117.1,117.2,117.3,117.4,86.1,86.2,86.3,86.4,174.2,174.4,242.1,242.2,242.3,242.4,87.1,87.2,87.3,87.4,88.1,88.2,88.3,88.4,175.1,178.1,178.2,178.3,178.4,179.1,179.2,179.3,179.4,180.3,');
INSERT INTO `roles` VALUES (38, 1, '省级营销公司总经理', 0, '2012-11-18 09:25:57', '负责省级公司机构管理', NULL, '271,272,273,277,278,299,291,292,293,308,309,310,295,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,243,244,245,246,247,248,249,250,251,256,1,9,13,14,307,10,15,16,11,17,22,117,12,21,114,116,330,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,61,76,77,62,78,79,63,81,64,82,210,212,213,302,7,95,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,198,199,200,201,202,203,205,206,327,328,329,8,100,105,207,208,209,274,275,276,101,252,253,257,258,259,', '272.1,272.2,272.4,273.4,278.1,278.2,278.4,299.4,292.1,292.2,292.4,308.1,308.2,308.4,309.1,309.2,309.4,310.1,310.2,310.4,295.1,295.2,295.4,320.1,320.2,320.4,304.1,304.2,304.4,305.1,305.2,305.4,306.1,306.2,306.4,318.1,318.2,318.4,319.4,331.1,331.2,331.4,332.1,332.2,332.4,333.4,334.4,335.1,335.2,335.4,336.1,336.2,336.4,337.1,337.2,337.4,245.1,245.2,245.4,246.1,246.2,246.4,247.1,247.2,247.4,248.1,248.2,248.4,250.1,250.2,250.4,256.4,13.1,13.2,13.4,307.1,307.2,307.4,15.1,15.2,15.4,16.1,16.2,16.4,22.1,22.2,22.4,117.1,117.2,117.4,21.4,116.4,330.4,39.1,39.2,39.4,40.1,40.4,41.1,41.2,41.4,42.4,315.4,316.4,324.4,326.4,51.1,51.4,52.4,118.1,118.2,118.4,53.1,53.2,53.4,54.1,54.4,140.1,140.2,140.4,143.1,143.2,143.4,144.4,56.4,145.1,145.2,145.4,57.1,57.4,65.4,66.1,66.2,66.4,69.4,161.1,161.2,161.4,76.1,76.2,76.4,77.4,78.1,78.2,78.4,79.1,79.2,79.4,81.1,82.1,82.4,212.1,212.4,302.4,97.1,97.4,109.1,109.2,109.4,110.4,178.1,178.2,178.4,179.4,180.1,180.2,180.4,241.4,185.4,186.1,186.2,186.4,301.2,301.4,193.4,194.1,194.2,194.4,199.4,200.1,200.2,200.3,200.4,202.4,203.1,203.2,203.4,206.1,206.2,206.4,328.1,328.2,328.4,329.1,329.2,329.4,105.4,208.1,208.4,209.4,275.4,276.4,101.1,101.2,101.4,253.1,253.4,258.1,258.4,259.2,259.4,');
INSERT INTO `roles` VALUES (39, 1, '销售经理', 0, '2012-12-26 01:10:20', '销售部门经理职位', NULL, '267,268,269,270,312,271,272,273,291,292,293,308,309,310,295,317,318,319,331,332,333,334,335,336,337,339,243,244,245,246,247,248,249,250,1,9,307,11,17,22,117,176,177,178,179,180,241,184,185,186,301,', '268.1,268.2,268.4,269.1,269.2,269.4,270.1,270.2,270.4,312.1,312.2,312.4,272.1,272.2,272.4,273.4,292.1,292.2,292.4,308.1,308.2,308.4,309.1,309.2,309.4,310.1,310.2,310.4,295.1,295.2,295.3,295.4,318.1,318.2,318.4,319.1,319.2,319.4,331.1,331.2,331.4,332.1,332.2,332.4,333.1,333.2,333.4,334.1,334.2,334.4,335.1,335.2,335.4,336.1,336.2,336.4,337.1,337.2,337.4,339.1,339.2,339.4,245.1,245.2,245.3,245.4,246.1,246.2,246.3,246.4,247.1,247.2,247.3,247.4,248.1,248.3,248.4,250.1,250.2,250.4,307.4,22.4,117.1,117.2,117.4,178.1,178.4,179.1,179.4,180.1,180.4,241.1,241.4,185.1,185.4,186.1,186.4,301.1,301.4,');

-- ----------------------------
-- Table structure for ruin
-- ----------------------------
DROP TABLE IF EXISTS `ruin`;
CREATE TABLE `ruin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruinNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `profitOrLoss` int(11) NULL DEFAULT NULL,
  `emp_id` int(11) NULL DEFAULT NULL,
  `rtime` datetime NULL DEFAULT NULL,
  `sum` float NULL DEFAULT NULL,
  `auditing` int(11) NULL DEFAULT NULL,
  `delflag` int(11) NULL DEFAULT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ruin_fk`(`emp_id`) USING BTREE,
  CONSTRAINT `ruin_fk` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of ruin
-- ----------------------------

-- ----------------------------
-- Table structure for ruininfo
-- ----------------------------
DROP TABLE IF EXISTS `ruininfo`;
CREATE TABLE `ruininfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) NULL DEFAULT NULL,
  `price` float UNSIGNED NULL DEFAULT NULL,
  `describes` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `disposeManner` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ruinId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_ruinInfo_product`(`productId`) USING BTREE,
  INDEX `FK_ruinInfo_ruin`(`ruinId`) USING BTREE,
  CONSTRAINT `FK_ruinInfo_product` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_ruinInfo_ruin` FOREIGN KEY (`ruinId`) REFERENCES `ruin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of ruininfo
-- ----------------------------

-- ----------------------------
-- Table structure for sale_goods
-- ----------------------------
DROP TABLE IF EXISTS `sale_goods`;
CREATE TABLE `sale_goods`  (
  `sg_id` int(11) NOT NULL AUTO_INCREMENT,
  `gd_id` int(11) NULL DEFAULT NULL,
  `sg_username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sgname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sg_price` double NOT NULL,
  `sg_img` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片路径',
  `sg_thumb` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '略缩路径',
  `sgcode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sg_norms` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sg_unit` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sg_stat` int(11) NULL DEFAULT NULL,
  `sg_checkGoods` int(11) NULL DEFAULT NULL,
  `sgtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sg_puttime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sg_details` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sg_video` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sg_inventory` int(11) NULL DEFAULT NULL,
  `sg_quantity` int(11) NULL DEFAULT NULL,
  `sg_sales_volume` int(11) NULL DEFAULT NULL,
  `sg_attribute` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sg_numbers` int(11) NULL DEFAULT NULL,
  `sg_checks` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_activity` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否活动(促销) 默认0 否 1 是',
  `activity_price` double NULL DEFAULT 0 COMMENT '活动(促销)价格',
  `activity_start` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动(促销)开始时间',
  `activity_end` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动(促销)结束时间',
  `sg_specifications` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `erweima` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码',
  `is_delivery` int(1) NULL DEFAULT NULL COMMENT '0不需要 1需要',
  PRIMARY KEY (`sg_id`) USING BTREE,
  UNIQUE INDEX `AK_Key_2`(`sgcode`) USING BTREE,
  INDEX `relation_sa_dit`(`gd_id`) USING BTREE,
  CONSTRAINT `relation_sa_dit` FOREIGN KEY (`gd_id`) REFERENCES `goods_dict` (`gd_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sale_goods
-- ----------------------------

-- ----------------------------
-- Table structure for sale_orders
-- ----------------------------
DROP TABLE IF EXISTS `sale_orders`;
CREATE TABLE `sale_orders`  (
  `so_id` int(11) NOT NULL AUTO_INCREMENT,
  `so_nums` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `so_stat` int(11) NULL DEFAULT NULL,
  `so_checkStat` int(11) NULL DEFAULT NULL,
  `so_orderTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cusid` int(11) NULL DEFAULT NULL,
  `ordertype` int(11) NULL DEFAULT NULL COMMENT '类型',
  `sg_price` double NULL DEFAULT NULL,
  `is_delivery` int(1) NULL DEFAULT NULL COMMENT '0不发货 1发货',
  `sg_devilvtype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sg_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sg_leave` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `count` int(10) NULL DEFAULT NULL,
  `ipnum` int(10) NULL DEFAULT NULL,
  `spaceSize` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `meetprice` double NULL DEFAULT NULL,
  `empid` int(11) NULL DEFAULT NULL,
  `devilvprice` double NULL DEFAULT NULL COMMENT '邮寄费用',
  `statchang` int(11) NULL DEFAULT NULL COMMENT '提交并审核或者直接提交',
  `divsg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品详情',
  `prices` double NULL DEFAULT NULL COMMENT '商品价格',
  `spec` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`so_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sale_orders
-- ----------------------------

-- ----------------------------
-- Table structure for salegoods_mids
-- ----------------------------
DROP TABLE IF EXISTS `salegoods_mids`;
CREATE TABLE `salegoods_mids`  (
  `sgm_id` int(11) NOT NULL AUTO_INCREMENT,
  `sg_id` int(11) NOT NULL,
  `so_id` int(11) NOT NULL,
  `so_orderNumber` int(11) NOT NULL,
  `soCheckStat` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`sgm_id`) USING BTREE,
  INDEX `relation_mid_god`(`sg_id`) USING BTREE,
  INDEX `relation_mids_oder`(`so_id`) USING BTREE,
  CONSTRAINT `relation_mid_god` FOREIGN KEY (`sg_id`) REFERENCES `sale_goods` (`sg_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `relation_mids_oder` FOREIGN KEY (`so_id`) REFERENCES `sale_orders` (`so_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of salegoods_mids
-- ----------------------------

-- ----------------------------
-- Table structure for saleorder
-- ----------------------------
DROP TABLE IF EXISTS `saleorder`;
CREATE TABLE `saleorder`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `classtype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `saleOrderNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empid` int(11) NOT NULL,
  `ordertype` int(11) NOT NULL,
  `Price` float NOT NULL,
  `beginTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_id` int(11) NULL DEFAULT NULL,
  `endTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `space_size` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_num` int(11) NULL DEFAULT NULL,
  `bw` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip_num` int(11) NULL DEFAULT NULL,
  `used_size` int(11) NULL DEFAULT NULL,
  `pay_style` int(11) NULL DEFAULT NULL,
  `pay_status` int(11) NULL DEFAULT NULL,
  `auditingState` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0：未审  1：已审  2 ：已提交上架',
  `Finance` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_start_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inputAdmin` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `inputTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `serverConfiguration` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cabinet` int(11) NULL DEFAULT NULL,
  `isgetorder` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `Id`(`Id`) USING BTREE,
  INDEX `FK_saleOrder_allType1`(`pay_status`) USING BTREE,
  INDEX `FK_saleOrder_allType2`(`pay_style`) USING BTREE,
  INDEX `FK_saleOrder_customer`(`customer_id`) USING BTREE,
  INDEX `FK_saleOrder_employee`(`empid`) USING BTREE,
  INDEX `FK_saleOrder_property`(`cabinet`) USING BTREE,
  INDEX `FK_saleOrder_allType`(`ordertype`) USING BTREE,
  CONSTRAINT `FK_saleOrder_allType` FOREIGN KEY (`ordertype`) REFERENCES `questioncategory` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_saleOrder_allType1` FOREIGN KEY (`pay_status`) REFERENCES `alltype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_saleOrder_allType2` FOREIGN KEY (`pay_style`) REFERENCES `alltype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_saleOrder_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_saleOrder_employee` FOREIGN KEY (`empid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_saleOrder_property` FOREIGN KEY (`cabinet`) REFERENCES `property` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'InnoDB free: 6144 kB; (`ordertype`) REFER `fajxc/alltype`(`i' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of saleorder
-- ----------------------------

-- ----------------------------
-- Table structure for scheduleplan
-- ----------------------------
DROP TABLE IF EXISTS `scheduleplan`;
CREATE TABLE `scheduleplan`  (
  `id` int(11) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `plantype` int(11) NULL DEFAULT NULL COMMENT '计划类型(0：日计划  1：周计划   2：月计划  3：季计划  4：年计划)',
  `subjecttitle` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `workcontent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `workremind` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `todayWorkPlan` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '今天工作内容',
  `tomorrowWorkPlan` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '明天工作任务',
  `begintime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开始时间',
  `endtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计划结束时间',
  `finishtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '完成时间',
  `remindtime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empid` int(11) NULL DEFAULT NULL COMMENT '工作人员id',
  `sendStyle` int(11) NULL DEFAULT NULL COMMENT '发送方式（0：发送系统消息  1 ：发送手机消息 2 发送电子邮件消息）',
  `remainSet` int(11) NULL DEFAULT NULL COMMENT '提醒设置（0：任务开始前发送  1 ： 任务结束前发送  2 任务超时后发送）',
  `state` int(11) NULL DEFAULT NULL COMMENT '是否完成',
  `importantLevel` int(11) NULL DEFAULT NULL COMMENT '重要程度  0：不重要  1 ： 一般  2 ： 重要',
  `subjectstyle` int(1) NULL DEFAULT NULL,
  `organizer` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `participator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isplan` int(1) NULL DEFAULT NULL,
  `effective` int(1) NULL DEFAULT NULL,
  `tmp` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `durationTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自动更新到期时间',
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `taskid` int(11) NULL DEFAULT NULL,
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `plan_emp_id`(`empid`) USING BTREE,
  CONSTRAINT `plan_emp_id` FOREIGN KEY (`empid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of scheduleplan
-- ----------------------------

-- ----------------------------
-- Table structure for sendmessage
-- ----------------------------
DROP TABLE IF EXISTS `sendmessage`;
CREATE TABLE `sendmessage`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sendtable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `sendtableId` int(11) NULL DEFAULT NULL COMMENT '相应的Id',
  `state` int(11) NULL DEFAULT NULL COMMENT '是否已接收（0.未出来 1.已处理）',
  `empId` int(11) NULL DEFAULT NULL COMMENT '接收人员',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `empId`(`empId`) USING BTREE,
  CONSTRAINT `sendmessage_ibfk_1` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sendmessage
-- ----------------------------

-- ----------------------------
-- Table structure for servermonitor
-- ----------------------------
DROP TABLE IF EXISTS `servermonitor`;
CREATE TABLE `servermonitor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverid` int(11) NOT NULL,
  `serverIP` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `monitorE` int(11) NULL DEFAULT NULL,
  `monitorLog` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_serverMonitor_`(`serverid`) USING BTREE,
  INDEX `FK_serverMonitor_employee`(`monitorE`) USING BTREE,
  CONSTRAINT `FK_serverMonitor_` FOREIGN KEY (`serverid`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_serverMonitor_employee` FOREIGN KEY (`monitorE`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of servermonitor
-- ----------------------------

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '餐套名',
  `realmtypeid` int(11) NULL DEFAULT NULL COMMENT '类型    静态/动态    等4种类型',
  `starttime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动开始时间',
  `endtime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动结束时间',
  `usetime` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '套餐使用时间长度',
  `describe1` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '套餐描述',
  `price` float(11, 0) NULL DEFAULT NULL COMMENT '原价',
  `chargeType` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '免费0，赠送者，收费预付2，收费后付3',
  `payprice` float(11, 0) NULL DEFAULT NULL COMMENT '实际价格',
  `delFlag` int(11) NULL DEFAULT NULL COMMENT '删除标记 0没删除 1删除',
  `ordertypeid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `setmeal_realmtype`(`realmtypeid`) USING BTREE,
  INDEX `setmeal_ordertype`(`ordertypeid`) USING BTREE,
  CONSTRAINT `setmeal_ordertype` FOREIGN KEY (`ordertypeid`) REFERENCES `ordertype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `setmeal_realmtype` FOREIGN KEY (`realmtypeid`) REFERENCES `realmtype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES (1, '免费套餐-Ⅰ', 1, '2012-01-12', '2012-02-12', '0', NULL, 1800, '0', 0, 1, NULL);
INSERT INTO `setmeal` VALUES (2, '动静态全站流量套餐包Ⅰ', 2, '2012-01-16', '2012-02-16', '1', '', 199, '2', 199, 1, NULL);
INSERT INTO `setmeal` VALUES (3, '动静态全站流量套餐包Ⅱ', 2, '2012-02-01', '2013-12-31', '2', '', 399, '2', 399, 1, NULL);
INSERT INTO `setmeal` VALUES (4, '动静态全站流量套餐包Ⅲ', 2, '2012-02-03', '2012-12-31', '1', '', 999, '2', 999, 1, NULL);
INSERT INTO `setmeal` VALUES (5, '动静态全站带宽套餐包Ⅰ', 2, '2012-02-01', '2012-12-31', '1', '', 499, '2', 499, 1, NULL);
INSERT INTO `setmeal` VALUES (6, '动静态全站带宽套餐包Ⅱ', 2, '2012-02-01', '2012-12-31', '1', '', 699, '2', 699, 1, NULL);
INSERT INTO `setmeal` VALUES (7, '动静态全站带宽套餐包Ⅲ', 2, '2012-02-01', '2012-12-31', '1', NULL, 1999, '2', 1999, 1, NULL);
INSERT INTO `setmeal` VALUES (8, '免费套餐-Ⅰ', 1, '2012-02-01', '2012-12-31', '1', NULL, 1800, '0', 0, 1, NULL);
INSERT INTO `setmeal` VALUES (9, '免费流量', 6, '2012-02-01', '2012-02-23', '1', NULL, 2000, '0', 0, 1, NULL);
INSERT INTO `setmeal` VALUES (10, '测试1', 1, '2012-02-01', '2012-02-02', '5', NULL, 2000, '0', 0, 1, NULL);
INSERT INTO `setmeal` VALUES (11, '测试数据', 1, '2012-03-01', '2012-03-29', '3', '优惠', 500, '3', 200, 1, NULL);
INSERT INTO `setmeal` VALUES (12, '测试数据03', 1, '2012-03-01', '2012-03-10', '1', '测试', 500, '3', 200, 1, NULL);
INSERT INTO `setmeal` VALUES (13, '测试数据', 1, '2012-03-01', '2012-03-31', '2', '测试', 500, '3', 250, 1, NULL);
INSERT INTO `setmeal` VALUES (14, '胥渊测试', 1, '2013-05-01', '2013-05-18', '5', '木有啥玩意', 100, '2', 100, 1, NULL);
INSERT INTO `setmeal` VALUES (15, '测试12', 1, '2013-05-01', '2013-05-04', '8', '实打实的', 200, '0', 200, 1, NULL);
INSERT INTO `setmeal` VALUES (16, '胥渊检测', 1, '2013-05-01', '2013-05-10', '5', '没有', 200, '0', 100, 1, NULL);
INSERT INTO `setmeal` VALUES (17, '1月份优惠套餐', 1, '2013-06-01', '2013-06-21', '32', '优惠', 50000, '2', 40000, 0, NULL);
INSERT INTO `setmeal` VALUES (18, '尼玛', 1, '2013-05-30', '2013-06-29', '2', '额度范围', 34234, '3', 23423, 1, NULL);
INSERT INTO `setmeal` VALUES (19, '5月份优惠', 1, '2013-05-01', '2013-06-01', '2', 'OKokoOKKOKOKOKO', 1000000, '2', 800000, 0, NULL);
INSERT INTO `setmeal` VALUES (20, 'asdsa ', 1, '2013-06-07', '2013-06-28', '45', '1242', 100, '3', 100, 0, NULL);
INSERT INTO `setmeal` VALUES (21, '在次测试', 1, '2013-06-04', '2013-06-27', '2', '实打实的', 0, '0', 10000, 0, NULL);
INSERT INTO `setmeal` VALUES (22, '侧四是实施', 1, '2013-06-01', '2013-07-05', '2', '实打实', 0, '2', 100000, 0, NULL);
INSERT INTO `setmeal` VALUES (23, '测试', 1, '2013-06-01', '2013-06-19', '2', '', 50200, '0', 10000, 0, NULL);
INSERT INTO `setmeal` VALUES (24, '胥渊测试111', 1, '2013-06-14', '2013-07-04', '2', '恶趣味', 2000, '0', 1000, 0, NULL);
INSERT INTO `setmeal` VALUES (25, '促使是', 1, '2013-06-08', '2013-06-21', '1089', '是的', 50200, '3', 10000, 0, NULL);
INSERT INTO `setmeal` VALUES (26, '在此测试', 3, '2013-06-21', '2013-07-05', '788', '是的撒', 3200, '3', 1000, 0, NULL);
INSERT INTO `setmeal` VALUES (27, '打野测试', 1, '2013-06-21', '2013-06-28', '72', '撒旦撒', 50200, '0', 10000, 0, NULL);
INSERT INTO `setmeal` VALUES (28, '流程测试', 1, '2013-05-03', '2013-06-09', '50', '放个大', 50, '1', 10, 0, NULL);

-- ----------------------------
-- Table structure for setmeal_comm
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_comm`;
CREATE TABLE `setmeal_comm`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(65) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `ordertype_id` int(11) NULL DEFAULT NULL COMMENT '订单类型外键(id)',
  `start_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '动活开始时间',
  `end_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动结束时间',
  `describe_text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '套餐描述',
  `charge_mode` int(11) NULL DEFAULT NULL COMMENT '付费方式',
  `total_price` float NULL DEFAULT NULL COMMENT '总价(原价)',
  `pay_price` float NULL DEFAULT NULL COMMENT '支付价格(实际价格)',
  `delflag` int(2) NULL DEFAULT NULL COMMENT '删除标识',
  `del_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除描述',
  `audit_state` int(3) NULL DEFAULT NULL,
  `audit_emp` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核员工',
  `build_time` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成时间(毫秒数)',
  `exit_scfj` int(1) NULL DEFAULT 0 COMMENT '是否存在上传附件',
  `temp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ordertype_id`(`ordertype_id`) USING BTREE,
  CONSTRAINT `setmeal_comm_ibfk_1` FOREIGN KEY (`ordertype_id`) REFERENCES `ordertype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of setmeal_comm
-- ----------------------------

-- ----------------------------
-- Table structure for setmealcenter
-- ----------------------------
DROP TABLE IF EXISTS `setmealcenter`;
CREATE TABLE `setmealcenter`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setmealid` int(11) NULL DEFAULT NULL COMMENT '套餐id',
  `productpropertyid` int(11) NULL DEFAULT NULL,
  `temp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '套餐属性id',
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '价格',
  `temp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计费方式-0流量，1带宽，2hit连接数',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `setcenter_setmeal`(`setmealid`) USING BTREE,
  INDEX `setcenter_productpro`(`productpropertyid`) USING BTREE,
  CONSTRAINT `setcenter_productpro` FOREIGN KEY (`productpropertyid`) REFERENCES `setmealproperty` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `setcenter_setmeal` FOREIGN KEY (`setmealid`) REFERENCES `setmeal` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of setmealcenter
-- ----------------------------

-- ----------------------------
-- Table structure for setmealproperty
-- ----------------------------
DROP TABLE IF EXISTS `setmealproperty`;
CREATE TABLE `setmealproperty`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '套餐的名称',
  `flow` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '多少带宽',
  `bandwidth` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '单价',
  `hitnum` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '原价',
  `flow1` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '优惠价',
  `flow2` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '线路',
  `flow3` float(11, 0) NULL DEFAULT NULL COMMENT '流量-类别3',
  `flow4` float(11, 0) NULL DEFAULT NULL COMMENT '流量-类别4',
  `bandwidth1` float(11, 0) NULL DEFAULT NULL COMMENT '带宽-类别1',
  `bandwidth2` float(11, 0) NULL DEFAULT NULL COMMENT '带宽-类别2',
  `bandwidth3` float(11, 0) NULL DEFAULT 0 COMMENT '带宽-类别3',
  `bandwidth4` float(11, 0) NULL DEFAULT NULL COMMENT '带宽-类别4',
  `hitnum1` float(11, 0) NULL DEFAULT NULL COMMENT 'hit连接数-类别1',
  `hitnum2` float(11, 0) NULL DEFAULT NULL COMMENT 'hit连接数-类别2',
  `hitnum3` float(11, 0) NULL DEFAULT NULL COMMENT 'hit连接数-类别3',
  `hitnum4` float(11, 0) NULL DEFAULT NULL COMMENT 'hit连接数-类别4',
  `delflag` int(11) NULL DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of setmealproperty
-- ----------------------------

-- ----------------------------
-- Table structure for stat
-- ----------------------------
DROP TABLE IF EXISTS `stat`;
CREATE TABLE `stat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `StatType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `StatTime` datetime NULL DEFAULT NULL,
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `employeeID` int(11) NULL DEFAULT NULL,
  `depId` int(11) NULL DEFAULT NULL,
  `auditingState` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_stat_depot`(`depId`) USING BTREE,
  INDEX `FK_stat_employee`(`employeeID`) USING BTREE,
  CONSTRAINT `FK_stat_depot` FOREIGN KEY (`depId`) REFERENCES `depot` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_stat_employee` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of stat
-- ----------------------------

-- ----------------------------
-- Table structure for statinfo
-- ----------------------------
DROP TABLE IF EXISTS `statinfo`;
CREATE TABLE `statinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factcount` int(11) NULL DEFAULT NULL,
  `datacount` int(11) NULL DEFAULT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statId` int(11) NULL DEFAULT NULL,
  `profitOrloss` int(11) NULL DEFAULT NULL,
  `modelId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of statinfo
-- ----------------------------
INSERT INTO `statinfo` VALUES (1, 4, 0, NULL, 1, 4, 12);
INSERT INTO `statinfo` VALUES (2, 5, 0, NULL, 1, 5, 19);

-- ----------------------------
-- Table structure for storage
-- ----------------------------
DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage`  (
  `storageId` int(11) NOT NULL AUTO_INCREMENT,
  `storageNo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `depotId` int(11) NOT NULL,
  `employeeId` int(11) NOT NULL,
  `allTypeId` int(11) NOT NULL,
  `storageVerify` int(11) NOT NULL,
  `storageDate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `productPriceSum` double NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `storageRemark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customerid` int(11) NULL DEFAULT NULL,
  `identitys` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`storageId`) USING BTREE,
  INDEX `FK_storage_allType`(`allTypeId`) USING BTREE,
  INDEX `FK_storage_depot`(`depotId`) USING BTREE,
  CONSTRAINT `FK_storage_allType` FOREIGN KEY (`allTypeId`) REFERENCES `alltype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_storage_depot` FOREIGN KEY (`depotId`) REFERENCES `depot` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 259 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of storage
-- ----------------------------
INSERT INTO `storage` VALUES (43, 'RK-2012022100002', 40, 100, 8, 1, '2012-02-21', NULL, '0', '机房', NULL, NULL);
INSERT INTO `storage` VALUES (45, 'RK-2012022800018', 40, 100, 8, 1, '2012-02-28', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (47, 'RK-2012032100034', 43, 100, 8, 0, '2012-03-21', NULL, '0', '曙光AMD1.8*2【二】系列，\r\n配置为：曙光AMD*2 2G ECC 73G SCSI硬盘', NULL, NULL);
INSERT INTO `storage` VALUES (51, 'RK-2012052000021', 42, 100, 6, 1, '2012-05-20', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (52, 'RK-2012052000027', 42, 100, 6, 1, '2012-05-20', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (54, 'RK-2012071400002', 43, 100, 6, 1, '2012-07-14', NULL, '0', '', 565, NULL);
INSERT INTO `storage` VALUES (55, 'RK-2012071400026', 43, 100, 8, 1, '2012-07-14', NULL, '0', '云峰I3-(二)系列\r\nI3 4G 500G 硬盘', NULL, NULL);
INSERT INTO `storage` VALUES (56, 'RK-2012071400035', 43, 100, 6, 1, '2011-12-13', NULL, '0', '', 566, NULL);
INSERT INTO `storage` VALUES (57, 'RK-2012071400041', 43, 100, 6, 1, '2011-11-29', NULL, '0', '', 134, NULL);
INSERT INTO `storage` VALUES (58, 'RK-2012071400047', 43, 100, 8, 1, '2012-07-14', NULL, '0', '曙光套餐三 AMD1.8*2 2G 500G', NULL, NULL);
INSERT INTO `storage` VALUES (59, 'RK-2012071400056', 43, 100, 6, 1, '2012-07-14', NULL, '0', '', 567, NULL);
INSERT INTO `storage` VALUES (60, 'RK-2012071400068', 43, 100, 6, 1, '2012-05-23', NULL, '0', '', 567, NULL);
INSERT INTO `storage` VALUES (61, 'RK-2012071400071', 43, 100, 6, 1, '2012-07-06', NULL, '0', '', 567, NULL);
INSERT INTO `storage` VALUES (62, 'RK-2012071400076', 43, 100, 6, 1, '2012-07-01', NULL, '0', '', 567, NULL);
INSERT INTO `storage` VALUES (63, 'RK-2012071400090', 43, 100, 6, 1, '2012-07-14', NULL, '0', '', 567, NULL);
INSERT INTO `storage` VALUES (64, 'RK-2012071400095', 43, 100, 6, 1, '2012-07-01', NULL, '0', '', 569, NULL);
INSERT INTO `storage` VALUES (65, 'RK-2012071600011', 43, 100, 6, 1, '2012-07-16', NULL, '0', '', 570, NULL);
INSERT INTO `storage` VALUES (66, 'RK-2012071600015', 43, 100, 6, 1, '2012-07-16', NULL, '0', '', 570, NULL);
INSERT INTO `storage` VALUES (67, 'RK-2012071600018', 43, 100, 6, 1, '2012-07-16', NULL, '0', '', 571, NULL);
INSERT INTO `storage` VALUES (68, 'RK-2012071600024', 43, 100, 6, 1, '2012-05-30', NULL, '0', '交换机：H3C S5800  1台\r\n交换机：H3C S5120  4台\r\n交换机：H3C S5000  8台\r\n服务器：HP DL160     47台\r\n服务器：DELL R410 7台\r\n服务器：DELL 1950 2台\r\n服务器：DELL 1435 2台', 572, NULL);
INSERT INTO `storage` VALUES (69, 'RK-2012071800009', 43, 100, 6, 1, '2012-07-18', NULL, '0', '', 85, NULL);
INSERT INTO `storage` VALUES (70, 'RK-2012071900010', 44, 100, 6, 1, '2012-03-17', NULL, '0', '', 572, NULL);
INSERT INTO `storage` VALUES (71, 'RK-2012071900014', 44, 100, 6, 1, '2012-03-19', NULL, '0', '', 578, NULL);
INSERT INTO `storage` VALUES (78, 'RK-2012071900022', 44, 100, 6, 1, '2012-03-17', NULL, '0', '', 579, NULL);
INSERT INTO `storage` VALUES (79, 'RK-2012071900026', 44, 100, 6, 1, '2012-05-22', NULL, '0', '', 571, NULL);
INSERT INTO `storage` VALUES (80, 'RK-2012072000010', 43, 100, 6, 8, '2012-05-20', NULL, '0', '', 583, NULL);
INSERT INTO `storage` VALUES (81, 'RK-2012072100004', 41, 100, 8, 1, '2012-07-21', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (82, 'RK-2012072700001', 43, 100, 6, 1, '2012-07-26', NULL, '0', '', 567, NULL);
INSERT INTO `storage` VALUES (83, 'RK-2012083000003', 44, 100, 8, 1, '2012-08-20', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (84, 'RK-2012083000014', 41, 100, 8, 1, '2012-08-20', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (85, 'RK-2012100800016', 43, 134, 6, 8, '2012-09-24', NULL, '0', '', 787, NULL);
INSERT INTO `storage` VALUES (86, 'RK-2012101600009', 44, 160, 6, 1, '2012-09-21', NULL, '0', '', 809, NULL);
INSERT INTO `storage` VALUES (87, 'RK-2012101600025', 43, 134, 6, 1, '2012-09-24', NULL, '0', '', 788, NULL);
INSERT INTO `storage` VALUES (88, 'RK-2012101600040', 45, 168, 6, 1, '2012-10-12', NULL, '0', '', 815, NULL);
INSERT INTO `storage` VALUES (89, 'RK-2012101700002', 44, 100, 6, 1, '2012-10-16', NULL, '0', '', 572, NULL);
INSERT INTO `storage` VALUES (90, 'RK-2012101700009', 45, 84, 8, 1, '2012-09-27', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (91, 'RK-2012101800004', 43, 100, 8, 1, '2012-10-18', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (92, 'RK-2012102400007', 44, 100, 8, 1, '2012-10-24', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (93, 'RK-2012102500002', 43, 100, 8, 1, '2012-10-19', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (94, 'RK-2012102900003', 43, 100, 8, 1, '2012-10-29', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (95, 'RK-2012110500002', 44, 157, 6, 1, '2012-11-02', NULL, '0', '', 859, NULL);
INSERT INTO `storage` VALUES (96, 'RK-2012111400016', 43, 100, 8, 1, '2012-11-14', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (97, 'RK-2012122500011', 44, 217, 8, 1, '2012-12-25', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (98, 'RK-2013010500002', 44, 217, 8, 1, '2013-01-05', NULL, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (99, 'RK-2013041800017', 45, 187, 6, 0, '2013-04-18', 10000, '0', 'sss', 1068, NULL);
INSERT INTO `storage` VALUES (101, 'RK-2013041800018', 44, 187, 6, 8, '2013-04-18', 1000, '0', '1000', 1078, NULL);
INSERT INTO `storage` VALUES (102, 'RK-2013042800017', 46, 187, 6, 8, '2013-04-20', 11, '0', '', 1068, NULL);
INSERT INTO `storage` VALUES (103, 'RK-2013050600015', 42, 13, 9, 0, '', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (104, 'RK-2013050600016', 41, 13, 9, 8, '2013-05-08', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (105, 'RK-2013050700015', 45, 187, 6, 0, '2013-05-11', NULL, '0', '', 1072, NULL);
INSERT INTO `storage` VALUES (106, 'RK-2013050800016', 42, 13, 8, 0, '2013-05-23', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (107, 'RK-2013050900021', 40, 13, 9, 0, '', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (108, 'RK-2013050900025', 42, 13, 9, 0, '', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (109, 'RK-2013050900026', 43, 13, 10, 0, '', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (110, 'RK-2013050900027', 41, 13, 9, 0, '', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (111, 'RK-2013051000012', 46, 145, 6, 0, '2013-05-17', NULL, '0', '', 1067, NULL);
INSERT INTO `storage` VALUES (112, 'RK-2013051000013', 45, 187, 6, 0, '2013-05-14', 1111, '0', '', 1069, NULL);
INSERT INTO `storage` VALUES (113, 'RK-2013051000018', 42, 13, 9, 0, '', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (114, 'RK-2013051000019', 40, 13, 8, 0, '', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (115, 'RK-2013051000021', 41, 13, 8, 0, '', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (116, 'RK-2013051000022', 44, 13, 6, 0, '2013-05-10', 11.1, '0', NULL, 1078, NULL);
INSERT INTO `storage` VALUES (117, 'RK-2013051000024', 40, 13, 10, 0, '', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (118, 'RK-2013051000025', 40, 13, 10, 8, '2013-05-23', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (119, 'RK-2013051000027', 46, 264, 10, 8, '2013-05-03', 111, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (120, 'RK-2013051000029', 43, 13, 10, 8, '', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (121, 'RK-2013051000030', 40, 13, 6, 1, '', 11.1, '0', NULL, 1078, NULL);
INSERT INTO `storage` VALUES (122, 'RK-2013051000035', 40, 13, 10, 1, '', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (123, 'RK-2013051000036', 40, 13, 10, 1, '', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (124, 'RK-2013051100009', 40, 13, 9, 1, '2013-05-11', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (125, 'RK-2013051100011', 40, 13, 9, 8, '2013-05-12', NULL, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (126, 'RK-2013051100011', 40, 13, 10, 8, '2013-05-11', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (127, 'RK-2013051100013', 40, 13, 9, 0, '2013-05-11', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (128, 'RK-2013051100014', 40, 13, 9, 1, '2013-05-11', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (129, 'RK-2013051100015', 40, 13, 9, 0, '2013-05-11', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (130, 'RK-2013051100016', 40, 13, 9, 0, '2013-05-11', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (131, 'RK-2013051100017', 40, 13, 9, 1, '2013-05-11', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (132, 'RK-2013051100019', 40, 13, 9, 1, '2013-05-11', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (133, 'RK-2013051100014', 44, 13, 9, 1, '2013-05-11', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (134, 'RK-2013051100035', 40, 13, 10, 0, '2013-05-11', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (135, 'RK-2013051100037', 40, 13, 10, 0, '2013-05-11', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (136, 'RK-2013051100038', 40, 13, 10, 0, '2013-05-11', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (137, 'RK-2013051100040', 40, 13, 10, 1, '2013-05-11', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (138, 'RK-2013051200001', 40, 13, 10, 1, '2013-05-12', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (139, 'RK-2013051200002', 40, 13, 10, 0, '2013-05-12', 11.1, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (142, 'RK-2013051200005', 40, 13, 6, 0, '2013-05-12', 11.1, '0', NULL, 1177, NULL);
INSERT INTO `storage` VALUES (143, 'RK-2013051200007', 40, 13, 8, 1, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (144, 'RK-2013051200008', 40, 13, 10, 1, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (145, 'RK-2013051200009', 40, 13, 9, 1, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (146, 'RK-2013051200010', 40, 13, 6, 1, '2013-05-12', 0, '0', NULL, 1075, NULL);
INSERT INTO `storage` VALUES (147, 'RK-2013051200013', 40, 13, 6, 1, '2013-05-12', 0, '0', NULL, 1177, NULL);
INSERT INTO `storage` VALUES (148, 'RK-2013051200014', 40, 13, 6, 1, '2013-05-12', 0, '0', NULL, 1077, NULL);
INSERT INTO `storage` VALUES (149, 'RK-2013051200030', 41, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (150, 'RK-2013051200031', 40, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (151, 'RK-2013051200032', 41, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (152, 'RK-2013051200032', 41, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (153, 'RK-2013051200034', 40, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (154, 'RK-2013051200035', 40, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (155, 'RK-2013051200036', 40, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (156, 'RK-2013051200038', 40, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (157, 'RK-2013051200039', 40, 13, 9, 1, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (158, 'RK-2013051200041', 40, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (159, 'RK-2013051200042', 40, 13, 9, 1, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (160, 'RK-2013051200055', 40, 13, 9, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (161, 'RK-2013051200056', 40, 13, 8, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (162, 'RK-2013051200057', 40, 13, 9, 1, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (163, 'RK-2013051200058', 40, 13, 8, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (164, 'RK-2013051200059', 40, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1175, NULL);
INSERT INTO `storage` VALUES (165, 'RK-2013051200060', 41, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1075, NULL);
INSERT INTO `storage` VALUES (166, 'RK-2013051200061', 42, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1077, NULL);
INSERT INTO `storage` VALUES (167, 'RK-2013051200061', 42, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1077, NULL);
INSERT INTO `storage` VALUES (168, 'RK-2013051200061', 42, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1077, NULL);
INSERT INTO `storage` VALUES (169, 'RK-2013051200062', 42, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1077, NULL);
INSERT INTO `storage` VALUES (170, 'RK-2013051200064', 41, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1175, NULL);
INSERT INTO `storage` VALUES (171, 'RK-2013051200064', 41, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1175, NULL);
INSERT INTO `storage` VALUES (172, 'RK-2013051200066', 40, 13, 6, 8, '2013-05-12', 0, '0', NULL, 1078, NULL);
INSERT INTO `storage` VALUES (173, 'RK-2013051200068', 40, 13, 6, 0, '2013-05-12', 0, '0', NULL, 1073, NULL);
INSERT INTO `storage` VALUES (174, 'RK-2013051200069', 41, 13, 10, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (175, 'RK-2013051200086', 42, 13, 8, 0, '2013-05-12', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (176, 'RK-2013051300001', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (177, 'RK-2013051300004', 40, 13, 8, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (178, 'RK-2013051300005', 40, 13, 6, 0, '2013-05-13', 0, '0', NULL, 1177, NULL);
INSERT INTO `storage` VALUES (179, 'RK-2013051300006', 40, 13, 6, 0, '2013-05-13', 0, '0', NULL, 1078, NULL);
INSERT INTO `storage` VALUES (180, 'RK-2013051300006', 40, 13, 6, 0, '2013-05-13', 0, '0', NULL, 1078, NULL);
INSERT INTO `storage` VALUES (181, 'RK-2013051300007', 42, 13, 6, 1, '2013-05-13', 0, '0', NULL, 1175, NULL);
INSERT INTO `storage` VALUES (182, 'RK-2013051300010', 40, 13, 6, 1, '2013-05-13', 0, '0', NULL, 1073, NULL);
INSERT INTO `storage` VALUES (183, 'RK-2013051300012', 40, 13, 6, 0, '2013-05-13', 0, '0', NULL, 1078, NULL);
INSERT INTO `storage` VALUES (184, 'RK-2013051300013', 40, 13, 10, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (185, 'RK-2013051300015', 40, 13, 8, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (186, 'RK-2013051300016', 40, 13, 8, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (187, 'RK-2013051300016', 40, 13, 8, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (188, 'RK-2013051300040', 40, 13, 8, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (189, 'RK-2013051300041', 41, 13, 8, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (190, 'RK-2013051300042', 40, 13, 8, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (191, 'RK-2013051300043', 40, 13, 8, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (192, 'RK-2013051300002', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (193, 'RK-2013051300052', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (194, 'RK-2013051300005', 41, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (195, 'RK-2013051300055', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (196, 'RK-2013051300056', 41, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (197, 'RK-2013051300057', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (198, 'RK-2013051300007', 42, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (199, 'RK-2013051300009', 42, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (200, 'RK-2013051300010', 42, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (201, 'RK-2013051300002', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (202, 'RK-2013051300063', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (203, 'RK-2013051300004', 40, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (204, 'RK-2013051300064', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (205, 'RK-2013051300064', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (206, 'RK-2013051300064', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (207, 'RK-2013051300065', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (208, 'RK-2013051300066', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (209, 'RK-2013051300067', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (210, 'RK-2013051300068', 40, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (211, 'RK-2013051300007', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (212, 'RK-2013051300009', 40, 13, 10, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (213, 'RK-2013051300010', 40, 13, 10, 0, '2013-05-13', 0, '0', '', NULL, NULL);
INSERT INTO `storage` VALUES (214, 'RK-2013051300011', 43, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (215, 'RK-2013051300012', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (216, 'RK-2013051300013', 41, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (217, 'RK-2013051300014', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (218, 'RK-2013051300016', 40, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (219, 'RK-2013051300017', 42, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (220, 'RK-2013051300018', 43, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (221, 'RK-2013051300021', 41, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (222, 'RK-2013051300023', 43, 13, 9, 0, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (223, 'RK-2013051300015', 40, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (224, 'RK-2013051300017', 40, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (225, 'RK-2013051300019', 41, 13, 8, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (226, 'RK-2013051300024', 42, 13, 9, 1, '2013-05-13', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (227, 'RK-2013051300025', 40, 13, 6, 1, '2013-05-13', 0, '0', NULL, 1077, NULL);
INSERT INTO `storage` VALUES (228, 'RK-2013051400005', 40, 13, 9, 1, '2013-05-14', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (229, 'RK-2013051500004', 40, 13, 9, 1, '2013-05-15', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (230, 'RK-2013051500005', 41, 13, 9, 0, '2013-05-15', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (231, 'RK-2013052500001', 40, 13, 9, 1, '2013-05-25', 500, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (232, 'RK-2013052500002', 41, 13, 8, 1, '2013-05-25', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (233, 'RK-2013052500004', 44, 13, 10, 1, '2013-05-25', 1000, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (234, 'RK-2013052500007', 40, 13, 9, 1, '2013-05-25', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (235, 'RK-2013053100005', 47, 13, 9, 1, '2013-05-31', 2500, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (236, 'RK-2013053100006', 47, 13, 9, 1, '2013-05-31', 4000, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (237, 'RK-2013053100007', 46, 13, 9, 1, '2013-05-31', 5000, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (238, 'RK-2013053100008', 40, 13, 8, 1, '2013-05-31', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (239, 'RK-2013053100011', 40, 13, 9, 1, '2013-05-31', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (240, 'RK-2013053100012', 47, 13, 9, 1, '2013-05-31', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (241, 'RK-2013060400026', 41, 13, 9, 1, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (242, 'RK-2013060400027', 41, 13, 9, 0, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (243, 'RK-2013060400029', 41, 13, 9, 8, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (244, 'RK-2013060400096', 41, 13, 9, 0, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (245, 'RK-2013060400112', 41, 13, 9, 0, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (246, 'RK-2013060400119', 42, 13, 9, 0, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (247, 'RK-2013060400040', 40, 13, 9, 1, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (248, 'RK-2013060400041', 40, 13, 9, 1, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (249, 'RK-2013060400124', 40, 13, 9, 1, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (250, 'RK-2013060400126', 44, 13, 9, 1, '2013-06-04', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (251, 'RK-2013060500023', 41, 13, 9, 1, '2013-06-05', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (252, 'RK-2013060500024', 41, 13, 9, 1, '2013-06-05', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (253, 'RK-2013060500025', 41, 13, 9, 1, '2013-06-05', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (254, 'RK-2013060500029', 41, 13, 9, 1, '2013-06-05', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (255, 'RK-2013060500048', 41, 13, 9, 0, '2013-06-05', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (256, 'RK-2013060700014', 40, 13, 6, 1, '2013-06-07', 0, '0', NULL, 1077, NULL);
INSERT INTO `storage` VALUES (257, 'RK-2013060800004', 40, 13, 9, 1, '2013-06-08', 0, '0', NULL, NULL, NULL);
INSERT INTO `storage` VALUES (258, 'RK-2013060800005', 41, 13, 9, 1, '2013-06-08', 0, '0', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for storageinfo
-- ----------------------------
DROP TABLE IF EXISTS `storageinfo`;
CREATE TABLE `storageinfo`  (
  `storageInfoId` int(11) NOT NULL AUTO_INCREMENT,
  `storageId` int(11) NOT NULL,
  `toOrderId` int(11) NULL DEFAULT NULL,
  `incomeid` int(11) NULL DEFAULT NULL,
  `purorderid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`storageInfoId`) USING BTREE,
  INDEX `FK_storageInfo_storage`(`storageId`) USING BTREE,
  INDEX `FK_storageInfo_purorder`(`purorderid`) USING BTREE,
  CONSTRAINT `FK_storageInfo_purorder` FOREIGN KEY (`purorderid`) REFERENCES `purorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_storageInfo_storage` FOREIGN KEY (`storageId`) REFERENCES `storage` (`storageId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of storageinfo
-- ----------------------------

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cardid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplier_company` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplier_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bank_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplier_origin` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zip_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `admin` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `QQ` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `facsimile` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 141 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES (128, '广东省电信珠海分公司', '', '广东省电信珠海分公司', '广东省珠海市信息大厦', '', '内部', '0756-3299329', '13492522955', '', '519000', '2011-12-22', 'sohoer', '', '', '0');
INSERT INTO `supplier` VALUES (129, '巧致集团', '43102119880303004X', '巧致国际有限公司', '深圳南山区深南香蜜立交天创大厦4509室', '6222021911000445939', '网站网络', '15073593311', '18648777311', 'qzgj@163.com', '518000', '2011-12-28', '12002', '123456', '0755236536', '1');
INSERT INTO `supplier` VALUES (130, '山东省联通集团滨州分公司', '', '山东省联通集团滨州分公司', '山东省滨州市黄河五部377号网通大厦', '', '内部', '18654310318', '18654510318', '', '', '2007-01-15', 'sohoer', '', '', '0');
INSERT INTO `supplier` VALUES (131, '滨州石油管道局双线机房', '', '福奥科技', '滨州石油管道局', '', '内部结算', '', '18654808098', '', '', '2011-10-09', 'sohoer', '', '', '0');
INSERT INTO `supplier` VALUES (132, '大庆数据中心', '230121198305030216', '大庆数据中心123.183.208.219,125.211.222.14 ', '哈尔滨市南岗区南直路181-9盟科视界9B23层', '', 'QQ', '13634881685', '13634581685', '6841845@qq.com', '', '2012-10-11', '16017', '6841845', '', '0');
INSERT INTO `supplier` VALUES (133, '许昌市华方信息技术有限公司', '412728198503070553', '许昌市华方信息技术有限公司218.29.176.219', '河南省许昌市八一路和万丰路菁华名家2A2单元2楼201室 ', '', 'http://www.dnsor.com', '0374-2775771', '13639465771', 'admin@dnsor.com', '', '2012-10-10', '16017', '97656470', '', '0');
INSERT INTO `supplier` VALUES (134, '济源浩诚文化传媒有限公司', '410881198112112010', '济源浩诚文化传媒有限公司222.89.39.35', '河南省济源市凯旋城C2-118号', '', '', '0391-6680077', '15539202030', 'longya2002@163.com', '459000', '2012-10-12', '16017', '5716311', '03916680077', '0');
INSERT INTO `supplier` VALUES (135, '江龙平', '360430198312586915', '四川省商众联信息产业有限公司', '成都市科华北路43号商众联办公楼', '75603700', '', '028-85408009', '13806852112', '105125214@qq.com', '610065', '2012-10-15', '13025', '105125214', '028-85408009-805', '0');
INSERT INTO `supplier` VALUES (136, '厦门易企网络科技有限公司', '350524198903095659', '易企网络科技有限公司ip:218.5.74.173', '厦门市湖里区吕岭路77号长安大厦4E', '', '陈全福', '0592-3680800', '13860149456', '2581314966@QQ.COM', '361000', '2012-10-15', '16017', '2581314966', '', '0');
INSERT INTO `supplier` VALUES (137, '首页互联科技发展有限公司', '360502199104011314', '首页互联科技发展有限公司', '南昌市八一大道洪城数码广场B座401', '', ' liantianzhe@163.com', ' 15390893669', '15330893669', '104169336@qq.com', '338000', '2012-10-18', '13031', '104169336', '', '0');
INSERT INTO `supplier` VALUES (138, '德州福瑞德家具', '', '德州福瑞德家具厂', '德州市湖滨路天衢工业园', '', '', '', '13604342253', '', '', '2012-11-18', '33002', '', '', '0');
INSERT INTO `supplier` VALUES (139, '新质科技深圳总部', '', '新质科技', '深圳宝安区', '', '', '', '18610235678', '', '', '2012-12-18', '33002', '', '', '0');
INSERT INTO `supplier` VALUES (140, '中国联通', '', '德州联通', '德州市湖滨路', '', '', '', '18653644976', '', '', '2013-01-09', '33002', '', '', '0');

-- ----------------------------
-- Table structure for t_cabinet
-- ----------------------------
DROP TABLE IF EXISTS `t_cabinet`;
CREATE TABLE `t_cabinet`  (
  `caid` int(11) NOT NULL AUTO_INCREMENT,
  `electID` int(11) NULL DEFAULT NULL,
  `caname` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `casz` int(11) NULL DEFAULT NULL,
  `pmax` int(11) NULL DEFAULT NULL,
  `bwmax` int(11) NULL DEFAULT NULL,
  `maches` int(11) NULL DEFAULT NULL,
  `use_size` int(11) NULL DEFAULT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`caid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_cabinet
-- ----------------------------
INSERT INTO `t_cabinet` VALUES (57, NULL, '23', 23, 23, 23, 11, 1, NULL);
INSERT INTO `t_cabinet` VALUES (61, 49, '56', 56, 56, 56, 28, 3, NULL);
INSERT INTO `t_cabinet` VALUES (64, NULL, 'ZHJG-001', 54, 5000, 10000, 27, 0, 'cab');
INSERT INTO `t_cabinet` VALUES (65, 49, 'dg-05-01', 54, 1000, 1000, 27, 1, 'cab');
INSERT INTO `t_cabinet` VALUES (70, 49, 'aaa', 50, 23, 24, 25, 1, 'cab');
INSERT INTO `t_cabinet` VALUES (73, 62, 'JG001', 54, 2880, 1024, 1, 1, 'cab');
INSERT INTO `t_cabinet` VALUES (74, 63, 'JG001', 54, 2880, 1024, 1, 1, 'cab');
INSERT INTO `t_cabinet` VALUES (75, 67, 'FJ001', 54, 2880, 1024, 1, 1, 'cab');
INSERT INTO `t_cabinet` VALUES (76, 69, 'JG001', 54, 2880, 1024, 27, 0, 'cab');
INSERT INTO `t_cabinet` VALUES (77, 70, 'JG001', 54, 2880, 1024, 27, 14, 'cab');
INSERT INTO `t_cabinet` VALUES (78, 71, 'JG001', 54, 2880, 1024, 27, 4, 'cab');
INSERT INTO `t_cabinet` VALUES (79, 70, 'JG002', 54, 1500, 1000, 27, 0, 'cab');
INSERT INTO `t_cabinet` VALUES (80, 75, '深圳001001', 100, 24, 100, 50, 0, 'cab');

-- ----------------------------
-- Table structure for t_city
-- ----------------------------
DROP TABLE IF EXISTS `t_city`;
CREATE TABLE `t_city`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '地市表',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地市名称',
  `code` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地市编码',
  `pinyin` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `superid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `temp` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '述描',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_city
-- ----------------------------
INSERT INTO `t_city` VALUES (1, '广东', '020', 'guangdong', 0, '广东省');
INSERT INTO `t_city` VALUES (2, '山东', '0530', 'shandong', 0, '山东省');
INSERT INTO `t_city` VALUES (3, '北京', '010', 'beijing', -1, '北京直辖市');
INSERT INTO `t_city` VALUES (4, '贵州', '0850', 'guizhou', 0, '贵州省');
INSERT INTO `t_city` VALUES (5, '天津', '022', 'tianjin', -1, '天津直辖市');
INSERT INTO `t_city` VALUES (6, '重庆', '023', 'chongqing', -1, '重庆直辖市');
INSERT INTO `t_city` VALUES (7, '上海', '021', 'shanghai', -1, '上海直辖市');
INSERT INTO `t_city` VALUES (8, '四川', '028', 'sichuan', 0, '四川省');
INSERT INTO `t_city` VALUES (9, '滨州', '0543', 'binzhou', 2, '山东省滨州市');
INSERT INTO `t_city` VALUES (10, '德州', '0534', 'dezhou', 2, '山东省德州市');
INSERT INTO `t_city` VALUES (11, '秦皇岛', '0335', 'qinhuangdao', 12, '河北秦皇岛');
INSERT INTO `t_city` VALUES (12, '河北', '0310', 'hebei', 0, '河北省');
INSERT INTO `t_city` VALUES (13, '济南', '0531', '济南', 2, '山东济南');
INSERT INTO `t_city` VALUES (14, '贵阳', '0851', 'guiyang', 4, '贵州省贵阳市');
INSERT INTO `t_city` VALUES (15, '珠海', '0756', 'zhuhai', 1, '广东省珠海市');
INSERT INTO `t_city` VALUES (16, '东莞', '0769', 'dongguan', 1, '广东省东莞市');
INSERT INTO `t_city` VALUES (17, '成都', '028', 'chengdu', 8, '四川省成都市');

-- ----------------------------
-- Table structure for t_electhouse
-- ----------------------------
DROP TABLE IF EXISTS `t_electhouse`;
CREATE TABLE `t_electhouse`  (
  `electID` int(11) NOT NULL AUTO_INCREMENT,
  `superid` int(11) NULL DEFAULT NULL,
  `electName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `electPosition` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `electTel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `electAdmPhone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `electAdmin` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `showcode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cityid` int(11) NULL DEFAULT NULL,
  `electCode` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`electID`) USING BTREE,
  INDEX `cityid`(`cityid`) USING BTREE,
  CONSTRAINT `t_electHouse_ibfk_1` FOREIGN KEY (`cityid`) REFERENCES `t_city` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_electhouse
-- ----------------------------
INSERT INTO `t_electhouse` VALUES (36, 0, '珠海电信库房', '广东珠海', '07552955871', '18654300883', '冷志勇', '0500', 15, '0100');
INSERT INTO `t_electhouse` VALUES (42, 0, '东莞联通', '河南少林', '0452-5632985', '1235645652', '张三', '0500', 16, '0200');
INSERT INTO `t_electhouse` VALUES (43, 0, '东莞电信', '东莞市', '454136', '15625665633', '张三', '0500', 16, '0300');
INSERT INTO `t_electhouse` VALUES (45, 0, '滨州联通', '滨州', '07552955871', '18654300883', '冷志勇', '0500', 9, '0500');
INSERT INTO `t_electhouse` VALUES (47, 0, '德州联通库房', '山东库房', '07552955871', '18654300883', '冷志勇', '0500', 10, '0700');
INSERT INTO `t_electhouse` VALUES (49, 1, '东莞电信', '东莞市', '454136', '15625665633', '张三', '0500', 16, '0301');
INSERT INTO `t_electhouse` VALUES (61, 0, '滨州双线', '滨州', '07552955871', '18654300883', '冷志勇', '0500', 9, '0600');
INSERT INTO `t_electhouse` VALUES (62, 1, 'FJ001', '滨州', '07552955871', '18654300883', '冷志勇', '0500', 9, '0601');
INSERT INTO `t_electhouse` VALUES (63, 1, 'FJ001', '滨州', '07552955871', '18654300883', '冷志勇', '0500', 9, '0501');
INSERT INTO `t_electhouse` VALUES (66, 0, '北京石景山库房', '北京石景山', '07552955871', '18654300883', '冷志勇', '0500', 3, '0800');
INSERT INTO `t_electhouse` VALUES (67, 1, 'FJ001', '北京石景山', '07552955871', '18654300883', '冷志勇', '0500', 3, '0801');
INSERT INTO `t_electhouse` VALUES (68, 0, '秦皇岛电信机房', '河北秦皇岛', '07552955871', '18654300883', '冷志勇', '0500', 11, '0900');
INSERT INTO `t_electhouse` VALUES (69, 1, 'FJ001', '河北秦皇岛', '07552955871', '18654300883', '冷志勇', '0500', 11, '0901');
INSERT INTO `t_electhouse` VALUES (70, 1, 'FJ001', '广东珠海', '07552955871', '18654300883', '冷志勇', '0500', 15, '0101');
INSERT INTO `t_electhouse` VALUES (71, 1, 'FJ001', '山东库房', '07552955871', '18654300883', '冷志勇', '0500', 10, '0701');
INSERT INTO `t_electhouse` VALUES (72, 0, '深圳001', '深圳', '12345678', '13041526341', 'aaa', '0500', 17, '1000');
INSERT INTO `t_electhouse` VALUES (73, 0, '深圳01', '广东', '12345678', '13025415263', 'admin', '0500', 5, '1100');
INSERT INTO `t_electhouse` VALUES (74, 0, '深圳电信库房', '广东深圳', '12345678', '15023652145', 'admin', '0500', 15, '1200');
INSERT INTO `t_electhouse` VALUES (75, 1, '深圳001', '深圳', '12345678', '13041526341', 'aaa', '0500', 17, '1001');

-- ----------------------------
-- Table structure for t_ipconfiguration
-- ----------------------------
DROP TABLE IF EXISTS `t_ipconfiguration`;
CREATE TABLE `t_ipconfiguration`  (
  `ipcID` int(11) NOT NULL AUTO_INCREMENT,
  `properID` int(11) NULL DEFAULT NULL,
  `depoID` int(11) NULL DEFAULT NULL,
  `ipcname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ipcaddress` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ipcarrier` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ipcstate` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `upNo` int(11) NULL DEFAULT NULL,
  `isblack` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ipcID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_ipconfiguration
-- ----------------------------
INSERT INTO `t_ipconfiguration` VALUES (12, 121, 43, '183.61.15.94', '183.61.15.94', '珠海电信', '1', 70, '0');
INSERT INTO `t_ipconfiguration` VALUES (13, 121, 44, '218.57.224.72', '218.57.224.72', '德州联通', '1', 69, '0');
INSERT INTO `t_ipconfiguration` VALUES (14, 121, 43, '183.61.15.74', '183.61.15.74', '珠海电信', '1', 63, '0');
INSERT INTO `t_ipconfiguration` VALUES (15, 121, 43, '183.61.15.100', '183.61.15.100', '珠海电信', '1', 61, '0');
INSERT INTO `t_ipconfiguration` VALUES (16, 121, 43, '183.61.15.88', '183.61.15.88', '珠海电信', '1', 60, '0');
INSERT INTO `t_ipconfiguration` VALUES (17, 121, 44, '218.57.224.71', '218.57.224.71', '德州联通', '1', 56, '0');
INSERT INTO `t_ipconfiguration` VALUES (18, 121, 44, '183.61.15.86', '183.61.15.86', '德州联通', '1', 55, '0');
INSERT INTO `t_ipconfiguration` VALUES (19, 121, 43, '218.58.232.144', '218.58.232.144', '珠海电信', '1', 48, '0');
INSERT INTO `t_ipconfiguration` VALUES (20, 121, 41, '60.217.58.105', '60.217.58.105', '滨州联通', '1', 47, '0');
INSERT INTO `t_ipconfiguration` VALUES (21, 121, 44, '218.57.224.76', '218.57.224.76', '德州联通', '1', 46, '0');
INSERT INTO `t_ipconfiguration` VALUES (22, 121, 43, '183.61.15.82', '183.61.15.82', '珠海电信', '1', 45, '0');
INSERT INTO `t_ipconfiguration` VALUES (23, 121, 44, '218.57.224.75', '218.57.224.75', '德州联通', '1', 41, '0');
INSERT INTO `t_ipconfiguration` VALUES (24, 121, 43, '183.61.15.69', '183.61.15.69', '珠海电信', '1', 28, '0');
INSERT INTO `t_ipconfiguration` VALUES (25, 121, 43, '183.61.15.58', '183.61.15.58', '珠海电信', '1', 32, '0');
INSERT INTO `t_ipconfiguration` VALUES (26, 121, 43, '183.61.15.60', '183.61.15.60', '珠海电信', '1', 28, '0');
INSERT INTO `t_ipconfiguration` VALUES (27, 121, 43, '183.61.15.59', '183.61.15.59', '珠海电信', '1', 26, '0');
INSERT INTO `t_ipconfiguration` VALUES (28, 121, 43, '183.61.15.76', '183.61.15.76', '珠海电信', '1', 24, '0');
INSERT INTO `t_ipconfiguration` VALUES (29, 121, 43, '183.61.15.62', '183.61.15.62', '珠海电信', '1', 23, '0');
INSERT INTO `t_ipconfiguration` VALUES (30, 121, 43, '183.61.15.75', '183.61.15.75', '珠海电信', '1', 22, '0');
INSERT INTO `t_ipconfiguration` VALUES (31, 121, 43, '183.61.15.63', '183.61.15.63', '珠海电信', '1', 20, '0');
INSERT INTO `t_ipconfiguration` VALUES (32, 121, 43, '183.61.15.61', '183.61.15.61', '珠海电信', '1', 19, '0');
INSERT INTO `t_ipconfiguration` VALUES (33, 121, 41, '60.217.58.115', '60.217.58.115', '滨州联通', '1', 18, '0');
INSERT INTO `t_ipconfiguration` VALUES (34, 121, 43, '183.61.15.64', '183.61.15.64', '珠海电信', '1', 16, '0');
INSERT INTO `t_ipconfiguration` VALUES (35, 121, 43, '183.61.15.83', '183.61.15.83', '珠海电信', '1', 65, '0');
INSERT INTO `t_ipconfiguration` VALUES (36, 121, 43, '183.61.15.91', '183.61.15.91', '珠海电信', '1', 65, '0');
INSERT INTO `t_ipconfiguration` VALUES (37, 121, 43, '183.61.15.92', '183.61.15.92', '珠海电信', '1', 65, '0');
INSERT INTO `t_ipconfiguration` VALUES (38, 121, 43, '183.61.15.93', '183.61.15.93', '珠海电信', '1', 65, '0');
INSERT INTO `t_ipconfiguration` VALUES (39, 121, 44, '218.57.224.70', '218.57.224.70', '德州联通', '1', 62, '0');
INSERT INTO `t_ipconfiguration` VALUES (40, 121, 44, '218.57.224.79', '218.57.224.79', '德州联通', '1', 62, '0');
INSERT INTO `t_ipconfiguration` VALUES (41, 121, 44, '218.57.224.80', '218.57.224.80', '德州联通', '1', 62, '0');
INSERT INTO `t_ipconfiguration` VALUES (42, 121, 44, '218.57.224.81', '218.57.224.81', '德州联通', '1', 62, '0');
INSERT INTO `t_ipconfiguration` VALUES (43, 121, 44, '218.57.224.82', '218.57.224.82', '德州联通', '1', 62, '0');
INSERT INTO `t_ipconfiguration` VALUES (44, 121, 45, '218.58.232.148', '218.58.232.148', '滨州双线', '1', 59, '0');
INSERT INTO `t_ipconfiguration` VALUES (45, 121, 45, '58.59.97.34', '58.59.97.34', '滨州双线', '1', 57, '0');
INSERT INTO `t_ipconfiguration` VALUES (46, 121, 44, '218.57.224.73', '218.57.224.73', '德州联通', '1', 40, '0');
INSERT INTO `t_ipconfiguration` VALUES (47, 121, 44, '218.57.224.74', '218.57.224.74', '德州联通', '1', 40, '0');
INSERT INTO `t_ipconfiguration` VALUES (48, 121, 43, '183.61.15.70', '183.61.15.70', '珠海电信', '1', 38, '0');
INSERT INTO `t_ipconfiguration` VALUES (49, 121, 43, '183.61.15.71', '183.61.15.71', '珠海电信', '1', 38, '0');
INSERT INTO `t_ipconfiguration` VALUES (50, 121, 43, '183.61.15.65', '183.61.15.65', '珠海电信', '1', 33, '0');
INSERT INTO `t_ipconfiguration` VALUES (51, 121, 43, '183.61.15.66', '183.61.15.66', '珠海电信', '1', 33, '0');
INSERT INTO `t_ipconfiguration` VALUES (52, 121, 43, '183.61.15.67', '183.61.15.67', '珠海电信', '1', 33, '0');
INSERT INTO `t_ipconfiguration` VALUES (53, 121, 43, '183.61.15.68', '183.61.15.68', '珠海电信', '1', 33, '0');
INSERT INTO `t_ipconfiguration` VALUES (54, 121, 43, '183.61.15.51', '183.61.15.51', '珠海电信', '1', 31, '0');
INSERT INTO `t_ipconfiguration` VALUES (55, 121, 43, '183.61.15.52', '183.61.15.52', '珠海电信', '1', 31, '0');
INSERT INTO `t_ipconfiguration` VALUES (56, 121, 43, '183.61.15.54', '183.61.15.54', '珠海电信', '1', 30, '0');
INSERT INTO `t_ipconfiguration` VALUES (57, 121, 43, '183.61.15.55', '183.61.15.55', '珠海电信', '1', 30, '0');
INSERT INTO `t_ipconfiguration` VALUES (58, 121, 43, '183.61.15.53', '183.61.15.53', '珠海电信', '1', 25, '0');
INSERT INTO `t_ipconfiguration` VALUES (59, 121, 43, '183.61.15.87', '183.61.15.87', '珠海电信', '1', 25, '0');
INSERT INTO `t_ipconfiguration` VALUES (60, 121, 43, '183.61.15.90', '183.61.15.90', '珠海电信', '1', 65, '0');
INSERT INTO `t_ipconfiguration` VALUES (61, 121, 43, '183.61.14.1', '183.61.14.1', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (62, 121, 43, '183.61.14.2', '183.61.14.2', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (63, 121, 43, '183.61.14.3', '183.61.14.3', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (64, 121, 43, '183.61.14.4', '183.61.14.4', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (65, 121, 43, '183.61.14.5', '183.61.14.5', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (66, 121, 43, '183.61.14.6', '183.61.14.6', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (67, 121, 43, '183.61.14.7', '183.61.14.7', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (68, 121, 43, '183.61.14.8', '183.61.14.8', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (69, 121, 43, '183.61.14.9', '183.61.14.9', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (70, 121, 43, '183.61.14.10', '183.61.14.10', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (71, 121, 43, '183.61.14.11', '183.61.14.11', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (72, 121, 43, '183.61.14.12', '183.61.14.12', '珠海电信', '1', 37, '0');
INSERT INTO `t_ipconfiguration` VALUES (85, 121, 44, '60.217.58.208', '60.217.58.208', '滨州联通', '1', 44, '0');
INSERT INTO `t_ipconfiguration` VALUES (86, 121, 45, '58.59.97.37', '58.59.97.37', '滨州双线', '1', 54, '0');
INSERT INTO `t_ipconfiguration` VALUES (88, 121, 45, '218.58.232.35', '218.58.232.35', '滨州双线', '1', 59, '0');
INSERT INTO `t_ipconfiguration` VALUES (89, 121, 45, '218.58.232.141', '218.58.232.141', '滨州双线', '1', NULL, '0');
INSERT INTO `t_ipconfiguration` VALUES (90, 121, 43, '218.57.224', '218.57.224.65', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (91, 121, 43, '218.57.224', '218.57.224.66', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (92, 121, 43, '218.57.224', '218.57.224.67', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (93, 121, 43, '218.57.224', '218.57.224.68', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (94, 121, 43, '218.57.224', '218.57.224.69', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (95, 121, 43, '218.57.224', '218.57.224.70', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (96, 121, 43, '218.57.224', '218.57.224.71', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (97, 121, 43, '218.57.224', '218.57.224.72', '珠海电信', '1', 69, NULL);
INSERT INTO `t_ipconfiguration` VALUES (98, 121, 43, '218.57.224', '218.57.224.73', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (99, 121, 43, '218.57.224', '218.57.224.74', '珠海电信', '1', 40, NULL);
INSERT INTO `t_ipconfiguration` VALUES (100, 121, 43, '218.57.224', '218.57.224.75', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (101, 121, 43, '218.57.224', '218.57.224.76', '珠海电信', '1', 46, NULL);
INSERT INTO `t_ipconfiguration` VALUES (102, 121, 43, '218.57.224', '218.57.224.77', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (103, 121, 43, '218.57.224', '218.57.224.78', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (104, 121, 43, '218.57.224', '218.57.224.79', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (105, 121, 43, '218.57.224', '218.57.224.80', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (106, 121, 43, '218.57.224', '218.57.224.81', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (107, 121, 43, '218.57.224', '218.57.224.82', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (108, 121, 43, '218.57.224', '218.57.224.83', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (109, 121, 43, '218.57.224', '218.57.224.84', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (110, 121, 43, '218.57.224', '218.57.224.85', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (111, 121, 43, '218.57.224', '218.57.224.86', '珠海电信', '1', 74, NULL);
INSERT INTO `t_ipconfiguration` VALUES (112, 121, 43, '218.57.224', '218.57.224.87', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (113, 121, 43, '218.57.224', '218.57.224.88', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (114, 121, 43, '218.57.224', '218.57.224.89', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (115, 121, 43, '218.57.224', '218.57.224.90', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (116, 121, 40, '0000', '100.10.0.1', '000', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (117, 121, 40, '0000', '100.10.0.2', '000', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (118, 121, 40, '测试', '123.1.2.2', '测试', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (119, 121, 43, '183.61.15.105', '183.61.15.105', '珠海电信', '0', NULL, NULL);
INSERT INTO `t_ipconfiguration` VALUES (120, 121, 44, '218.57.224.91', '218.57.224.91', '德州联通', '1', 44, NULL);

-- ----------------------------
-- Table structure for t_logtab
-- ----------------------------
DROP TABLE IF EXISTS `t_logtab`;
CREATE TABLE `t_logtab`  (
  `loid` int(11) NOT NULL AUTO_INCREMENT,
  `looper` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `loadmin` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `loTime` datetime NULL DEFAULT NULL,
  `upsid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`loid`) USING BTREE,
  INDEX `log_produt`(`upsid`) USING BTREE,
  CONSTRAINT `log_produt` FOREIGN KEY (`upsid`) REFERENCES `upserver` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_logtab
-- ----------------------------

-- ----------------------------
-- Table structure for t_resourcecheck
-- ----------------------------
DROP TABLE IF EXISTS `t_resourcecheck`;
CREATE TABLE `t_resourcecheck`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '资源核实单表',
  `empid` int(20) NULL DEFAULT NULL COMMENT '申请人id',
  `cid` int(20) NOT NULL COMMENT '地区t_city表id',
  `tid` int(20) NULL DEFAULT NULL COMMENT 't_electHosch机房表id',
  `rvid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源核实单编号',
  `pid` int(20) NULL DEFAULT NULL COMMENT 'product产品表的id',
  `starttime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请时间',
  `isstate` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态(0未审批 1-已审批 2-已回复)',
  `eid` int(20) NULL DEFAULT NULL COMMENT '回复人',
  `conent` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复内容',
  `temp1` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备份1',
  `temp2` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备份2',
  `temp3` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备份3',
  `audtitingFlag` int(11) NULL DEFAULT NULL COMMENT '审批标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_resourcecheck
-- ----------------------------

-- ----------------------------
-- Table structure for t_saledflow
-- ----------------------------
DROP TABLE IF EXISTS `t_saledflow`;
CREATE TABLE `t_saledflow`  (
  `df_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售流程',
  `saleod_id` int(11) NULL DEFAULT NULL,
  `df_content` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `df_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间',
  `df_stat` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '确定是否选用超连接',
  PRIMARY KEY (`df_id`) USING BTREE,
  INDEX `saleod_id`(`saleod_id`) USING BTREE,
  CONSTRAINT `t_saledFlow_ibfk_1` FOREIGN KEY (`saleod_id`) REFERENCES `saleorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_saledflow
-- ----------------------------

-- ----------------------------
-- Table structure for taskplan_saleorder
-- ----------------------------
DROP TABLE IF EXISTS `taskplan_saleorder`;
CREATE TABLE `taskplan_saleorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '项目任务和订单合同的中间表',
  `taskid` int(11) NOT NULL COMMENT '项目任务ID',
  `saleorderid` int(11) NOT NULL COMMENT '订单或者合同ID',
  `flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标识符',
  `status` int(11) NULL DEFAULT NULL COMMENT '申批状态。０通过，１拒绝',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of taskplan_saleorder
-- ----------------------------
INSERT INTO `taskplan_saleorder` VALUES (1, 327, 30, 'PurOrder', 1);
INSERT INTO `taskplan_saleorder` VALUES (2, 327, 29, 'PurOrder', 1);
INSERT INTO `taskplan_saleorder` VALUES (3, 327, 31, 'PurOrder', 1);
INSERT INTO `taskplan_saleorder` VALUES (4, 377, 230, 'Storage', 1);

-- ----------------------------
-- Table structure for toorder
-- ----------------------------
DROP TABLE IF EXISTS `toorder`;
CREATE TABLE `toorder`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) NULL DEFAULT NULL,
  `piciNO` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `totime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `buytype` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deliverytType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deliveryTime` datetime NULL DEFAULT NULL,
  `deliveryer` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deliveryaddress` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `supplieraddress` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payappoint` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isBilling` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `billingType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payAppointType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `paytraffic` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trafficOrdernum` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `orderGross` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trafficcompany` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trafficLinkman` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `trafficphone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `grossmoney` float NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transacter` int(11) NULL DEFAULT NULL,
  `transactdept` int(11) NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `toOrderNum` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `toOrderVerify` int(11) NULL DEFAULT NULL COMMENT '核审状态',
  `storageState` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `FK__returnOrd__toOrd__0662F0A3`(`transactdept`) USING BTREE,
  INDEX `FK_toOrder_employee`(`transacter`) USING BTREE,
  INDEX `FK_toOrder_purOrder`(`orderid`) USING BTREE,
  CONSTRAINT `FK__returnOrd__toOrd__0662F0A3` FOREIGN KEY (`transactdept`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_toOrder_employee` FOREIGN KEY (`transacter`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_toOrder_purOrder` FOREIGN KEY (`orderid`) REFERENCES `purorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of toorder
-- ----------------------------

-- ----------------------------
-- Table structure for toorderprintfo
-- ----------------------------
DROP TABLE IF EXISTS `toorderprintfo`;
CREATE TABLE `toorderprintfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `toOrderId` int(11) NULL DEFAULT NULL,
  `toPrId` int(11) NULL DEFAULT NULL,
  `Realitynum` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `character` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_toOrderprintfo_purOrder`(`toPrId`) USING BTREE,
  INDEX `FK_toOrderprinfo_toOrder`(`toOrderId`) USING BTREE,
  CONSTRAINT `FK_toOrderprinfo_toOrder` FOREIGN KEY (`toOrderId`) REFERENCES `toorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_toOrderprintfo_purOrder` FOREIGN KEY (`toPrId`) REFERENCES `purorderinfo` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of toorderprintfo
-- ----------------------------

-- ----------------------------
-- Table structure for tree
-- ----------------------------
DROP TABLE IF EXISTS `tree`;
CREATE TABLE `tree`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) UNSIGNED NOT NULL,
  `position` int(10) UNSIGNED NOT NULL,
  `sleft` int(10) UNSIGNED NOT NULL,
  `sright` int(10) UNSIGNED NOT NULL,
  `level` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tree
-- ----------------------------

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ssosyRealmName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delFlag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of type
-- ----------------------------

-- ----------------------------
-- Table structure for updatecache
-- ----------------------------
DROP TABLE IF EXISTS `updatecache`;
CREATE TABLE `updatecache`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户更新缓存记录表ID',
  `customerId` int(11) NULL DEFAULT NULL COMMENT '外键 客户表id',
  `domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网站域名',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新内容',
  `result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行结果',
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行时间',
  `tmp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `tmp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `tmp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `tmp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customerId`(`customerId`) USING BTREE,
  CONSTRAINT `updatecache_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of updatecache
-- ----------------------------

-- ----------------------------
-- Table structure for upserver
-- ----------------------------
DROP TABLE IF EXISTS `upserver`;
CREATE TABLE `upserver`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NULL DEFAULT NULL COMMENT '父ID',
  `uptime` datetime NULL DEFAULT NULL,
  `downtime` datetime NULL DEFAULT NULL,
  `saleId` int(11) NULL DEFAULT NULL,
  `serverId` int(11) NULL DEFAULT NULL,
  `empId` int(11) NULL DEFAULT NULL,
  `maintenancePass` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bandwidthAmount` int(11) NULL DEFAULT NULL,
  `bandwidthThrottling` int(11) NULL DEFAULT NULL,
  `audtitingFlag` int(19) NULL DEFAULT NULL,
  `upFlag` int(11) NULL DEFAULT NULL,
  `upNo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delflag` int(11) NULL DEFAULT NULL,
  `serverIp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ipnum` int(11) NULL DEFAULT NULL COMMENT 'ip数量',
  `customerId` int(11) NULL DEFAULT NULL COMMENT '客户id',
  `serverLocation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机房位置',
  `temp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注备',
  `jhjname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `port` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `jgh` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `caid` int(11) NULL DEFAULT NULL,
  `markNum` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `housesAndRooms` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `soid` int(11) NULL DEFAULT NULL,
  `conkoutid` int(10) NULL DEFAULT NULL,
  `remarks` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_upServer_employee`(`empId`) USING BTREE,
  INDEX `FK_upServer_product`(`serverId`) USING BTREE,
  INDEX `FK_upServer_saleOrder`(`saleId`) USING BTREE,
  CONSTRAINT `FK_upServer_employee` FOREIGN KEY (`empId`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_upServer_product` FOREIGN KEY (`serverId`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_upServer_saleOrder` FOREIGN KEY (`saleId`) REFERENCES `saleorder` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of upserver
-- ----------------------------

-- ----------------------------
-- Table structure for user_group_info
-- ----------------------------
DROP TABLE IF EXISTS `user_group_info`;
CREATE TABLE `user_group_info`  (
  `User_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `supergroupIds` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `groupIDs` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `resourcePermission` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问资源权限',
  PRIMARY KEY (`User_group_id`) USING BTREE,
  INDEX `FK__User_grou__userI__5BE2A6F2`(`userID`) USING BTREE,
  CONSTRAINT `FK__User_grou__userI__5BE2A6F2` FOREIGN KEY (`userID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 276 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user_group_info
-- ----------------------------
INSERT INTO `user_group_info` VALUES (274, 291, '32', '34', '');
INSERT INTO `user_group_info` VALUES (275, 292, '56', '57', '');

-- ----------------------------
-- Table structure for user_relation
-- ----------------------------
DROP TABLE IF EXISTS `user_relation`;
CREATE TABLE `user_relation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段关系表',
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'UUID唯一编码',
  `relationTypeId` int(11) NULL DEFAULT NULL COMMENT 'user_relationTypeSb 表主键（无外键）',
  `fbuuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `beanName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实体类名称',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称（如：家庭成员等）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段备注',
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp6` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp7` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp8` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp9` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp10` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp11` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp12` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp13` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp14` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp15` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp16` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp17` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp18` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp19` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp20` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user_relation
-- ----------------------------
INSERT INTO `user_relation` VALUES (1, '26dda417-f00d-4da7-ab7b-8d333500480d', 1, '26dda417-f00d-4da7-ab7b-8d333500480d', 'Employee', '小学', '小学阶段的学习', '2010-9-1', '2016-7-1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (2, '1dd01d4e-36e0-422f-8f19-3aa47a1c0c33', 1, '26dda417-f00d-4da7-ab7b-8d333500480d', 'Employee', '初中', '初中阶段的学习', '2011-11-28', '2014-11-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (4, '45fc344c-f5aa-44f3-b0a4-2a3e463c42b6', 1, '26dda417-f00d-4da7-ab7b-8d333500480d', 'Employee', '高中', '高中阶段的学习', '2011-11-28', '2014-11-28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (5, '26dda417-f00d-4da7-ab7b-8d3335002342', 2, '26dda417-f00d-4da7-ab7b-8d333500480d', 'Employee', '张鸿鹄', '家庭成员', '父亲', '职位：老师', '三中', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (8, '26dda417-f00d-4da7-ab7b-8d3335004543', 2, '530cc24e-f09c-4125-939c-fbbec1248865', 'Employee', '1', NULL, '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (9, '26dda417-f00d-4da7-ab7b-8d3335002422', 2, '530cc24e-f09c-4125-939c-fbbec1248865', 'Employee', '2', NULL, '2', '2', '2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (10, '26dda417-f00d-4da7-ab7b-8d3335004452', 2, '530cc24e-f09c-4125-939c-fbbec1248865', 'Employee', '3', NULL, '3', '3', '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (11, '4fe97ad9-1658-4200-aa34-4d36257ef297', 2, '56ac34ff-17b2-4b6e-997d-77a6857bd5ed', 'Employee', '周爱花', NULL, '同学', '学生', '一中', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (12, 'c66a54e8-8194-4c39-92a2-3a537c374575', 2, '56ac34ff-17b2-4b6e-997d-77a6857bd5ed', 'Employee', '周传雄', NULL, '明星', '歌星', '天娱传媒', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (13, '4327f3ad-4c39-4a8a-9900-4f7f2b21560c', 2, '3e03d207-e7cf-4250-a6dc-5def5ecb2885', 'Employee', '名称2, 名称1', NULL, '称谓2, 称谓1', '职位2, 职位1', '单位2, 单位1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (14, 'a0d69bce-4839-4841-8d58-4af9c16de1ee', 2, '3e03d207-e7cf-4250-a6dc-5def5ecb2885', 'Employee', '名称3', NULL, '称谓3', '职位3', '单位3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (15, '3de01a23-ff1a-4e54-8b35-9c92ef2c0dc1', 2, '3e03d207-e7cf-4250-a6dc-5def5ecb2885', 'Employee', '名称4', NULL, '称谓4', '职位4', '单位4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (16, 'fc56210f-617a-47a6-9b9e-73a4bccfc4d4', 2, '3e03d207-e7cf-4250-a6dc-5def5ecb2885', 'Employee', '名称5', NULL, '称谓5', '职位5', '单位5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (17, '0befabec-9fb5-4982-8555-6e54720d6efb', 2, '3e03d207-e7cf-4250-a6dc-5def5ecb2885', 'Employee', '名称6', NULL, '称谓6', '职位6', '单位6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (18, 'd3a9f204-b666-441f-a265-5d069dbc9f4a', 2, 'b26f3d05-1672-41c2-9b81-1ee97272fc88', 'Employee', '名称1', NULL, '称谓1', '职位1', '单位1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (19, 'cac175fb-5075-4b07-ab94-1e6ad3f6a03c', 2, 'e105e961-0232-4c20-b98b-e27630ffafb1', 'Employee', '名称1', NULL, '称谓1', '职位1', '单位1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (20, 'df2060bc-1677-4f6e-a05f-15980df789c1', 2, 'e84857a7-30fd-423f-9272-4734cdab5692', 'Employee', '啊啊', '家庭成员组成', '啊', '啊', ' 啊', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (21, 'cc6e3435-424c-4cbd-ad19-52e0b5c7fd5c', 2, 'e84857a7-30fd-423f-9272-4734cdab5692', 'Employee', ' 啊', '家庭成员组成', '啊', ' 啊', '啊', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (22, '02daf638-ef60-47b7-be0f-8801eeb9416e', 2, '16ae774f-1dca-44ec-86be-1be2f620ab78', 'Employee', '张一', '家庭成员组成', '父亲', '工人', '灯草公司', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (23, '387feeef-21d1-4b9e-a560-7459771c0f40', 2, '16ae774f-1dca-44ec-86be-1be2f620ab78', 'Employee', '张二', '家庭成员组成', '母亲', '工人', '灯草公司', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (24, 'a5bc4b1b-532f-4716-9c26-83f4417a9541', 2, '3f1cd712-5ec9-4e92-bd9a-cf96528a33d6', 'Employee', 'sfsdf', '家庭成员组成', 'sdfdsf', 'fdsfdsf', 'dsfdsfds', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (25, 'b921be51-c187-41b3-ab26-77ac22153926', 2, '3d51e98f-1460-4afd-a2b6-cfe52df630fb', 'Employee', '名称1', '家庭成员组成', '称谓1', '职位1', '工作单位1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (26, 'd7e5a78d-9274-466a-85da-793b057de150', 2, '3d51e98f-1460-4afd-a2b6-cfe52df630fb', 'Employee', '名称2', '家庭成员组成', '称谓', '职位2', '工作单位2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (27, '2df8d476-5e46-469d-bfcd-77c34ae35889', 2, 'cbeaff86-eeaf-412c-a410-a3b434b1d563', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (28, '2cea4325-ecdf-45f2-820e-7d189f207147', 2, '42c38c93-ecb3-431c-b965-dab76dfd356a', 'Employee', '阙华健', '家庭成员组成', '爸', '爸', '地球', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (29, '61bca365-85fa-467a-9e5c-bc531c1a41fb', 2, 'c7040611-5ee0-406e-bc95-2d30fe501094', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (30, 'b00ac836-c9c9-4a11-ba27-2e91d54128f5', 2, '31b4c168-20ac-46bf-af55-ea98d5604cfd', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (31, '5b1144d1-b0ea-4e13-ae4b-36e1a4525ad9', 2, 'f47552ca-32e2-418d-966a-2430a3479d9f', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (32, '8e61745d-fc95-4c1d-b711-a863a09bf3a6', 2, '918429ae-78db-4f29-833d-5dd54f26b95d', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (33, '689274f6-bcc3-4f19-947f-60996e1bd419', 2, '899a79c2-74cd-4d8d-9dfe-185aa758670e', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (34, 'c490aefc-725c-4b51-b0c0-042d0bb9440b', 2, '3fee90d0-4deb-4df9-b0a4-70a286d0168b', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (35, '3321870f-b161-4a32-a453-7ea20056e5e5', 2, '09955d63-55a3-465c-8094-5e8bcf900d65', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (36, '13e3e04e-4a80-495b-89b8-4a7604f916cf', 2, 'a5094251-367e-461e-aeb0-2f7e4884fc25', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (37, 'a06abf83-0d04-4d9e-be98-f90836a9da8c', 2, '4b84f1e8-0152-4216-8709-d632a1011e3b', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (38, '0e10c83f-b171-45f2-9ad8-99aed63a811f', 2, '72accc00-8998-4df8-ad7f-0d295e6ffe29', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (39, 'ed0ae267-c431-4e12-851f-67c8962e70d4', 2, 'f59d9976-5ce9-43f9-b9e3-a5360d3aea0c', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (40, 'b9c8ddca-6256-47db-8831-a898638992cd', 2, '9a6dc36d-36a4-4ef0-8921-a03068a46d5a', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (41, '184f35ae-151e-46a2-9dc0-1ffad6008e45', 2, '31a250e3-79c1-4462-9ba4-4dffcbd30c02', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (42, 'b708e19b-d555-4649-ad21-a6cd1623143b', 2, '0615ebee-09e6-4919-86f1-7cca492cc89a', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (43, '724d03d4-fa1c-4f65-af5c-0eef9666b065', 2, 'bc8653f3-95d5-41bc-bb0d-a2094034d1c7', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (44, 'c4ae9208-6e22-4418-bcf2-92c8271af312', 2, '41be5b97-3658-4e68-b6f6-128b76ef6209', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (45, 'ae516499-5452-48ec-ac7e-8f6900910db3', 2, 'e6f438b7-e9ae-491c-a06c-617e56ef1933', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (46, '769b5802-55f5-4d2d-81ff-c622fd0ef450', 2, '48c24425-94eb-473f-a9d2-7763beff38bc', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (47, '9218c44e-97e8-4129-87b3-8767a90aaa79', 2, '2031b4c6-f33e-4db2-bcef-4bc66b392e25', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (48, 'a15505ab-8f1e-44fd-8f13-3916b9cf0009', 2, 'a14708dd-0ab3-4aa8-9f3f-43bcd79ad3f1', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (49, '75bccbf3-afbd-4a5f-a4bb-35fd99e6d8cc', 2, '2a630b2e-21b0-4377-bb27-9dcdfc87dfd3', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (50, '4bb908d8-5f54-4ab0-ab22-562a26147121', 2, '16de0f91-375b-4cdb-bb24-803a3eb1015b', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (51, 'e37232a3-abd0-4a60-b1d6-1ef88ab03f65', 2, '90124d61-7a75-4873-aa3a-b251421a9a06', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (52, '25168fd3-6e43-407e-be9c-58a977e3d369', 2, '24627593-2027-4ab6-bfb7-0968aa68c094', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (53, '9c3cc45a-b746-420d-aa99-45cd2a3ac8f0', 2, '6f019488-294e-4e94-8cf2-e1e969e741d4', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (54, '6aaa7a39-245c-49bb-a402-83aac1e67053', 2, '18ca7df6-ff46-44a9-b071-0fdebb2889e4', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_relation` VALUES (55, '47c50363-c709-4b8b-802f-c8971f02a6a3', 2, '7567ab28-0300-4f62-a9dc-e08010d5a616', 'Employee', '', '家庭成员组成', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user_relationfb
-- ----------------------------
DROP TABLE IF EXISTS `user_relationfb`;
CREATE TABLE `user_relationfb`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段关系描述附表',
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'UUID唯一编码',
  `relationTypeId` int(11) NULL DEFAULT NULL COMMENT 'user_relationTypeSb 表主键（无外键）',
  `beanName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '实体类名称',
  `f` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '段字名称（记录表中字段的名称）',
  `fname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称描述（对字段名称的描述或备注）',
  `ftype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `fmyorder` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '序排',
  `fform` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `flen` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段长度',
  `fvalue` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段值',
  `fformsize` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段1',
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段2',
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时字段3',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `empFieldId`(`f`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user_relationfb
-- ----------------------------

-- ----------------------------
-- Table structure for user_relationtypesb
-- ----------------------------
DROP TABLE IF EXISTS `user_relationtypesb`;
CREATE TABLE `user_relationtypesb`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '字段类型识别表',
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键Id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '称名',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称备注',
  `temp1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时字段临1',
  `temp2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时字段临2',
  `temp3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时字段临3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user_relationtypesb
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `RoleID` int(11) NOT NULL,
  `loginName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CustomerOrEmployeeId` int(11) NOT NULL,
  `startTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `loginTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lastLoginTime` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `counts` int(11) NOT NULL,
  `IpPart` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lastIpPart` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `delflag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`) USING BTREE,
  INDEX `RoleID`(`RoleID`) USING BTREE,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 293 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 1, 'admin', 'm7tTVEaMykg=', 'admin', 'employee', 15, '2011-08-09 12:29:47', '2025-01-08 12:54:33', '2024-10-29 15:45:13', 1196, '223.72.108.103', '223.160.226.188', 1, '0');
INSERT INTO `users` VALUES (291, 31, '14001', 'm7tTVEaMykg=', '冷志勇', 'employee', 13, '2016-04-13 17:34:09', '2026-10-22 10:29:40', '2026-10-21 19:08:11', 40, '113.84.1.40', '113.84.65.106', 1, '0');
INSERT INTO `users` VALUES (292, 36, '20001', 'm7tTVEaMykg=', '客服一', 'employee', 323, '2024-10-29 12:50:51', '2025-06-06 17:46:12', '2025-06-06 17:45:20', 7, '112.97.46.69', '42.88.204.108', 1, '0');

-- ----------------------------
-- Table structure for verifyorder
-- ----------------------------
DROP TABLE IF EXISTS `verifyorder`;
CREATE TABLE `verifyorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'verifyOrder（审核流程表）',
  `ordertype` int(50) NOT NULL COMMENT '单类型',
  `departments` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门集合',
  `empOrdept` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标识是部门审或是员工审？',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ordertype`(`ordertype`) USING BTREE,
  CONSTRAINT `verifyorder_ibfk_2` FOREIGN KEY (`ordertype`) REFERENCES `docmark` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 481 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of verifyorder
-- ----------------------------
INSERT INTO `verifyorder` VALUES (374, 5, '31', NULL);
INSERT INTO `verifyorder` VALUES (375, 5, '1', NULL);
INSERT INTO `verifyorder` VALUES (376, 5, '76', NULL);
INSERT INTO `verifyorder` VALUES (382, 13, '74', NULL);
INSERT INTO `verifyorder` VALUES (383, 13, '31', NULL);
INSERT INTO `verifyorder` VALUES (384, 13, '76', NULL);
INSERT INTO `verifyorder` VALUES (385, 15, '74', NULL);
INSERT INTO `verifyorder` VALUES (386, 15, '33', NULL);
INSERT INTO `verifyorder` VALUES (387, 15, '1', NULL);
INSERT INTO `verifyorder` VALUES (388, 15, '31', NULL);
INSERT INTO `verifyorder` VALUES (389, 15, '76', NULL);
INSERT INTO `verifyorder` VALUES (390, 18, '33', NULL);
INSERT INTO `verifyorder` VALUES (394, 18, '1', NULL);
INSERT INTO `verifyorder` VALUES (396, 18, '76', NULL);
INSERT INTO `verifyorder` VALUES (399, 31, '76', NULL);
INSERT INTO `verifyorder` VALUES (414, 8, '76', NULL);
INSERT INTO `verifyorder` VALUES (416, 9, '74', NULL);
INSERT INTO `verifyorder` VALUES (417, 9, '76', NULL);
INSERT INTO `verifyorder` VALUES (418, 9, '1', NULL);
INSERT INTO `verifyorder` VALUES (419, 9, '31', NULL);
INSERT INTO `verifyorder` VALUES (420, 9, '76', NULL);
INSERT INTO `verifyorder` VALUES (427, 12, '74', NULL);
INSERT INTO `verifyorder` VALUES (428, 12, '31', NULL);
INSERT INTO `verifyorder` VALUES (429, 12, '1', NULL);
INSERT INTO `verifyorder` VALUES (430, 12, '1', NULL);
INSERT INTO `verifyorder` VALUES (431, 12, '76', NULL);
INSERT INTO `verifyorder` VALUES (432, 16, '74', NULL);
INSERT INTO `verifyorder` VALUES (433, 16, '1', NULL);
INSERT INTO `verifyorder` VALUES (434, 26, '33', NULL);
INSERT INTO `verifyorder` VALUES (435, 26, '1', NULL);
INSERT INTO `verifyorder` VALUES (436, 26, '31', NULL);
INSERT INTO `verifyorder` VALUES (437, 26, '76', NULL);
INSERT INTO `verifyorder` VALUES (443, 1, '72', NULL);
INSERT INTO `verifyorder` VALUES (454, 8, '72', NULL);
INSERT INTO `verifyorder` VALUES (457, 3, '72', NULL);
INSERT INTO `verifyorder` VALUES (458, 4, '30', NULL);
INSERT INTO `verifyorder` VALUES (460, 36, '79', 'emp');
INSERT INTO `verifyorder` VALUES (461, 37, '79', 'emp');
INSERT INTO `verifyorder` VALUES (462, 6, '79', 'emp');
INSERT INTO `verifyorder` VALUES (468, 39, '31', 'emp');
INSERT INTO `verifyorder` VALUES (470, 2, '79', 'emp');
INSERT INTO `verifyorder` VALUES (472, 40, '30', 'emp');
INSERT INTO `verifyorder` VALUES (475, 10, '30', 'emp');
INSERT INTO `verifyorder` VALUES (479, 11, '30', 'emp');
INSERT INTO `verifyorder` VALUES (480, 35, '30', 'emp');

-- ----------------------------
-- Table structure for verifyorder_department
-- ----------------------------
DROP TABLE IF EXISTS `verifyorder_department`;
CREATE TABLE `verifyorder_department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '审核流程部门表',
  `departmentId` int(11) NULL DEFAULT NULL COMMENT '部门外键',
  `verifyOrderId` int(11) NULL DEFAULT NULL COMMENT '审核流程外键Id',
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `verifyState` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多人或者一人审核',
  `orderVerify` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核顺序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of verifyorder_department
-- ----------------------------

-- ----------------------------
-- Table structure for verifyorder_employee
-- ----------------------------
DROP TABLE IF EXISTS `verifyorder_employee`;
CREATE TABLE `verifyorder_employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '审核员工表',
  `departmentId` int(11) NOT NULL COMMENT '部门外键Id',
  `verifyOrderId` int(11) NOT NULL COMMENT '审核流程外键Id',
  `employees` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工集合',
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `verifyState` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '人多或者一人审核',
  `orderVerify` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审核顺序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `verifyOrder_employee_verifyOrderId`(`verifyOrderId`) USING BTREE,
  INDEX `verifyOrder_employee_departmentId`(`departmentId`) USING BTREE,
  CONSTRAINT `verifyOrder_employee_departmentId` FOREIGN KEY (`departmentId`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `verifyOrder_employee_verifyOrderId` FOREIGN KEY (`verifyOrderId`) REFERENCES `verifyorder` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of verifyorder_employee
-- ----------------------------

-- ----------------------------
-- Table structure for workgrade
-- ----------------------------
DROP TABLE IF EXISTS `workgrade`;
CREATE TABLE `workgrade`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位名称',
  `shortname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩写',
  `grade` int(11) NULL DEFAULT 1 COMMENT '权重(5 高级经理级别,4总经理级别,3主管级别,2组长级别,1成员级别)',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '工作职责',
  `edittime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编辑时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of workgrade
-- ----------------------------
INSERT INTO `workgrade` VALUES (1, '总经理', 'ZJL', 5, 'CEO', '2012-07-06 17:50:40');
INSERT INTO `workgrade` VALUES (2, '高级经理', 'GJJL', 4, '研发协助', '2012-07-23 17:51:15');
INSERT INTO `workgrade` VALUES (3, '经理', 'JTDSH1', 3, '经理', '2012-07-21 13:01');
INSERT INTO `workgrade` VALUES (4, '主管', 'ZG', 2, '主管', '2012-07-18 10:48:37');
INSERT INTO `workgrade` VALUES (5, '组长', 'ZZ', 1, '组长', '2012-07-18 10:48:39');

-- ----------------------------
-- Table structure for worklog
-- ----------------------------
DROP TABLE IF EXISTS `worklog`;
CREATE TABLE `worklog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志表',
  `logNo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `empId` int(11) NULL DEFAULT NULL COMMENT '添加日志的员工 外键',
  `recordTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志添加的时间',
  `workresult` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '日志内容',
  `selftemper` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `suggestion` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` int(11) NULL DEFAULT NULL COMMENT '志日类型 0日志 1周志',
  `replier` int(11) NULL DEFAULT NULL COMMENT '注批日志的员工',
  `replyTime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批注时间',
  `replyContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '批注内容',
  `isView` int(11) NULL DEFAULT NULL COMMENT '是否批注查看 0为未批注 1已批注 2为已查看批注',
  `accessory` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `mark` int(5) NULL DEFAULT NULL,
  `tsjyflag` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9117 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of worklog
-- ----------------------------
INSERT INTO `worklog` VALUES (9116, 'GZRZ14110201603310543406871', 13, '2016-03-31 17:43:40', '今天工作很开心 ，领导的任务顺利完成，下面的人工作也很卖力', '今天工作很开心 ，领导的任务顺利完成，下面的人工作也很卖力', NULL, '', 0, NULL, NULL, NULL, 0, NULL, NULL, '0');

-- ----------------------------
-- Table structure for workorder
-- ----------------------------
DROP TABLE IF EXISTS `workorder`;
CREATE TABLE `workorder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工单(workorder)',
  `saleorderId` int(11) NULL DEFAULT NULL COMMENT '订单',
  `upserverId` int(11) NULL DEFAULT NULL COMMENT '上架单',
  `productId` int(11) NULL DEFAULT NULL COMMENT '产品',
  `problemType` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题类型',
  `problemInfo` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题描述',
  `status` int(10) NULL DEFAULT NULL COMMENT '处理状态(0:未处理 1:处理中 2:已处理)',
  `temp` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `saleorder` int(10) NULL DEFAULT NULL,
  `workorderNo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of workorder
-- ----------------------------

-- ----------------------------
-- Table structure for workposition
-- ----------------------------
DROP TABLE IF EXISTS `workposition`;
CREATE TABLE `workposition`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位名称',
  `shortname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩写',
  `deptid` int(11) NULL DEFAULT NULL,
  `workgrade` int(11) NULL DEFAULT 1 COMMENT '权重(5 高级经理级别,4总经理级别,3主管级别,2组长级别,1成员级别)',
  `workcontent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '工作职责',
  `edittime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编辑时间',
  `functionIDs` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `permissions` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `parpostionid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ispersonman` int(10) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `deptid`(`deptid`) USING BTREE,
  INDEX `workgrade`(`workgrade`) USING BTREE,
  CONSTRAINT `workposition_ibfk_1` FOREIGN KEY (`deptid`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `workposition_ibfk_2` FOREIGN KEY (`workgrade`) REFERENCES `workgrade` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of workposition
-- ----------------------------
INSERT INTO `workposition` VALUES (10, '山东运维主管', 'SDYWZG', 82, 5, '负责山东运维部管理', '2012-08-25 10:41', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (11, '行政经理', 'XZJL', 76, 3, '负责行政部一切管理事情', '2012-10-12 07:35', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (21, '营销总监', 'YXZJ', 33, 1, '营销中心老大的岗位', '2013-01-24 05:17:39', '291,292,293,308,309,310,295,438,443,439,450,1,9,307,8,101,', '', NULL, 1);
INSERT INTO `workposition` VALUES (22, '常务副总裁', 'CWFZ', 29, 1, '主管日常集团事务、分管研发中心、财务中心、创意设计中心', '2013-01-24 05:17:17', '344,345,346,347,348,357,358,440,454,455,456,', '', '21', 0);
INSERT INTO `workposition` VALUES (25, '系统管理员', 'XTGLY', 1, 1, '', NULL, '1,8,9,13,14,100,114,115,116,311,330,356,351,352', '351.7,351.8,352.1,352.2,352.3,352.40,352.88', NULL, 1);
INSERT INTO `workposition` VALUES (26, '研发岗(java)', 'yfjava', 30, 1, 'java工程师', '2013-01-19 18:25', '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,339,340,338,342,343,344,345,346,347,348,357,358,349,350,438,442,443,444,445,446,447,439,448,449,450,451,452,453,440,454,455,456,459,460,441,457,458,461,462,463,464,468,469,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,356,10,15,16,11,17,22,117,12,21,114,115,116,330,353,354,355,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,341,198,199,200,201,202,203,205,206,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,351,352,101,252,253,254,257,258,259,', '352.1,352.2,', NULL, 0);
INSERT INTO `workposition` VALUES (27, '项目经理', 'ZCXMJL', 151, 1, '', '2013-01-24 05:19:43', '439,450,', '', NULL, 0);
INSERT INTO `workposition` VALUES (28, '市场策划专员', 'SCCHZY', 163, 1, '', '2013-01-24 05:27', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (29, '财务经理', 'cwjl', 31, 1, '', '2013-01-30 12:10', '438,443,439,450,', '', NULL, 1);
INSERT INTO `workposition` VALUES (30, '会计', 'KJ', 31, 1, '', '2013-01-30 12:10', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (31, '出纳', 'CN', 31, 1, '', '2013-01-30 12:10', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (32, '会计文员', 'KJWY', 31, 1, '', '2013-01-30 12:11', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (33, '战略研究中心经理', 'ZLYJJL', 150, 1, '', '2013-01-30 13:12', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (34, '行业研究顾问', 'HYYJ', 150, 1, '', '2013-01-30 13:30', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (36, '项目经理助理', 'JL', 151, 1, '', '2013-05-21 13:51', NULL, NULL, NULL, 1);
INSERT INTO `workposition` VALUES (41, '销售总监', 'XSZJ', 91, 1, '', '2013-01-30 13:54', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (42, '区域销售经理', 'QYXSJL', 91, 1, '', '2013-01-30 13:55', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (47, '深圳销售经理', 'SZXSJL', 80, 1, '', '2013-02-02 14:12', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (48, '深圳销售助理', 'SZXSZL', 80, 1, '', '2013-02-02 14:13', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (49, '网络销售主管', 'MLXSZG', 81, 1, '', '2013-02-02 14:14', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (50, '网络销售专员', 'MLXSJY', 81, 1, '', '2013-02-02 14:14', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (51, '深圳销售一组主管', 'SZXSYZZG', 116, 1, '', '2013-02-02 14:15', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (52, '深圳销售一组专员', 'SZGZXSJY', 116, 1, '', '2013-02-02 14:16', '317,318,319,331,332,333,334,335,336,337,339,340,496,439,450,440,454,', '', NULL, 0);
INSERT INTO `workposition` VALUES (53, '深圳销售二组主管', 'SZXSEZXG', 117, 1, '', '2013-02-02 14:17', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (54, '深圳销售二组专员', 'SZXSEZJY', 117, 1, '', '2013-02-02 14:17', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (55, '研发中心主管', 'YFZXZG', 30, 1, '研发中心主管', '2013-05-21 16:02', '439,448,449,450,', '', NULL, 0);
INSERT INTO `workposition` VALUES (58, '控股集团BOSS', 'KGJTZG', 28, 1, NULL, '2013-02-01 14:44', '291,292,293,308,309,310,295,300,320,317,318,319,331,332,333,334,335,336,337,339,340,342,343,344,345,346,347,348,357,358,349,350,438,443,444,447,439,449,450,451,440,454,459,460,441,457,458,1,9,13,307,356,353,354,355,5,83,86,174,242,84,87,88,7,95,96,97,109,110,191,192,194,341,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,352,101,', '', NULL, 1);
INSERT INTO `workposition` VALUES (59, '控股集团议员', 'KGJTYY', 28, 1, NULL, '2013-02-01 14:44', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (60, '财务主管', 'CWZG', 31, 1, '', '2013-02-01 16:34', '438,444,445,446,447,439,450,440,454,455,456,459,460,2,32,39,40,', '', NULL, 0);
INSERT INTO `workposition` VALUES (61, '营销副总监', 'YXFZJ', 33, 1, '', '2013-02-01 16:37', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (62, '滨州销售主管', 'BZXSZG', 108, 1, '滨州销售岗', '2013-02-02 14:06', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (68, '滨州销售助理', 'BZXSZL', 108, 1, '', '2013-02-02 14:07', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (69, '滨州销售专员', 'BZXSZY', 108, 1, '', '2013-02-02 14:07', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (71, '北京销售经理', 'BJXSJL', 110, 1, '', '2013-02-02 14:22', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (72, '北京销售助理', 'BJXSZL', 110, 1, '', '2013-02-02 14:23', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (73, '北京销售专员', 'BJXSZY', 110, 1, '', '2013-02-02 14:23', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (74, '运维中心总经理', 'YWZXZJL', 74, 1, '', '2013-02-02 14:29', '438,443,439,450,', '', NULL, 1);
INSERT INTO `workposition` VALUES (75, '运维中心副经理', 'YWZXFJL', 74, 1, '', '2013-02-02 14:30', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (76, '滨州运维技术员', 'BZYWJSY', 82, 1, '', '2013-02-25 18:36', NULL, NULL, NULL, 0);
INSERT INTO `workposition` VALUES (77, '深圳运维主管', 'SZYWZG', 119, 1, '', '2013-02-02 14:32', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (78, '深圳运维技术员', 'SZYWJSY', 119, 1, '', '2013-02-02 14:32', '439,448,450,', '', NULL, 0);
INSERT INTO `workposition` VALUES (79, '人力资源经理', 'RLZYJL', 92, 1, '', '2013-02-02 15:02', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (80, '人力资源助理', 'RLXYJL', 92, 1, '', '2013-02-02 15:03', '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,475,480,481,482,494,495,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,339,340,496,338,342,343,344,345,346,347,348,357,358,473,349,350,438,442,443,444,445,446,447,470,485,439,448,449,450,451,452,453,471,476,493,440,454,455,456,459,460,474,477,484,441,457,458,472,461,462,463,464,468,469,486,487,488,489,490,491,492,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,356,10,15,16,11,17,22,117,12,21,114,115,116,330,353,354,355,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,341,198,199,200,201,202,203,205,206,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,351,352,101,252,253,254,257,258,259,', '352.1,352.2,', NULL, 0);
INSERT INTO `workposition` VALUES (81, '滨州行政助理', 'BZXZXL', 164, 1, '', '2013-02-02 15:04', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (82, '德州行政助理', 'DZXZZL', 164, 1, '', '2013-02-02 15:05', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (83, '行政经理', 'XZJL', 162, 1, '', '2013-02-02 15:06', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (84, '行政主管', 'XZZG', 162, 1, '', '2013-02-02 15:06', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (85, '深圳行政助理', 'SZXZZL', 162, 1, '', '2013-02-02 15:07', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (86, '深圳前台', 'SZQT', 162, 1, '', '2013-02-02 15:07', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (87, '创意总监', 'CYZJ', 149, 1, '', '2013-02-02 15:09', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (88, '创意总监秘书', 'CYZJMS', 149, 1, '', '2013-02-02 15:10', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (89, '深圳设计室经理', 'SZSJJL', 153, 1, '', '2013-02-02 15:11', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (90, '深圳设计师', 'SZSJS', 153, 1, '', '2013-02-02 15:12', '439,448,450,243,244,245,246,247,248,249,', '', NULL, 0);
INSERT INTO `workposition` VALUES (91, '德州设计室经理', 'DZCJJL', 154, 1, '', '2013-02-02 15:13', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (92, '德州设计师', 'DZSJS', 154, 1, '', '2013-02-02 15:14', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (95, '南方区域客服经理', 'NFQYKFJL', 157, 1, '', '2013-02-02 15:21', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (96, '深圳客服主管', 'SZKFZG', 160, 1, '', '2013-02-02 15:19', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (97, '深圳客服专员', 'SZKFZY', 160, 1, '', '2013-02-02 15:19', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (98, '北方区域客服经理', 'BFQYKFJL', 158, 1, '', '2013-02-02 15:20', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (99, '山东客服主管', 'SDKFZG', 161, 1, '', '2013-02-02 15:22', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (100, '滨州客服专员', 'BZKFZY', 161, 1, '', '2013-02-02 15:23', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (101, '德州客服专员', 'DZKFZY', 161, 1, '', '2013-02-02 15:24', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (102, '北京客服经理', 'BJKFJL', 159, 1, '', '2013-02-02 15:34', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (103, '北京客服专员', 'BJKFZY', 159, 1, '', '2013-02-02 15:34', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (104, '总裁秘书', 'ZCMS', 88, 1, '', '2013-02-02 15:36', '439,450,', NULL, '36', 0);
INSERT INTO `workposition` VALUES (105, '总裁办助理', 'ZCBZL', 88, 1, '', '2013-02-02 15:37', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (106, '行政中心总经理', 'xzzxzjl', 76, 1, '', '2013-07-04 09:32', '317,318,319,331,332,333,334,335,336,337,339,340,496,1,9,13,14,114,115,330,', '', NULL, 1);
INSERT INTO `workposition` VALUES (107, '客服中心总经理', 'KFZXZJL', 156, 1, '', '2013-02-25 17:29', '439,450,', NULL, NULL, 1);
INSERT INTO `workposition` VALUES (108, '营销中心总经理', 'YXZXZJL', 33, 1, '', '2013-02-25 17:32', '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,339,340,338,342,343,344,345,346,347,348,357,358,473,349,350,438,442,443,444,445,446,447,470,439,448,449,450,451,452,453,471,440,454,455,456,459,460,474,441,457,458,472,461,462,463,464,468,469,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,356,10,15,16,11,17,22,117,12,21,114,115,116,330,353,354,355,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,341,198,199,200,201,202,203,205,206,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,351,352,101,252,253,254,257,258,259,', '352.1,352.2,', NULL, 0);
INSERT INTO `workposition` VALUES (109, '研发中心总经理', 'YFZHZJL', 30, 1, '', '2013-05-21 16:02', '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,475,480,481,482,494,495,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,339,340,496,338,342,343,344,345,346,347,348,357,358,473,349,350,438,442,443,444,445,446,447,470,485,439,448,449,450,451,452,453,471,476,493,440,454,455,456,459,460,474,477,484,441,457,458,472,461,462,463,464,468,469,486,487,488,489,490,491,492,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,356,10,15,16,11,17,22,117,12,21,114,115,116,330,353,354,355,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,341,198,199,200,201,202,203,205,206,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,351,352,101,252,253,254,257,258,259,', '352.1,352.2,14.1,14.2', NULL, 1);
INSERT INTO `workposition` VALUES (110, '创意中心总经理', 'CYZXXJL', 149, 1, '', '2013-02-25 17:46', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (111, '大客户总经理', 'DKFZJL', 29, 1, '', '2013-02-25 17:47', '342,343,344,345,346,347,348,357,358,438,443,439,450,1,9,307,356,11,17,22,117,114,330,353,2,32,39,176,177,179,191,192,193,341,198,199,327,328,329,8,100,105,207,208,209,274,275,276,311,351,', '', '77,37', 0);
INSERT INTO `workposition` VALUES (112, '德州分公司总经理', 'DZFGSZJL', 29, 1, '', '2013-02-25 18:09', '439,450,', NULL, NULL, 0);
INSERT INTO `workposition` VALUES (114, '德州运维技术员', 'DZYWJSY', 82, 1, '', '2013-02-25 18:36', NULL, NULL, NULL, 0);
INSERT INTO `workposition` VALUES (115, '副总经理', 'FZJL', 29, 1, '', '2013-02-27 11:19', '317,318,319,331,332,333,334,335,336,337,339,340,496,1,9,13,14,114,115,330,', NULL, '121,49', 0);
INSERT INTO `workposition` VALUES (116, '财务中心总经理', 'CWZXZJL', 31, 1, '', '2013-02-25 18:44', '260,261,262,263,264,265,266,267,268,269,270,312,271,272,273,277,278,296,297,298,299,285,286,288,289,287,290,294,291,292,293,308,309,310,295,300,320,303,304,305,306,317,318,319,331,332,333,334,335,336,337,339,340,338,342,343,344,345,346,347,348,357,358,349,350,438,442,443,444,445,446,447,439,448,449,450,451,452,453,440,454,455,456,459,460,441,457,458,461,462,463,464,243,244,245,246,247,248,249,250,251,255,256,1,9,13,14,307,356,10,15,16,11,17,22,117,12,21,114,115,116,330,353,354,355,2,32,39,40,313,33,41,42,314,315,316,323,324,325,326,3,44,51,45,52,118,46,53,47,54,140,48,143,144,49,56,145,50,57,4,58,65,66,59,69,161,60,73,74,75,61,76,77,62,78,79,63,81,64,82,210,212,213,302,321,322,5,83,86,174,242,84,87,88,85,89,175,181,182,183,187,188,189,7,95,96,97,109,110,176,177,178,179,180,241,184,185,186,301,191,192,193,194,341,198,199,200,201,202,203,205,206,327,328,329,8,100,103,104,105,106,107,207,208,209,274,275,276,311,351,352,101,252,253,254,257,258,259,', '352.1,352.2,', NULL, 0);
INSERT INTO `workposition` VALUES (123, 'weqwe', 'qwqwe', 125, 1, '12', '2013-03-11 16:02', NULL, NULL, NULL, 1);
INSERT INTO `workposition` VALUES (124, '12', '13', 115, 1, '23', '2013-03-11 16:03', NULL, NULL, NULL, 1);
INSERT INTO `workposition` VALUES (125, '系统管理员', 'XTGLY', 1, 1, '', NULL, '1,8,9,13,14,100,114,115,116,330,356,351,', '351.7,351.8,14.1,14.2', NULL, 1);
INSERT INTO `workposition` VALUES (126, '系统管理员', 'XTGLY', 1, 1, '', NULL, '1,8,9,13,14,100,114,115,116,311,330,356,351,352', '351.7,351.8,14.1,14.2', NULL, 1);
INSERT INTO `workposition` VALUES (127, '客户服务中心(2024)', 'KF', 156, 1, '客服中心', '2024-10-29 12:43:49', '260,261,262,266,267,268,269,270,312,291,292,293,308,309,310,439,448,450,452,453,471,441,457,458,472,461,462,463,464,5,83,86,174,242,84,87,88,', '', NULL, 0);

-- ----------------------------
-- Table structure for workposition_employee
-- ----------------------------
DROP TABLE IF EXISTS `workposition_employee`;
CREATE TABLE `workposition_employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工兼职部门职位表',
  `positionid` int(11) NOT NULL COMMENT '职位id',
  `empid` int(11) NOT NULL COMMENT '兼任员工id',
  `edittime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作时间',
  `positiontype` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `positionid`(`positionid`) USING BTREE,
  INDEX `empid`(`empid`) USING BTREE,
  CONSTRAINT `workposition_employee_ibfk_1` FOREIGN KEY (`positionid`) REFERENCES `workposition` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `workposition_employee_ibfk_2` FOREIGN KEY (`empid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 199 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of workposition_employee
-- ----------------------------
INSERT INTO `workposition_employee` VALUES (196, 126, 15, NULL, 1);
INSERT INTO `workposition_employee` VALUES (197, 109, 13, '2016-04-13 17:35:37.0', 4);
INSERT INTO `workposition_employee` VALUES (198, 127, 323, '2024-10-29 15:05:38.0', 1);

-- ----------------------------
-- Function structure for getChildClassesLst
-- ----------------------------
DROP FUNCTION IF EXISTS `getChildClassesLst`;
delimiter ;;
CREATE FUNCTION `getChildClassesLst`(rootId INT)
 RETURNS varchar(1000) CHARSET utf8
BEGIN
     DECLARE sTemp VARCHAR(1000);
     DECLARE sTempChd VARCHAR(1000);

    SET sTemp = '';
    SET sTempChd =CAST(rootId AS CHAR);
   WHILE sTempChd IS NOT NULL DO
  SET sTemp = CONCAT(sTemp,',',sTempChd);
    SELECT GROUP_CONCAT(classid) INTO sTempChd FROM fa_cms_classes  WHERE delflag = 0 and  FIND_IN_SET(superid,sTempChd)>0;
    END WHILE;
  RETURN sTemp;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for getChildDeptLst
-- ----------------------------
DROP FUNCTION IF EXISTS `getChildDeptLst`;
delimiter ;;
CREATE FUNCTION `getChildDeptLst`(rootId INT)
 RETURNS varchar(1000) CHARSET utf8
BEGIN
     DECLARE sTemp VARCHAR(1000);
     DECLARE sTempChd VARCHAR(1000);
    
    SET sTemp = '';
    SET sTempChd =CAST(rootId AS CHAR);
   WHILE sTempChd IS NOT NULL DO
  SET sTemp = CONCAT(sTemp,',',sTempChd);
    SELECT GROUP_CONCAT(id) INTO sTempChd FROM department  WHERE FIND_IN_SET(parentId,sTempChd)>0;
    END WHILE;
  RETURN sTemp;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for getTreeChlid
-- ----------------------------
DROP FUNCTION IF EXISTS `getTreeChlid`;
delimiter ;;
CREATE FUNCTION `getTreeChlid`(rootId INT)
 RETURNS varchar(1000) CHARSET utf8
BEGIN
    DECLARE sTemp VARCHAR(1000);
    DECLARE sTempChd VARCHAR(1000);

    SET sTemp = '$';
    SET sTempChd =CAST(rootId as CHAR);

    WHILE sTempChd is not null DO
        SET sTemp = CONCAT(sTemp,',',sTempChd);
        
        SELECT GROUP_CONCAT(id) INTO sTempChd FROM department where FIND_IN_SET(pid,sTempChd)>0;
    END WHILE;
    RETURN sTemp;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
