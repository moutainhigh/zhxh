<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心-我的信息</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/faq.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/laydate/laydate.js" type="text/javascript"></script>

</head>
<body>
	<div class="bg"></div> <!--弹框外的透明背景 搜索和页脚用到-->
	
	<!--评价弹框-->
	<div class="tan-bg"></div>
	<div class="pj-tan">
	    <div class="pj-xq clearfix">
	        <div class="img-txt">
	            <img src="images/img3.jpg" class="fl" />
	            <div class="txt fl">
	                <a href="javascript:;">紧致毛孔柔肤精华液</a>
	                <em>Tighten The Pores Soft Skin Essence</em>
	            </div>
	        </div>
	        <div class="pj-tan-num">1</div>
	        <div class="pj-tan-price">￥300</div>
	    </div>
	    <div class="pj-dingdan">
	        <div class="pj-dingdan-con clearfix">
	            <span class="fl">评价订单</span>
	            <textarea name="" cols="" rows="" class="fl"></textarea>
	        </div>
	    </div>
	    <input type="button" value="提交评价" />
	</div>
		
	<!--头部-->
	<%@include file="/view/pc/header.jsp" %>
	
	<div class="HTML-con user-con clearfix">
	    <!--左侧-->
	    <%@include file="/view/pc/account/left.jsp" %>
	    <script>
			$('#myinfo').addClass('cur');
		</script>
	    <!--右侧-->
	    <div class="user-r fr">
	        <h3>我的信息</h3>
	        <div class="indent">
	            <h4>基本信息</h4>
	            <form id="info_form" action="" method="post">
	            <input type="hidden" name="id" value="${user.id }"/>
	            <table width="" border="0" cellpadding="0" cellspacing="0" class="my-xx">
	              <tr>
	                <td width="66">姓名</td>
	                <td><input type="text" name="username" value="${user.username }" class="xx-txt" /></td>
	              </tr>
	              <tr>
	                <td>手机</td>
	                <td><input type="text" value="${user.phonenumber }" readonly="readonly" class="xx-txt" /><em>（如需更改需验证）</em></td>
	              </tr>
	              <tr>
	                <td>性别</td>
	                <td>
	                	<select name="sex" class="xx-txt">
	                		<option ${user.sex == 2?"selected":"" } value="2">女士</option>
	                		<option ${user.sex == 1?"selected":"" } value="1">先生</option>
	                	</select>
	                </td>
	              </tr>
	              
	              <tr>
	                <td>出生日期</td>
	                <td><input type="text" id="birthday" name="birthday" value="${user.birthday }" class="xx-txt" /></td>
	              </tr>
	              <tr>
	                <td> </td>
	                <td><a id="info" href="javascript:;">保 存</a></td>
	              </tr>
	            </table>
	            </form>
	        </div>
	        <div class="indent">
	            <h4>修改密码</h4>
	            <form id="form_pwd" action="" method="post">
	            <input type="hidden" name="id" value="${user.id }"/>
	            <table width="" border="0" cellpadding="0" cellspacing="0" class="my-xx">
	              <tr>
	                <td width="66">原 密 &nbsp;码</td>
	                <td><input type="text" id="oldpwd" name="password" value="" class="xx-txt" /></td>
	              </tr>
	              <tr>
	                <td width="66">新 密 &nbsp;码</td>
	                <td><input type="text" id="newpwd" name="newpwd" value="" class="xx-txt" /></td>
	              </tr>
	              <tr>
	                <td>确认密码</td>
	                <td><input type="text" id="repwd" name="repwd" value="" class="xx-txt" /></td>
	              </tr>
	              <tr>
	                <td> </td>
	                <td><a id="uppwd" href="javascript:;">保 存</a></td>
	              </tr>
	            </table>
	            </form>
	        </div>
	        
	    </div>
	</div>
	
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
			//
			$("#info").click(function(){
				var obj = $("#info_form").serializeObject();
				//alert(JSON.stringify(d));
				var fdata = $.param(obj);
				$.ajax({
    		    	async:false,
    		        url: "${pageContext.request.contextPath}/porder/upUserInfo.htmls",
    		        data: fdata,
    		        type: "post",
    		        dataType:"text",
    		        success: function (text) {
    		        	if(text != "error"){
    		        		layer.msg('修改成功！', {icon: 1});
    		        	}else{
    		        		layer.msg('修改失败！', {icon: 2});
    		        	}
    		        },
    		        error: function (jqXHR, textStatus, errorThrown) {
    		            alert(jqXHR.responseText);
    		        }
    		    });
			});
			//
			$("#uppwd").click(function(){
				var oldpwd = $("#oldpwd").val();
				var newpwd = $("#newpwd").val();
				var repwd = $("#repwd").val();
				if(typeof(oldpwd) == "undefined" || oldpwd == ""){
					layer.msg("请输入原密码");
					return false;
				}else if(typeof(newpwd) == "undefined" || newpwd == ""){
					layer.msg("请输入新的密码");
					return false;
				}else if(newpwd != repwd){
					layer.msg("两次密码不同");
					return false;
				}
				
				var obj = $("#form_pwd").serializeObject();
				var fdata = $.param(obj);
				$.ajax({
    		    	async:false,
    		        url: "${pageContext.request.contextPath}/porder/uppwd.htmls",
    		        data: fdata,
    		        type: "post",
    		        dataType:"text",
    		        success: function (text) {
    		        	if(text == "1"){
    		        		layer.msg("原密码错误！");
    		        		return false;
    		        	}
    		        	if(text != "error"){
    		        		layer.msg('修改成功！', {icon: 1});
    		        	}else{
    		        		layer.msg('修改失败！', {icon: 2});
    		        	}
    		        },
    		        error: function (jqXHR, textStatus, errorThrown) {
    		            alert(jqXHR.responseText);
    		        }
    		    });
			});
			
			//
			laydate({
			   elem: '#birthday'
			})
		});
	</script>
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>