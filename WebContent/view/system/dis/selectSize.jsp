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
		
	    $(function(){
	    	mini.parse();
	    	grid_product_size = mini.get("grid_product_size");
	    	grid_product_size.set({
        		url:"${pageContext.request.contextPath}/userManager2/list_select_size.htmls",
        		columns: [
    	                  { type: "checkcolumn",headerAlign:"center",width: 30},
    					  { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
    					  { field: "productpic",name:"productpic", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "商品主图片(200*200)"},
    					  { field: "productname",name:"productname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
    					  { field: "productsize",name:"productsize", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "规格标准",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
    					  { field: "price",name:"price",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "单价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25 } },
    					  { field: "saleprice",name:"saleprice", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "特价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25  } },
    					  { field: "productmemo",name:"productmemo", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品简介",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} },
    					  { field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } },
    					  { field: "sizesort",name:"sizesort", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: {type: "textbox", minValue: 0, maxValue: 500, value: 25 } }
    				],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
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
                
                if (typeof(record.id) != "undefined" && record.id != "") {
                	if (field == "productpic") {
       	        		if (typeof(value) == "undefined" || value == "") {
                    		e.cellHtml = '<a href="javascript:;" onclick="open_upload_pic(\'grid_product_size\',\''+record.id+'\',\'pic\',\'productsize\')" >选择图片</a>';
           	        	}
       	        		else {
       	        			e.cellHtml = '<a href="javascript:;" onclick="open_upload_pic(\'grid_product_size\',\''+record.id+'\',\'pic\',\'productsize\')" ><img src="${pageContext.request.contextPath}/' + value + '" height="30px" /></a>';
       	        		}
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
	    
	  	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			data = mini.clone(data);    //必须
			var parentid = data.parentid;
			var userid = data.userid;
			var productid = data.productid;
			
			grid_product_size.load({ parentid: parentid,userid:userid ,productid:productid});
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
	    	//判断是否选择了数据
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
	
</head>
<body>
   <div class="mini-toolbar" style="text-align:center;line-height:30px;" borderStyle="border-bottom: 1;border-top: 0;border-left:0;border-right:0;">
          <label id="memo">选择商品规格</label>
    </div>
    <div class="mini-fit">
        <div id="grid_product_size" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
    </div>              
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border-bottom: 0;border-top: 1;border-left:0;border-right:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">选择</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>