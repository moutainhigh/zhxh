<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <style type="text/css">
	    html, body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    
    </style>
    
    <script type="text/javascript">
	    var grid;
	    var Genders = [{ id: 1, text: '先生' }, { id: 2, text: '女士'}];
	   	$(function(){
	   		//mini.parse();
	   		
			grid = mini.get("grid");
	    	grid.set({
	    		url:"${pageContext.request.contextPath}/userManager/list.htmls",
	    		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
	  	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
	  	              	{ field: "phonenumber",name:"phonenumber", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "手机",vtype:"required" ,editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	                { field: "username",name:"username", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "真实姓名",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	            	{ field: "birthday",name:"birthday", width: 80, headerAlign: "center", align:"center",allowSort: false, dateFormat:"yyyy-MM-dd", header: "生日",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
	  	          		{ type:"comboboxcolumn",field: "sex",name:"sex",autoShowPopup:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "性别",editor: { type: "combobox",data:"Genders"} },
	  	          	
	  	                { field: "password",name:"password", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "登录密码",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
	  	          		
	  	          	
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
	    });
	   	
	   	//绘制表格
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
       	        	}else {
   	        			e.cellStyle = "color:red;text-align:center";
   	        			e.cellHtml = "********";
   	        		}
    	        }
            });
        }
	   	
	    function search() {
            var key = mini.get("key").getValue();
            grid.load({ key: key });
        }

        function onKeyEnter(e) {
            search();
        }

        function addRow() {          
            var newRow = { name: "New Row" };
            grid.addRow(newRow, 0);

            grid.beginEditCell(newRow, "LoginName");
        }
        function removeRow() {
            var rows = grid.getSelecteds();
            if (rows.length > 0) {
                grid.removeRows(rows, true);
            }else{
            	alert("请选择要删除的账户");
            }
        }
        function saveData() {   
        	//验证非空
        	grid.validate();
        	if(grid.isValid() == false) {
	            mini.alert("输入有误，请校验输入单元格内容","系统提示",
	            	function(action){
	            		//alert(action);
	            		var error = grid.getCellErrors()[0];
	            		grid.beginEditCell(error.record, error.column);
		            }
	            );
	            return;
	        }
        	
            var data = grid.getChanges();
            var json = mini.encode(data);
            grid.loading("保存中，请稍后......");
            $.ajax({
                url: "${pageContext.request.contextPath}/userManager/save.htmls",
                data: { "objs": json },
                type: "post",
                dataType:"text",
                success: function (text) {
                	alert("保存成功");
                    grid.reload();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
            });
        }

        
    </script>
</head>
<body>
	<div class="mini-toolbar" style="padding:2px;border-bottom:0;">
	    <table style="width:100%;">
	        <tr>
	            <td style="width:100%;">
	                <a class="mini-button" iconCls="icon-add" onclick="addRow()" plain="true" tooltip="增加...">增加</a>
	                <a class="mini-button" iconCls="icon-remove" onclick="removeRow()" plain="true">删除</a>
	                <span class="separator"></span>
	                <a class="mini-button" iconCls="icon-save" onclick="saveData()" plain="true">保存</a>            
	            </td>
	            <td style="white-space:nowrap;">
	                <input id="key" class="mini-textbox" emptyText="请输入姓名" style="width:150px;" onenter="onKeyEnter"/>   
	                <a class="mini-button" onclick="search()">查询</a>
	            </td>
	        </tr>
	    </table>           
	</div>
	<div class="mini-fit" >
		<div id="grid" class="mini-datagrid" style="width:100%;height:100%;" >
	        
	    </div>
	</div>
    
</body>
</html>