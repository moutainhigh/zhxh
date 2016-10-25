<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/view/order/css/table.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    
    <script src="${pageContext.request.contextPath}/js/jquery-jtemplates.js"></script>
    <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/js.validate.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
    
    <style type="text/css">
	    .admin {
		    width: 100%;
		    padding: 20px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 87px;
		    overflow: auto;
		}
		.input {
    		font-size: 12px;
    	}
		
    </style>
    
    <script type="text/javascript">
    
	    var userid = "";
    
    	$(function(){
    		//getUser();
    	})
    	
    	function setData(data) {
    		/* parentid = data.parentid;
    		identity = data.identity;
    		pageSize = data.pageSize;
    		checktype = data.checktype;
    		
    		loadData(); */
    	}
    	
    	//外部获取数据。这里是序列化form表单
    	function getData() {
    		var formData = false;
    		$("#addUserForm").ajaxSubmit(function() {
    			//formData = $("#addUserForm").serializeJson();
    			formData = $("#newPassword").val();
    		});
    		
    		return formData;
    	}
    	
    </script>
</head>
<body>
	<div class="updateUser" style="width:700px;margin:0 auto;margin-top:20px">
		<div class="container-layout" style="padding: 5px 30px 0px 30px;">
			<div class="doc-demoview doc-viewad0 ">
				<div class="view-body">
					<form id="addUserForm" method="post" class="form-x" onsubmit="return false;">
						<div class="form-group">
							<div class="label">
								<label for="username">原密码</label>
							</div>
							<div class="field">
								<input type="text" class="input" id="password" name="password" size="30" value="" data-validate="required:必填,ajax#${pageContext.request.contextPath}/orderUser/checkPassword.htmls?password=:原密码不正确" placeholder="原密码[不能为空]">
							</div>
						</div><div class="form-group">
							<div class="label">
								<label for="username">新密码</label>
							</div>
							<div class="field">
								<input type="password" class="input" id="newPassword" name="newPassword" size="30" value="" data-validate="required:必填" placeholder="新密码[不能为空]">
							</div>
						</div><div class="form-group">
							<div class="label">
								<label for="username">新密码确认</label>
							</div>
							<div class="field">
								<input type="password" class="input" id="confirmPassword" name="confirmPassword" size="30" value="" data-validate="required:必填,repeat#newPassword:错误提示(两次输入的密码不一致)" placeholder="新密码确认[不能为空]">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>