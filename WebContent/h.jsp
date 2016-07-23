<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>jQuery MiniUI Demo</title>
<meta content="text/html; charset=UTF-8" http-equiv="content-type" />

	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/admin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/admin.js"></script>

</head>
<body>
	<div class="panel border-main" style="width: 60%; margin-left: 250px; margin-top: 100px;">
		<div class="panel-body">
			<div class="view-body">
				<div class="keypoint bg">
					<h1>你好，${sessionScope.CURRENT_USER_IN_SESSION.accountcode }!</h1>
					<p>欢迎使用本系统。请点击功能菜单，操作档案管理功能。</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>