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
    	var id = "";
    	var videopath = "";
    	
	    $(function() {
			
		});
	    
	    //标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			videopath = data.videopath;
			$("#vpath").html(videopath);
		}
	    
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	    	var rows = grid.getSelecteds();
            if (rows.length == 1) {
            	CloseWindow("ok");
            } else {
                alert("请先选择。");
            }
	        
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	
	</script>
    
</head>
<body>
	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;botton:30px">
        <table style="width:100%;">
             <tbody>
	             <tr>
	                 <td style="">
						外站视频文件播放测试
	                 </td>
	                 <td style="white-space:nowrap;" width="200">
	                 </td>
	             </tr>
	         </tbody>
        </table>
    </div>
    <div class="mini-fit">
    	<div id="vpath"></div>
	</div>
	
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" style="padding:0px;border-top:1;border-left:0;border-right:0;border-bottom:0; ">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
    
</body>
</html>