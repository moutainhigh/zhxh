<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

	<style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;text-align:center;
	    }
	    .div{ margin:0 auto; width:400px; height:100px;}    
    </style>
    
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    
    <script type="text/javascript">
    
    	var server;
    	var form;
	    
	    $(function(){
	    	mini.parse();
	    })
	    
	    //标准方法接口定义
		function SetData(data) {
		}
	    
		function update() {
			var form = new mini.Form("#form1");
	        
	        form.validate();
	        if (form.isValid() == false) return;
	        
	        
			var confirmpass = mini.get("confirmpass").getValue();
			var password = mini.get("password").getValue();
			var id = '${sessionScope.CURRENT_USER_IN_SESSION.id }';
			
			if (password == "" || confirmpass == "" || id == "") {
				alert("没有获取足够数据，请退出后，重新尝试，或与管理员联系。");
				$("#password").focus();
				return;
			}
			
			if (password != confirmpass) {
				alert("两次密码输入不一致，请重新输入。");
				$("#password").focus();
				return;
			}
			
		    $.ajax({
		        async : true,
		        url : "${pageContext.request.contextPath}/account/toupdatepass.do",
		        type : 'post',
		        data:{id:id,password:password},
		        dataType : 'text',
		        success : function(data) {
		            if (data == "success") {
		            	alert("更新完毕。");
		            } else {
		            	alert("可能因为您长时间没有操作，或读取数据时出错，请关闭浏览器，重新登录尝试或与管理员联系!！");
		            }
		        }
		    });
		}
		
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	</script>
    
</head>
<body>
	<div class="mini-toolbar" style="text-align:center;line-height:30px;" borderStyle="border-left:0;border-right:0;border-top:0;">
          <label id="memo"><span style="color:red; ">修改帐户信息</span></label>
    </div>
    <div class="mini-fit">
        <div id="form1" class="div" style="margin-top: 30px;width:80%;">
	        <table cellpadding="5px" class="table table-bordered">
	        	<tr >
	                <td>
	                    <label for="textbox1$text">帐户登录名称：</label>
	                </td>
	                <td>
	                    <input id="accountcode" name="accountcode" readonly=true value="${sessionScope.CURRENT_USER_IN_SESSION.accountcode }" class="mini-textbox" style="width:130px;" required="true"  />
	                </td>
	            </tr>
	        	<tr >
	                <td>
	                    <label for="textbox1$text">帐户姓名：</label>
	                </td>
	                <td>
	                    <input id="accountname" name="accountname" class="mini-textbox" readonly=true style="width:130px;" required="true"  value="${sessionScope.CURRENT_USER_IN_SESSION.accountname }"/>
	                </td>
	            </tr>
	        	<tr >
	                <td>
	                    <label for="textbox1$text">帐户密码：</label>
	                </td>
	                <td>
	                    <input id="password" name="password" type="password" class="mini-textbox" style="width:230px;" required="true"/>
	                </td>
	            </tr>
	        	<tr >
	                <td>
	                    <label for="textbox1$text">密码确认：</label>
	                </td>
	                <td>
	                    <input id="confirmpass" name="confirmpass" type="password" class="mini-textbox" style="width:230px;" required="true"/>
	                </td>
	            </tr>
	        </table>
	    </div>
    </div>
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border-left:0;border-right:0;border-bottom:0;">
        <a class="mini-button" style="width:60px;" onclick="update()">保存</a>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>