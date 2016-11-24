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
    <script src="${pageContext.request.contextPath}/js/echarts/echarts.min.js"></script>
	<!-- 引入 vintage 主题 -->
	<script src="${pageContext.request.contextPath}/js/echarts/theme/shine.js"></script>
    <script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/js.validate.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/view/order/tpl/bank/bank.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/view/order/tpl/bank/bankList.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/order/tpl/bank/page.css">
    
    <style type="text/css">
	    .doc-naver { padding-top: 10px;padding-bottom: 10px;}
		.doc-header.fixed-top .doc-naver {padding-top: 10px;padding-bottom: 10px;background-color: #fff;}
		.admin {width: 100%; padding: 20px;background: #fff;right: 0; bottom: 0;top: 87px;overflow: auto;}
		.nav-inline li a {line-height: 22px;}
		.border-back {border-color:#b5cfd9;}
    </style>
    
    <script type="text/javascript">
    	userid = '${sessionScope.pc_user_sessiion.id}';
	    $(function(){
	        getUserBank();
	    })
	    
	    //
	    function fanliHelp(){
	    	layer.tips('返利金额将直接进入可支配账户中', '#fanliHelp', {tips: [1, '#FF9901'],time: 5000,});
	    }
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 260px">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;">资金帐户</a></li>
		</ul>
		<div class="admin">
			<div class="line-big">
				<div id="banks" class="x5">
					<!-- 账户列表 -->
				</div>
				<div id="payBill" class="x7">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>资金明细</strong>
							<input type="hidden" id="_userid" />
							<input type="hidden" id="_parentid" />
							<input type="hidden" id="_trantype" />
							<input type="hidden" id="_identity" />
							<input type="hidden" id="_detailstype" />
							<input type="hidden" id="_status" />
						</div>
						<div id="billDetail" class="panel-body">
							<!-- <div class="float-right"><div class="form-group">
								<div class="field">
									<label><input name="identity" type="radio">全部 </label>&nbsp;
									<label><input name="identity" type="radio">代理 </label>&nbsp;
									<label><input name="identity" type="radio">直营店 </label>&nbsp;
									<label><input name="identity" type="radio">门店 </label>&nbsp;
								</div>
							</div></div> -->
							<p align="center">暂无数据...</p>							
						</div>
						<div id="share_details" class="panel-body" style="padding: 0px 60px;display: black;">
							<!-- 分润详情 -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--底部-->
	<div class="layout fixed-bottom bg-white">
		<div class="border-bottom padding-bottom">
			<div class="text-center height-big text-small">
				<strong>版权所有 亚普软件(北京)有限公司&copy; <a href="#"></a> All Rights Reserved.</strong>
			</div>
		</div>
	</div>
</body>
</html>