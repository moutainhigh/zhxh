<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心-收货地址</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pc/faq.css" />
<script src="${pageContext.request.contextPath}/js/pc/jquery-1.9.1.min.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/pc/index.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
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
			$('#myaddress').addClass('cur');
		</script>
	    <!--右侧-->
	    <div class="user-r fr">
	        <h3>收货地址</h3>
	        <div class="indent">
	            <h4>新增收货地址</h4>
	            <form id="address_form" name="form1" method="post">
	            <input type="hidden" name="id" value="${userPath.id }"/>
	            <table width="" border="0" cellpadding="0" cellspacing="0" class="my-xx">
	              <tr>
	                <td width="66">收货人</td>
	                <td><input type="text" value="${userPath.username }" name="username" id="usname" class="xx-txt" /></td>
	              </tr>
	              <tr>
	                <td>手机号码</td>
	                <td><input type="text" value="${userPath.userphone }" name="userphone" id="userphone" maxlength="11" class="xx-txt" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,'')"  /></td>
	              </tr>
	              <tr>
	                <td>邮编号码</td>
	                <td><input type="text" value="${userPath.postcode }" name="postcode" id="postcode" maxlength="6" class="xx-txt" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,'')"  /></td>
	              </tr>
	              <tr>
	                <td>收货地址</td>
	                <td><input type="text" value="${userPath.userpath }" name="userpath" id="userpath" class="xx-txt" /></td>
	              </tr>
	              <tr>
	                <td> </td>
	                <td><a id="save" href="javascript:;">保存</a></td>
	              </tr>
	            </table>
	            </form>
	        </div>
	        <div class="indent">
	            <table width="" border="0" cellpadding="0" cellspacing="0" class="postal">
	              <tr class="tr">
	                <td width="156">收货人</td>
	                <td width="184">详细地址</td>
	                <td width="154">邮编</td>
	                <td width="198">手机号</td>
	                <td width="145">操作</td>
	              </tr>
	              <c:forEach var="item" items="${userPathList }">
	              	<tr>
		                <td class="tdleft">${item.username }</td>
		                <td>${item.userpath }</td>
		                <td>${item.postcode }</td>
		                <td>${item.userphone }</td>
		                <td><a href="${pageContext.request.contextPath}/porder/upAddress.htmls?id=${item.id}">修改</a> | <a href="javascript:;" onclick="del('${item.id}')">删除</a></td>
		            </tr>
	              </c:forEach>
	            </table>
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
			$("#save").click(function(){
				var username = $("#usname").val();
				var userphone = $("#userphone").val();
				var postcode = $("#postcode").val();
				var userpath = $("#userpath").val();
				if(typeof(username) == "undefined" || username == ""){
					layer.msg("请输入收货人");
					return false;
				}else if(typeof(userphone) == "undefined" || userphone == ""){
					layer.msg("请输入手机号码");
					return false;
				}else if(typeof(postcode) == "undefined" || postcode == ""){
					layer.msg("请输入邮编");
					return false;
				}else if(typeof(userpath) == "undefined" || userpath == ""){
					layer.msg("请输入收货地址");
					return false;
				}else{
					var flag = validatemobile(userphone);
					if(!flag){
						layer.msg("请输入正确的手机号");
						return false;
					}
				}
				var obj = $("#address_form").serializeObject();
				var fdata = $.param(obj);
				$.ajax({
			    	async:false,
			        url: "${pageContext.request.contextPath}/porder/editAddress.htmls",
			        data: fdata,
			        type: "post",
			        dataType:"text",
			        success: function (text) {
			        	if(text != "error"){
			        		location.reload();
			        	}else{
			        		layer.msg("添加失败！");
			        	}
			        },
			        error: function (jqXHR, textStatus, errorThrown) {
			            layer.msg(jqXHR.responseText);
			        }
			    });
			});
		});
		//
		function del(id){
			layer.confirm('确定要删除该地址吗？', {
				title:"系统提示",
				icon:3,
				  	btn: ['确定','取消'] //按钮
				}, function(){
					location.href = "${pageContext.request.contextPath}/porder/delAddress.htmls?id="+id;
				}, function(){
				});
			
		}
		//
		function validatemobile(mobile) {
			if (trim(mobile) == "") {
		        return false; 
		    }     
		    if(mobile.length!=11) {
		    	return false; 
		    } 
		    var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		    if(!myreg.test(mobile)) {
		        return false; 
		    }
		    return true;
		} 
	</script>
	<!--页脚-->
	<%@ include file="/view/pc/bottom.jsp" %>
</body>
</html>