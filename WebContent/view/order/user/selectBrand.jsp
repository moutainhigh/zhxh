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
    
    <script type="text/javascript">
    
	    var parentid = "";
		var userid = ""
		var checktype = "";
		
    	var rows;
    
    	$(function(){
    		
    	})
    	
    	function setData(data) {
    		parentid = data.parentid;
    		userid = data.userid;
    		checktype = data.checktype;
    		loadData();
    	}
    	
    	function loadData() {
    		var par = {};
    		par.parentid = parentid;
    		par.userid = userid;
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserDis/selUserBrand.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	rows = json.data;
               	 	$(".admin_panel").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/userDis/selectBrand.tpl");
               	 	$(".admin_panel").setParam('rowCount', json.total);
               	 	$(".admin_panel").setParam('path', '${pageContext.request.contextPath}');
	                $(".admin_panel").processTemplate(json.data);
	                
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
    		/* var sel_arr = sel_ids.split(",");
    		for(var i=0;i<rows.length;i++) {
    			for(var j=0;j<sel_arr.length;j++) {
    				if (sel_arr[j] == rows[i].id) {
    					result.push(rows[i]);
    				}
    			}
    		} */
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
			<div class="admin_panel">
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>
</body>
</html>