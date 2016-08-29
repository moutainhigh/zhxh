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
		var grid_plist;
		var grid_product_size;
		
       	$(function(){
       		mini.parse();
       		
			grid_brand = mini.get("grid_brand");
			grid_brand.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "brandlogo",name:"brandlogo", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌Logo",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onButtonEdit"} },
      	                { field: "brandname",name:"brandname", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "品牌名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "brandpath",name:"brandpath",type:"comboboxcolumn", autoEscape:true,width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌显示位置",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"PC端展示"},{"id":"2","text":"移动商城展示"}] } },
      	              	{ field: "isshow",name:"isshow",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } },
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
			
			grid_plist = mini.get("grid_plist");
			grid_plist.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	              	{ field: "action", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	              	{ field: "brandname",name:"brandname", width: 250, headerAlign: "center", align:"center",allowSort: false, header: "列表页名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
	            fitColumns:false,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
			grid_product_size = mini.get("grid_product_size");
			grid_product_size.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
    	                  { type: "checkcolumn",headerAlign:"center",width: 30},
    					  { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
    					  { field: "productpic",name:"productpic", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "商品主图片"},
    					  { field: "productname",name:"productname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
    					  { field: "showtype",name:"showtype",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "商品显示类型",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"富文本"},{"id":"2","text":"仅图片"}] } },
    					  { field: "productsize",name:"productsize", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "规格标准",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
    					  { field: "price",name:"price",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "售价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25 } },
    					  { field: "saleprice",name:"saleprice", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "特价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25  } },
    					  { field: "sizesort",name:"sizesort", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: {type: "textbox", minValue: 0, maxValue: 500, value: 25 } },
    					  { field: "productmemo",name:"productmemo", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品简介",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} },
    					  { field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } }
    				],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
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
            
            var s = "";
            
			if (grid.id == "grid_plist") {
                s = '  <a class="Edit_Button" href="javascript:getUrl(\'' + id + '\')" >获取地址</a>';
            }
            
            return s;
        }
       	
       	function getUrl(id) {
       		var serv_path = "${pageContext.request.contextPath}";
       		mini.alert(serv_path + "/pcMain/product.htmls?id=" + id);
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
   	        			e.cellStyle = "color:red;text-align:center";
                		e.cellHtml = '未设置图片';
       	        	}
   	        		else {
   	        			e.cellHtml = '<img src="${pageContext.request.contextPath}/' + value + '" height="30px" />';
   	        		}
    	        }
                if (field == "brandcolor") {
                	if (typeof(value) == "undefined" || value == "") {
                		e.cellStyle = "color:red;text-align:center";
                		e.cellHtml = '未设置颜色';
       	        	}
   	        		else {
   	        			e.cellHtml = '<span style="background-color:' + value + ';width:30px;height:30px;display:inline-block"></span>';
   	        		}
    	        }
                
                if (field == "isshow") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                	else {
                		e.cellStyle = "color:blue;text-align:center";
                	}
                }
            });
       		
       		/* grid_plist.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "pic") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
   	        		}
    	        }
         	}); */
       		
       		grid_product_size.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "productpic") {
   	        		if (typeof(value) == "undefined" || value == "") {
   	        			e.cellStyle = "color:red;text-align:center";
                		e.cellHtml = '未设置图片';
       	        	}
   	        		else {
   	        			e.cellHtml = '<img src="${pageContext.request.contextPath}/' + value + '" height="30px" />';
   	        		}
    	        }
                if (field == "isshow") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                	else {
                		e.cellStyle = "color:blue;text-align:center";
                	}
                }
            });
       		
       	}
       	
       	function onSelectionChanged(e) {
            var grid = e.sender;
	       	//处理对应
            var record = grid.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	if (grid.id == 'grid_brand') {
            		grid_plist.setData([]);
                	grid_plist.setTotalCount(0);
            		grid_product_size.setData([]);
            		grid_product_size.setTotalCount(0);
            	}
            	else if (grid.id == 'grid_plist') {
            		grid_product_size.setData([]);
            		grid_product_size.setTotalCount(0);
            	}
	      		return;
	      	}
            
            if (record) {
            	if (grid.id == 'grid_brand') {
            		grid_plist.load({listtype:'plist', parentid: record.id });
            		grid_product_size.setData([]);
            		grid_product_size.setTotalCount(0);
            	}
            	else if (grid.id == 'grid_plist') {
            		grid_product_size.load({listtype:'label_plist', parentid: record.id });
            	}
            }
        }
       	
		function addRow() {
			
			//获取品牌
       		var record = grid_brand.getSelected();
			
            if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	mini.alert("请先选择品牌，再添加品牌列表页内容.");
	      		return;
	      	}
			
			var newRow = {};
			newRow.parentid = record.id;
			newRow.brandname = "新建列表页";
			
			grid_plist.addRow(newRow, 0);
			grid_plist.beginEditCell(newRow, "brandname");
        }
		
		function delRow(grid_type) {
			
			var cf1 = "确定要删除选中的数据吗？";
			var tmpGrid;
			if (grid_type == "grid_plist") {
				tmpGrid = grid_plist;
			}
			else if (grid_type == 'grid_product_size'){
				tmpGrid = grid_product_size;
			}
        	var rows = tmpGrid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要删除的数据.");
       		 	return;
       	 	}
       	 	
       	 	mini.confirm("确定删除记录？", "确定？",
                 function (action) {
                     if (action == "ok") {
                    	 tmpGrid.removeRows(rows, false);
                     } else {
                         
                     }
                 }
             );
        }
       	
		function save(gridtype) {
			
			var url = "${pageContext.request.contextPath}/product/save.htmls";
			
			var tmpGrid;
			var pams = {};
			var savetype = "";
			if (gridtype == "grid_plist") {
				tmpGrid = grid_plist;
				pams.savetype = "plist";
				
			}
			else if (gridtype == "grid_product_size"){
				
				var record = grid_plist.getSelected();
		      	
	            if (typeof(record.id) == "undefined" || record.id == "") {
	            	mini.alert("请先选择列表页内容，再处理列表商品数据.");
		      		return;
		      	}

	            
				tmpGrid = grid_product_size;
				url = "${pageContext.request.contextPath}/public/save.htmls";
				pams.act = "label_plist";
				//pams.parentid = record.id;
				//pams.parenttype = "brandlist_pic"
			}
			
			tmpGrid.validate();
	        if (tmpGrid.isValid() == false) {
	            mini.alert("输入有误，请校验输入单元格内容","系统提示",
	            	function(action){
	            		//alert(action);
	            		var error = tmpGrid.getCellErrors()[0];
	            		tmpGrid.beginEditCell(error.record, error.column);
		            }
	            );
	            return;
	        }
	        
	        var objs = tmpGrid.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	mini.alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        
	        pams.objs = json;
	        tmpGrid.loading("保存中，请稍后......");
	        $.ajax({
	        	async:false,
	            url: url,
	            data: pams,
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	mini.alert("保存完毕。");
	            	tmpGrid.reload();
	            	grid_product_size.setData([]);
	            	grid_product_size.setTotalCount(0);
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                mini.alert(jqXHR.responseText);
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
		
		function sel_product_size(){
			
			var record = grid_plist.getSelected();
			
			if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	mini.alert("请先选择要选择商品的列表页.");
	      		return;
	      	}
         	 
			var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	         mini.open({
	        	 url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/selectProductSize",
	             title: "选择商品至商品列表", width: pWidth-200, height:pHeight-100,
	             allowResize:true,
	             showMaxButton:true,
	             onload: function () {
	            	 /* var iframe = this.getIFrameEl();
                	 	var data = {listid:record.id};
                     iframe.contentWindow.SetData(data); */
	             },
	             ondestroy: function (action) {
	            	 if (action == "ok") {
                         var iframe = this.getIFrameEl();
                         var rows = iframe.contentWindow.GetData();
                         
                         var ids = getSelectGridid(rows);
                         
                         grid_product_size.loading("保存中，请稍后......");
                         $.ajax({
                             url: "${pageContext.request.contextPath}/label/labelListSave.htmls",
                             data: {'objids':ids,'labelid':record.id,'tablename':'product_list'},
                             type: "post",
                             dataType:"text",
                             success: function (text) {
                            	 grid_product_size.reload();
                             },
                             error: function (jqXHR, textStatus, errorThrown) {
                                 alert(jqXHR.responseText);
                             }
                         });
                     }
	             }
	         });
		}
		
		function labelListDel() {
			
			var record = grid_plist.getSelected();
			
			if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	mini.alert("请先选择要移除商品的列表页.");
	      		return;
	      	}
			
			var rows = grid_product_size.getSelecteds();
         	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要删除的数据.");
       		 	return;
       	 	}
       	 	
       	 	var ids = getSelectGridid(rows);
       	 	
       	 	mini.confirm("确定删除记录？", "确定？",
                 function (action) {
                     if (action == "ok") {
                    	 grid_product_size.loading("保存中，请稍后......");
                    	 var url = "${pageContext.request.contextPath}/label/labelListDel.htmls";
						$.ajax({
							async:false,
						    url: url,
						    data: {'objids':ids,'labelid':record.id},
						    type: "post",
						    dataType:"text",
						    success: function (text) {
						    	grid_product_size.reload();
						    },
						    error: function (jqXHR, textStatus, errorThrown) {
						        mini.alert(jqXHR.responseText);
						    }
						});
                     } else {
                         
                     }
                 }
             );
       	 	
		}
		
		
