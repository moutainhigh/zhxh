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
	    
	    var grid;
		
	    $(function(){
	    	mini.parse();
	    	grid = mini.get("grid");
	    	grid.set({
        		columns: [
  						{ type: "checkcolumn",headerAlign:"center",width: 30},
       	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
       	                { field: "updatetxt",name:"updatetxt", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "批量更新项" },
       	                { field: "updatevalue",name:"updatevalue", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "批量更新内容",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
       	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
	    	var data = [];
	    	var row = {};
	    	row.id = "buyerdis";
	    	row.updatetxt = "采购折扣";
	    	row.updatevalue = 0;
	    	data.push(row);
	    	
	    	var row1 = {};
	    	row1.id = "rebatesdis";
	    	row1.updatetxt = "返利标准";
	    	row1.updatevalue = 0;
	    	data.push(row1);
	    	var row2 = {};
	    	row2.id = "bonusesdis";
	    	row2.updatetxt = "奖励标准";
	    	row2.updatevalue = 0;
	    	data.push(row2);
	    	
	    	grid.setData(data);
    		grid.setTotalCount(data.length);
	    })
	    
	  	//标准方法接口定义
		function SetData(data) {
			/* //跨页面传递的数据
			data = mini.clone(data);    //必须
			var parentid = data.parentid;
			var userid = data.userid;
			
			grid_brand.load({ parentid: parentid,userid:userid }); */
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
	    	grid.validate();
	        if (grid.isValid() == false) {
	        	parent.parent.layer.msg('输入有误，请校验输入单元格内容', {
	        		  icon: 5,
	        		  time: 2000 //2秒关闭（如果不配置，默认是3秒）
	        		}, function(){
	        			var error = tmpGrid.getCellErrors()[0];
	            		tmpGrid.beginEditCell(error.record, error.column);
	        		}
	        	);
	            return;
	        }
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
        <a class="mini-button" style="width:60px;" onclick="onOk()">更改</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>