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
	    t1.text = "系统配置";
	    dataList.push(t1);
	    
	    var t2 = {};
	    t2.id = "setting";
	    t2.pid = "right";
	    t2.text = "参数设置";
	    t2.iconCls = "setting";
	    t2.url = getRootPath_web() + "/common/dispatch.do?page=/view/config/config_list";
	    t2.iconPosition = "top";
	    dataList.push(t2);
	    
	    var t3 = {};
	    t3.id = "docserver";
	    t3.pid = "right";
	    t3.text = "电子全文服务器";
	    t3.iconCls = "database";
	    t3.url = getRootPath_web() + "/common/dispatch.do?page=/view/config/docserver_list";
	    t3.iconPosition = "top";
	    dataList.push(t3);
	    
	    var t4 = {};
	    t4.id = "docauth";
	    t4.pid = "right";
	    t4.text = "电子全文权限";
	    t4.iconCls = "key";
	    t4.url = getRootPath_web() + "/common/dispatch.do?page=/view/config/doc_auth";
	    t4.iconPosition = "top";
	    dataList.push(t4);
	    
	    //获取系统是否有电子全文检索功能
	    $.ajax({
			async : false,
			url : "${pageContext.request.contextPath}/config/getIndexer.do",
			data: "",
			type : 'post',
			dataType : 'text',
			success : function(data) {
				if (data != null && data != "") {
					if (data == "1") {
						var t6 = {};
					    t6.id = "docIndexer";
					    t6.pid = "right";
					    t6.text = "电子全文索引";
					    t6.iconCls = "indexer";
					    t6.url = getRootPath_web() + "/common/dispatch.do?page=/view/config/doc_indexer";
					    t6.iconPosition = "top";
					    dataList.push(t6);
					}
				}
			}
		});
	    
	    var t5 = {};
	    t5.id = "print";
	    t5.pid = "right";
	    t5.text = "打印配置";
	    t5.iconCls = "print";
	    t5.url = getRootPath_web() + "/common/dispatch.do?page=/view/config/print_tab";
	    t5.iconPosition = "top";
	    dataList.push(t5);
    
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
<%-- 	        <div id="leftTree" class="mini-outlookmenu" url="${pageContext.request.contextPath}/view/config/configmenu.txt" onitemselect="onItemSelect"
            	idField="id" parentField="pid" textField="text" borderStyle="border:0" 
        	>
        	</div> --%>
	    </div>
		<div showCollapseButton="false" >
		    	<iframe id="mainframe" src="${pageContext.request.contextPath}/common/dispatch.do?page=/view/config/config_list" width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="auto" allowtransparency="yes"></iframe>
		</div>
	    
	</div>
</body>
</html>