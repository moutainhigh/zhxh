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
	<link href="${pageContext.request.contextPath}/js/videojs5.8/video-js.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/js/videojs5.8/video.js"></script>
	
    <script type="text/javascript">
    	var id = "";
    	var mp4path = "";
    	var webmpath = "";
    	
	    $(function() {
	    	var poster = "${pageContext.request.contextPath}/file/upload/1af06e63-3cd1-4783-8d91-99ca55782a5b.jpg";
			$('#my-video').attr('poster', poster);
		});
	    
	    //标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			id = data.id;
			mp4path = data.mp4path;
			webmpath = data.webmpath;
			
			var myPlayer = videojs("my-video");
			myPlayer.src({type: "video/mp4", src: "${pageContext.request.contextPath}/" + mp4path});
			myPlayer.src({type: "video/webm", src: "${pageContext.request.contextPath}/" + webmpath});
			
						
			
			/* changeVideoSrc = function(url) {
			    var myPlayer = videojs('playerId'),
			       videoSrc = options.promoLocation + url,
			    poster = videoSrc.replace(/.mp4/, '.jpg');
			       myPlayer.posterImage.show();
			     myPlayer.src({type: "video/mp4", src: videoSrc});
			     myPlayer.one('canplay', function() {
			     $('video').attr('poster', poster);
			     });
			}; */


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
		<video id="my-video" class="video-js vjs-default-skin vjs-big-play-centered" controls preload="auto" width="640" height="264" poster="" data-setup="{}">
			<!-- <source src="MY_VIDEO.mp4" type='video/mp4'>
			<source src="MY_VIDEO.webm" type='video/webm'> -->
			<p class="vjs-no-js">
				要查看此视频请启用JavaScript，并考虑升级到现代高版本Web浏览器。
			</p>
		</video>
	</div>                
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" style="padding:0px;border-top:1;border-left:0;border-right:0;border-bottom:0; ">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>