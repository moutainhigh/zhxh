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
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script> --%>
    <script>
    
    	var grid_rated;
    	var parentid = "";
    	
    	$(function(){
    		mini.parse();
    		grid_rated = mini.get("grid_rated");
    		grid_rated.set({
	    		url:"${pageContext.request.contextPath}/product/list.htmls",
	            columns: [
	                  { type: "checkcolumn",headerAlign:"center",width: 30},
					  { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
					  { field: "username",name:"username", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "评价帐户名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
					  { field: "ratedtime",name:"ratedtime",dateFormat:"yyyy-MM-dd",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "评价时间",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
					  { field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
					  { field: "ratedmemo",name:"ratedmemo", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "评价内容",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} }
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
	            pageSize:100
	        });
    	})
    	
    	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			parentid = data.productid;
			var productname = data.productname;
			
			$("#pid").html("编辑商品["+productname+"]评价");
			grid_rated.load({ listtype:'rated',parentid: parentid });
		}
    	
		function addRow() {
			
			var newRow = {};
			newRow.parentid = parentid;
			newRow.username = "";
			newRow.userid = "";
			newRow.isshow = "0";
			newRow.ratedmemo = "";
			
			var now = new Date();
            var nowDate = now.getFullYear()+"-"+((now.getMonth()+1)<10?"0":"")+(now.getMonth()+1)+"-"+(now.getDate()<10?"0":"")+now.getDate();
	    	newRow.ratedtime = nowDate;
			
            grid_rated.addRow(newRow, 0);
            grid_rated.beginEditCell(newRow, "username");
        }
		
		function delRow() {
			
			var cf1 = "确定要删除选中的评价吗？";
			
        	var rows = grid_rated.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要删除的数据.");
       		 	return;
       	 	}
       	 	
       	 	mini.confirm(cf1, "确定？",
                 function (action) {
                     if (action == "ok") {
                    	 grid_rated.removeRows(rows, false);
                     } else {
                         
                     }
                 }
            );
        }
       	
		function save() {
			
			var url = "${pageContext.request.contextPath}/product/save.htmls";
			var savetype = "rated";
			
			grid_rated.validate();
	        if (grid_rated.isValid() == false) {
	            mini.alert("输入有误，请校验输入单元格内容","系统提示",
	            	function(action){
	            		//alert(action);
	            		var error = grid_rated.getCellErrors()[0];
	            		grid_rated.beginEditCell(error.record, error.column);
		            }
	            );
	            return;
	        }
	    	
	        var objs = grid_rated.getChanges();
	        var json = mini.encode(objs,"yyyy-MM-dd");
	        if (json.length == 2) {
	        	mini.alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        grid_rated.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: url,
	            data: {'objs':json,'savetype':savetype},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	mini.alert("保存完毕。");
	            	grid_rated.reload();
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
        <div id="grid_rated" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border-bottom: 1;border-top: 1;border-left:0;border-right:0;"></div>
    </div>
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>