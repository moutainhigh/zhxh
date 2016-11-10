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
	    
	    var grid_bank;
	    
	    
	    var parentid = "";
	    var userid = "";
	    var bankid = "";
	    
		var grid_bill;
		
		var columns_income=[
						{ type: "checkcolumn",headerAlign:"center",width: 30},
						{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
						{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
						{ field: "billno",name:"billno", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "账单流水号",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "createtime",name:"createtime",dateFormat:"yyyy-MM-dd HH:mm:ss", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "日期",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "u_username",name:"u_username", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "客户名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "trantypetxt",name:"trantypetxt", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "摘要",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "account_receivable",name:"account_receivable", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "金额(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
	     	    ];
		var columns_spending=[
						{ type: "checkcolumn",headerAlign:"center",width: 30},
						{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
						{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
						{ field: "billno",name:"billno", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "账单流水号",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "createtime",name:"createtime",dateFormat:"yyyy-MM-dd HH:mm:ss", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "日期",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "u_username",name:"u_username", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "客户名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "trantypetxt",name:"trantypetxt", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "摘要",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "amount",name:"amount", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "金额(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
		              { field: "status",name:"status", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"-1","text":"失败"},{"id":"0","text":"未接收"},{"id":"1","text":"成功"}] }}
	     	    ];
		
	    $(function(){
	    	mini.parse();
	    	grid_bank = mini.get("grid_bank");
	    	grid_bank.set({
        		url:"${pageContext.request.contextPath}/userBank/showUserBank.htmls",
        		columns: [
  						{ type: "checkcolumn",headerAlign:"center",width: 30},
        	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
        	                { field: "bankname",name:"bankname", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "帐户名称" },
        	                { field: "bankpay",name:"bankpay", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "金额",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
        	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            onselectionchanged:"onSelectionChanged",
	            showPager:true,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	
	    	grid_bill = mini.get("grid_bill");
	    	grid_bill.set({
        		//url:"${pageContext.request.contextPath}/userBank/incomeBillDetail.htmls",
        		columns: [
							{ type: "checkcolumn",headerAlign:"center",width: 30},
	      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	      	                { field: "u_companyname",name:"u_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "交易流水",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
	      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            //onselectionchanged:"onSelProductChanged",
	            //fitColumns:false,
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
       		
	    	grid_bill.on("drawcell", function (e) {
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
        }
	    
	    function getBill(banktype,parentid,userid) {
	    	var url = "";
	    	if (banktype == 'incomebank' || banktype == "depositbank") {
	    		url = "${pageContext.request.contextPath}/userBank/incomeBillDetail.htmls";
	    		grid_bill.set({
		    		url:url,
		    		columns: columns_income
		    	})
	    	}
	    	else if (banktype == "costbank") {
	    		url = "${pageContext.request.contextPath}/userBank/spendingBillDetail.htmls";
	    		grid_bill.set({
		    		url:url,
		    		columns: columns_spending
		    	})
	    	}
	    	
	    	grid_bill.load({parentid:parentid, userid: userid });
	    }
	    
	    function onSelectionChanged(e) {
            var grid = e.sender;
	       	//处理角色对应的帐户
            var record = grid.getSelected();
	      	
            if (record) {
            	getBill(record.banktype,parentid,userid);
            }
        }
	    
	    function onselectionchanged(e) {
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
		function SetData(data) {
			//跨页面传递的数据
			bankid = data.bankid;
			parentid = data.parentid;
			userid = data.userid;
			grid_bank.load({ bankid: bankid });
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
    
</head>
<body>
	<div class="mini-fit">
	 	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
	 		<div size="30%" showCollapseButton="false" style="border-width: 1;">
		    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
			        <table style="width:100%;">
			            <tbody>
			             <tr>
			                 <td style="width:100%;">
			                 	<span id="pid" style="padding-left:5px;">资金帐户列表</span>
			                 </td>
			             </tr>
			         </tbody>
			        </table>
			    </div>
			    <div class="mini-fit">
			        <div id="grid_bank" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
			    </div>
			</div>
			<div showCollapseButton="true">
				<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
		            <table style="width:100%;">
		                <tbody>
			                <tr>
			                    <td style="width:100%;">
			                    	<span id="pid" style="padding-left:5px;">交易流水列表</span>
			                    </td>
			                </tr>
			            </tbody>
		            </table>
		        </div>
		        <div class="mini-fit">
		            <div id="grid_bill" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
		        </div>
			</div>
		</div>
	</div>
	<div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:1;">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>