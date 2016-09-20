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
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    
    <script src="${pageContext.request.contextPath}/js/jquery-jtemplates.js"></script>
    <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
    
    <style type="text/css">
	    
		.doc-demoview {
		    border: solid 1px #ddd;
		    padding: 15px;
		    border-radius: 4px 4px 0 0;
		}
		
		.doc-viewad0, .doc-codead0 {
		    border-color: #cec;
		}
		
		.doc-demoview .view-body {
		    padding-top: 15px;
		    padding-bottom:15px;
		}
		
		.form-x .form-group .label {
		    float: left;
		    width: 15%;
		    text-align: right;
		    padding: 7px 7px 7px 0;
		    white-space: nowrap;
		    text-overflow: ellipsis;
		    overflow: hidden;
		}
		
		.form-x .form-group .field {
		    float: left;
		    width: 85%;
		}
		
		.input {
    		font-size: 12px;
    	}
		
    </style>
    
    <script type="text/javascript">
    
  //form序列化
	$.fn.serializeObject = function()  
	{  
	   var o = {};  
	   var a = this.serializeArray();  
	   $.each(a, function() {  
	       if (o[this.name]) {  
	           if (!o[this.name].push) {  
	               o[this.name] = [o[this.name]];  
	           }  
	           o[this.name].push(this.value || '');  
	       } else {  
	           o[this.name] = this.value || '';  
	       }  
	   });  
	   return o;  
	};
    	
    	$(function(){
    		
 			$(".view-body").setTemplateElement("Template-List-user-form");
     		$(".view-body").setParam('identity', parent.radio_value);
            $(".view-body").processTemplate();
            
            laydate({
  			   elem: '#birthday'
  			})
    	})
    	//外部获取数据。这里是序列化form表单
    	function getData() {
    		
    		console.log($("#addUserForm").serializeJson() + "=======");  
    		return $("#addUserForm").serializeJson();
    	}
    	
    	function aa() {
    		var obj = $("#addUserForm").serializeObject();
    		alert(obj.username);
    		//console.log($("#addUserForm").serializeJson() + "=======");  
    	}
    	
    </script>
</head>
<body>
	<div class="container-layout" style="padding: 30px;">
		<div class="doc-demoview doc-viewad0 ">
			<div class="view-body">
				<form id="addUserForm" method="post" class="form-x" onsubmit="return false;">
					<div class="form-group">
						<div class="label">
							<label for="username">真实姓名</label>
						</div>
						<div class="field">
							<input type="text" class="input" id="username" name="username" size="30" data-validate="required:必填" placeholder="客户姓名[不能为空]">
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="phonenumber">手机号码</label>
						</div>
						<div class="field">
							<input type="text" class="input" id="phonenumber" name="phonenumber" size="30" data-validate="required:必填,mobile:手机号码只能填写数字,ajax#${pageContext.request.contextPath}/orderUser/checkPhoneNum.htmls?checkType=insert&phoneNum=:手机号码已注册" placeholder="手机号码[作为客户登录本系统的帐号。[不能为空,仅数字]">
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="birthday">出生日期</label>
						</div>
						<div class="field">
							<input type="text" class="input" id="birthday" name="birthday" size="30" placeholder="点击选择">
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="phonenumber">性别</label>
						</div>
						<div class="field">
							<select class="input" id="sex" name="sex">
								<option value="1">男</option>
								<option value="0">女</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="companyname">机构名称</label>
						</div>
						<div class="field">
							<input type="text" class="input" id="companyname" name="companyname" size="30" data-validate="required:必填" placeholder="机构名称[机构店名称]">
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="companypath">机构地址</label>
						</div>
						<div class="field">
							<input type="text" class="input" id="companypath" name="companypath" size="30" data-validate="required:必填" placeholder="机构地址[机构的联系地址]">
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="companyname">机构代码</label>
						</div>
						<div class="field">
							<input type="text" class="input" id="companycode" name="companycode" size="30" data-validate="required:必填" placeholder="机构代码[与手机号相同]">
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="wechar">微信号码</label>
						</div>
						<div class="field">
							<input type="text" class="input" id="wechar" name="wechar" size="30" placeholder="微信号码[可不填]">
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="sort">排序</label>
						</div>
						<div class="field">
							<input type="text" class="input" id="sort" name="sort" size="30" data-validate="required:必填,number:请填写数字"  placeholder="排序">
						</div>
					</div>
					<div class="form-group">
						<div class="label">
							<label for="wechar">验证码</label>
						</div>
						<div class="field">
							<div class="input-group">
								<input type="text" class="input" id="vcode" name="vcode" size="50" data-validate="required:必填" placeholder="手机验证码" />
								<span class="addbtn">
					            	<button type="button" class="button" onclick="aa()">获取</button>
					            </span>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<textarea id="Template-List-user-form" rows="0" cols="0" style="display:none">
		<!--
		<form method="post" class="form-x" onsubmit="return false;">
			<input type="hidden" id="identity" name="identity" value="{$P.identity}" />
			<div class="form-group">
				<div class="label">
					<label for="username">真实姓名</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="username" name="username" size="30" data-validate="required:必填" placeholder="客户姓名[不能为空]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="phonenumber">手机号码</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="phonenumber" name="phonenumber" size="30" data-validate="required:必填,mobile:手机号码只能填写数字,ajax#${pageContext.request.contextPath}/orderUser/checkPhoneNum.htmls?checkType=insert&phoneNum=:手机号码已注册" placeholder="手机号码[作为客户登录本系统的帐号。[不能为空,仅数字]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="username">出生日期</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="birthday" name="birthday" size="30" placeholder="点击选择">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="phonenumber">性别</label>
				</div>
				<div class="field">
					<select class="input" id="sex" name="sex">
						<option value="1">男</option>
						<option value="0">女</option>
					</select>
				</div>
			</div>
			{#if $P.identity == 'A' || $P.identity == 'C'}
			<div class="form-group">
				<div class="label">
					<label for="companyname">机构名称</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="companyname" name="companyname" size="30" data-validate="required:必填" placeholder="机构名称[机构店名称]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="companypath">机构地址</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="companypath" name="companypath" size="30" data-validate="required:必填" placeholder="机构地址[机构的联系地址]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="companyname">机构代码</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="companycode" name="companycode" size="30" data-validate="required:必填" placeholder="机构代码[与手机号相同]">
				</div>
			</div>
			{#/if}
			<div class="form-group">
				<div class="label">
					<label for="wechar">微信号码</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="wechar" name="wechar" size="30" placeholder="微信号码[可不填]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="sort">排序</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="sort" name="sort" size="30" data-validate="required:必填,number:请填写数字"  placeholder="排序">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="wechar">验证码</label>
				</div>
				<div class="field">
					<div class="input-group">
						<input type="text" class="input" id="vcode" name="vcode" size="50" data-validate="required:必填" placeholder="手机验证码" />
						<span class="addbtn">
			            	<button type="button" class="button" onclick="aa()">获取</button>
			            </span>
					</div>
				</div>
			</div>
		</form>
	    -->
	</textarea>
<script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
<script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>
</body>
</html>