</script>
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;">
		<div size="300" showCollapseButton="true">
			<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
		        <table style="width:100%;">
		            <tbody>
		             <tr>
		                 <td style="width:100%;">
		                 	<span id="pid" style="padding-left:5px;">品牌列表</span>
		                 </td>
		                 <td style="white-space:nowrap;">
		                 </td>
		             </tr>
		         	</tbody>
		        </table>
		    </div>
		    <div class="mini-fit">
		        <div id="grid_brand" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
		    </div>
		</div>
		<div showCollapseButton="false" >
			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
		   		<div size="50%" showCollapseButton="false" ><!-- style="border-width: 1;" -->
			    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
				        <table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">商品列表页内容</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow()">添加</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_plist')">删除</a>
					                <span class="separator"></span>
					         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_plist')">保存</a>
					         		<a class="mini-button" iconCls="icon-tip" plain="true" onclick="showRow('grid_brand')">查看系列页效果</a>
				                 </td>
				             </tr>
				         	</tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid_plist" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div> 
				    </div>
				</div>
				<div showCollapseButton="true">
		   			<div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
			    		 <table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">商品列表页显示的商品</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="sel_product_size()">添加</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="labelListDel()">移除</a>
				                 </td>
				             </tr>
				         	</tbody>
				        </table>
				    </div>
			        <div class="mini-fit" >
				         <div id="grid_product_size" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				    </div>
		   		</div>
			</div>
		</div>
		
	</div>
</body>
</html>