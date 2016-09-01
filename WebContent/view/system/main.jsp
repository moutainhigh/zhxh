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
    <script src="${pageContext.request.contextPath}/js/boot.js" type="text/javascript"></script> 
    <script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
    
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
    		
    		var url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/system/updateAccount";
    		var title = "修改帐户信息";
        	mini.open({
                url: url,
                title: title, width:600, height:400,
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
							<li><a href="javascript:;" funcode="common/dispatch.htmls?page=/view/system/system/setting">系统配置</a></li>
							<li><a href="javascript:;" funcode="common/dispatch.htmls?page=/view/system/product/productmain">商品管理</a></li>
							<li><a href="javascript:;" funcode="common/dispatch.htmls?page=/view/system/content/home">内容管理</a></li>
							<li><a href="javascript:;">采购分销<span class="arrow"></span></a>
								<ul class="drop-menu">
									<li><a href="javascript:;" funcode="common/dispatch.htmls?page=/view/system/member/userManager">会员管理</a></li>
									<li><a href="javascript:;" funcode="common/dispatch.htmls?page=/view/system/member/userManager">订单管理</a></li>
									<li><a href="javascript:;" funcode="common/dispatch.htmls?page=/view/system/order/ordermain">利益分配</a></li>
									<li><a href="${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/order/main" target="_brank">采购分销系统</a></li>
									<li><a href="javascript:;" funcode="">子菜单2</a></li>
								</ul>
							</li>
							<li><a href="javascript:;">下拉菜单<span class="arrow"></span></a>
								<ul class="drop-menu">
									<li><a href="${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/order/main" target="_brank">进货系统</a></li>
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