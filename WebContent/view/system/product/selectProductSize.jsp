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
	    
	    var grid_brand;
		var grid_product;
		var grid_product_size;
		
	    $(function(){
	    	mini.parse();
	    	grid_brand = mini.get("grid_brand");
			grid_brand.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
  						{ type: "checkcolumn",headerAlign:"center",width: 30},
        	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
        	                { field: "brandlogo",name:"brandlogo", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "品牌Logo" },
        	                { field: "brandname",name:"brandname", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "品牌名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
        	                { field: "brandpath",name:"brandpath",type:"comboboxcolumn", autoEscape:true,width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌显示位置",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"PC端展示"},{"id":"2","text":"移动商城展示"}] } },
        	                { field: "isshow",name:"isshow",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } },
        	                { field: "brandcolor",name:"brandcolor", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "品牌颜色",vtype:"required" },
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
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			grid_brand.load({ listtype: 'brand' });
        	
			grid_product = mini.get("grid_product");
			grid_product.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "productname",name:"productname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "createdate",name:"update",dateFormat:"yyyy-MM-dd", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "创建日期",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "sort",name:"sort", width: 30, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelProductChanged",
	            //fitColumns:false,
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
					  { field: "price",name:"price",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "单价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25 } },
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
	            //onselectionchanged:"onSelectionChanged",
	            allowUnselect:false,
	            showPager:true,
	            showPageSize:false,
	            pageSize:1000
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
       		
	    	grid_product.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "isshow") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                	else {
                		e.cellStyle = "color:blue;text-align:center";
                	}
                }
            });
	    	
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
	    
	    function onSelProductChanged(e) {
            var grid = e.sender;
	       	//处理角色对应的帐户
            var record = grid.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	grid_product_size.setData([]);
            	grid_product_size.setTotalCount(0);
	      		return;
	      	}
            
            if (record) {
            	grid_product_size.load({ listtype:'productsize',parentid: record.id });
            }
        }
	    
	  	//标准方法接口定义
		/* function SetData(data) {
			//跨页面传递的数据
			id = data.id;
			saveFolder = data.saveFolder;
			forObj = data.forObj;
			
			$("#id").val(id);
			$("#saveFolder").val(saveFolder);
			$("#forObj").val(forObj);
			
		} */
	    
	    function GetData() {
			var rows = grid_product_size.getSelecteds();
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
	
	<!-- <style type="text/css">
		#img{width:220px;height:120px;display:block; border:1px solid #d3d3d3;}
	</style> -->
    
</head>
<body>
    <div class="mini-fit">
    	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
	   		<div size="50%" showCollapseButton="false" style="border-width: 1;">
	   			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
	   				<div size="50%" showCollapseButton="false" style="border-width: 1;">
				    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
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
						<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				            <table style="width:100%;">
				                <tbody>
					                <tr>
					                    <td style="width:100%;">
					                    	<span id="pid" style="padding-left:5px;">商品列表</span>
					                    </td>
					                    <td style="white-space:nowrap;">
					                    	<!-- <a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_product')">新增</a>
					                 		<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_product')">删除</a>
							                <span class="separator"></span>
							         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_product')">保存</a> -->
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
			</div>
			<div showCollapseButton="true">
	   			<div class="mini-toolbar" borderStyle="border:0;">
			        <table style="width:100%;">
			            <tbody>
			             <tr>
			                 <td style="width:100%;">
			                 	<span id="pid" style="padding-left:5px;">商品规格</span>
			                 </td>
			                 <td style="white-space:nowrap;">
			                  	<!-- <a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_product_size')">新增</a>
			                	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_product_size')">删除</a>
				                <span class="separator"></span>
				         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_product_size')">保存</a> -->
			                 </td>
			             </tr>
			         </tbody>
			        </table>
			    </div>
			    <div class="mini-fit"><!-- border-bottom: 1;border-top: 0;border-left:0;broder-right:0" -->
			        <div id="grid_product_size" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border-bottom: 1;border-top: 1;border-left:0;border-right:0;"></div>
			    </div>
	   		</div>
		</div>
    </div>                
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">选择</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>