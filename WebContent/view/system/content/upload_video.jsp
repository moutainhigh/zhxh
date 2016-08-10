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
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/plupload-2.1.8/js/plupload.full.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/plupload-2.1.8/js/i18n/zh_CN.js"></script>
    
    <script type="text/javascript">
    	var id = "";
    	var videotype = "";
    	
	    $(function() {
		    
		});
	    
	    //标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			id = data.id;
			videotype = data.videotype;
			
			var uploader = new plupload.Uploader({
	    		runtimes : 'html5,flash,silverlight,html4',
	    		browse_button : 'pickfiles', // you can pass an id...
	    		container: document.getElementById('container'), // ... or DOM Element itself
	    		multi_selection: false,
	    		max_file_count:1,
	    		url : "${pageContext.request.contextPath}/common/upload_video.htmls?id="+id+"&videotype="+videotype,
	    		chunk_size : '2mb',
	    		// Flash settings
		        flash_swf_url : '${pageContext.request.contextPath}/js/plupload-2.1.8/js/Moxie.swf',
		     
		        // Silverlight settings
		        silverlight_xap_url : '${pageContext.request.contextPath}/js/plupload-2.1.8/js/Moxie.xap',
		        
	    		filters : {
	    			max_file_size : '500mb',
	    			mime_types: [
	    				{title : "视频文件", extensions : "mp4,webm"}
	    			]
	    		},

	    		init: {
	    			PostInit: function() {
	    				document.getElementById('filelist').innerHTML = '';

	    				document.getElementById('uploadfiles').onclick = function() {
	    					uploader.start();
	    					return false;
	    				};
	    			},

	    			FilesAdded: function(up, files) {
	    				plupload.each(files, function(file) {
	    					for (var i=0;i<up.files.length;i++) {
	    						if (up.files[i].id != file.id) {
	    							up.removeFile(up.files[i]);
	    						}
	    					}
	    					if (up.files.length == 1) {
	    						document.getElementById('filelist').innerHTML = '<div id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ')<b></b></div>';
	    					}
	    				});
	    			},
	    			FileUploaded:function(up,file,result){
	    				/* var d = JSON.parse(result.response);
	    				grid.setData(d); */
	    			},

	    			UploadProgress: function(up, file) {
	    				document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
	    			},

	    			Error: function(up, err) {
	    				document.getElementById('console').appendChild(document.createTextNode("\nError #" + err.code + ": " + err.message));
	    			}
	    		}
	    	});

	    	uploader.init();
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
	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <table style="width:100%;">
             <tbody>
	             <tr>
	                 <td style="">
						<div id="filelist" style="float:left;padding-left:5px;">请选择视频文件。</div>
						<div id="console"></div>
	                 </td>
	                 <td style="white-space:nowrap;" width="200">
	                 	<div id="container" style="float:right">
	                 		<a id="pickfiles" class="mini-button" plain="true" name="auth">选择视频文件</a>
	                 		<a id="uploadfiles" class="mini-button" iconCls="icon-upload" plain="true"  name="auth">上传</a>
						</div>
	                 </td>
	             </tr>
	         </tbody>
        </table>
    </div>
    <div class="mini-fit">
		<!-- <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div> -->
    </div>                
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" style="padding:0px;border-top:1;border-left:0;border-right:0;border-bottom:0; ">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>