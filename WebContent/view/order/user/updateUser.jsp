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
    <script src="${pageContext.request.contextPath}/js/js.validate.js" type="text/javascript"></script>
    
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
		
		.doc-codead0 {
		    background: #efe;
		}
		.doc-democode {
		    border: solid 1px #ddd;
		    border-radius: 0 0 4px 4px;
		    padding: 15px;
		    background: #f5f5f5;
		    font-size: 12px;
		    border-top: none;
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
    
    	$(function(){
    		
    		/* $(".view-body").setTemplateElement("Template-List-user-form");
     		//$(".view-body").setParam('identity', parent.radio_value);
            $(".view-body").processTemplate(parent.updateRow);
            
            laydate({
  			   elem: '#birthday'
  			})
  			
  			$("#phonenumber").blur(function(){
				var val = $(this).val();
				$('#companycode').val(val);
 			}) */
    	})
    	
    	//作废。因从外面调用传参数，模板数据加载后，不能带入js的绑定。
    	function setData(data) {
    		var row = data.updateRow;
    		var updatePhone = data.updatePhone;
    		$(".view-body").setTemplateElement("Template-List-user-form");
     		$(".view-body").setParam('updatePhone', updatePhone);
            $(".view-body").processTemplate(row);
            
            laydate({
  			   elem: '#birthday'
  			})
  			
  			$("#phonenumber").blur(function(){
				var val = $(this).val();
				$('#companycode').val(val);
 			})
 			
    	}
    	
    	//外部获取数据。这里是序列化form表单
    	function getData() {
    		var formData = false;
    		$("#addUserForm").ajaxSubmit(function() {
				formData = $("#addUserForm").serializeJson();
			});
    		return formData;
    	}
    	
		function getSendCode() {
			
			var phonenumber = $('#phonenumber').val();
			
			if (trim(phonenumber) == "") {
				parent.layer.msg("请输入手机号码。");
				$('#phonenumber').val("");
				$('#phonenumber').focus();
				return;
			}
			
			if (!validatemobile(phonenumber) ) {
				parent.layer.msg("请正确输入手机号码。");
				$('#phonenumber').val("");
				$('#phonenumber').focus();
				return;
			}
			//获取
			$.ajax({
            	url: "${pageContext.request.contextPath}/orderUser/getCode.htmls",
            	data:{'phonenumber':phonenumber,'sendType':'update'},
            	type:"post",
            	dataType:"text",
                success: function (text) {
                	if (text == "empty") {
                		layer.msg("未获取到手机号码，请重新输入手机号码，再获取短信验证码.");
        				$('#phonenumber').focus();
        				return;
                	}
                	else if (text == "exist") {
                		layer.msg("手机号码已注册过，请重新输入手机号码，再获取短信验证码.");
        				$('#phonenumber').focus();
        				return;
                	}
                	else if(text == "success"){
                    	//location.reload();
                		opentime();
                    }else{
                    	//layer.msg("测试的验证码:" + text);
                    	opentime();
                    }
                },
                error: function () {
                    layer.msg("失败");
                    return;
                }
            });
			return false;
		}
		
		var wait=120;
		function opentime() {
			var o = $(".huoqu");
			if (wait == 0) {  
	            o.removeAttr("disabled");
	            //o.val("获取验证码");
	            o.text("获取验证码");
	            wait = 120;
	        } else {
	        	o.attr("disabled", true);
	            //o.val("重新发送(" + wait + ")");
	            o.text("重新发送(" + wait + ")");
	            wait--;  
	            setTimeout(function() {  
	            	opentime(o);
	            },  
	            1000)
	        }
		}
    	
    </script>
</head>
<body>
	<div class="container-layout" style="padding: 30px;">
		<div class="doc-demoview doc-viewad0 ">
			<div class="view-body">
				
			</div>
		</div>
		<div class="doc-democode doc-codead0 ">
			<blockquote class="border-sub">
				<p><span style="color:red">填写注意：</span><br>
				1.手机号码必须真实填写，一个手机号码仅能注册一次。<br>
				2.手机号码需接收验证短信，填入验证码才能合法注册。<br>
				3.手机号码同时作为客户登录本系统的帐号及普通会员采购时利益分配的唯一标准代码。
				</p>
			</blockquote>
		</div>
	</div>
	<textarea id="Template-List-user-form" rows="0" cols="0" style="display:none">
		<!--
		<script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
		<form id="addUserForm" method="post" class="form-x" onsubmit="return false;">
			<input type="hidden" id="id" name="id" value="{$T.id}" />
			<input type="hidden" id="identity" name="identity" value="{$T.identity}" />
			{#if $P.updatePhone == 0}<input type="hidden" class="input" id="phonenumber" name="phonenumber" size="30" value="{$T.phonenumber}" >{/#if}
			<div class="form-group">
				<div class="label">
					<label for="username">真实姓名</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="username" name="username" size="30" value="{$T.username}" data-validate="required:必填" placeholder="客户姓名[不能为空]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="phonenumber">手机号码</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="phonenumber" name="phonenumber" {#if $P.updatePhone == 0}disabled="disabled"{/#if} size="30" value="{$T.phonenumber}" data-validate="required:必填,mobile:手机号码只能填写数字,ajax#${pageContext.request.contextPath}/orderUser/checkPhoneNum.htmls?userid={$T.id}&checkType=update&phoneNum=:手机号码已注册" placeholder="手机号码[作为客户登录本系统的帐号。[不能为空,仅数字]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="username">出生日期</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="birthday" name="birthday" value="{$T.birthday}" size="30" placeholder="点击选择">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="phonenumber">性别</label>
				</div>
				<div class="field">
					<select class="input" id="sex" name="sex">
						<option {#if $T.sex == 1}selected{#/if} value="1">男</option>
						<option {#if $T.sex == 0}selected{#/if} value="0">女</option>
					</select>
				</div>
			</div>
			{#if $T.identity == 'A' || $T.identity == 'C'}
			<div class="form-group">
				<div class="label">
					<label for="companyname">机构名称</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="companyname" name="companyname" size="30" value="{$T.companyname}" data-validate="required:必填" placeholder="机构名称[机构店名称]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="companypath">机构地址</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="companypath" name="companypath" size="30" value="{$T.companypath}" data-validate="required:必填" placeholder="机构地址[机构的联系地址]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="companyname">机构代码</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="companycode" name="companycode" disabled="disabled" value="{$T.companycode}" size="30" data-validate="required:必填" placeholder="机构代码[与手机号相同]">
				</div>
			</div>
			{#/if}
			<div class="form-group">
				<div class="label">
					<label for="wechar">微信号码</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="wechar" name="wechar" size="30" value="{$T.wechar}" placeholder="微信号码[可不填]">
				</div>
			</div>
			<div class="form-group">
				<div class="label">
					<label for="sort">排序</label>
				</div>
				<div class="field">
					<input type="text" class="input" id="sort" name="sort" size="30" value="{$T.sort}" data-validate="required:必填,number:请填写数字"  placeholder="排序">
				</div>
			</div>
			{#if $P.updatePhone == 1}
			<div class="form-group">
				<div class="label">
					<label for="wechar">验证码</label>
				</div>
				<div class="field">
					<div class="input-group">
						<input type="text" class="input" id="sendcode" name="sendcode" size="50" data-validate="required:必填" placeholder="手机验证码" />
						<span class="addbtn">
			            	<button type="button" class="button huoqu" onclick="getSendCode()">获取验证码</button>
			            </span>
					</div>
				</div>
			</div>
			{/#if}
		</form>
	    -->
	</textarea>
	<script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>
</body>
</html>