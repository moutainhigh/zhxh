
var grid_bank;		//资金账户
var parentid = "";
var userid = "";
var bankid = "";
var identity = "";	//身份
var grid_bill;		//资金账户流水

//收入/充值
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
//支出/提现
var columns_spending=[
	{ type: "checkcolumn",headerAlign:"center",width: 30},
	{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
	{ field: "billno",name:"billno", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "账单流水号"},
    { field: "createtime",name:"createtime",dateFormat:"yyyy-MM-dd HH:mm:ss", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "日期"},
    { field: "u_username",name:"u_username", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "客户名称"},
    { field: "trantypetxt",name:"trantypetxt", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "摘要"},
    { field: "amount",name:"amount", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "金额(元)"},
    { field: "status",name:"status",type:"comboboxcolumn", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"-1","text":"失败"},{"id":"0","text":"未接收"},{"id":"1","text":"成功"}] }}
    ];
//平台售额
var columns_share=[
	{ type: "checkcolumn",headerAlign:"center",width: 30},
	{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onRebateRewardActionRenderer",cellStyle:"padding:0;"},
	{ field: "ordernumber",name:"ordernumber", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "订单号"},
	{ field: "submitname",name:"submitname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "下单机构"},
	{ field: "sharepay",name:"sharepay", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "分润金额"},
	{ field: "sharenumber",name:"sharenumber", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "分润数量"},
	{ field: "sharetime",name:"sharetime",dateFormat:"yyyy-MM-dd HH:mm:ss", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "日期"},
	{ field: "sharestate",name:"sharestate",type:"comboboxcolumn", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"等待分润"},{"id":"1","text":"分润完成"}] }}
	];
//可支配账户
var columns_disposable=[
   	{ type: "checkcolumn",headerAlign:"center",width: 30},
   	{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
   	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
   	{ field: "billno",name:"billno", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "账单流水号"},
   	{ field: "orderno",name:"orderno", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "订单号"},
   	{ field: "amount",name:"amount", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "金额"},
   	{ field: "trantype_txt",name:"trantype_txt", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "交易类型"},
   	{ field: "createtime",name:"createtime",dateFormat:"yyyy-MM-dd HH:mm:ss", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "交易时间"}
   	];
//配额
var columns_quota=[
   	{ type: "checkcolumn",headerAlign:"center",width: 30},
   	{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
   	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
   	{ field: "billno",name:"billno", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "账单流水号"},
   	{ field: "p_company",name:"p_company", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "机构名称"},
   	{ field: "amount",name:"amount", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "金额"},
   	{ field: "createtime",name:"createtime",dateFormat:"yyyy-MM-dd HH:mm:ss", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "时间"}
   	];
//返利、奖励
var columns_rebateRewar=[
   	{ type: "checkcolumn",headerAlign:"center",width: 30},
   	{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
   	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
   	{ field: "billno",name:"billno", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "账单流水号"},
   	{ field: "order_no",name:"order_no", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "订单号"},
   	{ field: "amount",name:"amount", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "金额"},
   	{ field: "createtime",name:"createtime",dateFormat:"yyyy-MM-dd HH:mm:ss", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "时间"}
   	];

/**
 * 收入-账单列表
 * */
function incomeBillDetail(uid,pid,trantype,identity){
	url = getRootPath_web() + "/userBank/incomeBillDetail.htmls";
	grid_bill.set({
		url:url,
		columns: columns_income
	});
	grid_bill.load({parentid:pid,userid:uid,trantype:trantype,identity:identity});
}

/**
 * 支出-账单列表
 * */
function spendingBillDetail(uid,pid,trantype){
	url = getRootPath_web() + "/userBank/spendingBillDetail.htmls";
	grid_bill.set({
		url:url,
		columns: columns_spending
	});
	grid_bill.load({parentid:pid,userid:uid,trantype:trantype});
}

/**
 * 格式化金额
 * */
function formatAmount(e){
	return formatFloat(e);
}

/**
 * 配额-账单列表
 * */
function quotaBillDetail(uid,pid){
	url = getRootPath_web() + "/userBank/quotaBillDetail.htmls";
	grid_bill.set({
		url:url,
		columns: columns_quota
	});
	grid_bill.load({userid:uid,parentid:pid});
}

/**
 * 平台售额-账单列表
 * */
function shareBillDetail(uid,status){
	url = getRootPath_web() + "/userBank/shareBill.htmls";
	grid_bill.set({
		url:url,
		columns: columns_share
	});
	grid_bill.load({userid:uid,status:status});
}

/**
 * 返利、奖励-账单列表
 * */
function disBillDetail(uid,pid,type){
	url = getRootPath_web() + "/userBank/rebateRewardBill.htmls";
	grid_bill.set({
		url:url,
		columns: columns_rebateRewar
	});
	grid_bill.load({userid:uid,parentid:pid,detailstype:type});
}

/**
 * 奖励转货款-账单列表
 * */
function transfBillDetail(uid){
	transfBill
}

/**
 * 可支配账户变更-账单列表
 * */
function disposablebillDetail(uid,pid){
	url = getRootPath_web() + "/userBank/disposableBill.htmls";
	grid_bill.set({
		url:url,
		columns: columns_disposable
	});
	grid_bill.load({userid:uid,parentid:pid});
}

/*-----------------资金账户流水-明细----------------------*/

/**
 * 返利、奖励-账单列表-详细
 * */
function onRebateRewardActionRenderer(e){
	 var grid = e.sender;
     var record = e.record;
     var userid = record.userid;
     var orderproductids = record.orderproductids;
     var s = "";
     s = "<a class='Edit_Button' href=\"javascript:rebateRewardBillDetails('"+userid+"','"+orderproductids+"')\" >详情</a>";
     return s;
}
function rebateRewardBillDetails(uid,orderproductids){
	mini.open({
        url: getRootPath_web() + "/common/dispatch.htmls?page=/view/system/bank/showBillDetails",
        title: "资金明细", width:500, height:300,
        allowResize:true,
        onload: function () {
        	var iframe = this.getIFrameEl();
        	var data = {userid:uid,pros:orderproductids};
        	iframe.contentWindow.SetData(data);
        },
        ondestroy: function (action) {
        	if (action == "ok") {
        		
            }
        }
    });
}
