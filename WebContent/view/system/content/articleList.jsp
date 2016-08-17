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
        		url:"${pageContext.request.contextPath}/public/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	              	{ field: "pic_url",name:"pic_url", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnNewsPicEdit"} },
      	              	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	              	{ field: "title",name:"title", width: 380, headerAlign: "center", align:"center",allowSort: false, header: "标题",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "brief",name:"brief", width: 380, headerAlign: "center", align:"center",allowSort: false, header: "简介",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "sort",name:"sort", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
        	grid.load({act:'public_content',parentid:'article',parenttype:'mrwz'});
        	drawcell();
        })
        
        function drawcell() {
       		grid.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "pic_url") {
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
		
		function delRow() {
        	var cf1 = "确定要删除选中的帐户吗？<br>&nbsp;&nbsp;&nbsp;&nbsp;注意：不可恢复，请谨慎操作。";
        	
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要删除的数据");
       		 	return;
       	 	}
       	 	var del_row = [];
       	 	for (var i=0;i<rows.length;i++) {
       	 		if (rows[i].id != 1) {
       	 			del_row.push(rows[i]);
       	 		}
       	 	}
       	 
       	 	mini.confirm(cf1, "系统提示",
                 function (action) {
                     if (action == "ok") {
                    	 grid.removeRows(del_row, false);
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
	            data: {'objs':json,'act':'public_content','parentid':'article','parenttype':'mrwz'},
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
		
		function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
           	var id = record.id;
            var s = ' <a class="Edit_Button" href="javascript:edit(\'' + id + '\')" >内容</a>'
            return s;
        }
		
		function edit(id){
			if(id == 'undefined'){
				mini.alert("请先保存信息，再添加内容!");
				return;
			}
			var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	         mini.open({
	             url: "${pageContext.request.contextPath}/public/edit.htmls?id="+id,
	             title: "内容编辑", width: pWidth-100, height:pHeight-100,
	             allowResize:true,
	             showMaxButton:true,
	             onload: function () {
	            	 var iframe = this.getIFrameEl();
	            	 var data = { 'id': id };
	                 
	                 //iframe.contentWindow.SetData(data);
	             },
	             ondestroy: function (action) {
	            	 grid.reload();
	             }
	         });
		}
		
		//上传文章图片
		function onBtnNewsPicEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid.getEditorOwnerRow(buttonEdit);
        	
        	if (null == row || typeof(row.id) == "undefined" || row.id == "") {
        		mini.alert("行记录还没有保存，请先保存后再上传.");
	      		return;
	      	}
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传文章图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"upload",forObj:"public_content_pic"};
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