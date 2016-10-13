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
    <!-- test.js 是为测试td编辑。这里没有用到 -->
    <script src="${pageContext.request.contextPath}/js/test.js" type="text/javascript"></script>
    
    <style type="text/css">
		
    </style>
    <script type="text/javascript">
    	var parentid = '${sessionScope.pc_user_sessiion.id}';
    	//机构分页
    	var pageIndex = 1;
    	var pageSize = 10;
    	var totalPage = 0;
    	
    	var searchmap = "";
    	
    	var disConfig = "";
    	
    	$(function(){
    		listUserRatio();
    		//调用全选插件
    	    $.fn.check({ checkall_name: "checkall", checkbox_name: "row_id" });
    		
    	    $('#searchTxt').bind('keypress',function(event){
                if(event.keyCode == "13") {
                	searchUser();
                }
            });
    	    
    	  //获取利益标准
    	    $.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUser/disConfig.htmls",
                //data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	disConfig = json;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	    
    	});
    	
    	function listUserRatio() {
    		var par = {};
    		par.parentid = parentid;
    		par.pageIndex = pageIndex-1;
    		par.pageSize = pageSize;
    		par.isPage = true;
    		
    		if (searchmap != "") {
    			par.mapObj = JSON.stringify(searchmap);
    		}
    		
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserDis/listUserRatio.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                 	totalPage = Math.ceil(json.total/pageSize);
               	 	//$(".admin-panel").setTemplateElement("Template-List-user-show");
               	 	$(".admin-panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/userRatioList.tpl");
	         		$(".admin-panel").setParam('rowCount', json.total);
	         		$(".admin-panel").setParam('pageSize', pageSize);
	         		$(".admin-panel").setParam('pageIndex', pageIndex);
	         		$(".admin-panel").setParam('totalPage', totalPage);
	         		$(".admin-panel").setParam('parentid', parentid);
	                $(".admin-panel").processTemplate(json.data);
	                
	                //bindTdClick();
	                pageSel();
	                pageEnter();
	              	//调用全选插件
	              	bindTrClick();
	              	bindTdClick();
	        	    $.fn.check({ checkall_name: "checkall", checkbox_name: "row_id" });
	              	
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
    	
    	function bindTrClick() {
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
    			listUserRatio();
    		}) 
    	}
    	
    	function pageEnter(type) {
    		$('.ui-pager-inp').bind('keypress',function(event) {
                if(event.keyCode == "13") {
                	if (isInteger($(this).val())) {
                		if ($(this).val() > totalPage || $(this).val() < 1 || $(this).val() == pageIndex) {
                			return false;
                		}
                		else {
                			pageIndex = $(this).val();
                			listUserRatio();
                		}
                	}
                	else {
                		
                	}
                    return false;
                }
            });
    	}
    	
    	function pageClick(sel_page,pagetype) {
    		pageIndex = sel_page;
    		listUserRatio();
    	}
    	
    	function addUser() {
    		var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	   		
    		layer.open({
			    type: 2,
			    title:'添加奖励转货款客户',
			    area: [(pWidth-350) + 'px', (pHeight-200) +'px'],
			    fix: false, //不固定
			    maxmin: false,
			    scrollbar:false,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/selectUserNoPage",
			    success: function(layero, index){
			    	var win = window['layui-layer-iframe' + index].window;
			    	var data = [];
			    	data.parentid = parentid;
			    	win.setData(data);
			    },
			    btn: ['选择', '取消'],
			  	yes: function(index,layero){
			  		var win = window['layui-layer-iframe' + index].window;
			  		var rowids = win.getData();
			  		
			  		if (rowids == "") {
			  			return;
			  		}
			  		//询问框
			  		layer.confirm('确定要将选择的客户添加[奖励转货款]吗？', {
			  			btn: ['确认', '取消']
			  		}, 
			  		function()	{
			  			var par = {};
			  			par.parentid = parentid;
			  			par.ids = rowids;
			  			$.ajax({
			    			async:false,
			                url: "${pageContext.request.contextPath}/orderUserDis/UserRatioSel.htmls",
			                data: par,
			                type: "post",
			                dataType:"text",
			                success: function (text) {
			                 	if (text == 'success') {
			                 		layer.msg("保存成功。",{icon:6});
			                 		listUserRatio();
			                 		win.pageIndex = 1;
			                 		win.loadData();
			                 		
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
    	
    	function delRatio() {
    		var ids = "";
			$('input:checkbox[name=row_id]:checked').each(function(i) {
				if(0==i){
					ids = $(this).val();
			 	}else{
			 		ids += (","+$(this).val());
			    }
			});
			if (ids == "") {
				layer.msg("请先选择要删除的奖励转货款客户.",{icon:6});
				return;
			}
			
			layer.confirm('确定要删除客户的奖励转货款吗？', {
	  			btn: ['确认', '取消']
	  		}, 
	  		function()	{
	  			var par = {};
	  			par.ids = ids;
	  			$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderUserDis/delRatio.htmls",
	                data: par,
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                 	if (text == 'success') {
	                 		layer.msg("保存成功。",{icon:6});
	                 		listUserRatio();
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
    	
    	function searchUser() {
    		var key = $("#searchTxt").val();
    		pageIndex = 1;
    		
    		if (key != "") {
    			searchmap = {};
                searchmap.username = key;
                searchmap.companyname = key;
            }
            else {
            	searchmap = "";
            }
    		listUserRatio();
			
    	}
    	
    	function td_tip(e) {
    		if (!e) e = window.event;
    		var reltg = e.relatedTarget ? e.relatedTarget : e.fromElement;
    		while (reltg && reltg != this) reltg = reltg.parentNode;
    		if (reltg != this) {
    			var msg = "奖励转货款系数，例如设置为1.3表示客户将奖励转为货款的倍数。以鼓励客户将获得奖励用于采购。0表示没有倍数。<span style='color:#C0FF3E'>点击可直接输入编辑。</span>";
        		var color = "#3595CC";
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
    	
    	function updatebatch() {
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
			var updown = "上限["+disConfig.bonuses_ratio_up + "].下限["+disConfig.bonuses_ratio_down + "]";
			layer.prompt({
   				title: '请输入奖励转货款系数.'+updown,
   				formType: 0
   			}, function(num){
   				if (num == "") {
   					layer.msg("请输入值。",{icon:5});
   		   			return false;
   				}
   				else if (!isNumber(num)) {
   					layer.msg("请输入数字。",{icon:5});
   		   			return false;
   				}
   				
   				if (num <= 0) {
   					layer.msg("请输入大于0的数字。",{icon:5});
   		   			return false;
   				}
   				
   				if (num > disConfig.bonuses_ratio_up) {
					layer.msg("设置超过上限，请重新输入。",{icon:5});
					return false;
				}
   				if (num < disConfig.bonuses_ratio_down) {
					layer.msg("设置低于下限，请重新输入。",{icon:5});
					return false;
				}
   				
   				$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderUserDis/updateRatio.htmls",
	                data: {'ids':sel_userid,'v':num},
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                 	if (text == 'success') {
	                 		layer.msg("保存成功。",{icon:6});
	                 		listUserRatio();
	                 	}
	                 	else {
	                 		layer.msg("保存出现问题，请退出重新登录，再尝试，或与开发商联系。",{icon:5});
	                 	}
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
	                }
	           });
   			});
    	}
    	//绑定数量的TD <!-- test.js 是为测试td编辑。这里没有用到 -->
    	function bindTdClick() {
    		$('.updateTd').unbind('click').click(function(){
    			var e = $(this);
    			var html = $(this).html();
    			if (html.indexOf("input") == -1) {
    				$(this).html("<input type='text' class='input input-small quant' value='"+html+"'/>");
    				$(".quant").focus();
    				$(".quant").select();
    				$(".quant").blur(function(){
    					var val = $(this).val();
    					if(!isNumber(val) || val == 0){
    				        val = html; //非正整数为1
    				    }
    					
    					if (val <= 0) {
    						val = html;
    					}
    					e.html(val);
    					
    					var id = e.attr("v");
    					if (val != html) {
    						$.ajax({
        		    			async:false,
        		                url: "${pageContext.request.contextPath}/orderUserDis/updateRatio.htmls",
        		                data: {'ids':id,'v':val},
        		                type: "post",
        		                dataType:"text",
        		                success: function (text) {
        		                 	if (text == 'success') {
        		                 		listUserRatio();
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
    	
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 150px;">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >客户奖励转货款设置</a></li>
		</ul>
		<div class="userDiv" style="padding: 20px 60px;">
			<div>
				<table style="width:100%;margin-bottom: 10px;">
					<tr>
						<td align="left">设置客户的奖励转货款系数</td>
						<td align="right">
							<a href="javascript:;" class="button bg-sub button-small" onclick="addUser()">添加客户</a>
							<a href="javascript:;" class="button bg-dot button-small" onclick="delRatio()">删除客户</a>
							<a href="javascript:;" class="button border-sub button-small" onclick="updatebatch()">批量设置</a>
							<input type="text" id="searchTxt" name="searchTxt" class="input input-auto" style="width:120px;margin-left: 20px"/>
							<a id="searchBtn" href="javascript:;" class="button bg-main button-small" onclick="searchUser()">检索</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="admin-panel">
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
	
</body>
</html>