<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--头部-->
	<div class="header-three">
	  	<div class="header header-width clearfix">
	    		<h1 class="logo fl"><a href="index.html"><img src="images/logo.png" /></a></h1>
	    		<ul class="user-header fr">
	    			 <li class="name"><a href="javascript:;"></a></li>
	    			 <li class="shop-cart"><a href="javascript:;"></a></li>
	    			 <li class="search" id="search"><a href="javascript:;"></a></li>
	    		</ul>
	        <a href="javascript:;" class="header-pic fr"><img src="images/header-pic.png" /></a>
	        <div class="nav">
	            <a href="javascript:;" class="cur">诗蜜安黛</a>
	            <a href="商品展示类 - 摩漾.html">摩漾</a>
	            <a href="商品展示类 - 夏木.html">夏木</a>
	            <a href="javascript:;">定制研发</a>
	            <a href="javascript:;">项目名称</a>
	            <a href="javascript:;">项目名称</a>
	        </div>
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
	<div class="shop-banner">
	    <ul id="banner_img">
	       <li><img src="images/img.jpg" /></li>
	       <li><img src="images/banner.jpg" /></li>
	       <li><img src="images/img.jpg" /></li>
	    </ul>
	    <div class="clearfix"></div>
	    <div class="slide">
	        <span class="cur"></span>
	        <span></span>      
	        <span></span>
	    </div>
	</div>
	
	<!--banner jquery-->
	<script type="text/javascript">
	         var time = "";
	         var index = 0;
	         $(function () {
	             showimg();
	             //鼠标移入移出
	             $(".slide span").hover(function () {
	                clearTimeout(time);
	                var icon=$(this).index();
	                $(".slide span").removeClass("cur").eq(icon).addClass("cur");
	                $("#banner_img li").hide().stop(true,true).eq(icon).fadeIn("slow");
	             }, function () { 
	                index=$(this).index();
	                time = setTimeout(showimg, 3000);
	             });
	         });
	
	         function showimg() {       
	            index++;
	            if (index >= $('.slide span').length ) {
	                index = 0
	            }  
	            // index = index >= 5 ? 0 : index + 1;
	            console.log("index: "+index)
	            $(".slide span").removeClass("cur").eq(index).addClass("cur");
	            $("#banner_img li").hide().stop(true,true).eq(index).fadeIn("slow");
	            time = setTimeout(showimg, 3000);
	         }
	</script>
	
	<div class="container">
	    <div class="row clearfix">
	      <!--上面3个图片-->
	      <div class="shop-top">
	          <div class="shop-con-l">
	              <div class="shop-Img">
	                  <div class="title clearfix"><span>提拉紧致</span><a href="javascript:;">查看更多</a></div>
	                  <a href="javascript:;"><img src="images/img1.jpg" /></a>
	                  <!--注  图片要传和这个大小一样的 940*1134-->
	              </div> 
	          </div>
	          <div class="shop-con-r">
	              <div class="shop-Img top-0">
	                  <div class="title clearfix"><span>提拉紧致</span><a href="javascript:;">查看更多</a></div>
	                  <a href="javascript:;"><img src="images/img2.jpg" /></a>
	              </div>
	              <div class="shop-Img bottom-0">
	                  <div class="title clearfix"><span>提拉紧致</span><a href="javascript:;">查看更多</a></div>
	                  <a href="javascript:;"><img src="images/img2.jpg" /></a>
	              </div> 
	          </div>
	      </div>
	      <!--下面2个-->
	      <div class="shop-con-l fl">
	          <div class="shop-Img">
	              <div class="title clearfix"><span>提拉紧致</span><a href="javascript:;">查看更多</a></div>
	              <a href="javascript:;"><img src="images/img2.jpg" /></a><!--注  图片要传和这个大小一样的 940*506-->
	          </div>
	      </div>
	      <div class="shop-con-r fr">
	          <div class="shop-Img">
	              <div class="title clearfix"><span>提拉紧致</span><a href="javascript:;">查看更多</a></div>
	              <a href="javascript:;"><img src="images/img2.jpg" /></a>
	          </div>
	      </div>
	    </div>
	</div>
	
	<!--页脚-->
	<div class="footer">
	    <div class="index-footer">
	   	    <div class="fl footer-left">
	   	   	    <a href="javascript:;">FAQ</a>
	   	   	    <a href="javascript:;">联系我们</a>
	   	   	    <a href="javascript:;">工作招聘</a>
	   	   	    <a href="javascript:;">区域合作</a>
	   	   	    <a href="javascript:;">隐私政策</a>
	   	   	    <a href="javascript:;">合作伙伴</a>
	   	   	    <a href="javascript:;">法律声明</a>
	   	   	    <a href="javascript:;" class="map">网站地图</a>
	   	    </div>
	   	    <div class="fr footer-right">
	   	   	    <span>Copyright © 众恒信合</span>
	   	    </div>
	    </div>
	    <div class="footer-tk footer-Itk">
	        <div class="tit">
	          <h3>网站地图</h3>
	          <em class="close"></em>
	        </div>
	        <div class="footer-tk-con clearfix">
	          <a href="javascript:;">FAQ</a>
	          <a href="javascript:;">联系我们</a>
	            <a href="javascript:;">工作招聘</a>
	            <a href="javascript:;">区域合作</a>
	            <a href="javascript:;">隐私政策</a>
	            <a href="javascript:;">合作伙伴</a>
	            <a href="javascript:;">法律声明</a>
	            <a href="javascript:;">网站地图</a>
	            <a href="javascript:;">新闻中心</a>
	            <a href="javascript:;">说明书</a>
	            <a href="javascript:;">美容文章</a>
	            <a href="javascript:;">案例库</a>      
	        </div>
	    </div>
	</div>
</body>
</html>