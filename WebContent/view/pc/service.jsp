<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/faq.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con FAQ clearfix">
	    <div class="tit">FAQ</div>
	    <div class="fl FAQ-l">
	        <a id="faq" href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=faq">FAQ</a>
	        <a id="lxwm" href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=lxwm">联系我们</a>
	        <a id="job" href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=job">工作招聘</a>
	        <a id="join" href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=join">区域合作</a>
	        <a id="policy" href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=policy">隐私政策</a>
	        <a id="partner" href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=partner">合作伙伴</a>
	        <a id="law" href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=law">法律声明</a>
	    </div>
	    <div class="fr FAQ-r">
	    <c:forEach var="item" items="${serviceList }">
	    	<div class="acd-list">
	            <h2>${item.title }</h2>
	            <div class="acd-content">
	                <p>${item.memo }</p>
	                <em class="up">︿ 向上收起 </em>
	            </div>
	        </div>
	    </c:forEach>
	    </div>
	</div>
	
	<script>
		$('#${ptype}').addClass('cur');
		var title = $('#${ptype}').html();
		$('.tit').html(title);
	</script>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
	
</body>
</html>