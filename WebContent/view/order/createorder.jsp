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
    
    <script src="${pageContext.request.contextPath}/js/echarts/echarts.min.js"></script>
	<!-- 引入 vintage 主题 -->
	<script src="${pageContext.request.contextPath}/js/echarts/theme/shine.js"></script>
    
    <style type="text/css">
    	.doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		}
		.doc-header.fixed-top .doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		    background-color: #fff;
		}
		.admin {
		    width: 100%;
		    padding: 20px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 87px;
		    overflow: auto;
		}
		
		.nav-inline li a {
			line-height: 22px;
		}
		
		.border-back {
    		border-color:#b5cfd9;
		}
		/* .panel-back {
			background-color: #f7f7f7;
		} */
		.table th{text-align: center}
    </style>
    <script type="text/javascript">
    	$(function(){
    		//
    		//$(".side-menu ul li").addClass('on').siblings('a').removeClass('on');
    		
    		/* $(".side-menu ul li").click(function(){
    			alert(123);
    		}); */
    		
    	});
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="#" class="icon-home">首页</a> </li>
			<li><a href="#" >采购单</a></li>
		</ul>
		<div class="admin" style="padding: 30px 60px;">
			<form onsubmit="return false;" class="form-x" method="post">
				<div class="form-group">
					<div class="label">
						<label for="username">选择商家</label>
					</div>
					<div class="field">
						<select name="age" class="input" >
							<option>请选商家</option>
							<option>平台</option>
						</select>
						<!-- <div class="input-note">请根据</div> -->
					</div>
				</div>
			</form>
			<form method="post">
				<div class="admin-panel">
					<!-- <div class="panel-head"><strong>商品列表</strong></div> -->
					<!-- <div class="padding border-bottom">
						<input type="button" value="全选" checkfor="id" name="checkall" class="button button-small checkall">
						<input type="button" value="添加文章" class="button button-small border-green">
						<input type="button" value="批量删除" class="button button-small border-yellow">
						<input type="button" value="回收站" class="button button-small border-blue">
					</div> -->
					<table class="table table-bordered table-hover">
						<tbody><tr class="panel-head">
							<th width="45">选择</th>
							<!-- <th width="120"></th> -->
							<th width="*">商品名称</th>
							<th width="100">规格</th>
							<th width="100">数量</th>
							<th width="100">单价</th>
							<th width="100">折扣</th>
							<th width="180">小计</th>
						</tr>
						<tr>
							<td><input type="checkbox" value="1" name="id"></td>
							<%-- <td><img alt="" src="${pageContext.request.contextPath}/file/pic/aa26da09-60e8-4168-8bf5-49bd65645e1b.jpg" width="46px" height="46px"></td> --%>
							<td>商品A</td>
							<td align="center">30ml</td>
							<td align="center">12</td>
							<td align="center">180</td>
							<td align="center">0.3</td>
							<td></td>
						</tr>
						<tr>
							<td><input type="checkbox" value="1" name="id"></td>
							<%-- <td><img alt="" src="${pageContext.request.contextPath}/file/pic/aa26da09-60e8-4168-8bf5-49bd65645e1b.jpg" width="46px" height="46px"></td> --%>
							<td>商品A</td>
							<td align="center">30ml</td>
							<td align="center">12</td>
							<td align="center">180</td>
							<td align="center">0.3</td>
							<td></td>
						</tr>
						<tr>
							<td><input type="checkbox" value="1" name="id"></td>
							<%-- <td><img alt="" src="${pageContext.request.contextPath}/file/pic/aa26da09-60e8-4168-8bf5-49bd65645e1b.jpg" width="46px" height="46px"></td> --%>
							<td>商品A</td>
							<td align="center">30ml</td>
							<td align="center">12</td>
							<td align="center">180</td>
							<td align="center">0.3</td>
							<td></td>
						</tr>
						
					</tbody></table>
					<div class="panel text-right" style="padding: 30px 50px;">
						<div>合计：<span>￥20,000.00</span></div>
						<br/>
						<div>应付总额：<span style="color: red !important">￥20,000.00</span></div>
					</div>
					<div class="form-inline" style="padding-top: 20px;">
						<div class="form-group">
							<div class="label">
								<label for="username">
									收货信息：</label>
							</div>
							<div class="field">
								收货人：张三，联系电话：15010780215，收货地址：北京市朝阳区望京悠乐汇A 2108
							</div>
						</div>
					</div>
					<div>
						<button class="button button-big bg-blue">提交订单</button>
					</div>
				</div>
			</form>		
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