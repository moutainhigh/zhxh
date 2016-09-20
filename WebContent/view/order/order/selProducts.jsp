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
    	$(function(){
    		//品牌对应的商品
    		prolist();
    		
    	});
    	
    	
    	//品牌-商品列表
    	function prolist(){
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/order/prolist.htmls",
                data: {parentid:'${parentid}',brandid:'${brandid}',pageIndex:0,pageSize:30},
                type: "post",
                dataType:"json",
                success: function (json) {
                	objs = json;
               	 	$("#orderList").setTemplateElement("Template-List-user-show");
	                $("#orderList").processTemplate(json.data);
	             	 //调用全选插件
	                $.fn.check({ checkall_name: "checkall", checkbox_name: "id" })
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           });
    	}
    	
    	function getData(){
    		var objArr = new Array();
    		$("input[name='id']").each(function(index,element){
       	    	if(element.checked==true){
       	        	id = element.value;
       	        	var tr = $('#'+id);
       	        	var tds = $(tr).find("td");
       	        	var _obj = {};
       	        	_obj.id = id;
       	        	_obj.productname = $.trim($(tds[1]).text());
       	        	_obj.productsize = $.trim($(tds[2]).text());
       	        	_obj.price = $.trim($(tds[3]).text());
       	        	_obj.buyerdis = $.trim($(tds[4]).text());
       	        	_obj.quantity = 1;
       	        	objArr.push(_obj);
       	        	/* for(i=0;i<tds.length;i++){
       	        		alert($.trim($(tds[i]).text()));
       	        	} */
       	        }
       	    });
    		return objArr;
    	}
    </script>
</head>
<body>
	<!--内容-->
	<div class="admin">
		<div style="padding-bottom: 20px;">
			<table style="text-align: center;"><tr>
				<td width="200px;"><input type="text" class="input" name="" placeholder="请输入商品名称" /></td>
				<td width="100px;"><button class="button" id="newOrder"><span class="icon-search"></span> 搜索</button></td>
			</tr></table>
		</div>
		<!-- <div class="padding float-right">
			<button class="button bg-blue" id="newOrder"><span class="icon-plus"></span> 新增</button>
		</div> -->
		<div id="orderList" class="admin-panel">
			<table class="table table-bordered table-hover text-small">
				<tbody>
					<tr class="panel-head">
						<th width="45" align="center"><input type="checkbox"></th>
						<th width="*">商品名称</th>
						<th width="100">规格</th>
						<th width="100">单价</th>
						<th width="100">折扣</th>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<textarea id="Template-List-user-show" rows="0" cols="0" style="display:none">
		<!--
		<table class="table table-bordered table-hover text-small">
			<tbody>
				<tr class="panel-head">
					<th width="45" align="center"><input type="checkbox" name="checkall"></th>
					<th width="80">商品名称</th>
					<th width="100">规格</th>
					<th width="50">单价</th>
					<th width="50">折扣</th>
				</tr>
				{#foreach $T as row}
				<tr class="tr" id="{$T.row.id}">
					<td align="center"><input type="checkbox" value="{$T.row.id}" name="id"></td>
					<td>{$T.row.productname}</td>
					<td>{$T.row.productsize}</td>
					<td>{$T.row.price}</td>
					<td>{$T.row.buyerdis}</td>
				</tr>
				{#/for}
			</tbody>
		</table>
	    -->
	</textarea>
</body>
</html>