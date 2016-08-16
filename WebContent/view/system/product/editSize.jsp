<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <script>
    
    	var grid;
    	var parentid = "";
    	
    	$(function(){
    		grid = mini.get("grid");
    		grid.set({
	    		url:"${pageContext.request.contextPath}/product/list.htmls",
	            columns: [
	                  { type: "checkcolumn",headerAlign:"center",width: 30},
					  { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
					  { field: "productsize",name:"productsize", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "规格标准",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
					  { field: "price",name:"price",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "售价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25 } },
					  { field: "saleprice",name:"saleprice", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "特价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25  } },
					  { field: "sizesort",name:"sizesort", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: {type: "textbox", minValue: 0, maxValue: 500, value: 25 } },
					  { field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } }
				],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            //onselectionchanged:"onSelectionChanged",
	            allowUnselect:false,
	            showPager:true,
	            showPageSize:false,
	            pageSize:1000
	        });
    	})
    	
    	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			parentid = data.productid;
			var productname = data.productname;
			
			$("#pid").html("设置商品["+productname+"]规格价格");
			grid.load({ listtype:'productsize',parentid: parentid });
		}
    	
		function addRow() {
			
			var newRow = {};
			newRow.productid = parentid;
			newRow.productsize = "";
			newRow.price = "";
			newRow.saleprice = "";
			newRow.isshow = "0";
			newRow.sizesort = "1";
			
            grid.addRow(newRow, 0);
            grid.beginEditCell(newRow, "productsize");
        }
		
		function delRow() {
			
			var cf1 = "确定要删除选中的规格价格吗？";
			
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要删除的数据.");
       		 	return;
       	 	}
       	 	var del_row = [];
       	 	for (var i=0;i<rows.length;i++) {
       	 		if (rows[i].id != 1) {
       	 			del_row.push(rows[i]);
       	 		}
       	 	}
       	 	
       	 	mini.confirm(cf1, "确定？",
                 function (action) {
                     if (action == "ok") {
                    	 grid.removeRows(del_row, false);
                     } else {
                         
                     }
                 }
            );
        }
       	
		function save() {
			
			var url = "${pageContext.request.contextPath}/product/save.htmls";
			var savetype = "productsize";
			
			grid.validate();
	        if (grid.isValid() == false) {
	            mini.alert("输入有误，请校验输入单元格内容");
	            var error = grid.getCellErrors()[0];
	            grid.beginEditCell(error.record, error.column);
	            return;
	        }
	    	
	        var objs = grid.getChanges();
	        var json = mini.encode(objs,"yyyy-MM-dd");
	        if (json.length == 2) {
	        	mini.alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        grid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: url,
	            data: {'objs':json,'savetype':savetype},
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
    	
    	function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	        CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	    function onRowDblClick(e) {
	        onOk();
	    }
	</script>
</head>
<body>
	<div class="mini-toolbar" borderStyle="border:0;">
        <table style="width:100%;">
            <tbody>
             <tr>
                 <td style="width:100%;">
                 	<span id="pid" style="padding-left:5px;">编辑商品评价</span>
                 </td>
                 <td style="white-space:nowrap;">
                  	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow()">新增</a>
                	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow()">删除</a>
	                <span class="separator"></span>
	         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save()">保存</a>
                 </td>
             </tr>
         </tbody>
        </table>
    </div>
    <div class="mini-fit"><!-- border-bottom: 1;border-top: 0;border-left:0;broder-right:0" -->
        <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border-bottom: 1;border-top: 1;border-left:0;border-right:0;"></div>
    </div>
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>