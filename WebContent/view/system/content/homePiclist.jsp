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
        		url:"${pageContext.request.contextPath}/home/list.html",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "pic_memo",name:"pic_memo", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "图片描述",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "pic_path",name:"pic_path", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "图片地址",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "pic_url",name:"pic_url", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "图片点击URL" },
      	                { field: "pic_sort",name:"pic_sort", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "图片排序" }
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
        	//drawcell();
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
		
		function add() {
	    	mini.open({
	    	    //url: "/view/system/member/EmployeeWindow.html",
	    	    url: "${pageContext.request.contextPath}/common/dispatch.html?page=/view/system/content/upload_pic",
	    	    title: "上传图片", width: 600, height: 400,
	    	    onload: function () {
	    	        var iframe = this.getIFrameEl();
	    	        var data = { parentid: "home_pic",parenttype:"首页轮播图"};
	    	        iframe.contentWindow.SetData(data);
	    	    },
	    	    ondestroy: function (action) {

	    	        grid.reload();
	    	    }
	    	});
		}
		
		function delRow() {
        	var cf1 = "确定要删除选中的帐户吗？注意：不可恢复，请谨慎操作。";
        	
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		alert("请选择要删除的帐户.");
       		 	return;
       	 	}
       	 	var del_row = [];
       	 	for (var i=0;i<rows.length;i++) {
       	 		if (rows[i].id != 1) {
       	 			del_row.push(rows[i]);
       	 		}
       	 	}
       	 
          	if (confirm(cf1)) {
          		grid.removeRows(del_row, false);
   		 	}
			
        }
       	
		function save() {
	    	grid.validate();
	        if (grid.isValid() == false) {
	            alert("输入有误，请校验输入单元格内容");
	            var error = grid.getCellErrors()[0];
	            grid.beginEditCell(error.record, error.column);
	            return;
	        }
	    	
	        var objs = grid.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        grid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: "${pageContext.request.contextPath}/home/save.html",
	            data: {'objs':json},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	alert("保存完毕。");
	            	grid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.responseText);
	            }
	        });
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
                 	<span id="pid" style="padding-left:5px;">首页轮播图</span>
                 </td>
                 <td style="white-space:nowrap;">
                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="add()">新增</a>
                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow()">删除</a>
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