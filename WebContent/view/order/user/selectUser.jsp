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
		var identity = ""
		var searchmap = "";
		var checktype = "";
		
		var pageIndex = 1;
    	var pageSize = 10;
    	var totalPage = 0;
    	
    	var rows;
    
    	$(function(){
    		
    		$('#searchTxt').bind('keypress',function(event){
                if(event.keyCode == "13") {
                	searchUser();
                }
            });
    	})
    	
    	function setData(data) {
    		parentid = data.parentid;
    		identity = data.identity;
    		pageSize = data.pageSize;
    		checktype = data.checktype;
    		
    		loadData();
    	}
    	
    	function loadData() {
    		var par = {};
    		par.parentid = parentid;
    		par.identity = identity;
    		par.pageIndex = pageIndex-1;
    		par.pageSize = pageSize;
    		
    		if (searchmap != "") {
    			par.mapObj = JSON.stringify(searchmap);
    		}
    		
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUser/list.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	rows = json.data;
                 	totalPage = Math.ceil(json.total/pageSize);
               	 	$(".admin-panel").setTemplateElement("Template-List-user");
	         		$(".admin-panel").setParam('rowCount', json.total);
	         		$(".admin-panel").setParam('pageSize', pageSize);
	         		$(".admin-panel").setParam('pageIndex', pageIndex);
	         		$(".admin-panel").setParam('radio_value', identity);
	         		$(".admin-panel").setParam('totalPage', totalPage);
	         		$(".admin-panel").setParam('checktype', checktype);
	                $(".admin-panel").processTemplate(json.data);
	                
	                //bindTdClick();
	                pageSel();
	                pageEnter();
	                bindTrClick();
	              	//调用全选插件
	              	if (checktype == "checkbox") {
	              		$.fn.check({ checkall_name: "checkall", checkbox_name: "row_id" });
	              	}
	              	
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
    		if (checktype == "checkbox") {
    			$('.table input:checkbox[name=row_id]:checked').each(function(i) {
    				if(0==i){
    					sel_ids = $(this).val();
    			 	}else{
    			 		sel_ids += (","+$(this).val());
    			    }
    			});
    		}
    		else {
    			sel_ids = $('.table input[name="row_id"]:checked ').val();
    		}
    		var sel_arr = sel_ids.split(",");
    		for(var i=0;i<rows.length;i++) {
    			for(var j=0;j<sel_arr.length;j++) {
    				if (sel_arr[j] == rows[i].id) {
    					result.push(rows[i]);
    				}
    			}
    		}
    		return result;
    	}
    	
    	function pageSel() {
    		$('.pageSel').change(function(){ 
    			var p1=$(this).children('option:selected').val();//这就是selected的值
    			pageIndex = 1;
    			pageSize = p1;
    			loadData();
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
                			loadData();
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
    		loadData();
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
    	
    	function searchUser() {
    		var key = $("#searchTxt").val();
    		pageIndex = 1;
    		
    		if (key != "") {
    			searchmap = {};
                searchmap.username = key;
                searchmap.phonenumber = key;
                if (identity != "Z") {
                	searchmap.companyname = key;
                    searchmap.companypath = key;
                }
            }
            else {
            	searchmap = "";
            }
    		loadData();
			
    	}
    	
    </script>
</head>
<body>
	<div class="layout" style="margin-bottom: 50px;">
		<div class="admin" style="padding: 20px 60px;">
			<form onsubmit="return false;" class="form-x" method="post">
				<div class="form-group float-right" style="width:200px">
					<input type="text" id="searchTxt" name="searchTxt" class="input input-auto" style="width:120px;margin-left: 20px"/>
					<a id="searchBtn" href="javascript:;" class="button bg-main button-small" onclick="searchUser()">检索</a>
				</div>
			</form>
			<form method="post" >
				<div class="admin-panel">
				</div>
			</form>		
		</div>
	</div>
	<textarea id="Template-List-user" rows="0" cols="0" style="display:none">
		<!--
		<script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
		<table class="table table-bordered table-hover text-small">
			<tbody>
				<tr class="panel-head item">
					<th width="45" align="center">
						{#if $P.checktype == "checkbox"}
						<input type="checkbox" value="1" name="checkall">
						{#/if}
					</th>
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
					{#if $P.radio_value == "C"}
					<th width="200">推荐人</th>
					{#/if}
					<th width="80">微信号码</th>
					<th width="50">状态</th>
					<th width="50">排序</th>
				</tr>
				{#if $P.rowCount > 0}
					{#foreach $T as row}
						<tr class="tr">
							<td align="center">
								{#if $P.checktype == "checkbox"}
								<input type="checkbox" value="{$T.row.id}" name="row_id">
								{#else}
								<input type="radio" value="{$T.row.id}" name="row_id">
								{#/if}
							</td>
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
							<td id="td_setreturn" v="{$T.row.setreturn}">{#if $T.row.setreturn == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
							{#elseif $P.radio_value == 'Z'}
							<td>{$T.row.belongcode}</td>
							{#/if}
							{#if $P.radio_value == "C"}
							<td>{$T.row.tuijianman}</td>
							{#/if}
							<td>{$T.row.wechar}</td>
							<td id="td_state" v="{$T.row.isopen}">{#if $T.row.isopen == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
							<td>{$T.row.sort}</td>
						</tr>
					{#/for}
				{#else}
					<tr class="tr" style="height:150px;">
						<td align="center" colspan="{#if $P.radio_value == 'A'}15{#elseif $P.radio_value == 'C'}16{#else}11{#/if}">还没有数据...</td>
					</tr>
				{#/if}
				
			</tbody>
		</table>
		<table class="table table-bordered table-hover text-small" style="border: solid 0px #ddd;">
			<tfoot>
			<tr class="">
				<td style="text-align:right" >
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
	<script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>
</body>
</html>