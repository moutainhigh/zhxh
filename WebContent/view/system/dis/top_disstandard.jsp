<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
  <%--   <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css"> --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
	
	
	<style type="text/css">
		.labelname {
			width:100px;
		}
		/* .icon-save:before, .icon-floppy-o:before {
		    content: "";
		} */
	</style>
    
	<script type="text/javascript">
	
		var form;
		$(function() {
			mini.parse();
			form = new mini.Form("#form1");
			$.ajax({
				async : false,
				url : "${pageContext.request.contextPath}/dis/list.htmls",
				data : {
					'act' : 'disconfig'
				},
				type : "post",
				dataType : "json",
				success : function(obj) {
					form.setData(obj, false);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					mini.alert(jqXHR.responseText);
				}
			})
			//form.setData(obj, false);
		})
		
		function save() {
            form.validate();
            if (form.isValid() == false) return;

            //提交数据
            var data = form.getData();      
            var json = mini.encode(data);
			
			$.ajax({
				async : false,
				url : "${pageContext.request.contextPath}/dis/saveDisConfig.htmls",
				data : {
					'objs' : json
				},
				type : "post",
				dataType : "text",
				success : function(text) {
					mini.alert("保存完毕。");
				},
				error : function(jqXHR, textStatus, errorThrown) {
					mini.alert(jqXHR.responseText);
				}
			});
		}
	</script>
