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
	    .member {
	        background:url(${pageContext.request.contextPath}/images/icon/user.png) no-repeat;width:32px;height:32px;
	    }
    </style>
    
    <script type="text/javascript">
	    var dataList = [];
	    
	    var t1 = {};
	    t1.id = "right";
	    t1.text = "订单管理";
	    dataList.push(t1);
	    
	    var t2 = {};
	    t2.id = "member";
	    t2.pid = "right";
	    t2.text = "全部订单";
	    t2.iconCls = "member";
	    t2.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/order/orderList&param={ordertype:''}";
	    t2.iconPosition = "top";
	    dataList.push(t2);
	    
	    var t3 = {};
	    t3.id = "member";
	    t3.pid = "right";
	    t3.text = "采购订单";
	    t3.iconCls = "member";
	    t3.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/order/orderList&param={ordertype:'sub'}";
	    t3.iconPosition = "top";
	    dataList.push(t3);
    
	    var t4 = {};
	    t4.id = "member";
	    t4.pid = "right";
	    t4.text = "普通会员订单";
	    t4.iconCls = "member";
	    t4.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/order/customerOrderList";
	    t4.iconPosition = "top";
	    dataList.push(t4);
	    
	    /* var t5 = {};
	    t5.id = "member";
	    t5.pid = "right";
	    t5.text = "全部门店管理";
	    t5.iconCls = "member";
	    t5.url = "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/userCList";
	    t5.iconPosition = "top";
	    dataList.push(t5);
	     */
	    
    	$(function(){
    		mini.parse();
            var leftTree = mini.get("leftTree");
            leftTree.loadList(dataList,"id","pid");
            leftTree.selectNode("member");
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