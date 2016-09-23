<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-jtemplates.js"></script>
     <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
    
    <style type="text/css">
		.admin {
		    padding: 20px 30px 10px 30px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 0px;
		    left: 0px;
		    overflow: auto;
		    width: 100%;
    	}
    	.table th{text-align: center}
    	.table-bordered th {border-bottom: 1px solid #ddd;}
    </style>
    <script type="text/javascript">
    	//
    	var orderid = "",ispay = "true";
    	//
    	function setData(id){
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/order/paymentorder.htmls",
                data: {orderid:id},
                type: "post",
                dataType:"json",
                success: function (json) {
               	 	var ordertotal = json.ordertotal;
               	 	var havebank = json.havebank;
                	$("#total").html(formatFloat(ordertotal,2));
               	 	$("#havebank").html(formatFloat(havebank,2));
            	 	if(ordertotal > havebank){
            	 		ispay = "false";
            	 		$("#alert").removeClass("alert-green");
            	 		$("#alert").addClass("alert-yellow");
            	 		$("#warning").html("可支配账户余额不足，请尽快充值！");
            	 	}else{
            	 		$("#alert").removeClass("alert-yellow");
            	 		$("#alert").addClass("alert-green");
            	 		$("#warning").html("可支配账户余额充足！");
            	 	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           });
    	}
    	
    	function getData(){
    		var data = {};
    		data.ispay = ispay;
    		data.orderid = orderid;
    		return data;
    	}
    </script>
</head>
<body>
	<!--内容-->
	<div class="admin">
			<div id="alert" class="alert alert-yellow">
				<span class="close rotate-hover"></span><strong>注意：</strong><label id="warning"></label>
			</div>
			<div class="text-right" style="padding: 30px 0px;">
				<div>应付总额：￥<span><strong id="total"></strong></span></div>
				<br/>
				<div>当前账户余额：￥<span style="color: red !important" ><strong id="havebank">0.00</strong></span></div>
			</div>
	</div>
</body>
</html>