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
		
	    $(function(){
	    	mini.parse();
	    	grid = mini.get("grid");
			grid.set({
        		url:"${pageContext.request.contextPath}/userManager2/listSelectUserC.htmls",
        		columns: [
  						{ type: "checkcolumn",headerAlign:"center",width: 30},
        	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
        	                { field: "username",name:"username", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "真实姓名",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
        	                { field: "phonenumber",name:"phonenumber", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "手机号码",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
        	              	{ field: "birthday",name:"birthday",dateFormat:"yyyy-MM-dd",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "性别",vtype:"required",editor:{ type: "datepicker"} },
        	              	{ field: "sex",name:"sex",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "性别",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"女"},{"id":"1","text":"男"}] } },
        	              	{ field: "identitymemo",name:"identitymemo",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "身份" },
        	                { field: "companyname",name:"companyname",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构名称" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
        	                { field: "companypath",name:"companypath",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构地址" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
        	                { field: "companycode",name:"companycode",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构代码" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
        	                { field: "wechar",name:"wechar",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "微信号码" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
        	                { field: "rank",name:"rank",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构级别" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
        	                { field: "isopen",name:"isopen",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁用"},{"id":"1","text":"正常"}] } }
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
			
        	//drawcell();
	    })
	    
	    function drawcell() {
	    	grid.on("drawcell", function (e) {
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
			
			grid.load({ parentid: parentid});
		}
	    
	    function GetData() {
			var rows = grid.getSelecteds();
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
        <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
    </div>              
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border-bottom: 0;border-top: 1;border-left:0;border-right:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">选择</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>