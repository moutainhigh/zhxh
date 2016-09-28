<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/view/order/css/table.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    
    <script src="${pageContext.request.contextPath}/js/jquery-jtemplates.js"></script>
    <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/js.validate.js" type="text/javascript"></script>
    
    <style type="text/css">
	    .admin {
		    width: 100%;
		    padding: 20px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 87px;
		    overflow: auto;
		}
		.input {
    		font-size: 12px;
    	}
		
    </style>
    
    <script type="text/javascript">
    
	    var parentid = "";
    	
    	var rows;
    
    	$(function(){
    	})
    	
    	function setData(data) {
    		parentid = data.parentid;
    		loadData();
    	}
    	
    	function loadData() {
    		var par = {};
    		par.parentid = parentid;
    		
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserDis/listSelectUserC.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	rows = json.data;
               	 	$(".admin-panel").setTemplateElement("Template-List-user");
               	 	$(".admin-panel").setParam('rowCount', json.total);
	                $(".admin-panel").processTemplate(json.data);
	                
	                bindTrClick();
	              	//调用全选插件
	              	$.fn.check({ checkall_name: "checkall", checkbox_name: "row_id" });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
    	
    	//外部获取数据。这里是序列化form表单
    	function getData() {
    		var result = [];
    		var sel_ids = "";
   			$('.table input:checkbox[name=row_id]:checked').each(function(i) {
   				if(0==i){
   					sel_ids = $(this).val();
   			 	}else{
   			 		sel_ids += (","+$(this).val());
   			    }
   			});
    		
    		return sel_ids;
    	}
    	
    	function bindTrClick() {
    		//除了表头（第一行）以外所有的行添加click事件.
            $("tr").first().nextAll().click(function (e) {
            	if (e.target.tagName == "TD") {
            		var firstInput = $(this).children("td:eq(0)").children("input:eq(0)");  // 第一个checkBox
                	firstInput.attr("checked",!firstInput.is(':checked'));
            	}
            });
    	}
    </script>
</head>
<body>
	<div class="layout" style="margin-bottom: 50px;">
		<div class="admin" style="padding: 20px 60px;">
			<div class="admin-panel">
			</div>
		</div>
	</div>
	<textarea id="Template-List-user" rows="0" cols="0" style="display:none">
		<!--
		<script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
		<table class="table table-bordered table-hover text-small">
			<tbody>
				<tr class="panel-head item">
					<th width="45" align="center">
						<input type="checkbox" value="1" name="checkall">
					</th>
					<th width="45">序号</th>
					<th width="80">姓名</th>
					<th width="100">手机号码</th>
					<th width="80">生日</th>
					<th width="50">性别</th>
					<th width="60">身份</th>
					<th width="200">客户名称</th>
					<th width="200">客户地址</th>
					<th width="100">客户代码</th>
					<th width="120">客户级别</th>
					<th width="200">推荐人</th>
					<th width="80">微信号码</th>
					<th width="50">状态</th>
					<th width="50">排序</th>
				</tr>
				{#if $P.rowCount > 0}
					{#foreach $T as row}
						<tr class="tr">
							<td align="center">
								<input type="checkbox" value="{$T.row.id}" name="row_id">
							</td>
							<td>{$T.row$index+1}</td>
							<td>{$T.row.username}</td>
							<td>{$T.row.phonenumber}</td>
							<td>{$T.row.birthday}</td>
							<td>{#if $T.row.sex == 1}男{#else}女{#/if}</td>
							<td>{$T.row.identitymemo}</td>
							<td>{$T.row.companyname}</td>
							<td>{$T.row.companypath}</td>
							<td>{$T.row.companycode}</td>
							<td>{$T.row.rank}</td>
							<td>{$T.row.tuijianman}</td>
							<td>{$T.row.wechar}</td>
							<td id="td_state" v="{$T.row.isopen}">{#if $T.row.isopen == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
							<td>{$T.row.sort}</td>
						</tr>
					{#/for}
				{#else}
					<tr class="tr" style="height:150px;">
						<td align="center" colspan="15">还没有数据...</td>
					</tr>
				{#/if}
				
			</tbody>
		</table>
	    -->
	</textarea>
	<script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>
</body>
</html>