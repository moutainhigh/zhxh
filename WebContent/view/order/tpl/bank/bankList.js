
var userid;	//当前sessioin账户
var _trantype;
var _current_uid;
/**
 * 资金账户
 * */
function getUserBank() {
	var par = {};
	par.userid = userid;
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/listUserBank.htmls",
        data: par,
        type: "post",
        dataType:"json",
        success: function (json) {
        	$("#banks").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/bankList.tpl");
        	$("#banks").setParam("path",getRootPath_web() + "/js/pintuer/pintuer.js");
        	$("#banks").setParam("identity",json.identity);
        	$("#banks").setParam("current_uid",_current_uid);
        	
        	$("#banks").processTemplate(json.data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
        	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
        }
   });
}

/**
 * 充值,trantype:充值类型
 * */
function recharge(pid,trantype){
	layer.prompt({
		title: '请输入充值金额，并确认',
		formType: 0 //prompt风格，支持0-2
	}, function(amount){
		if(!isInteger(amount)){
			parent.layer.msg('请输入大于0的正整数', {icon:5});
			return;
		}
		var config = getDisConfig();
		if(config.deposit_up > 0){
			if(amount > config.deposit_up){
				parent.layer.msg("您输入的金额超过上限，请重新输入",{icon:6});
				return;
			}
		}
		if(config.deposit_down > 0){
			if(amount < config.deposit_down){
				parent.layer.msg("您输入的金额低于下限，请重新输入",{icon:6});
				return;
			}
		}
		
		$.ajax({
			async:false,
            url: getRootPath_web() + "/orderUserBank/recharge.htmls",
            data: {parentid:pid,amount:amount,trantype:trantype},
            type: "post",
            dataType:"json",
            success: function (json) {
            	if(json.code != "0"){
            		_current_uid = pid;
            		$("#billDetail").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/payBillDetail.tpl");
             		$("#billDetail").processTemplate(json.data);
             		layer.msg("账单已生成，请确认并支付",{icon:6});
            	}else{
            		layer.msg("操作失败，请稍后再试！",{icon:6});
            	}
            	/* getUserBank();
            		layer.msg("充值成功",{icon:6}); */
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(jqXHR.responseText);
            }
       	});
	});
}

/**
 * 充值-付款
 * */
function payment(){
	pay_form.action=getRootPath_web() + "/orderUserBank/payment.htmls";
	pay_form.submit();
	
	var cf = "是否支付成功？【是】【否】<br><p style='font-size:12px; color:#FF6600'>点击【是】，表示支付成功请查看账户金额是否已变更，点击【否】，表示支付失败可再次进行支付</p><p style='font-size:12px; color:red'>注意：请勿重复提交</p>";
	layer.confirm(cf, {title:'系统提示',icon:3,
			btn: ['是','否'] //按钮
		}, function(index){
			getUserBank();
			$("#income_click").click();
			layer.close(index);
		}, function(){
			//layer.msg("请",{icon:6});
		});
}

/**
 * 转货款
 * */
function transfBuyBank(pid,amount){
	layer.prompt({
		title: '请输入充值金额，并确认',
		value:amount,
		formType: 0 //prompt风格，支持0-2
	}, function(trans_amount){
		if(trans_amount > amount){
			parent.layer.msg("账户余额不足，请重新输入！",{icon:6});
			return;
		}else{
			//获取系数
			var coef = getTransfCoef(pid);
			var subtotal = trans_amount;
			if(coef != 0){
				subtotal = trans_amount * coef;	
			}
			var cf = "<p>转货款金额￥"+trans_amount+"，转货款系数"+coef+"倍，总金额：￥"+subtotal+"</P>";
			layer.confirm(cf+'【确定要转货款吗？】', {
				title:'系统消息',
			  btn: ['确定','取消'] //按钮
			}, function(){
				//提交服务器
				$.ajax({
   	    			async:false,
   	                url: getRootPath_web() + "/orderUserBank/transfBuyBank.htmls",
   	                data: {parentid:pid,amount:trans_amount},
   	                type: "post",
   	                dataType:"text",
   	                success: function (text) {
   	                	if(text == "success"){
   	                		getUserBank();
   	                		layer.msg("转货款成功！",{icon:6});
   	                	}else{
   	                		layer.msg("操作失败，请稍后再试！",{icon:6});
   	                	}
   	                },
   	                error: function (jqXHR, textStatus, errorThrown) {
   	                    alert(jqXHR.responseText);
   	                }
   	           	});
			}, function(){
			  
			});
		}
	});
}

