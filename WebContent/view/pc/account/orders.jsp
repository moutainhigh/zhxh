<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心-我的订单</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/faq.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--评价弹框-->
	<div class="tan-bg"></div>
	<div class="pj-tan">
	    <div class="pj-xq clearfix">
	        <div class="img-txt">
	            <img src="images/img3.jpg" class="fl" />
	            <div class="txt fl">
	                <a href="javascript:;">紧致毛孔柔肤精华液</a>
	                <em>Tighten The Pores Soft Skin Essence</em>
	            </div>
	        </div>
	        <div class="pj-tan-num">1</div>
	        <div class="pj-tan-price">￥300</div>
	    </div>
	    <div class="pj-dingdan">
	        <div class="pj-dingdan-con clearfix">
	            <span class="fl">评价订单</span>
	            <textarea name="" cols="" rows="" class="fl"></textarea>
	        </div>
	    </div>
	    <input type="button" value="提交评价" />
	</div>
		
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con user-con clearfix">
	    <!--左侧-->
	    <%@include file="/view/pc/account/left.jsp" %>
	    <script>
			$('#myorder').addClass('cur');
		</script>
	    <!--右侧-->
	    <div class="user-r fr">
	        <h3>我的订单</h3>
	        <div class="indent">
	            <h4>所有订单</h4>
	            <ul class="indent-tit">
	                <li class="dingdan-xq">订单详情</li>
	                <li class="dingdan-num">数量</li>
	                <li class="dingdan-Consignee">&nbsp;</li>
	                <li class="dingdan-zt">订单状态</li>
	                <li class="dingdan-cz">操作</li>
	            </ul>
	            <ul class="indent_message">
	            <c:forEach var="item" items="${orderList }">
	            	<li class="clearfix">
	                    <p>
	                      <span>${item.ordertime }</span>
	                      <span class="color">订单号： <a href="${pageContext.request.contextPath}/porder/orderinfo.htmls?id=${item.id}" target="_blank">${item.ordernumber }</a></span>
	                      <span class="color">订单金额：￥${item.ordertotal }</span>
	                    </p>
	                    <c:forEach var="pro" items="${item.orderProList }" varStatus="status" >
	                    	<div class="text-bottom clearfix">
	                        <div class="img-txt dingdan-xq">
	                            <img src="${pageContext.request.contextPath}/${pro.productpic }" class="fl" />
	                            <div class="txt fl">
	                                <a href="javascript:;">${pro.productname }</a>
	                                <em>${pro.productmemo }</em>
	                                <span>40ml</span>
	                            </div>
	                        </div>
	                        <div class="dingdan-num line-height">${pro.productnum }</div>
	                        <div class="dingdan-Consignee line-height">&nbsp;</div>
	                        <div class="dingdan-zt line-height">${item.orderstatusmemo }</div>
	                        <c:if test="${status.index == 0 }">
	                        	<div class="dingdan-cz">
	                        		<a href="${pageContext.request.contextPath}/porder/orderinfo.htmls?id=${item.id}" target="_blank">订单详情</a>
		                            <!-- <b class="del">删除</b> -->
		                            <!-- <em class="pj">评价</em> -->
		                        </div>
	                        </c:if>
	                    </div>
	                    </c:forEach>
	                </li>
	            </c:forEach>
	            </ul>
	            
	            <!--分页-->
	        <ul class="page">
            	<li><a href="javascript:window.location.href='${pageContext.request.contextPath}/porder/orders.htmls?page=1'" class="${page == 1?'cur':'' }">1</a></li>
				<c:if test="${pageCount != 1}">  
				    <c:choose>  
				        <c:when test="${page <= 5}">  
				            <c:forEach var="i" begin="2" end="${page}">  
				                <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/porder/orders.htmls?page=${i }'" class="${page == i?'cur':'' }">${i }</a></li>
				            </c:forEach>
				        </c:when>  
				        <c:otherwise>
				        	<li id="" >...</li>
				            <c:forEach var="i" begin="${page-3}" end="${page}">  
				                <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/porder/orders.htmls?page=${i }'" class="${page == i?'cur':'' }">${i }</a></li>
				            </c:forEach>  
				        </c:otherwise>  
				    </c:choose>
				    <c:choose>
				        <c:when test="${page >= pageCount-4 || pageCount-4 <= 0}">  
				            <c:forEach var="i" begin="${page + 1}" end="${pageCount}">  
				               <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/porder/orders.htmls?page=${i }'" class="${page == i?'cur':'' }">${i }</a></li>
				            </c:forEach>  
				        </c:when>  
				        <c:otherwise>  
				            <c:forEach var="i" begin="${page + 1}" end="${page + 3}">  
				                <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/porder/orders.htmls?page=${i }'" class="${page == i?'cur':'' }">${i }</a></li>
				            </c:forEach>  
				            <li id="" >...</li>
				            <li><a href="javascript:window.location.href='${pageContext.request.contextPath}/porder/orders.htmls?page=${pageCount }'" class="${page == i?'cur':'' }">${pageCount }</a></li>
				        </c:otherwise>  
				    </c:choose>  
				</c:if>
				<li>共${pageCount }页 当前第${page }页 共${rowCount }条记录</li>
			</ul>
	        </div>
	    </div>
	</div>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>