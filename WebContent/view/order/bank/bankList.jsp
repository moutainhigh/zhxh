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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/order/tpl/bank/page.css">
    
    <style type="text/css">
	    .doc-naver { padding-top: 10px;padding-bottom: 10px;}
		.doc-header.fixed-top .doc-naver {padding-top: 10px;padding-bottom: 10px;background-color: #fff;}
		.admin {width: 100%; padding: 20px;background: #fff;right: 0; bottom: 0;top: 87px;overflow: auto;}
		.nav-inline li a {line-height: 22px;}
		.border-back {border-color:#b5cfd9;}
    </style>
    
    <script type="text/javascript">
    	var userid = '${sessionScope.pc_user_sessiion.id}';
	    $(function(){
	        getUserBank();
	    })
	    
	    //资金账户
	    function getUserBank() {
    		var par = {};
    		par.userid = userid;
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserBank/listUserBank.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	$("#banks").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/bank/bankList.tpl");
                	$("#banks").setParam("path","${pageContext.request.contextPath}/js/pintuer/pintuer.js");
                	$("#banks").setParam("identity",json.identity);
                	$("#banks").processTemplate(json.data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
	    //充值,trantype:充值类型
	    function recharge(pid,trantype){
	    	layer.prompt({
   				title: '请输入充值金额，并确认',
   				formType: 0 //prompt风格，支持0-2
   			}, function(amount){
   				if(!isInteger(amount)){
   					parent.layer.msg('请输入大于0的正整数', {icon:5});
					return;
   				}
   				var config = getDisConfig();
   				if(config.deposit_up > 0){
   					if(amount > config.deposit_up){
   						parent.layer.msg("您输入的金额超过上限，请重新输入",{icon:6});
   						return;
   					}
   				}
   				if(config.deposit_down > 0){
   					if(amount < config.deposit_down){
   						parent.layer.msg("您输入的金额低于下限，请重新输入",{icon:6});
   						return;
   					}
   				}
   				
   				$.ajax({
   	    			async:false,
   	                url: "${pageContext.request.contextPath}/orderUserBank/recharge.htmls",
   	                data: {parentid:pid,amount:amount,trantype:trantype},
   	                type: "post",
   	                dataType:"json",
   	                success: function (json) {
   	                	if(json.code != "0"){
   	                		alert(json.data.billno);
   	                	}else{
   	                		layer.msg("操作失败，请稍后再试！",{icon:6});
   	                	}
   	                	/* getUserBank();
	                		layer.msg("充值成功",{icon:6}); */
   	                },
   	                error: function (jqXHR, textStatus, errorThrown) {
   	                    alert(jqXHR.responseText);
   	                }
   	           	});
   			});
	    }
 		
	    //转货款
	    function transfBuyBank(pid,amount){
	    	layer.prompt({
   				title: '请输入充值金额，并确认',
   				value:amount,
   				formType: 0 //prompt风格，支持0-2
   			}, function(trans_amount){
   				if(trans_amount > amount){
   					parent.layer.msg("账户余额不足，请重新输入！",{icon:6});
   					return;
   				}else{
   					//获取系数
   					var coef = getTransfCoef(pid);
   					var subtotal = trans_amount;
   					if(coef != 0){
   						subtotal = trans_amount * coef;	
   					}
   					var cf = "<p>转货款金额￥"+trans_amount+"，转货款系数"+coef+"倍，总金额：￥"+subtotal+"</P>";
   					layer.confirm(cf+'【确定要转货款吗？】', {
   						title:'系统消息',
   					  btn: ['确定','取消'] //按钮
   					}, function(){
   						//提交服务器
   						$.ajax({
   		   	    			async:false,
   		   	                url: "${pageContext.request.contextPath}/orderUserBank/transfBuyBank.htmls",
   		   	                data: {parentid:pid,amount:trans_amount},
   		   	                type: "post",
   		   	                dataType:"text",
   		   	                success: function (text) {
   		   	                	if(text == "success"){
   		   	                		getUserBank();
   		   	                		layer.msg("转货款成功！",{icon:6});
   		   	                	}else{
   		   	                		layer.msg("操作失败，请稍后再试！",{icon:6});
   		   	                	}
   		   	                },
   		   	                error: function (jqXHR, textStatus, errorThrown) {
   		   	                    alert(jqXHR.responseText);
   		   	                }
   		   	           	});
   					}, function(){
   					  
   					});
   				}
   			});
	    }
	    //获取转货款系数
	    function getTransfCoef(pid){
	    	var coef = 0;
	    	$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserBank/getTransfCoef.htmls",
                data: {parentid:pid},
                type: "post",
                dataType:"text",
                success: function (text) {
                	if(text != "error"){
                		//系数应该是大于0的数
                		coef = text;
                	}else{
                		coef = 0;
                	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //alert(jqXHR.responseText);
                    coef = 0;
                }
           	});
	    	return coef;
	    }
	    
	    //提现
	    function withdrawal(pid,amount,trantype){
	    	layer.prompt({
   				title: '请输入提现金额，并确认',
   				value:amount,
   				formType: 0 //prompt风格，支持0-2
   			}, function(withdraw_amount){
   				if(withdraw_amount > amount){
   					parent.layer.msg("账户余额不足，请重新输入！",{icon:6});
   					return;
   				}else{
					//提交服务器
					$.ajax({
	   	    			async:false,
	   	                url: "${pageContext.request.contextPath}/orderUserBank/withdrawal.htmls",
	   	                data: {parentid:pid,amount:withdraw_amount,trantype:trantype},
	   	                type: "post",
	   	                dataType:"text",
	   	                success: function (text) {
	   	                	if(text == "success"){
	   	                		getUserBank();
	   	                		layer.msg("提现成功！",{icon:6});
	   	                	}else if(text == "0"){
	   	                		layer.msg("您的账户已被冻结，不能进行提现！",{icon:6});
	   	                	}else{
	   	                		layer.msg("操作失败，请稍后再试！",{icon:6});
	   	                	}
	   	                },
	   	                error: function (jqXHR, textStatus, errorThrown) {
	   	                    alert(jqXHR.responseText);
	   	                }
	   	           	});
   				}
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
			<li><a href="javascript:;" >资金帐户</a></li>
		</ul>
		<div class="admin">
			<div class="line-big">
				<div id="banks" class="x5">
					<!-- 账户列表 -->
				</div>
				<div class="x7">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>资金明细</strong>
							<input type="hidden" id="_userid" />
							<input type="hidden" id="_parentid" />
							<input type="hidden" id="_trantype" />
							<input type="hidden" id="_identity" />
							<input type="hidden" id="_detailstype" />
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