/**
 * 获取转货款系数
 * */
function getTransfCoef(pid){
	var coef = 0;
	$.ajax({
		async:false,
        url: getRootPath_web() + "/orderUserBank/getTransfCoef.htmls",
        data: {parentid:pid},
        type: "post",
        dataType:"text",
        success: function (text) {
        	if(text != "error"){
        		//系数应该是大于0的数
        		coef = text;
        	}else{
        		coef = 0;
        	}
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //alert(jqXHR.responseText);
            coef = 0;
        }
   	});
	return coef;
}

//提现
function withdrawal(pid,amount,trantype){
	layer.prompt({
		title: '请输入提现金额，并确认',
		value:amount,
		formType: 0 //prompt风格，支持0-2
	}, function(withdraw_amount){
		if(withdraw_amount > amount){
			parent.layer.msg("账户余额不足，请重新输入！",{icon:6});
			return;
		}else{
			//提交服务器
			$.ajax({
    			async:false,
                url: getRootPath_web() + "/orderUserBank/withdrawal.htmls",
                data: {parentid:pid,amount:withdraw_amount,trantype:trantype},
                type: "post",
                dataType:"text",
                success: function (text) {
                	if(text == "success"){
                		
                	}else if(text == "0"){
                		layer.msg("您的账户已被冻结，不能进行提现！",{icon:6});
                	}else{
                		layer.msg("操作失败，请稍后再试！",{icon:6});
                	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           	});
		}
	});
}


/**
 * 提现-填写表单
 * */
function apply_withdrawal(pid,amount,trantype){
	_current_uid = pid;
	_trantype = trantype;
	$("#billDetail").setTemplateURL(getRootPath_web() + "/view/order/tpl/bank/pay2bank.tpl");
	$("#billDetail").setParam("path",getRootPath_web() + "/js/pintuer/pintuer.js");
	$("#billDetail").setParam("parentid",pid);
	$("#billDetail").setParam("amount",amount);
	$("#billDetail").setParam("trantype",trantype);
	$("#billDetail").processTemplate();
}

/**
 * 这里是序列化form表单
 * */
function getData() {
	var formData = false;
	$("#pay2bankForm").ajaxSubmit(function() {
		formData = $("#pay2bankForm").serializeJson();
	});
	return formData;
}

function save_ithdrawal_bill() {
	var row = getData();
	if (row == false) {
		return false;
	}else {
		var json = JSON.stringify(row);
		$.ajax({
			async:false,
            url: getRootPath_web() + "/orderUserBank/withdrawal.htmls",
            data: {'objs':json,'sendcode':row.sendcode},
            type: "post",
            dataType:"text",
            success: function (text) {
            	if(text == "codeerror"){
            		layer.msg("验证码错误",{icon:6});
            	}else if(text == "3"){
            		layer.msg("您的账户余额不足，请重新输入提现金额。",{icon:6});
            	}else if(text == "2"){
            		layer.msg("您的账户已被冻结，请联系上级机构。",{icon:6});
            	}else if(text == "1"){
            		layer.msg("申请成功",{icon:6});
            		//
            		getUserBank();
        			$("#spending_click"+_trantype+_current_uid).click();
            	}else if(text == "0"){
            		layer.msg("您的上级机构账户余额不足，请联系上级机构",{icon:6});
            	}else if(text == "-1"){
            		layer.msg("系统错误",{icon:6});
            	}else{
            		layer.msg("系统繁忙，请稍后再试！",{icon:6});
            	}
            },
            error: function (jqXHR, textStatus, errorThrown) {
            	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
            }
       });
	}
}
/**
 * 获取验证码
 * */
function getSendCode() {
	$.ajax({
    	url: getRootPath_web() + "/orderUserBank/getCode.htmls",
    	type:"post",
    	dataType:"text",
        success: function (text) {
        	opentime();
        	alert(text);
        },
        error: function () {
            layer.msg("失败");
            return;
        }
    });
	return false;
}
var wait=120;
function opentime() {
	var o = $(".huoqu");
	if (wait == 0) {  
        o.removeAttr("disabled");
        o.text("获取验证码");
        wait = 120;
    } else {
    	o.attr("disabled", true);
        o.text("重新发送(" + wait + ")");
        wait--;  
        setTimeout(function() {  
        	opentime(o);
        },  
        1000)
    }
}