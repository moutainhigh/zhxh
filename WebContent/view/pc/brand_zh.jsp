<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	
	<!--banner-->
	<div class="shop-banner">
	    <ul id="banner_img">
	    <c:forEach var="item" items="${brandPicList }">
	    	<li><img src="${pageContext.request.contextPath}/${item.pic_path }" height="580px;"/></li>
	    </c:forEach>
	    </ul>
	    <div class="clearfix"></div>
	    <div class="slide">
		    <c:forEach var="item" items="${brandPicList }">
		    	<span></span>
		    </c:forEach>
	    </div>
	</div>
	
	<!--banner jquery-->
	<script type="text/javascript">
	         var time = "";
	         var index = 0;
	         $(function () {
	             showimg();
	             //鼠标移入移出
	             $(".slide span").hover(function () {
	                clearTimeout(time);
	                var icon=$(this).index();
	                $(".slide span").removeClass("cur").eq(icon).addClass("cur");
	                $("#banner_img li").hide().stop(true,true).eq(icon).fadeIn("slow");
	             }, function () { 
	                index=$(this).index();
	                time = setTimeout(showimg, 3000);
	             });
	         });
	
	         function showimg() {       
	            index++;
	            if (index >= $('.slide span').length ) {
	                index = 0
	            }  
	            // index = index >= 5 ? 0 : index + 1;
	            console.log("index: "+index)
	            $(".slide span").removeClass("cur").eq(index).addClass("cur");
	            $("#banner_img li").hide().stop(true,true).eq(index).fadeIn("slow");
	            time = setTimeout(showimg, 3000);
	         }
	</script>
	
	<div class="container">
	    <div class="row clearfix">
	      <!--上面3个图片-->
	      <div class="shop-top">
	          <div class="shop-con-l">
	              <div class="shop-Img">
	              	<c:forEach var="item" items="${bfList }" begin="0" end="0">
	    				<div class="title clearfix"><span>${item.title }</span><a href="javascript:;">查看更多</a></div>
	                  	<a href="javascript:;"><img src="${pageContext.request.contextPath}/${item.firstpic}" /></a>
	    			</c:forEach>
	                  <!--注  图片要传和这个大小一样的 940*1134-->
	              </div> 
	          </div>
	          <div class="shop-con-r">
	          <c:forEach var="item" items="${bfList }" begin="1" end="1">
	              <div class="shop-Img top-0">
	                  <div class="title clearfix"><span>${item.title }</span><a href="javascript:;">查看更多</a></div>
	                  <a href="javascript:;"><img src="${pageContext.request.contextPath}/${item.firstpic}"/></a>
	              </div>
	          </c:forEach>
	          <c:forEach var="item" items="${bfList }" begin="2" end="2">
	              <div class="shop-Img bottom-0">
	                  <div class="title clearfix"><span>${item.title }</span><a href="javascript:;">查看更多</a></div>
	                  <a href="javascript:;"><img src="${pageContext.request.contextPath}/${item.firstpic}" /></a>
	              </div> 
	          </c:forEach>
	          </div>
	      </div>
	      <!--下面2个-->
	      <c:forEach var="item" items="${bfList }" begin="3" end="100" varStatus="status">
	      	<c:choose>
	      		<c:when test="${status.count%2 == 0 }">
	      			<div class="shop-con-r fr">
			          <div class="shop-Img">
			              <div class="title clearfix"><span>${item.title }</span><a href="javascript:;">查看更多</a></div>
		                  <a href="javascript:;"><img src="${pageContext.request.contextPath}/${item.firstpic}" /></a>
			          </div>
			      </div>
	      		</c:when>
	      		<c:otherwise>
	      			<div class="shop-con-l fl">
				          <div class="shop-Img">
				          	  <div class="title clearfix"><span>${item.title }</span><a href="javascript:;">查看更多</a></div>
			                  <a href="javascript:;"><img src="${pageContext.request.contextPath}/${item.firstpic}" /></a>
				              <!--注  图片要传和这个大小一样的 940*506-->
				          </div>
				      </div>
	      		</c:otherwise>
	      	</c:choose>
	      </c:forEach>
	    </div>
	</div>

	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>