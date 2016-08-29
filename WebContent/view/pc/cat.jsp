<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/faq.css" />
<%-- <script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> --%> 
<script src="${pageContext.request.contextPath}/js/jquery-1.11.0.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con shopcart-con clearfix">
	    <h3>购物车</h3>
	    <div class="shopcart-con-top">
	        <h4 class="cart-icon1 fl">购物车</h4>
	        <ul class="fr">
	            <li class="cur"><em>step01</em><span>购物车</span></li>
	            <li><em>step02</em><span>订单确认</span></li>
	            <li><em>step03</em><span>付款</span></li>
	            <li><em>step04</em><span>付款成功</span></li>
	        </ul>
	    </div>
	    <table width="0" border="0" cellpadding="0" cellspacing="0" class="cart-table">
	      <tr class="tr">
	        <td width="110"><input id="checkAll" type="checkbox" /></td>
	        <td width="444">商品名称</td>
	        <td width="156">单价/元</td>
	        <td width="250">数量/件</td>
	        <td width="144">小计/元</td>
	        <td width="96">操作</td>
	      </tr>
	      <c:forEach var="item" items="${psizeList }">
	      	<tr id="${item.productcatid }">
		      	<td><input type="checkbox" name="id" value="${item.id }" /></td>
		        <td align="left">
		            <div class="img-txt">
		                <img src="${pageContext.request.contextPath}/${item.productpic }" class="fl" />
		                <div class="txt fl">
		                    <h5>${item.productname }</h5>
		                    <em>${item.productmemo }</em>
		                    <span>${item.productsize }</span>
		                </div>
		            </div>
		        </td>
		        <td>${item.saleprice }</td>
		        <td>
		            <div class="num">
		                <em class="fl">-</em>
		                <input type="text" value="${item.quantity }" class="txtnum fl" />
		                <em class="fl">+</em>
		            </div>
		        </td>
		        <td>30.00</td>
		        <td><b class="del"><a href="javascript:delCat('${item.productcatid }')">删除</a></b></td>
		      </tr>
	      </c:forEach>
	    </table>
	    <div class="Select-all clearfix">
	        <a href="javascript:;" id="chk_all" class="checkall" >选择所有项目</a>
	        <a href="javascript:delCat('');">删除选中的商品</a>
	    </div>
	    <div class="tatol">
	        <p>
	            <em>合计金额：￥300</em>
	            <em>运费：￥0</em>
	            <em>总价：<b>￥300</b></em>
	        </p>
	    </div>
	    <input type="button" value="立即购买" class="shopcart-but" />
	</div>
	
	<script type="text/javascript">
	
		$(function() { 
			
			//选择所有
	        $('#checkAll').click(function(){
	            var checked = $('#checkAll').is(':checked');
	            var unitselect = $('input[name="id"]');
	            checked?unitselect.prop('checked',true):unitselect.prop('checked',false);
	        });
	        $('.checkall').click(function(){
	            var checked = $('#checkAll').is(':checked');
	            
	            var checkAll = $('#checkAll');
	            checked?checkAll.prop('checked',false):checkAll.prop('checked',true);
	            
	            var unitselect = $('input[name="id"]');
	            checked?unitselect.prop('checked',false):unitselect.prop('checked',true);
	        });
	        
		}) 
	
		//删除
		function delCat(id){
			var ids = "";
    		if (id != "") {
    			ids = id;
    		}else {
           	    $("input[name='id']").each(function(){
           	        if($(this).prop("checked") == true){
           	            ids += $(this).val() + ",";
           	        }
           	    });
           	 	ids = ids.substring(0,ids.length-1);
    		}
    		
			alert(ids);
			/* $.ajax({
		    	async:false,
		        url: "${pageContext.request.contextPath}/porder/catDel.htmls",
		        data: {'id':id},
		        type: "post",
		        dataType:"text",
		        success: function (text) {
		        	alert(text);
		        	if(text == "success"){
		        		$("#"+id).remove();
		        	}
		        },
		        error: function (jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.responseText);
		        }
		    }); */
		}
	
	
	</script>
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>