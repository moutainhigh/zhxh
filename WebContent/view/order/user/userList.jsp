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
    <script src="${pageContext.request.contextPath}/js/js.validate.js" type="text/javascript"></script>
    
    <style type="text/css">
    	
    	/* .doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		} */
		/* .doc-header.fixed-top .doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		    background-color: #fff;
		} */
		.admin {
		    width: 100%;
		    padding: 20px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 87px;
		    overflow: auto;
		}
		
		.nav-inline li a {
			line-height: 22px;
		}
		
		/* .border-back {
    		border-color:#b5cfd9;
		} */
		/* .panel-back {
			background-color: #f7f7f7;
		} */
		
    </style>
    <script type="text/javascript">
    	var parentid = '${sessionScope.pc_user_sessiion.id}';
    	var pageIndex = 1;
    	var pageSize = 10;
    	var totalPage = 0;
    	
    	var rows = [];
    	
    	var searchmap = "";
    	var radio_value = "";
    	$(function(){
    		$("input[name=radio_user]:eq(0)").attr("checked",'checked');
    		radio_click();
    		$("input[name=radio_user]").click(function(){
    			$(this).val();
    			pageIndex = 1;
    			searchmap = "";
    			$("#searchTxt").val("");
    			radio_click();
  			});
    		//调用全选插件
    	    $.fn.check({ checkall_name: "checkall", checkbox_name: "row_id" });
    		
    	    $('#searchTxt').bind('keypress',function(event){
                if(event.keyCode == "13") {
                	searchUser();
                }
            });
    	    
    	});
    	
    	function bindTrClick() {
    		//除了表头（第一行）以外所有的行添加click事件.
            $("tr").first().nextAll().click(function (e) {
            	if (e.target.tagName == "TD") {
            		var firstInput = $(this).children("td:eq(0)").children("input:eq(0)");  // 第一个checkBox
                	firstInput.attr("checked",!firstInput.is(':checked'));
            	}
            });
    	}
    	
    	function pageSel() {
    		$('.pageSel').change(function(){ 
    			var p1=$(this).children('option:selected').val();//这就是selected的值
    			pageIndex = 1;
    			pageSize = p1;
    			radio_click();
    		}) 
    	}
    	
    	//绑定数量的TD
    	function bindTdClick() {
    		$('.table td').unbind('click').click(function(){
    			var e = $(this);
    			var html = $(this).html();
    			if (html.indexOf("input") == -1) {
    				$(this).html("<input type='text' class='input input-small quant' value='"+html+"'/>");
    				$(".quant").focus();
    				$(".quant").select();
    				$(".quant").blur(function(){
    					var val = $(this).val();
    					/* if(!(/^(\+|-)?\d+$/.test(val)) || val == 0){  
    				        val = 1; //非正整数为1
    				    } */
    					e.html(val);
    					/* var id = $(e).parent("tr").attr("id");	//当前行ID
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
    					} */
    					//重新加载数据
    					//loadData();
    				})
    			}
    		})
    	}
    	
    	function pageEnter() {
    		$('.ui-pager-inp').bind('keypress',function(event) {
                if(event.keyCode == "13") {
                	if (isInteger($(this).val())) {
                		if ($(this).val() > totalPage || $(this).val() < 1 || $(this).val() == pageIndex) {
                			return false;
                		}
                		else {
                			pageIndex = $(this).val();
                    		radio_click();
                		}
                	}
                	else {
                		
                	}
                    return false;
                }
            });
    	}
    	
    	function pageClick(sel_page) {
    		pageIndex = sel_page;
    		radio_click();
    	}
    	
    	function td_tip(e) {
    		//'#td_state'
    		var msg = "";
    		var color = "#3595CC";
    		var v = $(e).attr("v");
    		if (e.id == "td_state") {
    			if (v == "1") {
    				msg = "状态为[正常]，客户可以登录本系统并进行充值、采购等操作。";
    			}
    			else {
    				msg = "状态为[禁用]，[禁用]后客户将不能登录本系统。";
    				color = "#EE7942";
    			}
    		}
    		else if (e.id == "td_setreturn") {
    			if (v == "1") {
    				msg = "状态为[正常]，允许客户享受采购折扣、返利、奖励等利益分配。";
    			}
    			else {
    				msg = "状态为[禁用]，[禁用]后客户将不享受采购折扣、返利、奖励等利益分配。";
    				color = "#EE7942";
    			}
    		}
    	    layer.tips(msg, e, {
    	    	tips: [1, color]
	    	    //time: 2000
	    	});
    	}
    	
    	function radio_click() {
    		radio_value = $("input[name='radio_user']:checked").val();
    		
    		var par = {};
    		par.parentid = parentid;
    		par.identity = radio_value;
    		par.pageIndex = pageIndex-1;
    		par.pageSize = pageSize;
    		
    		if (searchmap != "") {
    			par.mapObj = JSON.stringify(searchmap);
    		}
    		
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUser/list.htmls",
                data: par,
                //data: {'parentid':parentid,identity:radio_value,pageIndex:pageIndex-1,pageSize:pageSize},
                type: "post",
                dataType:"json",
                success: function (json) {
                	rows = json.data;
                 	totalPage = Math.ceil(json.total/pageSize);
                 	//totalPage = ((json.total%pageSize==0)?(json.total/pageSize):(json.total/pageSize+1));   
               	 	$(".admin-panel").setTemplateElement("Template-List-user-show");
	         		$(".admin-panel").setParam('rowCount', json.total);
	         		$(".admin-panel").setParam('pageSize', pageSize);
	         		$(".admin-panel").setParam('pageIndex', pageIndex);
	         		$(".admin-panel").setParam('radio_value', radio_value);
	         		$(".admin-panel").setParam('totalPage', totalPage);
	         		$(".admin-panel").setParam('parentid', parentid);
	         		//$("#admin-panel").setParam('docAuthArr', docAuthArr);
	                $(".admin-panel").processTemplate(json.data);
	                
	                //bindTdClick();
	                pageSel();
	                pageEnter();
	                bindTrClick();
	              	//调用全选插件
	        	    $.fn.check({ checkall_name: "checkall", checkbox_name: "row_id" });
	              	
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
    	
    	function searchUser() {
    		var key = $("#searchTxt").val();
    		pageIndex = 1;
    		
    		if (key != "") {
    			searchmap = {};
                searchmap.username = key;
                searchmap.phonenumber = key;
                if (radio_value != "Z") {
                	searchmap.companyname = key;
                    searchmap.companypath = key;
                }
            }
            else {
            	searchmap = "";
            }
			radio_click();
			
    	}
    	
    	function addUser() {
    		
    		var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	   		
    		layer.open({
			    type: 2,
			    title:'新建客户',
			    area: ['700px', (pHeight-100) +'px'],
			    fix: false, //不固定
			    maxmin: false,
			    scrollbar:false,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/addUser",
			    success: function(layero, index){
			    	/* var win = parent.window['layui-layer-iframe' + index].window;
			    	var data = {};
			    	data.identity = "Z";
			    	win.setData(data); */
			    },
			    btn: ['保存', '取消'],
			  	yes: function(index,layero){
			  		var win = window['layui-layer-iframe' + index].window;
			  		var row = win.getData();
			  		
			  		if (row == false) {
			  			return;
			  		}
			  		else {
			  			row.identity = radio_value;
			  			row._state = 'added';
			  			if (row.identity != "Z") {
			  				row.companycode = row.phonenumber;
			  			}
			  			var rowArr = [];
			  			rowArr.push(row);
			  			var json = JSON.stringify(rowArr);
			  			$.ajax({
			    			async:false,
			                url: "${pageContext.request.contextPath}/orderUser/save.htmls",
			                data: {'objs':json},
			                type: "post",
			                dataType:"text",
			                success: function (text) {
			                 	if (text == 'success') {
			                 		layer.msg("保存成功。",{icon:6});
			                 		radio_click();
			                 	}
			                 	else if (text == "codeerror") {
			                 		layer.msg("手机短信验证码错误，请输入正确，再尝试，或与开发商联系。",{icon:5});
			                 	}
			                 	else {
			                 		layer.msg("保存出现问题，请退出重新登录，再尝试，或与开发商联系。",{icon:5});
			                 	}
			                },
			                error: function (jqXHR, textStatus, errorThrown) {
			                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
			                }
			           });
			  		}
			  	},
			  	btn2: function(){
			    	layer.closeAll();
			  	},
			    end: function(){
			    	//alert(123);
			    }
			});
    	}
    	function updateUser(userid) {
    		var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	   		
	   		var updateRow = "";
	   		for (var i=0;i<rows.length;i++) {
	   			if (rows[i].id == userid) {
	   				updateRow = rows[i];
	   				break;
	   			}
	   		}
	   		
	   		if (updateRow == "") {
	   			layer.msg("未找到要修改的记录，请重新登录再次尝试或与管理员联系。",{icon:5});
	   			return false;
	   		}
	   		
    		layer.open({
			    type: 2,
			    title:'修改客户',
			    area: ['700px', (pHeight-100) +'px'],
			    fix: false, //不固定
			    maxmin: false,
			    scrollbar:false,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/updateUser",
			    success: function(layero, index){
			    	var win = window['layui-layer-iframe' + index].window;
			    	var data = [];
			    	data.updateRow = updateRow;
			    	data.updatePhone = 0;
			    	win.setData(data);
			    },
			    btn: ['保存', '取消'],
			  	yes: function(index,layero){
			  		var win = window['layui-layer-iframe' + index].window;
			  		var row = win.getData();
			  		
			  		if (row == false) {
			  			return;
			  		}
			  		//询问框
			  		layer.confirm('确定要修改客户信息吗？', {
			  			btn: ['确认', '取消']
			  		}, 
			  		function()	{
			  			row._state = 'modified';
			  			row.updatePhone = "0";
			  			if (row.identity != "Z") {
			  				row.companycode = row.phonenumber;
			  			}
			  			var rowArr = [];
			  			rowArr.push(row);
			  			var json = JSON.stringify(rowArr);
			  			$.ajax({
			    			async:false,
			                url: "${pageContext.request.contextPath}/orderUser/save.htmls",
			                data: {'objs':json},
			                type: "post",
			                dataType:"text",
			                success: function (text) {
			                 	if (text == 'success') {
			                 		layer.msg("保存成功。",{icon:6});
			                 		radio_click();
			                 	}
			                 	else if (text == "codeerror") {
			                 		layer.msg("手机短信验证码错误，请输入正确，再尝试，或与开发商联系。",{icon:5});
			                 	}
			                 	else {
			                 		layer.msg("保存出现问题，请退出重新登录，再尝试，或与开发商联系。",{icon:5});
			                 	}
			                },
			                error: function (jqXHR, textStatus, errorThrown) {
			                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
			                }
			           });
			  		}, 
			  		function(){
			  			
			  		});
			  		
			  	},
			  	btn2: function(){
			    	layer.closeAll();
			  	},
			    end: function(){
			    	//alert(123);
			    }
			});
    		return false;
    	}
    	
    	function updatebatch(v,t) {
    		var sel_userid = "";
			$('input:checkbox[name=row_id]:checked').each(function(i) {
				if(0==i){
					sel_userid = $(this).val();
			 	}else{
			 		sel_userid += (","+$(this).val());
			    }
			});
			if (sel_userid == "") {
				layer.msg("请先选择要批量操作的客户",{icon:6});
				return;
			}
			
			var txt = "正常";
    		if (v == 0) {
    			txt = "禁用";
    		}
    		
    		var updatefield = t;
    		var cf = "状态为[";
    		if (t == "setreturn") {
    			cf = "接收分成为[";
    		}
    		
    		layer.confirm('确定要批量修改选中客户的'+cf+txt+']吗？', {
	  			btn: ['确认', '取消']
	  		}, 
	  		function()	{
	  			$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderUser/updateBatch.htmls",
	                data: {'updateUserids':sel_userid,'field':t,'fieldValue':v},
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                 	if (text == 'success') {
	                 		layer.msg("保存成功。",{icon:6});
	                 		radio_click();
	                 	}
	                 	else {
	                 		layer.msg("保存出现问题，请退出重新登录，再尝试，或与开发商联系。",{icon:5});
	                 	}
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
	                }
	           });
	  		}, 
	  		function(){
	  			
	  		});
    		
    	}
    	
    	function delbatch() {
    		var sel_userid = "";
			$('input:checkbox[name=row_id]:checked').each(function(i) {
				if (1 != $(this).val()) {
					if(0==i){
						sel_userid = $(this).val();
				 	}else{
				 		sel_userid += (","+$(this).val());
				    }
				}
			});
			if (sel_userid == "") {
				layer.msg("请先选择要批量操作的客户",{icon:6});
				return;
			}
			
    		layer.confirm('确定要批量删除选中的客户吗？', {
	  			btn: ['确认', '取消']
	  		}, 
	  		function()	{
	  			$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderUser/delBatch.htmls",
	                data: {'delUserids':sel_userid},
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                 	if (text == 'success') {
	                 		layer.msg("保存成功。",{icon:6});
	                 		radio_click();
	                 	}
	                 	else {
	                 		layer.msg("保存出现问题，请退出重新登录，再尝试，或与开发商联系。",{icon:5});
	                 	}
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
	                }
	           });
	  		}, 
	  		function(){
	  			
	  		});
    		
    	}
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px;">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >客户列表</a></li>
		</ul>
		<div class="admin" style="padding: 20px 60px;">
			<form onsubmit="return false;" class="form-x" method="post">
				<div class="form-group float-right" style="width:430px">
					<c:choose>
	    				<c:when test="${sessionScope.pc_user_sessiion.id == '1' }">
	    					<input name="radio_user" type="radio" value="A"> 代理
	    					<input name="radio_user" type="radio" value="C"> 门店
	    				</c:when>
	    				<c:when test="${sessionScope.pc_user_sessiion.identity == 'A' }">
	    					<input name="radio_user" type="radio" value="C"> 门店
	    					<!-- <input name="radio_user" type="radio"> 普通会员  -->
	    				</c:when>
	    				<c:otherwise>
	    					<!-- <input name="radio_user" type="radio" checked> 普通会员 -->
	    				</c:otherwise>
	    			</c:choose>
					<!-- <input name="radio_user" type="radio" checked> 代理
					<input name="radio_user" type="radio"> 门店
					<input name="radio_user" type="radio"> 普通会员 -->
					<input name="radio_user" type="radio" value="Z"> 普通会员 
					<input type="text" id="searchTxt" name="searchTxt" class="input input-auto" style="width:120px;margin-left: 20px"/>
					<a id="searchBtn" href="javascript:;" class="button bg-main button-small" onclick="searchUser()">检索</a>
					<a id="addUser" href="javascript:;" onclick="addUser()" style="margin-left: 5px" class="button bg-blue">新建</a>
				</div>
			</form>
			<form method="post" >
				<div class="admin-panel">
				</div>
			</form>		
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
				<tr class="panel-head item">
					<th width="45" align="center"><input type="checkbox" value="1" name="checkall"></th>
					<th width="45">序号</th>
					<th width="80">姓名</th>
					<th width="100">手机号码</th>
					<th width="80">生日</th>
					<th width="50">性别</th>
					<th width="60">身份</th>
					{#if $P.radio_value == 'A' || $P.radio_value == 'C'}
					<th width="200">客户名称</th>
					<th width="200">客户地址</th>
					<th width="100">客户代码</th>
					<th width="120">客户级别</th>
					<th width="80">接收分成</th>
					{#elseif $P.radio_value == 'Z'}
					<th width="100">所属机构代码</th>
					{#/if}
					<th width="80">微信号码</th>
					<th width="50">状态</th>
					<th width="50">排序</th>
					<th width="100">操作</th>
				</tr>
				{#if $P.rowCount > 0}
					{#foreach $T as row}
						<tr class="tr">
							<td align="center"><input type="checkbox" value="{$T.row.id}" name="row_id"></td>
							<td>{($T.row$index+1)+($P.pageIndex * $P.pageSize - $P.pageSize)}</td>
							<td>{$T.row.username}</td>
							<td>{$T.row.phonenumber}</td>
							<td>{$T.row.birthday}</td>
							<td>{#if $T.row.sex == 1}男{#else}女{#/if}</td>
							<td>{$T.row.identitymemo}</td>
							{#if $P.radio_value == 'A' || $P.radio_value == 'C'}
							<td>{$T.row.companyname}</td>
							<td>{$T.row.companypath}</td>
							<td>{$T.row.companycode}</td>
							<td>{$T.row.rank}</td>
							<td id="td_setreturn" v="{$T.row.setreturn}" onmouseover="td_tip(this)">{#if $T.row.setreturn == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
							{#elseif $P.radio_value == 'Z'}
							<td>{$T.row.belongcode}</td>
							{#/if}
							<td>{$T.row.wechar}</td>
							<td id="td_state" v="{$T.row.isopen}" onmouseover="td_tip(this)">{#if $T.row.isopen == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
							<td>{$T.row.sort}</td>
							<td><button class="button button-small border-sub" onclick="return updateUser('{$T.row.id}')">修改</button></td>
						</tr>
					{#/for}
				{#else}
					<tr class="tr" style="height:150px;">
						<td align="center" colspan="15">还没有数据...</td>
					</tr>
				{#/if}
				
			</tbody>
			<tfoot class="tfoot">
				<tr class="">
					{#if $P.parentid == "1"}
					<td align="center"><input type="checkbox" value="0" name="checkall"></td>
					<td colspan="6" class="tr pr10" style="text-align:left" >
						<a class="batch-op batchActivate" href="javascript:void(0)" onclick="updatebatch(1,'isopen')">批量开通</a>
						<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="updatebatch(0,'isopen')">批量禁用</a>
						{#if $P.radio_value == 'A' || $P.radio_value == 'C'} | 
						<a class="batch-op batchActivate" href="javascript:void(0)" onclick="updatebatch(1,'setreturn')">批量接收分成</a>
						<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="updatebatch(0,'setreturn')">批量禁用接收分成</a> | 
						{#/if}
						<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="delbatch()">批量删除</a>
					</td>
					{#else}
					
					{#/if}
					<td colspan="9" style="text-align:right" >
						<div class="page">
							<span>每页显示</span>
							<select class="pageSel">
								<option {#if $P.pageSize == 10}selected{#/if}  value="10">10</option>
								<option {#if $P.pageSize == 50}selected{#/if}  value="50">50</option>
								<option {#if $P.pageSize == 100}selected{#/if}  value="100">100</option>
							</select>
							<span>条</span>
							<div class="page-number">
								<span>第</span>
								<input class="ui-pager-inp" type="text" value="{$P.pageIndex}"> 
								<span>页</span>
								<span>共</span>
								<span class="totalPage">{$P.totalPage}</span>
								<span>页</span>
								<div class="pn">
								{#if $P.pageIndex == 1}
									<a href="javascript:void(0);" class="ui-pager-prev">上一页</a>
								{#else}
									<a href="javascript:void(0);" class="ui-pager-prev" onclick="pageClick({$P.pageIndex-1})">上一页</a>
								{#/if}
								{#if $P.pageIndex == $P.totalPage || $P.totalPage == 0}
									<a href="javascript:void(0);" class="ui-pager-next">下一页</a>
								{#else}
									<a href="javascript:void(0);" class="ui-pager-next" onclick="pageClick({$P.pageIndex + 1 })">下一页</a>
								{#/if}
								</div>
							</div>
						</div>
						<span class="page-total">共计：[{$P.rowCount}] 条</span>
					</td>
				</tr>
			</tfoot>
		</table>
	    -->
	</textarea>
	<!-- <td align="center"><input type="checkbox" value="0" name="checkall"></td>
	<td colspan="6" class="tr pr10" style="text-align:left" >
		<a class="batch-op batchActivate" href="javascript:void(0)" onclick="updatebatch(1,'isopen')">批量开通</a>
		<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="updatebatch(0,'isopen')">批量禁用</a>
		{#if $P.radio_value == 'A' || $P.radio_value == 'C'} | 
		<a class="batch-op batchActivate" href="javascript:void(0)" onclick="updatebatch(1,'setreturn')">批量接收分成</a>
		<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="updatebatch(0,'setreturn')">批量禁用接收分成</a> | 
		{#/if}
		<a class="batch-op batchInactivate" href="javascript:void(0)" onclick="delbatch()">批量删除</a>
	</td> -->
</body>
</html>