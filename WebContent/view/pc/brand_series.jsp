<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${brand.brandname }-系列展示</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/pc/koala.min.1.5.js"></script>
<script type="text/javascript">
	$(function(){
		var height = $("#D1pic1").height();
		$("#fsD1").height(height);
	})
</script>
</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	<div class="shop-IMG">
		<a href='${series.picurl != ""?series.picurl:"javascript:;" }' >
			<img src="${pageContext.request.contextPath}/${series.pic }" />
		</a>		
	</div>		
	<!--轮播图-->
	<div id="fsD1" class="focus">  
	    <div id="D1pic1" class="fPic">
	    <c:forEach var="item" items="${brandlistPic }">
	    	<div class="fcon" style="display: none;">
	    		<a href='${item.pic_url != ""?item.pic_url:"javascript:;" }' >
	    			<img src="${pageContext.request.contextPath}/${item.pic_path }" style="opacity: 1; /">
	    		</a>
	    	</div>
	    </c:forEach>
	    </div>
	    <div class="fbg">  
	        <div class="D1fBt" id="D1fBt">  
	        <c:forEach var="item" items="${brandlistPic }">
	    		<a href="javascript:void(0)" hidefocus="true" target="_self" class=""><i>1</i></a>  
	    	</c:forEach>
	        </div>  
	    </div>  
	    <span class="prev"></span>   
	    <span class="next"></span>    
	</div>  
	<div class="clearfix"></div>
	<script type="text/javascript">
	  Qfast.add('widgets', { path: "${pageContext.request.contextPath}/js/pc/terminator2.2.min.js", type: "js", requires: ['fx'] });  
	  Qfast(false, 'widgets', function () {
	    K.tabs({
	      id: 'fsD1',   //焦点图包裹id  
	      conId: "D1pic1",  //** 大图域包裹id  
	      tabId:"D1fBt",  
	      tabTn:"a",
	      conCn: '.fcon', //** 大图域配置class       
	      auto: 1,   //自动播放 1或0
	      effect: 'fade',   //效果配置
	      eType: 'click', //** 鼠标事件
	      pageBt:true,//是否有按钮切换页码
	      bns: ['.prev', '.next'],//** 前后按钮配置class                          
	      interval: 3000  //** 停顿时间  
	    }) 
	  })  
	</script>
	<!--视频-->
	<div class="shop-IMG" align="center" >
	<c:forEach var="item" items="${videoList }">
		<c:choose>
			<c:when test="${item.islocal == 0 }">
				<video id="preview-player" class="video-js vjs-big-play-centered" controls preload="auto" width="800px"  poster="${pageContext.request.contextPath}/${item.videoshowpic }" data-setup="{}">
				    <source src="${pageContext.request.contextPath}/${item.mp4newname }" type="video/mp4"></source>
				    <source src="${pageContext.request.contextPath}/${item.webmnewname }" type="video/webm"></source>
				</video>
			</c:when>
			<c:otherwise>
				${item.videopath }
			</c:otherwise>
		</c:choose>
	</c:forEach>
	</div>
	<!-- 图片 -->
	<c:forEach var="item" items="${brandlist_pic }">
		<div class="shop-IMG">
			<a href='${item.pic_url != ""?item.pic_url:"javascript:;" }' >
				<img src="${pageContext.request.contextPath}/${item.pic_path }" />
			</a>
		</div>
	</c:forEach>
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/videojs_5.10.4/video-js.css">
	<script src="${pageContext.request.contextPath}/js/videojs_5.10.4/video.js"></script>
	<script src="${pageContext.request.contextPath}/js/videojs_5.10.4/videojs-mux.js"></script>
</body>
</html>