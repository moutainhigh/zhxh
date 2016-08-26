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
	            //onselectionchanged:"onSelectionChanged",
	            onload:"onload",
	            allowUnselect:false,
	            showPager:true,
	            showPageSize:false,
	            pageSize:10000
	        });
			grid_product_size.load({ listtype:'productsizeall',parentid: "" });
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
        }
	    
	    function onload() {
	    	if (linkids != "") {
				var idArr = linkids.split(",");
				
				for(var i=0;i<idArr.length;i++) {
					var row = grid_product_size.findRow(function(row){
		    		    if(row.id == idArr[i]) return true;
		    		});
					if (row != null && row.id != "") {
						grid_product_size.select(row);
					}
				}
			}
	    }
	    
	  	//标准方法接口定义
		function SetData(data) {
			data = mini.clone(data);    //必须
			//跨页面传递的数据
			id = data.id;
			linkids = data.linkids;
			
			/* var rows = grid_product_size.findRow(function(row){
    		    if(row.noteid == grid_data[i].id) return true;
    		}); */
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
	
	<!-- <style type="text/css">
		#img{width:220px;height:120px;display:block; border:1px solid #d3d3d3;}
	</style> -->
    
</head>
<body>
	<div class="mini-toolbar" style="text-align:center;line-height:30px;" borderStyle="border-bottom:1;border-top: 0;border-left:0;border-right:0;">
          <label id="memo">请选择商品详细页推荐的同类商品（选择的商品会显示在商品详细页内的推荐商品滚动中。请选择2-4个。）</label>
    </div>
    <div class="mini-fit">
    	<div class="mini-toolbar" borderStyle="border:0;">
	        <table style="width:100%;">
	            <tbody>
	             <tr>
	                 <td style="width:100%;">
	                 	<span id="pid" style="padding-left:5px;">商品规格</span>
	                 </td>
	                 <td style="white-space:nowrap;">
	                 </td>
	             </tr>
	         </tbody>
	        </table>
	    </div>
	    <div class="mini-fit"><!-- border-bottom: 1;border-top: 0;border-left:0;broder-right:0" -->
	        <div id="grid_product_size" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border-bottom: 1;border-top: 1;border-left:0;border-right:0;"></div>
	    </div>
    </div>                
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">选择</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>