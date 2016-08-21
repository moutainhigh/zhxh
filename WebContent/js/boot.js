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

var bootPATH = __CreateJSPath("boot.js");

//debugger
mini_debugger = false;   

//miniui
document.write('<script src="' + bootPATH + 'jquery-1.11.0.js" type="text/javascript"></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'util.js" type="text/javascript"></sc' + 'ript>');
document.write('<script src="' + bootPATH + 'miniui3.6/miniui.js" type="text/javascript" ></sc' + 'ript>');
document.write('<link href="' + bootPATH + 'miniui3.6/themes/default/miniui.css" rel="stylesheet" type="text/css" />');
document.write('<link href="' + bootPATH + 'miniui3.6/themes/icons.css" rel="stylesheet" type="text/css" />');

//skin
//var skin = getCookie("miniuiSkin");
var skin = "blue";
//var skin = "Default";

if (skin != "Default") {
    document.write('<link href="' + bootPATH + 'miniui3.6/themes/' + skin + '/skin.css" rel="stylesheet" type="text/css" />');
}

////////////////////////////////////////////////////////////////////////////////////////
function getCookie(sName) {
    var aCookie = document.cookie.split("; ");
    var lastMatch = null;
    for (var i = 0; i < aCookie.length; i++) {
        var aCrumb = aCookie[i].split("=");
        if (sName == aCrumb[0]) {
            lastMatch = aCrumb;
        }
    }
    if (lastMatch) {
        var v = lastMatch[1];
        if (v === undefined) return v;
        return unescape(v);
    }
    return null;
}

function getRootPath_web() {
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    return (localhostPaht + projectName);
}

//document.write('<script type="text/javascript">');
//document.write('$(document).ajaxComplete(function (evt, request, settings){');
//document.write('var text = request.responseText;');
//document.write('if(text.indexOf("页面过期")>0){');
//document.write('top.location = "'+getRootPath_web()+'/login.do";');
//document.write('}');
//document.write('})');
//document.write('</script>');

//document.write('<script type="text/javascript">');
//document.write('var WinAlerts = window.alert;');
//document.write('window.alert = function (e) {');
//document.write('if (e != null && e.indexOf("试用")>-1) {');
//document.write('WinAlerts("拦截第三方试用");');
//document.write('return;');
//document.write('}');
//document.write('else {');
//document.write('WinAlerts (e);');
//document.write('}};');
//document.write('</script>');

//$(document).ajaxComplete(function (evt, request, settings){
//    var text = request.responseText;
//    alert(text);
//    //判断返回的数据内容，如果是超时，则跳转到登陆页面
//    //if(text == "logout"){
//    //    top.location = '/login.jsp';
//    //}
//})

//$.ajaxSetup({
//    contentType:"application/x-www-form-urlencoded;charset=utf-8",   
//    cache:false ,   
//    complete:function(data,TS){   
//        //对返回的数据data做判断，
//        //session过期的话，就location到一个页面
//        }    
//    }
//});