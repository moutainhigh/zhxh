<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="user-l fl">
    <span>欢迎回来，${sessionScope.pc_user_sessiion.username}</span>
    <div class="user-nav">
        <!-- <a id="" href="个人中心.html"><b></b>我的账户</a> -->
        <a id="myorder" href="${pageContext.request.contextPath}/porder/orders.htmls"><b></b>我的订单</a>
        <a id="myinfo" href="${pageContext.request.contextPath}/porder/info.htmls"><b></b>我的信息</a>
        <a id="myaddress" href="${pageContext.request.contextPath}/porder/address.htmls"><b></b>收货地址</a>
        <c:if test='${sessionScope.pc_user_sessiion.identity != "Z" }'>
        	<a id="orderSystem" target="_blank" href="${pageContext.request.contextPath}/order/ordermain.htmls"><b></b>采购系统</a>
         	<a id="orderSystem" target="_blank" href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/z/main_z"><b></b>分期购</a>
        </c:if>
        
        <!-- <a id="myquiz" href="我的提问.html"><b></b>我的提问</a> -->
        <a id="myaddress" href="${pageContext.request.contextPath}/pcMain/plogout.htmls"><b></b>退出登录</a>
    </div>
</div>
