<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
	
	
	<style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }
		.labelname {
			width:100px;
		}
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
	</style>
    
	<script type="text/javascript">
	
		var form;
		var formstate = "label";
		$(function() {
			mini.parse();
			form = new mini.Form("#form1");
			/*$.ajax({
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
			}) */
			//form.setData(obj, false);
			labelModel();
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
				},
				error : function(jqXHR, textStatus, errorThrown) {
					mini.alert(jqXHR.responseText);
				}
			});
		}
	</script>
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
   		<div size="50%" showCollapseButton="false" style="border-width: 1;">
   			<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
		        <table style="width:100%;border-collapse: separate;border-spacing: 3px;">
		            <tbody>
			             <tr>
			                 <td style="width:100%;">
			                 	<span id="pid" style="padding-left:5px;">平台对代理、直营店通用利益标准[<span style="color:red">如果没有对代理、直营店设置，就采用通用的标准</span>]</span>
			                 </td>
			                 <td style="white-space:nowrap;">
				         		<a id="editBtn" class="mini-button" iconCls="icon-edit" plain="true" onclick="inputModel()">编辑</a>
				         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save()">保存</a>
			                 </td>
			             </tr>
			        </tbody>
		        </table>
		    </div>
		    <div class="mini-fit">
			    <div id="form1" style="text-align: center;">
			    	<input name="id" class="mini-textbox" style="width:100%;" visible=false/>
			        <table class="table table-bordered t" style="width: 80%;margin:auto; margin-top: 20px">
						<tbody>
							<tr>
								<td class="labelname">参数设置</td>
								<td colspan="7">设置后，平台下代理、直营店通用利益分配标准。</td>
							</tr>
							<tr>
								<td class="labelname"><label for="rebates_down$text">代理折扣</label></td>
								<td colspan="7"><input id="buyerdis_a" name="buyerdis" class="mini-textbox" style="width:100%;" vtype="float" emptyText="请输入数字" /></td>
							</tr>
							<tr>
								<td><label for="rebates_down$text">直营店折扣</label></td>
								<td><input id="buyerdis_c" name="buyerdis_c" class="mini-textbox" style="width:100%;" vtype="float" emptyText="请输入数字" /></td>
								<td>直营店返利</td>
								<td><input name="rebatesdis" class="mini-textbox" style="width:100%;" vtype="int" emptyText="请输入整数" /></td>
								<td>直营店奖励</td>
								<td><input name="bonusesdis" class="mini-textbox" style="width:100%;" vtype="int" emptyText="请输入整数" /></td>
								<td>直营店奖励转货款</td>
								<td><input name="bonuses_ratio" class="mini-textbox" style="width:100%;" vtype="float" emptyText="请输入数字" /></td>
							</tr>
							<tr>
								<td>说明</td>
								<td colspan="7" style="color:#FF8C00">
									(1)折扣:输入进货折扣百分比。例如0.3表示3折进货。<br>
									(1)返利:输入返利的百分比。例如0.3表示30%<br>
									(2)奖励:输入整数。例如50表示50元<br>
									(5)奖励转货款:输入奖励转为货款的倍数。例如1.3表示奖励将乘以1.3倍，计入货款。<br>
								</td>
							</tr>
						</tbody>
					</table>
			    </div>
		    </div>
		</div>
		<div showCollapseButton="true">
			<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" borderStyle="padding:0;border:0;">
	        	<div name="brandPic" title="综合页轮播图片">
	                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
			    		 <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="upload_brandfirstpic()">上传</a>
				     	 <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandpic')">删除</a>
				     	 <span class="separator"></span>
				         <a class="mini-button" iconCls="icon-save" plain="true" onclick="saveBrandpic()">保存</a>
				     </div>
			        <div class="mini-fit" >
				         <div id="grid_brandpic" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				    </div>
	            </div>
	            <div name="brandFirst" title="综合页内容">
	                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
				         <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="addRow()">新增</a>
				         <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandfirst')">删除</a>
				         <span class="separator"></span>
				         <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('meter')">保存</a>
				         <span class="separator"></span>
				     </div>
			        <div class="mini-fit" >
				         <div id="grid_brandfirst" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				     </div>
	            </div>
	        </div>
		</div>
	</div>
	
</body>
</html>