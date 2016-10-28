<%@page import="net.ussoft.zhxh.model.Income_bill"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="net.ussoft.zhxh.pay.kq.KqSubmit"%>
<%@page import="net.ussoft.zhxh.pay.kq.KqConfig"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<%
	Income_bill bill = (Income_bill)request.getAttribute("bill");
	Map<String,String> hm = new LinkedHashMap<String, String>();
	hm.put("inputCharset", KqConfig.inputCharset);
	hm.put("pageUrl", KqConfig.pageUrl);
	hm.put("bgUrl", KqConfig.bgUrl_z);
	hm.put("version", KqConfig.version);
	hm.put("language", KqConfig.language);
	hm.put("signType", KqConfig.signType);
	hm.put("merchantAcctId",KqConfig.merchantAcctId);
	hm.put("orderId", bill.getBillno());
	Float amount = bill.getAccount_receivable() * 100;	//转换为分
	hm.put("orderAmount", String.valueOf(amount.intValue()));
	hm.put("orderTime", KqConfig.orderTime);
	hm.put("productName","支付货款");
	hm.put("payType", KqConfig.payType);
	//hm.put("bankId", KqConfig.bankId);
	//hm.put("signMsg", KqConfig.getSignMsg());
	
	//建立请求
	String sHtmlText = KqSubmit.buildRequest(hm,"post");
	out.println(sHtmlText);
%>
<body>
	
</body>
</html>