<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
    <style type="text/css">
	    body {
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }
	    .key {
	        background:url(${pageContext.request.contextPath}/images/key.png) no-repeat;width:32px;height:32px;
	    }
	    .setting {
	        background:url(${pageContext.request.contextPath}/images/setting.png) no-repeat;width:32px;height:32px;
	    }
	    .database {
	        background:url(${pageContext.request.contextPath}/images/database.png) no-repeat;width:32px;height:32px;
	    }
	    .print {
	        background:url(${pageContext.request.contextPath}/images/print.png) no-repeat;width:32px;height:32px;
	    }
	    .indexer {
	        background:url(${pageContext.request.contextPath}/images/Notes_Large.png) no-repeat;width:32px;height:32px;
	    }
    </style>
    
    <script type="text/javascript">
	    var dataList = [];
	    
	    var t1 = {};
	    t1.id = "right";
	    t1.text = "内容管理";
	    dataList.push(t1);
	    
	    var t2 = {};
	    t2.id = "setting";
	    t2.pid = "right";
	    t2.text = "首图轮播";
	    t2.iconCls = "setting";
	    t2.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/homePiclist";
	    t2.iconPosition = "top";
	    dataList.push(t2);
	    
	    var t3 = {};
	    t3.id = "setting";
	    t3.pid = "right";
	    t3.text = "制作专题";
	    t3.iconCls = "setting";
	    t3.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/subjectList";
	    t3.iconPosition = "top";
	    dataList.push(t3);
    
	    var t4 = {};
	    t4.id = "setting";
	    t4.pid = "right";
	    t4.text = "FAQ";
	    t4.iconCls = "setting";
	    t4.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/faqList";
	    t4.iconPosition = "top";
	    dataList.push(t4);
    
	    var t5 = {};
	    t5.id = "setting";
	    t5.pid = "right";
	    t5.text = "联系我们";
	    t5.iconCls = "setting";
	    t5.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/contactusList";
	    t5.iconPosition = "top";
	    dataList.push(t5);
	    
	    var t6 = {};
	    t6.id = "setting";
	    t6.pid = "right";
	    t6.text = "工作招聘";
	    t6.iconCls = "setting";
	    t6.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/jobList";
	    t6.iconPosition = "top";
	    dataList.push(t6);
	    
	    var t7 = {};
	    t7.id = "setting";
	    t7.pid = "right";
	    t7.text = "区域合作";
	    t7.iconCls = "setting";
	    t7.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/joinList";
	    t7.iconPosition = "top";
	    dataList.push(t7);
	    
	    var t8 = {};
	    t8.id = "setting";
	    t8.pid = "right";
	    t8.text = "隐私政策";
	    t8.iconCls = "setting";
	    t8.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/policyList";
	    t8.iconPosition = "top";
	    dataList.push(t8);
	    
	    var t9 = {};
	    t9.id = "setting";
	    t9.pid = "right";
	    t9.text = "合作伙伴";
	    t9.iconCls = "setting";
	    t9.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/partnerList";
	    t9.iconPosition = "top";
	    dataList.push(t9);
	    
	    var t10 = {};
	    t10.id = "setting";
	    t10.pid = "right";
	    t10.text = "法律声明";
	    t10.iconCls = "setting";
	    t10.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/lawList";
	    t10.iconPosition = "top";
	    dataList.push(t10);
    	$(function(){
            var leftTree = mini.get("leftTree");
            leftTree.loadList(dataList,"id","pid");
        })
        
        function onItemSelect(e) {
    		var iframe = document.getElementById("mainframe");
            var item = e.item;
            iframe.src = item.url;
        }
        
    </script>
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;">
		<div size="200" showCollapseButton="true">
	        <div id="leftTree" class="mini-outlookmenu"  onitemselect="onItemSelect" borderStyle="border:0" ></div>
	    </div>
		<div showCollapseButton="false" >
		    	<iframe id="mainframe" src="${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/homePiclist" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="auto" allowtransparency="yes"></iframe>
		</div>
	    
	</div>
</body>
</html>