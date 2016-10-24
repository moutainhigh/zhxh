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
    
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    
    <script src="${pageContext.request.contextPath}/js/jquery-jtemplates.js"></script>
    <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/js.validate.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>
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
    		getUser();
    	})
    	
    	function setData(data) {
    		/* parentid = data.parentid;
    		identity = data.identity;
    		pageSize = data.pageSize;
    		checktype = data.checktype;
    		
    		loadData(); */
    	}
    	
    	function getUser() {
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUser/getUser.htmls",
                type: "post",
                dataType:"json",
                success: function (json) {
                	userid = json.id;
                	$(".updateUser").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/user/updateUser_self.tpl");
            		$(".updateUser").setParam('path', '${pageContext.request.contextPath}');
            		$(".updateUser").setParam('updatePhone', 1);
                    $(".updateUser").processTemplate(json);
                    laydate({
           			   elem: '#birthday'
           			})
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
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
    	    	data:{'userid':userid,'phonenumber':phonenumber,'sendType':'update'},
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
	<div class="updateUser" style="width:700px;margin:0 auto;margin-top:20px">
	
	</div>
	<script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>
</body>
</html>