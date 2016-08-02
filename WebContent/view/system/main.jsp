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
    <title>众恒信和综合管理平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/admin.css">
    <script src="${pageContext.request.contextPath}/js/boot.js" type="text/javascript"></script> 
    <%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script> --%>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/admin.js"></script>
    <script src="${pageContext.request.contextPath}/js/layer/layer.js"></script>
    
    <!-- <link type="image/x-icon" href="/favicon.ico" rel="shortcut icon" />
    <link href="/favicon.ico" rel="bookmark icon" /> -->
    
    <style type="text/css">
    	.bread_hide {
    		display:none;
    	}
    	.bread_show {
    		display:block;
    	}
    	
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    
	    .Note
	    {
	        background:url(Notes_Large.png) no-repeat;width:32px;height:32px;
	    }
	    .Reports
	    {
	        background:url(Reports_Large.png) no-repeat;width:32px;height:32px;
	    }

		.menu_iframe{position:absolute; visibility:inherit; top:0px; left:0px; width:120px; z-index:-1; filter: Alpha(Opacity=100); background:#000000;}
    
    </style>
    
    <script type="text/javascript">
    	$(function(){
    		mini.parse();
    		/* $(".bread").addClass("bread_hide");
    		$("#index").removeClass("bread_hide");
    		$("#index").addClass("bread_show"); */
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
	            window.location.href = "${pageContext.request.contextPath}/logout.html";
	        };
	    }
    	
    </script>
</head>

<body>

	<div id="layout1" class="mini-layout" style="width: 100%; height: 100%;">
		<div  region="north" height="70" showSplit="false" showHeader="false" style="overflow: hide;">
			<div class="view-body" style="height:100%;background: url('${pageContext.request.contextPath}/images/header.gif') repeat-x scroll 0 -1px rgba(0, 0, 0, 0);">
				<div class="navbar" style="padding-top: 15px;padding-bottom: 0px;padding-right: 15px;padding-left: 15px;" >
					<div class="navbar-head" style="padding-right: 20px">
						<button data-target="#navbar1" class="button icon-navicon"></button>
						<a href="#"><span class="icon-bank" style="font-size: 30px;"></span></a>
					</div>
					<div id="navbar1" class="navbar-body nav-navicon">
						<ul class="nav nav-inline nav-menu">
							<li><a href="javascript:;" funcode="index">首页</a></li>
							<li><a href="javascript:;" funcode="common/dispatch.html?page=/view/system/system/setting">系统配置</a></li>
							<li><a href="javascript:;" funcode="common/dispatch.html?page=/view/system/product/productmain">商品管理</a></li>
							<li><a href="javascript:;" funcode="common/dispatch.html?page=/view/system/userManager">会员管理</a></li>
							<li><a href="javascript:;">下拉菜单<span class="arrow"></span></a>
								<ul class="drop-menu">
									<li><a href="javascript:;" funcode="">子菜单</a></li>
									<li><a href="javascript:;" funcode="">子菜单2</a></li>
								</ul>
							</li>
						</ul>
						<div class="navbar-text navbar-right hidden-s">
							欢迎 <a href="#" title="点击修改帐户信息" style="color: #0ae;" onclick="updatepass('${sessionScope.CURRENT_USER_IN_SESSION.id }')">${sessionScope.CURRENT_USER_IN_SESSION.accountname == ""?sessionScope.CURRENT_USER_IN_SESSION.accountcode:sessionScope.CURRENT_USER_IN_SESSION.accountname  } </a>。 
					            <img style="vertical-align: middle;" src="${pageContext.request.contextPath}/images/close_06.png" />
					           	<a href="javascript:;" onclick="quit()">退出</a>
						</div>
					</div>
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