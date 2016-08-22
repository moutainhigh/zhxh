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
       		mini.parse();
			grid = mini.get("grid");
        	grid.set({
        		url:"${pageContext.request.contextPath}/public/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	              	{ field: "pic_path",name:"pic_path", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "轮播图片",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "pic_memo",name:"pic_memo", width: 380, headerAlign: "center", align:"center",allowSort: false, header: "图片描述",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "pic_url",name:"pic_url", width: 280, headerAlign: "center", align:"center",allowSort: false, header: "图片点击URL",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "pic_active",name:"pic_active",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
      	              	{ field: "pic_sort",name:"pic_sort", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "图片排序", editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
        	grid.load({act:'publicpic', parentid: 'home_pic',parenttype:'lbt' });
        	drawcell();
        })
        
        function drawcell() {
       		grid.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "pic_path") {
   	        		if (value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' width='60px' />";
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
	    	    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/upload_pic",
	    	    title: "上传图片", width: 600, height: 400,
	    	    onload: function () {
	    	        var iframe = this.getIFrameEl();
	    	        var data = { parentid: "home_pic",parenttype:"lbt"};
	    	        iframe.contentWindow.SetData(data);
	    	    },
	    	    ondestroy: function (action) {

	    	        grid.reload();
	    	    }
	    	});
		}
		
		function delRow() {
        	var cf1 = "确定要删除吗？<br>&nbsp;&nbsp;&nbsp;&nbsp;注意：不可恢复，请谨慎操作。";
        	
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要删除的数据");
       		 	return;
       	 	}
       	 
       	 	mini.confirm(cf1, "系统提示",
                 function (action) {
                     if (action == "ok") {
                    	 grid.removeRows(rows, false);
                     }
                 }
             );
       	 
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
	            url: "${pageContext.request.contextPath}/public/save.htmls",
	            data: {'objs':json,'act':'publicpic','parentid':'home_pic','parenttype':'lbt'},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	mini.alert("保存完毕。");
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