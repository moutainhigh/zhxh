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
    <%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/colorpicker/jquery.colorpicker.js"></script> --%>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery.bigcolorpicker/jquery.bigcolorpicker.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.bigcolorpicker/jquery.bigcolorpicker.min.js"></script>
    
    <script type="text/javascript">
	    //mini.parse();
	    
	    var grid;
	    var s_color="";
	    $(function(){
	    	mini.parse();
	    	//$("#btn").bigColorpicker("sel_color");
	    	$("#img").bigColorpicker(function(el,color){
	    		s_color = color;
	    		$(el).css("background-color",color);
	    	});
	    })
	    
	    function GetData() {
	    	return s_color;
	    }
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	        CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	    function onRowDblClick(e) {
	        onOk();
	    }
	
	</script>
	
	<style type="text/css">
		#img{width:220px;height:120px;display:block; border:1px solid #d3d3d3;}
	</style>
    
</head>
<body>
	<div class="mini-toolbar" style="text-align:center;line-height:30px;" borderStyle="border:0;">
          <label id="memo">请选择颜色</label>
    </div>
    <div class="mini-fit">
		<!-- <input name="name" id="sel_color" class="mini-textbox" /><a id="btn" class="mini-button " plain="true" iconCls="icon-add" onclick="onClick">选色</a> -->
		<a href="javascript:void(0)" id="img" style="margin-left: 100px;margin-top: 20px"></a>
    </div>                
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">选择</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>