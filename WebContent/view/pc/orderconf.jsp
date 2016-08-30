<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单确认</title>

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
	    <h3>订单确认</h3>
	    <div class="shopcart-con-top">
	        <h4 class="cart-icon2 fl">订单确认</h4>
	        <ul class="fr">
	            <li><em>step01</em><span>购物车</span></li>
	            <li class="cur"><em>step02</em><span>订单确认</span></li>
	            <li><em>step03</em><span>付款</span></li>
	            <li><em>step04</em><span>付款成功</span></li>
	        </ul>
	    </div>
	    <div class="dingdan">
	        <div class="tit clearfix">
	            <span class="fl">收货人<i>/</i></span>
	            <div class="add-address fr">新增地址</div>
	        </div>
	        <div class="address">
	            <ul class="address-ul">
	                <li class="clearfix">
	                    <div class="address-x fl">
	                        <input name="" type="radio" value="" />
	                        <span>孙俪</span>
	                        <em>(100000)  北京市北京市西城区 马家堡路蓝光云鼎511室</em>
	                        <b>1371158327</b>
	                    </div>
	                    <div class="address-but fl">
	                        <a href="javascript:;">修改</a>
	                        <a href="javascript:;" class="del">删除</a>
	                    </div>
	                </li>
	                <li class="clearfix">
	                    <div class="address-x fl">
	                        <input name="" type="radio" value="" />
	                        <span>孙俪</span>
	                        <em>(100000)  北京市北京市西城区 马家堡路蓝光云鼎511室</em>
	                        <b>1371158327</b>
	                    </div>
	                    <div class="address-but fl">
	                        <a href="javascript:;">修改</a>
	                        <a href="javascript:;" class="del">删除</a>
	                    </div>
	                </li>
	            </ul>
	            <em class="more">+ 更多</em>
	        </div>
	    </div>
	    <div class="dingdan">
	        <div class="tit clearfix">
	            <span class="fl">商品<i>/</i></span>
	        </div>
	    </div>
	    <table width="0" border="0" cellpadding="0" cellspacing="0" class="cart-table">
	      <tr class="tr">
	        <td width="600">商品名称</td>
	        <td width="176">单价/元</td>
	        <td width="250">数量/件</td>
	        <td width="174">小计/元</td>
	      </tr>
	      <c:forEach var="item" items="${psizeList }">
	      	<tr>
		        <td align="left">
		            <div class="img-txt" style="margin-left: 31px">
		                <img src="${pageContext.request.contextPath}/${item.productpic }" class="fl" />
		                <div class="txt fl">
		                    <h5>${item.productname }</h5>
		                    <em>${item.productmemo }</em>
		                </div>
		            </div>
		        </td>
		        <td>${item.saleprice }</td>
		        <td>${item.quantity }</td>
		        <td>${item.saleprice * item.quantity}</td>
		    </tr>
	      </c:forEach>
	    </table>
	    <div class="tatol">
	        <p>
	            <em>合计金额：￥${subtotal }</em>
	            <em>运费：￥0</em>
	            <em>总价：<b>￥${subtotal }</b></em>
	        </p>
	    </div>
	    <form name="form1" action="${pageContext.request.contextPath}/porder/suborder.htmls" method="post">
	    	<input type="hidden" name="ids" value="${pids }">
	    	<input type="hidden" name="addressid" id="address" value="1">
	    	<input type="button" value="立即付款" onclick="tosubmit()" class="shopcart-but" />
	    </form>
	</div>
	<script type="text/javascript">
		function tosubmit(){
			var address = $("#address").val();
			if(typeof(address) == "undefined" || address == ""){
				alert("请选择一个地址！");
				return;
			}
			form1.submit();
		}
	</script>
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>