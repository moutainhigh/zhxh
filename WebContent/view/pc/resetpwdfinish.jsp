<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>重置密码</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />

</head>
<body>
	
<div class="wjmm-logo">
    <h1><a href="${pageContext.request.contextPath}/pcMain/pcindex.htmls"><img src="${pageContext.request.contextPath}/${logo.pic_path }" /></a></h1>
</div>

<div class="wjmm-con">
    <div class="steps">
        <h3 class="xian"></h3>
        <div class="steps-list">
            <b></b>
            <span>确认账号</span>
        </div>
        <div class="steps-list cur">
            <b></b>
            <span>重设完成</span>
        </div>
    </div>
    <div class="wjmm-form">
        <img src="${pageContext.request.contextPath}/images/correct.jpg" />
        <p>重置密码成功！</p>
    </div>
</div>
<div class="wjmm-footer">
    <p>Copyright © 众恒信合化妆品有限公司　 京ICP备12345678号-1　 版权所有众恒信合化妆品有限公司</p>
</div>	

</body>
</html>