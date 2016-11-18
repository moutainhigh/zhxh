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
    <script type="text/javascript" src="${pageContext.request.contextPath}/view/system/bank/bankbill.js"></script>
    <script type="text/javascript">
	    //mini.parse();
	    
	    $(function(){
	    	mini.parse();
	    	grid_bill_details = mini.get("grid_bill_details");
	    	grid_bill_details.set({
        		url:"${pageContext.request.contextPath}/userBank/rebateRewardBillDetails.htmls",
        		columns: [
	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
	                { field: "productname",name:"productname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "商品名称" },
	        	    { field: "detailsnum",name:"detailsnum", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "数量"},
	        	    { field: "detailspay",name:"detailspay", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "金额"},
	        	    { field: "createtime",name:"createtime",dateFormat:"yyyy-MM-dd HH:mm:ss", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "日期"},
	        	    { field: "ordernumber",name:"ordernumber", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "订单号"},
	        	    { field: "acompanyname",name:"acompanyname", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "机构名称"}
	        	    ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            //onselectionchanged:"onSelectionChanged",
	            showPager:true,
	            fitColumns:true,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	
	    })
	    
	  	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			grid_bill_details.load({ billid: data.billid });
		}
	  	
	  	//关闭窗体
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    
	</script>
    
</head>
<body>
    <div class="mini-fit">
        <div id="grid_bill_details" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
    </div>
	<div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:1;">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>