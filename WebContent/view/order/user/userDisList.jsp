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
    	
		/* 这个是为td编辑显示小红标志。这里没有用到  */
		.grid-cell-dirty {
		    background: url(${pageContext.request.contextPath}/view/order/images/dirty.gif) no-repeat right 4px;
		}
		
    </style>
    <script type="text/javascript">
    	var parentid = '${sessionScope.pc_user_sessiion.id}';
    	var pageIndex = 1;
    	var pageSize = 10;
    	var totalPage = 0;
    	
    	var rows = [];
    	
    	var searchmap = "";
    	var radio_value = "";
    	
    	//设置用
    	var set_user = "";
    	
    	function getPath() {
    		var strFullPath=window.document.location.href;  
            var strPath=window.document.location.pathname;  
            var pos=strFullPath.indexOf(strPath);  
            var prePath=strFullPath.substring(0,pos);  
            var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);  
            var basePath = prePath;  
            basePath = prePath + postPath;    
            return basePath;
    	}
    	$(function(){
    		getPath();
    		/* layer.prompt({
    			formType: 0,
    			value: '0.2',
    			title: '请输入值'
    		}, function(value, index, elem) {
    			alert(value); //得到value
    			layer.close(index);
    		}); */
    		
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
    	
    	
    	/* var cat1 = Cat.createNew("asdflkjjjjj");
    		alert(cat1.load("asf"));
    		
    		cat1.set({
    			url:"http://www.baidu.com",
    			columns: [
							{ type: "checkcolumn",headerAlign:"center",width: 30},
	      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40}
	      	            ]
    		});
    		
    		alert(cat1.getUrl()); */
    	//绑定数量的TD <!-- test.js 是为测试td编辑。这里没有用到 -->
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
               	 	//$(".admin-panel").setTemplateElement("Template-List-user-show");
               	 	$(".admin-panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/listUser.tpl");
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
    	
    	function showUserDis(userid) {
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserDis/listUserStandard.htmls",
                data: {'parentid':parentid,'userid':userid},
                type: "post",
                dataType:"json",
                success: function (json) {
                	$(".setUserDisDiv").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/setUserDis.tpl");
             		$(".setUserDisDiv").setParam('radio_value', radio_value);
             		$(".setUserDisDiv").setParam('rowCount', json.total);
             		//$(".selUserDiv").setParam('parentid', parentid);
                    $(".setUserDisDiv").processTemplate(json.data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    		
    		
    	}
    	
    	function setUserDis(userid) {
    		for (var i=0;i<rows.length;i++) {
	   			if (rows[i].id == userid) {
	   				set_user = rows[i];
	   				break;
	   			}
	   		}
	   		
	   		if (set_user == "") {
	   			layer.msg("未找到要设置的记录，请重新登录再次尝试或与管理员联系。",{icon:5});
	   			return false;
	   		}
	   		var sel_user_arr = [];
	   		sel_user_arr.push(set_user);
	   		
	   		$(".selUserDiv").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/setUserAction.tpl");
     		$(".selUserDiv").setParam('radio_value', radio_value);
     		$(".selUserDiv").setParam('rowCount', 1);
            $(".selUserDiv").processTemplate(sel_user_arr);
            
            showUserDis(userid);
	   		
    		$(".userDiv").slideToggle(1000,function(){
    			//alert("滑动向上缩小完毕");
    		});
    		$(".selUserDiv").slideToggle(1000,function() {
    			
    		});
    		$(".setUserDisDiv").slideToggle(1000,function() {
    			//alert("滑动向下放大完毕");
    		});
    		return false;
    	}
    	
    	function showUserList() {
    		$(".userDiv").slideToggle(1000,function() {
    			//alert("滑动向下放大完毕");
    		});  
    		$(".selUserDiv").slideToggle(1000,function() {
    			//alert("滑动向下放大完毕");
    		});
    		$(".setUserDisDiv").slideToggle(1000,function() {
    			//alert("滑动向下放大完毕");
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
			<li><a href="javascript:;" >客户利益设置</a></li>
		</ul>
		<div class="selUserDiv" style="display:none;padding:20px 60px;">
		</div>
		<div class="userDiv" style="padding: 20px 60px;">
			<form onsubmit="return false;" class="form-x" method="post">
				<div class="form-group float-right" style="width:300px">
					<c:choose>
	    				<c:when test="${sessionScope.pc_user_sessiion.id == '1' }">
	    					<input name="radio_user" type="radio" value="A"> 代理
	    					<input name="radio_user" type="radio" value="C"> 门店
	    				</c:when>
	    				<c:when test="${sessionScope.pc_user_sessiion.identity == 'A' }">
	    					<input name="radio_user" type="radio" value="C"> 门店
	    				</c:when>
	    				<c:otherwise>
	    				</c:otherwise>
	    			</c:choose>
					<input type="text" id="searchTxt" name="searchTxt" class="input input-auto" style="width:120px;margin-left: 20px"/>
					<a id="searchBtn" href="javascript:;" class="button bg-main button-small" onclick="searchUser()">检索</a>
				</div>
			</form>
			<div class="admin-panel">
			</div>
		</div>
		<div class="setUserDisDiv" style="display:none;padding:20px 60px;">
			
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