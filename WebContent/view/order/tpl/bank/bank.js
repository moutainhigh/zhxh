//

var pageIndex = 1;
var pageSize = 10;
var totalPage = 0;

/**
 * 收入-账单列表
 * */
function incomeBillDetail(uid,pid,trantype,identity){
	$("#_userid").val(uid);
	$("#_parentid").val(pid);
	$("#_trantype").val(trantype);
	$("#_identity").val(identity);
	
	initPage();
	loadData_incomeBillDetail();
}

//加载数据-收入-账单列表
function loadData_incomeBillDetail(){
	var _data = {};
	_data.parentid = $("#_parentid").val();
	_data.userid = $("#_userid").val();
	_data.trantype = $("#_trantype").val();
	_data.identity = $("#_identity").val();
	_data.pageIndex = pageIndex;
	_data.pageSize = pageSize;
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/incomeBillDetail.htmls",
        data: _data,
        type: "post",
        dataType:"json",
        success: function (json) {
        	totalPage = Math.ceil(json.total/pageSize);
        	$("#billDetail").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/incomeBillDetail.tpl");
        	$("#billDetail").setParam('rowCount', json.total);
     		$("#billDetail").setParam('pageSize', pageSize);
     		$("#billDetail").setParam('pageIndex', pageIndex);
     		$("#billDetail").setParam('totalPage', totalPage);
        	$("#billDetail").processTemplate(json.data);
        	//
        	pageSel(1);
            pageEnter(1);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
   });
}

/**
 * 支出-账单列表
 * */
function spendingBillDetail(uid,pid,trantype){
	$("#_userid").val(uid);
	$("#_parentid").val(pid);
	$("#_trantype").val(trantype);
	
	initPage();
	loadData_spendingBillDetail();
}

//加载数据-支出-账单列表
function loadData_spendingBillDetail(){
	var _data = {};
	_data.parentid = $("#_parentid").val();
	_data.userid = $("#_userid").val();
	_data.trantype = $("#_trantype").val();
	_data.pageIndex = pageIndex;
	_data.pageSize = pageSize;
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/spendingBillDetail.htmls",
        data: _data,
        type: "post",
        dataType:"json",
        success: function (json) {
        	totalPage = Math.ceil(json.total/pageSize);
        	$("#billDetail").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/spendingBillDetail.tpl");
        	$("#billDetail").setParam('rowCount', json.total);
     		$("#billDetail").setParam('pageSize', pageSize);
     		$("#billDetail").setParam('pageIndex', pageIndex);
     		$("#billDetail").setParam('totalPage', totalPage);
        	$("#billDetail").processTemplate(json.data);
        	//
        	pageSel(2);
            pageEnter(2);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
   });
}


/**
 * 配额-账单列表
 * */
function quotaBillDetail(uid,pid){
	$("#_userid").val(uid);
	$("#_parentid").val(pid);
	
	initPage();
	loadData_quotaBillDetail();
}

//加载数据-配额-账单列表
function loadData_quotaBillDetail(){
	var _data = {};
	_data.parentid = $("#_parentid").val();
	_data.userid = $("#_userid").val();
	_data.pageIndex = pageIndex;
	_data.pageSize = pageSize;
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/quotaBillDetail.htmls",
        data: _data,
        type: "post",
        dataType:"json",
        success: function (json) {
        	totalPage = Math.ceil(json.total/pageSize);
        	$("#billDetail").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/quotaBillDetail.tpl");
        	$("#billDetail").setParam('rowCount', json.total);
     		$("#billDetail").setParam('pageSize', pageSize);
     		$("#billDetail").setParam('pageIndex', pageIndex);
     		$("#billDetail").setParam('totalPage', totalPage);
        	$("#billDetail").processTemplate(json.data);
        	//
        	pageSel(3);
            pageEnter(3);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
   });
}

/**
 * 返利、奖励-账单列表
 * */
function disBillDetail(uid,pid,type){
	$("#_userid").val(uid);
	$("#_parentid").val(pid);
	$("#_detailstype").val(type);
	initPage();
	loadData_disBillDetail();
}

//加载数据-返利、奖励-账单列表
function loadData_disBillDetail(){
	var _data = {};
	_data.parentid = $("#_parentid").val();
	_data.userid = $("#_userid").val();
	_data.detailstype = $("#_detailstype").val();
	_data.pageIndex = pageIndex;
	_data.pageSize = pageSize;
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/rebateRewardBill.htmls",
        data: _data,
        type: "post",
        dataType:"json",
        success: function (json) {
        	totalPage = Math.ceil(json.total/pageSize);
        	$("#billDetail").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/publicDisDetail.tpl");
        	$("#billDetail").setParam('rowCount', json.total);
     		$("#billDetail").setParam('pageSize', pageSize);
     		$("#billDetail").setParam('pageIndex', pageIndex);
     		$("#billDetail").setParam('totalPage', totalPage);
        	$("#billDetail").processTemplate(json.data);
        	//
        	pageSel(4);
            pageEnter(4);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
   });
}

/**
 * 平台售额-账单列表
 * */
