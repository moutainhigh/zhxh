<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网站地图</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

<style type="text/css">
	dd a {
		margin-left: 120px;
	}
	
	dt a {
		margin-left: 120px;
	}
	dl {
		margin-left: 10px;
	}
</style>

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con" style="text-align:center;">
	    <h3 class="shoplist-tit" style="">网站地图</h3>
	    <div class="shoplist clearfix" style="text-align:center;">
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/news.htmls" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/news.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>新闻中心</span>
	                <a href="${pageContext.request.contextPath}/pcMain/news.htmls" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=join" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/qyhz.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>区域合作</span>
	                <a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=join" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=job" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/gzzp.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>工作招聘</span>
	                <a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=job" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/article.htmls" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/mrwz.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>美容文章</span>
	                <a href="${pageContext.request.contextPath}/pcMain/article.htmls" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/spec.htmls" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/sms.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>下载专区</span>
	                <a href="${pageContext.request.contextPath}/pcMain/spec.htmls" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=faq" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/FAQ.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>FAQ</span>
	                <a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=faq" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=policy" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/yszc.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>隐私政策</span>
	                <a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=policy" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=partner" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/hzhb.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>合作伙伴</span>
	                <a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=partner" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=law" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/flsm.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>法律声明</span>
	                <a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=law" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/cases.htmls" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/alk.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>案例库</span>
	                <a href="${pageContext.request.contextPath}/pcMain/cases.htmls" >查看详情</a>
	            </dd>
	        </dl>
	    	<dl>
	            <dt class="fl">
	            	<a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=lxwm" >
	            		<img src="${pageContext.request.contextPath}/images/newMap/lxwm.jpg" height="200px" />
	            	</a>
	            </dt>
	            <dd class="fl" style="padding: 0px 20px 0px 15px">
	                <span>联系我们</span>
	                <a href="${pageContext.request.contextPath}/pcMain/service.htmls?ptype=lxwm" >查看详情</a>
	            </dd>
	        </dl>
	    </div>
	</div>
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>