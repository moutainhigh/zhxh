__CreateJSPath = function (js) {
    var scripts = document.getElementsByTagName("script");
    var path = "";
    for (var i = 0, l = scripts.length; i < l; i++) {
        var src = scripts[i].src;
        if (src.indexOf(js) != -1) {
            var ss = src.split(js);
            path = ss[0];
            break;
        }
    }
    var href = location.href;
    href = href.split("#")[0];
    href = href.split("?")[0];
    var ss = href.split("/");
    ss.length = ss.length - 1;
    href = ss.join("/");
    if (path.indexOf("https:") == -1 && path.indexOf("http:") == -1 && path.indexOf("file:") == -1 && path.indexOf("\/") != 0) {
        path = href + "/" + path;
    }
    return path;
}
// JavaScript 公共工具类

function trim(str){ //删除左右两端的空格
	return str.replace(/(^\s*)|(\s*$)/g, "");
}
function ltrim(str){ //删除左边的空格
	return str.replace(/(^\s*)/g,"");
}
function rtrim(str){ //删除右边的空格
	return str.replace(/(\s*$)/g,"");
}


//获取滚动条位置，存入cookie
function jscroll(classname,name) {
	var jscroll = $('.'+classname).scrollTop();
	if (name == null) {
		setCookie('jscroll',jscroll);
	}
	else {
		setCookie(name,jscroll);
	}
}

//获取滚动条位置，存入cookie
function setCroll(object,name) {
	var jscroll = $(object).scrollTop();
	if (name == null) {
		setCookie('jscroll',jscroll);
	}
	else {
		setCookie(name,jscroll);
	}
}


//设置cookie
function setCookie(name,value){
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

//读取cookies
function getCookie(name){
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
        return (arr[2]);
    else
        return null;
}
//删除cookies
function delCookie(name){
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null)
        document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}

function getRootPath_web() {
    /*//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    alert(localhostPaht + projectName);
    return (localhostPaht + projectName);*/
	
	var bootPATH = __CreateJSPath("util.js");
	bootPATH = bootPATH.substr(0,bootPATH.length-3);
	//alert(bootPATH);
	return bootPATH;
}




//function sessionOut1(data) {
//	if(data.toString().indexOf("页面过期") > 0 ) {
//		alert("您已经太长时间没有操作,请重新登录。");
//		window.top.location.href=getRootPath_web() + "/login.do";
//	}
//	return false;
//}
//
//$(function(){
//	$.ajaxSetup({
//	    contentType:"application/x-www-form-urlencoded;charset=utf-8",
//	    cache:false,
//	    complete:function(XMLHttpRequest,textStatus){
//	    	var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); //通过XMLHttpRequest取得响应头，sessionstatus，  
//	    	alert(sessionstatus + "66");
//	        if(sessionstatus=="timeout"){
//	        	alert("登录超时,请重新登录！");
//	            //如果超时就处理 ，指定要跳转的页面
//	            window.top.location.href = getRootPath_web() + "/login.do";
//	            //window.location.replace(webPath.webRoot + "account/login");   
//	        }   
//	    }   
//	});
//})

$.ajaxSetup({
    contentType:"application/x-www-form-urlencoded;charset=utf-8",
    cache:false,
    async: false,
    complete:function(XMLHttpRequest,textStatus){
    	var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); //通过XMLHttpRequest取得响应头，sessionstatus，  
        if(sessionstatus=="timeout"){
        	alert("登录超时,请重新登录！");
            //如果超时就处理 ，指定要跳转的页面
            window.top.location.href = getRootPath_web() + "login.htmls";
            //window.location.replace(webPath.webRoot + "account/login");   
        }
        else if (sessionstatus == "timeout2") {
        	alert("登录超时,请重新登录！");
            //如果超时就处理 ，指定要跳转的页面
            window.top.location.href = getRootPath_web() + "login_single.htmls";
        }
    }   
});

