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

		var grid_brand;
		var grid_brandpic;
		var grid_brandfirst;
		
       	$(function(){
       		//mini.parse();
       		
			grid_brand = mini.get("grid_brand");
			grid_brand.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "brandlogo",name:"brandlogo", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌Logo",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onButtonEdit"} },
      	                { field: "brandname",name:"brandname", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "品牌名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "brandpath",name:"brandpath",type:"comboboxcolumn", autoEscape:true,width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌显示位置",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"PC端展示"},{"id":"2","text":"移动商城展示"}] } },
      	                { field: "isshow",name:"isshow",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
      	                { field: "brandcolor",name:"brandcolor", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌颜色",vtype:"required",editor: {  type: "buttonedit",allowInput:false,onbuttonclick:"onBtnColorEdit"  } },
      	                { field: "sort",name:"sort", width: 40, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            //fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			grid_brand.load({ listtype: 'brand' });
			//drawcell();
        	
			grid_brandpic = mini.get("grid_brandpic");
			grid_brandpic.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	                { field: "pic_path",name:"pic_path", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "品牌综合页轮播图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnBrandPicEdit" } },
      	              	{ field: "pic_active",name:"pic_active",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
      	              	{ field: "pic_url",name:"pic_url", width: 350, headerAlign: "center", align:"center",allowSort: false, header: "图片点击URL",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "pic_sort",name:"pic_sort", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "pic_memo",name:"pic_memo", width: 450, headerAlign: "center", align:"center",allowSort: false, header: "图片描述",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} }
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
			
			grid_brandfirst = mini.get("grid_brandfirst");
			grid_brandfirst.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	                { field: "firstpic",name:"firstpic", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "品牌综合内容主图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnBrandFirstEdit" } },
      	              	{ field: "title",name:"title", width: 250, headerAlign: "center", align:"center",allowSort: false, header: "标题",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "righttitle",name:"righttitle", width: 250, headerAlign: "center", align:"center",allowSort: false, header: "右侧标题",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "righttitleurl",name:"righttitleurl", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "右侧标题点击url",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "firstpicurl",name:"firstpicurl", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "图片点击url",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "sort",name:"sort", width: 50, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
       		grid_brand.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "brandlogo") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' width='60px' />";
   	        		}
    	        }
                if (field == "brandcolor") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "";
   	        		}
    	        }
         	});
       		grid_brandpic.on("drawcell", function (e) {
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
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' width='60px' />";
   	        		}
    	        }
         	});
       		grid_brandfirst.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "firstpic") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' width='60px' />";
   	        		}
    	        }
         	});
       	}
       	
       	function onSelectionChanged(e) {
            var grid = e.sender;
	       	//处理角色对应的帐户
            var record = grid.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	grid_brandpic.setData([]);
            	grid_brandpic.setTotalCount(0);
            	grid_brandfirst.setData([]);
            	grid_brandfirst.setTotalCount(0);
	      		return;
	      	}
            
            if (record) {
            	grid_brandpic.load({listtype:'brandfirst_lb_pic', parentid: record.id });
            	grid_brandfirst.load({listtype:'brandfirst', parentid: record.id });
            }
        }
       	
       	function upload_brandfirstpic() {
       		
       		//获取品牌
       		var record = grid_brand.getSelected();
	      	
            if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	alert("请先选择品牌，在上传品牌综合页轮播图片.");
	      		return;
	      	}
	    	mini.open({
	    	    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/upload_pic",
	    	    title: "上传品牌综合页轮播图片", width: 600, height: 400,
	    	    onload: function () {
	    	        var iframe = this.getIFrameEl();
	    	        var data = { parentid: record.id,parenttype:"brandfirst_lb_pic"};
	    	        iframe.contentWindow.SetData(data);
	    	    },
	    	    ondestroy: function (action) {
	    	    	grid_brandpic.reload();
	    	    }
	    	});
		}
       	
		function addRow() {
			
			//获取品牌
       		var record = grid_brand.getSelected();
			
            if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	alert("请先选择品牌，再添加品牌综合页内容.");
	      		return;
	      	}
			
			var newRow = {};
			newRow.brandid = record.id;
			newRow.brandname = record.brandname;
			newRow.title = "";
			newRow.righttitle = "";
			newRow.righttitleurl = "";
			newRow.sort = 1;
			newRow.firstpic = "";
			newRow.firstpicurl = "";
			
			grid_brandfirst.addRow(newRow, 0);
			grid_brandfirst.beginEditCell(newRow, "title");
        }
		
		function delRow(grid_type) {
			
			var cf1 = "确定要删除选中的数据吗？";
			var tmpGrid;
			if (grid_type == "grid_brandpic") {
				tmpGrid = grid_brandpic;
			}
			else {
				tmpGrid = grid_brandfirst;
			}
			
        	var rows = tmpGrid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		alert("请选择要删除的数据.");
       		 	return;
       	 	}
       	 
          	if (confirm(cf1)) {
          		tmpGrid.removeRows(rows, false);
   		 	}
			
        }
       	
		function save() {
			
			var url = "${pageContext.request.contextPath}/product/save.htmls";
			var savetype = "brandfirst";
			
			grid_brandfirst.validate();
	        if (grid_brandfirst.isValid() == false) {
	            alert("输入有误，请校验输入单元格内容");
	            var error = grid_brandfirst.getCellErrors()[0];
	            grid_brandfirst.beginEditCell(error.record, error.column);
	            return;
	        }
	    	
	        var objs = grid_brandfirst.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        grid_brandfirst.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: url,
	            data: {'objs':json,'savetype':savetype},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	alert("保存完毕。");
	            	grid_brandfirst.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.responseText);
	            }
	        });
	    }
		
		function saveBrandpic() {
			
			//获取品牌
       		var record = grid_brand.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	alert("请先选择品牌，再添加品牌综合页内容.");
	      		return;
	      	}
			
			var url = "${pageContext.request.contextPath}/public/save.htmls";
			
			grid_brandpic.validate();
	        if (grid_brandpic.isValid() == false) {
	            alert("输入有误，请校验输入单元格内容");
	            var error = grid_brandpic.getCellErrors()[0];
	            grid_brandpic.beginEditCell(error.record, error.column);
	            return;
	        }
	    	
	        var objs = grid_brandpic.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        grid_brandpic.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: url,
	            data: {'objs':json,'act':'publicpic','parentid':record.id,'parenttype':'brandfirst_lb_pic'},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	alert("保存完毕。");
	            	grid_brandpic.reload();
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
		
		function onBtnBrandFirstEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid_brandfirst.getEditorOwnerRow(buttonEdit);
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传品牌综合页主图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"pic",forObj:"firstpic"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		grid_brand.reload();
                		/* var iframe = this.getIFrameEl();
                        var grid_data = iframe.contentWindow.GetData();
                        grid_data = mini.clone(grid_data);    //必须
                        if (grid_data != "" || grid_data.length > 0) {
                        	var row = grid_book.getEditorOwnerRow(buttonEdit);
                            //var row = grid_book.getSelecteds();
                            grid_book.cancelEdit();
                            grid_book.updateRow(row, {
                            	itemid :grid_data.id,
                            	itemcode: grid_data.itemcode,
                            	itemtype:grid_data.itemtype
                            });
                        } */
                    }
                }
            });
        }
        
        
        //以下不确定要
        
        function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var uid = record._uid;
            var id = record.id;
            var rowIndex = e.rowIndex;
            var productname = record.productname;

            var s = ' <a class="Edit_Button" href="javascript:editRated(\'' + id + '\',\'' + productname + '\')" >评价</a>'
            s += '  <a class="Edit_Button" href="javascript:delete_book(\'' + uid + '\')" >详细</a>';
            return s;
        }
        
       		/* grid_product.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "productpic") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' width='60px' />";
   	        		}
    	        }
            }); */
        
       	
       	
       	function onBtnProductEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid_product.getEditorOwnerRow(buttonEdit);
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传商品主图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"pic",forObj:"productpic"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		grid_product.reload();
                		/* var iframe = this.getIFrameEl();
                        var grid_data = iframe.contentWindow.GetData();
                        grid_data = mini.clone(grid_data);    //必须
                        if (grid_data != "" || grid_data.length > 0) {
                        	var row = grid_book.getEditorOwnerRow(buttonEdit);
                            //var row = grid_book.getSelecteds();
                            grid_book.cancelEdit();
                            grid_book.updateRow(row, {
                            	itemid :grid_data.id,
                            	itemcode: grid_data.itemcode,
                            	itemtype:grid_data.itemtype
                            });
                        } */
                    }
                }
            });
        }
       	
       	function onBtnColorEdit(e) {
        	var buttonEdit = e.sender;
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/selectColor",
                title: "选择颜色", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		var iframe = this.getIFrameEl();
                        var color_data = iframe.contentWindow.GetData();
                        color_data = mini.clone(color_data);    //必须
                        if (color_data != "") {
                        	var row = grid_brand.getEditorOwnerRow(buttonEdit);
                            //var row = grid_book.getSelecteds();
                            grid_brand.cancelEdit();
                            grid_brand.updateRow(row, {
                            	brandcolor:color_data
                            });
                        }
                    }
                }
            });
        }
       	
        function editRated(id,productname) {
        	
        	var title = "商品评价";
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/editRated",
                title: title, width: 800, height:600,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {productid:id,productname:productname};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		
                    }
                }
            });
        }
        
		
		
