<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单确认</title>
<style type="text/css">
.tan-bg1{ width: 100%; height: 100%; position:fixed; left:0; background-color:#000; filter:alpha(opacity=30); opacity:0.3; top:0; display:none; z-index: 9999;}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/faq.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--添加新地址弹框-->
	<div class="tan-bg1"></div>
	<form id="address_form" action="" method="post">
	<div class="add-address-tan">
	    <span>新地址</span>
	    <ul class="con">
	        <li class="clearfix">
	            <em class="fl">收货人</em>
	            <div class="input fl"><input type="text" name="username" id="usname" class="txt" /></div>
	        </li>
	        <li class="clearfix">
	            <em class="fl">手机号码</em>
	            <div class="input fl"><input type="text" name="userphone" id="userphone" class="txt" /></div>
	        </li>
	        <li class="clearfix">
	            <em class="fl">邮政编码</em>
	            <div class="input fl"><input type="text" name="postcode" id="postcode" class="txt" /></div>
	        </li>
	        <li class="clearfix">
	            <em class="fl">收货地址</em>
	            <div class="input fl"><input type="text" name="userpath" id="userpath" class="txt" /></div>
	        </li>
	    </ul>
	    <input type="button" value="保 存" onclick="saveAddress()" class="hold" />
	    
	</div>
	</form>
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	
	<div class="HTML-con shopcart-con clearfix">
	    <h3>订单确认</h3>
	    <div class="shopcart-con-top">
	        <h4 class="cart-icon2 fl">订单确认</h4>
	        <ul class="fr">
	            <li><em>step01</em><span>购物车</span></li>
	            <li class="cur"><em>step02</em><span>订单确认</span></li>
	            <li><em>step03</em><span>付款</span></li>
	            <li><em>step04</em><span>付款成功</span></li>
	        </ul>
	    </div>
	    <div class="dingdan">
	        <div class="tit clearfix">
	            <span class="fl">收货人<i>/</i></span>
	            <div class="add-address fr">新增地址</div>
	        </div>
	        <div class="address">
	            <ul class="address-ul">
	            <c:forEach var="item" items="${userPathList }">
	            	<li class="clearfix">
	                    <div class="address-x fl">
	                        <input name="ad_id" type="radio" value="${item.id }" />
	                        <span>${item.username }</span>
	                        <em>${item.userpath }</em>
	                        <b>${item.userphone }</b>
	                    </div>
	                    <div class="address-but fl">
	                        <!-- <a href="javascript:;">修改</a>
	                        <a href="javascript:;" class="del">删除</a> -->
	                    </div>
	                </li>
	            </c:forEach>
	            </ul>
	            <em class="more">+ 更多</em>
	        </div>
	    </div>
	    <div class="dingdan">
	        <div class="tit clearfix">
	            <span class="fl">商品<i>/</i></span>
	        </div>
	    </div>
	    <table width="0" border="0" cellpadding="0" cellspacing="0" class="cart-table">
	      <tr class="tr">
	        <td width="600">商品名称</td>
	        <td width="176">单价/元</td>
	        <td width="250">数量/件</td>
	        <td width="174">小计/元</td>
	      </tr>
	      <c:forEach var="item" items="${psizeList }">
	      	<tr>
		        <td align="left">
		            <div class="img-txt" style="margin-left: 31px">
		                <img src="${pageContext.request.contextPath}/${item.productpic }" class="fl" />
		                <div class="txt fl">
		                    <h5>${item.productname }</h5>
		                    <em>${item.productmemo }</em>
		                </div>
		            </div>
		        </td>
		        <td>${item.saleprice }</td>
		        <td>${item.quantity }</td>
		        <td>${item.saleprice * item.quantity}</td>
		    </tr>
	      </c:forEach>
	    </table>
	    <div class="tatol">
	        <p>
	            <em>合计金额：￥${subtotal }</em>
	            <em>运费：￥0</em>
	            <em>总价：<b>￥${subtotal }</b></em>
	        </p>
	    </div>
	    <form name="form1" action="${pageContext.request.contextPath}/porder/suborder.htmls" method="post">
	    	<input type="hidden" name="ids" value="${pids }">
	    	<input type="hidden" name="addressid" id="address" value="">
	    	<input type="button" value="立即付款" onclick="tosubmit()" class="shopcart-but" />
	    </form>
	</div>
	<script type="text/javascript">
		//form序列化
		$.fn.serializeObject = function()  
		{  
		   var o = {};  
		   var a = this.serializeArray();  
		   $.each(a, function() {  
		       if (o[this.name]) {  
		           if (!o[this.name].push) {  
		               o[this.name] = [o[this.name]];  
		           }  
		           o[this.name].push(this.value || '');  
		       } else {  
		           o[this.name] = this.value || '';  
		       }  
		   });  
		   return o;  
		};
		
		function tosubmit(){
			$("input[name='ad_id']").each(function(){
       	        if($(this).prop("checked") == true){
       	        	var id = $(this).val();
       	        	$("#address").val(id);
       	        	//alert(id);
       	        }
       	    });
			var address = $("#address").val();
			if(typeof(address) == "undefined" || address == ""){
				layer.msg("请选择一个地址！");
				return;
			}
			form1.submit();
		}
		//
		function saveAddress(){
			var username = $("#usname").val();
			var userphone = $("#userphone").val();
			var postcode = $("#postcode").val();
			var userpath = $("#userpath").val();
			if(typeof(username) == "undefined" || username == ""){
				layer.msg("请输入收货人");
				return false;
			}else if(typeof(userphone) == "undefined" || userphone == ""){
				layer.msg("请输入手机号码");
				return false;
			}else if(typeof(postcode) == "undefined" || postcode == ""){
				layer.msg("请输入邮编");
				return false;
			}else if(typeof(userpath) == "undefined" || userpath == ""){
				layer.msg("请输入收货地址");
				return false;
			}
			var obj = $("#address_form").serializeObject();
			var fdata = $.param(obj);
			$.ajax({
		    	async:false,
		        url: "${pageContext.request.contextPath}/porder/newaddress.htmls",
		        data: fdata,
		        type: "post",
		        dataType:"text",
		        success: function (text) {
		        	if(text != "error"){
		        		location.reload();
		        	}else{
		        		layer.msg("添加失败！");
		        	}
		        },
		        error: function (jqXHR, textStatus, errorThrown) {
		            layer.msg(jqXHR.responseText);
		        }
		    });
			
		}
	</script>
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>