//form序列化
$.fn.serializeObject = function()  
{  
   var o = {};  
   var a = this.serializeArray();  
   $.each(a, function() {  
       if (o[this.name]) {  
           if (!o[this.name].push) {  
               o[this.name] = [o[this.name]];  
           }  
           o[this.name].push(this.value || '');  
       } else {  
           o[this.name] = this.value || '';  
       }  
   });  
   return o;  
};

//全选插件
//checkall_name   操作全选的复选框name
//checkbox_name   被操作的复选框的name  name值可不统一 设置包含值 以XXX开头 自己修改
(function ($) {
  $.fn.check = function (options) {
      var defaults = {
          checkall_name: "checkall_name", //全选框name
          checkbox_name: "checkbox_name" //被操作的复选框name
      },
      ops = $.extend(defaults, options);
      e = $("input[name='" + ops.checkall_name + "']"), //全选
      f = $("input[name='" + ops.checkbox_name + "']"), //单选
      g = f.length; //被操作的复选框数量
      f.click(function () {
          $("input[name ='" + ops.checkbox_name + "']:checked").length == $("input[name='" + ops.checkbox_name + "']").length ? e.attr("checked", !0) : e.attr("checked", !1);
      }), e.click(function () {
          for (i = 0; g > i; i++) f[i].checked = this.checked;
      });
  };
})(jQuery);

//form 序列化插件。
(function($){  
    $.fn.serializeJson=function(){
        var serializeObj={};
        var array=this.serializeArray();
        var str=this.serialize();  
        $(array).each(function(){  
            if(serializeObj[this.name]){  
                if($.isArray(serializeObj[this.name])){  
                    serializeObj[this.name].push(this.value);  
                }else{  
                    serializeObj[this.name]=[serializeObj[this.name],this.value];  
                }  
            }else{  
                serializeObj[this.name]=this.value;   
            }  
        });  
        return serializeObj;  
    };  
})(jQuery);


/**
 * 格式化金额
 * */
function formatAmount(e){
	return formatFloat(e,2);
}

//金额格式化  
function formatFloat(src, pos){  
    var num = parseFloat(src).toFixed(pos);  
    num = num.toString().replace(/\$|\,/g,'');  
    if(isNaN(num)) num = "0";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num*100+0.50000000001);  
    cents = num%100;  
    num = Math.floor(num/100).toString();  
    if(cents<10) cents = "0" + cents;  
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
    num = num.substring(0,num.length-(4*i+3))+','+num.substring(num.length-(4*i+3));  
    return (((sign)?'':'-') + num + '.' + cents);  
}

/** 
 * 将数值四舍五入(保留2位小数)后格式化成金额形式 
 * 
 * @param num 数值(Number或者String) 
 * @return 金额格式的字符串,如'1,234,567.45' 
 * @type String 
 */  
function formatCurrency(num) {  
    num = num.toString().replace(/\$|\,/g,'');  
    if(isNaN(num))  
    num = "0";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num*100+0.50000000001);  
    cents = num%100;  
    num = Math.floor(num/100).toString();  
    if(cents<10)  
    cents = "0" + cents;  
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
    num = num.substring(0,num.length-(4*i+3))+','+  
    num.substring(num.length-(4*i+3));  
    return (((sign)?'':'-') + num + '.' + cents);  
} 
/** 
 * 将数值四舍五入(保留1位小数)后格式化成金额形式 
 * 
 * @param num 数值(Number或者String) 
 * @return 金额格式的字符串,如'1,234,567.4' 
 * @type String 
 */  
function formatCurrencyTenThou(num) {  
    num = num.toString().replace(/\$|\,/g,'');  
    if(isNaN(num))  
    num = "0";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num*10+0.50000000001);  
    cents = num%10;  
    num = Math.floor(num/10).toString();  
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
    num = num.substring(0,num.length-(4*i+3))+','+  
    num.substring(num.length-(4*i+3));  
    return (((sign)?'':'-') + num + '.' + cents);  
}  