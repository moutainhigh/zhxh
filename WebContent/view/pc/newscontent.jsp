<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新闻</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con dzyf">
		<div class="new-ny-tit">
	        <h3>${news.title }</h3>
	        <p><span>发布时间：${news.createtime } </span></p>
	        <DIV class=bshare-custom><A class=bshare-qzone title=分享到QQ空间></A><A class=bshare-sinaminiblog title=分享到新浪微博></A><A class=bshare-renren title=分享到人人网></A><A class=bshare-qqmb title=分享到腾讯微博></A><A class=bshare-douban title=分享到豆瓣></A><A class="bshare-more bshare-more-icon more-style-addthis" title=更多平台></A><SPAN class="BSHARE_COUNT bshare-share-count">0</SPAN></DIV>
	        <SCRIPT src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh" type=text/javascript charset="utf-8"></SCRIPT>
	        <SCRIPT src="http://static.bshare.cn/b/bshareC0.js" type=text/javascript charset="utf-8"></SCRIPT>
	    </div>
	    <div class="new-content" style="line-height:20px;text-indent:2em">${news.memo}</div>
	</div>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
	<!-- 看到这里我就想骂人，在苹果手机中（垃圾苹果），加载视频的 js要放在页面底部最后加载 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/videojs_5.10.4/video-js.css">
	<script src="${pageContext.request.contextPath}/js/videojs_5.10.4/video.js"></script>
	<script src="${pageContext.request.contextPath}/js/videojs_5.10.4/videojs-mux.js"></script>
</body>
</html>