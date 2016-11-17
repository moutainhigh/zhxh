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
    <title>集丽科技采购分销管理平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/order/css/c.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/view/order/js/jquery.layout/jquery-ui-latest.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/view/order/js/jquery.layout/jquery.layout-latest.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/view/order/js/commonApp.js"></script>
    <script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
    
    <!-- <link type="image/x-icon" href="/favicon.ico" rel="shortcut icon" />
    <link href="/favicon.ico" rel="bookmark icon" /> -->
    
    <style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    

    </style>
    
    <script type="text/javascript">
		var myLayout;
		var curInd = -1;
		$(function() {
			myLayout = $('body').layout({
				west__size:					96
			,	west__spacing_closed:		0
			,	west__spacing_open:		0
			,	west__togglerLength_closed:	100
			,	west__togglerContent_closed:""
			,	west__togglerTip_closed:	""
			,	west__sliderTip:			""
			,	west__slideTrigger_open:	"mouseover"
			,	center__maskContents:		true
			});
			
			$(".ui-layout-west").css("z-index",999);
			
			$(".side-menu  a").click(function(){
    			var funcode = $(this).attr("funcode");
    			curInd = $(this).attr("curInd");
    			
    			var url = funcode;
    			if (url == 'index') {
    				$("#mainFrame").attr("src","${pageContext.request.contextPath}/view/system/h.jsp");
    			}
    			else {
    				$("#mainFrame").attr("src",url);
    			}
    			Public.Ui.Menu.curInd = curInd;
    			/* $("#navbar1 li").removeClass("active");
    			$(this).parent().addClass("active"); */
    		});
			//updateCur(); 如果菜单有隐藏，需要调整curInd的号码。这里暂时不需要
		})
		
		function updateCur() {
			var identity = '${sessionScope.pc_user_sessiion.identity}';
			if (identity == "C") {
				$(".pay a").attr("curInd","2");
				$(".message a").attr("curInd","3");
				$(".report a").attr("curInd","4");
			}
		}
		
		function removeMenuCurrent() {
			$(".side-menu-li").removeClass("current");
			Public.Ui.Menu.curInd = -1;
		}
		
		function quit() {
			if(confirm("真的要退出系统吗?")) {
	            window.location.href = "${pageContext.request.contextPath}/logout.htmls";
	        };
	    }
		
		function resetFunc(resetType) {
			var topFunc = false;
			//标注的修改=========
			if (resetType == "message") {
				$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderMessage/getNum.htmls",
	                data: {'numType':resetType},
	                type: "post",
	                dataType:"json",
	                success: function (json) {
	                	if (resetType == "message") {
	                		$("#messageTopFunc").html("");
		                	$("#message0Func").html("");
		                	$("#message1Func").html("");
		                	//$("#message2Func").html("");
		                 	if (json.m0 > 0) {
		                 		$("#message0Func").html('<span class="ui-new-func"></span>');
		                 		topFunc = true;
		                 	}
		                 	if (json.m1 > 0) {
		                 		$("#message1Func").html('<span class="ui-new-func"></span>');
		                 		topFunc = true;
		                 	}
		                 	/* if (json.m2 > 0) {
		                 		$("#message2Func").html('<span class="ui-new-func"></span>');
		                 		topFunc = true;
		                 	} */
		                 	
		                 	if (topFunc) {
		                 		$("#messageTopFunc").html('<span class="ui-new-func"></span>');
		                 	}
		                 	
		                 	document.getElementById("mainFrame").contentWindow.resetMessage(json);
	                	}
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
	                }
	           });
			}
			//====================
		}
		
		function refreshMessage() { 
			resetFunc("message");
		} 
		//setInterval(refreshMessage,15000); //消息15秒刷新
	</script>
</head>

