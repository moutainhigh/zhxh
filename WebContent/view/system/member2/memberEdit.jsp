<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<!-- 编辑--普通会员 -->
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
    
    <style type="text/css">
	    html, body
	    {
	        font-size:12px;
	        padding:0;
	        margin:0;
	        border:0;
	        height:100%;
	        overflow:hidden;
	    }
    </style>
</head>
<body>
	<div class="mini-toolbar" style="border-top:0;border-left:0;border-right:0;border-bottom:1">
        <table style="width:100%;">
            <tbody>
             <tr>
                 <td style="width:100%;">
                 	<span id="ftitle" style="padding-left:5px;">添加/修改</span>
                 </td>
                 <td style="white-space:nowrap;">
	         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save()">保存</a>
                 </td>
             </tr>
         </tbody>
        </table>
    </div>
	<div id="form1" style="text-align: center;">
    	<input name="id" class="mini-textbox" style="width:100%;" visible=false/>
        <table class="table table-bordered t" style="width: 80%;margin:auto; margin-top: 50px">
			<tbody>
				<tr>
					<td class="labelname">账户信息</td>
					<td colspan="3">手机号作为登录账户，唯一的。</td>
				</tr>
				<tr>
					<td class="labelname"><label for="rebates_down$text">手 机 &nbsp;号</label></td>
					<td><input id="phonenumber" name="phonenumber" class="mini-textbox" style="width:100%;" required="true" vtype="int" emptyText="请输入手机号" /></td>
					<td class="labelname">姓 &nbsp;&nbsp;&nbsp;&nbsp; 名</td>
					<td><input name="username" class="mini-textbox" style="width:100%;" required="true"  emptyText="请输入姓名" /></td>
				</tr>
				<tr>
					<td>密 &nbsp;&nbsp;&nbsp;&nbsp; 码</td>
					<td><input name="password" class="mini-password" style="width:100%;" required="true" emptyText="请输入登录密码" /></td>
					<td>身 &nbsp;&nbsp;&nbsp;&nbsp; 份</td>
					<td>
						<select id="identity" name="identity" style="width:100%;" class="mini-combobox" enabled="false">
	                        <option value="A">代理</option>
	                        <!-- <option value="B">市代</option> -->
	                        <option value="C">门店</option>
	                        <option value="Z">会员</option>
	                    </select>
					</td>
				</tr>
				<tr>
					<td>性 &nbsp;&nbsp;&nbsp;&nbsp; 别</td>
					<td>
						<select name="sex" style="width:100%;" class="mini-combobox">
	                        <option value="1">先生</option>
	                        <option value="2">女士</option>
	                    </select>
					</td>
					<td>年 &nbsp;&nbsp;&nbsp;&nbsp; 龄</td>
					<td><input name="age" class="mini-textbox" style="width:100%;" vtype="int" emptyText="请输入年龄" /></td>
				</tr>
				<tr>
					<td>出生日期</td>
					<td><input name="birthday" class="mini-datepicker" style="width:100%;" /></td>
					<td>所属店代码</td>
					<td><input name="belongcode" class="mini-textbox" style="width:100%;" required="true" emptyText="请输入机构代码" /></td>
				</tr>
				<tr>
					<td>地址</td>
					<td colspan="3"><input name="companypath" class="mini-textbox" style="width:100%;" required="true" emptyText="请输入地址" /></td>
				</tr>
			</tbody>
		</table>
    </div>
    
    <script type="text/javascript">
        mini.parse();

        var form = new mini.Form("form1");

        //添加
        function save() {
            var o = form.getData();            
            form.validate();
            if (form.isValid() == false) return;
            var json = mini.encode(o);
            $.ajax({
            	url: "${pageContext.request.contextPath}/userManager/save.htmls",
                data: { "objs": json },
                type: "post",
                dataType:"text",
                cache: false,
                success: function (text) {
                	if(text == "isPhoneNum"){
                		mini.alert("手机号已存在");
                		return;
                	}
                    CloseWindow("save");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    CloseWindow();
                }
            });
        }

        //修改
        function SetData(data) {
        	//跨页面传递的数据对象，克隆后才可以安全使用
        	var data = mini.clone(data);
        	var action = data.action;
            if (action == "update") {
                var rowData = data.row;
                form.setData(rowData);
                form.setChanged(false);
            }
            else if (action == "add") {
            	//设置身份
            	var identity = data.identity;
            	var obj = mini.get("identity");
                obj.setValue(identity);
            	/* if(obj == 'A'){
            		修改 ftitle
            	} */
            }
        }

        function GetData() {
            var o = form.getData();
            return o;
        }
        function CloseWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();            
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }


        function onButtonEdit(e) {
            var btnEdit = e.sender;

            mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/selectUser",
                title: "选择推荐人",
                width: 650,
                height: 380,
                onload: function () {
//                    var iframe = this.getIFrameEl();
//                    iframe.contentWindow.SetData(null);
                },
                ondestroy: function (action) {
                    if (action == "ok") {
                        var iframe = this.getIFrameEl();

                        var data = iframe.contentWindow.GetData();
                        data = mini.clone(data);    //必须
						if (data) {
                            btnEdit.setValue(data.id);
                            btnEdit.setText(data.id);
                        }
						
						/* var o = form.getData();
						o.tuijianid = data.id;
						form.setData(o);
		                form.setChanged(false); */
                    }
                }
            });
        }

    </script>
</body>
</html>