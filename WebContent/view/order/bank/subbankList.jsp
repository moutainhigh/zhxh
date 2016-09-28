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
    </style>
    
    <script type="text/javascript">
    	var userid = '${sessionScope.pc_user_sessiion.id}';
	    $(function(){
	        getUserBank();
	    })
	    
	    function getUserBank() {
    		var par = {};
    		par.parentid = userid;
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserBank/listUserBank.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	$("#banks").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/bank/subbankList.tpl");
                	$("#banks").setParam("identity",json.identity);
                	$("#banks").processTemplate(json.data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
	    function setQuota(userid){
	    	layer.prompt({
   				title: '请输入配额金额，并确认',
   				formType: 0 //prompt风格，支持0-2
   			}, function(amount){
   				$.ajax({
   	    			async:false,
   	                url: "${pageContext.request.contextPath}/orderUserBank/setQuota.htmls",
   	                data: {userid:userid,amount:amount},
   	                type: "post",
   	                dataType:"text",
   	                success: function (text) {
   	                	if(text == "success"){
   	                		getUserBank();
   	                		layer.msg("配额添加成功",{icon:6});
   	                	}else{
   	                		layer.msg("操作失败，请稍后再试！",{icon:6});
   	                	}
   	                },
   	                error: function (jqXHR, textStatus, errorThrown) {
   	                    alert(jqXHR.responseText);
   	                }
   	           	});
   			});
	    }
 		
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >资金管理</a></li>
			<li><a href="javascript:;" >我的客户资金帐户</a></li>
		</ul>
		<div class="admin">
			<div class="line-big">
				<div id="banks" class="x5">
					
				</div>
				<div class="x7">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>待处理订单</strong>
						</div>
						<div class="panel-body">
							<table class="table">
								<tbody>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">我的采购单:4笔</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">￥66645</td>
									</tr>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">客户订货单:4笔</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">￥66645</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<br>
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>最新消息</strong>
							<a href="javascript:;"><span class="float-right">更多</span></a>
						</div>
						<div class="panel-body">
							<table class="table">
								<tbody>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">[浙江丽美美容院]充值成功..</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">2016-04-05</td>
									</tr>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">[浙江丽美美容院]充值成功..</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">2016-04-05</td>
									</tr>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">[浙江丽美美容院]充值成功..</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">2016-04-05</td>
									</tr>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">[浙江丽美美容院]充值成功..</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">2016-04-05</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<br>
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