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
    	
    	.doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		}
		.doc-header.fixed-top .doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		    background-color: #fff;
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
		
		.nav-inline li a {
			line-height: 22px;
		}
		
		.border-back {
    		border-color:#b5cfd9;
		}
		/* .panel-back {
			background-color: #f7f7f7;
		} */
		.table th{text-align: center}
		
		.table-bordered th {
		    border-bottom: 0px solid #ddd;
		}
		
		.table tr {
			height:45px;
		}
		.table th ,.table tbody td {
			vertical-align: middle;
			padding: 1px 5px;
			text-align: center;
		}
		
		tfoot {
		    display: table-footer-group;
		    vertical-align: middle;
		    border-color: inherit;
		}
		.table tfoot td {
			vertical-align: middle;
		    height: 66px;
		    border-top: 1px solid #dce2e7;
		    border: solid 0px #ddd;
		}
		
		.page {
		    float: right;
		    display: inline-block;
		    vertical-align: middle;
		    width: 350px;
		    line-height: 26px;
		    margin: 10px;
		}
		

		.page-total {
		    float: left;
		    line-height: 26px;
		    margin: 10px 10px 0;
		    display: block;
		    float: right;
		}
		.page span {
		    float: left;
		    margin-left: 5px;
		}
		
		.page .pageSel {
		    float: left;
		    display: block;
		    color: #666;
		    margin: 0 0 0 10px;
		    border: 1px solid #d6dee3;
		    padding: 4px;
		    font-size: 12px;
		    height: 26px;
		}
		.page-number {
		    margin-left: 130px;
		}
		
		.page .pn {
		    float: right;
		}
		.page .pn, .page .pn a {
		    margin-left: 5px;
		}
		
		.page .ui-pager-next, .page .ui-pager-prev {
		    margin-left: 5px;
		}

		.ui-pager-next, .ui-pager-prev {
		    background: url(${pageContext.request.contextPath}/view/order/images/icon8.png) no-repeat;
		    display: inline-block;
		    width: 25px;
		    height: 0;
		    padding-top: 25px;
		    overflow: hidden;
		    cursor: pointer;
		}
		
		.ui-pager-next {
		    background-color: #fafafa;
		    border: 1px solid #c7ced1;
		    background-position: 10px -51px;
		}
		.ui-pager-prev {
		    background-color: #fafafa;
		    border: 1px solid #c7ced1;
		    background-position: 9px -34px;
		}
		
		.ui-pager-inp {
		    padding: 0 5px;
		    height: 25px;
		    line-height: 25px;
		    border: 1px solid #d6dee3;
		    color: #555;
		    width: 30px;
		    display: inline-block;
		    float: left;
		    vertical-align: middle;
		    outline: 0;
		    font-family: verdana,'宋体','Microsoft Yahei',Tahoma,Arial;
		    margin-left: 5px;
		    font-size: 12px;
		}
		
    </style>
    <script type="text/javascript">
    	var parentid = '${sessionScope.pc_user_sessiion.id}';
    	var pageIndex = 1;
    	var pageSize = 2;
    	var totalPage = 0;
    	$(function(){
    		$("input[name=radio_user]:eq(0)").attr("checked",'checked');
    		radio_click();
    		$("input[name=radio_user]").click(function(){
    			$(this).val();
    			radio_click();
  			});
    		
    	});
    	
    	function pageSel() {
    		$('.pageSel').change(function(){ 
    			var p1=$(this).children('option:selected').val();//这就是selected的值
    			pageIndex = 1;
    			pageSize = p1;
    			radio_click();
    		}) 
    	}
    	
    	function bindTdClick() {
    		$('.table td').unbind('click').click(function(){
    			var html = $(this).html();
    			if (html.indexOf("input") == -1) {
    				$(this).html("<input type='text' class='input input-small' value='"+html+"'/>");
    				$(".input").focus();
    				$(".input").blur(function(){
    					var val = $(this).val();
    					$('.table td').html(val);
    				})
    			}
    		})
    	}
    	
    	function pageClick(sel_page) {
    		pageIndex = sel_page;
    		radio_click();
    	}
    	
    	function radio_click() {
    		var radio_value = $("input[name='radio_user']:checked").val();
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUser/list.htmls",
                data: {'parentid':parentid,identity:radio_value,pageIndex:pageIndex-1,pageSize:pageSize},
                type: "post",
                dataType:"json",
                success: function (json) {
               	 	/* alert(json.data);
               	    $(".booklist").setTemplateElement("Template-List-note-show");
     	         	$(".booklist").setParam('totle', 0);
                 	//process template
                 	$(".booklist").processTemplate(data); */
                 	totalPage = Math.ceil(json.total/pageSize);
                 	//totalPage = ((json.total%pageSize==0)?(json.total/pageSize):(json.total/pageSize+1));   
               	 	$(".admin-panel").setTemplateElement("Template-List-user-show");
	         		$(".admin-panel").setParam('rowCount', json.total);
	         		$(".admin-panel").setParam('pageSize', pageSize);
	         		$(".admin-panel").setParam('pageIndex', pageIndex);
	         		$(".admin-panel").setParam('totalPage', totalPage);
	         		//$("#admin-panel").setParam('docAuthArr', docAuthArr);
	                $(".admin-panel").processTemplate(json.data);
	                
	                bindTdClick();
	                pageSel();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
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
		<div class="admin" style="padding: 30px 60px;">
			<form onsubmit="return false;" class="form-x" method="post">
				<div class="form-group float-right">
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
					<a href="javascript:;" onclick="aaa()" style="margin-left: 20px" class="button bg-blue">新建</a>
				</div>
			</form>
			<form method="post">
				<div class="admin-panel">
					<table class="table table-bordered table-hover text-small">
						<tbody>
							<tr class="panel-head">
								<th width="45" align="center"><input type="checkbox" value="1" name="id"></th>
								<!-- <th width="120"></th> -->
								<th width="*">商品名称</th>
								<th width="100">规格</th>
								<th width="100">数量</th>
								<th width="100">单价</th>
								<th width="100">折扣</th>
								<th width="180">小计</th>
							</tr>
							<tr>
								<td align="center"><input type="checkbox" value="1" name="id"></td>
								<%-- <td><img alt="" src="${pageContext.request.contextPath}/file/pic/aa26da09-60e8-4168-8bf5-49bd65645e1b.jpg" width="46px" height="46px"></td> --%>
								<td>商品A</td>
								<td align="center">30ml</td>
								<td align="center">12</td>
								<td align="center">180</td>
								<td align="center">0.3</td>
								<td></td>
							</tr>
							<tr>
								<td align="center"><input type="checkbox" value="1" name="id"></td>
								<%-- <td><img alt="" src="${pageContext.request.contextPath}/file/pic/aa26da09-60e8-4168-8bf5-49bd65645e1b.jpg" width="46px" height="46px"></td> --%>
								<td>商品A</td>
								<td align="center">30ml</td>
								<td align="center">12</td>
								<td align="center">180</td>
								<td align="center">0.3</td>
								<td></td>
							</tr>
							<tr>
								<td align="center"><input type="checkbox" value="1" name="id"></td>
								<%-- <td><img alt="" src="${pageContext.request.contextPath}/file/pic/aa26da09-60e8-4168-8bf5-49bd65645e1b.jpg" width="46px" height="46px"></td> --%>
								<td>商品A</td>
								<td align="center">30ml</td>
								<td align="center">12</td>
								<td align="center">180</td>
								<td align="center">0.3</td>
								<td></td>
							</tr>
						</tbody>
					</table>
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
				<tr class="panel-head">
					<th width="45" align="center"><input type="checkbox" value="1" name="id"></th>
					<th width="45">序号</th>
					<th width="80">姓名</th>
					<th width="100">手机号码</th>
					<th width="80">生日</th>
					<th width="50">性别</th>
					<th width="60">身份</th>
					<th width="200">机构名称</th>
					<th width="200">机构地址</th>
					<th width="100">机构代码</th>
					<th width="80">微信号码</th>
					<th width="80">机构级别</th>
					<th width="50">状态</th>
					<th width="50">排序</th>
					<th width="100">操作</th>
				</tr>
				{#if $P.rowCount > 0}
					{#foreach $T as row}
						<tr class="tr">
							<td align="center"><input type="checkbox" value="1" name="id"></td>
							<td>{($T.row$index+1)+($P.pageIndex * $P.pageSize - $P.pageSize)}</td>
							<td>{$T.row.username}</td>
							<td>{$T.row.phonenumber}</td>
							<td>{$T.row.birthday}</td>
							<td>{#if $T.row.sex == 1}男{#else}女{#/if}</td>
							<td>{$T.row.identitymemo}</td>
							<td>{$T.row.companyname}</td>
							<td>{$T.row.companypath}</td>
							<td>{$T.row.companycode}</td>
							<td>{$T.row.wechar}</td>
							<td>{$T.row.rank}</td>
							<td>{#if $T.row.isopen == 1}正常{#else}<span style="color:red">禁用</span>{#/if}</td>
							<td>{$T.row.sort}</td>
							<td>操作</td>
						</tr>
					{#/for}
				{#else}
					<tr class="tr" style="height:150px;">
						<td align="center" colspan="15">还没有数据...</td>
					</tr>
				{#/if}
				
			</tbody>
			<tfoot>
				<tr class="">
					<td align="center"><input type="checkbox" value="0"></td>
					<td colspan="5" class="tr pr10" style="text-align:left" >
						<a class="batch-op batchActivate" href="javascript:void(0)">批量开通</a>
						<a class="batch-op batchInactivate" href="javascript:void(0)">批量禁用</a>
					</td>
					<td colspan="10" style="text-align:right" >
						<div class="page">
							<span>每页显示</span>
							<select class="pageSel">
								<option {#if $P.pageSize == 2}selected{#/if}  value="2">2</option>
								<option {#if $P.pageSize == 10}selected{#/if}  value="10">10</option>
								<option {#if $P.pageSize == 50}selected{#/if}  value="50">50</option>
								<option {#if $P.pageSize == 100}selected{#/if}  value="100">100</option>
							</select>
							<span>条</span>
							<div class="page-number">
								<span>第</span>
								<input class="ui-pager-inp" type="text" value="{$P.pageIndex}" autocomplete="off"> 
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
</body>
</html>