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
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "codename",name:"codename", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "名称" },
      	              	{ field: "pic_path",name:"pic_path", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "图片(80*80)" },
      	                { field: "memo",name:"memo", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "内容",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
        	grid.load({act:'syspublic'});
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
   	        		if (typeof(value) == "undefined" || value == "") {
                		e.cellHtml = '<a href="javascript:;" onclick="open_upload_pic(\'grid\',\''+record.id+'\',\'logo\',\'logo\')" >选择图片</a>';
       	        	}
   	        		else {
   	        			e.cellHtml = '<a href="javascript:;" onclick="open_upload_pic(\'grid\',\''+record.id+'\',\'logo\',\'logo\')" ><img src="${pageContext.request.contextPath}/' + value + '" height="30px" /></a>';
   	        		}
    	        }
            });
        }
       	
       	function open_upload_pic(grid_type,rowid,saveFolder,forObj) {
       		var tmpGrid;
       		
       		if (grid_type == "grid") {
				tmpGrid = grid;
			}
       		
       		var objs = tmpGrid.getChanges();
       		if (objs != "") {
       			parent.parent.layer.msg("发现列表中有未保存的数据。请先保存数据或刷新后再上传图片。",{icon:3});
   	 			return;
       		}
       		else {
       			mini.open({
                    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/upload_pic",
                    title: "上传图片", width: 600, height:500,
                    allowResize:true,
                    onload: function () {
                    	var iframe = this.getIFrameEl();
                   	 	var data = {id:rowid,saveFolder:saveFolder,forObj:forObj};
                        //var data = rows[0];
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                    	if (action == "ok") {
                    		tmpGrid.cancelEdit();
                    		tmpGrid.reload();
                        }
                    }
                });
       		}
       		
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
	        	parent.parent.layer.msg("没有发现修改的内容，请直接修改，然后再保存。",{icon:3});
	        	return;
	        }
	        grid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: "${pageContext.request.contextPath}/public/save.htmls",
	            data: {'act':'logo','objs':json},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	parent.parent.layer.msg("保存完毕。",{icon:6});
	            	grid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	            	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
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
                 	<span id="pid" style="padding-left:5px;">系统公共资源</span>
                 </td>
                 <td style="white-space:nowrap;">
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