<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	            <div><input type="text" value="" class="txt em" placeholder="真实姓名"/></div>
	            <div><input type="text" value="" class="txt em" placeholder="手机号码"/></div>
	            <div><input type="text" value="" class="txt em" placeholder="密码" /></div>
	            <div>
	            	<input type="text" value="" class="yzm em" placeholder="验证码" />
	            	<input type="button" value="获取验证码" class="huoqu login-but2" onclick="getCode()" />
	            	<!-- <a href="javascript:;" class="huoqu" onclick="getCode()">获取验证码</a> -->
	            </div>
	            <div class="clearfix wjmima">
	                <em class="fr">已有账号 <b class="lidenglu">立即登录</b></em>
	            </div>
	            <div class="but"><input type="button" value="注 册" class="login-but"></div>
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
		
		function getCode() {
			//获取
			$.ajax({
            	url: "${pageContext.request.contextPath}/plogin_getCode.htmls",
            	data:{},
            	type:"post",
            	dataType:"text",
                success: function (text) {
                    if(text == "success"){
                    	location.reload();
                    }else{
                    	alert("测试的验证码:" + text);
                    }
                },
                error: function () {
                    alert("失败");
                }
            });
			
			opentime();
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