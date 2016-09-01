<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>说明书</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con download">  
	    <h3>说明书</h3>
	    <div class="download-a clearfix">
	    <c:forEach var="item" items="${specList }">
	    	<a href="${pageContext.request.contextPath}/pcMain/downloadfile.htmls?id=${item.id }">
	            <img src="${pageContext.request.contextPath}/${item.pic }">
	            <span>${item.title }</span>
	            <em><c:if test="${null != item.file_path }">下载</c:if></em>
	        </a>
	    </c:forEach>
	    </div>
	    <!--分页-->
        <ul class="page">
           	<li><a href="javascript:window.location.href='${pageContext.request.contextPath}/pcMain/spec.htmls?ptype=${ptype }&page=1'" class="${page == 1?'cur':'' }">1</a></li>
			<c:if test="${pageCount != 1}">  
			    <c:choose>  
			        <c:when test="${page <= 5}">  
			            <c:forEach var="i" begin="2" end="${page}">  
			                <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/pcMain/spec.htmls?ptype=${ptype }&page=${i }'" class="${page == i?'cur':'' }">${i }</a></li>
			            </c:forEach>
			        </c:when>  
			        <c:otherwise>
			        	<li id="" >...</li>
			            <c:forEach var="i" begin="${page-3}" end="${page}">  
			                <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/pcMain/spec.htmls?ptype=${ptype }&page=${i }'" class="${page == i?'cur':'' }">${i }</a></li>
			            </c:forEach>  
			        </c:otherwise>  
			    </c:choose>
			    <c:choose>
			        <c:when test="${page >= pageCount-4 || pageCount-4 <= 0}">  
			            <c:forEach var="i" begin="${page + 1}" end="${pageCount}">  
			               <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/pcMain/spec.htmls?ptype=${ptype }&page=${i }'" class="${page == i?'cur':'' }">${i }</a></li>
			            </c:forEach>  
			        </c:when>  
			        <c:otherwise>  
			            <c:forEach var="i" begin="${page + 1}" end="${page + 3}">  
			                <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/pcMain/spec.htmls?ptype=${ptype }&page=${i }'" class="${page == i?'cur':'' }">${i }</a></li>
			            </c:forEach>  
			            <li id="" >...</li>
			            <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/pcMain/spec.htmls?ptype=${ptype }&page=${pageCount }'" class="${page == i?'cur':'' }">${pageCount }</a></li>
			        </c:otherwise>  
			    </c:choose>  
			</c:if>
			<li>共${pageCount }页 当前第${page }页 共${rowCount }条记录</li>
		</ul>
	</div>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>