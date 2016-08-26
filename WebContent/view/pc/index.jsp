<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	<!-- login -->
	<%@include file="/view/pc/login.jsp" %>
	
	<!--头部 页面头部不一样 程序注意-->
	<div class="index-header">
	  	<div class="indexheader header clearfix">
	    		<h1 class="logo fl"><a href="javascript:;"><img src="" /></a></h1>
	    		<ul class="header-user fr">
	    			 <li class="name"><a href="javascript:;"></a></li>
	    			 <li class="shop-cart"><a href="javascript:;"></a></li>
	    			 <li class="search" id="search"><a href="javascript:;"></a></li>
	    		</ul>
	  	</div>
	  	<!--搜索框-->
	  	<div class="search-box">
	    		<div class="search-box-con">
	      			<div class="search clearfix">
	      			  	<input type="text" class="txt" value="请输入一个关键词" />
	      			    <input type="button" class="but" />
	      		  </div>
	      			<div class="keywords">人气搜索关键词：<a href="javascript:;">摩漾</a><a href="javascript:;">摩漾</a><a href="javascript:;">摩漾</a><a href="javascript:;">摩漾</a></div>
	    		</div>
	  	</div>	
	</div>
	
	
	<!--banner-->
	<div class="imgbox">
	    <ul id="banner_img">
	    <c:forEach var="pic" items="${homePic }">
			<li><a href='${pic.pic_url != ""?pic.pic_url:"javascript:;" }' target="_blank"><img src="${pageContext.request.contextPath}/${pic.pic_path }" height="600px;" /></a></li>
	    </c:forEach>
	    </ul>
	    <div class="clearfix"></div>
	    <div class="imgnum">
	    <c:forEach var="brand" items="${brandList }">
	    	<a href="${pageContext.request.contextPath}/pcMain/zh.htmls?id=${brand.id}" >${brand.brandname }</a>
	    </c:forEach>
	    </div>
	    <div class="imgnum-bottom">
	    <c:forEach var="subject" items="${subjectList }">
	    	<a href="${pageContext.request.contextPath}/pcMain/subject.htmls?id=${subject.id}">${subject.title }</a>
	    </c:forEach>
	    </div>
	</div>
	<!--banner jquery-->
	<script type="text/javascript">
	         var time = "";
	         var index = 0;
	         $(function () {
	             showimg();
	
	         });
	
	         function showimg() {       
	            index++;
	            if (index >= $('#banner_img li').length ) {
	                index = 0
	            }  
	
	            $("#banner_img li").hide().stop(true,true).eq(index).fadeIn("slow");
	            time = setTimeout(showimg, 3000);
	         }
	</script>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>

</body>
</html>