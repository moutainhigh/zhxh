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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/view/order/css/table.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-jtemplates.js"></script>
    <script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
    <style type="text/css">
    	.doc-naver {padding-top: 10px;padding-bottom: 10px;}
		.doc-header.fixed-top .doc-naver {padding-top: 10px;padding-bottom: 10px;background-color: #fff;}
		.nav-inline li a {line-height: 22px;}
		.border-back {border-color:#b5cfd9;}
		.admin {width: 100%;background: #fff;right: 0; bottom: 0;top: 87px;overflow: auto;}
		.list-group, .list-link {border: solid 1px #EED97C;background-color: #fffdf3;}
		.panel {border-top: solid 0}
    </style>
    <script type="text/javascript">
		//全局对象
		var objArr = new Array();
		var total = 0,total_sum = 0;
    	$(function(){
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/order/orderdetails.htmls",
                data: {orderid:'${orderid}'},
                type: "post",
                dataType:"json",
                success: function (json) {
                	var order = json.order;	//订单
                	$("#ordernum").html(order.ordernumber);
                	$("#ordertime").html(order.ordertime);
                	$("#ostatus").html(order.orderstatusmemo);
                	disposal(json.products);	//订单详情
                	var address = json.address;	//收货地址
                	var address_str = "收货人："+address.username+"，联系电话："+address.userphone+"，收货地址："+address.userpath;
                	$("#address").html(address_str);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           	});
    	});
    	
    	//加载数据
    	function loadData(){
    		$("#proList").setTemplateElement("Template-List-user-show");
            $("#proList").processTemplate(objArr);
            //
            $("#total").html(formatFloat(total,2));
            $("#total_sum").html(formatFloat(total,2));
            
    	}
    	
    	
    	//处理数据
    	function disposal(data){
    		for(i=0;i<data.length;i++){
    			objArr.push(initializeObj(data[i]));
    		}
    		//加载数据
    		loadData();
    	}
    	
    	//初始数据对象
    	function initializeObj(data){
    		var obj = {};
    		obj.id = data.id;
			obj.productname = data.productname;
			obj.productsize = data.productsize;
			obj.price = formatFloat(data.price,2);		//售价
			obj.buyerdis = formatFloat(data.buyerdis,2);	//折扣
			obj.quantity = data.productnum; 	//数量
			var _subtotal = 0;
			if(parseInt(data.buyerdis) > 0){
				_subtotal = data.price * data.buyerdis * data.productnum;	//小计
			}else{
				_subtotal = data.price * data.productnum;	//小计
			}
			obj.subtotal = formatFloat(_subtotal,2);
			total += obj.subtotal;
			return obj;
    	}
    	
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="#" class="icon-home">首页</a> </li>
			<li><a href="#" >我的订单</a></li>
			<li><a href="#" >订单详情</a></li>
		</ul>
		<div class="admin" style="padding: 0px 60px;">
			<div class="media-body">
				<div class="padding float-left"><h4>订单详情</h4></div>
				<div class="padding float-right"><button class="button button bg-blue icon-reply"> 返回</button></div>
			</div>
			<div style="padding-bottom: 20px;">
				<ul class="list-group">
					<li>订单号：<strong id="ordernum"></strong>	<label style="padding-left: 30px;" id="ordertime"></label><span id="ostatus" class="tag bg-yellow float-right"></span></li>
					<li>【收货信息】<span id="address"></span></li>
				</ul>
			</div>
			<h4>订单商品</h4>
			<hr class="bg-sub">
			<div style="padding-bottom: 20px;">
				<div id="proList" class="admin-panel">
					<table class="table table-bordered table-hover text-small">
						<tbody>
							<tr class="panel-head">
								<!-- <th width="45" align="center"><input type="checkbox" value="1" name="id"></th> -->
								<!-- <th width="120"></th> -->
								<th width="*">商品名称</th>
								<th width="160">规格</th>
								<th width="160">数量</th>
								<th width="100">单价</th>
								<th width="100">折扣</th>
								<th width="180">小计</th>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="text-right panel" style="padding: 30px 50px;">
					<div>合计：￥<span id="total">0.00</span></div>
					<br/>
					<div>应付总额：￥<span style="color: red !important" id="total_sum">0.00</span></div>
				</div>
			</div>
			<h4>物流信息</h4>
			<hr class="bg-sub">
			<div class="table-responsive">
				<table class="table table-hover">
					<tbody><tr>
						<th style="text-align: left;" width="180">处理时间</th>
						<th style="text-align: left;" width="*">处理信息</th>
						<th width="180">操作人</th>
					</tr>
					<tr>
						<td style="text-align: left;">2016-07-20 12:36:13</td>
						<td style="text-align: left;">您的订单已经拣货完毕，待出库交付申通快递，运单号为229111673599</td>
						<td>商家</td>
					</tr>
					<tr>
						<td style="text-align: left;">2016-07-20 19:30:13</td>
						<td style="text-align: left;">由广东东莞南城西平分部 发往 广东东莞中转部</td>
						<td>申通快递</td>
					</tr>
				</tbody></table>
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
	
	<textarea id="Template-List-user-show" rows="0" cols="0" style="display:none">
		<!--
		<table class="table table-bordered table-hover text-small">
			<tbody>
				<tr class="panel-head">
					<th width="160">品牌</th>
					<th width="*">商品名称</th>
					<th width="160">规格</th>
					<th width="160">数量</th>
					<th width="100">单价</th>
					<th width="100">折扣</th>
					<th width="180">小计</th>
				</tr>
				{#foreach $T as row}
				<tr class="tr" id="{$T.row.id}">
					<td>夏木</td>
					<td style="text-align: left;">{$T.row.productname}</td>
					<td>{$T.row.productsize}</td>
					<td>{$T.row.quantity}</td>
					<td style="text-align: right;">￥{$T.row.price}</td>
					<td>{$T.row.buyerdis}</td>
					<td style="text-align: right;">￥{$T.row.subtotal}</td>
				</tr>
				{#/for}
			</tbody>
		</table>
	    -->
	</textarea>
	
	<script type="text/javascript">
		//金额格式化  
	    function formatFloat(src, pos){  
	        var num = parseFloat(src).toFixed(pos);  
	        num = num.toString().replace(/\$|\,/g,'');  
	        if(isNaN(num)) num = "0";  
	        sign = (num == (num = Math.abs(num)));  
	        num = Math.floor(num*100+0.50000000001);  
	        cents = num%100;  
	        num = Math.floor(num/100).toString();  
	        if(cents<10) cents = "0" + cents;  
	        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
	        num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3));  
	        return (((sign)?'':'-') + num + '.' + cents);  
	    }
	</script>
</body>
</html>