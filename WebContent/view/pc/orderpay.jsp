<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>付款</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/faq.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con shopcart-con clearfix">
	    <h3>付款</h3>
	    <div class="shopcart-con-top">
	        <h4 class="cart-icon3 fl">付款</h4>
	        <ul class="fr">
	            <li><em>step01</em><span>购物车</span></li>
	            <li><em>step02</em><span>订单确认</span></li>
	            <li class="cur"><em>step03</em><span>付款</span></li>
	            <li><em>step04</em><span>付款成功</span></li>
	        </ul>
	    </div>
	    <div class="pay-through">
	        <img src="images/tick.png" />
	        <p>订单提交成功，请尽快完成付款！</p>
	    </div>
	    <div class="dingdan">
	        <div class="tit clearfix">
	            <span class="fl">收货人<i>/</i></span>
	        </div>
	        <div class="address">
	            <ul class="address-ul">
	                <li class="clearfix">
	                    <div class="address-x fl">
	                        <span>孙俪</span>
	                        <em>(100000)  北京市北京市西城区 马家堡路蓝光云鼎511室</em>
	                        <b>1371158327</b>
	                    </div>
	                </li>
	            </ul>
	        </div>
	    </div>
	    <!--结算金额-->
	    <div class="dingdan">
	        <div class="tit clearfix">
	            <span class="fl">结算金额<i>/</i></span>
	        </div>
	        <div class="tatol">
	            <p>
	                <em>合计金额：￥300</em>
	                <em>运费：￥0</em>
	                <em>总价：<b>￥300</b></em>
	            </p>
	        </div>
	    </div>
	    <!--选择支付方式-->
	    <div class="dingdan">
	        <div class="tit clearfix">
	            <span class="fl">选择支付方式<i>/</i></span>
	        </div>
	        <em class="pay">网上银行支付</em>
	        <div class="Bank-pay">
	            <ul class="change-banck clearfix">
	              <li>
	                <input type="radio" checked="checked" name="name" id="c01">
	                <label for="c01"><img src="images/index06_07.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c02">
	                <label for="c02"><img src="images/index06_09.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c03">
	                <label for="c03"><img src="images/index06_11.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c05">
	                <label for="c05"><img src="images/index06_13.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c06">
	                <label for="c06"><img src="images/index06_15.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c07">
	                <label for="c07"><img src="images/index06_17.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c08">
	                <label for="c08"><img src="images/index06_25.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c09">
	                <label for="c09"><img src="images/index06_26.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c010">
	                <label for="c010"><img src="images/index06_27.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c011">
	                <label for="c011"><img src="images/index06_28.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c012">
	                <label for="c012"><img src="images/index06_29.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c013">
	                <label for="c013"><img src="images/index06_30.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c014">
	                <label for="c014"><img src="images/index06_37.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c015">
	                <label for="c015"><img src="images/index06_38.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c016">
	                <label for="c016"><img src="images/index06_39.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c017">
	                <label for="c017"><img src="images/index06_40.gif"></label>
	              </li>
	            </ul>            
	        </div>
	        <em class="pay">第三方支付平台</em>
	        <div class="Bank-pay">
	            <ul class="change-banck clearfix">
	              <li>
	                <input type="radio" checked="checked" name="name" id="c01">
	                <label for="c01"><img src="images/index06_41.gif"></label>
	              </li>
	              <li>
	                <input type="radio" name="name" id="c02">
	                <label for="c02"><img src="images/index06_42.gif"></label>
	              </li>
	            </ul>
	        </div>
	    </div>
	    <div class="pay-but">
	        <input type="button" value="立即付款" class="shopcart-but" />
	        <input type="button" value="返回" class="shopcart-black" />
	    </div>
	    
	</div>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>