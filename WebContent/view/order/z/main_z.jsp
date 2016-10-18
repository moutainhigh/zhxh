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
    <title>集丽科技-普通会员采购管理平台</title>
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
						<a class="order side-menu-a new-con-p" target="mainFrame" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/myorderlist">
							<i class="icon"></i>订单<span class="${sessionScope.order_status_msg > 0 ? 'ui-new-func':''}"></span>
						</a>
						<c:if test="${sessionScope.pc_user_sessiion.identity != 'C'}">
						<div class="float-menu" style="display: none; top: 0px; margin-top: 0px;">
							<ul class="sec-nav clearfix sec-nav-flow" style="width: 249px;">
								<li class="sec-nav-li sec-nav-li-flow" style="height: 126px;">
									<a class="sec-nav-a li-a-color" href="javascript:;">订单管理</a>
									<ul class="third-nav-ul">
										<li class="sec-nav-li menu2" code="WBM_ORDER_RETURNED">
											<a class="sec-nav-a new-con" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/myorderlist">我的订单
											<span class="${sessionScope.order_status_msg2 > 0 ? 'ui-new-func':''}"></span></a>
										</li>
										<li class="sec-nav-li menu2" code="WBM_ORDER_OUTSTOCK">
											<a class="sec-nav-a new-con" target="mainFrame" href="javascript:;" curInd="0" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/suborderlist">客户订单
											<span class="${sessionScope.order_status_msg1 > 0 ? 'ui-new-func':''}"></span></a>
										</li>
									</ul>
								</li>
							</ul>
						</div>
						</c:if>
					</li>
					
					<li class="pr side-menu-li li-crop menu1" id="customer" code="WBM_CUSTOMER">
						<a class="customer side-menu-a new-con-p" href="javascript:;" curInd="1" funcode="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/z/userList">
							<i class="icon"></i>客户
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<iframe id="mainFrame" name="mainFrame" class="ui-layout-center" width="100%" height="600" frameborder="0" scrolling="auto" src="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index"></iframe>
</body>
</html>