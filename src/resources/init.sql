-- 初始化数据库

-- 用户
DELETE FROM public_user;
-- 关系
DELETE FROM public_user_link;
-- 地址
DELETE FROM public_user_path;
-- 账户
DELETE FROM public_user_bank;
-- 分销明细
DELETE FROM public_bonus_list;
-- 交易记录
DELETE FROM public_trade_bill;
-- 品牌
DELETE FROM public_user_brand;
-- 返利奖励明细表
DELETE FROM public_dis_details;
-- 设置采购各种标准
DELETE FROM public_set_user_standard;
-- 设置奖励转货款标准
DELETE FROM public_set_bonuses_ratio;
-- 订单表
DELETE FROM public_order;
-- 订单商品
DELETE FROM public_order_product;
-- 订单地址
DELETE FROM public_order_path;
-- 返利数量表
DELETE FROM public_product_size_rebate;
-- 退货单
DELETE FROM public_order_return;
-- 订单物流
DELETE FROM public_order_logistics;
-- 订单支付
DELETE FROM public_pay;
-- 短信验证日志表
DELETE FROM public_phone_code_log;
-- 日志表
DELETE FROM public_log;
-- 消息表
DELETE FROM public_message;
-- 
DELETE FROM income_bill;
DELETE FROM spending_bill;
DELETE FROM quota_bill;
DELETE FROM rebate_reward_bill;
DELETE FROM share_bill;




-- 插入平台帐户 id为1
INSERT INTO `public_user` ( `id`, `usercode`, `username`, `phonenumber`, `identity`, `identitymemo`, `dianid`, `shidaiid`, `shengdaiid`, `tuijianid`, `tuijianman`, `tuijiansort`, `setreturn`, `isopen`, `password`, `uid`, `sex`, `birthday`, `companyname`, `companypath`, `parentid`, `belongcode`, `companycode`, `wechar`, `rank`, `createtime`, `sort`) VALUES ( '1', '', '集丽科技', '13701000001', 'A', '平台', '', '', '', '', '', '', '1', '1', 'e10adc3949ba59abbe56e057f20f883e', '', '1', '1977-01-23', '集丽科技公司', '北京市朝阳区', NULL, '', '13701000001', '', '中国总代理', '2016-09-09', '1');
INSERT INTO `public_user_link` ( `id`, `parentid`, `userid`) VALUES ( '1', '1', '1');
INSERT INTO `public_user_bank` ( `id`, `parentid`, `userid`, `incomebank`, `costbank`, `takenbank`, `sellbank`, `havebank`, `quotabank`, `depositbank`, `selltakenbank`, `rebatesbank`, `bonusesbank`, `bonusestakenbank`, `bankstate`, `bankstatetxt`) VALUES ( '1', '1', '1', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '正常');


