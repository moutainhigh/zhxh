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
    	.doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		}
		.doc-header.fixed-top .doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		    background-color: #fff;
		}
		.nav-inline li a {
			line-height: 22px;
		}
		.border-back {
    		border-color:#b5cfd9;
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
    </style>
    <script type="text/javascript">
		//全局对象
		var objArr = new Array();
		var total = 0,total_sum = 0;
		var comp;//采购商家(用于改变商家时-取消回调)
    	$(function(){
    		//提示信息
    		layer.tips('请先选择采购商家', '#f_comp', {tips: [2, '#FF9901'],time: 5000,});
    		
    		//选择商家
    		$("#f_comp").change(function(){
    			if($(this).val() != "0")
    				layer.tips('点击选择品牌', '#brand_btn', {tips: [1, '#FF9901'],time: 5000,});
    			
    			if(objArr.length > 0){
    				var cf1 = "";
    				layer.confirm('您是如何看待前端开发？', {
   						btn: ['重要','奇葩'] //按钮
   					}, function(index){
   						//数据清零
    	    			objArr = [];
    	    			total = 0,total_sum = 0;
    	    			loadData();
    	    			layer.close(index);
   					}, function(){
   						$("#f_comp").val(comp);
   					});
    				
    			}
    			//品牌
    			brand($(this).val());
    			
    		});
    		
    		//提交
    		$("#submit_btn").click(function(){
    			if(objArr.length > 0){
    				var _data =  JSON.stringify(objArr);
    				var _parentid = $("#f_comp").val();
    				$.ajax({
    	    			async:false,
    	                url: "${pageContext.request.contextPath}/order/createorder.htmls",
    	                data: {objs:_data,parentid:_parentid},
    	                type: "post",
    	                dataType:"text",
    	                success: function (text) {
    	                	if(text == "success")
    	                		location.href = "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/myorderlist";
    	                	else
    	                		layer.msg("操作失败",{icon:6});
    	                },
    	                error: function (jqXHR, textStatus, errorThrown) {
    	                    alert(jqXHR.responseText);
    	                }
    	           	});
    			}else{
    				layer.msg("您没有添加任何商品",{icon:6});
    				return;
    			}
    		});
    	});
    	
    	//加载数据
    	function loadData(){
    		$("#proList").setTemplateElement("Template-List-user-show");
            $("#proList").processTemplate(objArr);
            bindTdClick();	//td绑定
            parent.parent.layer.closeAll();	//关闭窗体
            //
            $("#total").html(formatFloat(total,2));
            $("#total_sum").html(formatFloat(total,2));
            
    	}
    	
    	//品牌
    	function brand(id){
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/order/brandlist.htmls",
                data: {parentid:id},
                type: "post",
                dataType:"json",
                success: function (json) {
                	var data = json.data;
                	$("#brand").html("");
                	for(i=0;i<data.length;i++){
                		$('<li><a href="javascript:;" onclick="selPro(\''+data[i].id+'\')">'+data[i].brandname+'</a> </li>').appendTo($("#brand"));
                	}
                	if(data.length > 0)
                		$("#brand_btn").removeAttr("disabled");	//解除
                	else
                		$("#brand_btn").attr("disabled","disabled");	//禁用
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           	});
    	}
    	
    	//选择商品
		function selPro(brandid){
			comp = $("#f_comp").val();
			parent.parent.layer.open({
			    type: 2,
			    title:'选择商品',
			    area: ['720px', '520px'],
			    fix: false, //不固定
			    maxmin: true,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/selProducts&param={'parentid':'"+comp+"','brandid':'"+brandid+"'}",
			    btn: ['确 定', '取 消'],
			  	yes: function(index,layero){
			  		var win = parent.window['layui-layer-iframe' + index].window;
			  		var data = win.getData();
			  		if(data.length > 0){
			  			disposal(data);//处理数据，并加载
			  		}else{
			  			parent.parent.layer.msg("您没有选择任何商品",{icon:6});
			  		}
			  	},
			    end: function(){
			    	//alert(123);
			    }
			});
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
			obj.price = data.price;		//售价
			obj.buyerdis = data.buyerdis;	//折扣
			obj.quantity = data.quantity; 	//数量
			if(parseInt(data.buyerdis) > 0){
				obj.subtotal = data.price * data.buyerdis * data.quantity;	//小计
			}else{
				obj.subtotal = data.price * data.quantity;	//小计
			}
			total += obj.subtotal;
			return obj;
    	}
    	
    	//绑定数量的TD
    	function bindTdClick() {
    		$('.quantity').unbind('click').click(function(){
    			var e = $(this);
    			var html = $(this).html();
    			if (html.indexOf("input") == -1) {
    				$(this).html("<input type='text' class='input quant' value='"+html+"'/>");
    				$(".quant").focus();
    				$(".quant").select();
    				$(".quant").blur(function(){
    					var val = $(this).val();
    					if(!(/^(\+|-)?\d+$/.test(val)) || val == 0){  
    				        val = 1; //非正整数为1
    				    }
    					e.html(val);
    					var id = $(e).parent("tr").attr("id");	//当前行ID
    					for(var i=0;i<objArr.length;i++) {
    						if (id == objArr[i].id) {
    							objArr[i].quantity = val; //变更数量
    							total = total - objArr[i].subtotal; //减去该商品数量变更前的小计
    							if(parseInt(objArr[i].buyerdis) > 0){
    								objArr[i].subtotal = objArr[i].price * objArr[i].buyerdis * objArr[i].quantity;	//小计
    							}else{
    								objArr[i].subtotal = objArr[i].price * objArr[i].quantity;	//小计
    							}
    							total = total + objArr[i].subtotal;	//把新的小计加到合计中
    							break;
    						}
    					}
    					//重新加载数据
    					loadData();
    				})
    			}
    		})
    	}
    	
    	
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="#" class="icon-home">首页</a> </li>
			<li><a href="#" >采购单</a></li>
		</ul>
		<div class="admin" style="padding: 30px 60px;">
			<div class="x3" style="padding-bottom: 20px;">
				<form onsubmit="return false;" class="form-x"><div class="form-group" id="f_parent">
	                 <div class="label" style="width: 16%">
	                     <label for="f_class">采购商家：</label>
	                 </div>
	                 <div class="field" style="width: 84%">
	                     <select class="input" id="f_comp" name="f_class">
	                     	 <option value="0">请选择</option>
	                     	 <c:forEach var="item" items="${u_list }">
	                         	<option value="${item.id }">${item.username }</option>
	                         </c:forEach>
	                     </select>
	                 </div>
	             </div></form>
			</div>
			<div class="padding float-right">
				<div class="button-group border-blue">
					<button id="brand_btn" type="button" class="button bg-blue dropdown-toggle" disabled="disabled">
						<span class="icon-plus"></span> 选择商品 <span class="downward"></span>
					</button>
					<ul id="brand" class="drop-menu">
					</ul>
				</div>
				<!-- <button class="button bg-blue" id="selPro"><span class="icon-plus"></span> </button> -->
			</div>
			<div>
				<div id="proList" class="admin-panel">
					<table class="table table-bordered table-hover text-small">
						<tbody>
							<tr class="panel-head">
								<th width="45" align="center"><input type="checkbox" value="1" name="id"></th>
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
				<div class="text-right" style="padding: 30px 50px;">
					<div>合计：￥<span id="total">0.00</span></div>
					<br/>
					<div>应付总额：￥<span style="color: red !important" id="total_sum">0.00</span></div>
				</div>
				<div class="form-inline" style="padding-top: 20px;">
					<div class="form-group">
						<div class="label">
							<label for="username">
								收货信息：</label>
						</div>
						<div class="field">
							收货人：张三，联系电话：15010780215，收货地址：北京市朝阳区望京悠乐汇A 2108
						</div>
					</div>
				</div>
				<div>
					<button id="submit_btn" class="button button-big bg-blue">提交订单</button>
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
	
	<textarea id="Template-List-user-show" rows="0" cols="0" style="display:none">
		<!--
		<table class="table table-bordered table-hover text-small">
			<tbody>
				<tr class="panel-head">
					<th width="45" align="center"><input type="checkbox" name="checkall"></th>
					<th width="*">商品名称</th>
					<th width="160">规格</th>
					<th width="160">数量</th>
					<th width="100">单价</th>
					<th width="100">折扣</th>
					<th width="180">小计</th>
				</tr>
				{#foreach $T as row}
				<tr class="tr" id="{$T.row.id}">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="id"></td>
					<td>{$T.row.productname}</td>
					<td>{$T.row.productsize}</td>
					<td class="quantity">{$T.row.quantity}</td>
					<td>{$T.row.price}</td>
					<td>{$T.row.buyerdis}</td>
					<td>{$T.row.subtotal}</td>
				</tr>
				{#/for}
			</tbody>
		</table>
	    -->
	</textarea>
	
	<script type="text/javascript">
		/** 
		 * 将数值四舍五入(保留2位小数)后格式化成金额形式 
		 * 
		 * @param num 数值(Number或者String) 
		 * @return 金额格式的字符串,如'1,234,567.45' 
		 * @type String 
		 */  
		function formatCurrency(num) {  
		    num = num.toString().replace(/\$|\,/g,'');  
		    if(isNaN(num))  
		    num = "0";  
		    sign = (num == (num = Math.abs(num)));  
		    num = Math.floor(num*100+0.50000000001);  
		    cents = num%100;  
		    num = Math.floor(num/100).toString();  
		    if(cents<10)  
		    cents = "0" + cents;  
		    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
		    num = num.substring(0,num.length-(4*i+3))+','+  
		    num.substring(num.length-(4*i+3));  
		    return (((sign)?'':'-') + num + '.' + cents);  
		}  
		   
		/** 
		 * 将数值四舍五入(保留1位小数)后格式化成金额形式 
		 * 
		 * @param num 数值(Number或者String) 
		 * @return 金额格式的字符串,如'1,234,567.4' 
		 * @type String 
		 */  
		function formatCurrencyTenThou(num) {  
		    num = num.toString().replace(/\$|\,/g,'');  
		    if(isNaN(num))  
		    num = "0";  
		    sign = (num == (num = Math.abs(num)));  
		    num = Math.floor(num*10+0.50000000001);  
		    cents = num%10;  
		    num = Math.floor(num/10).toString();  
		    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
		    num = num.substring(0,num.length-(4*i+3))+','+  
		    num.substring(num.length-(4*i+3));  
		    return (((sign)?'':'-') + num + '.' + cents);  
		}  
		  
		// 添加金额格式化  
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