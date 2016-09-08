var Public = {
    Ui: {
        Menu: {},
        MenuList: {},
        Combo: {},
        Dialog: {},
        DatePicker: {},
        Tip: {}
    },
    checkIE : function() {
        var a = function() {
            for (var a = 3,
            b = document.createElement("div"), c = b.getElementsByTagName("i"); b.innerHTML = "<!--[if gt IE " + ++a + "]><i></i><![endif]-->", c[0];);
            return a > 4 && a
        } ();
        if (a && a < 8) {
            var b = '<div style="height:50px;width:100%;background:#FFF6CD;border:1px solid #E6DBB1;z-index:9999;line-height:50px;text-align:center;left:96px;">IE版本过低，推荐升级你的浏览器。建议下载以下的免费浏览器：<a href="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B6E29D538-ECA3-3687-97DA-B8AAC8C2A08D%7D%26lang%3Dzh-CN%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26installdataindex%3Ddefaultbrowser/update2/installers/ChromeSetup.exe" class="theme-color" target="_blank">谷歌浏览器</a>或IE8以上浏览器，其它浏览器建议使用极速模式。</div>';
            $(b).insertBefore($(".header")),
            $(".header").css({
                top: 50
            }),
            $(".system-notice").css({
                top: 60
            })
        }
    },
    ResizeData: {}
}
$(function() {
	Public.checkIE(),
    b = location.pathname,
    function() {
    	var d = "";
        var e = {
            init: function() {
                if (!$(".side-wrap").length) return ! 1;
                var a = this;
                return (a.setHtml(), setTimeout(function() {
//              return parent.sysSetting.port ? (a.hoverEventAgent(), !1) : (a.setCropMenu(), a.setHtml(), setTimeout(function() {
                    a.setWidth(),
                    a.setposi(),
                    a.Resize()
                },
                100), void a.hoverevent())
            },
            setHtml: function() {
            },
            hidefn: function(a) {
                for (var b = 0; b < a.length; b++) {
                    var c = a[b].split(".");
                    1 == c.length && (d[c[0]].ishide = !0),
                    2 == c.length ? d[c[0]].menu[c[1]].ishide = !0 : 3 == c.length && (d[c[0]].menu[c[1]].menu[c[2]].ishide = !0)
                }
            },
            showfn: function(a) {
                for (var b = 0; b < a.length; b++) {
                    var c = a[b].split(".");
                    1 == c.length && (d[c[0]].ishide = !1),
                    2 == c.length ? d[c[0]].menu[c[1]].ishide = !1 : 3 == c.length && (d[c[0]].menu[c[1]].menu[c[2]].ishide = !1)
                }
            },
            hoverevent: function() {
                var a, c;
                a = b.replace("/", ""),
                a.indexOf("/") != -1 && (a = a.substring(0, a.indexOf("/"))),
                "faq" == a ? a = "message": "inventory" == a ? a = "product": "generalize" == a && (a = "message"),
                c = document.getElementById(a),
                c && (c.className = c.className + " current"),
                Public.Ui.Menu.curInd = $(".side-menu .side-menu-li").index($(".side-menu-li.current")),
                $(".side-menu .side-menu-li").hover(function() {
                    var a = $(this);
                    a.addClass("hover").removeClass("current").siblings(".side-menu-li").removeClass("current hover");
                    var b = a.find(".float-menu");
                    b.html() && (b.show(), b.addClass("showMenu"))
                },
                function() {
                    var a = $(this);
                    a.removeClass("current hover");
                    var b = a.find(".float-menu");
                    b.html() && b.removeClass("showMenu"),
                    Public.Ui.Menu.curInd != -1 && $(".side-menu .side-menu-li").eq(Public.Ui.Menu.curInd).addClass("current")
                })
            },
            hoverEventAgent: function() {
                var a, c;
                a = b.replace("/", ""),
                a.indexOf("/") != -1 ? (c = document.getElementById(a.substring(0, a.indexOf("/"))), a = a.substring(0, a.indexOf("/"))) : c = document.getElementById(a),
                c && (c.className = c.className + " current"),
                Public.Ui.Menu.curInd = $(".side-menu>ul>li").index($(".side-menu>ul>li.current")),
                $(".side-menu>ul>li").hover(function() {
                    var a = $(this);
                    a.addClass("current").siblings("li").removeClass("current")
                },
                function() {
                    var a = $(this);
                    a.removeClass("current"),
                    Public.Ui.Menu.curInd != -1 && $(".side-menu>ul>li").eq(Public.Ui.Menu.curInd).addClass("current")
                })
            },
            setWidth: function() {
                for (var a = $(".side-menu .float-menu .sec-nav-flow"), b = 0; b < a.length; b++) {
                    a.eq(b).parents(".float-menu").css("display", "block");
                    for (var c = a.eq(b).find(".sec-nav-li-flow"), d = 0, e = 0; e < c.length; e++) d += c.eq(e).outerWidth();
                    a.eq(b).width(d),
                    c.height(a.eq(b).height()),
                    a.eq(b).parents(".float-menu").css("display", "none")
                }
            },
            setposi: function() {
                var a = ($(".side-menu .side-menu-li"), $(".side-menu .float-menu"));
                a.css({
                    top: 0
                })
            },
            Resize: function() {
                function a() {
                    var a = parent.window.Public.ResizeData.LeftLi1.outerHeight(),
                    b = parent.window.Public.ResizeData.LeftLi1.offset().top - $(document).scrollTop() + parent.window.Public.ResizeData.FloatMenu1height;
                    b > $(parent.window).height() ? parent.window.Public.ResizeData.FloatMenu1.css({
                        "margin-top": a - parent.window.Public.ResizeData.FloatMenu1height
                    }) : parent.window.Public.ResizeData.FloatMenu1.css({
                        "margin-top": 0
                    });
                    var c = a,
                    d = parent.window.Public.ResizeData.LeftLi2.offset().top - $(document).scrollTop() + parent.window.Public.ResizeData.FloatMenu2height;
                    d > $(parent.window).height() ? parent.window.Public.ResizeData.FloatMenu2.css({
                        "margin-top": c - parent.window.Public.ResizeData.FloatMenu2height
                    }) : parent.window.Public.ResizeData.FloatMenu2.css({
                        "margin-top": 0
                    })
                }
                Public.ResizeData.LeftLi = $(".side-menu .side-menu-li"),
                Public.ResizeData.LeftLi1 = Public.ResizeData.LeftLi.eq(Public.ResizeData.LeftLi.length - 1),
                Public.ResizeData.FloatMenu1 = Public.ResizeData.LeftLi1.find(".float-menu"),
                Public.ResizeData.FloatMenu1height = Public.ResizeData.FloatMenu1.outerHeight(),
                Public.ResizeData.LeftLi2 = Public.ResizeData.LeftLi.eq(Public.ResizeData.LeftLi.length - 2),
                Public.ResizeData.FloatMenu2 = Public.ResizeData.LeftLi2.find(".float-menu"),
                Public.ResizeData.FloatMenu2height = Public.ResizeData.FloatMenu2.outerHeight(),
                a(),
                $(parent.window).resize(function() {
                    parent && a()
                })
            }
        };
        e.init()
    } ()
    
});