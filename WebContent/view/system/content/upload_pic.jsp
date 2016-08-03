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
    
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/js/plupload-2.1.8/js/jquery.plupload.queue/css/jquery.plupload.queue.css" media="screen" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/plupload-2.1.8/js/plupload.full.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/plupload-2.1.8/js/jquery.plupload.queue/jquery.plupload.queue.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/plupload-2.1.8/js/i18n/zh_CN.js"></script>
    
    <script type="text/javascript">
    	var parentid = "";
    	var parenttype = "";
	    $(function() {
		    
		});
	    
	    //标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			parentid = data.parentid;
			parenttype = data.parenttype;
			
			// Setup html5 version
		    $("#uploader").pluploadQueue({
		        // General settings
		        runtimes : 'html5,flash,silverlight,html4',
		        url : "${pageContext.request.contextPath}/common/upload.htmls?parentid="+parentid+"&parenttype="+parenttype,
		        chunk_size : '2mb',
		        //rename : true,
		        //dragdrop: true,
		         
		        filters : {
		            // Maximum file size
		            max_file_size : '500mb'
		            // Specify what files to browse for
		           /*  mime_types: [
		                {title : "Image files", extensions : "jpg,gif,png"},
		                {title : "Zip files", extensions : "zip"}
		            ] */
		        },
		 
		        // Resize images on clientside if we can
		        /* resize: {
		            width : 200,
		            height : 200,
		            quality : 90,
		            crop: true // crop to exact dimensions
		        }, */
		 
		 
		        // Flash settings
		        flash_swf_url : '${pageContext.request.contextPath}/js/plupload-2.1.8/js/Moxie.swf',
		     
		        // Silverlight settings
		        silverlight_xap_url : '${pageContext.request.contextPath}/js/plupload-2.1.8/js/Moxie.xap'
		    });
			
			//grid.load({ fileids: fileids,treeid:treeid});
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
	<div class="mini-fit">
		<div id="uploader" style="width:100%;height:100%">
	    <p>您的浏览器不支持Flash、Silverlight、HTML5.请更换浏览器。</p>
    </div>
</body>
</html>