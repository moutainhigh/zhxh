//

var pageIndex = 1;
var pageSize = 10;
var totalPage = 0;

function accountDetail(uid,pid,trantype){
	$("#_userid").val(uid);
	$("#_parentid").val(pid);
	$("#_trantype").val(trantype);
	loadData_accountdetail();
}

//加载数据-账户资金明细列表
function loadData_accountdetail(){
	var _data = {};
	_data.parentid = $("#_parentid").val();
	_data.userid = $("#_userid").val();
	_data.trantype = $("#_trantype").val();
	_data.pageIndex = pageIndex;
	_data.pageSize = pageSize;
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/accountDetail.htmls",
        data: _data,
        type: "post",
        dataType:"json",
        success: function (json) {
        	totalPage = Math.ceil(json.total/pageSize);
        	$("#accountdetail").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/accountDetail.tpl");
        	$("#accountdetail").setParam('rowCount', json.total);
     		$("#accountdetail").setParam('pageSize', pageSize);
     		$("#accountdetail").setParam('pageIndex', pageIndex);
     		$("#accountdetail").setParam('totalPage', totalPage);
        	$("#accountdetail").processTemplate(json.data);
        	//
        	pageSel();
            pageEnter();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText);
        }
   });
}

/**
 * 分页 - 翻页(上一页、下一页)
 * */
function pageClick(sel_page) {
	pageIndex = sel_page;
	loadData_accountdetail();	//加载数据-订单列表
}

/**
 * 输入页码 - 跳转
 * */
function pageEnter() {
	$('.ui-pager-inp').bind('keypress',function(event) {
        if(event.keyCode == "13") {
        	if (isInteger($(this).val())) {
        		if ($(this).val() > totalPage || $(this).val() < 1 || $(this).val() == pageIndex) {
        			return false;
        		}
        		else {
        			pageIndex = $(this).val();
            		loadData_accountdetail();	//加载数据-订单列表
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
function pageSel() {
	$('.pageSel').change(function(){ 
		var p1=$(this).children('option:selected').val();//这就是selected的值
		pageIndex = 1;
		pageSize = p1;
		loadData_accountdetail();	//加载数据-订单列表
	}) 
}

