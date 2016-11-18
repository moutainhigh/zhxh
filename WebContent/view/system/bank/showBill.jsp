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
	    	grid_bank = mini.get("grid_bank");
	    	grid_bank.set({
        		url:"${pageContext.request.contextPath}/userBank/showUserBank.htmls",
        		columns: [
  						{ type: "checkcolumn",headerAlign:"center",width: 30},
        	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
        	                { field: "bankname",name:"bankname", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "帐户名称" },
        	                { field: "bankpay",name:"bankpay", width: 100, headerAlign: "center", align:"right",allowSort: false, header: "金额",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
        	                { field: "action", width: 160, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onBankActionRenderer",cellStyle:"padding:0;"}
        	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            //onselectionchanged:"onSelectionChanged",
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
	    
	    //表格渲染
	    function onBankActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
           	var id = record.id;
           	var banktype = record.banktype;
        	var s = "";
        	if(identity == "A1"){
        		if(banktype == "incomebank"){	//收入总计
               		s = "<a class='Edit_Button' href=\"javascript:incomeBillDetail('','','1,2,3,4','')\" >收入流水</a>";
               	}else if(banktype == "costbank"){	//支出总计
               		s = "<a class='Edit_Button' href=\"javascript:spendingBillDetail('','','1,2,3,4')\" >支出流水</a>";
               	}else if(banktype == "takenbank"){	//可提现账户
               		s = "<a class='Edit_Button' href=\"javascript:spendingBillDetail('"+userid+"','"+parentid+"','1')\" >提现记录</a>";
               	}else if(banktype == "sellbank"){	//平台售额总计
               		s = "<a class='Edit_Button' href=\"javascript:shareBillDetail('"+userid+"','')\" >分润明细</a>";
               	}
        	}else if(identity == "A"){
        		if(banktype == "incomebank"){	//收入总计
               		s = "<a class='Edit_Button' href=\"javascript:incomeBillDetail('','"+userid+"','1,2','A')\" >充值记录</a> | ";
               		s += "<a class='Edit_Button' href=\"javascript:shareBillDetail('"+userid+"','1')\" >平台售额</a>";
               	}else if(banktype == "costbank"){	//支出总计
               		s = "<a class='Edit_Button' href=\"javascript:spendingBillDetail('','"+userid+"','1,2,3,4')\" >支出流水</a>";
               	}else if(banktype == "takenbank"){	//可提现账户
               		s = "<a class='Edit_Button' href=\"javascript:spendingBillDetail('"+userid+"','"+parentid+"','2')\" >提现记录</a>";
               	}else if(banktype == "havebank"){	//可支配账户
               		s = "<a class='Edit_Button' href=\"javascript:disposablebillDetail('"+userid+"','"+parentid+"')\" >交易流水</a>";
               	}else if(banktype == "sellbank"){	//平台售额总计
               		s = "<a class='Edit_Button' href=\"javascript:shareBillDetail('"+userid+"','')\" >分润明细</a>";
               	}else if(banktype == "quotabank"){	//配额总计
               		s = "<a class='Edit_Button' href=\"javascript:quotaBillDetail('"+userid+"','"+parentid+"')\" >配额明细</a>";
               	}else if(banktype == "depositbank"){//充值总计
               		s = "<a class='Edit_Button' href=\"javascript:incomeBillDetail('"+userid+"','"+parentid+"','1,2','A')\" >充值明细</a>";
               	}
        	}else if(identity == "C"){
        		if(banktype == "depositbank"){//充值总计
               		s = "<a class='Edit_Button' href=\"javascript:incomeBillDetail('"+userid+"','"+parentid+"','2','C')\" >充值明细</a>";
               	}else if(banktype == "quotabank"){	//配额总计
               		s = "<a class='Edit_Button' href=\"javascript:quotaBillDetail('"+userid+"','"+parentid+"')\" >配额明细</a>";
               	}else if(banktype == "sellbank"){	//平台售额总计
               		s = "<a class='Edit_Button' href=\"javascript:shareBillDetail('"+userid+"','')\" >分润明细</a>";
               	}else if(banktype == "selltakenbank"){	//可提现账户
               		s = "<a class='Edit_Button' href=\"javascript:spendingBillDetail('"+userid+"','"+parentid+"','3')\" >提现记录</a>";
               	}else if(banktype == "rebatesbank"){	//返利累计
               		s = "<a class='Edit_Button' href=\"javascript:disBillDetail('"+userid+"','"+parentid+"',1)\" >返利明细</a>";
               	}else if(banktype == "bonusesbank"){	//奖励累计
               		s = "<a class='Edit_Button' href=\"javascript:disBillDetail('"+userid+"','"+parentid+"',2)\" >奖励明细</a>";
               	}else if(banktype == "bonusestakenbank"){	//奖励可提现账户
               		s = "<a class='Edit_Button' href=\"javascript:spendingBillDetail('"+userid+"','"+parentid+"','4')\" >奖励明细</a>";
               	}
        	}
           
            return s;
        }
	    
	  	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			bankid = data.bankid;
			parentid = data.parentid;
			userid = data.userid;
			identity = data.identity;
			grid_bank.load({ bankid: bankid });
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