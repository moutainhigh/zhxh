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
	    .page {
	        background:url(${pageContext.request.contextPath}/images/page.png) no-repeat;width:32px;height:32px;
	    }
    </style>
    
    <script type="text/javascript">
	    
	    var dataList = [];
	    
	    var t1 = {};
	    t1.id = "right";
	    t1.text = "利益分配管理";
	    dataList.push(t1);
	    
	    var t2 = {};
	    t2.id = "disconfig";
	    t2.pid = "right";
	    t2.text = "公共利益分配参数设置";
	    t2.iconCls = "setting";
	    t2.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/dis/disconfig";
	    t2.iconPosition = "top";
	    dataList.push(t2);
	    
	    var t3 = {};
	    t3.id = "disstandard";
	    t3.pid = "right";
	    t3.text = "平台直属利益分配详细";
	    t3.iconCls = "setting";
	    t3.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/dis/top_disstandard";
	    t3.iconPosition = "top";
	    dataList.push(t3);
	    
	    /*var t4 = {};
	    t4.id = "brandlist";
	    t4.pid = "right";
	    t4.text = "品牌系列页";
	    t4.iconCls = "page";
	    t4.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/brandlist";
	    t4.iconPosition = "top";
	    dataList.push(t4);
	    
	    var t5 = {};
	    t5.id = "productlist";
	    t5.pid = "right";
	    t5.text = "品牌列表页";
	    t5.iconCls = "page";
	    t5.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/plist";
	    t5.iconPosition = "top";
	    dataList.push(t5); */
	    
    
    	$(function(){
    		mini.parse();
            var leftTree = mini.get("leftTree");
            leftTree.loadList(dataList,"id","pid");
          	leftTree.selectNode("disconfig");
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
		    	<iframe id="mainframe" src="" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="auto" allowtransparency="yes"></iframe>
		</div>
	    
	</div>
</body>
</html>