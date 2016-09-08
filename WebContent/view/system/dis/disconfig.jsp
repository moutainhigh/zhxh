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
		.asLabel .mini-textbox-border,
	    .asLabel .mini-textbox-input,
	    .asLabel .mini-buttonedit-border,
	    .asLabel .mini-buttonedit-input,
	    .asLabel .mini-textboxlist-border
	    {
	        border:0;background:none;cursor:default;
	    }
	    .asLabel .mini-buttonedit-button,
	    .asLabel .mini-textboxlist-close
	    {
	        display:none;
	    }
	    .asLabel .mini-textboxlist-item
	    {
	        padding-right:8px;
	    }    
		/* .icon-save:before, .icon-floppy-o:before {
		    content: "";
		} */
	</style>
    
	<script type="text/javascript">
	
		var form;
		var formstate = "label";
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
			labelModel();
			//form.setData(obj, false);
		})
		
		function labelModel() {
            var fields = form.getFields(); 
            for (var i = 0, l = fields.length; i < l; i++) {
                var c = fields[i];
                if (c.setReadOnly) c.setReadOnly(true);     //只读
                if (c.setIsValid) c.setIsValid(true);      //去除错误提示
                if (c.addCls) c.addCls("asLabel");          //增加asLabel外观
            }
        }
		function inputModel() {
        	var editBtn = mini.get("editBtn");
        	
        	if (formstate == "input") {
        		labelModel();
        		formstate = "label";
        		editBtn.setText("编辑");
        		return;
        	}
        	
            var fields = form.getFields();
            for (var i = 0, l = fields.length; i < l; i++) {
                var c = fields[i];
                if (c.setReadOnly) c.setReadOnly(false);
                if (c.removeCls) c.removeCls("asLabel");
            }
            mini.repaint(document.body);
            
            formstate = "input";
            editBtn.setText("取消");
            
        }
		
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
					labelModel();
				},
				error : function(jqXHR, textStatus, errorThrown) {
					mini.alert(jqXHR.responseText);
				}
			});
		}
	</script>
</head>
<body>
	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <table style="width:100%;border-collapse: separate;border-spacing: 3px;">
            <tbody>
             <tr>
                 <td style="width:100%;">
                 	<span id="pid" style="padding-left:5px;">平台利益分配参数设置[如果某些参数如果不设置或设置为0，将不限制]</span>
                 </td>
                 <td style="white-space:nowrap;">
	         		<a id="editBtn" class="mini-button" iconCls="icon-edit" plain="true" onclick="inputModel()">编辑</a>
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
					<td class="labelname">参数设置</td>
					<td colspan="3">设置后，全平台代理、店统一利益分配标准。</td>
				</tr>
				<tr>
					<td class="labelname"><label for="rebates_down$text">返利下限</label></td>
					<td><input id="rebates_down" name="rebates_down" class="mini-textbox" style="width:100%;" vtype="float" emptyText="请输入数字" /></td>
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
					<td><input name="bonuses_ratio_down" class="mini-textbox" style="width:100%;" vtype="float" emptyText="请输入数字" /></td>
					<td>奖励转货款上限</td>
					<td><input name="bonuses_ratio_up" class="mini-textbox" style="width:100%;" vtype="float" emptyText="请输入数字" /></td>
				</tr>
				<tr>
					<td>平台分成天数</td>
					<td colspan="3"><input name="balance_date" class="mini-textbox" style="width:100%;" vtype="int;range:0,365" emptyText="请输入1-365数字" /></td>
				</tr>
				<tr>
					<td>说明</td>
					<td colspan="3" style="color:#FF8C00">
						(1)返利:输入返利的百分比。例如0.3表示30%<br>
						(2)奖励:输入整数。例如50表示50元<br>
						(3)提现日期:限制每周提现的日期。输入整数。例如2表示每周二。<br>
						(4)配额、充值:输入整数。例如500表示500元。<br>
						(5)奖励转货款:输入奖励转为货款的倍数。例如1.3表示奖励将乘以1.3倍，计入货款。<br>
						(6)平台分成天数:设置普通会员购买后，平台分成给代理和店，进入可提现账户的金额的天数。例如7表示7天后。
					</td>
				</tr>
			</tbody>
		</table>
    </div>
</body>
</html>