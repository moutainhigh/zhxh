<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

	<style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    
    </style>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    
    <script type="text/javascript">
	    
	    var grid;
	    
	    var fieldObject = [];
		fieldObject[0] = {"id":"0","text":"禁止采购"};
		fieldObject[1] = {"id":"1","text":"可采购"};
		
	    $(function(){
	    	mini.parse();
	    	
	    })
	    
	  	//标准方法接口定义
		function SetData(data) {
			/* //跨页面传递的数据
			data = mini.clone(data);    //必须
			var parentid = data.parentid;
			var userid = data.userid;
			
			grid_brand.load({ parentid: parentid,userid:userid }); */
		}
	    
	    function GetData() {
			var field = mini.get("field");
			
	        return field.getValue();
	    }
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	    	//判断是否选择了数据
	    	var rows = GetData();
	    	if (rows.length == 0) {
	    		CloseWindow("cancel");
	    	}
	    	else {
	    		CloseWindow("ok");
	    	}
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	</script>
	
</head>
<body>
    <div class="mini-fit">
    	<div style="margin-left: 50px;margin-top: 10px">
    		请选择状态:<br><input id="field" class="mini-combobox" style="width:150px;" textField="text" valueField="id" data="fieldObject" value="0">
    	</div>
        
    </div>              
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border-bottom: 0;border-top: 1;border-left:0;border-right:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">更改</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>