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
<script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>

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
	
	if (window != top) {
		top.location.href = location.href;
	}
	 
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
	    
	    $("#loginform").keydown(function(e){
			var e = e || event,
			keycode = e.which || e.keyCode;
			if (keycode==13) {
				login();
			}
		});
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
	
	function trim(str){
		//删除字符串2端空格
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}
	
	function login(){
		var uname = $('#uname').val();
		var pwd = $('#pwd').val();
		
		if (trim(uname) == "") {
			layer.msg("请输入登录帐户");
			$('#uname').val("")
			$('#uname').focus();
			return;
		}
		if (trim(pwd) == "") {
			layer.msg("请输入登录密码。");
			$('#pwd').val("");
			$('#pwd').focus();
			return;
		}
		
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
                	layer.msg(text);
                }
            },
            error: function () {
            	layer.msg("失败");
            }
        });
		
	}
	
</script>
</head>
<body>
    <div class="header-three">
	  	
	</div>
	
	<div class="login-tan2 denglu" style="display: block;">
	    <div id="loginform" class="login">
	        <h3>登录账号</h3>
	        <div class="login-ipnut">
	            <div><input type="text" id="uname" value="" class="txt name" placeholder="手机"/></div>
	            <div><input type="password" id="pwd" value="" class="txt mima" placeholder="密码" /></div>
	            <div class="clearfix wjmima">
	                <a href="javascript:;" class="fr" onclick="javascript:location.href='${pageContext.request.contextPath}/plogin_reset.htmls'" target="_blank">忘记密码？</a>
	                <!-- <em class="fr">没有账号 <b class="zhuce">立即注册</b></em> -->
	            </div>
	            <div class="but"><input type="button" onclick="login()" value="登 录" class="login-but"></div>
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
	                <!-- <em class="fr">已有账号 <b class="lidenglu">立即登录</b></em> -->
	            </div>
	            <div class="but"><input type="button" value="注 册" class="login-but"></div>
	        </div>
	    </div>
	</div>
	
	
	
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
	
</body>
</html>