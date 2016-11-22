<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 

<link rel="stylesheet" href="${pageContext.request.contextPath}/js/videojs_5.10.4/video-js.css">
<script src="${pageContext.request.contextPath}/js/videojs_5.10.4/video.js"></script>
<script src="${pageContext.request.contextPath}/js/videojs_5.10.4/videojs-mux.js"></script>

<script type="text/javascript">

	$(function(){
		var myPlayer = videojs('preview-player');
	    videojs("preview-player").ready(function(){
	        var myPlayer = this;
	        myPlayer.play();
	    });
	})

</script>

</head>
<body>
	<video id="preview-player"
		class="video-js vjs-default-skin vjs-big-play-centered" controls
		preload="auto"
		poster=""
		width="680" height="480"
		data-setup="{}">
		<source
			src="${pageContext.request.contextPath}/${fileurl}"
			type="video/mp4"></source>
	</video>
</body>
</html>