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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/view/order/css/page.css">
	<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/view/order/css/table.css"> --%>
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
		.admin {width: 100%; padding: 20px;background: #fff;right: 0; bottom: 0;top: 87px;overflow: auto;}
    </style>
    <script type="text/javascript">
    	var userid = '${sessionScope.pc_user_sessiion.id}';
    	var identity = '${sessionScope.pc_user_sessiion.identity}';
    	//机构分页
    	var pageIndex = 1;
    	var pageSize = 10;
    	var totalPage = 0;
    	//品牌分页
    	var pageIndex_brand = 1;
    	var pageSize_brand = 1;
    	var totalPage_brand = 0;
    	
    	//采购标准设置翻页
    	var pageIndex_dis = 1;
    	var pageSize_dis = 1;
    	var totalPage_dis = 0;
    	
    	var rows = [];
    	
    	var searchmap = "";
    	var radio_value = "";
    	
    	//设置用
    	var set_parentid = "";
    	
    	var sel_brandid= "";
    	
    	var disConfig = "";
    	
    	$(function(){
    		list();
    	    
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
    	
		function list() {
    		
    		var par = {};
    		par.userid = userid;
    		par.pageIndex = pageIndex-1;
    		par.pageSize = pageSize;
    		
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUser/getParentlist.htmls",
                data: par,
                //data: {'parentid':parentid,identity:radio_value,pageIndex:pageIndex-1,pageSize:pageSize},
                type: "post",
                dataType:"json",
                success: function (json) {
                	rows = json.data;
                 	//totalPage = Math.ceil(json.total/pageSize);
               	 	//$(".admin-panel").setTemplateElement("Template-List-user-show");
               	 	$("#parents").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/parentList.tpl");
	         		//$(".parents").setParam('rowCount', json.total);
	         		//$(".parents").setParam('pageSize', pageSize);
	         		//$(".parents").setParam('pageIndex', pageIndex);
	         		//$(".parents").setParam('totalPage', totalPage);
	                $("#parents").processTemplate(json.data);
	                
	                //bindTdClick();
	                //pageSel();
	                //pageEnter("userList");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
    	
    	function pageSel(type) {
    		
    		if (type == "brand") {
        		$('#pageBrandSel').change(function(){ 
        			var p1=$(this).children('option:selected').val();//这就是selected的值
        			pageIndex_brand = 1;
       				pageSize_brand = p1;
              		getUserBrand(set_parentid);
        		}) 
    		}
    		if (type == "dis") {
        		$('#pageDisSel').change(function(){ 
        			var p1=$(this).children('option:selected').val();//这就是selected的值
        			pageIndex_dis = 1;
        			pageSize_dis = p1;
        			getUserDis(sel_brandid);
        		}) 
    		}
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
                    			list();
                    		}
                		}
                		if (type == "brand") {
                			if ($(this).val() > totalPage_brand || $(this).val() < 1 || $(this).val() == pageIndex_brand) {
                    			return false;
                    		}
                    		else {
                    			pageIndex_brand = $(this).val();
                    			getUserBrand(set_parentid);
                    		}
                		}
                		else if (type == "dis") {
                			if ($(this).val() > totalPage_dis || $(this).val() < 1 || $(this).val() == pageIndex_dis) {
                    			return false;
                    		}
                    		else {
                    			pageIndex_dis = $(this).val();
                    			getUserDis(sel_brandid);
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
    		if (pagetype == "brand") {
    			pageIndex_brand = sel_page;
    			getUserBrand(set_parentid);
    		}
    		else if (pagetype == "dis") {
    			pageIndex_dis = sel_page;
    			getUserDis(sel_brandid);
    		}
    	}
    		
    	function getParentDis(id) {
    		if (identity == "C") {
    			getUserRatio(id);
    		}
    		set_parentid = id;
    		sel_brandid = "";
    		getUserBrand(id);
    		getUserDis("");
    	}
    	
    	//获取机构奖励转
    	function getUserRatio(id) {
    		var par = {};
    		par.parentid = id;
    		par.userid = userid;
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserDis/listParentRatio.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	if (json != "") {
                		$("#parentBonusesDiv_panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/parentRatio.tpl");
                        $("#parentBonusesDiv_panel").processTemplate(json);
                	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
    	
    	function getUserBrand(id) {
    		
    		var par = {};
    		par.parentid = id;
    		par.userid = userid;
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
                	$("#parentBrandDiv_panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/parentBrand.tpl");
                	$("#parentBrandDiv_panel").setParam('pageSize', pageSize_brand);
	         		$("#parentBrandDiv_panel").setParam('pageIndex', pageIndex_brand);
	         		$("#parentBrandDiv_panel").setParam('totalPage', totalPage_brand);
             		$("#parentBrandDiv_panel").setParam('rowCount', json.total);
             		$("#parentBrandDiv_panel").setParam('path', '${pageContext.request.contextPath}');
                    $("#parentBrandDiv_panel").processTemplate(json.data);
                    
                    pageEnter("brand");
                    pageSel("brand");
                    //bindTrClick("userBrand");
                    
                    /* $("input[name=brand_row_id]").unbind("click").click(function(){
        				sel_brandid = $(this).val();
        				pageIndex_dis = 1;
            			getUserDis();
          			}); */
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
    	
    	function showSizeDis(brandid) {
    		pageIndex_dis = 1;
			getUserDis(brandid);
    	}
    	
    	function getUserDis(brandid) {
    		sel_brandid = brandid;
    		if (brandid == "") {
    			var tmp = [];
    			$("#parentDisDiv_panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/parentDis.tpl");
         		$("#parentDisDiv_panel").setParam('rowCount', 0);
         		$("#parentDisDiv_panel").setParam('pageSize', pageSize_dis);
         		$("#parentDisDiv_panel").setParam('pageIndex', 1);
         		$("#parentDisDiv_panel").setParam('totalPage', 0);
         		$("#parentDisDiv_panel").setParam('path', '${pageContext.request.contextPath}/');
                $("#parentDisDiv_panel").processTemplate(tmp);
    		}
    		else {
	    		var par = {};
	    		par.parentid = set_parentid;
	    		par.userid = userid;
	    		par.brandid = brandid;
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
	                	$("#parentDisDiv_panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/parentDis.tpl");
	             		$("#parentDisDiv_panel").setParam('rowCount', json.total);
	             		$("#parentDisDiv_panel").setParam('pageSize', pageSize_dis);
	             		$("#parentDisDiv_panel").setParam('pageIndex', pageIndex_dis);
	             		$("#parentDisDiv_panel").setParam('totalPage', totalPage_dis);
	             		$("#parentDisDiv_panel").setParam('radio_value',identity);
	             		$("#parentDisDiv_panel").setParam('path', '${pageContext.request.contextPath}/');
	                    $("#parentDisDiv_panel").processTemplate(json.data);
	                    
	                    pageEnter("dis");
	                    pageSel("dis");
	                    //bindTrClick("userDis");
	                  //调用全选插件
		        	    //$.fn.check({ checkall_name: "checkall_dis", checkbox_name: "row_id_dis" });
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
	                }
	           });
    		}
    	}
    	
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >我的采购利益</a></li>
		</ul>
		<div class="admin">
			<div class="line-big">
				<div id="parents" class="x5">
					<!-- 父级账户列表 -->
				</div>
				<div class="x7">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>我的奖励转货款系数</strong>
						</div>
						<div id="parentBonusesDiv_panel" class="panel-body">
							<p>暂无数据</p>
						</div>
					</div>
					<div class="panel border-sub" style="margin-top: 20px">
						<div class="panel-head">
							<strong>可采购品牌列表</strong>
						</div>
						<div id="parentBrandDiv_panel" class="panel-body">
							<p>暂无数据</p>
						</div>
					</div>
					<div class="panel border-sub" style="margin-top: 20px">
						<div class="panel-head">
							<strong>可采购商品规格列表</strong>
						</div>
						<div id="parentDisDiv_panel" class="panel-body">
							<p>暂无数据</p>
						</div>
					</div>
				</div>
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