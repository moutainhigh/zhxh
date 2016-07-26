<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/admin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/boot.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/admin.js"></script>
    
    <script type="text/javascript">
	    function updatepass(id) {
			
			var url = "${pageContext.request.contextPath}/common/dispatch.do?page=/view/account/updateAccount";
			var title = "修改帐户信息";
	    	mini.open({
	            url: url,
	            title: title, width:500, height:400,
	            allowResize:true,
	            onload: function () {
	            	
	            },
	            ondestroy: function (action) {
	            }
	        });
			
		}
    </script>
    <style type="text/css">
    	body {
    		line-height: 15px;
    	}
    </style>
</head>
<body>
	<div class="admin">
		<div class="line-big">
			<div class="xm3">
				<div class="panel border-back">
					<div class="panel-body text-center">
						<img src="${pageContext.request.contextPath}/images/user_man.png" width="120" class="radius-circle">
						<br> <a href="#" title="点击修改帐户信息" style="color: #0ae;" onclick="updatepass('${sessionScope.CURRENT_USER_IN_SESSION.id }')">${sessionScope.CURRENT_USER_IN_SESSION.accountname == ""?sessionScope.CURRENT_USER_IN_SESSION.accountcode:sessionScope.CURRENT_USER_IN_SESSION.accountname  } </a>
					</div>
					<div class="panel-foot bg-back border-back">您好，${sessionScope.CURRENT_USER_IN_SESSION.accountname == ""?sessionScope.CURRENT_USER_IN_SESSION.accountcode:sessionScope.CURRENT_USER_IN_SESSION.accountname  }，欢迎使用后台管理系统。</div>
				</div>
				<br>
				<div class="panel">
					<div class="panel-head"><strong>站点统计</strong></div>
					<ul class="list-group">
						<li><span class="float-right badge bg-red">88</span><span class="icon-user-p"></span> 注册会员</li>
						<li><span class="float-right badge bg-red">88</span><span class="icon-user-p"></span> 仅关注人员</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-male"></span> 男性用户</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-female"></span> 女性用户</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-shopping-cart"></span> 订单总数</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-shopping-cart"></span> 未结束订单总数</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-file-text"></span> 品牌总数</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-database"></span> 商品总数</li>
					</ul>
				</div>
				<br>
			</div>
			<div class="xm9">
				<div class="alert alert-yellow"><span class="close"></span><strong>注意：</strong>您有5条未读信息，<a href="#">点击查看</a>。</div>
				<div class="alert">
					<h4>拼图前端框架介绍</h4>
					<p class="text-gray padding-top">拼图是优秀的响应式前端CSS框架，国内前端框架先驱及领导者，自动适应手机、平板、电脑等设备，让前端开发像游戏般快乐、简单、灵活、便捷。</p>
					<a target="_blank" class="button bg-dot icon-code" href="pintuer4.zip"> 下载示例代码</a>
					<a target="_blank" class="button bg-main icon-download" href="http://www.pintuer.com/download/pintuer.zip"> 下载拼图框架</a>
					<a target="_blank" class="button border-main icon-file" href="http://www.pintuer.com/"> 拼图使用教程</a>
				</div>
				<div class="panel">
					<div class="panel-head"><strong>系统信息</strong></div>
					<table class="table">
						<tbody>
							<tr>
								<th colspan="2">服务器信息</th>
								<th colspan="2">系统信息</th>
							</tr>
							<tr>
								<td width="110" align="right">操作系统：</td>
								<td>Windows 2008</td>
								<td width="90" align="right">系统开发：</td>
								<td><a href="http://www.pintuer.com" target="_blank">拼图前端框架</a></td>
							</tr>
							<tr>
								<td align="right">Web服务器：</td>
								<td>Apache</td>
								<td align="right">主页：</td>
								<td><a href="http://www.pintuer.com" target="_blank">http://www.pintuer.com</a></td>
							</tr>
							<tr>
								<td align="right">程序语言：</td>
								<td>PHP</td>
								<td align="right">演示：</td>
								<td><a href="http://www.pintuer.com/demo/" target="_blank">demo/</a></td>
							</tr>
							<tr>
								<td align="right">数据库：</td>
								<td>MySQL</td>
								<td align="right">群交流：</td>
								<td><a href="http://shang.qq.com/wpa/qunwpa?idkey=a08e4d729d15d32cec493212f7672a6a312c7e59884a959c47ae7a846c3fadc1" target="_blank">201916085</a> (点击加入)</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<p class="text-right text-gray">基于<a class="text-gray" target="_blank" href="http://www.pintuer.com">拼图前端框架</a>构建</p>
		<div class="clearfix text-center">
			<a class="button button-big bg-main badge-corner" href="http://www.pintuer.com/demo/pintuer3/" target="_blank">拼图最美中文后台-后翘<span class="badge bg-red">会员</span></a>
			<br>
			<br>
			<br>
		</div>
		<br>
	</div>
</body>
</html>