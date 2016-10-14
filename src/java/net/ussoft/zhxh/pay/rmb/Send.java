package net.ussoft.zhxh.pay.rmb;

import net.ussoft.zhxh.model.Income_bill;

public class Send {

	private final String PAGE_URL = "";
	private final String BG_URL = "http://101.227.69.165:8801/RMBPORT/receive.jsp";
	
	//人民币网关账号，该账号为11位人民币网关商户编号+01,该参数必填。
	private String merchantAcctId = "1001213884201";
	//编码方式，1代表 UTF-8; 2 代表 GBK; 3代表 GB2312 默认为1,该参数必填。
	private String inputCharset = "1";
	//接收支付结果的页面地址，该参数一般置为空即可。
	private String pageUrl = PAGE_URL;
	//服务器接收支付结果的后台地址，该参数务必填写，不能为空。
	private String bgUrl = BG_URL;
	//网关版本，固定值：v2.0,该参数必填。
	private String version =  "v2.0";
	//语言种类，1代表中文显示，2代表英文显示。默认为1,该参数必填。
	private String language =  "1";
	//签名类型,该值为4，代表PKI加密方式,该参数必填。
	private String signType =  "4";
	//支付人姓名,可以为空。
	private String payerName= ""; 
	//支付人联系类型，1 代表电子邮件方式；2 代表手机联系方式。可以为空。
	private String payerContactType =  "";
	//支付人联系方式，与payerContactType设置对应，payerContactType为1，则填写邮箱地址；payerContactType为2，则填写手机号码。可以为空。
	private String payerContact =  "";
	//商户订单号，以下采用时间来定义订单号，商户可以根据自己订单号的定义规则来定义该值，不能为空。
	private String orderId = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	//订单金额，金额以“分”为单位，商户测试以1分测试即可，切勿以大金额测试。该参数必填。
	private String orderAmount = "1";
	//订单提交时间，格式：yyyyMMddHHmmss，如：20071117020101，不能为空。
	private String orderTime = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	//商品名称，可以为空。
	private String productName= "充值"; 
	//商品数量，可以为空。
	private String productNum = "";
	//商品代码，可以为空。
	private String productId = "";
	//商品描述，可以为空。
	private String productDesc = "";
	//扩展字段1，商户可以传递自己需要的参数，支付完快钱会原值返回，可以为空。
	private String ext1 = "";
	//扩展自段2，商户可以传递自己需要的参数，支付完快钱会原值返回，可以为空。
	private String ext2 = "";
	//支付方式，一般为00，代表所有的支付方式。如果是银行直连商户，该值为10，必填。
	private String payType = "00";
	//银行代码，如果payType为00，该值可以为空；如果payType为10，该值必须填写，具体请参考银行列表。
	private String bankId = "0";
	//同一订单禁止重复提交标志，实物购物车填1，虚拟产品用0。1代表只能提交一次，0代表在支付不成功情况下可以再提交。可为空。
	private String redoFlag = "";
	//快钱合作伙伴的帐户号，即商户编号，可为空。
	private String pid = "";
	
	/**
	 * 签名字符串 
	 * */
	public void setSignMsg(Income_bill bill,HttpClient http){
		this.orderId = bill.getBillno();
		this.productName = bill.getTrantypetxt();
		// signMsg 签名字符串 不可空，生成加密签名串
		String signMsgVal = "";
		signMsgVal = appendParam(signMsgVal, "inputCharset", inputCharset);
		signMsgVal = appendParam(signMsgVal, "pageUrl", pageUrl);
		signMsgVal = appendParam(signMsgVal, "bgUrl", bgUrl);
		signMsgVal = appendParam(signMsgVal, "version", version);
		signMsgVal = appendParam(signMsgVal, "language", language);
		signMsgVal = appendParam(signMsgVal, "signType", signType);
		signMsgVal = appendParam(signMsgVal, "merchantAcctId",merchantAcctId);
		signMsgVal = appendParam(signMsgVal, "payerName", payerName);
		signMsgVal = appendParam(signMsgVal, "payerContactType",payerContactType);
		signMsgVal = appendParam(signMsgVal, "payerContact", payerContact);
		signMsgVal = appendParam(signMsgVal, "orderId", orderId);
		signMsgVal = appendParam(signMsgVal, "orderAmount", orderAmount);
		signMsgVal = appendParam(signMsgVal, "orderTime", orderTime);
		signMsgVal = appendParam(signMsgVal, "productName", productName);
		signMsgVal = appendParam(signMsgVal, "productNum", productNum);
		signMsgVal = appendParam(signMsgVal, "productId", productId);
		signMsgVal = appendParam(signMsgVal, "productDesc", productDesc);
		signMsgVal = appendParam(signMsgVal, "ext1", ext1);
		signMsgVal = appendParam(signMsgVal, "ext2", ext2);
		signMsgVal = appendParam(signMsgVal, "payType", payType);
		signMsgVal = appendParam(signMsgVal, "bankId", bankId);
		signMsgVal = appendParam(signMsgVal, "redoFlag", redoFlag);
		signMsgVal = appendParam(signMsgVal, "pid", pid);
		Pkipair pki = new Pkipair();
		String signMsg = pki.signMsg(signMsgVal);
		//System.out.println(signMsg);
		
		http.setParameter("inputCharset", "1");
		http.setParameter("pageUrl", PAGE_URL);
		http.setParameter("bgUrl", BG_URL);
		http.setParameter("version", version);
		http.setParameter("language", language);
		http.setParameter("signType", signType);
		http.setParameter("signMsg", signMsg);
		http.setParameter("merchantAcctId",merchantAcctId);
		http.setParameter("payerName", payerName);
		http.setParameter("payerContactType",payerContactType);
		http.setParameter("payerContact", payerContact);
		http.setParameter("orderId", orderId);
		http.setParameter("orderAmount", orderAmount);
		http.setParameter("orderTime", orderTime);
		http.setParameter("productName", productName);
		http.setParameter("productNum", productNum);
		http.setParameter("productId", productId);
		http.setParameter("productDesc", productDesc);
		http.setParameter("ext1", ext1);
		http.setParameter("ext2", ext2);
		http.setParameter("payType", payType);
		http.setParameter("bankId", bankId);
		http.setParameter("redoFlag", redoFlag);
		http.setParameter("pid", pid);
	}
	

	/**
	 * 拼接参数
	 * */
	private String appendParam(String returns, String paramId, String paramValue) {
		if (!returns.equals("")) {
			if (!paramValue.equals("")) {
				returns += "&" + paramId + "=" + paramValue;
			}
		}else {
			if (!paramValue.equals("")) {
				returns = paramId + "=" + paramValue;
			}
		}
		return returns;
	}
}
