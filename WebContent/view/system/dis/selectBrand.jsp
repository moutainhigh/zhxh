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
		
	    $(function(){
	    	mini.parse();
	    	grid_brand = mini.get("grid_brand");
			grid_brand.set({
        		url:"${pageContext.request.contextPath}/userManager2/list_select_brand.htmls",
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
        }
	    
	  	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			data = mini.clone(data);    //必须
			var parentid = data.parentid;
			var userid = data.userid;
			
			grid_brand.load({ parentid: parentid,userid:userid });
		}
	    
	    function GetData() {
			var rows = grid_brand.getSelecteds();
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
          <label id="memo">选择品牌</label>
    </div>
    <div class="mini-fit">
        <div id="grid_brand" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
    </div>              
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border-bottom: 0;border-top: 1;border-left:0;border-right:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">选择</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>