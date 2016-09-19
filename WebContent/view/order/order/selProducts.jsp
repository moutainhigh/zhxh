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
    
    <style type="text/css">
		.admin {
		    padding: 30px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 0px;
		    left: 0px;
		    overflow: auto;
		    width: 100%;
    	}
    	.table th{text-align: center}
    </style>
    <script type="text/javascript">
    	$(function(){
    		//品牌
    		brand();
    		//品牌对应的商品
    		$("#brand").change(function(){
    			prolist($(this).val());
    		});
    		
    	});
    	
    	//品牌
    	function brand(){
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/order/brandlist.htmls",
                data: {parentid:'${parentid}'},
                type: "post",
                dataType:"json",
                success: function (json) {
                	var data = json.data;
                	for(i=0;i<data.length;i++){
                		$("<option></option>").val(data[i].id).text(data[i].brandname).appendTo($("#brand"));
                	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           	});
    	}
    	
    	//品牌-商品列表
    	function prolist(brandid){
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/order/prolist.htmls",
                data: {parentid:'${parentid}',brandid:brandid,pageIndex:0,pageSize:30},
                type: "post",
                dataType:"json",
                success: function (json) {
               	 	$("#orderList").setTemplateElement("Template-List-user-show");
	                $("#orderList").processTemplate(json.data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           });
    	}
    </script>
</head>
<body>
	<!--内容-->
	<div class="admin">
		<div class="padding float-left">
			<table><tr>
				<td>品牌：</td>
				<td> 
					<select class="input" id="brand">
	                	 <option value="0">请选择</option>
	                </select>
                </td>
			</tr></table>
		</div>
		<!-- <div class="padding float-right">
			<button class="button bg-blue" id="newOrder"><span class="icon-plus"></span> 新增</button>
		</div> -->
		<div id="orderList" class="admin-panel">
			<table class="table table-bordered table-hover text-small">
				<tbody>
					<tr class="panel-head">
						<th width="45" align="center"><input type="checkbox" value="1" name="id"></th>
						<th width="*">商品名称</th>
						<th width="100">规格</th>
						<th width="100">单价</th>
						<th width="100">折扣</th>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="padding float-right">
			<button class="button bg-blue" id="newOrder"><span class="icon-plus"></span> 新增</button>
		</div>
	</div>
	<div style="height: 200000px;">sdfsdf</div>
	<textarea id="Template-List-user-show" rows="0" cols="0" style="display:none">
		<!--
		<table class="table table-bordered table-hover text-small">
			<tbody>
				<tr class="panel-head">
					<th width="45" align="center"><input type="checkbox" value="1" name="id"></th>
					<th width="80">商品名称</th>
					<th width="100">规格</th>
					<th width="50">单价</th>
					<th width="50">折扣</th>
				</tr>
				{#foreach $T as row}
				<tr class="tr">
					<td align="center"><input type="checkbox" value="1" name="id"></td>
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