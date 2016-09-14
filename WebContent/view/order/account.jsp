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
	<div class="layout doc-header fixed box-shadow-small" style="z-index: 9;">
		<div class="container-layout doc-naver">
			<div class="line">
				<div class="x3 doc-logo" >
					<!-- <button class="button icon-navicon margin-top float-right" data-target="#doc-header-pintuer">
					</button>
					<a href="/">
						<img src="images/logo.png" width="180" height="40" alt="拼图" class="ring-hover">
					</a> -->
					<p class="text-sub text-big" style="margin-left:30px; line-height: 40px;margin-bottom: 0px;">众恒信和采购分销平台</p>
				</div>
				<div class="x9 doc-nav " style="text-align: right;">
					<ul class="nav nav-inline nav-navicon padding-small-top nav-menu" id="doc-header-pintuer" style="margin-right: 50px">
						<li>
							<a class="" href="javascript:;">
								<span><img src="${pageContext.request.contextPath}/images/user_man.png" width="22" class="radius-circle"></span>
								我
								<span class="downward"></span>
							</a>
							<ul class="drop-menu">
								<li><a class="icon-user" target="_blank" href="javascript:;"> 修改资料</a></li>
								<li><a class="icon-key" target="_blank" href="javascript:;"> 修改密码</a></li>
							</ul>
						</li>
						<li class="active">
							<a class="" href="javascript:;">
								<span class="icon-envelope-o"></span>&nbsp;
								<span class="badge bg-blue">5+</span>
								<span class="downward"></span>
							</a>
							<ul class="drop-menu">
								<li><a class="" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;您有16封邮件</a></li>
								<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;查阅更多...</a></li>
							</ul>
						</li>
						<li>
							<a class="" href="javascript:;">
								<span class="icon-bell-o"></span>&nbsp;
								<span class="badge bg-green">99+</span>
								<span class="downward"></span>
							</a>
							<ul class="drop-menu">
								<li><a class="" target="_blank" href="javascript:;"><span class="icon-comment"></span>&nbsp;您有26条未读消息</a></li>
								<li><a class="" target="_blank" href="javascript:;"><span class="icon-comments"></span>&nbsp;您有13条回复消息</a></li>
								<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;查看更多...</a></li>
							</ul>
						</li>
						<li>
							<a href="javascript:;"><span class="icon-comment-o"></span>&nbsp;客服<span class="downward"></span></a>
							<ul class="drop-menu">
								<li><a href="/react.html">在线客服</a></li>
								<li><a href="/weixin/index.html">意见反馈</a></li>
								<li><a href="javascript:;" style="background-color: #00a7e4;color: #fff;">400-400-4000</a></li>
								<li><a href="javascript:;" style="background-color: #00a7e4;color: #fff;">7*24小时服务</a></li>
							</ul>
						</li>
						<li><a class="" target="_blank" href="login.html"><span class="icon-sign-out"></span>注销</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="#" class="icon-home">首页</a> </li>
			<li><a href="#" >资金账户</a></li>
		</ul>
		<div class="admin" style="padding: 30px 60px;">
			<div class="tab">
				<div class="tab-head">
					<strong>资金账户</strong></span>
					<ul class="tab-nav">
						<li class="active"><a href="#tab-start">平台</a> </li>
						<li class=""><a href="#tab-css">张三</a> </li>
					</ul>
				</div>
				<div class="tab-body">
					<div id="tab-start" class="tab-panel active">
						<div class="table-responsive">
							<table class="table table-bordered">
								<tbody><tr>
									<th width="60">序号</th>
									<th>账户</th>
									<th>金额</th>
									<th>操作</th>
								</tr>
								<tr>
									<td>1</td>
									<td>可支配账户</td>
									<td>100</td>
									<td><a class="button border-blue button-little" href="#"><span class="icon-gears"></span> 充值</a></td>
								</tr>
								<tr>
									<td>2</td>
									<td>收入</td>
									<td>100</td>
									<td><a class="button border-blue button-little" href="#"><span class="icon-gears"></span> 明细</a></td>
								</tr>
							</tbody></table>
						</div>
					</div>
					<div id="tab-css" class="tab-panel">
						重新定义常用的CSS，对文本、图像、按钮、背景、表格等样式重新设置。</div>
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