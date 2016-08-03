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
		var grid_label_2;
		
       	$(function(){
       		//mini.parse();
       		
			grid = mini.get("grid");
        	grid.set({
        		url:"${pageContext.request.contextPath}/label/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:60},
      	                { field: "labelname",name:"labelname", width: 400, headerAlign: "center", align:"center",allowSort: false, header: "标签名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "sort",name:"sort", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "标签排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	grid.load({"parentid":"0"});
        	
        	grid_label_2 = mini.get("grid_label_2");
        	grid_label_2.set({
        		url:"${pageContext.request.contextPath}/label/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:60},
      	                { field: "labelname",name:"labelname", width: 400, headerAlign: "center", align:"center",allowSort: false, header: "标签名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "sort",name:"sort", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "标签排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	//drawcell();
        })
        
        function onSelectionChanged(e) {
            var grid = e.sender;
	      	//处理角色对应的帐户
            var record = grid.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	grid_label_2.setData([]);
            	grid_label_2.setTotalCount(0);
	      		return;
	      	}
            
            if (record) {
            	grid_label_2.load({ parentid: record.id });
            }
        }
        
        /* function drawcell() {
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
        } */
       	
		function addRow(grid_type,parentid) {
			
			var tmpGrid;
			if (grid_type == "grid") {
				tmpGrid = grid;
			}
			else {
				tmpGrid = grid_label_2;
				
				var rows = grid.getSelecteds();
	          	 
	       	 	if (rows.length == 0) {
	       	 		alert("请选择要添加二级标签的所属一级标签.");
	       		 	return;
	       	 	}
	       	 	else {
	       	 		if (typeof(rows[0].id) == "undefined" || rows[0].id == "") {
	       	 			alert("当前一级标签还没有保存。请先保存一级标签后再创建二级标签。");
	       	 			return;
	       	 		}
	       	 		else {
	       	 			parentid = rows[0].id;
	       	 		}
	       	 	}
			}
			
            var newRow = {
            		labelname: "",
            		parentid:parentid,
            		sort:1
            		};
            tmpGrid.addRow(newRow, 0);
            tmpGrid.beginEditCell(newRow, "labelname");
        }
		
		function delRow(grid_type) {
			
			var cf1 = "确定要删除选中的标签吗？";
			var tmpGrid;
			if (grid_type == "grid") {
				tmpGrid = grid;
				cf1 += "<br>注意：删除一级分类，将同时删除所属的二级分类，并同时取消二级分类与其他商品之间的关联关系。不可恢复，请谨慎操作。";
			}
			else {
				tmpGrid = grid_label_2;
				cf1 += "<br>注意：删除二级分类，将同时取消二级分类与其他商品之间的关联关系,不可恢复，请谨慎操作";
			}
			
        	var rows = tmpGrid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		alert("请选择要删除的标签.");
       		 	return;
       	 	}
       	 	var del_row = [];
       	 	for (var i=0;i<rows.length;i++) {
       	 		if (rows[i].id != 1) {
       	 			del_row.push(rows[i]);
       	 		}
       	 	}
       	 
          	if (confirm(cf1)) {
          		tmpGrid.removeRows(del_row, false);
   		 	}
			
        }
       	
		function save(grid_type) {
			
			var tmpGrid;
			if (grid_type == "grid") {
				tmpGrid = grid;
			}
			else {
				tmpGrid = grid_label_2;
			}
			
			
			tmpGrid.validate();
	        if (tmpGrid.isValid() == false) {
	            alert("输入有误，请校验输入单元格内容");
	            var error = tmpGrid.getCellErrors()[0];
	            tmpGrid.beginEditCell(error.record, error.column);
	            return;
	        }
	    	
	        var objs = tmpGrid.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        tmpGrid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: "${pageContext.request.contextPath}/label/save.htmls",
	            data: {'objs':json},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	alert("保存完毕。");
	            	tmpGrid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.responseText);
	            }
	        });
	    }
		
		/* function updatePass() {
			var cf1 = "确定要初始化选中的帐户吗？注意：初始化密码为【123456】，请谨慎操作。";
        	
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		alert("请选择要初始化密码的帐户.");
       		 	return;
       	 	}
       	 	
       	 	var ids = getSelectGridid(rows);
       	 
          	if (confirm(cf1)) {
          		grid.loading("初始化密码中，请稍后......");
    	        
    	        $.ajax({
    	        	async:false,
    	            url: "${pageContext.request.contextPath}/account/initUpdatePass.html",
    	            data: {'ids':ids},
    	            type: "post",
    	            dataType:"text",
    	            success: function (text) {
    	            	if (text == "success") {
    	            		alert("保存完毕。");
    	            		grid.reload();
    	            	}
    	            	else {
    	            		alert("初始化密码失败。请重新登录再尝试或与开发人员联系。")
    	            	}
    	            	
    	            },
    	            error: function (jqXHR, textStatus, errorThrown) {
    	                alert(jqXHR.responseText);
    	            }
    	        });
   		 	}
		} */
		
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
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
   		<div size="60%" showCollapseButton="false" style="border-width: 1;">
	    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
		        <table style="width:100%;">
		            <tbody>
		             <tr>
		                 <td style="width:100%;">
		                 	<span id="pid" style="padding-left:5px;">标签一级分类</span>
		                 </td>
		                 <td style="white-space:nowrap;">
		                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid','0')">新增</a>
		                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid')">删除</a>
			                <span class="separator"></span>
			         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid')">保存</a>
		                 </td>
		             </tr>
		         </tbody>
		        </table>
		    </div>
		    <div class="mini-fit">
		        <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
		    </div>
		</div>
		<div showCollapseButton="true">
   			<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
	            <table style="width:100%;">
	                <tbody>
		                <tr>
		                    <td style="width:100%;">
		                    	<span id="pid" style="padding-left:5px;">标签二级分类</span>
		                    </td>
		                    <td style="white-space:nowrap;">
		                    	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_label_2','0')">新增</a>
		                 		<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_label_2')">删除</a>
				                <span class="separator"></span>
				         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_label_2')">保存</a>
		                    </td>
		                </tr>
		            </tbody>
	            </table>
	        </div>
	        <div class="mini-fit">
	            <div id="grid_label_2" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
	        </div>
   		</div>
	</div>
</body>
</html>