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

<!-- <script src="/js/jpages/jQuery.1.8.2.min.js"></script> -->
<script src="/js/jpages/jPages.js"></script>

<style type="text/css">
		h2 a{
			color: #5DB0E6;
			text-shadow: 0 0 10px #5DB0E6;
		}
		
        .holder {
    		margin: 15px 0;
			text-align:right;
    	}
    
    	.holder a {
    		font-size: 14px;
    		cursor: pointer;
    		margin: 0 5px;
    		color: #505050;
    	}
    
    	.holder a:hover {
    		background-color: #222;
    		color: #fff;
    	}
    
    	.holder a.jp-previous { margin-right: 15px; }
    	.holder a.jp-next { margin-left: 15px; }
    
    	.holder a.jp-current, a.jp-current:hover { 
    		color: #5DB0E6;
    		font-weight: bold;
			text-shadow: 1px 1px #505050;
    	}
    
    	.holder a.jp-disabled, a.jp-disabled:hover {
    		color: #bbb;
    	}
    
    	.holder a.jp-current, a.jp-current:hover,
    	.holder a.jp-disabled, a.jp-disabled:hover {
    		cursor: default; 
    		background: none;
    	}
    
    	.holder span { margin: 0 5px; }
	</style>
	
</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="width-100">
	    <div class="container shop-page clearfix">
	        <h1 class="fl">特润修护肌透精华露</h1>
	        <div class="fr shop-gwc">
	            <div class="price">价格：￥500</div>
	            <div class="num">
	                <span>数量：</span>
	                <div class="num-box">
	                    <em class="fl" onclick="jishuan(-1)">-</em>
	                    <input type="text" value="1" class="txtnum" />
	                    <em class="fr" onclick="jishuan(+1)">+</em>
	                </div>
	            </div>
	            <div class="num">
	                <span>规格：</span>
	                <div class="fl norms-div">
	                    <div class="norms cur">15ml</div>
	                    <div class="norms">40ml</div>
	                    <div class="norms">60ml</div>
	                </div>
	            </div>
	            <div class="page-gwc-but">
	                 <a href="javascript:;" class="buy">在线购买</a>
	                 <a href="javascript:;">加入购物车</a>
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
	                <div class="con" style="left:0;"><!--调整第一个显示位置请修改"left:0px;的值" -->
	                    <c:forEach var="item" items="${proList }">
	                    	<a href="${pageContext.request.contextPath}/pcMain/product_c.htmls?id=${item.id}" target="_blank" class="left">
	                        	<img src="${pageContext.request.contextPath}/${item.productpic }" />
	                        	<p>${item.productname }</p>
	                    	</a>
	                    </c:forEach>
	                </div>
	            </div>
	            <div class="btns"><a href="javascript:void(0)" class="up"></a><a href="javascript:void(0)" class="down"></a></div>
	        </div>
	    </div>
	    <div class="shop-page-cnter3 clearfix">
	        <span class="fl">评价  0</span>
	        <ul id="itemContainer" class="comment fr">
	           
	        </ul>
	        <div class="holder" style="float:left"></div>
	        <div style="float:left;margin: 15px 2px;">
				<span id="page-panel"></span>
				<span id="page-pane2"></span>
				<span id="page-pane3"></span>
				<span id="page-pane4"></span>
			</div>
	    </div>
	    <!--分页-->
	    <ul class="page">
	       
	    </ul>
	</div>
	
	<script>
	    $(function(){
	        $("div.holder").jPages({
	            containerID  : "itemContainer",
				first: '首页',
				last: '尾页',
				previous: '上页',
				next: '下页',
				perPage: 2,
	            startPage: 1,
	            startRange: 2,
	            midRange: 3,
	            endRange: 2,
				animation: 'wobble',
				keyBrowse: true,
				callback    : function( pages, items){
					pageClick(pages.current);
				  
				   $("#page-panel").html("当前页面:" + pages.current);
				   $("#page-pane2").html("页面总数:" + pages.count);
				   $("#page-pane3").html("总数量:" + items.count);
	               $("#page-pane4").html("每页数量:" + items.count/pages.count);
	
	
				}
	        });
	    
	    });
	    
	    function pageClick(pageIndex){
			$.ajax({
		    	async:false,
		        url: "${pageContext.request.contextPath}/pcMain/rated.htmls",
		        data: {'parentid':'${product.id}','pageIndex':pageIndex,'pageSize':'2'},
		        type: "post",
		        dataType:"json",
		        success: function (jsonObj) {
		        	var pageCount = jsonObj.pageCount;
		        	var rowCount = jsonObj.rowCount;
		        	for(i=0;i<jsonObj.data.length;i++){
		        		var html = ratedHTML(jsonObj.data[i].username,jsonObj.data[i].ratedmemo,jsonObj.data[i].ratedtime);
		        		$('#itemContainer').append(html)
		        	}
		        	//page(pageIndex,pageCount,rowCount);
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
	</script>




















	<script type="text/javascript">
		function page (page,pageCount,rowCount){
			var pageHtml = "";
        	pageHtml += '<li><a href="javascript:pageClick(1)" class="'+page==1?"cur":""+'">1</a></li>';
        	alert(pageHtml);
			if(pageCount != 1){
				if(page < 5){
					for(i=2;i<page;i++){
						pageHtml += '<li><a href="javascript:pageClick('+i+')" class="'+page==i?"cur":""+'">'+i+'</a></li>';
					}
				}else{
					pageHtml += '<li id="" >...</li>';
					for(i=page - 1;i<page;i++){
						pageHtml += '<li><a href="javascript:pageClick('+i+')" class="'+page==i?"cur":""+'">'+i+'</a></li>';
					}
				}
				if(page >= pageCount-4 || pageCount-4 <= 0){
					for(i=page + 1;i<pageCount;i++){
						pageHtml += '<li><a href="javascript:pageClick('+i+')" class="'+page==i?"cur":""+'">'+i+'</a></li>';
					}
				}else{
					for(i=page + 1;i<page + 3;i++){
						pageHtml += '<li><a href="javascript:pageClick('+i+')" class="'+page==i?"cur":""+'">'+i+'</a></li>';
					}
					pageHtml += '<li id="" >...</li>';
					pageHtml += '<li><a href="javascript:pageClick('+pageCount+')" class="'+page==i?"cur":""+'">'+pageCount+'</a></li>';
				}
			}
			alert(pageHtml);
			pageHtml += '<li>共'+pageCount+'页 当前第'+page+'页 共'+rowCount+'条记录</li>';
			alert(pageHtml);
			$('.page').html(pageHtml);
		}

	</script>
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>