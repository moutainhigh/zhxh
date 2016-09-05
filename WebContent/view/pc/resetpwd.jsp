<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>重置密码</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/index.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
<style>
	.login-but2 {
	    width: 130px;
	    height: 42px;
	    background: #666;
	    text-align: center;
	    font-weight: bold;
	    font-size: 14px;
	    color: #fff;
	    cursor: pointer;
	    margin-top: 0px;
	}
	.reset-txt {
	    width: 215px;
	    height: 40px;
	    text-indent: 10px;
	    font-size: 14px;
	    color: #ccc;
	    font-family: '宋体';
	    border: solid 1px #ddd;
	}
</style>

</head>
<body>
	
<div class="wjmm-logo">
    <h1><a href="${pageContext.request.contextPath}/pcMain/pcindex.htmls"><img src="${pageContext.request.contextPath}/${logo.pic_path }" /></a></h1>
</div>

<div class="wjmm-con">
    <div class="steps">
        <h3 class="xian"></h3>
        <div class="steps-list cur">
            <b></b>
            <span>确认账号</span>
        </div>
        <div class="steps-list">
            <b></b>
            <span>重设完成</span>
        </div>
    </div>
    <div align="center" class="wjmm-form">
        <div class="itme"><input id="umobile" type="text" value="" class="wjmm-txt error" placeholder="请输入手机号" /></div>
        <div class="itme">
        	<input id="sendcode" name="sendcode" type="text" value="" class="reset-txt" placeholder="验证码" />
        	<input type="button" value="获取验证码" class="huoqu login-but2" onclick="getSendCode()" />
        </div>
        <div class="itme"><input id="password" type="text" value="" class="wjmm-txt" placeholder="请输入新密码" /></div>
        <div class="itme"><a href="javascript:;" class="wjmm-but">下一步</a></div>
    </div>
</div>

<div class="wjmm-footer">
    <p>Copyright © 众恒信合化妆品有限公司　 京ICP备12345678号-1　 版权所有众恒信合化妆品有限公司</p>
</div>	
<script type="text/javascript">

	$(function(){
		$("#umobile").focus();
		//
		$(".wjmm-but").click(function(){
			var mobile = $('#umobile').val();
			var sendcode = $('#sendcode').val();
			var password = $('#password').val();
			
			var flag = validatemobile(mobile);
			if(!flag){
				layer.msg("请输入正确的手机号");
				$("#umobile").focus();
				return false;
			}else if(trim(sendcode) == ""){
				layer.msg("请输入验证码");
				return false;
			}else if(trim(password) == ""){
				layer.msg("请输入密码");
				return false;
			}
			
			var user = {};
			user.phonenumber = mobile;
			user.password = password;
			user.sendcode = sendcode;
			
			$.ajax({
            	url: "${pageContext.request.contextPath}/plogin_resetpwd.htmls",
            	data:user,
            	type:"post",
            	dataType:"text",
                success: function (text) {
                	if (text == "codeerror") {
                		layer.msg("验证码错误，请重新输入。");
                	}
                	else if (text == "phoneerror") {
                		layer.msg("手机号码错误，请使用正确的手机号码。");
                	}
                	else if (text == "timeout") {
                		layer.msg("验证码超时，请重新获取验证码。");
                	}
                	else if(text == "success"){
                		location.href="${pageContext.request.contextPath}/plogin_pwdfinish.htmls";
                    }else{
                    	layer.msg(text);
                    }
                },
                error: function () {
                    layer.msg("失败");
                }
            });
			
		});
	});
	function validatemobile(mobile) {
		if (trim(mobile) == "") {
	        return false; 
	    }     
	    if(mobile.length!=11) {
	    	return false; 
	    } 
	    var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
	    if(!myreg.test(mobile)) {
	        return false; 
	    }
	    return true;
	} 
	
	function getSendCode() {
		
		var phonenumber = $('#umobile').val();
		
		if (trim(phonenumber) == "") {
			layer.msg("请输入手机号码。");
			$('#umobile').val("");
			$('#umobile').focus();
			return;
		}
		
		if (!validatemobile(phonenumber) ) {
			layer.msg("请正确输入手机号码。");
			$('#umobile').val("");
			$('#umobile').focus();
			return;
		}
		
		//获取
		$.ajax({
	    	url: "${pageContext.request.contextPath}/plogin_resetGetCode.htmls",
	    	data:{'phonenumber':phonenumber},
	    	type:"post",
	    	dataType:"text",
	        success: function (text) {
	        	if (text == "empty") {
	        		layer.msg("未获取到手机号码，请重新输入手机号码，再获取短信验证码.");
					$('#umobile').focus();
					return;
	        	}
	        	else if (text == "exist") {
	        		layer.msg("手机号码不存在，请重新输入手机号码，再获取短信验证码.");
					$('#umobile').focus();
					return;
	        	}else{
	            	layer.msg("测试的验证码:" + text);
	            	opentime();
	            }
	        },
	        error: function () {
	            layer.msg("失败");
	            return;
	        }
	    });
	}
	
	var wait=120;
	function opentime() {
		var o = $(".huoqu");
		if (wait == 0) {  
	        o.removeAttr("disabled");
	        o.val("获取验证码");
	        wait = 120;
	    } else {
	    	o.attr("disabled", true);
	        o.val("重新发送(" + wait + ")");
	        wait--;  
	        setTimeout(function() {  
	        	opentime(o);
	        },  
	        1000)
	    }
	}
	
	function trim(str){
		//删除字符串2端空格
		return str.replace(/(^\s*)|(\s*$)/g, "");
	}
</script>
</body>
</html>