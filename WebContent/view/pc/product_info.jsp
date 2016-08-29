<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详情</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

<link rel="stylesheet" href="${pageContext.request.contextPath}/js/videojs_5.10.4/video-js.css">
<script src="${pageContext.request.contextPath}/js/videojs_5.10.4/video.js"></script>
<script src="${pageContext.request.contextPath}/js/videojs_5.10.4/videojs-mux.js"></script>

<script src="${pageContext.request.contextPath}/js/page/jquery.page.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/page/page_css.css">
</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="width-100">
	    <div class="container shop-page clearfix">
	        <h1 class="fl">${product.productname }</h1>
	        <div class="fr shop-gwc">
	            <div class="price">价格：￥${product.saleprice }</div>
	            <div class="num">
	                <span>数量：</span>
	                <div class="num-box">
	                    <em class="fl" onclick="jishuan(-1)">-</em>
	                    <input id="quantity" type="text" value="1" class="txtnum" />
	                    <em class="fr" onclick="jishuan(+1)">+</em>
	                </div>
	            </div>
	            <div class="num">
	                <span>规格：</span>
	                <div class="fl norms-div">
	                <c:forEach var="item" items="${psizeList }">
	                	<a href="javascript:window.location.href='${pageContext.request.contextPath}/pcMain/product_c.htmls?id=${item.id }';"><div class='norms ${product.id eq item.id ?"cur":"" }'>${item.productsize }</div></a>
	                </c:forEach>
	                </div>
	            </div>
	            <div class="page-gwc-but">
	                 <a href="${pageContext.request.contextPath}/porder/orderconf.htmls?id=${product.id}" class="buy">在线购买</a>
	                 <a href="javascript:addCat('${sessionScope.pc_user_sessiion.id}');">加入购物车</a>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="">
	 <c:choose>
	 	<c:when test="${pcontent != null }">
	 		${pcontent.memo}
	 	</c:when>
	 	<c:otherwise>
	 	<c:forEach var="item" items="${proPics}">
	 		<img width="100%" src="${pageContext.request.contextPath}/${item.pic_path}">
	 	</c:forEach>
	 	</c:otherwise>
	 </c:choose>
	</div>
	<div class="HTML-con">
	   
	    <div class="shop-page-cnter2">
	        <h3>相关商品</h3>
	        <div class="area">
	            <div class="cons">
	                <%-- <div class="con" style="left:0;"><!--调整第一个显示位置请修改"left:0px;的值" -->
	                    <c:forEach var="item" items="${proList }">
	                    	<a href="${pageContext.request.contextPath}/pcMain/product_c.htmls?id=${item.id}" target="_blank" class="left">
	                        	<img src="${pageContext.request.contextPath}/${item.productpic }" />
	                        	<p>${item.productname }</p>
	                    	</a>
	                    </c:forEach>
	                </div> --%>
	            </div>
	            <div class="btns"><a href="javascript:void(0)" class="up"></a><a href="javascript:void(0)" class="down"></a></div>
	        </div>
	    </div>
	    <div class="shop-page-cnter3 clearfix">
	        <span class="fl">评价  <span id="p_count"></span></span>
	        <ul id="itemContainer" class="comment fr">
	           
	        </ul>
	    </div>
	    <!--分页-->
	    <div class="tcdPageCode" style="text-align: center;"></div>
	</div>
	
	<script>
		var pageCount = 0;
		var	rowCount = 0;
		var pageSize = 5;
		$(function(){
			//初始加載，第一頁
			$.ajax({
		    	async:false,
		        url: "${pageContext.request.contextPath}/pcMain/rated.htmls",
		        data: {'parentid':'${product.productid}','pageIndex':1,'pageSize':pageSize},
		        type: "post",
		        dataType:"json",
		        success: function (jsonObj) {
		        	pageCount = jsonObj.pageCount;
		        	rowCount = jsonObj.rowCount;
		        	$('#p_count').html(rowCount);
		        	for(i=0;i<jsonObj.data.length;i++){
		        		var html = ratedHTML(jsonObj.data[i].username,jsonObj.data[i].ratedmemo,jsonObj.data[i].ratedtime);
		        		$('#itemContainer').append(html)
		        	}
		        },
		        error: function (jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.responseText);
		        }
		    });
			//創建分頁
			$(".tcdPageCode").createPage({
		        pageCount:pageCount,
		        current:1,
		        backFn:function(p){
		        	pageClick(p)
		        }
		    });
			
		});
		
		//分頁請求數據
	    function pageClick(pageIndex){
			$.ajax({
		    	async:false,
		        url: "${pageContext.request.contextPath}/pcMain/rated.htmls",
		        data: {'parentid':'${product.productid}','pageIndex':pageIndex,'pageSize':pageSize},
		        type: "post",
		        dataType:"json",
		        success: function (jsonObj) {
		        	$('#itemContainer').html('');
		        	for(i=0;i<jsonObj.data.length;i++){
		        		var html = ratedHTML(jsonObj.data[i].username,jsonObj.data[i].ratedmemo,jsonObj.data[i].ratedtime);
		        		$('#itemContainer').append(html)
		        	}
		        },
		        error: function (jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.responseText);
		        }
		    });
		}
		//评价内容HTML
		function ratedHTML(username,memo,tatedtime){
			var html = ''
				+'<li class="clearfix">'
				+'	<div class="fl">'
				+'    	<em>'+username+'</em>'
				+'    	<p>'+memo+'</p>'
				+'	</div>'
				+'	<b class="fr">'+tatedtime+'</b>'
				+'</li>';
			return html;
		}
		
		//加入购物车
		function addCat(userid){
			if(userid == ""){
				$('.denglu').fadeIn(800);	
				$('.tan-bg').fadeIn(800);	
				//$(".box").toggle(); 
				$('body').one('click',function(){
			        $('.denglu').fadeOut(800);
			        $('.tan-bg').fadeOut(800);
			        $('.add-tan').fadeOut(800);
				})
				return;
			}else{
				var quantity = $('#quantity').val();
				$.ajax({
			    	async:false,
			        url: "${pageContext.request.contextPath}/porder/catAdd.htmls",
			        data: {'userid':userid,'productsizeid':'${product.id}','quantity':quantity},
			        type: "post",
			        dataType:"text",
			        success: function (text) {
			        	alert(text);
			        },
			        error: function (jqXHR, textStatus, errorThrown) {
			            alert(jqXHR.responseText);
			        }
			    });
			}
		}
		
	</script>

	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>