<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<!-- 编辑--代理/店 -->
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
					<td colspan="3" style="color: #f60">手机号作为登录账户，唯一的。<br>【注：请填写真实有效的手机号，否则会影响后期的订货,系统消息的接受。】</td>
				</tr>
				<tr>
					<td class="labelname"><label for="rebates_down$text">手 机 &nbsp;号</label></td>
					<td><input id="phonenumber" name="phonenumber" class="mini-textbox" style="width:100%;" required="true" vtype="int" onvaluechanged="setCompanyCode" emptyText="请输入手机号" /></td>
					<td class="labelname">姓 &nbsp;&nbsp;&nbsp;&nbsp; 名</td>
					<td><input id="username" name="username" class="mini-textbox" style="width:100%;" required="true"  emptyText="请输入姓名" /></td>
				</tr>
				<tr>
					<td>密 &nbsp;&nbsp;&nbsp;&nbsp; 码</td>
					<td><input name="password" class="mini-password" style="width:100%;" required="true" emptyText="请输入登录密码" /></td>
					<td>级 &nbsp;&nbsp;&nbsp;&nbsp; 别</td>
					<td><input name="rank" class="mini-textbox" style="width:100%;" emptyText="请输入级别" /></td>
				</tr>
				<tr>
					<td>身 &nbsp;&nbsp;&nbsp;&nbsp; 份</td>
					<td>
						<select id="identity" name="identity" style="width:100%;" class="mini-combobox" enabled="false">
	                        <option value="A">代理</option>
	                        <!-- <option value="B">市代</option> -->
	                        <option value="C">门店</option>
	                        <option value="Z">会员</option>
	                    </select>
					</td>
					<td>上 &nbsp;&nbsp;&nbsp;&nbsp; 级</td>
					<td>
						<input id="parentid" name="parentid" required="true" allowInput="false" property="editor" class="mini-buttonedit" onbuttonclick="onButtonEdit" style="width:100%;"  />
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
					<td>是否分利</td>
					<td>
						<select name="setreturn" style="width:100%;" class="mini-combobox">
	                        <option value="0">否</option>
	                        <option value="1">是</option>
	                    </select>
					</td>
				</tr>
				<tr>
					<td>机构名称</td>
					<td><input name="companyname" class="mini-textbox" style="width:100%;" required="true" emptyText="请输入机构名称" /></td>
					<td>机构代码</td>
					<td><input id="companycode" name="companycode" class="mini-textbox" style="width:100%;" allowInput="false" required="true" /></td>
				</tr>
				<tr>
					<td>机构地址</td>
					<td colspan="3"><input name="companypath" class="mini-textbox" style="width:100%;" required="true" emptyText="请输入机构地址" /></td>
				</tr>
			</tbody>
		</table>
    </div>
    
    <script type="text/javascript">
        mini.parse();

        var form = new mini.Form("form1");

        //添加
        function save() {
        	/* var data = form.getData(true, false);
            var s = mini.encode(data);
            alert(s); */
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
                		parent.parent.layer.msg("手机号已存在,请更换手机号",{icon:6});
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
                //上级
                /* var identity = rowData.identity;
            	if(identity == 'A' || identity == 'C'){
            		//代理的上级是平台（平台也是个代理ID为1）
            		//此处的C就代表直营店
            		var parentid = mini.get("parentid");
            		parentid.setValue("1");
            		parentid.setText("平台");
            		parentid.setShowButton(false);
            	} */
                var parentid = mini.get("parentid");
            	parentid.setRequired(false);
            	parentid.setShowButton(false);
            }
            else if (action == "add") {
            	//设置身份
            	var identity = data.identity;
            	var obj = mini.get("identity");
                obj.setValue(identity);
            	if(identity == 'A'){
            		//代理的上级是平台（平台也是个代理ID为1）
            		var parentid = mini.get("parentid");
            		parentid.setValue("1");
            		parentid.setText("平台");
            		parentid.setShowButton(false);
            	} 
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

		//设置上级机构
        function onButtonEdit(e) {
            var btnEdit = e.sender;
            mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/selectAgent",
                title: "选择机构",
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
                            btnEdit.setText(data.username);
                        }
                    }
                }
            });
        }
		
        //机构代码-为手机号
        function setCompanyCode(e) {
            var mobile = e.sender;
            var companycode = mini.get("companycode");
            companycode.setValue(mobile.getValue());
        }
    </script>
</body>
</html>