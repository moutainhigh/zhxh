<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

	<style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    
    </style>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    
    <script type="text/javascript">
	    //mini.parse();
	    
	    var grid;
	    var parentid;
	    var parenttype;
		
	    $(function(){
	    	mini.parse();
	    	grid = mini.get("grid");
	    	grid.set({
        		url:"${pageContext.request.contextPath}/public/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	                { field: "pic_path",name:"pic_path", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "品牌综合页轮播图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnEdit" } },
      	              	{ field: "pic_active",name:"pic_active",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
      	              	/* { field: "pic_url",name:"pic_url", width: 350, headerAlign: "center", align:"center",allowSort: false, header: "图片点击URL",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }, */
      	              	{ field: "pic_sort",name:"pic_sort", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	                /* { field: "pic_memo",name:"pic_memo", width: 450, headerAlign: "center", align:"center",allowSort: false, header: "图片描述",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} } */
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
	            //fitColumns:false,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
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
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
   	        		}
    	        }
                
                if (field == "pic_active") {
                	if (value == 0){
   	        			e.cellStyle = "color:red;text-align:center";
   	        		}
   	        		else if (value == 1) {
   	        			e.cellStyle = "color:blue;text-align:center";
   	        		}
    	        }
         	});
        }
	    
	  	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			parentid = data.parentid;
			parenttype = data.parenttype;
			
			grid.load({act:'publicpic',parenttype:parenttype, parentid: parentid });
			
		}
	  	
		function upload_pic() {
	    	mini.open({
	    	    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/upload_pic",
	    	    title: "上传图片", width: 600, height: 400,
	    	    onload: function () {
	    	        var iframe = this.getIFrameEl();
	    	        var data = { parentid: parentid,parenttype:parenttype};
	    	        iframe.contentWindow.SetData(data);
	    	    },
	    	    ondestroy: function (action) {
	    	    	grid.reload();
	    	    }
	    	});
		}
		
		//上传修改综合页轮播图片。单张修改
		function onBtnEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid.getEditorOwnerRow(buttonEdit);
        	
        	if (null == row || typeof(row.id) == "undefined" || row.id == "") {
        		alert("行记录还没有保存，请先保存后再上传.");
	      		return;
	      	}
        	
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传修改图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"upload",forObj:"publicpic"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid.cancelEdit();
            		grid.reload();
                }
            });
        }
		
		function delRow() {
        	var cf1 = "确定要删除选中的数据吗？";
        	
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
	            data: {'objs':json,'act':'publicpic','parentid':parentid,'parenttype':parenttype},
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
	    
	    function GetData() {
			var rows = grid_product.getSelecteds();
	        return rows;
	    }
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	    	//判断固定收费的各种日期是否设置。
	    	var rows = GetData();
	    	if (rows.length == 0) {
	    		CloseWindow("cancel");
	    	}
	    	else {
	    		CloseWindow("ok");
	    	}
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	</script>
	
	<style type="text/css">
		#img{width:220px;height:120px;display:block; border:1px solid #d3d3d3;}
	</style>
    
</head>
<body>
    <div class="mini-fit">
    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
	        <table style="width:100%;">
	            <tbody>
	             <tr>
	                 <td style="width:100%;">
	                 	<span id="pid" style="padding-left:5px;">图片列表</span>
	                 </td>
	                 <td style="white-space:nowrap;">
	                 	<a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="upload_pic()">上传</a>
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
    </div>                
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border-top:1;border-left:0;border-right:0;">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>