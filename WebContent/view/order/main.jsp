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
    <title>众恒信和采购分销管理平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/admin.css">
    <script src="${pageContext.request.contextPath}/js/boot.js" type="text/javascript"></script> 
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/admin.js"></script>
    <script src="${pageContext.request.contextPath}/js/layer/layer.js"></script>
    
    <!-- <link type="image/x-icon" href="/favicon.ico" rel="shortcut icon" />
    <link href="/favicon.ico" rel="bookmark icon" /> -->
    
    <style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    

    </style>
    
    <script type="text/javascript">
    	$(function(){
    		mini.parse();
    		$("#north").css("overflow","visible");
    		$(".mini-layout-region-body ").css("overflow","visible");
    		$("#navbar1  a").click(function(){
    			var funcode = $(this).attr("funcode");
    			var url = funcode;
    			if (url == 'index') {
    				$("#main_frm").attr("src","${pageContext.request.contextPath}/view/system/h.jsp");
    			}
    			else {
    				$("#main_frm").attr("src",url);
    			}
    			
    			$("#navbar1 li").removeClass("active");
    			$(this).parent().addClass("active");
    		});
    	})
    	
    	function updatepass(id) {
    		
    		var url = "${pageContext.request.contextPath}/common/dispatch.do?page=/view/account/updateAccount";
    		var title = "修改帐户信息";
        	mini.open({
                url: url,
                title: title, width:500, height:400,
                allowResize:true,
                onload: function () {
                	
                },
                ondestroy: function (action) {
                }
            });
    		
			/* mini.open({
	            url: bootPATH + "../common/dispatch.do?page=/view/auth/account/updateAccount",
	            title: "修改帐户信息", width: 400, height:300,
	            allowResize:true,
	            onload: function () {
	            },
	            ondestroy: function (action) {
	            }
	        }); */
		}
    	
    	function quit() {
			if(confirm("真的要退出系统吗?")) {
	            window.location.href = "${pageContext.request.contextPath}/logout.htmls";
	        };
	    }
    	
    </script>
</head>

<body>
	<div id="layout1" class="mini-layout" style="width: 100%; height: 100%;">
		<div  region="north" height="38" showSplit="false" showHeader="false" style="overflow: hide;">
			<div class="navbar bg-blue bg-inverse radius">
				<div class="navbar-head" style="vertical-align: middle;width:200px;margin-left: 15px;padding: 3px;">
					<!-- <button class="button bg icon-navicon" data-target="#navbar-big2"></button> -->
					<a href="#">
						<img src="${pageContext.request.contextPath}/images/distributor_logo.png" width="32" style="vertical-align:middle"/>
					</a>
					<span >众恒信和采购分销管理平台</span>
				</div>
				<div class="navbar-body nav-navicon" id="navbar-big">
					<ul class="nav nav-inline nav-menu">
						<li><a href="#">首页</a> </li>
						<li class="active"><a href="#">元件<span class="arrow"></span></a>
							<ul class="drop-menu">
								<li><a href="#">概述</a> </li>
								<li><a href="#">网格系统<span class="arrow"></span></a>
									<ul>
										<li><a href="#">响应式布局</a> </li>
										<li><a href="#">非响应式布局</a> </li>
									</ul>
								</li>
								<li><a href="#">图标</a> </li>
							</ul>
						</li>
						<li class="nav-more"><a href="#">更多<span class="arrow"></span></a>
							<ul class="drop-menu">
								<li><a href="#">组件</a> </li>
								<li><a href="#">模块<span class="arrow"></span></a>
									<ul>
										<li><a href="#">头部</a> </li>
										<li><a href="#">导航</a> </li>
										<li><a href="#">底部</a> </li>
									</ul>
								</li>
							</ul>
						</li>
					</ul>
					<div class="navbar-form navbar-left">
						<form>
							<input type="text" class="input input-auto border-white" name="keywords" size="15" placeholder="关键词" />
							<input type="submit" name="search" value="搜索" class="button bg-white" />
						</form>
					</div>
					<ul class="nav nav-inline nav-menu navbar-right">
						<li>
							<a class="bg-main" href="javascript:;">
								<spn><img src="http://www.pintuer.com/demo/pintuer2/images/face.jpg" width="28" class="radius-circle"></spn>
								管理员
								<span class="downward"></span>
							</a>
							<ul class="drop-menu">
								<li><a class="icon-user" target="_blank" href="javascript:;">修改资料</a></li>
								<li><a class="icon-key" target="_blank" href="javascript:;">修改密码</a></li>
							</ul>
						</li>
						<li><a class="bg-green" href="javascript:;"><span class="icon-envelope"></span>&nbsp;<span class="badge bg-blue">5+</span><span class="downward"></span></a>
							<ul class="drop-menu">
								<li><a class="text-yellow-light" target="_blank" href="javascript:;"><span class="icon-envelope"></span>您有16封邮件</a></li>
								<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>查阅更多...</a></li>
							</ul>
						</li>
						<li><a class="bg-blue" href="javascript:;"><span class="icon-bell-o"></span>&nbsp;<span class="badge bg-green">99+</span><span class="downward"></span></a>
							<ul class="drop-menu">
								<li><a class="text-yellow-light active" target="_blank" href="javascript:;"><span class="icon-comment"></span>您有26条未读消息</a></li>
								<li><a class="text-yellow-light active" target="_blank" href="javascript:;"><span class="icon-comments"></span>您有13条回复消息</a></li>
								<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>查看更多...</a></li>
							</ul>
						</li>
						<li><a class="bg-yellow" target="_blank" href="login.html"><span class="icon-sign-out"></span>注销</a></li>
					</ul>
					<!-- <div class="navbar-text navbar-right hidden-s">
						文本 <a href="#">链接</a>
						<button type="button" class="button bg-white">
							按钮</button>
					</div> -->
				</div>
			</div>
		</div>
		<div title="south" region="south" showSplit="false" showHeader="false" height="30">
			<div style="line-height: 28px; text-align: center; cursor: default">版权所有 亚普软件(北京)有限公司&copy; <a href="#"></a> All Rights Reserved.</div>
		</div>
<!-- 		<div title="south" region="south" showSplit="false" showHeader="false" height="30">
			<div style="line-height: 28px; text-align: center; cursor: default">Copyright
				© 亚普软件（北京）有限公司版权所有</div>
		</div> -->
		<div title="center" region="center" bodyStyle="overflow:hidden;">
			<iframe id="main_frm" src="${pageContext.request.contextPath}/view/system/h.jsp" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="auto" allowtransparency="yes"></iframe>
		</div>
	</div>

</body>
</html>