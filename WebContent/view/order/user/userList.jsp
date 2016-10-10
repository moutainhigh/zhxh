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
    	
    	//绑定的TD
    	function bindTdClick() {
    		$('.update td').unbind('click').click(function(){
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
    				    var m = '<div class="mini-grid-cell-inner  mini-grid-cell-nowrap  grid-cell-dirty" style="">'+val+'</div>';
    					e.html(m);
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
    	
    	/* $("input").focus(function() {
			this.value = "";
		}).blur(function() {
			var self = this;
			setTimeout(function() {
				self.value = "默认值";
			}, 300)
		});
		$("div").click(function() {//这部分不变 
			var value = $("input").val();
			console.log(value);
		}); */
    	
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
		function test() {
			$("#sex").trigger("mousedown");
		}
		
		function reload() {
			radio_click();
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
               	 	//$(".admin-panel").setTemplateElement("Template-List-user-show");
               	 	$(".admin-panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/user/listUser.tpl",null,{filter_data: true});
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
    	
    	function updateUserTuijian(userid) {
    		if (userid == "") {
    			layer.msg("未找到要修改推荐人的记录，请重新登录再次尝试或与管理员联系。",{icon:5});
	   			return false;
    		}
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
	   			layer.msg("未找到要修改推荐人的的记录，请重新登录再次尝试或与管理员联系。",{icon:5});
	   			return false;
	   		}
	   		
    		layer.open({
			    type: 2,
			    title:'修改客户的推荐人',
			    area: [(pWidth-200)+'px', (pHeight-100) +'px'],
			    fix: false, //不固定
			    maxmin: false,
			    scrollbar:false,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/selectUser",
			    success: function(layero, index){
			    	var win = window['layui-layer-iframe' + index].window;
			    	var data = [];
			    	data.parentid = parentid;
			    	data.identity = radio_value;
			    	data.pageSize = 10;
			    	data.checktype = "radio";
			    	win.setData(data);
			    },
			    btn: ['选择', '取消'],
			  	yes: function(index,layero){
			  		var win = window['layui-layer-iframe' + index].window;
			  		var sel_rows = win.getData();
			  		if (sel_rows.length == 0) {
			  			layer.close(index); 
			  			return;
			  		}
			  		
			  		if (updateRow.id == sel_rows[0].id) {
			  			layer.msg("不允许自己推荐自己，如有疑问请与开发商联系。",{icon:6});
			  			return;
			  		}
			  		//询问框
			  		layer.confirm('确定要修改客户的推荐人信息吗？', {
			  			btn: ['确认', '取消']
			  		},
			  		function()	{
			  			updateRow._state = 'modified';
			  			updateRow.updatePhone = "0";
			  			updateRow.tuijianid = sel_rows[0].id;
			  			updateRow.tuijianman = sel_rows[0].companyname;
			  			
			  			var rowArr = [];
			  			rowArr.push(updateRow);
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
			  		layer.close(index); 
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
			if (t == "tuijianman") {
				txt = "清空";
			}
			else if (v == 0) {
    			txt = "禁用";
    		}
    		
    		var updatefield = t;
    		var cf = "状态为[";
    		if (t == "setreturn") {
    			cf = "接收分成为[";
    		}
    		else if (t == "tuijianman") {
    			cf = "推荐人[";
    		}
    		
    		layer.confirm('确定要批量修改选中客户的'+cf+txt+']吗？', {
	  			btn: ['确认', '取消']
	  		}, 
	  		function()	{
	  			$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderUser/updateBatch.htmls",
	                data: {'parentid':parentid,'updateUserids':sel_userid,'field':t,'fieldValue':v},
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
	<div class="layout" style="margin-bottom: 100px;">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >客户列表</a></li>
		</ul>
		<div class="admin" style="padding: 20px 60px;">
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