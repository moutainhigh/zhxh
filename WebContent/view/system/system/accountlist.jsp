<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }
    </style>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    
<script type="text/javascript">

		var grid;
		
       	$(function(){
       		//mini.parse();
       		
			grid = mini.get("grid");
        	grid.set({
        		url:"${pageContext.request.contextPath}/account/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "accountcode",name:"accountcode", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "帐户登录名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "accountname",name:"accountname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "帐户真实姓名",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "password",name:"password", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "登录密码" }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            //onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	grid.load();
        	drawcell();
        })
        
        function drawcell() {
       		grid.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "password") {
   	        		if (value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "color:red;text-align:center";
   	        			e.cellHtml = "********";
   	        		}
    	        }
            });
        }
       	
		function addRow() {
       		
            var newRow = {
            		accountcode: "",
            		accountname:""
            		};
            grid.addRow(newRow, 0);
            grid.beginEditCell(newRow, "accountcode");
        }
		
		function delRow() {
        	var cf1 = "确定要删除选中的帐户吗？注意：不可恢复，请谨慎操作。";
        	
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要删除的帐户.");
       		 	return;
       	 	}
       	 
          	if (confirm(cf1)) {
          		grid.removeRows(rows, false);
   		 	}
			
        }
       	
		function save() {
	    	grid.validate();
	        if (grid.isValid() == false) {
	            mini.alert("输入有误，请校验输入单元格内容","系统提示",
	            	function(action){
	            		//alert(action);
	            		var error = grid.getCellErrors()[0];
	            		grid.beginEditCell(error.record, error.column);
		            }
	            );
	            return;
	        }
	    	
	        var objs = grid.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	mini.alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        grid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: "${pageContext.request.contextPath}/account/save.htmls",
	            data: {'objs':json},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	mini.alert("保存完毕。");
	            	grid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                mini.alert(jqXHR.responseText);
	            }
	        });
	    }
		
		function updatePass() {
			var cf1 = "确定要初始化选中的帐户吗？注意：初始化密码为【123456】，请谨慎操作。";
        	
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要初始化密码的帐户.");
       		 	return;
       	 	}
       	 	
       	 	var ids = getSelectGridid(rows);
       	 
          	if (confirm(cf1)) {
          		grid.loading("初始化密码中，请稍后......");
    	        
    	        $.ajax({
    	        	async:false,
    	            url: "${pageContext.request.contextPath}/account/initUpdatePass.htmls",
    	            data: {'ids':ids},
    	            type: "post",
    	            dataType:"text",
    	            success: function (text) {
    	            	if (text == "success") {
    	            		mini.alert("保存完毕。");
    	            		grid.reload();
    	            	}
    	            	else {
    	            		mini.alert("初始化密码失败。请重新登录再尝试或与开发人员联系。")
    	            	}
    	            	
    	            },
    	            error: function (jqXHR, textStatus, errorThrown) {
    	                mini.alert(jqXHR.responseText);
    	            }
    	        });
   		 	}
		}
		
		function getSelectGridid(rows) {
        	var ids = "";
            for (var i=0;i<rows.length;i++) {
            	ids += rows[i].id + ",";
            }
            ids = ids.substring(0,ids.length-1);
            return ids;
        }
		
</script>
</head>
<body>
	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <table style="width:100%;">
            <tbody>
             <tr>
                 <td style="width:100%;">
                 	<span id="pid" style="padding-left:5px;">帐户列表[注意：新增登录帐户，系统将默认初始密码为 123456 帐户登录后，自行修改密码]</span>
                 </td>
                 <td style="white-space:nowrap;">
                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow()">新增</a>
                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow()">删除</a>
                 	<a class="mini-button" iconCls="icon-reload" plain="true" onclick="updatePass()">初始化密码</a>
	                <span class="separator"></span>
	         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save()">保存</a>
                 </td>
             </tr>
         </tbody>
        </table>
    </div>
    <div class="mini-fit">
        <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
    </div>
</body>
</html>