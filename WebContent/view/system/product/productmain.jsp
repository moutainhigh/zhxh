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
	    .product {
	        background:url(${pageContext.request.contextPath}/images/makeup.png) no-repeat;width:32px;height:32px;
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
	    t1.text = "商品管理";
	    dataList.push(t1);
	    
	    var t2 = {};
	    t2.id = "product";
	    t2.pid = "right";
	    t2.text = "商品管理";
	    t2.iconCls = "product";
	    t2.url = getRootPath_web() + "/common/dispatch.html?page=/view/system/product/productlist";
	    t2.iconPosition = "top";
	    dataList.push(t2);
	    
	    var t3 = {};
	    t3.id = "label";
	    t3.pid = "right";
	    t3.text = "标签管理";
	    t3.iconCls = "label";
	    t3.url = getRootPath_web() + "/common/dispatch.html?page=/view/system/system/labellist";
	    t3.iconPosition = "top";
	    dataList.push(t3);
	    
    
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
		    	<iframe id="mainframe" src="${pageContext.request.contextPath}/common/dispatch.html?page=/view/system/product/productlist" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="auto" allowtransparency="yes"></iframe>
		</div>
	    
	</div>
</body>
</html>