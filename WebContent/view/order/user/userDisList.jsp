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
    	//机构分页
    	var pageIndex = 1;
    	var pageSize = 10;
    	var totalPage = 0;
    	//品牌分页
    	var pageIndex_brand = 1;
    	var pageSize_brand = 5;
    	
    	//采购标准设置翻页
    	var pageIndex_dis = 1;
    	var pageSize_dis = 30;
    	var totalPage_dis = 0;
    	
    	var rows = [];
    	
    	var searchmap = "";
    	var radio_value = "";
    	
    	//设置用
    	var set_user = "";
    	
    	var sel_brandid= "";
    	
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
    	
    	function bindTrClick(type) {
    		if (type == "userList") {
    			//除了表头（第一行）以外所有的行添加click事件.
                $("tr").first().nextAll().click(function (e) {
                	if (e.target.tagName == "TD") {
                		var firstInput = $(this).children("td:eq(0)").children("input:eq(0)");  // 第一个checkBox
                    	firstInput.attr("checked",!firstInput.is(':checked'));
                	}
                });
    		}
    		else if (type == "userBrand") {
    			 $(".userBrand tr").first().nextAll().click(function (e) {
                 	if (e.target.tagName == "TD") {
                 		var $radio = $(this).find("input[type=radio]");
                        $flag  = $radio.is(":checked");
		                if( !$flag ){
		                    $radio.prop("checked",true).trigger("click");
		                }
                 		//var firstInput = $(this).children("td:eq(0)").children("input:eq(0)");  // 第一个checkBox
                     	//firstInput.attr("checked",!firstInput.is(':checked'));
                 	}
                 });
    		}
    		else if (type == "userDis") {
    			 $(".userDis tr").first().nextAll().click(function (e) {
                 	if (e.target.tagName == "TD") {
                 		var firstInput = $(this).children("td:eq(0)").children("input:eq(0)");  // 第一个checkBox
                     	firstInput.attr("checked",!firstInput.is(':checked'));
                 	}
                 });
    		}
    	}
    	
    	function pageSel() {
    		$('.pageSel').change(function(){ 
    			var p1=$(this).children('option:selected').val();//这就是selected的值
    			pageIndex = 1;
    			pageSize = p1;
    			radio_click();
    		}) 
    	}
    	
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
    	
    	function pageEnter(type) {
    		$('.ui-pager-inp').bind('keypress',function(event) {
                if(event.keyCode == "13") {
                	if (isInteger($(this).val())) {
                		if (type == "userList") {
                			if ($(this).val() > totalPage || $(this).val() < 1 || $(this).val() == pageIndex) {
                    			return false;
                    		}
                    		else {
                    			pageIndex = $(this).val();
                        		radio_click();
                    		}
                		}
                		else if (type == "userDis") {
                			if ($(this).val() > totalPage_dis || $(this).val() < 1 || $(this).val() == pageIndex_dis) {
                    			return false;
                    		}
                    		else {
                    			pageIndex_dis = $(this).val();
                    			getUserDis();
                    		}
                		}
                	}
                	else {
                		
                	}
                    return false;
                }
            });
    	}
    	
    	function pageClick(sel_page,pagetype) {
    		if (pagetype == "userList") {
    			pageIndex = sel_page;
        		radio_click();
    		}
    		else if (pagetype == "userBrand") {
    			pageIndex_brand = sel_page;
    			getUserBrand();
    		}
    		else if (pagetype == "userDis") {
    			pageIndex_dis = sel_page;
    			getUserDis();
    		}
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
    		
    		if (radio_value == "C") {
    			$(".dis").css("display","block");
    		}
    		else {
    			$(".dis").css("display","none");
    		}
    		
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
               	 	$(".admin-panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/userList.tpl");
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
	                pageEnter("userList");
	                bindTrClick("userList");
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
    	
    	function addBrand() {
    		var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	   		
	   		if (set_user == "") {
	   			layer.msg("未找到要添加品牌的客户的记录，请重新登录再次尝试或与管理员联系。",{icon:5});
	   			return false;
	   		}
	   		
    		layer.open({
			    type: 2,
			    title:'为客户添加可采购的品牌',
			    area: [(pWidth-280) + 'px', (pHeight-200) +'px'],
			    fix: false, //不固定
			    maxmin: false,
			    scrollbar:false,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/selectBrand",
			    success: function(layero, index){
			    	var win = window['layui-layer-iframe' + index].window;
			    	var data = [];
			    	data.parentid = parentid;
			    	data.userid = set_user.id;
			    	data.checktype = "checkbox";
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
			  		layer.confirm('确定要为客户添加能采购的品牌吗？', {
			  			btn: ['确认', '取消']
			  		}, 
			  		function()	{
			  			var par = {};
			  			par.parentid = parentid;
			  			par.userid = set_user.id;
			  			par.brandids = rowids;
			  			$.ajax({
			    			async:false,
			                url: "${pageContext.request.contextPath}/orderUserDis/saveUserBrand.htmls",
			                data: par,
			                type: "post",
			                dataType:"text",
			                success: function (text) {
			                 	if (text == 'success') {
			                 		layer.msg("保存成功。",{icon:6});
			                 		getUserBrand();
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
    	
    	function delBrand() {
    		if (sel_brandid == "") {
    			layer.msg("请先选择要删除的品牌.",{icon:6});
				return;
    		}
    		
    		layer.confirm('确定要删除客户能购买的品牌吗？<br><span style="color:red">注意：删除后，客户不采购该品牌下的商品。</span>', {
	  			btn: ['确认', '取消']
	  		}, 
	  		function()	{
	  			var par = {};
	    		par.parentid = parentid;
	    		par.userid = set_user.id;
	    		par.brandid = sel_brandid;
	    		
	    		$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderUserDis/delUserBrand.htmls",
	                data: par,
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                 	if (text == 'success') {
	                 		layer.msg("保存成功。",{icon:6});
	                 		getUserBrand();
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
    	
    	function addSize() {
    		var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	   		
	   		if (set_user == "") {
	   			layer.msg("未找到客户的记录，请先选择客户。",{icon:5});
	   			return false;
	   		}
	   		
	   		if (sel_brandid == "") {
	   			layer.msg("未找到品牌记录，请先选择品牌。",{icon:5});
	   			return false;
	   		}
	   		
    		layer.open({
			    type: 2,
			    title:'为客户添加可采购的商品',
			    area: [(pWidth-280) + 'px', (pHeight-200) +'px'],
			    fix: false, //不固定
			    maxmin: false,
			    scrollbar:false,
			    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/user/selectSize",
			    success: function(layero, index){
			    	var win = window['layui-layer-iframe' + index].window;
			    	var data = [];
			    	data.parentid = parentid;
			    	data.userid = set_user.id;
			    	data.brandid = sel_brandid;
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
			  		layer.confirm('确定要为客户添加能采购的商品吗？', {
			  			btn: ['确认', '取消']
			  		}, 
			  		function()	{
			  			var par = {};
			  			par.parentid = parentid;
			  			par.userid = set_user.id;
			  			par.brandid = sel_brandid;
			  			par.sizeids = rowids;
			  			$.ajax({
			    			async:false,
			                url: "${pageContext.request.contextPath}/orderUserDis/saveUserSizeStandard.htmls",
			                data: par,
			                type: "post",
			                dataType:"text",
			                success: function (text) {
			                 	if (text == 'success') {
			                 		layer.msg("保存成功。",{icon:6});
			                 		getUserDis();
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
    	
    	function delSize() {
    		var ids = "";
			$('input:checkbox[name=row_id_dis]:checked').each(function(i) {
				if(0==i){
					ids = $(this).val();
			 	}else{
			 		ids += (","+$(this).val());
			    }
			});
			if (ids == "") {
				layer.msg("请先选择要删除的采购利益标准",{icon:6});
				return;
			}
			
			layer.confirm('确定要删除客户的采购利益标准吗？<br><span style="color:red">注意：客户将不能采购这些被删除的商品.', {
	  			btn: ['确认', '取消']
	  		}, 
	  		function()	{
	  			var par = {};
	  			par.ids = ids;
	  			$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/orderUserDis/delUserStandard.htmls",
	                data: par,
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                 	if (text == 'success') {
	                 		layer.msg("保存成功。",{icon:6});
	                 		getUserDis();
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
    	
    	function getUserBrand() {
    		
    		var par = {};
    		par.parentid = parentid;
    		par.userid = set_user.id;
    		par.pageIndex = pageIndex_brand-1;
    		par.pageSize = pageSize_brand;
    		par.isPage = true;
    		
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserDis/listUserBrand.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	var totalPage_brand = Math.ceil(json.total/pageSize_brand);
                	$(".userBrandDiv_panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/userBrand.tpl");
                	$(".userBrandDiv_panel").setParam('pageSize', pageSize_brand);
	         		$(".userBrandDiv_panel").setParam('pageIndex', pageIndex_brand);
	         		$(".userBrandDiv_panel").setParam('totalPage', totalPage_brand);
             		$(".userBrandDiv_panel").setParam('rowCount', json.total);
             		$(".userBrandDiv_panel").setParam('path', '${pageContext.request.contextPath}');
                    $(".userBrandDiv_panel").processTemplate(json.data);
                    
                    bindTrClick("userBrand");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
    	function getUserDis() {
    		if (sel_brandid == "") {
    			var tmp = [];
    			$(".setUserDisDiv_panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/setUserDis.tpl");
         		$(".setUserDisDiv_panel").setParam('rowCount', 0);
         		$(".setUserDisDiv_panel").setParam('pageSize', pageSize_dis);
         		$(".setUserDisDiv_panel").setParam('pageIndex', 1);
         		$(".setUserDisDiv_panel").setParam('totalPage', 0);
         		$(".setUserDisDiv_panel").setParam('path', '${pageContext.request.contextPath}/');
                $(".setUserDisDiv_panel").processTemplate(tmp);
    		}
    		else {
    			var par = {};
        		par.parentid = parentid;
        		par.userid = set_user.id;
        		par.brandid = sel_brandid;
        		par.pageIndex = pageIndex_dis-1;
        		par.pageSize = pageSize_dis;
        		par.isPage = true;
    			$.ajax({
        			async:false,
                    url: "${pageContext.request.contextPath}/orderUserDis/listUserStandard.htmls",
                    data: par,
                    type: "post",
                    dataType:"json",
                    success: function (json) {
                    	totalPage_dis = Math.ceil(json.total/pageSize_dis);
                    	$(".setUserDisDiv_panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/setUserDis.tpl");
                 		$(".setUserDisDiv_panel").setParam('rowCount', json.total);
                 		$(".setUserDisDiv_panel").setParam('pageSize', pageSize_dis);
                 		$(".setUserDisDiv_panel").setParam('pageIndex', pageIndex_dis);
                 		$(".setUserDisDiv_panel").setParam('totalPage', totalPage_dis);
                 		$(".setUserDisDiv_panel").setParam('path', '${pageContext.request.contextPath}/');
                        $(".setUserDisDiv_panel").processTemplate(json.data);
                        
                        pageEnter("userDis");
                        bindTrClick("userDis");
                      //调用全选插件
    	        	    $.fn.check({ checkall_name: "checkall_dis", checkbox_name: "row_id_dis" });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                    	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                    }
               });
    		}
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
	   		
	   		$(".selUserDiv-panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/setUserAction.tpl");
     		$(".selUserDiv-panel").setParam('radio_value', radio_value);
     		$(".selUserDiv-panel").setParam('rowCount', 1);
            $(".selUserDiv-panel").processTemplate(sel_user_arr);
            
          	//显示品牌
	   		getUserBrand();
	   		getUserDis();
	   		
    		$(".userDiv").slideToggle(1000,function(){
    			//alert("滑动向上缩小完毕");
    		});
    		$(".selUserDiv").slideToggle(1000,function() {
    			
    		});
    		$(".userBrandDiv").slideToggle(1000,function() {
    			$("input[name=brand_row_id]").click(function(){
    				sel_brandid = $(this).val();
    				pageIndex_dis = 1;
        			getUserDis();
      			});
			});
    		$(".setUserDisDiv").slideToggle(1000,function() {
    		});
    		return false;
    	}
    	
    	function showUserList() {
    		$(".userDiv").slideToggle(1000,function() {
    			set_user = "";
    		});  
    		$(".selUserDiv").slideToggle(1000,function() {
    			//alert("滑动向下放大完毕");
    		});
    		$(".userBrandDiv").slideToggle(1000,function() {
    			pageIndex_brand = 1;
			});
    		
    		$(".setUserDisDiv").slideToggle(1000,function() {
    			//alert("滑动向下放大完毕");
    			sel_brandid = "";
    			pageIndex_dis = 1;
    		});
    	}
    	
    	function updateUserSizeStandard(key,v) {
    		
    		var sel_ids = "";
   			$('.userDis input:checkbox[name=row_id_dis]:checked').each(function(i) {
   				if(0==i){
   					sel_ids = $(this).val();
   			 	}else{
   			 		sel_ids += (","+$(this).val());
   			    }
   			});
   			
   			if (sel_ids == "") {
   				layer.msg("未找到要设置的记录，请重新登录再次尝试或与管理员联系。",{icon:5});
	   			return false;
   			}
   			
     		var cf = "确定要批量设置选中商品的";
     		var txt = "";
    		if (key == "buyerdis") {
    			txt = "[折扣]";
    		}
    		else if (key == "rebatesdis") {
    			txt = "[返利]";
    		}
    		else if (key == "bonusesdis") {
    			txt = "[奖励]";
    		}
    		else if (key == "state") {
    			if (v == '1') {
    				txt = "[状态]为[可采购]";
    			}
    			else {
    				txt = "[状态]为[禁止采购]";
    			}
    		}
    		else {
    			layer.msg("参数错误，请重新登录再次尝试或与管理员联系。",{icon:5});
	   			return false;
    		}
    		cf += txt + "吗？";
    		
    		if (key == "state") {
    			layer.confirm(cf, {
    	  			btn: ['确认', '取消']
    	  		}, 
    	  		function()	{
    	  			$.ajax({
       	    			async:false,
       	                url: "${pageContext.request.contextPath}/orderUserDis/updateUserSizeStandard.htmls",
       	                data: {ids:sel_ids,updateKey:key,updateValue:v},
       	                type: "post",
       	                dataType:"text",
       	                success: function (text) {
       	                	if(text == "success"){
       	                		getUserDis();
       	                		layer.msg("操作成功",{icon:6});
       	                	}else{
       	                		layer.msg("操作失败，请稍后再试！",{icon:6});
       	                	}
       	                },
       	                error: function (jqXHR, textStatus, errorThrown) {
       	                    alert(jqXHR.responseText);
       	                }
       	           	});
    	  		}, 
    	  		function(){
    	  			
    	  		});
    		}
    		else {
    			layer.prompt({
       				title: '请输入'+txt+'，并确认',
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
       				
       				if (num < 0) {
       					layer.msg("请输入大约0的数字。",{icon:5});
       		   			return false;
       				}
       				
       				$.ajax({
       	    			async:false,
       	                url: "${pageContext.request.contextPath}/orderUserDis/updateUserSizeStandard.htmls",
       	                data: {ids:sel_ids,updateKey:key,updateValue:num},
       	                type: "post",
       	                dataType:"text",
       	                success: function (text) {
       	                	if(text == "success"){
       	                		getUserDis();
       	                		layer.msg("操作成功",{icon:6});
       	                	}else{
       	                		layer.msg("操作失败，请稍后再试！",{icon:6});
       	                	}
       	                },
       	                error: function (jqXHR, textStatus, errorThrown) {
       	                    alert(jqXHR.responseText);
       	                }
       	           	});
       			});
    		}
    	}
    	
    	
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 150px;">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >客户采购利益设置</a></li>
		</ul>
		<div class="selUserDiv" style="display:none;padding:20px 60px;">
			<div><div class="float-left" style="margin-bottom: 10px;">客户列表</div></div>
			<div class="selUserDiv-panel"></div>
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
		<div class="userBrandDiv" style="display:none;padding:0px 60px;">
			<div>
				<table style="width:100%;margin-bottom: 10px;">
					<tr>
						<td align="left">设置客户能采购的品牌</td>
						<td align="right">
							<a href="javascript:;" class="button bg-sub button-small" onclick="addBrand()">添加品牌</a>
							<a href="javascript:;" class="button bg-dot button-small" onclick="delBrand()">删除品牌</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="userBrandDiv_panel">
			</div>
		</div>
		<div class="setUserDisDiv" style="display:none;padding:20px 60px;margin-bottom: 20px;">
			<div>
				<table style="width:100%;margin-bottom: 10px;">
					<tr>
						<td align="left">设置客户的采购利益标准</td>
						<td align="right">
							<div class="button-group border-blue button-small" style="margin-top: -2px">
								<button type="button" class="button button-small dropdown-hover">
									批量设置 <span class="downward"></span>
								</button>
								<ul class="drop-menu" style="text-align:left;width:15px">
									<li><a href="javascript:;" onclick="updateUserSizeStandard('buyerdis')">批量设置[折扣]</a></li>
									<li class="dis"><a href="javascript:;" onclick="updateUserSizeStandard('rebatesdis')">批量设置[返利]</a></li>
									<li class="dis"><a href="javascript:;" onclick="updateUserSizeStandard('bonusesdis')">批量设置[奖励]</a></li>
									<li><a href="javascript:;" onclick="updateUserSizeStandard('state','1')">批量[可采购]</a></li>
									<li><a href="javascript:;" onclick="updateUserSizeStandard('state','0')">批量[禁止采购]</a></li>
								</ul>
							</div>
							<a href="javascript:;" class="button bg-sub button-small" onclick="addSize()">添加商品</a>
							<a href="javascript:;" class="button bg-dot button-small" onclick="delSize()">删除商品</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="setUserDisDiv_panel">
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