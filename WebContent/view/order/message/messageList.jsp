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
    <script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>
    
    <style type="text/css">
    	
		.input {
    		font-size: 12px;
    	}
    	
    	/* ==== */
		
    </style>
    <script type="text/javascript">
    	var userid = '${sessionScope.pc_user_sessiion.id}';
    	var pageIndex = 1;
    	var pageSize = 10;
    	var totalPage = 0;
    	
    	var rows = [];
    	
    	var searchmap = "";
    	var radio_value = "${radio_value}";
    	$(function(){
    		var message_txt = ""
    		if (radio_value == 0) {
    			message_txt = "系统消息";
    		}
    		else if (radio_value == 1) {
    			message_txt = "业务消息";
    		}
    		else if (radio_value == 2) {
    			message_txt = "站内信";
    		}
    		
    		$("#message_txt").html(message_txt);
    		
    		$("input[name=radio_message]:eq(${radio_value})").attr("checked",'checked');
    		list();
    		//调用全选插件
    	    //$.fn.check({ checkall_name: "checkall", checkbox_name: "row_id" });
    		
    		$("input[name=radio_message]").click(function(){
    			$(this).val();
    			pageIndex = 1;
    			searchmap = "";
    			$("#searchTxt").val("");
    			list();
  			});
    		
    	    $('#searchTxt').bind('keypress',function(event){
                if(event.keyCode == "13") {
                	searchMessage();
                }
            });
    	});
    	
    	function list() {
    		radio_value = $("input[name='radio_message']:checked").val();
    		
    		/* $("#sendM").hide();
    		if (radio_value == 2) {
    			$("#sendM").show();
    		} */
    		
    		var par = {};
    		par.receiveid = userid;
    		par.pageIndex = pageIndex-1;
    		par.pageSize = pageSize;
    		par.messagetype = radio_value;
    		
    		if (searchmap != "") {
    			par.mapObj = JSON.stringify(searchmap);
    		}
    		
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderMessage/list.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	rows = json.data;
                 	totalPage = Math.ceil(json.total/pageSize);
               	 	$(".admin-panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/message/messageList.tpl",null,{filter_data: true});
	         		$(".admin-panel").setParam('rowCount', json.total);
	         		$(".admin-panel").setParam('pageSize', pageSize);
	         		$(".admin-panel").setParam('pageIndex', pageIndex);
	         		$(".admin-panel").setParam('totalPage', totalPage);
	                $(".admin-panel").processTemplate(json.data);
	                
	                //bindTdClick();
	                pageSel();
	                pageEnter();
	                bindTrClick();
	                //updateTd();
	              	//调用全选插件
	        	    $.fn.check({ checkall_name: "checkall", checkbox_name: "row_id" });
	              	
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
    	
    	function pageSel() {
    		$('.pageSel').change(function(){
    			var p1=$(this).children('option:selected').val();//这就是selected的值
    			pageIndex = 1;
    			pageSize = p1;
    			list();
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
                    		list();
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
    		list();
    	}
    	
    	function reload() {
    		list();
		}
    	
    	function searchMessage() {
    		var key = $("#searchTxt").val();
    		pageIndex = 1;
    		
    		if (key != "") {
    			searchmap = {};
                searchmap.sendname = key;
                searchmap.receivename = key;
                searchmap.messagetxt = key;
            }
            else {
            	searchmap = "";
            }
			list();
			
    	}
    	
    	function bindTrClick() {
    		//除了表头（第一行）以外所有的行添加click事件.
            $(".table tr").first().nextAll().click(function (e) {
            	if (e.target.tagName == "TD") {
            		var firstInput = $(this).children("td:eq(0)").children("input:eq(0)");  // 第一个checkBox
                	firstInput.attr("checked",!firstInput.is(':checked'));
            	}
            });
    	}
    	
    	function setMessageState(id) {
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderMessage/updateBatch.htmls",
                data: {'ids':id,'field':'messagestate','fieldValue':1},
                type: "post",
                dataType:"text",
                success: function (text) {
                 	if (text == 'success') {
                 		layer.msg("保存成功。",{icon:6});
                 		list();
                 		parent.resetFunc("message");
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
    	
    	function updatebatch(v,t) {
    		var sel_id = getInfo();
			if (sel_id == "") {
				layer.msg("请先选择要批量操作的消息.",{icon:6});
				return;
			}
    		
    		var updatefield = t;
    		var cf = "状态为[已读]";
    		
    		layer.confirm('确定要批量修改选中消息的'+cf+']吗？', {
	  			btn: ['确认', '取消']
	  		}, 
	  		function()	{
	  			$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderMessage/updateBatch.htmls",
	                data: {'ids':sel_id,'field':t,'fieldValue':v},
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                 	if (text == 'success') {
	                 		layer.msg("保存成功。",{icon:6});
	                 		list();
	                 		parent.resetFunc("message");
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
    	function getInfo() {
    		var sel_id = "";
			$('input:checkbox[name=row_id]:checked').each(function(i) {
				if(0==i){
					sel_id = $(this).val();
			 	}else{
			 		sel_id += (","+$(this).val());
			    }
			});
			
			return sel_id;
    	}
    	
    	function delbatch() {
    		var sel_id = getInfo();
    		if (sel_id == "") {
				layer.msg("请先选择要批量操作的消息.",{icon:6});
				return;
			}
			
    		layer.confirm('确定要批量删除选中的消息吗？', {
	  			btn: ['确认', '取消']
	  		}, 
	  		function()	{
	  			$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderMessage/delete.htmls",
	                data: {'ids':sel_id},
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                 	if (text == 'success') {
	                 		layer.msg("保存成功。",{icon:6});
	                 		list();
	                 		parent.resetFunc("message");
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
	<div class="layout" style="margin-bottom: 100px;">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a id="message_txt" href="javascript:;" >业务消息列表</a></li>
		</ul>
		<div class="admin" style="padding: 20px 60px;">
			<div class="form-group float-right" style="width:580px">
				<input name="radio_message" type="radio" value="0"> 系统消息
 				<input name="radio_message" type="radio" value="1"> 业务消息
 				<!-- <input name="radio_message" type="radio" value="2"> 站内信 -->
				<input type="text" id="searchTxt" name="searchTxt" class="input input-auto" style="width:120px;margin-left: 20px"/>
				<a id="searchBtn" href="javascript:;" class="button bg-main button-small" onclick="searchMessage()">检索</a>
				<a id="addUser" href="javascript:;" onclick="messagestate(1,'messagestate')" style="margin-left: 5px" class="button bg-blue">批量已读</a>
				<a id="addUser" href="javascript:;" onclick="delbatch()" style="margin-left: 5px" class="button button-small border-red">批量删除</a>
				<!-- <a id="sendM" href="javascript:;" onclick="delbatch()" style="margin-left: 5px" class="button button-small border-sub">发站内信</a> -->
			</div>
			<div class="admin-panel"></div>
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
</body>
</html>