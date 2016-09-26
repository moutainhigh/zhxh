/**
 * 
 */

//$(function(){
//    laydate({
//	   elem: '#birthday'
//	})
//	
//	$("#phonenumber").blur(function(){
//		var val = $(this).val();
//		$('#companycode').val(val);
//	})
//	
//	$('#username').focus();
//})

//这里是序列化form表单
function getData() {
	var formData = false;
	$("#addUserForm").ajaxSubmit(function() {
		formData = $("#addUserForm").serializeJson();
	});
	return formData;
}

function insertUser() {
	//alert(getRootPath_web());
	var row = getData();
	if (row == false) {
			return false;
		}
	else {
		row.identity = radio_value;
		row._state = 'added';
		if (row.identity != "Z") {
			row.companycode = row.phonenumber;
		}
		var rowArr = [];
		rowArr.push(row);
		var json = JSON.stringify(rowArr);
		$.ajax({
			async:false,
            url: getRootPath_web() + "/orderUser/save.htmls",
            data: {'objs':json},
            type: "post",
            dataType:"text",
            success: function (text) {
             	if (text == 'success') {
             		layer.msg("保存成功1。",{icon:6});
             		radio_click();
             		return false;
             	}
             	else if (text == "codeerror") {
             		layer.msg("手机短信验证码错误，请输入正确，再尝试，或与开发商联系。",{icon:5});
             	}
             	else {
             		layer.msg("保存出现问题，请退出重新登录，再尝试，或与开发商联系。",{icon:5});
             	}
            },
            error: function (jqXHR, textStatus, errorThrown) {
            	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
            }
       });
	}
}

function updateUser() {
	var row = getData();
	if (row == false) {
			return false;
	}
	else {
		//询问框
  		layer.confirm('确定要修改客户信息吗？', {
  			btn: ['确认', '取消']
  		},
  		function()	{
  			row._state = 'modified';
  			row.updatePhone = "0";
  			if (row.identity != "Z") {
  				row.companycode = row.phonenumber;
  			}
  			var rowArr = [];
  			rowArr.push(row);
  			var json = JSON.stringify(rowArr);
  			$.ajax({
    			async:false,
                url: getRootPath_web() + "/orderUser/save.htmls",
                data: {'objs':json},
                type: "post",
                dataType:"text",
                success: function (text) {
                 	if (text == 'success') {
                 		layer.msg("保存成功。",{icon:6});
                 		radio_click();
                 	}
                 	else if (text == "codeerror") {
                 		layer.msg("手机短信验证码错误，请输入正确，再尝试，或与开发商联系。",{icon:5});
                 	}
                 	else {
                 		layer.msg("保存出现问题，请退出重新登录，再尝试，或与开发商联系。",{icon:5});
                 	}
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
  		}, 
  		function(){
  			
  		});
	}
}

function getSendCode() {
			
	var phonenumber = $('#phonenumber').val();
	
	if (trim(phonenumber) == "") {
		parent.layer.msg("请输入手机号码。");
		$('#phonenumber').val("");
		$('#phonenumber').focus();
		return;
	}
	
	if (!validatemobile(phonenumber) ) {
		parent.layer.msg("请正确输入手机号码。");
		$('#phonenumber').val("");
		$('#phonenumber').focus();
		return;
	}
	
	//获取
	$.ajax({
    	url: getRootPath_web() + "/orderUser/getCode.htmls",
    	data:{'phonenumber':phonenumber,'sendType':'insert'},
    	type:"post",
    	dataType:"text",
        success: function (text) {
        	if (text == "empty") {
        		layer.msg("未获取到手机号码，请重新输入手机号码，再获取短信验证码.");
				$('#phonenumber').focus();
				return;
        	}
        	else if (text == "exist") {
        		layer.msg("手机号码已注册过，请重新输入手机号码，再获取短信验证码.");
				$('#phonenumber').focus();
				return;
        	}
        	else if(text == "success"){
            	//location.reload();
        		opentime();
            }else{
            	//layer.msg("测试的验证码:" + text);
            	opentime();
            }
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
        //o.val("获取验证码");
        o.text("获取验证码");
        wait = 120;
    } else {
    	o.attr("disabled", true);
        //o.val("重新发送(" + wait + ")");
        o.text("重新发送(" + wait + ")");
        wait--;  
        setTimeout(function() {  
        	opentime(o);
        },  
        1000)
    }
}