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
    	var current_uid; //当前操作的账户
	    $(function(){
	    	current_uid = "";
	        getUserBank();
	        
	        /* $("input[name=radio_user]").click(function(){
	        	getUserBank();
  			}); */
	    })
    	
    	//检索
	    function searchbank(){
	    	 getUserBank();
    	}
    	
    	//资金账户
	    function getUserBank() {
	    	radio_value = $("input[name='radio_user']:checked").val();
    		var par = {};
    		par.parentid = userid;
    		par.identity = radio_value;
    		par.search = $("#keyword").val();
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserBank/listUserBank.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	if(json.data == ""){
                		layer.msg("未找到匹配的账户",{icon:6});
                		return;
                	}
                	$("#banks").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/bank/subbankList.tpl");
                	$("#banks").setParam("path","${pageContext.request.contextPath}/js/pintuer/pintuer.js");
                	$("#banks").setParam("activeUser",userid);
                	$("#banks").setParam("identity",json.identity);
                	$("#banks").setParam("current_uid",current_uid);
                	$("#banks").processTemplate(json.data);
               		//提示信息
               		layer.tips('点击可更改资金账户的状态', '#status1', {tips: [1, '#FF9901'],time: 5000,});
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
	    function setQuota(userid,bankstate){
	    	if(bankstate != 1){
	    		parent.layer.msg("账户已被冻结，请开启账户进行设置",{icon:5});
	    		return;
	    	}
	    	var config = getDisConfig();	//配额范围
	    	layer.prompt({
   				title: '请输入配额【'+config.quota_down+'-'+config.quota_up+'】',
   				formType: 0 //prompt风格，支持0-2
   			}, function(amount){
   				if(!isInteger(amount)){
   					parent.layer.msg('请输入大于0的正整数', {icon:5});
   					return;
   				}
   				if(config.quota_up > 0){
   					if(amount > config.quota_up){
   						parent.layer.msg("您设置的配额超过上限，请重新输入",{icon:6});
   						return;
   					}
   				}
   				if(config.quota_down > 0){
   					if(amount < config.quota_down){
   						parent.layer.msg("您设置的配额低于下限，请重新输入",{icon:6});
   						return;
   					}
   				}
   				$.ajax({
   	    			async:false,
   	                url: "${pageContext.request.contextPath}/orderUserBank/setQuota.htmls",
   	                data: {userid:userid,amount:amount},
   	                type: "post",
   	                dataType:"text",
   	                success: function (text) {
   	                	if(text == "success"){
   	                		current_uid = userid;
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
 		
	    //
	    function setAccountStatus(uid,pid,state){
	    	var state_txt = ['开启','冻结'];
	    	var cf = "您确定要"+state_txt[state]+"该账户吗？";
			layer.confirm(cf, {title:'系统提示',icon:3,
				btn: ['确定','取消'] //按钮
			}, function(index){
				$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderUserBank/setAccountState.htmls",
	                data: {userid:uid,parentid:pid,state:state},
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                	if(text != "error"){
	                		current_uid = uid;
	                		getUserBank();
	                		layer.msg("账户已"+text,{icon:6});
	                	}else{
	                		layer.msg("操作失败！",{icon:6});
	                	}
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    alert(jqXHR.responseText);
	                }
	           	});
	   			layer.close(index);
			}, function(){
			});
	    }
	    
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 260px">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >资金管理</a></li>
			<li><a href="javascript:;" >我的客户资金帐户</a></li>
		</ul>
		<div class="admin">
			<div class="line-big">
				<div class="x5">
					<div class="form-group">筛选：
						<c:if test="${sessionScope.pc_user_sessiion.id eq '1'}">
						<input name="radio_user" type="radio" value="" checked="checked"/> 全部
						<input name="radio_user" type="radio" value="A"/> 代理
    					<input name="radio_user" type="radio" value="C"/> 门店
    					</c:if>
						<input type="text" id="keyword" class="input input-auto" style="width:120px;">
						<a id="searchBtn" href="javascript:;" class="button bg-main button-small" onclick="searchbank()">检索</a>
					</div>
					<div  id="banks" class="collapse">
						<div class="panel border-sub active">
							<div class="panel-head">
								<strong>客户资金帐户</strong>
							</div>
							<div class="panel-body"><p>暂无数据</p>
							</div>
						</div>
					</div>
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
							<input type="hidden" id="_status" />
						</div>
						<div id="billDetail" class="panel-body">
							<p>暂无数据</p>
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