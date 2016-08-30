<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新闻</title>

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
	    <div class="user-l fl">
	        <span>欢迎回来，孙俪！</span>
	        <div class="user-nav">
	            <a href="个人中心.html"><b></b>我的账户</a>
	            <a href="javascript:;" class="cur"><b></b>我的订单</a>
	            <a href="我的信息.html"><b></b>我的信息</a>
	            <a href="我的提现.html"><b></b>我的提现</a>
	            <a href="我的提问.html"><b></b>我的提问</a>
	        </div>
	    </div>
	    <!--右侧-->
	    <div class="user-r fr">
	        <h3>我的订单</h3>
	        <div class="indent">
	            <h4>所有订单</h4>
	            <ul class="indent-tit">
	                <li class="dingdan-xq">订单详情</li>
	                <li class="dingdan-num">数量</li>
	                <li class="dingdan-Consignee">收货人</li>
	                <li class="dingdan-zt">订单状态</li>
	                <li class="dingdan-cz">操作</li>
	            </ul>
	            <ul class="indent_message">
	                <li class="clearfix">
	                    <p>
	                      <span>2016-07-14</span>
	                      <span class="color">订单号： 1234567890</span>
	                      <span class="color">订单金额：￥300</span>
	                    </p>
	                    <div class="text-bottom clearfix">
	                        <div class="img-txt dingdan-xq">
	                            <img src="images/img3.jpg" class="fl" />
	                            <div class="txt fl">
	                                <a href="javascript:;">紧致毛孔柔肤精华液</a>
	                                <em>Tighten The Pores Soft Skin Essence</em>
	                                <span>40ml</span>
	                            </div>
	                        </div>
	                        <div class="dingdan-num line-height">1</div>
	                        <div class="dingdan-Consignee line-height">孙俪</div>
	                        <div class="dingdan-zt line-height">待付款</div>
	                        <div class="dingdan-cz">
	                            <b class="del">删除</b>
	                            <em class="pj">评价</em>
	                        </div>
	                    </div>
	                </li>
	                <li class="clearfix">
	                    <p>
	                      <span>2016-07-14</span>
	                      <span class="color">订单号： 1234567890</span>
	                      <span class="color">订单金额：￥300</span>
	                    </p>
	                    <div class="text-bottom clearfix">
	                        <div class="img-txt dingdan-xq">
	                            <img src="images/img3.jpg" class="fl" />
	                            <div class="txt fl">
	                                <a href="javascript:;">紧致毛孔柔肤精华液</a>
	                                <em>Tighten The Pores Soft Skin Essence</em>
	                                <span>40ml</span>
	                            </div>
	                        </div>
	                        <div class="dingdan-num line-height">1</div>
	                        <div class="dingdan-Consignee line-height">孙俪</div>
	                        <div class="dingdan-zt line-height">待发货</div>
	                        <div class="dingdan-cz">
	                            <b class="del">删除</b>
	                            <em class="pj">评价</em>
	                        </div>
	                    </div>
	                </li>
	                <li class="clearfix">
	                    <p>
	                      <span>2016-07-14</span>
	                      <span class="color">订单号： 1234567890</span>
	                      <span class="color">订单金额：￥300</span>
	                    </p>
	                    <div class="text-bottom clearfix">
	                        <div class="img-txt dingdan-xq">
	                            <img src="images/img3.jpg" class="fl" />
	                            <div class="txt fl">
	                                <a href="javascript:;">紧致毛孔柔肤精华液</a>
	                                <em>Tighten The Pores Soft Skin Essence</em>
	                                <span>40ml</span>
	                            </div>
	                        </div>
	                        <div class="dingdan-num line-height">1</div>
	                        <div class="dingdan-Consignee line-height">孙俪</div>
	                        <div class="dingdan-zt line-height">已发货</div>
	                        <div class="dingdan-cz">
	                            <b class="del">删除</b>
	                            <em class="pj">评价</em>
	                        </div>
	                    </div>
	                </li>
	                <li class="clearfix">
	                    <p>
	                      <span>2016-07-14</span>
	                      <span class="color">订单号： 1234567890</span>
	                      <span class="color">订单金额：￥300</span>
	                    </p>
	                    <div class="text-bottom clearfix">
	                        <div class="img-txt dingdan-xq">
	                            <img src="images/img3.jpg" class="fl" />
	                            <div class="txt fl">
	                                <a href="javascript:;">紧致毛孔柔肤精华液</a>
	                                <em>Tighten The Pores Soft Skin Essence</em>
	                                <span>40ml</span>
	                            </div>
	                        </div>
	                        <div class="dingdan-num line-height">1</div>
	                        <div class="dingdan-Consignee line-height">孙俪</div>
	                        <div class="dingdan-zt line-height">已签收</div>
	                        <div class="dingdan-cz">
	                            <b class="del">删除</b>
	                            <em class="pj">评价</em>
	                        </div>
	                    </div>
	                </li>
	            </ul>
	        </div>
	    </div>
	</div>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>