</script>
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
   		<div size="50%" showCollapseButton="false" ><!-- style="border-width: 1;" -->
	    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
		        <table style="width:100%;">
		            <tbody>
		             <tr>
		                 <td style="width:100%;">
		                 	<span id="pid" style="padding-left:5px;">品牌列表</span>
		                 </td>
		                 <td style="white-space:nowrap;">
		                 	<!-- <a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_brand')">新增</a>
		                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brand')">删除</a>
			                <span class="separator"></span>
			         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brand')">保存</a> -->
		                 </td>
		             </tr>
		         	</tbody>
		        </table>
		    </div>
		    <div class="mini-fit">
		        <div id="grid_brand" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
		    </div>
		</div>
		<div showCollapseButton="true">
   			<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" borderStyle="padding:0;border:0;">
	        	<div name="brandPic" title="综合页轮播图片">
	                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
			    		 <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="upload_brandfirstpic()">上传</a>
				     	 <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandpic')">删除</a>
				     	 <span class="separator"></span>
				         <a class="mini-button" iconCls="icon-save" plain="true" onclick="saveBrandpic()">保存</a>
				     </div>
			        <div class="mini-fit" >
				         <div id="grid_brandpic" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				    </div>
	            </div>
	            <div name="brandFirst" title="综合页内容">
	                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
				         <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="addRow()">新增</a>
				         <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandfirst')">删除</a>
				         <span class="separator"></span>
				         <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('meter')">保存</a>
				         <span class="separator"></span>
				     </div>
			        <div class="mini-fit" >
				         <div id="grid_brandfirst" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				     </div>
	            </div>
	        </div>
   		</div>
	</div>
</body>
</html>