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
    <%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jquery.bigcolorpicker/jquery.bigcolorpicker.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.bigcolorpicker/jquery.bigcolorpicker.min.js"></script> --%>
	<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/colorpicker/jquery.colorpicker.js"></script> --%>
    
<script type="text/javascript">

		var grid_brand;
		var grid_product;
		
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
	            allowCellEdit:true,
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
        	
			grid_product = mini.get("grid_product");
			grid_product.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	              	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	                { field: "productpic",name:"productpic", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "商品主图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnProductEdit" } },
      	                { field: "productname",name:"productname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "productcode",name:"productcode", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "商品型号",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "showtype",name:"showtype",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "商品显示类型",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"富文本"},{"id":"2","text":"仅图片"}] } },
      	                { field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
      	                { field: "productmemo",name:"productmemo", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品简介",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "createdate",name:"update",dateFormat:"yyyy-MM-dd", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "上架日期",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "ifdis",name:"ifdis",type:"comboboxcolumn", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "是否参与三级分销",editor: { type: "combobox", data: [{"id":"0","text":"否"},{"id":"1","text":"是"}] } },
      	                { field: "sort",name:"sort", width: 30, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	drawcell();
        })
        
        function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var uid = record._uid;
            var id = record.id;
            var rowIndex = e.rowIndex;
            var productname = record.productname;

            var s = ' <a class="Edit_Button" href="javascript:editRated(\'' + id + '\',\'' + productname + '\')" >评价</a>'
            s += '  <a class="Edit_Button" href="javascript:delete_book(\'' + id + '\')" >详细</a>';
            s += '  <a class="Edit_Button" href="javascript:getUrl(\'' + id + '\')" >获取地址</a>';
            return s;
        }
       	
       	function getUrl() {
       		alert("${pageContext.request.contextPath}/id");
       	}
        
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
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
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
       		
       		grid_product.on("drawcell", function (e) {
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
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
   	        		}
    	        }
            });
        }
       	
       	function onButtonEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid_brand.getEditorOwnerRow(buttonEdit);
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传品牌Logo", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"logo",forObj:"brandlog"};
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
       	
        function onSelectionChanged(e) {
            var grid = e.sender;
	       	//处理角色对应的帐户
            var record = grid.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	grid_product.setData([]);
            	grid_product.setTotalCount(0);
	      		return;
	      	}
            
            if (record) {
            	grid_product.load({listtype:'product', parentid: record.id });
            }
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
        
		function addRow(grid_type) {
			
			var tmpGrid;
			var editField;
			var newRow = {};
			if (grid_type == "grid_brand") {
				tmpGrid = grid_brand;
				newRow.brandname = "";
				newRow.sort = 1;
				newRow.brandpath = "1";
				newRow.isshow = "0";
				newRow.brandcolor = "";
				
				editField = "brandname";
			}
			else {
				tmpGrid = grid_product;
				
				var rows = grid_brand.getSelecteds();
				var brandid = "";
	       	 	if (rows.length == 0) {
	       	 		alert("请选择要添加商品的所属品牌.");
	       		 	return;
	       	 	}
	       	 	else {
	       	 		if (typeof(rows[0].id) == "undefined" || rows[0].id == "") {
	       	 			alert("当前品牌还没有保存。请先保存品牌后再创建商品。");
	       	 			return;
	       	 		}
	       	 		else {
	       	 			brandid = rows[0].id;
	       	 		}
	       	 	}
	       	 	
	       	 	newRow.productpic = "";
	       	 	newRow.brandid = brandid;
				newRow.productname = "";
				newRow.productcode = "";
				newRow.showtype = "1";
				newRow.isshow = "0";
				newRow.productmemo = "";
				
				newRow.ifdis = "0";
				newRow.sort = 1;
				
				var now = new Date();
	            var nowDate = now.getFullYear()+"-"+((now.getMonth()+1)<10?"0":"")+(now.getMonth()+1)+"-"+(now.getDate()<10?"0":"")+now.getDate();
		    	newRow.createdate = nowDate;
				
				editField = "productname";
			}
			
            tmpGrid.addRow(newRow, 0);
            tmpGrid.beginEditCell(newRow, editField);
        }
		
		function delRow(grid_type) {
			
			var cf1 = "确定要删除选中的数据吗？";
			var tmpGrid;
			if (grid_type == "grid_brand") {
				tmpGrid = grid_brand;
				cf1 += "<br>注意：删除品牌，将同时删除所属的商品，并删除该品牌下的所有设置。不可恢复，请谨慎操作。";
			}
			else {
				tmpGrid = grid_product;
				cf1 += "<br>注意：删除商品，将同时删除该商品的所有设置,不可恢复，请谨慎操作";
			}
			
        	var rows = tmpGrid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		alert("请选择要删除的数据.");
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
			var url = "${pageContext.request.contextPath}/product/save.htmls";
			var savetype = "brand";
			if (grid_type == "grid_brand") {
				tmpGrid = grid_brand;
			}
			else {
				tmpGrid = grid_product;
				//url = "${pageContext.request.contextPath}/product/saveProduct.html";
				savetype = "product";
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
	            url: url,
	            data: {'objs':json,'savetype':savetype},
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
   		<div size="50%" showCollapseButton="false" style="border-width: 1;">
	    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
		        <table style="width:100%;">
		            <tbody>
		             <tr>
		                 <td style="width:100%;">
		                 	<span id="pid" style="padding-left:5px;">品牌列表</span>
		                 </td>
		                 <td style="white-space:nowrap;">
		                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_brand')">新增</a>
		                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brand')">删除</a>
			                <span class="separator"></span>
			         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brand')">保存</a>
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
   			<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
	            <table style="width:100%;">
	                <tbody>
		                <tr>
		                    <td style="width:100%;">
		                    	<span id="pid" style="padding-left:5px;">商品列表</span>
		                    </td>
		                    <td style="white-space:nowrap;">
		                    	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_product')">新增</a>
		                 		<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_product')">删除</a>
				                <span class="separator"></span>
				         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_product')">保存</a>
		                    </td>
		                </tr>
		            </tbody>
	            </table>
	        </div>
	        <div class="mini-fit">
	            <div id="grid_product" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
	        </div>
   		</div>
	</div>
</body>
</html>