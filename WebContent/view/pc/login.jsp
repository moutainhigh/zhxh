<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<script src="${pageContext.request.contextPath}/js/json2.js"></script>
	<!--登录的弹框  只做了index 每个页面都可以-->
	<div class="tan-bg"></div>
	<div class="login-tan denglu">
	    <div class="login">
	        <h3>登录账号</h3>
	        <div class="login-ipnut">
	            <div><input type="text" id="uname" value="" class="txt name em" placeholder="手机或邮箱"/></div>
	            <div><input type="password" id="pwd" value="" class="txt mima em" placeholder="密码" /></div>
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
	<div class="login-tan add-tan">
	    <div class="login">
	        <h3>加入我们</h3>
	        <div class="login-ipnut">
	            <div><input id="username" name="username" type="text" value="" class="txt em" placeholder="真实姓名"/></div>
	            <div><input id="phonenumber" name="phonenumber" type="text" value="" class="txt em" placeholder="手机号码"/></div>
	            <div><input id="password" name="password" type="password" value="" class="txt em" placeholder="密码" /></div>
	            <div>
	            	<input id="sendcode" name="sendcode" type="text" value="" class="yzm em" placeholder="验证码" />
	            	<input type="button" value="获取验证码" class="huoqu login-but2" onclick="getSendCode()" />
	            	<!-- <a href="javascript:;" class="huoqu" onclick="getCode()">获取验证码</a> -->
	            </div>
	            <div class="clearfix wjmima">
	                <em class="fr">已有账号 <b class="lidenglu">立即登录</b></em>
	            </div>
	            <div class="but"><input type="button" value="注 册" class="login-but" onclick="reg()"></div>
	        </div>
	    </div>
	</div>
	
	<style>
	<!--
		.login-but2 {
		    width: 132px;
		    height: 42px;
		    background: #666;
		    text-align: center;
		    font-weight: bold;
		    font-size: 14px;
		    color: #fff;
		    cursor: pointer;
		    margin-top: 0px;
		}
	-->
	</style>
	
	<script type="text/javascript">
	
		function trim(str){
			//删除字符串2端空格
			return str.replace(/(^\s*)|(\s*$)/g, "");
		}
	
		function login(){
			var uname = $('#uname').val();
			var pwd = $('#pwd').val();
			
			if (trim(uname) == "") {
				alert("请输入登录帐户。");
				$('#uname').val("")
				$('#uname').focus();
				return;
			}
			if (trim(pwd) == "") {
				alert("请输入登录密码。");
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
                    	location.reload();
                    }else{
                    	alert(text);
                    }
                },
                error: function () {
                    alert("失败");
                }
            });
			
		}
		
		function reg(){
			var username = $('#username').val();
			var phonenumber = $('#phonenumber').val();
			var password = $('#password').val();
			var sendcode = $('#sendcode').val();
			
			if (trim(username) == "") {
				alert("请输入真实姓名。");
				$('#username').val("")
				$('#username').focus();
				return;
			}
			if (trim(phonenumber) == "") {
				alert("请输入手机号码。");
				$('#phonenumber').val("");
				$('#phonenumber').focus();
				return;
			}
			if (trim(sendcode) == "") {
				alert("请输入短信验证码。");
				$('#sendcode').val("");
				$('#sendcode').focus();
				return;
			}
			if (trim(password) == "") {
				alert("请输入登录密码。");
				$('#password').val("");
				$('#password').focus();
				return;
			}
			
			var user = {};
			user.username = username;
			user.phonenumber = phonenumber;
			user.password = password;
			user.sendcode = sendcode;
			
			$.ajax({
            	url: "${pageContext.request.contextPath}/plogin_reg.htmls",
            	data:user,
            	type:"post",
            	dataType:"text",
                success: function (text) {
                	if (text == "codeerror") {
                		alert("验证码错误，请重新输入。");
                	}
                	else if (text == "phoneerror") {
                		alert("手机号码错误，请使用正确的手机号码。");
                	}
                	else if (text == "timeout") {
                		alert("验证码超时，请重新获取验证码。");
                	}
                	else if(text == "success"){
                		alert("注册成功。请登录。");
                		$(".em").val("");
                		$('.denglu').fadeIn(800);
                    	$('.add-tan').fadeOut(800);
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
			
			var phonenumber = $('#phonenumber').val();
			
			if (trim(phonenumber) == "") {
				alert("请输入手机号码。");
				$('#phonenumber').val("");
				$('#phonenumber').focus();
				return;
			}
			
			if (!validatemobile(phonenumber) ) {
				alert("请正确输入手机号码。");
				$('#phonenumber').val("");
				$('#phonenumber').focus();
				return;
			}
			
			//获取
			$.ajax({
            	url: "${pageContext.request.contextPath}/plogin_getCode.htmls",
            	data:{'phonenumber':phonenumber},
            	type:"post",
            	dataType:"text",
                success: function (text) {
                	if (text == "empty") {
                		alert("未获取到手机号码，请重新输入手机号码，再获取短信验证码.");
        				$('#phonenumber').focus();
        				return;
                	}
                	else if (text == "exist") {
                		alert("手机号码已注册过，请重新输入手机号码，再获取短信验证码.");
        				$('#phonenumber').focus();
        				return;
                	}
                	else if(text == "success"){
                    	location.reload();
                    }else{
                    	alert("测试的验证码:" + text);
                    	opentime();
                    }
                },
                error: function () {
                    alert("失败");
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
	</script>