function shareBillDetail(uid){
	$("#_userid").val(uid);
	
	initPage();
	loadData_shareBillDetail();
}

//加载数据-平台售额-账单列表
function loadData_shareBillDetail(){
	var _data = {};
	_data.userid = $("#_userid").val();
	_data.pageIndex = pageIndex;
	_data.pageSize = pageSize;
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/shareBill.htmls",
        data: _data,
        type: "post",
        dataType:"json",
        success: function (json) {
        	totalPage = Math.ceil(json.total/pageSize);
        	$("#billDetail").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/shareBillDetail.tpl");
        	$("#billDetail").setParam('rowCount', json.total);
     		$("#billDetail").setParam('pageSize', pageSize);
     		$("#billDetail").setParam('pageIndex', pageIndex);
     		$("#billDetail").setParam('totalPage', totalPage);
     		$("#billDetail").setParam('userid', _data.userid);
        	$("#billDetail").processTemplate(json.data);
        	//
        	pageSel(5);
            pageEnter(5);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
   });
}
//平台售额-详细
function shareDetails(uid,ids){
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/shareBillDetails.htmls",
        data: {'orderproductids':ids},
        type: "post",
        dataType:"json",
        success: function (json) {
        	var data = json.data;
        	var mDataArr = [];
        	for (i=0;i<data.length;i++) {
        		var m = data[i];
        		var mData = {};
        		mData.brandname = m.brandname;
        		mData.productname = m.productname;
        		mData.productsize = m.productsize;
        		mData.price = m.price;
        		mData.productnum = m.productnum;
        		var skey = "";
        		var ms = JSON.parse(m.sharekey);
        		for(var key	 in ms){
        			for(var k in ms[key]){
        				if(uid == "1"){ //平台查看所有机构分润情况
        					skey += "["+ms[key][k].companyname+":"+ms[key][k].sharepay+"]";
        				}else{
        					if(uid == ms[key][k].userid){
            					skey += ms[key][k].sharepay;
            					break;
            				}	
        				}
            		}
        		}
        		mData.skey = skey;
        		mDataArr.push(mData);
        	}
        	
        	$("#share_details").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/shareBillDetails.tpl");
        	$("#share_details").processTemplate(mDataArr);
        	//alert(json.data[0].sharekey);
        	layer.open({
      		  type: 1,
      		  area: ['680px', ''],
      		  shade: false,
      		  title: false, //不显示标题
      		  content: $('#details'), //捕获的元素
      		  cancel: function(index){
      			  layer.closeAll();
      		    //layer.close(index);
      		    //this.content.show();
      		  }
      		});
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
   });
}

/**
 * 收入/支出详细
 * */
function details(id){
	layer.open({
	  type: 1,
	  area: ['680px', ''],
	  shade: false,
	  title: false, //不显示标题
	  content: $('#'+id), //捕获的元素
	  cancel: function(index){
		  layer.closeAll();
	    //layer.close(index);
	    //this.content.show();
	    //layer.msg('捕获就是从页面已经存在的元素上，包裹layer的结构', {time: 5000, icon:6});
	  }
	});
}

/**
 * 分页参数初始化
 * */
function initPage(){
	pageIndex = 1;
	pageSize = 10;
	totalPage = 0;
}

/**
 * 分页 - 翻页(上一页、下一页)
 * */
function pageClick(sel_page,type) {
	pageIndex = sel_page;
	page_loadData(type);
}

/**
 * 输入页码 - 跳转
 * */
function pageEnter(type) {
	$('.ui-pager-inp').bind('keypress',function(event) {
        if(event.keyCode == "13") {
        	if (isInteger($(this).val())) {
        		if ($(this).val() > totalPage || $(this).val() < 1 || $(this).val() == pageIndex) {
        			return false;
        		}
        		else {
        			pageIndex = $(this).val();
        			page_loadData(type);
        		}
        	}
        	else {
        	}
            return false;
        }
    });
}

/**
 * 切换每页显示条数
 * */
function pageSel(type) {
	$('.pageSel').change(function(){ 
		var p1=$(this).children('option:selected').val();//这就是selected的值
		pageIndex = 1;
		pageSize = p1;
		page_loadData(type);
	}) 
}

/**
 * 分页切换-加载数据
 * type:1收入，2支出，3配额，4返利/奖励
 * */
function page_loadData(type){
	if(type == 1){
		loadData_incomeBillDetail();	//收入-账单列表
	}else if(type == 2){
		loadData_spendingBillDetail();	//支出-账单列表
	}else if(type == 3){
		loadData_quotaBillDetail();		//配额-账单列表
	}else if(type == 4){
		loadData_disBillDetail();		//返利、奖励-账单列表
	}else if(type == 5){
		loadData_shareBillDetail();		//平台售额
	}
}

//获取利益标准
function getDisConfig(){
		var disConfig;
    $.ajax({
		async:false,
        url: getRootPath_web() + "/orderUser/disConfig.htmls",
        //data: par,
        type: "post",
        dataType:"json",
        success: function (json) {
        	disConfig = json;
        },
        error: function (jqXHR, textStatus, errorThrown) {
        	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
        }
   	});
	return disConfig;
}