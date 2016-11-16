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
	    
		var grid_product_size;
		var grid_product_size_link;
		var id = "";
		var linkids = "";
		
	    $(function(){
	    	mini.parse();
			
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
	            onload:"onload",
	            allowUnselect:false,
	            showPager:true,
	            showPageSize:false,
	            pageSize:10000
	        });
			grid_product_size.load({ listtype:'productsizeall',parentid: "" });
			
			grid_product_size_link = mini.get("grid_product_size_link");
			grid_product_size_link.set({
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
	            allowUnselect:false,
	            showPager:true,
	            showPageSize:false,
	            pageSize:10000
	        });
			
        	drawcell();
	    })
	    
	    function drawcell() {
	    	
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
	    	
	    	grid_product_size_link.on("drawcell", function (e) {
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
	    
	    function onload() {
	    	if (linkids != "") {
				var idArr = linkids.split(",");
				var sel_data = [];
				for(var i=0;i<idArr.length;i++) {
					var row = grid_product_size.findRow(function(row){
		    		    if(row.id == idArr[i]) return true;
		    		});
					if (row != null && row.id != "") {
						sel_data.push(row);
					}
				}
				
				if (sel_data.length > 0) {
					grid_product_size_link.setData(sel_data);
					grid_product_size.removeRows(sel_data,false);
				}
			}
	    }
	    
	    function addRow() {
	    	var rows = grid_product_size.getSelecteds();
	    	
	    	if (rows.length == 0) {
	    		mini.alert("请选择要加入到推荐的商品。");
	    		return;
	    	}
	    	grid_product_size.removeRows(rows);
	    	grid_product_size_link.addRows(rows);
	    }
	    
	    function removeRow() {
			var rows = grid_product_size_link.getSelecteds();
	    	
	    	if (rows.length == 0) {
	    		mini.alert("请选择要移除的推荐商品。");
	    		return;
	    	}
	    	grid_product_size_link.removeRows(rows);
	    	grid_product_size.addRows(rows);
	    }
	    
	    function saveLinksids() {
	    	
	    	var rows = grid_product_size_link.getData();
	    	var ids = "";
            
            if (rows.length > 0) {
            	ids = getSelectGridid(rows);
            }
            //提交到服务器
            $.ajax({
	        	async:false,
	            url: "${pageContext.request.contextPath}/product/saveSizeLinkids.htmls",
	            data: {'id':id,'linkids':ids},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	parent.parent.layer.msg("保存完毕。",{icon:6});
	            	//onOk();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	            	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
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
	    
	  	//标准方法接口定义
		function SetData(data) {
			data = mini.clone(data);    //必须
			//跨页面传递的数据
			id = data.id;
			linkids = data.linkids;
			
		}
	    
	    function GetData() {
			var rows = grid_product_size.getSelecteds();
	        return rows;
	    }
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	    	CloseWindow("ok");
	    	/* var rows = GetData();
	    	if (rows.length == 0) {
	    		CloseWindow("cancel");
	    	}
	    	else {
	    		CloseWindow("ok");
	    	} */
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	</script>
    
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
   		<div size="50%" showCollapseButton="false" style="border-width: 1;">
		    <div class="mini-fit">
		    	<div class="mini-toolbar" borderStyle="border:0;">
			        <table style="width:100%;">
		                <tbody>
			                <tr>
			                    <td style="width:100%;">
			                    	<span id="pid" style="padding-left:5px;">选择的商品会显示在商品详细页内的推荐商品滚动中。建议选择2-4个。</span>
			                    </td>
			                    <td style="white-space:nowrap;">
			                    	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow()">加入</a>
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
		<div showCollapseButton="true">
			<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
	            <table style="width:100%;">
	                <tbody>
		                <tr>
		                    <td style="width:100%;">
		                    	<span id="pid" style="padding-left:5px;">详细页推荐商品列表(注：状态为【下架】的商品，即使选择，也不会显示)</span>
		                    </td>
		                    <td style="white-space:nowrap;">
		                 		<a class="mini-button" iconCls="icon-remove" plain="true" onclick="removeRow()">移除</a>
				                <span class="separator"></span>
				         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="saveLinksids()">保存</a>
		                    </td>
		                </tr>
		            </tbody>
	            </table>
	        </div>
	        <div class="mini-fit">
	            <div id="grid_product_size_link" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
	        </div>
		</div>
	</div>    
</body>
</html>