<body>
	<div class="ui-layout-west">
		<div class="side-wrap">
			<h1 class="logo">
				<a title="集丽科技, 让美丽更简单！" target="mainFrame" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index"><img src="${pageContext.request.contextPath}/view/order/images/logo.png" alt="集丽科技"></a>
			</h1>
			<div class="side-menu">
				<ul>
					<li class="pr side-menu-li li-crop menu1" id="order" code="WBM_ORDER">
						<c:if test="${sessionScope.pc_user_sessiion.id != '1'}">
						<a class="order side-menu-a new-con-p" target="mainFrame" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/myorderlist">
							<i class="icon"></i>订单<span class="${sessionScope.order_status_msg > 0 ? 'ui-new-func':''}"></span>
						</a>
						</c:if>
						<c:if test="${sessionScope.pc_user_sessiion.id == '1'}">
						<a class="order side-menu-a new-con-p" target="mainFrame" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/suborderlist">
							<i class="icon"></i>订单<span class="${sessionScope.order_status_msg > 0 ? 'ui-new-func':''}"></span>
						</a>
						</c:if>
						
						<div class="float-menu" style="display: none; top: 0px; margin-top: 0px;">
							<ul class="sec-nav clearfix sec-nav-flow" style="width: 249px;">
								<li class="sec-nav-li sec-nav-li-flow" style="height: 126px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">订单管理</a>
									<ul class="third-nav-ul">
										<c:if test="${sessionScope.pc_user_sessiion.id != '1'}">
										<li class="sec-nav-li menu2" code="WBM_ORDER_RETURNED">
											<a class="sec-nav-a new-con" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/myorderlist">我的订单
											<span class="${sessionScope.order_status_msg2 > 0 ? 'ui-new-func':''}"></span></a>
										</li>
										</c:if>
										<c:if test="${sessionScope.pc_user_sessiion.identity == 'A' }">
										<li class="sec-nav-li menu2" code="WBM_ORDER_OUTSTOCK">
											<a class="sec-nav-a new-con" target="mainFrame" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/suborderlist">客户订单
											<span class="${sessionScope.order_status_msg1 > 0 ? 'ui-new-func':''}"></span></a>
										</li>
										</c:if>
										<c:if test="${sessionScope.pc_user_sessiion.id == '1'}">
										<li class="sec-nav-li menu2" code="WBM_ORDER_RETURNED">
											<a class="sec-nav-a new-con" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/z/suborderlist">普通会员订单
											<span class="${sessionScope.order_status_msg3 > 0 ? 'ui-new-func':''}"></span></a>
										</li>
										</c:if>
										<c:if test="${sessionScope.pc_user_sessiion.id != '1'}">
										<li class="sec-nav-li menu2" code="WBM_ORDER_RETURNED">
											<a class="sec-nav-a new-con" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/z/zOrderlist&param={'orderType':'my'}">普通会员订单
											<span class="${sessionScope.order_status_msg4 > 0 ? 'ui-new-func':''}"></span></a>
										</li>
										</c:if>
									</ul>
								</li>
							</ul>
						</div>
					</li>
					
					<li class="pr side-menu-li li-crop menu1" id="customer" code="WBM_CUSTOMER">
						<a class="customer side-menu-a new-con-p" href="javascript:;" curInd="1" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/userList">
							<i class="icon"></i>客户
						</a>
						<div class="float-menu" style="display: none; top: 0px; margin-top: 0px;">
							<ul class="sec-nav clearfix sec-nav-flow" style="width: 249px;">
								<li class="sec-nav-li sec-nav-li-flow" style="height: 160px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">客户管理</a>
									<ul class="third-nav-ul">
										<li class="sec-nav-li menu2" code="WBM_CUSTOMER_LIST">
											<a class="sec-nav-a new-con" href="javascript:;" curInd="1" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/userList">客户列表</a>
										</li>
										<c:if test="${sessionScope.pc_user_sessiion.id != '1'}">
											<li class="sec-nav-li menu2" code="WBM_CUSTOMER_LEVEL">
												<a class="sec-nav-a new-con" href="javascript:;" curInd="1" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/parentDisList">我的采购利益</a>
											</li>
										</c:if>
										<c:if test="${sessionScope.pc_user_sessiion.identity != 'C'}">
											<li class="sec-nav-li menu2" code="WBM_CUSTOMER_LEVEL">
												<a class="sec-nav-a new-con" href="javascript:;" curInd="1" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/userDisList">客户采购利益</a>
											</li>
											<li class="sec-nav-li menu2" code="WBM_CUSTOMER_LEVEL">
												<a class="sec-nav-a new-con" href="javascript:;" curInd="1" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/userRatioList">奖励转货款设置</a>
											</li>
										</c:if>
									</ul>
								</li>
							</ul>
						</div>
					</li>
					<!-- <li class="product pr side-menu-li li-crop menu1" id="product" code="WBM_PRODUCT">
						<a class="product side-menu-a new-con-p"  href="javascript:;">
							<i class="icon"></i>商品<span class="ui-new-func"></span>
						</a>
						<div class="float-menu" style="display: none; top: 0px;">
							<ul class="sec-nav clearfix sec-nav-flow" style="width: 304px;">
								<li class="sec-nav-li sec-nav-li-flow" style="height: 228px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">商品管理</a>
									<ul class="third-nav-ul">
										<li class="third-nav-li menu2" code="WBM_PRODUCT_LIST">
											<a class="third-nav-a new-con"  href="javascript:;">商品列表</a>
										</li>
										<li class="third-nav-li menu2" code="WBM_PRODUCT_TYPE">
											<a class="third-nav-a new-con" href="javascript:;">商品类别</a>
										</li>
										<li class="third-nav-li menu2" code="WBM_PRODUCT_UNIT">
											<a class="third-nav-a new-con" href="javascript:;">计量单位</a>
										</li>
									</ul>
								</li>
								<li class="sec-nav-li sec-nav-li-flow" style="height: 228px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">促销管理</a>
									<ul class="third-nav-ul">
										<li class="third-nav-li menu2" code="WBM_PRODUCT_PROMOTION">
											<a class="third-nav-a new-con"  href="javascript:;">商品促销</a>
										</li>
										<li class="third-nav-li menu2" code="WBM_PRODUCT_ORDER_PROMOTION">
											<a class="third-nav-a new-con" href="javascript:;">订单促销</a>
										</li>
										<li class="third-nav-li menu2" code="WBM_PRODUCT_MIX_PROMOTION">
											<a class="third-nav-a new-con" href="javascript:;">组合促销<span class="ui-new-func"></span></a>
										</li>
									</ul>
								</li>
							</ul>
						</div>
					</li> -->
					<li class="pay pr side-menu-li li-crop menu1" id="pay" code="WBM_FUND">
						<a class="pay side-menu-a new-con-p" href="javascript:;"  curInd="2" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/bank/bankList">
							<i class="icon"></i>资金
						</a>
						<div class="float-menu" style="display: none; top: 0px;">
							<ul class="sec-nav clearfix sec-nav-flow" style="width: 221px;">
								<li class="sec-nav-li sec-nav-li-flow" style="height: 126px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">资金管理</a>
									<ul class="third-nav-ul">
										<li class="third-nav-li menu2" code="WBM_FUND_RECEIPT_CONFIRM">
											<a class="sec-nav-a new-con" href="javascript:;" curInd="2" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/bank/bankList">我的资金账户</a>
										</li>
										<c:if test="${sessionScope.pc_user_sessiion.identity != 'C'}">
										<li class="third-nav-li menu2" code="WBM_FUND_ONLINE_PAYMENT">
											<a class="third-nav-a new-con" href="javascript:;" curInd="2" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/bank/subbankList">我的客户资金帐户</a>
										</li>
										</c:if>
										<li class="third-nav-li menu2" code="WBM_FUND_BANK_ACCOUNT">
											<a class="third-nav-a new-con" href="javascript:;">银行账号**</a>
										</li>
									</ul>
								</li>
								<li class="sec-nav-li sec-nav-li-flow" style="height: 126px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">资金报表</a>
									<ul class="third-nav-ul">
										<li class="third-nav-li menu2" code="WBM_FUND_INCOME_RECORD">
											<a class="third-nav-a new-con" href="javascript:;">资金收支报表</a>
										</li>
										<li class="third-nav-li menu2" code="WBM_FUND_INCOME_STATISTICS">
											<a class="third-nav-a new-con" href="javascript:;">返利奖励统计</a>
										</li>
										<li class="third-nav-li menu2" code="WBM_FUND_SEND_STATISTICS">
											<a class="third-nav-a new-con" href="javascript:;">发货统计</a>
										</li>
									</ul>
								</li>
							</ul>
						</div>
					</li>
					<li class="message pr side-menu-li li-crop menu1" id="message" code="WBM_NOTIFY">
						<a class="message side-menu-a new-con-p" href="javascript:;" curInd="3" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'1'}">
							<i class="icon"></i>消息
							<span id="messageTopFunc">
							<c:choose>
								<c:when test="${sessionScope.order_message0_session > 0}">
									<span class="ui-new-func">
								</c:when>
								<c:when test="${sessionScope.order_message1_session > 0}">
								 	<span class="ui-new-func">
								</c:when>
								<%-- <c:when test="${sessionScope.order_message2_session > 0}">
								 	<span class="ui-new-func">
								</c:when> --%>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							</span>
						</a>
						<div class="float-menu" style="display: none; top: 0px; margin-top: 0px;">
							<ul class="sec-nav clearfix sec-nav-flow" style="width: 249px;">
								<li class="sec-nav-li sec-nav-li-flow" style="height: 126px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">消息管理</a>
									<ul class="third-nav-ul">
										<li class="third-nav-li menu2" code="WBM_NOTIFY_CLASSIFY">
											<a class="third-nav-a new-con" href="javascript:;" curInd="3" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'1'}">业务消息
												<span id="message1Func">
												<c:if test="${sessionScope.order_message1_session > 0}">
													<span class="ui-new-func"></span>
												</c:if>
												</span>
											</a>
										</li>
										<%-- <li class="third-nav-li menu2" code="WBM_NOTIFY_NOTICE">
											<a class="third-nav-a new-con" href="javascript:;" curInd="3" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'2'}">站内信
											<span id="message2Func">
											<c:if test="${sessionScope.order_message2_session > 0}">
												<span class="ui-new-func"></span>
											</c:if>
											</span>
											</a>
										</li> --%>
										<li class="third-nav-li menu2" code="WBM_NOTIFY_AD">
											<a class="third-nav-a new-con" href="javascript:;" curInd="3" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'0'}">系统消息
											<span id="message0Func">
											<c:if test="${sessionScope.order_message0_session > 0}">
												<span class="ui-new-func"></span>
											</c:if>
											</span>
											</a>
										</li>
									</ul>
								</li>
								<!-- <li class="sec-nav-li sec-nav-li-flow" style="height: 126px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">手机短信</a>
									<ul class="third-nav-ul">
										<li class="third-nav-li menu2" code="WBM_NOTIFY_SMS_RECHARGE">
											<a class="third-nav-a new-con" href="javascript:;">短信充值</a>
										</li>
										<li class="third-nav-li menu2" code="WBM_NOTIFY_SMS_SETTING">
											<a class="third-nav-a new-con" href="javascript:;">短信发送设置</a>
										</li>
									</ul>
								</li> -->
							</ul>
						</div>
					</li>
					<li class="report pr side-menu-li li-crop menu1" id="report" code="WBM_REPORT">
						<a class="report side-menu-a new-con-p" href="javascript:;">
							<i class="icon"></i>报表
						</a>
						<div class="float-menu" style="top: 0px; margin-top: 0px;">
							<ul class="sec-nav">
								<li class="sec-nav-li menu2" code="WBM_REPORT_ORDER">
									<a class="sec-nav-a new-con" href="javascript:;">采购统计报表**</a>
								</li>
								<li class="sec-nav-li menu2" code="WBM_REPORT_INDENT">
									<a class="sec-nav-a new-con" href="javascript:;">客户订货报表**</a>
								</li>
								<!-- <li class="sec-nav-li menu2" code="WBM_REPORT_AREA">
									<a class="sec-nav-a new-con" href="javascript:;">代理统计报表</a>
								</li> -->
								<li class="sec-nav-li menu2" code="WBM_REPORT_SALE">
									<a class="sec-nav-a new-con" href="javascript:;">商品销售报表**</a>
								</li>
								
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<iframe id="mainFrame" name="mainFrame" class="ui-layout-center" width="100%" height="600" frameborder="0" scrolling="auto" src="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index"></iframe>
</body>
</html>