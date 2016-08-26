<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!--登录的弹框  只做了index 每个页面都可以-->
	<div class="tan-bg"></div>
	<div class="login-tan denglu">
	    <div class="login">
	        <h3>登录账号</h3>
	        <div class="login-ipnut">
	            <div><input type="text" value="手机或邮箱" class="txt name" /></div>
	            <div><input type="text" value="密码" class="txt mima" /></div>
	            <div class="clearfix wjmima">
	                <a href="忘记密码.html" class="fl">忘记密码？</a>
	                <em class="fr">没有账号 <b class="zhuce">立即注册</b></em>
	            </div>
	            <div class="but"><input type="button" value="登 录" class="login-but"></div>
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