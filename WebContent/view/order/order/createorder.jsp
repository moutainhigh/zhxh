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
    <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
    <style type="text/css">
    	.doc-naver {padding-top: 10px;padding-bottom: 10px;}
		.doc-header.fixed-top .doc-naver { padding-top: 10px;padding-bottom: 10px;background-color: #fff;}
		.nav-inline li a {line-height: 22px;}
		.border-back {border-color:#b5cfd9;}
		.admin {width: 100%;padding: 20px;background: #fff;right: 0;bottom: 0;top: 87px;overflow: auto;}
    </style>
    <script type="text/javascript">
		//全局对象
		var objArr = new Array();
		var total = 0,total_sum = 0;
		var comp;//采购商家(用于改变商家时-取消回调)
		var address;
		var tips = 0;	//提现信息
    	$(function(){
    		//提示信息
    		layer.tips('请先选择采购商家', '#f_comp', {tips: [2, '#FF9901'],time: 5000,});
    		
    		//选择商家
    		$("#f_comp").change(function(){
    			var _brand = $(this).val();
    			if(objArr.length > 0){
    				var cf = "您确定要变更采购商家吗？<br><p style='font-size:12px; color:red'>注意：变更后，已选择的商品将被清除。</p>";
    				layer.confirm(cf, {title:'系统提示',icon:3,
   						btn: ['确定','取消'] //按钮
   					}, function(index){
   						//数据清零
    	    			objArr = [];
    	    			total = 0,total_sum = 0;
    	    			loadData();
    	    			brand(_brand);	//品牌
    	    			layer.close(index);
   					}, function(){
   						$("#f_comp").val(comp);
   					});
    			}else{
        			brand(_brand);//品牌
    			}
    		});
    		
    		//提交
    		$("#submit_btn").click(function(){
    			if(objArr.length > 0){
    				var _data =  JSON.stringify(objArr);
    				var _parentid = $("#f_comp").val();
    				var _address_id = $("#address_id").val();
    				if(typeof(_address_id) == "undefined" || _address_id == ""){
    					layer.msg("请添加收货地址",{icon:6});
    					return;
    				}
    				$.ajax({
    	    			async:false,
    	                url: "${pageContext.request.contextPath}/order/createorder.htmls",
    	                data: {objs:_data,parentid:_parentid,addressid:_address_id},
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
            //
            $("#total_num").html(objArr.length);
            $("#total").html(formatFloat(total,2));
            $("#total_sum").html(formatFloat(total,2));
            
            if(tips == 0){
            	layer.tips('点击购买数量进行编辑', '#p_quantity', {tips: [1, '#FF9901'],time: 5000,end:function(){
            		layer.tips('点击移除商品', '.icon-minus', {tips: [1, '#FF9901'],time: 5000,});
            	}});
            	tips = 1;
            }
    	}
    	
    	//品牌
    	function brand(id){
    		if(id != "0"){
    			layer.tips('点击选择品牌', '#brand_btn', {tips: [1, '#FF9901'],time: 5000,});
        		$.ajax({
        			async:false,
                    url: "${pageContext.request.contextPath}/order/brandlist.htmls",
                    data: {parentid:id},
                    type: "post",
                    dataType:"json",
                    success: function (json) {
                    	if(json.total > 0){
                    		var data = json.data;
                        	$("#brand").html("");
                        	for(i=0;i<data.length;i++){
                        		$('<li><a href="javascript:;" onclick="selPro(\''+data[i].id+'\')">'+data[i].brandname+'</a> </li>').appendTo($("#brand"));
                        	}
                        	$("#brand_btn").removeAttr("disabled");	//解除
                    	}else{
                    		$("#brand_btn").attr("disabled","disabled");	//禁用 
                    		layer.tips('该机构下没有设置品牌', '#brand_btn', {tips: [1, '#FF9901'],time: 5000,});
                    	}
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert(jqXHR.responseText);
                    }
               	});
    		}else{
    			$("#brand_btn").attr("disabled","disabled");	//禁用 
    		}
			
    	}
    	
    	//选择商品
		function selPro(brandid){
			comp = $("#f_comp").val();
			parent.parent.layer.open({
			    type: 2,
			    title:'选择商品',
			    area: ['720px', '520px'],
			    fix: false, //不固定
			    maxmin: false,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/selProducts",
			    btn: ['确 定', '取 消'],
			    success:function(layero,index){
			    	var win = parent.window['layui-layer-iframe' + index].window;
			    	win.setData(comp,brandid);
			    },
			  	yes: function(index,layero){
			  		var win = parent.window['layui-layer-iframe' + index].window;
			  		var data = win.getData();
			  		if(data.length > 0){
			  			disposal(data);//处理数据，并加载
			  			parent.parent.layer.closeAll();	//关闭窗体
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
    		if(objArr.length > 0){
    			for(var i=0;i<data.length;i++){
    				var flag = true;
        			for(var j=0;j<objArr.length;j++){
        				if(data[i].id == objArr[j].id){
        					flag = false;
        				}
        			}
        			if(flag)
        				objArr.push(initializeObj(data[i]));
        		}
    		}else{
    			for(var i=0;i<data.length;i++){
        			objArr.push(initializeObj(data[i]));
        		}
    		}
    		
    		//加载数据
    		loadData();
    	}
    	
    	
    	//初始数据对象
    	function initializeObj(data){
    		var obj = {};
    		obj.id = data.id;
    		obj.brandname = data.brandname;
			obj.productname = data.productname;
			obj.productsize = data.productsize;
			obj.price = data.price;		//售价
			obj.price_txt = formatFloat(data.price,2);
			obj.buyerdis = data.buyerdis;	//折扣
			obj.quantity = data.quantity; 	//数量
			var _subtotal = 0;
			if(parseFloat(data.buyerdis) > 0){
				_subtotal = data.price * data.buyerdis * data.quantity;	//小计
			}else{
				_subtotal = data.price * data.quantity;	//小计
			}
			obj.subtotal = _subtotal;
			obj.subtotal_txt = formatFloat(_subtotal,2);
			total = parseFloat(total) + parseFloat(obj.subtotal);
			return obj;
    	}
    	
    	//绑定数量的TD
    	function bindTdClick() {
    		$('.quantity').unbind('click').click(function(){
    			var e = $(this);
    			var html = $(this).html();
    			if (html.indexOf("input") == -1) {
    				//$(this).html("<input type='text' class='input quant' value='"+html+"'/>");
    				//$(this).html("<input type='text' class='input quant' value='"+html+"'/>");
    				$(this).html("<input class='input quant' value='"+html+"' onkeyup='if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,\"\");this.value=this.value.replace(\".\",\"\");}else{this.value=this.value.replace(/\D/g,\"\");this.value=this.value.replace(\".\",\"\");}' onafterpaste='if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,\"\");this.value=this.value.replace(\".\",\"\");}else{this.value=this.value.replace(/\D/g,\"\");this.value=this.value.replace(\".\",\"\");}'>");
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
    							if(parseFloat(objArr[i].buyerdis) > 0){
    								objArr[i].subtotal = objArr[i].price * objArr[i].buyerdis * objArr[i].quantity;	//小计
    								objArr[i].subtotal_txt = formatFloat(objArr[i].price * objArr[i].buyerdis * objArr[i].quantity,2);	//小计输出
    							}else{
    								objArr[i].subtotal = objArr[i].price * objArr[i].quantity;	//小计
    								objArr[i].subtotal_txt = formatFloat(objArr[i].price * objArr[i].quantity,2);	//小计输出
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
    	
    	//选择收货地址
    	function selAddress(){
			parent.parent.layer.open({
			    type: 2,
			    title:'修改收货地址',
			    area: ['720px', '520px'],
			    fix: false, //不固定
			    maxmin: true,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/myaddress",
			    btn: ['确 定', '取 消'],
			  	yes: function(index,layero){
			  		var win = parent.window['layui-layer-iframe' + index].window;
			  		var data = win.getData();
			  		if(data.length > 0){
			  			var address = "收货人："+data[0].username+"，联系电话："+data[0].userphone+"，收货地址："+data[0].address;
			  			$("#address_id").val(data[0].id);
			  			$("#address").html(address);
			  			parent.parent.layer.closeAll();	//关闭窗体
			  		}else{
			  			parent.parent.layer.msg("请选择一个收货地址",{icon:6});
			  		}
			  	},
			    end: function(){
			    	//alert(123);
			    }
			});
		}
    	
    	//
    	function delRow(id){
    		var cf = "您确定要删除？";
			layer.confirm(cf, {title:'系统提示',icon:3,
				btn: ['确定','取消'] //按钮
			}, function(index){
				var objArr_tmp = new Array();
				for(var i=0;i<objArr.length;i++){
					if(objArr[i].id == id){
						objArr.splice(i,1);
						break;
					}
				}
				//重新计算价格
				total = 0;
				total_sum = 0;
				for(var i=0;i<objArr.length;i++){
					var subtotal = 0;
					if(parseFloat(objArr[i].buyerdis) > 0){
						subtotal = objArr[i].price * objArr[i].buyerdis * objArr[i].quantity;	//小计
					}else{
						subtotal = objArr[i].price * objArr[i].quantity;	//小计
					}
					total = parseFloat(total) + parseFloat(subtotal);
				}
				loadData();
   				layer.close(index);
			}, function(){
			});
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
			<div class="x3">
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
								<th width="45" align="center" id="p_del"></th>
								<th width="9%">品牌</th>
								<th width="*">商品名称</th>
								<th width="9%">规格</th>
								<th width="9%"><span id="p_quantity">数量</span></th>
								<th width="9%">单价</th>
								<th width="6%">折扣</th>
								<th width="10%">小计</th>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="text-right panel" style="padding: 30px 50px;border-top: solid 0">
					<div>共[<span id="total_num" style="color:red">0</span>]件商品。 合计：￥<span id="total" style="color:red">0.00</span></div>
					<br/>
					<div>应付总额：￥<span style="color: red !important" id="total_sum">0.00</span></div>
				</div>
				<div class="form-inline" style="padding-top: 30px;">
					<div class="form-group">
						<div class="label">
							<label for="username">收货信息：</label>
						</div>
						<div class="field"><button class="button button-little border-blue" onclick="selAddress()"><span class="icon-edit"></span></button>
							<input type="hidden" id="address_id" value="${address_id }"/>
							<label id="address">${address }</label>
						</div>
					</div>
				</div>
				<div class="padding-top">
					<button id="submit_btn" class="button bg-blue float-right">提交订单</button>
					<input type="text" name="exchangeamount" id="exchangeamount" value="0" size="5" style="ime-mode:disabled" onKeyUp="this.value=this.value.replace(/[^1-9]/g,'');this.value=this.value.replace('.','');" />
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
		<table class="table table-bordered table-hover text-small sel">
			<tbody>
				<tr class="panel-head">
					<th width="45" align="center" id="p_del"></th>
					<th width="50">序号</th>
					<th width="10%">品牌</th>
					<th width="*">商品名称</th>
					<th width="9%">规格</th>
					<th width="9%"><span id="p_quantity">数量</span></th>
					<th width="9%">单价</th>
					<th width="6%">折扣</th>
					<th width="10%">小计</th>
				</tr>
				{#foreach $T as row}
				<tr class="tr" id="{$T.row.id}">
					<td align="center"><a href="javascript:;" class="button-little icon-minus" onclick="delRow('{$T.row.id}')"> </a></td>
					<td align="center">{$T.row$index+1}</td>
					<td>{$T.row.brandname}</td>
					<td style="text-align: left;">{$T.row.productname}</td>
					<td>{$T.row.productsize}</td>
					<td class="quantity">{$T.row.quantity}</td>
					<td style="text-align: right;">￥{$T.row.price_txt}</td>
					<td>{$T.row.buyerdis}</td>
					<td style="text-align: right;">￥{$T.row.subtotal_txt}</td>
				</tr>
				{#/for}
			</tbody>
		</table>
	    -->
	</textarea>
</body>
</html>