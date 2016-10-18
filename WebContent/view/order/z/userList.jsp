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
		
		/* 添加用 */
		.doc-demoview {
		    border: solid 1px #ddd;
		    padding: 10px 15px 0px 15px;
		    border-radius: 4px 4px 0 0;
		}
		
		.doc-viewad0, .doc-codead0 {
		    border-color: #cec;
		}
		
		.doc-demoview .view-body {
		    padding-top: 15px;
		    padding-bottom:15px;
		}
		
		.doc-codead0 {
		    background: #efe;
		}
		.doc-democode {
		    border: solid 1px #ddd;
		    border-radius: 0 0 4px 4px;
		    padding: 10px;
		    background: #f5f5f5;
		    font-size: 12px;
		    border-top: none;
		}
		
		.form-x .form-group .label {
		    float: left;
		    width: 15%;
		    text-align: right;
		    padding: 7px 7px 7px 0;
		    white-space: nowrap;
		    text-overflow: ellipsis;
		    overflow: hidden;
		}
		
		.form-x .form-group .field {
		    float: left;
		    width: 85%;
		}
		
		.input {
    		font-size: 12px;
    	}
    	
    	/* ==== */
		
    </style>
    <script type="text/javascript">
    	var parentid = '${sessionScope.pc_user_sessiion.id}';
    	var pageIndex = 1;
    	var pageSize = 10;
    	var totalPage = 0;
    	
    	var rows = [];
    	
    	var searchmap = "";
    	var radio_value = "Z";
    	$(function(){
    		radio_click();
    		
    	    $('#searchTxt').bind('keypress',function(event){
                if(event.keyCode == "13") {
                	searchUser();
                }
            });
    	    
    	  //新增订货单
    		/* $("#newOrder").click(function(){
    			location.href = "${pageContext.request.contextPath}/orderZ/newOrder.htmls?userid=aaa";
    		}); */
    	    
    	  	//提示信息
    		layer.tips('可点击客户信息，直接编辑并自动保存。', '#tip_username', {tips: [1, '#FF9901'],time: 5000,});
    	    
    	});
    	
    	function addOrder(userid) {
    		location.href = "${pageContext.request.contextPath}/orderZ/newOrder.htmls?userid="+userid;
    	}
    	function oldOrder(userid) {
    		location.href = "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/z/zOrderlist&param={'buyuserid':'"+userid+"','orderType':'buyuser'}";
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
    	
    	function pageSel() {
    		$('.pageSel').change(function(){ 
    			var p1=$(this).children('option:selected').val();//这就是selected的值
    			pageIndex = 1;
    			pageSize = p1;
    			radio_click();
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
    		
    		if (!e) e = window.event;
    		var reltg = e.relatedTarget ? e.relatedTarget : e.fromElement;
    		while (reltg && reltg != this) reltg = reltg.parentNode;
    		if (reltg != this) {
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
    		
    	}
    	
    	function td_tip_over(e) {
    		
    		if (!e) e = window.event;
    		var reltg = e.relatedTarget ? e.relatedTarget : e.toElement;
    		while (reltg && reltg != this) reltg = reltg.parentNode;
    		if (reltg != this) {
    			// 这里可以编写 onmouseleave 事件的处理代码
    			layer.closeAll('tips');
    		}
    		//layer.closeAll('tips');
    	}
    	
    	function updateTd() {
    		$('.u').unbind('click').click(function(){
    	        if(!$(this).is('.input_td')){
    	        	var thisid = $(this).parent().attr("id");
    	        	var editor = $(this).attr("editor");
    	        	var field = $(this).attr("field");
    	        	var html = $(this).text();
    	        	
    	        	if (editor == "textbox") {
    	        		$(this).addClass('input_td').html('<input type="text" id="'+field+'" name="'+field+'" class="input input-small" value="'+ $(this).text() +'" onfocus=this.select() />').find('input').focus().blur(function(){    
       	        			// var thisid = $(this).parent().siblings("th:eq(0)").text();  
           	                var self = $(this);
       	        			var value=$(this).val();
       	        			if (value == html) {
       	        				self.parent().removeClass('input_td').html(self.val() || 0); 
       	        				return;
       	        			}
           	                var vtype = $(this).parent().attr("vtype");
           	                if(typeof(vtype) != "undefined" && vtype != ""){
           	                	var vtypeArr = vtype.split(";");
           	                	for(var i=0;i<vtypeArr.length;i++) {
           	                		if (vtypeArr[i] == "") {
           	                			break;
           	                		}
           	                		else if (vtypeArr[i] == "required") {
           	                			if (value == "") {
           	                				$(this).focus();
           	                				layer.msg("不能为空。请填写内容。",{icon:5});
           	                	   			return false;
           	                			}
           	                		}
           	                		else if (vtypeArr[i] == "int") {
           	                			if (!isInteger(value)) {
           	                				$(this).focus();
           	                				layer.msg("请输入数字。",{icon:5});
           	                	   			return false;
           	                			}
           	                		}
           	                	}
           	                }
           	                
           	                var par = {};
           	                par.updateUserids = thisid;
           	                par.field = field;
           	                par.fieldValue = value;
           	                 
           	                $.ajax({    
           	                   type: 'POST',    
           	                   url: '${pageContext.request.contextPath}/orderUser/updateBatch.htmls',
           	                   //data: "updateUserids="+thisid+"&thisclass="+thisclass+"&thisvalue="+thisvalue
           	                   data:par
           	                });
           	                //clearTimeout(timerId);
           	             	var timerId = setTimeout(function(){ 
           	             		self.parent().removeClass('input_td').html(self.val() || 0);    
           	            	},300) 
           	            	radio_click();
           	            });
    	        	}
    	        	else if (editor == "combobox") {
    	        		
   	        			$(this).addClass('input_td');
   	        			var html = "<select  id='"+field+"' name='"+field+"'>";
   	        			if (field == "sex") {
    	        			if ($(this).text() == "男") {
    	        				html += "<option value='1' selected='selected'>男</option>";
    	        			}
    	        			else {
    	        				html += "<option value='1'>男</option>";
    	        			}
    	        			if ($(this).text() == "女") {
    	        				html += "<option value='0' selected='selected'>女</option>";
    	        			}
    	        			else {
    	        				html += "<option value='0'>女</option>";
    	        			}
   	        			}
   	        			else if (field == "setreturn") {
   	        				html += "<option value='1'>正常</option>";
   	        				html += "<option value='0'>禁用</option>";
   	        			}
   	        			html += "</select>";
   	        			
   	        			$(this).html(html);
   	        			
   	        			$("#"+field).focus().blur(function(){ 
   	        				var self = $(this);
   	        				var p1=$(this).children('option:selected').val();//这就是selected的值
   	        				var p1_text = $(this).children('option:selected').text();
   	        				var par = {};
              	                par.updateUserids = thisid;
              	                par.field = field;
              	                par.fieldValue = p1;
              	                
              	                 
              	                $.ajax({    
              	                   type: 'POST',    
              	                   url: '${pageContext.request.contextPath}/orderUser/updateBatch.htmls',
              	                   //data: "updateUserids="+thisid+"&thisclass="+thisclass+"&thisvalue="+thisvalue
              	                   data:par
              	                });
              	                //clearTimeout(timerId);
              	             	var timerId = setTimeout(function(){
              	             		self.parent().removeClass('input_td').html(p1_text || 0);
              	            	},300)
              	            	radio_click();
   	        			})
   	        			$("#"+field).trigger("mousedown");
    	        		//$("#"+field).click();
    	        	}
   	        		
   	        		if (editor == "datebox") {
   	        			laydate({
   	        			   elem: '#' + field
   	        			})
   	        		}
   	        		
    	        }    
    	    });
    		/* .hover(function(){    
    	        $(this).addClass('hover');    
    	    },function(){    
    	        $(this).removeClass('hover');    
    	    });   */
    	}
    	
		function reload() {
			radio_click();
		}
    	
    	function radio_click() {
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
                type: "post",
                dataType:"json",
                success: function (json) {
                	rows = json.data;
                 	totalPage = Math.ceil(json.total/pageSize);
               	 	$(".admin-panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/z/listUser.tpl",null,{filter_data: true});
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
	              	//调用全选插件
	                bindTrClick();
	                updateTd();
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
    		$(".addUser").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/user/addUser.tpl");
    		$(".addUser").setParam('path', '${pageContext.request.contextPath}');
    		$(".addUser").setParam('identity', radio_value);
            $(".addUser").processTemplate();
           
    		$(".admin").slideToggle(800,function(){
    			//alert("滑动向上缩小完毕");
    		});
    		
    		$(".addUser").slideToggle(800,function() {
    			 laydate({
      			   elem: '#birthday'
      			})
      			$("#phonenumber").blur(function(){
	   				var val = $(this).val();
	   				$('#companycode').val(val);
	   			})
	   			$('#username').focus();
    		});
    	}
    	
    	function showUpdateUser(userid) {
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
    		$(".addUser").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/user/updateUser.tpl");
    		$(".addUser").setParam('path', '${pageContext.request.contextPath}');
    		$(".addUser").setParam('identity', radio_value);
    		$(".addUser").setParam('updatePhone', 0);
            $(".addUser").processTemplate(updateRow);
           
    		$(".admin").slideToggle(800,function(){
    			//alert("滑动向上缩小完毕");
    		});
    		
    		$(".addUser").slideToggle(800,function() {
    			laydate({
      			   elem: '#birthday'
      			})
	   			$('#username').focus();
    		});
    	}
    	
    	function resetUserlist() {
    		
    		$(".admin").slideToggle(800,function(){
    			
    		});
    		
    		$(".addUser").css('display','none'); 
    		$(".addUser").html("");
    		
    		/* $(".addUser").slideToggle(1000,function() {
    			
    		}); */
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
	<div class="layout" style="margin-bottom: 100px;">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >客户列表</a></li>
		</ul>
		<div class="admin" style="padding: 20px 60px;">
			<div class="form-group float-right" style="width:280px">
				<input type="text" id="searchTxt" name="searchTxt" class="input input-auto" style="width:120px;margin-left: 20px"/>
				<a id="searchBtn" href="javascript:;" class="button bg-main button-small" onclick="searchUser()">检索</a>
				<a id="addUser" href="javascript:;" onclick="addUser()" style="margin-left: 5px" class="button bg-blue">新建</a>
			</div>
			<div class="admin-panel"></div>
		</div><!-- padding:0px 300px; -->
		<div class="addUser" style="display:none;width:700px;margin: 0 auto;"></div>
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