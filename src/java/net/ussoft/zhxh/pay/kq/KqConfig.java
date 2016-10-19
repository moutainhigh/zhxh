package net.ussoft.zhxh.pay.kq;


/**
 * 快钱支付-参数配置
 * @author guodh
 * @version kq - v3.0.6
 * */
public class KqConfig {

	//人民币网关账号，该账号为11位人民币网关商户编号+01,该参数必填。
	public static String merchantAcctId = "1001213884201";
	
	//编码方式，1代表 UTF-8; 2 代表 GBK; 3代表 GB2312 默认为1,该参数必填。
	public static String inputCharset = "1";
	
	//接收支付结果的页面地址，该参数一般置为空即可。
	public static String pageUrl = "";
	
	//服务器接收支付结果的后台地址，该参数务必填写，不能为空。
	public static String bgUrl = "http://139.224.0.109/kq/receive.htmls";
	
	//网关版本，固定值：v2.0,该参数必填。
	public static String version =  "v2.0";
	
	//语言种类，1代表中文显示，2代表英文显示。默认为1,该参数必填。
	public static String language =  "1";
	
	//签名类型,该值为4，代表PKI加密方式,该参数必填。
	public static String signType =  "4";
	
	//商户订单号，以下采用时间来定义订单号，商户可以根据自己订单号的定义规则来定义该值，不能为空。
	public static String orderId = "2016101816220001";//new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	
	//订单金额，金额以“分”为单位，商户测试以1分测试即可，切勿以大金额测试。该参数必填。
	public static String orderAmount = "1";
	
	//订单提交时间，格式：yyyyMMddHHmmss，如：20071117020101，不能为空。
	public static String orderTime = "2016101816220001";//new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	
	//商品名称，可以为空。
	public static String productName= ""; 
	
	//支付方式，一般为00，代表所有的支付方式。如果是银行直连商户，该值为10，必填。
	public static String payType = "00";
	
	//银行代码，如果payType为00，该值可以为空；如果payType为10，该值必须填写，具体请参考银行列表。
//	String bankId = "";
	
	/*public static String getSignMsg(){
		String signMsgVal = "";
		signMsgVal = appendParam(signMsgVal, "inputCharset", inputCharset);
		signMsgVal = appendParam(signMsgVal, "pageUrl", pageUrl);
		signMsgVal = appendParam(signMsgVal, "bgUrl", bgUrl);
		signMsgVal = appendParam(signMsgVal, "version", version);
		signMsgVal = appendParam(signMsgVal, "language", language);
		signMsgVal = appendParam(signMsgVal, "signType", signType);
		signMsgVal = appendParam(signMsgVal, "merchantAcctId",merchantAcctId);
		signMsgVal = appendParam(signMsgVal, "orderId", orderId);
		signMsgVal = appendParam(signMsgVal, "orderAmount", orderAmount);
		signMsgVal = appendParam(signMsgVal, "orderTime", orderTime);
		signMsgVal = appendParam(signMsgVal, "productName", productName);
		signMsgVal = appendParam(signMsgVal, "payType", payType);
		System.out.println("signMsg="+signMsgVal);
		Pkipair pki = new Pkipair();
		String signMsg = pki.signMsg(signMsgVal);
		return signMsg;
	}

	public static String appendParam(String returns, String paramId, String paramValue) {
		if (returns != "") {
			if (paramValue != "") {

				returns += "&" + paramId + "=" + paramValue;
			}

		} else {

			if (paramValue != "") {
				returns = paramId + "=" + paramValue;
			}
		}

		return returns;
	}*/
	
}
