<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="user-l fl">
    <span>${sessionScope.pc_user_sessiion.phonenumber}</span>
    <div class="user-nav">
        <!-- <a id="" href="个人中心.html"><b></b>我的账户</a> -->
        <a id="myorder" href="${pageContext.request.contextPath}/porder/orders.htmls"><b></b>我的订单</a>
        <a id="myinfo" href="${pageContext.request.contextPath}/porder/info.htmls"><b></b>我的信息</a>
        <a id="myaddress" href="${pageContext.request.contextPath}/porder/address.htmls"><b></b>收货地址</a>
        <!-- <a id="myquiz" href="我的提问.html"><b></b>我的提问</a> -->
        <a id="myaddress" href="${pageContext.request.contextPath}/pcMain/plogout.htmls"><b></b>退出登录</a>
    </div>
</div>
