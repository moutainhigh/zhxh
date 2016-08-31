<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单详情</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/faq.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con dingdanxq-con clearfix">
	    <div class="text5_3_box7 clearfix">
	        <div class="text5_3_box7_1">
	            <b class="cur"></b>
	            <h2></h2><h3></h3>
	            <p>待支付</p>
	        </div>
	        <div class="text5_3_box7_1">
	            <b class="cur"></b>
	            <h2></h2><h3></h3>
	            <p>待发货</p>
	        </div>
	        <div class="text5_3_box7_1">
	            <b class="cur"></b>
	            <h2></h2>
	            <p class="cur">已发货</p>
	        </div>
	        <div class="text5_3_box7_1 text5_3_box7_w">
	            <b></b>
	            <p>完成</p>
	        </div>
	    </div>
	    <div class="indent">
	        <h4>物流信息</h4>
	        <ul class="logistics-top">
	            <li class="time">处理时间</li>
	            <li class="xx">处理信息</li>
	            <li class="czr">操作人</li>
	        </ul>
	        <ul class="logistics-con">
	            <li class="clearfix">
	                <div class="time">2016-07-20 12:36:13</div>
	                <div class="xx">您提交了订单，请等待系统确认</div>
	                <div class="czr">客户</div>
	            </li>
	            <li class="clearfix">
	                <div class="time">2016-07-20 15:40:33</div>
	                <div class="xx">第三方卖家已经开始拣货</div>
	                <div class="czr">商家</div>
	            </li>
	            <li class="clearfix">
	                <div class="time">2016-07-20 16:02:01</div>
	                <div class="xx">您的订单已经拣货完毕，待出库交付申通快递，运单号为229111673599<br />运单号为：229111673599    </div>
	                <div class="czr">商家</div>
	            </li>
	            <li class="clearfix">
	                <div class="time">2016-07-20 19:30:13</div>
	                <div class="xx">由广东东莞南城西平分部 发往 广东东莞中转部</div>
	                <div class="czr">申通快递</div>
	            </li>
	            <li class="clearfix">
	                <div class="time">2016-07-21 00:36:53</div>
	                <div class="xx">由广东东莞中转部 发往 北京中转部</div>
	                <div class="czr">申通快递</div>
	            </li>
	
	            <li class="clearfix">
	                <div class="time">2016-07-21 00:36:53</div>
	                <div class="xx">广东东莞中转部 正在进行 装袋 扫描</div>
	                <div class="czr">申通快递</div>
	            </li>
	            <li class="clearfix">
	                <div class="time">2016-07-21 18:55:48</div>
	                <div class="xx">快件已到达北京中转部</div>
	                <div class="czr">申通快递</div>
	            </li>
	            <li class="clearfix">
	                <div class="time">2016-07-22 07:10:54</div>
	                <div class="xx">由北京中转部 发往 北京丰台五里店公司</div>
	                <div class="czr">申通快递</div>
	            </li>
	            <li class="clearfix">
	                <div class="time">2016-07-22 07:12:00</div>
	                <div class="xx">北京丰台五里店公司 的收件员 扫描员1已收件</div>
	                <div class="czr">申通快递</div>
	            </li>
	        </ul>
	    </div>
	    <div class="indent">
	        <h4>订单商品</h4>
	        <p>收货信息：<span>${orderPath.username }</span><span>${orderPath.userphone }</span><span>${orderPath.userpath }，${orderPath.postcode }</span></p>
	        <!-- <span>订单编号： <em>844537679884777 </em>          付款方式：账户余额支付</span> -->
	        <ul class="dingdanxq-top clearfix">
	            <li class="dingdansp">商品</li>
	            <li class="dingdannum">数量</li>
	            <li class="dingdanprice">价格</li>
	            <li class="dingdanzt">订单状态</li>
	            <li class="dingdancz">操作</li>
	        </ul>
	        <ul class="dingdanxq-message">
	        	<c:forEach var="item" items="${proList }">
	        		<li class="clearfix">
		                <div class="img-txt dingdansp">
		                    <img src="${pageContext.request.contextPath}/${item.productpic }" class="fl" />
		                    <div class="txt fl">
		                        <a href="javascript:;">${item.productname }</a>
		                        <em>${item.productmemo }</em>
		                        <span>${item.productsize }</span>
		                    </div>
		                </div>
		                <div class="dingdannum line-height">${item.productnum }</div>
		                <div class="dingdanprice line-height">${item.price }</div>
		                <div class="dingdanzt line-height">已完成</div>
		                <div class="dingdancz">
		                    <b>确认收货</b>
		                    <!-- <em class="pj">评价</em> -->
		                </div>
		            </li>
	        	</c:forEach>
	        </ul>
	    </div>
	    <a href="javascript:;" class="back">返回</a>
	</div>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>