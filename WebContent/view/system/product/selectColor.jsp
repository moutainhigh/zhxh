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
	    		$("#s_color").val(color);
	    	});
	    })
	    
	    function GetData() {
	    	s_color = $("#s_color").val();
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
          <label id="memo">请选择颜色[两种方式：<br>1、点击取色区域，选择颜色。2、自主输入颜色代码，输入标准为 #000000  颜色代码可以在网上查到]</label>
    </div>
    <div class="mini-fit" style="text-align: center;">
    	<div style="width: 80%;margin:auto; margin-top: 50px">
	    	颜色代码：<input name="s_color" id="s_color" type="text" value="" />
			<a href="javascript:void(0)" id="img" style="margin-left: 140px;margin-top: 20px;"></a>
    	</div>
    </div>                
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">选择</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>