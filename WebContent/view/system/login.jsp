<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/admin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/admin.js"></script>
    <!-- <link type="image/x-icon" href="/favicon.ico" rel="shortcut icon" />
    <link href="/favicon.ico" rel="bookmark icon" /> -->
    
    <script type="text/javascript">
    
	    if (window != top) {
			top.location.href = location.href;
		}

		$(document).ready(
			function (){
			  $('#kaptcha').click(
				  function (){
					$(this).attr('src', 'kaptcha.htmls?' + Math.floor(Math.random() * 100));
				  }
			  );
			}
		);
	</script> 
	<style>
		.doc-footer {
		    position:fixed;
			bottom:50px;
			text-align: center;
			padding: 20px 0;
		}
		.top_wz {
		    float: left;
		    font-size: 18px;
		    padding-left: 10px;
		    line-height: 70px;
		}
		.top_img {
			float: left;
			margin-left: 0px;
			margin-right: 0px;
		}
	</style>
<title>众恒信和综合管理平台</title>
</head>
<body>
	<div class="container">
	    <div class="line">
	        <div class="xs6 xm4 xs3-move xm4-move">
	            <br /><br /><br />
	            <div class="media media-y">
	                <div class="container xs6 xm4 xs3-move xm4-move text-gray">
	                	<span class="icon-bank" style="font-size: 45px;"></span>
	                	<%-- <img src="${pageContext.request.contextPath}/images/logo.png" width="64px" height="64px" class="radius" alt="" /> --%>
	                </div>
	                <%-- <div class="top_wz">
	                	${sysname }
	                </div> --%>
	            </div>
	            <br /><br /><br />
	            <form action="onlogin.htmls" method="post">
	            <div class="panel">
	                <div class="panel-head text-center"><strong>登录众恒信和管理后台</strong></div>
	                <div class="panel-body" style="padding:30px;">
	                    <div class="form-group">
	                        <div class="field field-icon-right">
	                            <input type="text" class="input" name="accountcode" placeholder="登录账号" value="admin" data-validate="required:请填写账号" />
	                            <span class="icon icon-user"></span>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="field field-icon-right">
	                            <input type="password" class="input" name="password" placeholder="登录密码" value="password" data-validate="required:请填写密码" />
	                            <span class="icon icon-key"></span>
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <div class="field">
	                            <input type="text" class="input" name="kaptchafield" placeholder="填写右侧的验证码" data-validate="required:请填写右侧的验证码" />
	                            <img  width="80" height="32" class="passcode kaptcha" style="cursor:pointer;" id="kaptcha" src="kaptcha.htmls"/>
	                        </div>
	                    </div>
	                </div>
	                <div class="panel-foot text-center"><button type="submit" class="button button-block bg-main text-big">立即登录系统</button></div>
	            </div>
	            </form>
	            <div class="text-right text-small padding-top" style="color: red;">${result }</div>
	        </div>
	    </div>
	</div>
	<div class="container doc-footer xs6 xm4 xs3-move xm4-move text-small text-gray">版权所有 亚普软件(北京)有限公司&copy; <a href="#"></a> All Rights Reserved.</div>
</body>
</html>