</head>
<body>
	<div id="c_aj" class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
   		<div size="50%" showCollapseButton="false" style="border-width: 1;">
   			<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" borderStyle="padding:0;border:0;">
   				<div name="brandlistPic" title="公共平台利益分配标准">
		   			<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				        <table style="width:100%;border-collapse: separate;border-spacing: 3px;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">代理商列表</span>
				                 </td>
				                 <td style="white-space:nowrap;">
					         		自动挂接条件：[<span style="color:red">电子全文名称</span>]包含[<span style="color:red">档案属性</span>]
				                 	<input id="key" class="mini-combobox" style="width:150px;" textField="text" valueField="id" 
									    value="" showNullItem="false" required="true" allowInput="false" emptyText="请选择..."
									/>
		                        	<a class="mini-button" iconCls="icon-split" plain="true" onclick="autoDoc()"  name="auth">自动挂接</a>
		                        	<span class="separator"></span>
		                        	<a class="mini-button" iconCls="icon-save" plain="true" onclick="saveDoc()"  name="auth">保存</a>
				                 </td>
				             </tr>
				         </tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid_a" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>
				 </div>
				 <div name="brandlist_v" title="代理商利益分配标准">
				 	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				        <table style="width:100%;border-collapse: separate;border-spacing: 3px;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">代理商列表</span>
				                 </td>
				                 <td style="white-space:nowrap;">
					         		自动挂接条件：[<span style="color:red">电子全文名称</span>]包含[<span style="color:red">档案属性</span>]
				                 	<input id="key" class="mini-combobox" style="width:150px;" textField="text" valueField="id" 
									    value="" showNullItem="false" required="true" allowInput="false" emptyText="请选择..."
									/>
		                        	<a class="mini-button" iconCls="icon-split" plain="true" onclick="autoDoc()"  name="auth">自动挂接</a>
		                        	<span class="separator"></span>
		                        	<a class="mini-button" iconCls="icon-save" plain="true" onclick="saveDoc()"  name="auth">保存</a>
				                 </td>
				             </tr>
				         </tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid_a" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>
				 </div>
				 <div name="brandlist_v" title="直营店利益分配标准">
				 	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				        <table style="width:100%;border-collapse: separate;border-spacing: 3px;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">代理商列表</span>
				                 </td>
				                 <td style="white-space:nowrap;">
					         		自动挂接条件：[<span style="color:red">电子全文名称</span>]包含[<span style="color:red">档案属性</span>]
				                 	<input id="key" class="mini-combobox" style="width:150px;" textField="text" valueField="id" 
									    value="" showNullItem="false" required="true" allowInput="false" emptyText="请选择..."
									/>
		                        	<a class="mini-button" iconCls="icon-split" plain="true" onclick="autoDoc()"  name="auth">自动挂接</a>
		                        	<span class="separator"></span>
		                        	<a class="mini-button" iconCls="icon-save" plain="true" onclick="saveDoc()"  name="auth">保存</a>
				                 </td>
				             </tr>
				         </tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid_a" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>
				 </div>
			</div>
		</div>
		<div showCollapseButton="true">
			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
				<div size="60%" showCollapseButton="false">
					<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				        <table style="width:100%;">
				             <tbody>
					             <tr>
					                 <td style="width:100%;">
					                 	<span id="pid" style="padding-left:5px;">挂接电子全文</span>
					                 </td>
					                 <td style="white-space:nowrap;">
					                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="removeRow()"  name="auth">移除</a>
					                 </td>
					             </tr>
					         </tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
						<div id="grid_doc" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>                
				</div>
				<div showCollapseButton="true" >
					<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				        <table style="width:100%;">
				             <tbody>
					             <tr>
					                 <td style="width:100%;">
					                 	<span id="pid_f" style="padding-left:5px;">待挂接电子全文</span>
					                 </td>
					                 <td style="white-space:nowrap;">
					                 	<a class="mini-button" iconCls="icon-upload" plain="true" onclick="upload()"  name="auth">上传</a>
					                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow()"  name="auth">删除</a>
					                 	<a class="mini-button" iconCls="icon-split" plain="true" onclick="singleDoc()"  name="auth">手动挂接</a>
					                 	<a id="downBtn" class="mini-button" iconCls="icon-tip" plain="true" onclick="setDocAuth()"  name="auth">设置权限</a>
					                 </td>
					             </tr>
					         </tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
						<div id="grid_upload" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>                
				</div>
			</div>
		</div>
	</div>
	
    <div id="form1" style="text-align: center;">
    	<input name="id" class="mini-textbox" style="width:100%;" visible=false/>
        <table class="table table-bordered t" style="width: 80%;margin:auto; margin-top: 50px">
			<tbody>
				<tr>
					<td class="labelname">参数设置</td>
					<td colspan="3">设置后，全平台代理、店统一利益分配标准。</td>
				</tr>
				<tr>
					<td class="labelname">返利下限</td>
					<td><input name="rebates_down" class="mini-textbox" style="width:100%;" vtype="float" emptyText="请输入数字" /></td>
					<td class="labelname">返利上限</td>
					<td><input name="rebates_up" class="mini-textbox" style="width:100%;" vtype="float" emptyText="请输入数字" /></td>
				</tr>
				<tr>
					<td>奖励下限</td>
					<td><input name="bonuses_down" class="mini-textbox" style="width:100%;" vtype="int" emptyText="请输入整数" /></td>
					<td>奖励上限</td>
					<td><input name="bonuses_up" class="mini-textbox" style="width:100%;" vtype="int" emptyText="请输入整数" /></td>
				</tr>
				<tr>
					<td>店提现日期</td>
					<td><input name="taken_dian" class="mini-textbox" style="width:100%;" vtype="int;rangeChar:1,1;range:0,5" emptyText="请输入1-5,1位数字" /></td>
					<td>代理的提现日期</td>
					<td><input name="taken_daili" class="mini-textbox" style="width:100%;" vtype="int;rangeChar:1,1;range:0,5" emptyText="请输入1-5,1位数字" /></td>
				</tr>
				<tr>
					<td>配额下限</td>
					<td><input name="quota_down" class="mini-textbox" style="width:100%;" vtype="int;range:0,500000" emptyText="请输入0-500000数字" /></td>
					<td>配额上限</td>
					<td><input name="quota_up" class="mini-textbox" style="width:100%;" vtype="int;range:0,500000" emptyText="请输入0-500000数字" /></td>
				</tr>
				<tr>
					<td>充值下限</td>
					<td><input name="deposit_down" class="mini-textbox" style="width:100%;" vtype="int;range:0,500000" emptyText="请输入0-500000数字" /></td>
					<td>充值上限</td>
					<td><input name="deposit_up" class="mini-textbox" style="width:100%;" vtype="int;range:0,500000" emptyText="请输入0-500000数字" /></td>
				</tr>
				<tr>
					<td>奖励转货款下限</td>
					<td><input name="bonuses_ratio_down" class="mini-textbox" style="width:100%;" vtype="int" emptyText="请输入数字" /></td>
					<td>奖励转货款上限</td>
					<td><input name="bonuses_ratio_up" class="mini-textbox" style="width:100%;" vtype="int" emptyText="请输入数字" /></td>
				</tr>
				<tr>
					<td>平台分成天数</td>
					<td colspan="3"><input name="balance_date" class="mini-textbox" style="width:100%;" vtype="int;range:0,365" emptyText="请输入1-365数字" /></td>
				</tr>
				<tr>
					<td>说明</td>
					<td colspan="3">
						(1)返利:输入返利的百分比。例如0.3表示30%<br>
						(2)奖励:输入整数。例如50表示50元<br>
						(3)提现日期:限制每周提现的日期。输入整数。例如2表示每周二。<br>
						(4)配额、充值、奖励:输入整数。例如500表示500元。<br>
						(5)奖励转货款:输入奖励转为货款的倍数。例如3表示奖励将乘以3倍，计入货款。
						(6)平台分成天数:设置普通会员购买后，平台分成给代理和店，进入可提现账户的金额的天数。例如7表示7天后。
					</td>
				</tr>
			</tbody>
		</table>
    </div>
</body>
</html>