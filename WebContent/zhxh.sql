/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50621
 Source Host           : localhost
 Source Database       : zhxh

 Target Server Type    : MySQL
 Target Server Version : 50621
 File Encoding         : utf-8

 Date: 09/03/2016 14:52:11 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `brandfirst`
-- ----------------------------
DROP TABLE IF EXISTS `brandfirst`;
CREATE TABLE `brandfirst` (
  `id` varchar(40) NOT NULL,
  `brandid` varchar(40) DEFAULT NULL,
  `brandname` varchar(200) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `righttitle` varchar(100) DEFAULT NULL,
  `righttitleurl` varchar(200) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `firstpic` varchar(200) DEFAULT NULL,
  `firstpicurl` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `brandfirst`
-- ----------------------------
BEGIN;
INSERT INTO `brandfirst` VALUES ('26395090-ec7d-413c-8d8c-faf84c380b3c', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'taef', 'asdfasdf', 'asdfasdf', 'asdf', '2', 'file/pic/c9663cde-9d1f-49f5-ac56-fff64b244388.jpg', 'asdf'), ('8e8d6e91-8936-4fa3-8d1a-81740c16621d', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '诗蜜安黛', '重点推荐测试文字', '跳转系列页测试', '/zhxh/pcMain/series.htmls?id=fb68235f-e483-4e40-9f76-aaa2a0613794', '1', 'file/pic/6486ea36-a940-4685-91c8-1d064a2f5a95.jpg', '/zhxh/pcMain/series.htmls?id=fb68235f-e483-4e40-9f76-aaa2a0613794'), ('b1d9ba0b-4cff-4ad6-97b8-5ba7f45172b0', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '诗蜜安黛', '新建标题', '点击无效果测试', '', '4', 'file/pic/dec5d458-382c-46e9-9a71-6f80a13486fd.jpg', ''), ('bc56b450-ca87-4217-a7c9-1504783fee47', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '诗蜜安黛', '新建标题', '点击无效果测试', '', '5', 'file/pic/76e4b5fb-84d8-4285-8880-ef94acea0c9e.jpg', ''), ('cb81cbf2-2a36-48cd-b948-bd97ce94fbbc', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '诗蜜安黛', '测试', '调整到列表页', '/zhxh/pcMain/product.htmls?id=8c9058fc-48b4-4363-a72e-5fb9f434e9b4', '3', 'file/pic/46dc4161-e085-4dd7-af46-1f76fa5c5b22.jpg', '/zhxh/pcMain/product.htmls?id=8c9058fc-48b4-4363-a72e-5fb9f434e9b4'), ('e0d3b2ed-8f88-42b7-aa97-77460b2aed1e', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '诗蜜安黛', '普通标题', '跳转商品详细', '/zhxh/pcMain/product_c.htmls?id=45e02ae0-02b8-4864-8670-6635e901c4e1', '2', 'file/pic/0ba6a191-f9b3-41ac-b776-4f3b27a537b4.jpg', '/zhxh/pcMain/product_c.htmls?id=45e02ae0-02b8-4864-8670-6635e901c4e1'), ('eb87563c-1c56-4062-8b11-91ac2f5d5556', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '诗蜜安黛', '新建标题', '点击无效果测试', '', '6', 'file/pic/3554a760-c526-4d89-98bd-37bb751b4faf.jpg', '');
COMMIT;

-- ----------------------------
--  Table structure for `brandlist`
-- ----------------------------
DROP TABLE IF EXISTS `brandlist`;
CREATE TABLE `brandlist` (
  `id` varchar(40) NOT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `listname` varchar(100) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `pic` varchar(200) DEFAULT NULL,
  `picurl` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `brandlist`
-- ----------------------------
BEGIN;
INSERT INTO `brandlist` VALUES ('32f424f6-dae2-4a1f-a133-70b7ff38d181', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'asdf', '1', 'file/pic/cefcd40d-06f0-4166-bd54-11a616f27dd1.jpg', 'sdf'), ('e14343dd-39b9-4d98-acfc-17a06c81be42', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'asdf', '2', 'file/pic/5aa97201-4e66-402c-b483-edfe4aea2d57.jpg', 'da'), ('fb68235f-e483-4e40-9f76-aaa2a0613794', 'b2ea19cc-4653-4a91-bfaa-e3e58e07caa0', '新建系列', '1', 'file/pic/ea3ab7d1-28f6-4d82-8e5b-6ff72fd99ab6.jpg', '/zhxh/pcMain/product_c.htmls?id=45e02ae0-02b8-4864-8670-6635e901c4e1');
COMMIT;

-- ----------------------------
--  Table structure for `filesdown`
-- ----------------------------
DROP TABLE IF EXISTS `filesdown`;
CREATE TABLE `filesdown` (
  `id` varchar(40) NOT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `filetime` varchar(100) DEFAULT NULL,
  `file_old_name` varchar(200) DEFAULT NULL,
  `file_new_name` varchar(200) DEFAULT NULL,
  `file_ext` varchar(40) DEFAULT NULL,
  `file_size` varchar(50) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `pic` varchar(200) DEFAULT NULL,
  `parenttype` varchar(100) DEFAULT NULL,
  `isshow` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `filesdown`
-- ----------------------------
BEGIN;
INSERT INTO `filesdown` VALUES ('d50185ad-02fb-447d-ab0e-5ffb1153b9d2', 'files', 'asdf', '2016-08-29 09:58:03', null, null, null, null, null, '1', null, 'spec', null);
COMMIT;

-- ----------------------------
--  Table structure for `label_list`
-- ----------------------------
DROP TABLE IF EXISTS `label_list`;
CREATE TABLE `label_list` (
  `id` varchar(40) NOT NULL,
  `labelid` varchar(40) DEFAULT NULL,
  `listid` varchar(40) DEFAULT NULL,
  `listtable` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `label_list`
-- ----------------------------
BEGIN;
INSERT INTO `label_list` VALUES ('22d19f19-e6e6-46b5-b9c5-961e2fe1d4a6', '8c9058fc-48b4-4363-a72e-5fb9f434e9b4', '0091c547-278d-4de7-91ec-90c8caae5b82', 'product_list'), ('4ad9f645-0aca-41f9-a827-361ea0d925ac', '8c9058fc-48b4-4363-a72e-5fb9f434e9b4', '24375c1c-4047-4849-b0ab-46d008e32334', 'product_list'), ('fed82c80-3a53-4d44-af5e-48ef9ea493bf', '8c9058fc-48b4-4363-a72e-5fb9f434e9b4', '45e02ae0-02b8-4864-8670-6635e901c4e1', 'product_list');
COMMIT;

-- ----------------------------
--  Table structure for `labeltype`
-- ----------------------------
DROP TABLE IF EXISTS `labeltype`;
CREATE TABLE `labeltype` (
  `id` varchar(40) NOT NULL,
  `labelname` varchar(200) DEFAULT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `labeltype`
-- ----------------------------
BEGIN;
INSERT INTO `labeltype` VALUES ('06e11dcf-f19e-4688-a355-7002d67e145f', '提拉紧致', 'b847f153-2c0f-474a-a964-2657793edd7c', '1'), ('2709513d-1e02-40f9-ad33-8b5ceb879590', '亮泽', 'a81d52a5-23cd-40d1-a4f7-78a4e9219a19', '1'), ('29f279e4-84b7-429a-8e4c-b9cdceed1070', '修复', 'b847f153-2c0f-474a-a964-2657793edd7c', '3'), ('32eaff3b-680b-4451-aee0-082fc922948f', '保湿', 'a81d52a5-23cd-40d1-a4f7-78a4e9219a19', '1'), ('62964d1f-7af7-449c-b833-7ec4f4bd3bb3', '美白', 'a81d52a5-23cd-40d1-a4f7-78a4e9219a19', '1'), ('a81d52a5-23cd-40d1-a4f7-78a4e9219a19', '功效', '0', '1'), ('b847f153-2c0f-474a-a964-2657793edd7c', '护肤品', '0', '2'), ('ca397743-0da4-44dd-8e60-5dd146e86801', '紧致', 'a81d52a5-23cd-40d1-a4f7-78a4e9219a19', '1'), ('fd117a21-b017-4c36-b535-b44d496138ae', '防护', 'b847f153-2c0f-474a-a964-2657793edd7c', '2');
COMMIT;

-- ----------------------------
--  Table structure for `product_list`
-- ----------------------------
DROP TABLE IF EXISTS `product_list`;
CREATE TABLE `product_list` (
  `id` varchar(40) NOT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `brandname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `product_list`
-- ----------------------------
BEGIN;
INSERT INTO `product_list` VALUES ('3ed3c04f-8ab5-4c38-ad7a-6340c435ee74', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'sss'), ('8c9058fc-48b4-4363-a72e-5fb9f434e9b4', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '诗蜜安黛列表页测试');
COMMIT;

-- ----------------------------
--  Table structure for `product_rated`
-- ----------------------------
DROP TABLE IF EXISTS `product_rated`;
CREATE TABLE `product_rated` (
  `id` varchar(40) NOT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `ratedmemo` text,
  `ratedtime` varchar(100) DEFAULT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `isshow` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `product_rated`
-- ----------------------------
BEGIN;
INSERT INTO `product_rated` VALUES ('18d7fb5a-9bbc-4afd-b5bb-d3dc006e545c', 'be117559-422e-4f7d-b1a1-71ee387eedda', '330ml的嫩肤精华露礼盒装还是非常划算的，算上赠品和积分跟代沟相比也差不多，希望线上专柜活动能更给力一点，这样能吸引更多的使用者选择天猫旗舰店哦。', '2016-08-07', '', '木***z（匿名）', '1'), ('2540a1a6-913e-42bb-9085-2ad15bf26520', '4b766cac-8626-451f-8b0f-9a072f410fcf', '', '2016-08-03', '', 'asdfa', '0'), ('2e0a19bc-800e-4f0d-b41f-9b6f77fcd2f9', 'be117559-422e-4f7d-b1a1-71ee387eedda', '自从拔草神仙水已经四个多月了，皮肤变的越来越稳定。以前容易出油爆痘，现在只要作息规律，饮食清淡低GI就不会再长痘痘了，而且肤色也变的更透彻、均匀，其实这都要归功于神仙水对皮肤角质的调理作用，这才是护肤的根本。从成分上来看，经典成分Pitera的含量很高，辅以丁二醇和1、2－戊二醇两种保湿剂简单而不失功效，另外没有酒精、香精也是成分党的极为看重的指标。对于我个人而言，非常喜欢神仙水的使用感受，如水般轻盈，上脸轻拍吸收很快，感觉清爽不粘腻。建议油皮配合清莹露，含乳酸、苹果酸和水杨酸能更好的清洁皮肤、疏通毛孔，让后续神仙水的功效更好体现。最后再感谢一下客服们每次耐心的解答和帮助，不得不说大牌从产品到服务都是一流水平，么么哒。', '2016-09-02', '', '武***6', '1'), ('2fb8aa82-80b9-4ea8-b0f7-accd97569d83', '4b766cac-8626-451f-8b0f-9a072f410fcf', '爱上大法师发\nasdf\n啊啊啊啊', '2016-08-03T00:00:00', '', '啊水电费', '0'), ('4b6baa89-d207-4380-b489-5a413795fc24', '09dff08d-7188-4096-9fda-8c350f037f77', '其实我本身皮肤挺好的，但偏偏眼角有细纹很干涩~平常不用眼霜，水乳搞定一切。现在细纹出现，真的有点后悔平常不用眼霜~入手这款大眼眼霜，时间还比较短，还没有特别明显的效果，保湿和滋润倒是马上能体会到。神仙水能带给我好皮肤，相信这款眼霜也行，坚持用下去吧，毕竟没有一分钟就起效的产品~', '2016-09-02', '', '什***伪（匿名）', '1'), ('6eb88d25-d05d-4c78-bdf3-c6e774cdf775', '09dff08d-7188-4096-9fda-8c350f037f77', '特地用了一段时间再来评论的，每天坚持使用一段时间之后，发现确实有效果，细纹有好转，相信再过一段时间之后，肯定能完全抹平', '2016-06-18', '', 't***2（匿名）', '1'), ('87f58ca2-1638-428d-864d-935a214b7f4e', '4b766cac-8626-451f-8b0f-9a072f410fcf', '啊水电费', '2016-08-10T00:00:00', '', '啊是大法师豆腐', '0'), ('adafd10e-8b7c-497c-abaa-d831ebffc3d8', '5ce0ea9a-35cf-49fb-8ffd-22a955661902', 'asdfasdfasdf', '2016-08-26', '', 'asdf', '0'), ('b6b234df-1fe1-48c5-926f-0395e3acb5d1', '09dff08d-7188-4096-9fda-8c350f037f77', '眼霜用的一直是诗蜜安黛的红瓶，全新升级很惊喜！已经连续用了好几天了，感觉眼角的皱纹有点点变淡了（嘿嘿嘿不知道是不是心理作用），今天老公突然很认真的跟我说，你最近神色好很多嘛！开心到飞起来~PS,诗蜜安黛的包装礼盒真的是高大上，喜欢！', '2016-08-06', '', '巴***9（匿名）', '1');
COMMIT;

-- ----------------------------
--  Table structure for `public_ask_result`
-- ----------------------------
DROP TABLE IF EXISTS `public_ask_result`;
CREATE TABLE `public_ask_result` (
  `id` varchar(40) NOT NULL,
  `askid` varchar(40) DEFAULT NULL,
  `resulttime` varchar(100) DEFAULT NULL,
  `resultman` varchar(100) DEFAULT NULL,
  `resultmemo` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_bankget_list`
-- ----------------------------
DROP TABLE IF EXISTS `public_bankget_list`;
CREATE TABLE `public_bankget_list` (
  `id` varchar(40) NOT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `bankgetcode` varchar(100) DEFAULT NULL,
  `bankgettime` varchar(100) DEFAULT NULL,
  `bankgetnum` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_bonus_list`
-- ----------------------------
DROP TABLE IF EXISTS `public_bonus_list`;
CREATE TABLE `public_bonus_list` (
  `id` varchar(40) NOT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `bonusdate` varchar(100) DEFAULT NULL,
  `bonusnum` decimal(11,2) DEFAULT NULL,
  `bonusmemo` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_brand`
-- ----------------------------
DROP TABLE IF EXISTS `public_brand`;
CREATE TABLE `public_brand` (
  `id` varchar(40) NOT NULL,
  `brandname` varchar(200) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `brandlogo` varchar(200) DEFAULT NULL,
  `brandpath` varchar(100) DEFAULT NULL,
  `isshow` int(11) DEFAULT NULL,
  `brandcolor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_brand`
-- ----------------------------
BEGIN;
INSERT INTO `public_brand` VALUES ('039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '诗蜜安黛', '1', 'file/logo/690df359-ec74-42fa-ba32-f638c740a340.png', '1', '1', '#000000'), ('b2ea19cc-4653-4a91-bfaa-e3e58e07caa0', '夏木', '2', 'file/logo/7eba6b16-371e-4a6d-b8d0-0488b0b12623.png', '1', '1', '#332BFF'), ('ecef2cd9-1b7b-4da0-8912-0cc20a7014d5', '摩漾', '3', 'file/logo/acc45402-dd30-4815-8ddd-4ce22c22a407.png', '1', '1', '#335656');
COMMIT;

-- ----------------------------
--  Table structure for `public_cat`
-- ----------------------------
DROP TABLE IF EXISTS `public_cat`;
CREATE TABLE `public_cat` (
  `id` varchar(40) NOT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `productid` varchar(40) DEFAULT NULL,
  `productsizeid` varchar(40) DEFAULT NULL,
  `buycount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_content`
-- ----------------------------
DROP TABLE IF EXISTS `public_content`;
CREATE TABLE `public_content` (
  `id` varchar(40) NOT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `parenttype` varchar(200) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `source` varchar(100) DEFAULT NULL,
  `memo` text,
  `createtime` varchar(200) DEFAULT NULL,
  `pic_url` varchar(200) DEFAULT NULL,
  `top` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `brief` varchar(2000) DEFAULT NULL,
  `isshow` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_content`
-- ----------------------------
BEGIN;
INSERT INTO `public_content` VALUES ('02418064-70f8-4c59-9b45-523785e43ed5', 'content', 'faq', '诗蜜安黛是否提供产品真伪鉴定服务?', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>非常感谢您对我们产品的关注和喜爱。但我们不提供这类服务。建议您前往诗蜜安黛指定美容院店咨询购买，以确保您购买到正品并享受相关服务。您可以在诗蜜安黛官方网站直接购买。</p>\n</body>\n</html>', '2016-09-03T14:35:03', null, null, '2', null, '1'), ('141174e5-5406-43d5-8680-718ce1bb4206', 'news', 'hy', 'asdf', null, null, '2016-08-28 11:04:48', null, null, '1', 'asdf', null), ('37f25b41-57ef-4ec3-93e0-b799517f6599', 'b2ea19cc-4653-4a91-bfaa-e3e58e07caa0', 'brandstory', null, null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<div class=\"HTML-con Brand-story\">\n<h3 style=\"text-align: center;\"><span style=\"font-size: 24pt;\"><strong>品牌故事</strong></span></h3>\n<div class=\"Brand-story-IMG\"><img src=\"../file/richedit/0abe6bfd-e9af-40a1-bdaf-b7d0992ee9f2.jpg\" alt=\"\" width=\"100%\" /></div>\n<div class=\"shop-page-cnter1 clearfix\">\n<div class=\"img fl\">\n<p>&nbsp;</p>\n<table style=\"margin-left: auto; margin-right: auto; height: 262px;\" width=\"1138\">\n<tbody>\n<tr>\n<td style=\"text-align: center;\"><img src=\"../file/richedit/dc46ecdb-6ac2-4273-b7e6-c16828842a05.jpg\" alt=\"\" width=\"551\" height=\"287\" /></td>\n<td>\n<h4 style=\"padding-left: 180px;\"><span style=\"color: #000000;\"><strong>诗蜜安黛</strong></span></h4>\n<p>&nbsp;</p>\n<p style=\"padding-left: 30px;\"><span style=\"color: #000000;\"><strong>品牌简介：</strong></span></p>\n<p style=\"padding-left: 30px;\">&nbsp;</p>\n<p style=\"padding-left: 30px;\"><span style=\"font-family: 微软雅黑; font-size: 10pt;\">紧致眼周肌肤，改善双眸疲倦现象 由精华笔和眼膜组成的眼部密集护理产品。改善细纹、黑眼圈、浮肿等眼周肌肤问题，恢复眼周肌肤弹性，散发明眸神采。</span></p>\n<p style=\"padding-left: 30px;\">&nbsp;</p>\n<p style=\"padding-left: 30px;\"><span style=\"color: #000000;\"><strong><span style=\"font-family: 微软雅黑; font-size: 10pt;\">修护眼部护理套装由两个步骤组成：</span></strong></span></p>\n<p style=\"padding-left: 30px;\">&nbsp;</p>\n<p style=\"padding-left: 30px;\"><span style=\"font-family: 微软雅黑; font-size: 10pt;\">滚珠式精华笔：可温和按摩眼周肌肤，凝露质地精华液蕴含多重活性成分，能同时紧实眼部肌肤淡化眼周皱纹，改善浮肿和黑眼圈</span></p>\n<p style=\"padding-left: 30px;\"><span style=\"font-family: 微软雅黑; font-size: 10pt;\">容量：10 片 +6ml / 盒</span></p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</div>\n</div>\n<div class=\"\">\n<table style=\"height: 310px; margin-left: auto; margin-right: auto;\" width=\"1136\">\n<tbody>\n<tr>\n<td>\n<p><span style=\"color: #000000;\"><strong><span style=\"font-size: 14pt;\">理念</span></strong></span></p>\n<p>&nbsp;</p>\n<p><span style=\"color: #000000;\"><strong><span style=\"font-size: 18pt;\">诗蜜安黛品牌理念</span></strong></span></p>\n<p>&nbsp;</p>\n<p><span style=\"font-family: 微软雅黑; font-size: 10pt;\">肌肤的自然保湿屏障，在你婴幼儿时期是完整的，但随着时间的推移便开始失去生命和活力，成为肌肤受损的主要原因。同样，拥有能够超越时间的活力美肌的秘密也在于&ldquo;保湿&rdquo;。</span></p>\n<p>&nbsp;</p>\n<p><span style=\"font-family: 微软雅黑; font-size: 10pt;\">通过20年对水和肌肤关系的研究，诗蜜安黛发现水不仅在保湿中发挥着重要作用，还能够增强美白和抗衰老产品的效果。</span></p>\n<p>&nbsp;</p>\n<p><span style=\"font-family: 微软雅黑; font-size: 10pt;\">独有的&ldquo;水科技&trade;&rdquo;，随时随地帮助自信的年轻女性获得自然水润和柔滑的肌肤。通过水的能量，我们为你还原肌肤本来的清澈透明。</span></p>\n</td>\n<td>\n<p><img src=\"../file/richedit/ec9585ef-ff48-4dfe-adb4-3402121e1e47.jpg\" alt=\"\" /></p>\n</td>\n</tr>\n</tbody>\n</table>\n</div>\n<p style=\"text-align: left;\">&nbsp;</p>\n<p style=\"text-align: left; padding-left: 30px;\"><span style=\"font-family: 微软雅黑; color: #000000;\"><strong><span style=\"font-size: 14pt;\"><strong>信念</strong></span></strong></span></p>\n<p style=\"text-align: left; padding-left: 30px;\">&nbsp;</p>\n<p style=\"padding-left: 30px;\"><span style=\"font-family: 微软雅黑; color: #000000;\"><strong><span style=\"font-size: 18pt;\">诗蜜安黛的诞生，源于帮助女性获得清澈透明如雪般肌肤的承诺。</span></strong></span></p>\n<p>&nbsp;</p>\n<table style=\"margin-left: auto; margin-right: auto; height: 318px;\" width=\"1155\">\n<tbody>\n<tr>\n<td><img src=\"../file/richedit/29e3d466-2e94-4b2c-ad2b-f47406d2c121.jpg\" alt=\"\" /></td>\n<td>\n<p style=\"padding-left: 30px;\"><span style=\"font-size: 10pt; font-family: 微软雅黑;\">肌肤的自然保湿屏障，在你婴幼儿时期是完整的，但随着时间的推移便开始失去生命和活力，成为肌肤受损的主要原因。同样，拥有能够超越时间的活力美肌的秘密也在于&ldquo;保湿&rdquo;。</span></p>\n<p style=\"padding-left: 30px;\">&nbsp;</p>\n<p style=\"padding-left: 30px;\"><span style=\"font-size: 10pt; font-family: 微软雅黑;\">通过20年对水和肌肤关系的研究，诗蜜安黛发现水不仅在保湿中发挥着重要作用，还能够增强美白和抗衰老产品的效果。</span></p>\n<p style=\"padding-left: 30px;\">&nbsp;</p>\n<p style=\"padding-left: 30px;\"><span style=\"font-size: 10pt; font-family: 微软雅黑;\">独有的&ldquo;水科技&trade;&rdquo;，随时随地帮助自信的年轻女性获得自然水润和柔滑的肌肤。通过水的能量，我们为你还原肌肤本来的清澈透明。</span></p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n</div>\n</body>\n</html>', null, null, null, null, null, '0'), ('4c2c2f3d-a9a0-4273-9c1d-5f0e007143e5', 'zt', 'dzyf', '多大的', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>啊水电费asdfasdfqaqqasd爱迪生发啥地方asdfasdfasdfasdfadsfadsf</p>\n</body>\n</html>', '2016-08-22T11:11:17', null, null, '1', null, null), ('5927f5c9-2e09-4b24-accb-997153a98c68', '45e02ae0-02b8-4864-8670-6635e901c4e1', 'productrich', null, null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/60b3320c-f9b2-4053-810e-806b458848ef.jpg\" alt=\"\" width=\"100%\" /></p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/775c6970-f75c-4140-8919-fd5d7341c474.jpg\" alt=\"\" width=\"100%\" /></p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/60c57102-9d5b-4f0a-8d23-fb05953fa68f.jpg\" alt=\"\" width=\"100%\" /></p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p><video id=\"preview-player\" class=\"video-js vjs-default-skin vjs-big-play-centered\" style=\"display: block; margin-left: auto; margin-right: auto;\" poster=\"../file/upload/6e626973-2ac2-4eab-a4c4-49b7a1ca55d8.jpg\" preload=\"auto\" controls=\"controls\" width=\"800\" height=\"400\" data-setup=\"{}\"><source src=\"../file/video/ea21fb29-a895-483b-a699-458756c6020e.mp4\" type=\"video/mp4\" /><source src=\"../file/video/754644db-88a2-438f-85c5-6898b1a2493d.webm\" type=\"video/webm\" /></video></p>\n</body>\n</html>', null, null, null, null, null, '0'), ('595ec285-4f5f-47c2-964e-c6b07425f9bd', 'content', 'subject', '测试项目', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>普通项目测试内容</p>\n</body>\n</html>', '2016-09-03T11:26:43', null, null, '2', null, '1'), ('66f7cb91-f471-40ce-a6b6-5bf39455ecc3', 'news', 'sp', '商品新闻测试', null, null, '2016-08-29 09:35:07', 'file/upload/569ebef1-c2f3-4039-85c5-1809cd653e8b.jpg', null, '1', '安师大发生的发生短发是大法师豆腐', null), ('7436206a-3acb-4f1d-af30-847654facc8d', 'content', 'law', '法律声明', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<h3>使用条款及条件 / 法律公告</h3>\n<p><br /><br />重要提示！敬请仔细阅读下列条款及条件（&ldquo;条款&rdquo;），该等条款管限您使用（包括接达、浏览及/或使用以下各项的任何互动功能）在以中华人民共和国消费者为对象的<a href=\"http://www.chanel.com/\" target=\"_BLANK\" rel=\"nofollow\">www.chanel.com</a>可接达的香奈儿网站（以及与包括透过香奈儿网站或香奈儿寄存或赞助的其他推广网站（例如在第三方社交网路服务上的迷你网站或网页）可接达的任何其他香奈儿网站或网页）的该等部份，包括藉着登入<a href=\"http://www.chanel.com/\" target=\"_BLANK\" rel=\"nofollow\">www.chanel.com</a>并从 &ldquo;Asia-Pacific&rdquo; 选定&ldquo;中国&rdquo;而接达的香奈儿网站中的该等部份（统称&ldquo;有关网站&rdquo;）。<br /><br />当您透过<a href=\"http://www.chanel.com/\" target=\"_BLANK\" rel=\"nofollow\">www.chanel.com</a>或透过其他推广网站接达其他语言特定、国家特定或地区特定网页时，请参阅适用于该等网页的独立使用条款。<br /><br />使用有关网站须受此等具法律约束力的条款规限，并构成您同意受此等条款约束及按照此等条款行事。我们保留随时修改条款的权利。任何该等修改将公布于有关网站，以及您同意须受该等修改约束。</p>\n<p>香奈儿公司及/或其全球联系人（&ldquo;香奈儿&rdquo;）拥有有关网站的一切权利、所有权及利益及/或拥有在有关网站上（包括在社交网路网站上）的内容及应用程式。<br /><br />香奈儿拥有在有关网站上的一切材料的一切著作权，或具有从第三方取得可在有关网站上使用材料的有效权利。香奈儿亦拥有在有关网站上或与有关网站相关所使用的一切商标、服务标记、营业名称、图样标志及网域名称，或具有从第三方取得可使用任何该等材料的有效权利。为任何未经明确允许的目的而变更或使用来自有关网站的材料，皆属侵犯香奈儿的著作权及其他专有权利。严禁在未取得香奈儿事先书面同意下使用本网站的材料。<br /><br />有关网站的任何部份除供浏览目的之外，在未取得香奈儿事先书面同意下，皆不得以任何方式复制、重制、重新刊登、上载、张贴、传送或散布。此项禁止规定亦包括以框架方式将任何内容由有关网站连结，以及未获授权的连结。</p>\n<p>使用或浏览有关网站所涉风险将由您自行承担。香奈儿或在设立或提供有关网站时代表香奈儿或以其他方式与香奈儿有联系的任何人士，皆不须因您使用有关网站而造成的任何直接、间接、特殊、惩罚性、连带、惩戒性或相应而生的损害赔偿负上法律责任。在法律许可的范围内且不受限于任何前述规定下，在有关网站上的各项信息均以&ldquo;现况&rdquo;方式向您提供，并无任何性质的明示或隐含保证，包括但不限于有关适销性、对某特别用途的适用性、不含电脑病毒或不侵权的隐含保证。由于某些司法管辖区并不容许在隐含保证上的限制，或对相应而生或连带损害赔偿的法律责任限制，故以上限制对您未必适用。请查看您的当地法律。<br /><br />您因登录或报名参加或向有关网站提出相关问题而藉电子邮件向香奈儿提交的应邀提供的信息，及/或购买产品，按情况而定，均受我们的私隐政策规限。一切非应邀提供的评论、意见、或其他陈述，包括意念、概念、技术、知识及类似信息，均不会被香奈儿视为机密处理，而香奈儿可按其认为适当的任何方式来使用该等材料。有关这方面的进一步息，请参阅我们的私隐政策。<br /><br /><strong>价格</strong><br /><br />在适用的情況下，本官网上提供的价格为人民币(含稅)，仅供参考，不能做为销售依据。 有关价格与香奈儿设于中国的香奈儿精品店所定的价格一致。香奈儿精品店保留随时变更实际售价的权利,不再另行通知。香奈儿高级珠宝网站所载的产品款式所提供价格系以52号或中码尺寸为参考基准,相同款式产品的售价可能会依尺寸大小而有所调整。</p>\n</body>\n</html>', '2016-09-03T14:41:32', null, null, '1', null, '1'), ('7647c551-2594-443e-bf78-05dffca0c37e', 'content', 'law', '隐私政策', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>全球的香奈儿公司（&ldquo;香奈儿&rdquo;）意识到保障到访香奈儿相关网站的所有消费者（&ldquo;您&rdquo;或&ldquo;使用者&rdquo;）的私隐的重要性。<br /><br />我们亦相信，告知您我们将如何使用您的个人信息，并让您可选择将如何使用此等信息数据至为重要。基于此等理由，我们鼓励您仔细阅读此私隐政策。<br /><br />此私隐政策乃发给并适用于到访下列各项的人士：在以中华人民共和国消费者为对象的<a href=\"http://www.chanel.com/\" target=\"_BLANK\" rel=\"nofollow\">www.chanel.com</a>可接达的香奈儿网站（以及与包括透过香奈儿网站或香奈儿管理赞助的其他推广网站（例如在第三方社交网路服务上的迷你网站或网页）可接达的任何其他香奈儿网站或网页）（统称&ldquo;有关网站&rdquo;）的该等部份，包括藉着登入<a href=\"http://www.chanel.com/\" target=\"_BLANK\" rel=\"nofollow\">www.chanel.com</a>并从 &ldquo;Asia-Pacific&rdquo; 选定&ldquo;中国&rdquo;而接达的香奈儿网站中的该等部份。<br /><br />此私隐政策仅适用于我们透过有关网站所收集的信息，并不引伸至适用于任何其它网站，包括拟为中华人民共和国境外使用者而设的其它香奈儿特定语言或特定国家网页。透过有关网站所收集的个人信息将直接传送至存置在中华人民共和国境内及境外的服务器。因此，我们可为下文所述目的而将您的个人信息移转至其它国家/地区。倘若您是从中华人民共和国境外接达为中华人民共和国消费者而设的网页，则中华人民共和国法律及我们可能将您的个人信息移转所至的其他国家/地区的法律未必提供程度相等于您本身所属国家/地区的法律可提供的保障。<br /><br />中华人民共和国法律应适用于透过有关网站所收集的个人信息（按下文第2.a.条所界定）。</p>\n<p>a. 个人信息</p>\n<p>&nbsp;</p>\n<p>虽然使用者可以不具名方式浏览我们的网站时，但在有关网站使用者在网站上自愿登记或以其他方式报名参与有关网站时、或透过有关网站与我们联络时，或从有关网站进行购买而自愿提供可识别个人身份信息时，按情況而定，我们仍可收集可识别个人身份信息（&ldquo;个人信息&rdquo;）。有关网站使用者可基于各种理由而提供个人信息，该等理由包括但不限于为了取得定期更新、产品信息、活动事项信息及服务信息，回答调查、参加比赛及收取其他宣传推广机会的通知，以及进行购买，按情況而定。我们可收集的个人信息种类包括姓名、性别、出生日期、地址、电话号码、电邮地址及购物信息，例如用以促进香奈儿产品销售的信用卡或借记卡信息，按情況而定。我们亦可将您提供的信息用以设立客户个人档案，以便让您知道您可能感兴趣的产品或活动事项以及精简日后购买的流程，按情況而定。我们可将我们在有关网站上收集的个人信息与我们在非网上收集有关使用者的其他信息合并，以便我们制定更切合需要的市场推广或网站内容，或作其他用途，例如内部研究调查。有关如何选择不接受允许我们使用您的个人信息作市场推广用途的信息，请参阅下文第6条。</p>\n<p>&nbsp;</p>\n<p>b. 非个人信息</p>\n<p>&nbsp;</p>\n<p>当您到访有关网站时，我们会收集若干汇集及非个人信息。此等信息与单一可识别身份访客无关。此等信息告知我们关于有多少使用者到访有关网站及所接达的网页等事项。收集此等信息有助我们为我们的访客制定切合需要的有关网站。<br /><br />当您到访有关网站进行浏览、阅读或下载信息时，我们会自动收集您的电脑网页浏览器发出的标准电脑信息，例如您的IP位址、浏览器种类及语文、接达次数及转介网站地址。我们通常不会将标准电脑信息连结至将会让我们识别使用者身份的任何事项，但如属为了强制执行遵照我们的服务规则或条款，或为了保障我们的服务、网站、使用者或其他人士则除外。<br /><br />按下文所述明，我们亦可透过&ldquo;Cookies&rdquo;或&ldquo;Web Beacons&rdquo;，收集非个人信息。<br /><br />Cookies曲奇：Cookies就是当您访问任何网站时，这些网站可能传送到您的浏览器并存储在您电脑中的一些信息。当您再次访问这些网站时，存储在您电脑中的Cookies会将之前存储的信息返回至网站。Cookies可以告诉我们，使用者是否首次访客或之前曾到访有关网站以及使用者对网站的哪些范畴最感兴趣。Cookies的使用，可以在我们的网站上存放您的访问信息有，从而提升您的上网体验。Cookies还可以帮助我们统计网站的访问活动，让我们可厘定哪些领域及功能最受欢迎。此等信息令我们得以改善我们的网站。<br /><br />大部份网络浏览器都被默认均设定为接受Cookies。然而，您可重新设定您的浏览器，以拒绝接受一切Cookies或显示接收到Cookies。若您选择拒绝接受Cookies，有关网站的某些功能可能会减弱。<br /><br />Web Beacons：Web Beacons 也被称为&ldquo;网络站信标&rdquo;、网络数据采集程序或者互联网访问标签，它是内嵌在网页和电子邮件内的小型图形文件，让我们或我们的第三方合作伙伴通过监控网站上的访问活动而或使Cookies更为有效。通过收集访问者在收到我们的电邮或网站内的指引信息之前和之后访问网站的情况，它可以帮助我们或我们的第三方合作伙伴评估访问行为，从而估计及提高我们的市场推广效率。我们使用日志档案储存透过网站信标所收集的信息数据。</p>\n</body>\n</html>', '2016-09-03T14:43:17', null, null, '2', null, '1'), ('83e71a2f-593d-4059-b54f-94f699a0ddf9', 'case', 'alk', 'asdfasdf', null, null, '2016-08-29 09:51:15', null, null, '1', 'asdf', null), ('86e849bc-9e67-4a0c-9fe4-8b054728ea47', '0091c547-278d-4de7-91ec-90c8caae5b82', 'productrich', null, null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>详细页测试</p>\n</body>\n</html>', '2016-09-02 14:48:12', null, null, null, null, '0'), ('94f1cb5b-a6af-42d2-8b2f-1816d820e90e', 'content', 'faq', '何处可以买到诗蜜安黛的产品？', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>诗蜜安黛所有的产品只在诗蜜安黛官网及授权美容店出售。请点击寻找销售店铺。</p>\n</body>\n</html>', '2016-09-03T14:32:08', null, null, '1', null, '1'), ('95d58853-aff5-493a-95fb-c8348f6164de', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', 'brandstory', null, null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/4dd0395b-b687-4ebe-ab0d-7b5b6dda3770.jpg\" alt=\"\" width=\"100%\" /></p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/390582b7-10cf-4cfc-a98d-f181898a4946.jpg\" alt=\"\" width=\"100%\" /></p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/6cacce4f-819e-441b-b2e3-1a67200a4165.jpg\" alt=\"\" width=\"100%\" /></p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/007b397a-f2b4-402a-8919-5096769c2add.jpg\" alt=\"\" width=\"100%\" /></p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/9b804ef3-1a4e-4944-b10c-299506d8be98.jpg\" alt=\"\" width=\"100%\" /></p>\n</body>\n</html>', null, null, null, null, null, '0'), ('9e29ed0c-5d60-4804-ba44-3869e11aaa89', '24375c1c-4047-4849-b0ab-46d008e32334', 'productrich', null, null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/dbc92297-026e-4304-9e78-7b9f3d3ce130.jpg\" alt=\"\" /></p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/e4111ee3-312b-46e6-8d9c-a2c9b699eb42.jpg\" alt=\"\" /></p>\n<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"../file/richedit/8750172c-1ad1-4145-9efe-f8f4876cc3ce.jpg\" alt=\"\" /></p>\n</body>\n</html>', '2016-09-02 14:41:30', null, null, null, null, '0'), ('a5dbd936-7f8d-462c-a131-73e6052a4440', 'ecef2cd9-1b7b-4da0-8912-0cc20a7014d5', 'brandstory', null, null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p style=\"text-align: center;\"><span style=\"font-family: 微软雅黑; font-size: 24pt;\">品牌故事</span></p>\n<p>诗蜜安黛</p>\n<p><strong>品牌简介：</strong></p>\n<p>紧致眼周肌肤，改善双眸疲倦现象 由精华笔和眼膜组成的眼部密集护理产品。改善细纹、黑眼圈、浮肿等眼周肌肤问题，恢复眼周肌肤弹性，散发明眸神采。</p>\n<p>修护眼部护理套装由两个步骤组成：</p>\n<p>滚珠式精华笔：可温和按摩眼周肌肤，凝露质地精华液蕴含多重活性成分，能同时紧实眼部肌肤淡化眼周皱纹，改善浮肿和黑眼圈</p>\n<p>容量：10 片 +6ml / 盒</p>\n<p><strong>理念</strong>诗蜜安黛品牌理念</p>\n<p>肌肤的自然保湿屏障，在你婴幼儿时期是完整的，但随着时间的推移便开始失去生命和活力，成为肌肤受损的主要原因。同样，拥有能够超越时间的活力美肌的秘密也在于&ldquo;保湿&rdquo;。</p>\n<p>通过20年对水和肌肤关系的研究，诗蜜安黛发现水不仅在保湿中发挥着重要作用，还能够增强美白和抗衰老产品的效果。</p>\n<p>独有的&ldquo;水科技&trade;&rdquo;，随时随地帮助自信的年轻女性获得自然水润和柔滑的肌肤。通过水的能量，我们为你还原肌肤本来的清澈透明。</p>\n<p><strong>信念</strong>诗蜜安黛的诞生，源于帮助女性获得清澈透明如雪般肌肤的承诺。</p>\n<p>肌肤的自然保湿屏障，在你婴幼儿时期是完整的，但随着时间的推移便开始失去生命和活力，成为肌肤受损的主要原因。同样，拥有能够超越时间的活力美肌的秘密也在于&ldquo;保湿&rdquo;。</p>\n<p>通过20年对水和肌肤关系的研究，诗蜜安黛发现水不仅在保湿中发挥着重要作用，还能够增强美白和抗衰老产品的效果。</p>\n<p>独有的&ldquo;水科技&trade;&rdquo;，随时随地帮助自信的年轻女性获得自然水润和柔滑的肌肤。通过水的能量，我们为你还原肌肤本来的清澈透明。</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n</body>\n</html>', null, null, null, null, null, '0'), ('b501a63c-5307-43ca-a22b-8b8618329c8c', 'service', 'faq', 'asdfasdfasdf', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>asdfasdf</p>\n</body>\n</html>', '2016-08-27 14:11:55', null, null, '1', null, null), ('bc402feb-ae67-4619-b6eb-b258d41c5ea7', 'content', 'lxwm', '联系我们', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>如果需要联系我们，请发送邮件到XXX@XXX.com。我们会安排专门客服人员与您取得联系。</p>\n</body>\n</html>', '2016-09-03T14:37:24', null, null, '1', null, '1'), ('e8018418-02a2-4350-a97c-f4dd95b6a726', 'news', 'qy', 'asdfasdf', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>《关于北京市2016年国民经济和社会发展计划上半年执行情况的报告》指出，尽管北京市2016年上半年常住人口增量、增速较上年同期均有所降低，但总量仍持续增加。从布局看，上半年北京城六区人口减量占全年任务的比重较低，年底实现城六区人口由增转降、完成全年的调控目标，任务十分艰巨。</p>\n<p>　　 根据此前北上广深设定的各自的人口红线，今后五年北京、上海、广州、深圳的常住人口增长空间分别为129.5万人、84.73万人、199.89万人、342.11万人。</p>\n<p>　　 针对新出台的积分落户政策，北京市有关部门表示，北京的户籍制度改革将统筹首都人口调控与城市可持续发展要求，坚持总量控制、有序推进的原则，把握好积分落户政策与人口调控目标的有效衔接和平衡。</p>\n<p>　　 积分落户政策与人口调控如何有效衔接，也成为上海、广州、深圳等国内超大城市面临的问题。</p>\n<p>　　 《上海市人民政府关于进一步推进本市户籍制度改革的若干意见》提出的四项原则之首，就是&ldquo;坚持总量调控、结构优化&hellip;&hellip;严格控制人口规模，综合解决人口总量、结构、布局问题。&rdquo;从公开数据看，上海、广州此前实现积分落户的人数年均也仅有5000人左右。</p>\n<p>　　<strong>北京劳动力供给2020年或现拐点</strong></p>\n<p>　　 多位专家指出，国内超大城市人口调控与疏解面临的问题，反映出<a class=\"linkAbout\" title=\"中国\" href=\"http://country.huanqiu.com/china\" target=\"_blank\">中国</a>城市人口结构、都市圈人口汇集等深层次问题。超大城市人口布局和调控，应该指向实现人口与经济社会发展之间匹配平衡的目标。</p>\n<p>&nbsp;</p>\n</body>\n</html>', '2016-08-29 09:31:32', null, null, '1', 'asdfasdf', null), ('ee251c96-8bd9-4835-bbb1-362e4feeb527', 'article', 'mrwz', '美容文章测试', null, null, '2016-08-29 09:48:50', null, null, '1', '啊善良的会计分录；阿克苏江东父老', null), ('ef7efeb9-0e2d-4481-bbd5-ff60b735a038', 'content', 'subject', '定制研发', null, '<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p>定制研发富文本页测试</p>\n</body>\n</html>', '2016-09-03T11:26:43', null, null, '1', null, '1');
COMMIT;

-- ----------------------------
--  Table structure for `public_dis_config`
-- ----------------------------
DROP TABLE IF EXISTS `public_dis_config`;
CREATE TABLE `public_dis_config` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `rebates_down` decimal(11,2) DEFAULT NULL,
  `rebates_up` decimal(12,2) DEFAULT NULL,
  `bonuses_down` decimal(11,2) DEFAULT NULL,
  `bonuses_up` decimal(11,2) DEFAULT NULL,
  `taken_dian` int(11) DEFAULT NULL,
  `taken_daili` int(11) DEFAULT NULL,
  `quota_down` int(11) DEFAULT NULL,
  `quota_up` int(11) DEFAULT NULL,
  `deposit_down` int(11) DEFAULT NULL,
  `deposit_up` int(11) DEFAULT NULL,
  `bonuses_ratio_down` int(11) DEFAULT NULL,
  `bonuses_ratio_up` int(11) DEFAULT NULL,
  `balance_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_dis_config`
-- ----------------------------
BEGIN;
INSERT INTO `public_dis_config` VALUES ('1', '0.40', '0.50', '200.00', '500.00', '0', '0', '0', '0', '0', '0', '1', '7', '1');
COMMIT;

-- ----------------------------
--  Table structure for `public_log`
-- ----------------------------
DROP TABLE IF EXISTS `public_log`;
CREATE TABLE `public_log` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `userid` varchar(40) DEFAULT NULL,
  `touserid` varchar(40) DEFAULT NULL,
  `logtype` varchar(40) DEFAULT NULL,
  `logmemo` varchar(500) DEFAULT NULL,
  `logtime` varchar(100) DEFAULT NULL,
  `lognum` varchar(100) DEFAULT NULL,
  `logpay` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_order`
-- ----------------------------
DROP TABLE IF EXISTS `public_order`;
CREATE TABLE `public_order` (
  `id` varchar(40) NOT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `ordernumber` varchar(200) DEFAULT NULL,
  `ordertime` varchar(100) DEFAULT NULL,
  `ordertotal` float DEFAULT NULL,
  `orderstatus` int(11) DEFAULT NULL,
  `orderstatusmemo` varchar(100) DEFAULT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `identity` varchar(40) DEFAULT NULL,
  `deliverynum` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_order_logistics`
-- ----------------------------
DROP TABLE IF EXISTS `public_order_logistics`;
CREATE TABLE `public_order_logistics` (
  `id` varchar(40) NOT NULL,
  `orderid` varchar(40) DEFAULT NULL,
  `handletime` varchar(100) DEFAULT NULL,
  `handleresult` varchar(500) DEFAULT NULL,
  `handleman` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_order_path`
-- ----------------------------
DROP TABLE IF EXISTS `public_order_path`;
CREATE TABLE `public_order_path` (
  `id` varchar(40) NOT NULL,
  `orderid` varchar(40) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `userphone` varchar(100) DEFAULT NULL,
  `userpath` varchar(1000) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_order_product`
-- ----------------------------
DROP TABLE IF EXISTS `public_order_product`;
CREATE TABLE `public_order_product` (
  `id` varchar(40) NOT NULL,
  `orderid` varchar(40) DEFAULT NULL,
  `productid` varchar(40) DEFAULT NULL,
  `productname` varchar(200) DEFAULT NULL,
  `productpic` varchar(200) DEFAULT NULL,
  `productnum` int(11) DEFAULT NULL,
  `isoknum` int(11) DEFAULT NULL,
  `ifok` int(11) DEFAULT NULL,
  `ifover` int(11) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `productmemo` varchar(2000) DEFAULT NULL,
  `ordertime` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `productsize` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_order_return`
-- ----------------------------
DROP TABLE IF EXISTS `public_order_return`;
CREATE TABLE `public_order_return` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `orderid` varchar(40) DEFAULT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `returndate` varchar(100) DEFAULT NULL,
  `returnproductid` varchar(40) DEFAULT NULL,
  `returnstatus` int(11) DEFAULT NULL,
  `returnstatusmemo` varchar(50) DEFAULT NULL,
  `memo` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_pay`
-- ----------------------------
DROP TABLE IF EXISTS `public_pay`;
CREATE TABLE `public_pay` (
  `id` varchar(40) NOT NULL,
  `orderid` varchar(40) DEFAULT NULL,
  `paytype` varchar(50) DEFAULT NULL,
  `paybank` varchar(100) DEFAULT NULL,
  `paynum` decimal(11,2) DEFAULT NULL,
  `paystatus` int(11) DEFAULT NULL,
  `settype` varchar(100) DEFAULT NULL,
  `setbank` varchar(100) DEFAULT NULL,
  `paycreatetime` varchar(100) DEFAULT NULL,
  `paytime` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_phone_code_log`
-- ----------------------------
DROP TABLE IF EXISTS `public_phone_code_log`;
CREATE TABLE `public_phone_code_log` (
  `id` varchar(40) NOT NULL,
  `phonenumber` varchar(100) DEFAULT NULL,
  `sendtime` varchar(100) DEFAULT NULL,
  `sendtimestr` varchar(100) DEFAULT NULL,
  `sendcode` varchar(50) DEFAULT NULL,
  `sendtype` varchar(50) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_phone_code_log`
-- ----------------------------
BEGIN;
INSERT INTO `public_phone_code_log` VALUES ('f348649c-b7fe-4791-8a9d-bb729e2026d1', '13800138001', '2016-08-30 19:17:14', '1472555834825', '664185', 'PCREG', '127.0.0.1');
COMMIT;

-- ----------------------------
--  Table structure for `public_pic`
-- ----------------------------
DROP TABLE IF EXISTS `public_pic`;
CREATE TABLE `public_pic` (
  `id` varchar(40) NOT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `parenttype` varchar(100) DEFAULT NULL,
  `pic_path` varchar(200) DEFAULT NULL,
  `pic_memo` varchar(500) DEFAULT NULL,
  `pic_active` int(11) DEFAULT NULL,
  `pic_sort` int(11) DEFAULT NULL,
  `pic_url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_pic`
-- ----------------------------
BEGIN;
INSERT INTO `public_pic` VALUES ('08507037-167c-4e77-a57d-52bd0bf040e0', 'home_pic', 'lbt', 'file/upload/08507037-167c-4e77-a57d-52bd0bf040e0.jpg', '', '1', '1', '/zhxh/pcMain/series.htmls?id=fb68235f-e483-4e40-9f76-aaa2a0613794'), ('16f12395-3528-46d6-9f19-e6ba45803c5a', 'fb68235f-e483-4e40-9f76-aaa2a0613794', 'brandlist_lb_pic', 'file/upload/40f5a599-201b-4f9e-8592-6cc7d56e36d2.jpg', '', '1', '1', ''), ('18c74e90-e5c5-409b-8b9d-4d095b686cf2', 'fb68235f-e483-4e40-9f76-aaa2a0613794', 'brandlist_pic', 'file/upload/33af4bb6-1e74-4d1b-9566-c5c8bd49d40d.jpg', '', '1', '1', '/zhxh/pcMain/product_c.htmls?id=45e02ae0-02b8-4864-8670-6635e901c4e1'), ('1af06e63-3cd1-4783-8d91-99ca55782a5b', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'brandfirst_lb_pic', 'file/upload/1af06e63-3cd1-4783-8d91-99ca55782a5b.jpg', '', '0', '12', 'ddd'), ('43c5b98e-d9f9-40bf-8eea-afb585ccc82c', 'e14343dd-39b9-4d98-acfc-17a06c81be42', 'brandlist_pic', 'file/upload/15c58ac1-3896-46b5-a4d4-14fc5f7a9955.jpg', '', '1', '1', 'asdf'), ('45de7053-2aeb-40f5-ac11-af976ebc0303', 'home_pic', 'lbt', 'file/upload/45de7053-2aeb-40f5-ac11-af976ebc0303.jpg', '', '1', '1', '/zhxh/pcMain/series.htmls?id=fb68235f-e483-4e40-9f76-aaa2a0613794'), ('4cdb9ab1-2498-4994-acf2-981d5eba071e', 'fb68235f-e483-4e40-9f76-aaa2a0613794', 'brandlist_lb_pic', 'file/upload/fed148da-b8bd-4caa-92cd-fd558cf3ba55.jpg', '', '1', '1', '/zhxh/pcMain/product_c.htmls?id=45e02ae0-02b8-4864-8670-6635e901c4e1'), ('5e07ccba-b76a-4e58-b71e-72f3a66f082b', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'brandfirst_lb_pic', 'file/upload/8182d194-e3fc-48f1-b8a9-ac1a7367bfd0.jpg', 'asdfasdfasdf', '0', '1', 'asdfdddddd'), ('621d0d41-9172-4d4a-9e88-88244dcd91de', 'home_pic', 'lbt', 'file/upload/621d0d41-9172-4d4a-9e88-88244dcd91de.jpg', '', '1', '1', '/zhxh/pcMain/product_c.htmls?id=45e02ae0-02b8-4864-8670-6635e901c4e1'), ('6de24551-c703-4d4c-9127-2961bb0cbf56', 'e14343dd-39b9-4d98-acfc-17a06c81be42', 'brandlist_lb_pic', 'file/upload/6de24551-c703-4d4c-9127-2961bb0cbf56.jpg', '', '1', '2', 'rrrrr'), ('6ebcfb58-15bc-4012-9565-9e94cf2bfc54', 'fb68235f-e483-4e40-9f76-aaa2a0613794', 'brandlist_lb_pic', 'file/upload/da31150c-3c5a-4fe8-b203-50c57b508c4b.jpeg', '', '1', '1', ''), ('6f8c6543-531d-412d-a5e9-538257d45632', 'e14343dd-39b9-4d98-acfc-17a06c81be42', 'brandlist_pic', 'file/upload/6f8c6543-531d-412d-a5e9-538257d45632.jpg', '', '0', '1', ''), ('7a603d3f-d613-4524-95f3-f54610344db8', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'brandfirst_lb_pic', 'file/upload/7a603d3f-d613-4524-95f3-f54610344db8.jpg', '', '1', '1', ''), ('93e36b0a-d0ad-42f7-b85b-5370c201e86e', 'e14343dd-39b9-4d98-acfc-17a06c81be42', 'brandlist_lb_pic', 'file/upload/4e66a6b2-ce05-46c1-89c8-18fa21cf8e3b.jpg', '', '0', '1', 'af'), ('95913f15-d148-49be-b9d1-d69283eef3fc', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'brandfirst_lb_pic', 'file/upload/95913f15-d148-49be-b9d1-d69283eef3fc.jpg', '', '0', '1', ''), ('b7af19f6-408b-4c17-99b5-e698afd9a215', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', 'brandfirst_lb_pic', 'file/upload/718c10c6-74de-4aa5-8aee-a58b621b3ab4.jpg', '', '1', '1', '/zhxh/pcMain/product_c.htmls?id=45e02ae0-02b8-4864-8670-6635e901c4e1'), ('cd6af10f-8139-4b37-85fb-cd28e722e49f', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', 'brandfirst_lb_pic', 'file/upload/676ea826-c709-42d7-b322-57743868f733.jpg', '', '1', '1', ''), ('dcb84217-a35c-47b8-bd40-4a9c61aba74e', 'e14343dd-39b9-4d98-acfc-17a06c81be42', 'brandlist_lb_pic', 'file/upload/dcb84217-a35c-47b8-bd40-4a9c61aba74e.jpg', '', '0', '1', ''), ('ebab2b83-62b9-4f8b-96db-19141d7281f8', '9eedaa81-dec0-4f69-a46c-0b069ed49666', 'brandfirst_lb_pic', 'file/upload/ebab2b83-62b9-4f8b-96db-19141d7281f8.jpg', '', '0', '1', '');
COMMIT;

-- ----------------------------
--  Table structure for `public_product`
-- ----------------------------
DROP TABLE IF EXISTS `public_product`;
CREATE TABLE `public_product` (
  `id` varchar(40) NOT NULL,
  `brandid` varchar(40) DEFAULT NULL,
  `productname` varchar(200) DEFAULT NULL,
  `productcode` varchar(100) DEFAULT NULL,
  `showtype` int(11) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `productpic` varchar(200) DEFAULT NULL,
  `isshow` int(11) DEFAULT NULL,
  `productmemo` varchar(2000) DEFAULT NULL,
  `createdate` varchar(100) DEFAULT NULL,
  `ifdis` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_product`
-- ----------------------------
BEGIN;
INSERT INTO `public_product` VALUES ('09dff08d-7188-4096-9fda-8c350f037f77', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '焕颜肌肤面部精华', '', '1', null, '', '1', '', '2016-09-01', '0', '1'), ('5ce0ea9a-35cf-49fb-8ffd-22a955661902', 'b2ea19cc-4653-4a91-bfaa-e3e58e07caa0', '新的商品', '', '1', null, '', '1', '', '2016-08-25', '0', '1'), ('a0211782-a1c1-4280-a450-d94a9a448e91', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '精粹净爽调理水', '', '1', null, '', '1', '', '2016-09-01', '0', '4'), ('a91053cc-f7dd-4ec8-9927-d3dc19f19def', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '亮妍日夜精华霜', '', '1', null, '', '1', '', '2016-09-01T00:00:00', '0', '3'), ('be117559-422e-4f7d-b1a1-71ee387eedda', '039ad8fe-f0eb-48d4-accf-a64cebc7ecef', '菁纯新生精华', '', '1', null, '', '1', '', '2016-09-01T00:00:00', '0', '2');
COMMIT;

-- ----------------------------
--  Table structure for `public_product_dis`
-- ----------------------------
DROP TABLE IF EXISTS `public_product_dis`;
CREATE TABLE `public_product_dis` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `productid` varchar(40) DEFAULT NULL,
  `diannum` decimal(11,2) DEFAULT NULL,
  `shinum` decimal(11,2) DEFAULT NULL,
  `shengnum` decimal(11,2) DEFAULT NULL,
  `tuijiannum` decimal(11,2) DEFAULT NULL,
  `limitnum` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_product_size`
-- ----------------------------
DROP TABLE IF EXISTS `public_product_size`;
CREATE TABLE `public_product_size` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `productid` varchar(40) DEFAULT NULL,
  `productname` varchar(200) DEFAULT NULL,
  `showtype` int(11) DEFAULT NULL,
  `productpic` varchar(500) DEFAULT NULL,
  `productmemo` varchar(2000) DEFAULT NULL,
  `productsize` varchar(100) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `saleprice` decimal(11,2) DEFAULT NULL,
  `sizesort` int(11) DEFAULT NULL,
  `isshow` int(11) DEFAULT NULL,
  `linkids` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_product_size`
-- ----------------------------
BEGIN;
INSERT INTO `public_product_size` VALUES ('0091c547-278d-4de7-91ec-90c8caae5b82', 'be117559-422e-4f7d-b1a1-71ee387eedda', '菁纯新生精华', '1', 'file/pic/b2baa107-4f61-4aa5-9854-6c58a0da7fa5.jpg', '菁纯新生精华放大双眼眼部修护精华紧致淡化细纹黑眼圈', '30ml', '2000.00', '1000.00', '2', '1', ''), ('24375c1c-4047-4849-b0ab-46d008e32334', 'be117559-422e-4f7d-b1a1-71ee387eedda', '菁纯新生精华', '1', 'file/pic/876f5d06-cd27-4abd-a702-3154f0e74297.jpg', '15ml菁纯新生精华放大双眼眼部修护精华紧致淡化细纹黑眼圈', '15ml', '1000.00', '500.00', '1', '1', ''), ('45e02ae0-02b8-4864-8670-6635e901c4e1', '09dff08d-7188-4096-9fda-8c350f037f77', '焕颜肌肤面部精华', '1', 'file/pic/890240ca-293f-45fa-a59b-0eb064303239.jpg', '诗蜜安黛寻求最高品质的产品，始终遵循“所有疗效的前提，必须是绝对的安全和没有副作用。”\n从科研到美，诗蜜安黛通过“跨界产品”为全球女性奉上“全局护理”的抗衰老盛宴，由内而外，真正实现专业、安全、有效的肌肤保养，用不老的美丽，永恒你最好的时光。', '50ml', '5800.00', '4200.00', '1', '1', '24375c1c-4047-4849-b0ab-46d008e32334,45e02ae0-02b8-4864-8670-6635e901c4e1,0091c547-278d-4de7-91ec-90c8caae5b82');
COMMIT;

-- ----------------------------
--  Table structure for `public_set_user_standard`
-- ----------------------------
DROP TABLE IF EXISTS `public_set_user_standard`;
CREATE TABLE `public_set_user_standard` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `parentid` varchar(40) DEFAULT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `buyerdis` decimal(11,2) DEFAULT NULL,
  `rebatesdis` decimal(11,2) DEFAULT NULL,
  `bonusesdis` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_user`
-- ----------------------------
DROP TABLE IF EXISTS `public_user`;
CREATE TABLE `public_user` (
  `id` varchar(40) NOT NULL,
  `usercode` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `phonenumber` varchar(50) DEFAULT NULL,
  `identity` varchar(40) DEFAULT NULL,
  `identitymemo` varchar(200) DEFAULT NULL,
  `dianid` varchar(40) DEFAULT NULL,
  `shidaiid` varchar(40) DEFAULT NULL,
  `shengdaiid` varchar(40) DEFAULT NULL,
  `tuijianid` varchar(40) DEFAULT NULL,
  `tuijianman` varchar(100) DEFAULT NULL,
  `tuijiansort` varchar(40) DEFAULT NULL,
  `setreturn` int(11) DEFAULT NULL,
  `isopen` int(11) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `uid` varchar(200) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `birthday` varchar(50) DEFAULT NULL,
  `companyname` varchar(200) DEFAULT NULL,
  `companypath` varchar(1000) DEFAULT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `belongcode` varchar(100) DEFAULT NULL,
  `companycode` varchar(100) DEFAULT NULL,
  `wechar` varchar(100) DEFAULT NULL,
  `rank` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_user`
-- ----------------------------
BEGIN;
INSERT INTO `public_user` VALUES ('0d654bf6-ef18-44ce-8b88-61fc493e1fe1', null, '张三', '13800138001', 'Z', '普通会员', null, null, null, null, null, null, '1', '1', '5f4dcc3b5aa765d61d8327deb882cf99', null, '1', null, null, null, null, null, null, null, null), ('1', null, 'wff', '13800138000', 'Z', '普通会员', null, null, null, null, null, null, null, '1', '47bce5c74f589f4867dbd57e9ca9f808', null, '1', '', null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `public_user_ask`
-- ----------------------------
DROP TABLE IF EXISTS `public_user_ask`;
CREATE TABLE `public_user_ask` (
  `id` varchar(40) NOT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `asktime` varchar(100) DEFAULT NULL,
  `askmemo` varchar(1000) DEFAULT NULL,
  `askstatus` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_user_bank`
-- ----------------------------
DROP TABLE IF EXISTS `public_user_bank`;
CREATE TABLE `public_user_bank` (
  `id` varchar(40) NOT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `incomebank` decimal(11,2) DEFAULT NULL,
  `costbank` decimal(11,2) DEFAULT NULL,
  `takenbank` decimal(11,2) DEFAULT NULL,
  `sellbank` decimal(11,2) DEFAULT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `havebank` decimal(11,2) DEFAULT NULL,
  `quotabank` decimal(11,2) DEFAULT NULL,
  `depositbank` decimal(11,2) DEFAULT NULL,
  `selltakenbank` decimal(11,2) DEFAULT NULL,
  `rebatesbank` decimal(11,2) DEFAULT NULL,
  `bonusesbank` decimal(11,2) DEFAULT NULL,
  `bonusestakenbank` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_user_link`
-- ----------------------------
DROP TABLE IF EXISTS `public_user_link`;
CREATE TABLE `public_user_link` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `parentid` varchar(40) DEFAULT NULL,
  `userid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_user_openid`
-- ----------------------------
DROP TABLE IF EXISTS `public_user_openid`;
CREATE TABLE `public_user_openid` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `parentid` varchar(40) DEFAULT NULL,
  `openid` varchar(200) DEFAULT NULL,
  `weixincode` varchar(100) DEFAULT NULL,
  `tuijianid` varchar(40) DEFAULT NULL,
  `tuijianman` varchar(100) DEFAULT NULL,
  `tuijiansort` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `public_user_path`
-- ----------------------------
DROP TABLE IF EXISTS `public_user_path`;
CREATE TABLE `public_user_path` (
  `id` varchar(40) NOT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `userphone` varchar(100) DEFAULT NULL,
  `userpath` varchar(1000) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_user_path`
-- ----------------------------
BEGIN;
INSERT INTO `public_user_path` VALUES ('c94635a8-71a8-48d8-9d15-4dc7a30a9e21', '1', '啊', '啊', '啊', '啊');
COMMIT;

-- ----------------------------
--  Table structure for `public_video`
-- ----------------------------
DROP TABLE IF EXISTS `public_video`;
CREATE TABLE `public_video` (
  `id` varchar(40) NOT NULL,
  `parentid` varchar(40) DEFAULT NULL,
  `parenttype` varchar(100) DEFAULT NULL,
  `videoshowpic` varchar(200) DEFAULT NULL,
  `videopath` varchar(500) DEFAULT NULL,
  `mp4oldname` varchar(500) DEFAULT NULL,
  `mp4newname` varchar(500) DEFAULT NULL,
  `webmoldname` varchar(500) DEFAULT NULL,
  `webmnewname` varchar(500) DEFAULT NULL,
  `islocal` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `isshow` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `public_video`
-- ----------------------------
BEGIN;
INSERT INTO `public_video` VALUES ('16eeec43-a97c-47ab-87c6-6f01936dc563', 'video', 'edit_video', 'file/upload/6e626973-2ac2-4eab-a4c4-49b7a1ca55d8.jpg', null, 'oceans.mp4', 'file/video/ea21fb29-a895-483b-a699-458756c6020e.mp4', 'Big_Buck_Bunny_Trailer.webm', 'file/video/754644db-88a2-438f-85c5-6898b1a2493d.webm', null, '1', '0'), ('5a93367f-057c-4c10-9ba9-289af4338b62', 'fb68235f-e483-4e40-9f76-aaa2a0613794', 'brandlist_video', 'file/pic/90e985bd-a4ca-4d92-b799-ba1adc79e7e4.jpg', '', '3.数字城市宣传片-宁波.mp4', 'file/video/864bb596-2b8e-44d9-a065-e843f76bd3e8.mp4', 'oceans.webm', 'file/video/6d301948-54e1-44be-922e-5c112fd2079f.webm', '0', '1', '1'), ('e7c3068e-4be0-4d53-8f9c-9b5ae62e5ec1', 'e14343dd-39b9-4d98-acfc-17a06c81be42', 'brandlist_video', 'file/pic/487f50ef-97f2-4ffd-9e24-5971faa4b4b5.jpg', '<embed wmode=\"opaque\" src=\"http://player.youku.com/player.php/sid/XMTMyNDA0MDc5Mg==/v.swf \" isAutoPlay=true allowFullScreen=\"true\" quality=\"high\" width=\"880\" height=\"400\" align=\"middle\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>', 'video.mp4', 'file/video/bcbd97a7-d894-4803-9d04-cc358f83cf19.mp4', 'oceans.webm', 'file/video/ccb8de63-09d4-4e12-9a90-510b32b8847b.webm', '0', '1', '0');
COMMIT;

-- ----------------------------
--  Table structure for `sys_account`
-- ----------------------------
DROP TABLE IF EXISTS `sys_account`;
CREATE TABLE `sys_account` (
  `id` varchar(40) NOT NULL,
  `accountcode` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `accountname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sys_account`
-- ----------------------------
BEGIN;
INSERT INTO `sys_account` VALUES ('1', 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', '超级帐户');
COMMIT;

-- ----------------------------
--  Table structure for `sys_data_dic`
-- ----------------------------
DROP TABLE IF EXISTS `sys_data_dic`;
CREATE TABLE `sys_data_dic` (
  `id` varchar(40) NOT NULL,
  `tablename` varchar(100) DEFAULT NULL,
  `field` varchar(100) DEFAULT NULL,
  `dic_key` varchar(100) DEFAULT NULL,
  `dic_value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sys_data_dic`
-- ----------------------------
BEGIN;
INSERT INTO `sys_data_dic` VALUES ('1', 'public_video', 'islocal', '0', '站内视频'), ('10', 'public_product', 'showtype', '2', '全图片效果显示商品信息'), ('11', 'public_product', 'isshow', '0', '禁止显示该商品信息'), ('12', 'public_product', 'isshow', '1', '开启显示该商品信息'), ('13', 'product_rated', 'isshow', '0', '不显示该评价'), ('14', 'product_rated', 'isshow', '1', '显示该评价'), ('15', 'public_user', 'userid', 'A', '身份为省代'), ('16', 'public_user', 'userid', 'B', '身份为市代'), ('17', 'public_user', 'userid', 'C', '身份为店'), ('18', 'public_user', 'userid', 'Z', '身份为普通会员'), ('19', 'public_user', 'tuijiansort', 'A', '仅是普通会员，A代表机构推荐的第一位'), ('2', 'public_video', 'islocal', '1', '外站视频'), ('20', 'public_user', 'tuijiansort', 'B', '仅是普通会员，B代表由A推荐的'), ('21', 'public_user', 'tuijiansort', 'C', '仅是普通会员，C代表由B推荐的'), ('22', 'public_user', 'tuijiansort', 'Z', '仅是普通会员，Z代表超出推荐范围'), ('23', 'public_user', 'setreturn', '0', '禁止该帐户接收任何固定额度分成'), ('24', 'public_user', 'setreturn', '1', '允许该帐户接收固定额度分成'), ('25', 'public_order', 'orderstatus', '0', '待支付'), ('26', 'public_order', 'orderstatus', '1', '待发货'), ('27', 'public_order', 'orderstatus', '2', '已发货'), ('28', 'public_order', 'orderstatus', '3', '已签收'), ('29', 'public_user_ask', 'askstatus', '0', '待解决'), ('3', 'sys_public', 'codetype', 'logo', '企业logo'), ('30', 'public_user_ask', 'askstatus', '1', '已回复'), ('31', 'public_order_product', 'status', '0', '已购买'), ('32', 'public_order_product', 'status', '1', '退货申请'), ('33', 'public_order_product', 'status', '2', '已退货'), ('34', 'public_order_product', 'ifover', '0', '未计算分成'), ('35', 'public_order_product', 'ifover', '1', '已计算完毕'), ('36', 'public_order_return', 'returnstatus', '1', '申请退货中'), ('37', 'public_order_return', 'returnstatus', '2', '退货结束'), ('38', 'public_product', 'ifdis', '0', '不参与三级分销'), ('39', 'public_product', 'ifdis', '1', '参与三级分销'), ('4', 'sys_public', 'codetype', 'bqxx', '版权信息'), ('40', 'public_log', 'logtype', 'logoin', '登录日志'), ('41', 'public_log', 'logtype', 'deposit', '充值日志'), ('42', 'public_log', 'logtype', 'quota', '配额日志'), ('43', 'public_log', 'logtype', 'rebates', '返利日志'), ('44', 'public_log', 'logtype', 'bonuses', '奖励日志'), ('45', 'public_log', 'logtype', 'bonuses_ratio', '奖励转贷款日志'), ('5', 'public_brand', 'brandpath', '0', 'pc端显示的品牌'), ('6', 'public_brand', 'brandpath', '1', '移动端显示的品牌'), ('7', 'public_brand', 'isshow', '0', '禁止显示该品牌'), ('8', 'public_brand', 'isshow', '1', '开启显示该品牌'), ('9', 'public_product', 'showtype', '1', '富文本效果显示商品信息');
COMMIT;

-- ----------------------------
--  Table structure for `sys_init`
-- ----------------------------
DROP TABLE IF EXISTS `sys_init`;
CREATE TABLE `sys_init` (
  `id` varchar(40) NOT NULL DEFAULT '',
  `initkey` varchar(200) DEFAULT NULL,
  `initvalue` varchar(200) DEFAULT NULL,
  `initkeymemo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sys_phone_fun`
-- ----------------------------
DROP TABLE IF EXISTS `sys_phone_fun`;
CREATE TABLE `sys_phone_fun` (
  `id` varchar(40) NOT NULL,
  `fun_cn` varchar(200) DEFAULT NULL,
  `fun_en` varchar(200) DEFAULT NULL,
  `fun_url` varchar(500) DEFAULT NULL,
  `fun_sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `sys_public`
-- ----------------------------
DROP TABLE IF EXISTS `sys_public`;
CREATE TABLE `sys_public` (
  `id` varchar(40) NOT NULL,
  `codename` varchar(100) DEFAULT NULL,
  `pic_path` varchar(200) DEFAULT NULL,
  `memo` varchar(500) DEFAULT NULL,
  `codetype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `sys_public`
-- ----------------------------
BEGIN;
INSERT INTO `sys_public` VALUES ('1', '企业Logo', 'file/logo/10423355-d134-4cbb-aae4-8d039c31d7c2.png', '55', 'logo1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
