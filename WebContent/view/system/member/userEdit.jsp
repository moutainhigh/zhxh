<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    
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
	<form id="form1" method="post">
        <input name="id" class="mini-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:70px;">手机号：</td>
                    <td style="width:150px;">    
                        <input name="phonenumber" class="mini-textbox" required="true"  emptyText="请输入手机号"/>
                    </td>
                    <td style="width:70px;">身份：</td>
                    <td style="width:150px;">
                    	<select name="userid" class="mini-combobox" >
                    		<option value="Z">会员</option>
	                        <option value="A">省代</option>
	                        <option value="B">市代</option>
	                        <option value="C">门店</option>
	                    </select>
                    </td>
                </tr>
               <tr>
                    <td style="width:70px;">推荐人：</td>
                    <td style="width:150px;">
                		<input textname="tuijianid" name="tuijianid" allowInput="false" property="editor" class="mini-buttonedit" onbuttonclick="onButtonEdit" />
                    </td>
                    <td style="width:70px;">是否分利：</td>
                    <td style="width:150px;">
                    	<select name="setreturn" class="mini-combobox" >
                    		<option value="0">否</option>
	                        <option value="1">是</option>
	                    </select>
                    </td>
                </tr>
                <tr>
                    <td style="width:70px;">禁用：</td>
                    <td style="width:150px;">
                    	<select name="isopen" class="mini-combobox" >
                    		<option value="0">关闭</option>
	                        <option value="1">开启</option>
	                    </select>
                    </td>
                </tr>
            </table>
        </div>
        <fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >基本信息</legend>
            <div style="padding:5px;">
        <table>
            <tr>
                <td style="width:70px;">姓名</td>
                <td style="width:150px;">    
                    <input name="username" class="mini-textbox" />
                </td>
                <td style="width:70px;">性别：</td>
                <td >                        
                    <select name="sex" class="mini-radiobuttonlist">
                        <option value="1">先生</option>
                        <option value="2">女士</option>
                    </select>
                </td>
                
            </tr>
            <tr>
                <td >年龄：</td>
                <td >    
                    <input name="age" class="mini-spinner" value="25" minValue="1" maxValue="200" />
                </td>
                <td >出生日期：</td>
                <td >    
                    <input name="birthday" class="mini-datepicker" required="true" emptyText="请选择日期"/>
                </td>
            </tr>
            <tr>
            	<td >城市：</td>
                <td >    
                    <input name="city" class="mini-combobox"  />
                </td>
                <td ></td>
                <td >    
                </td>
                
            </tr>
        </table>            
            </div>
        </fieldset>
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
    
    <script type="text/javascript">
        mini.parse();

        var form = new mini.Form("form1");

        //添加
        function SaveData() {
            var o = form.getData();            
            form.validate();
            if (form.isValid() == false) return;
            var json = mini.encode(o);
            $.ajax({
            	url: "${pageContext.request.contextPath}/userManager/save.html",
                data: { "objs": json },
                type: "post",
                dataType:"text",
                cache: false,
                success: function (text) {
                	if(text == "isPhoneNum"){
                		alert("手机号已存在");
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
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                data = mini.clone(data);
                var rowData = data.row;
                form.setData(rowData);
                form.setChanged(false);
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
                url: "${pageContext.request.contextPath}/common/dispatch.html?page=/view/system/member/selectUser",
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