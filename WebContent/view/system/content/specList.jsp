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
      	              	{ field: "pic",name:"pic", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "图片(300*300)",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnNewsPicEdit"} },
      	              	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	              	{ field: "title",name:"title", width: 380, headerAlign: "center", align:"center",allowSort: false, header: "标题",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "file_old_name",name:"file_old_name", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "文件名称",editor: {  type:"buttonedit",allowInput:false,onbuttonclick:"onBtnFileEdit" } },
      	              	{ field: "sort",name:"sort", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
        	grid.load({act:'public_file',parentid:'files',parenttype:'spec'});
        	drawcell();
        })
        
        function drawcell() {
       		grid.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "pic") {
   	        		if (value == undefined) {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='30px' />";
   	        		}
    	        }
            });
        }
       	
		function addRow() {
       		
            var newRow = {sort:1};
            grid.addRow(newRow, 0);
            grid.beginEditCell(newRow, "title");
        }
		
		function delRow() {
			var cf1 = "确定要删除选中的数据吗？<br><p style='font-size:12px; color:red'>注意：删除后，不可恢复，请谨慎操作.</p>";
        	var rows = grid.getSelecteds();
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要删除的数据.",{icon:6});
       		 	return;
       	 	}
       	 
       	 	parent.parent.layer.msg(cf1, {
	 	 		icon:3
	 	 		,time: 0 //不自动关闭
	 	  		,btn: ['确认删除', '取消']
	 	  		,yes: function(index){
	 	  			grid.removeRows(rows, false);
	 	    		parent.parent.layer.close(index);
	 	  		}
	 		});
        }
       	
		function save() {
	    	grid.validate();
	        if (grid.isValid() == false) {
	        	parent.parent.layer.msg('输入有误，请校验输入单元格内容', {
	        		  icon: 5,
	        		  time: 2000 //2秒关闭（如果不配置，默认是3秒）
	        		}, function(){
	        			var error = grid.getCellErrors()[0];
	            		grid.beginEditCell(error.record, error.column);
	        		}
	        	);
	            return;
	        }
	    	
	        var objs = grid.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	parent.parent.layer.msg("没有发现修改的内容，请直接修改，然后再保存",{icon:6});
	        	return;
	        }
	        grid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: "${pageContext.request.contextPath}/public/save.htmls",
	            data: {'objs':json,'act':'public_file','parentid':'files','parenttype':'spec'},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	parent.parent.layer.msg("保存完毕",{icon:6});
	            	grid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.responseText);
	            }
	        });
	    }
		
		function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
           	var id = record.id;
           	var filePath = record.file_path;
           	var s = "";
           	if(filePath != undefined){
           		s = ' <a class="Edit_Button" href="${pageContext.request.contextPath}/pcMain/downloadfile.htmls?id=' + id + '" >下载</a>'
           	}
            		
            return s;
        }
		
		function edit(id){
			if(id == 'undefined'){
				parent.parent.layer.msg("请先保存数据，再操作!",{icon:6});
				return;
			}
			var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	         mini.open({
	             url: "${pageContext.request.contextPath}/public/edit.htmls?id="+id,
	             title: "内容编辑", width: pWidth-200, height:pHeight-100,
	             allowResize:true,
	             showMaxButton:true,
	             onload: function () {
	            	 var iframe = this.getIFrameEl();
	            	 var data = { 'id': id };
	                 
	                 //iframe.contentWindow.SetData(data);
	             },
	             ondestroy: function (action) {
	            	 //grid.reload();
	             }
	         });
		}
		
		//上传文件图片
		function onBtnNewsPicEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid.getEditorOwnerRow(buttonEdit);
        	
        	if (null == row || typeof(row.id) == "undefined" || row.id == "") {
        		parent.parent.layer.msg("行记录还没有保存，请先保存后再上传.",{icon:6});
	      		return;
	      	}
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"upload",forObj:"public_file_pic"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid.cancelEdit();
            		grid.reload();
                }
            });
        }
        
		//上传文件
		function onBtnFileEdit(e) {
        	var buttonEdit = e.sender;
			var row = grid.getEditorOwnerRow(buttonEdit);
        	
        	if (null == row || typeof(row.id) == "undefined" || row.id == "") {
        		parent.parent.layer.msg("行记录还没有保存，请先保存后再上传.",{icon:6});
	      		return;
	      	}
        	
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/upload_file",
                title: "上传文件", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid.cancelEdit();
                	grid.reload();
                }
            });
        }
</script>
</head>
<body>
	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <table style="width:100%;">
            <tbody>
             <tr>
                 <td style="width:100%;">
                 	<span id="pid" style="padding-left:5px;">行业新闻</span>
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
    <div class="mini-fit">
        <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
    </div>
</body>
</html>