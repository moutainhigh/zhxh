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
    <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
    
    <style type="text/css">
		.admin {
		    padding: 20px 30px 10px 30px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 0px;
		    left: 0px;
		    overflow: auto;
		    width: 100%;
    	}
    	.table th{text-align: center}
    	.table-bordered th {border-bottom: 1px solid #ddd;}
    </style>
    <script type="text/javascript">
    	//
    	var orderid = "";
    	$(function(){
    		
    	});
    	
    	//品牌-商品列表
    	function loadData(){
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderZ/orderShareProduct.htmls",
                data: {orderid:orderid},
                type: "post",
                dataType:"json",
                success: function (json) {
                	var order = json.order;	//订单
                	//加载支付
            		$("#orderProductList").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/z/orderShare.tpl");
                    $("#orderProductList").processTemplate(json);
                	
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           	});
    	}
    	
    	function inc(json) {
    		var jsonArr = JSON.parse(json);
    		var result = "";
    		for(var i=0;i<jsonArr.length;i++) {
    			result += "[" + jsonArr[i].companyname + "] 折扣 [" + jsonArr[i].userStandard + "] 数量 [" + jsonArr[i].productnum + "] 分润 [" + jsonArr[i].sharepay + "]."
    		}
    		return result;
    	}
    	
    	//
    	function setData(id){
    		orderid = id;
    		loadData();
    	}
    	
    	//
    	function getData(){
    		var objArr = new Array();
    		$("input[name='id']").each(function(index,element){
       	    	if(element.checked==true){
       	        	id = element.value;
       	        	var tr = $('#'+id);
       	        	var tds = $(tr).find("td");
       	        	var i = 1;
       	        	var _obj = {};
       	        	_obj.id = id;
       	        	_obj.brandname = $.trim($(tds[i++]).text());
       	        	_obj.productname = $.trim($(tds[i++]).text());
       	        	_obj.productsize = $.trim($(tds[i++]).text());
       	        	_obj.price = $.trim($(tds[i++]).text());
       	        	_obj.saleprice = $.trim($(tds[i++]).text());
       	        	_obj.quantity = 1;
       	        	objArr.push(_obj);
       	        	/* for(i=0;i<tds.length;i++){
       	        		alert($.trim($(tds[i]).text()));
       	        	} */
       	        }
       	    });
    		return objArr;
    	}
    	
    	function bindTrClick() {
    		//除了表头（第一行）以外所有的行添加click事件.
            $(".sel tr").first().nextAll().click(function (e) {
            	if (e.target.tagName == "TD") {
            		var firstInput = $(this).children("td:eq(0)").children("input:eq(0)");  // 第一个checkBox
                	firstInput.attr("checked",!firstInput.is(':checked'));
            	}
            });
    	}
    </script>
</head>
<body>
	<!--内容-->
	<div class="admin">
		<div id="orderProductList" class="admin-panel">
		</div>
	</div>
</body>
</html>