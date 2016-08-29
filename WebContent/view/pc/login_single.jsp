<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 

<style>
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

<script>
	$('#${id}').addClass('cur');
	
	$(function(){
		$('b.zhuce').click(function(){
	    	//$('.denglu').fadeOut(200);
	    	//$('.add-tan').fadeIn(200);
			$('.denglu').hide();
	    	$('.add-tan').fadeIn(200);
	    })
	    $('b.lidenglu').click(function(){
	    	$('.add-tan').hide();
	    	$('.denglu').fadeIn(200);
	    	
	    })
	})
	
	/*function cat(userid){
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
			window.location.href = '${pageContext.request.contextPath}/porder/cat.htmls?userid='+userid;
		}
	}*/
	
	function login(){
		var uname = $('#uname').val();
		var pwd = $('#pwd').val();
		
		$.ajax({
        	url: "${pageContext.request.contextPath}/plogin.htmls",
        	data:{'uname':uname,'pwd':pwd},
        	type:"post",
        	dataType:"text",
            success: function (text) {
                if(text == "success"){
                	window.location.href = '${pageContext.request.contextPath}/pcMain/pcindex.htmls';
                	//location.reload();
                }else{
                	alert(text);
                }
            },
            error: function () {
                alert("失败");
            }
        });
		
	}
	
</script>
</head>
<body>
    <div class="header-three">
	  	<div class="header header-width clearfix">
	    		<h1 class="logo fl"><a href="${pageContext.request.contextPath}/pcMain/pcindex.htmls"><img src="${pageContext.request.contextPath}/images/logo.png" /></a></h1>
	    		<ul class="user-header fr">
	    			<c:choose>
	    				<c:when test="${sessionScope.pc_user_sessiion != null }">
	    					<li class="name1"><a href="javascript:;">${sessionScope.pc_user_sessiion.phonenumber}</a></li>
	    				</c:when>
	    				<c:otherwise>
	    					<li class="name"><a href="javascript:;"></a></li>
	    				</c:otherwise>
	    			</c:choose>
	    			 <li class="shop-cart"><span class="badge bg-red">8</span><a href="javascript:cat('${sessionScope.pc_user_sessiion.id}')"></a></li>
	    			 <li class="search" id="search"><a href="javascript:;"></a></li>
	    		</ul>
	        <a href="javascript:;" class="header-pic fr"><img src="${pageContext.request.contextPath}/images/header-pic.png" /></a>
	        <div class="nav">
            <c:forEach var="brand" items="${brandList }">
		    	<a id="${brand.id }" href="${pageContext.request.contextPath}/pcMain/zh.htmls?id=${brand.id}" >${brand.brandname }</a>
		    </c:forEach>
		    <c:forEach var="subject" items="${subjectList }">
		    	<a id="${subject.id }" href="${pageContext.request.contextPath}/pcMain/subject.htmls?id=${subject.id}">${subject.title }</a>
		    </c:forEach>
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
	
	<div class="login-tan2 denglu" style="display: block;">
	    <div class="login">
	        <h3>登录账号</h3>
	        <div class="login-ipnut">
	            <div><input type="text" id="uname" value="" class="txt name" placeholder="手机或邮箱"/></div>
	            <div><input type="text" id="pwd" value="" class="txt mima" placeholder="密码" /></div>
	            <div class="clearfix wjmima">
	                <a href="忘记密码.html" class="fl">忘记密码？</a>
	                <em class="fr">没有账号 <b class="zhuce">立即注册</b></em>
	            </div>
	            <div class="but"><input type="button" onclick="login()" value="登 录" class="login-but"></div>
	            <div class="other-login">
	                <h3></h3>
	                <span>第三方登录</span>
	                <div class="login-bottom">
	                    <%-- <a href="javascript:;"><img src="${pageContext.request.contextPath}/images/qq.jpg" /></a>
	                    <a href="javascript:;"><img src="${pageContext.request.contextPath}/images/weixin.jpg" /></a> --%>
	                </div>
	            </div>    
	        </div>
	    </div>
	</div>
	
	<!--注册弹框-->
	<div class="login-tan2 add-tan" style="display: none;">
	    <div class="login">
	        <h3>加入我们</h3>
	        <div class="login-ipnut">
	            <div><input type="text" value="姓名" class="txt" /></div>
	            <div><input type="text" value="手机/邮箱" class="txt" /></div>
	            <div><input type="text" value="密码" class="txt" /></div>
	            <div><input type="text" value="验证码" class="yzm" /><a href="javascript:;" class="huoqu">获取验证码</a></div>
	            <div class="clearfix wjmima">
	                <em class="fr">已有账号 <b class="lidenglu">立即登录</b></em>
	            </div>
	            <div class="but"><input type="button" value="注 册" class="login-but"></div>
	        </div>
	    </div>
	</div>
	
	
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
	
</body>
</html>