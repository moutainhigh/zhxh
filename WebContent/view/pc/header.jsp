<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="header-three">
	  	<div class="header header-width clearfix">
	    		<h1 class="logo fl"><a href="index.html"><img src="images/logo.png" /></a></h1>
	    		<ul class="user-header fr">
	    			 <li class="name"><a href="javascript:;"></a></li>
	    			 <li class="shop-cart"><a href="javascript:;"></a></li>
	    			 <li class="search" id="search"><a href="javascript:;"></a></li>
	    		</ul>
	        <a href="javascript:;" class="header-pic fr"><img src="${pageContext.request.contextPath}/images/header-pic.png" /></a>
	        <div class="nav">
            <c:forEach var="brand" items="${brandList }">
		    	<a id="${brand.id }" href="商品展示类 - 诗蜜安黛.html" >${brand.brandname }</a>
		    </c:forEach>
		    <c:forEach var="subject" items="${subjectList }">
		    	<a id="${subject.id }" href="${pageContext.request.contextPath}/pcMain/subject.htmls?id=${subject.id}">${subject.title }</a>
		    </c:forEach>
	        </div>
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
<script>
	$('#${id}').addClass('cur');
</script>