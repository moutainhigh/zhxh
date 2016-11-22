<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css"> --%>
<script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
<%@include file="/view/pc/login.jsp" %>

<style>
<!--
.badge {
    display: inline-block;
    min-width: 10px;
    padding: 2px 3px;
    font-size: 12px;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    background-color: #999;
    border-radius: 2em;
    float: right;
    margin-right: -10px;
}
.bg-red {
    background-color: #e33;
}
-->
</style>

<div class="header-three" style="background: ${brand.brandcolor}">
	  	<div class="header header-width clearfix">
	    		<h1 class="logo fl" style='${brand.brandlogo == null ? "margin-top: 0px;":""}'><a href="${pageContext.request.contextPath}/pcMain/pcindex.htmls"><img style='${brand.brandlogo == null ? "width: 60px;height: 60px;":""}' src='${pageContext.request.contextPath}/${brand.brandlogo == null ? logo.pic_path:brand.brandlogo}' /></a></h1>
	    		<ul class="user-header fr">
	    			<c:choose>
	    				<c:when test="${sessionScope.pc_user_sessiion != null }">
	    					<li class="name1" style="line-height:42px;color:#fff;"><a style="color:#fff;font-weight: bold;" href="${pageContext.request.contextPath}/porder/orders.htmls" title="个人中心">${sessionScope.pc_user_sessiion.username}</a></li>
	    				</c:when>
	    				<c:otherwise>
	    					<li class="name"><a href="javascript:;" title="个人中心"></a></li>
	    				</c:otherwise>
	    			</c:choose>
	    			 <li class="shop-cart">
	    			 	<div class="cat_div">
	    			 	<c:if test='${sessionScope.cat_num != null && sessionScope.cat_num != 0  }'>
	    			 		<span id="catnum" class="badge bg-red">${sessionScope.cat_num }</span>
	    			 	</c:if>
	    			 	</div>
	    			 	<a href="javascript:cat('${sessionScope.pc_user_sessiion.id}')" title="购物车"></a>
	    			 </li>
	    			 <!-- <li class="search" id="search"><a href="javascript:;" title="检索"></a></li> -->
	    		</ul>
	    	<c:if test='${ptype eq "1" }'>
	    		<a href="${pageContext.request.contextPath}/pcMain/story-c.htmls?id=${id}" class="header-pic fr"><img src="${pageContext.request.contextPath}/images/header-pic.png" style="width:22px;height:22px;" title="品牌故事"/></a>
	    	</c:if>
	        <div class="nav">
            <c:forEach var="brand" items="${brandList }">
		    	<a id="${brand.id }" href="${pageContext.request.contextPath}/pcMain/zh.htmls?id=${brand.id}" >${brand.brandname }</a>
		    </c:forEach>
		    <a href="${pageContext.request.contextPath}/pcMain/newMap.htmls" >网站地图</a>
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
	//购车-登录框
	function cat(userid){
		if(userid == ""){
			$(".em").val("");
			$('.denglu').fadeIn(800);	
			$('.tan-bg').fadeIn(800);	
			//$(".box").toggle(); 
			$('body').one('click',function(){
		        $('.denglu').fadeOut(800);
		        $('.tan-bg').fadeOut(800);
		        $('.add-tan').fadeOut(800);
			})
			$("#uname").focus();
			return;
		}else{
			window.location.href = '${pageContext.request.contextPath}/porder/cat.htmls?userid='+userid;
		}
	}
</script>