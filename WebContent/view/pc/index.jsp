<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
<style type="text/css">
<!--
.badge {
    display: inline-block;
    min-width: 10px;
    padding: 2px 3px;
    font-size: 12px;
    line-height: 1;
    color: #fff;
    text-align: center;
    white-space: nowrap;
    vertical-align: baseline;
    background-color: #999;
    border-radius: 2em;
    float: right;
    margin-right: -10px;
}
.bg-red {
    background-color: #e33;
}
-->
</style>
</head>
<body style="height:100%; position:relative; overflow:hidden">
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	<!-- login -->
	<%@include file="/view/pc/login.jsp" %>
	
	<!--头部 页面头部不一样 程序注意-->
	<div class="index-header">
	  	<div class="indexheader header clearfix">
	    		<h1 class="logo fl"><a href="javascript:;"><img style="width: 60px;height: 60px;" src="${pageContext.request.contextPath}/${logo.pic_path}" /></a></h1>
	    		<ul class="header-user fr">
	    			 <c:choose>
	    				<c:when test="${sessionScope.pc_user_sessiion != null }">
	    					<li class="name1" style="line-height:42px;color:#fff;"><a style="color:#000;font-weight: bold;" href="${pageContext.request.contextPath}/porder/orders.htmls" title="个人中心">${sessionScope.pc_user_sessiion.username}</a></li>
	    				</c:when>
	    				<c:otherwise>
	    					<li class="name"><a href="javascript:;" title="个人中心"></a></li>
	    				</c:otherwise>
	    			</c:choose>
	    			 <li class="shop-cart">
	    			 	<div class="cat_div">
	    			 	<c:if test='${sessionScope.cat_num != null && sessionScope.cat_num != 0  }'>
	    			 		<span id="catnum" class="badge bg-red">${sessionScope.cat_num }</span>
	    			 	</c:if>
	    			 	</div>
	    			 	<a href="javascript:cat('${sessionScope.pc_user_sessiion.id}')" title="购物车"></a>
	    			 </li>
	    			 <li class="search" id="search"><a href="javascript:;"></a></li>
	    		</ul>
	  	</div>
	  	<!--搜索框-->
	  	<div class="search-box">
	    		<div class="search-box-con">
	      			<div class="search clearfix">
	      			  	<input type="text" class="txt" value="请输入一个关键词" />
	      			    <input type="button" class="but" />
	      		  </div>
	      			<div class="keywords">人气搜索关键词：<a href="javascript:;">摩漾</a><a href="javascript:;">摩漾</a><a href="javascript:;">摩漾</a><a href="javascript:;">摩漾</a></div>
	    		</div>
	  	</div>	
	</div>
	
	
	<!--banner-->
	<div class="imgbox">
	    <ul id="banner_img">
	    <c:forEach var="pic" items="${homePic }">
			<li><a href='${pic.pic_url != ""?pic.pic_url:"javascript:;" }'><img src="${pageContext.request.contextPath}/${pic.pic_path }" /></a></li>
	    </c:forEach>
	    </ul>
	    <div class="clearfix"></div>
	    <div class="imgnum">
	    <c:forEach var="brand" items="${brandList }">
	    	<a href="${pageContext.request.contextPath}/pcMain/zh.htmls?id=${brand.id}" >${brand.brandname }</a>
	    </c:forEach>
	    <c:forEach var="subject" items="${subjectList }" begin="0" end="0">
	    	<a href="${pageContext.request.contextPath}/pcMain/subject.htmls?id=${subject.id}">${subject.title }</a>
	    </c:forEach>
	    </div>
	    <div class="imgnum-bottom">
	    <c:forEach var="subject" items="${subjectList }" begin="1" end="100">
	    	<a href="${pageContext.request.contextPath}/pcMain/subject.htmls?id=${subject.id}">${subject.title }</a>
	    </c:forEach>
	    </div>
	</div>
	<!--banner jquery-->
	<script type="text/javascript">
         var time = "";
         var index = 0;
         $(function () {
             showimg();

         });

         function showimg() {       
            index++;
            if (index >= $('#banner_img li').length ) {
                index = 0
            }
            var len = $('#banner_img li').length;
			if(len > 1){
				$("#banner_img li").hide().stop(true,true).eq(index).fadeIn("slow");
	            time = setTimeout(showimg, 6000);
			}
         }
         
         /* var time = "";
         var index = 0;
         $(function () {
             showimg();
             //鼠标移入移出
             $(".imgnum a").hover(function () {
                clearTimeout(time);
                var icon=$(this).index();
                $(".imgnum a").removeClass("onselect").eq(icon).addClass("onselect");
                $("#banner_img li").hide().stop(true,true).eq(icon).fadeIn("slow");
             }, function () { 
                index=$(this).index();
                time = setTimeout(showimg, 3000);
             });
         });

         function showimg() {       
            index++;
            if (index >= $('.imgnum a').length ) {
                index = 0
            }  
            // index = index >= 5 ? 0 : index + 1;
            console.log("index: "+index)
            $(".imgnum a").removeClass("onselect").eq(index).addClass("onselect");
            $("#banner_img li").hide().stop(true,true).eq(index).fadeIn("slow");
            time = setTimeout(showimg, 3000);
         } */
         
         
         //购车-登录框
         function cat(userid){
         	if(userid == ""){
         		$(".em").val("");
         		$('.denglu').fadeIn(800);	
         		$('.tan-bg').fadeIn(800);	
         		//$(".box").toggle(); 
         		$('body').one('click',function(){
         	        $('.denglu').fadeOut(800);
         	        $('.tan-bg').fadeOut(800);
         	        $('.add-tan').fadeOut(800);
         		})
         		$("#uname").focus();
         		return;
         	}else{
         		window.location.href = '${pageContext.request.contextPath}/porder/cat.htmls?userid='+userid;
         	}
         }
	</script>
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>

</body>
</html>