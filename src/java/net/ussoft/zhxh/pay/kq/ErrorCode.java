package net.ussoft.zhxh.pay.kq;

import java.util.HashMap;
import java.util.Map;

/**
 * 错误代码表
 * */
public class ErrorCode {

	/**
	 * 错误代码
	 * */
	public static Map<String, String> initErrorCode(){
		Map<String, String> map = new HashMap<String, String>();
		map.put("0000", "支付成功 ");
		map.put("1000", "身份验证失败 ");
		map.put("1001", "信息填写不全 ");
		map.put("1002", "付款方帐号无效 ");
		map.put("1003", "加密方式不正确 ");
		map.put("1004", "收款方帐号无效 ");
		map.put("1005", "收款联系方式无效 ");
		map.put("1006", "交易描述不能大于100位");
		map.put("1007", "收款超过限额");
		map.put("1008", "费用大于付款金额");
		map.put("1009", "验签错误");
		map.put("1010", "IP地址不符");
		map.put("1011", "不匹配的接口类型");
		map.put("1012", "支付金额格式不正确");
		map.put("1014", "银行卡号不能为空");
		map.put("1005", "email或mobile格式不正确");
		map.put("1016", "不匹配的交易类型");
		map.put("1017", "货币代码错误");
		map.put("1018", "不能给自己付款");
		map.put("1019", "查询请求为空");
		map.put("1020", "查询类型无效");
		map.put("1021", "订单不存在");
		map.put("1022", "未指定查询起始时间");
		map.put("1023", "时间格式错误");
		map.put("1024", "无效数组");
		map.put("1025", "商家订单必须是0-9a-zA-Z和_的字符组合");
		map.put("1026", "超过最大交易笔数限制");
		map.put("2001", "服务器计费异常");
		map.put("2002", "服务处理异常");
		map.put("2003", "付款账户被冻结");
		map.put("2004", "其他异常");
		map.put("3001", "不是授权的会员");
		map.put("3002", "查询结果集为空");
		map.put("3003", "匹配收款人名称");
		map.put("3004", "不能给非快钱用户支付");
		map.put("3005", "通知异常");
		map.put("3006", "验签不能为空");
		map.put("3010", "付款超过限额");
		map.put("3014", "单笔付款超过限额");
		map.put("3015", "单笔收款超过限额");
		map.put("4007", "开户行不能为空");
		map.put("4008", "省份格式不正确");
		map.put("4009", "城市格式不正确");
		map.put("4013", "银行名称错误");
		map.put("5201", "订单不能被退款");
		map.put("5203", "不是订单的所有者");
		map.put("5204", "超出退款时限");
		map.put("5211", "订单号必须输入");
		map.put("5212", "商家订单号已经存在");
		map.put("6001", "余额不足");
		map.put("6003", "收款账户被冻结");
		map.put("6006", "交易引擎出错");
		map.put("7000", "批次号必须是A-Z/0-9和_的字符组合");
		map.put("7001", "批次号已经存在");
		map.put("7002", "付款会员号不能为空");
		map.put("7003", "付款账户不能为空");
		map.put("7004", "付款账户不存在");
		map.put("7005", "付款账户不是人民币账户");
		map.put("7006", "会员号和账户号不匹配");
		map.put("7007", "不匹配的字符集");
		map.put("7008", "主题信息验签不能为空");
		map.put("7009", "主题信息验签错误");
		return map;
	}
	
	/***
	 * 获取错误描述
	 * @param code
	 * @return
	 * */
	public static String getErrorCodeTxt(String code){
		Map<String, String> map = initErrorCode();
		return map.get(code);
	}
}
