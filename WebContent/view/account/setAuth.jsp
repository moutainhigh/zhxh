<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

	<style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    
    </style>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
    
    <script type="text/javascript">
	    //mini.parse();
	    
	    var tree;
	    var accountid;
	    var showStr = "";
	    var grid;
	    var selectTreeid = "";
	    var selectTreecode = "";
	    var account_tree = "";
	    
	    var templettype = "";
	    
	    var selectTempletid = "";
	    
	    var tableType = [];
	    
	    var grid_file_auth;
	    
	    var docAuthArr = [];
	    
	    $(function(){
	    	
	    	//获取角色对象组
       		var docAuth = {};
       		docAuth.id = "";
       		docAuth.text = "";
       		docAuthArr.push(docAuth);
       		$.ajax({
    			async : false,
    			url : "${pageContext.request.contextPath}/config/getDocAuth.do",
    			type : 'post',
    			dataType : 'text',
    			success : function(data) {
    				if (data != null) {
    					var myobj = JSON.parse(data);
    					//var myobj=eval(data);
	    				for(var i=0;i<myobj.length;i++){
	    					var docAuth = {};
	    					docAuth.id = myobj[i].columnname;
	    					docAuth.text = myobj[i].columndata;
	    					docAuthArr.push(docAuth);
	    				}
    				}
    			}
    		});
       		
	    	tree = mini.get("tree1");
	    	grid = mini.get("grid");
	    	grid_file_auth = mini.get("grid_file_auth");
       		var url = "${pageContext.request.contextPath}/tree/getTree.do";
       		
       		tree.set({
       			expandOnLoad:0,
       			showTreeIcon:true,
       			textField:"text",
       			idField:"id",
       			parentField:"parentid",
       			resultAsTree:false,
       			showCheckBox:true,
       			checkRecursive:true, 
       			imgPath:"${pageContext.request.contextPath}/images/tree/"
       		});
       		tree.load(url);
       		
       		tree.on("nodeselect", function (e) {
       			selectTreeid = e.node.id;
            	selectTreecode = e.node.text;
            	selectTempletid = e.node.templetid;
            	templettype = e.node.templettype;
       			
                if (e.isLeaf) {
                	/* $.ajax({
            			async : false,
            			url : "${pageContext.request.contextPath}/templet/getTemplettype.do",
            			data: {id:e.node.templetid},
            			type : 'post',
            			dataType : 'text',
            			success : function(data) {
            				if (data != null && data != "") {
            					templettype = data;
            				}
            				else {
            					templettype = "";
            				}
            			}
            		}); */
                	
                	if (templettype == "F") {
                		var ajAddbtn = mini.get("ajAddbtn");
                		ajAddbtn.setVisible(false);
                	}
                	else {
                		var ajAddbtn = mini.get("ajAddbtn");
                		ajAddbtn.setVisible(true);
                	}
                	
                	var aaa = mini.getsbyName("auth");
    	   			for(var i=0;i<aaa.length;i++) {
    	   				aaa[i].setEnabled(true);
    	   			}
    	   			
                	$.ajax({
            			async : false,
            			url : "${pageContext.request.contextPath}/account/getTreeAuth.do",
            			data: {id:accountid,treeid:e.node.id},
            			type : 'post',
            			dataType : 'text',
            			success : function(data) {
            				if (data != null && data != "") {
            					account_tree = data;
            				}
            				else {
            					account_tree = "";
            					var aaa = mini.getsbyName("auth");
                	   			for(var i=0;i<aaa.length;i++) {
                	   				aaa[i].setEnabled(false);
                	   			}
                	   			grid.clearRows();
                	   			grid_file_auth.clearRows();
            				}
            			}
            		});
                	
                	if (account_tree != "") {
                		var account_treeObj = JSON.parse(account_tree);
                		
                		var filter = account_treeObj.filter;
                		if (null != filter && filter != "") {
                			grid.setData(JSON.parse(filter));
                		}
                		else {
                			grid.clearRows();
                		}
                		//drawcell();
                		
                		//生成电子文件权限
                		var f = JSON.parse("["+account_tree+"]");
                		grid_file_auth.setData(f);
                	}
                	else {
                		grid.clearRows();
                		grid_file_auth.clearRows();
                	}
        	       	
                	$("#pid").html("高级权限-["+selectTreecode+"]的记录访问权限");
                	
                } else {
                	var aaa = mini.getsbyName("auth");
    	   			for(var i=0;i<aaa.length;i++) {
    	   				aaa[i].setEnabled(false);
    	   			}
    	   			grid.clearRows();
    	   			grid_file_auth.clearRows();
    	   			
    	   			selectTreeid = "";
                	selectTreecode = "";
                	selectTempletid = "";
                	account_tree = "";
                	templettype = "";
                	$("#pid").html("高级权限-记录访问权限");
                }
            });
       		
        	grid.set({
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	              	{ field: "action", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	                { field: "tableType",name:"tableType", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "档案类型",vtype:"required" },
      	                { field: "fieldname",name:"fieldname", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "字段名称",vtype:"required",editor: { type: "buttonedit",allowInput:false,onbuttonclick:"onButtonEdit"} },
      	                { field: "oper",name:"oper",type:"comboboxcolumn",autoShowPopup:true, width: 120, headerAlign: "center", align:"center",allowSort: false, header: "条件",vtype:"required",editor: { type: "combobox", data: [{"id":"like","text":"包含"},{"id":"equal","text":"等于"}]} },
      	                { field: "dataAuthValue",name:"dataAuthValue", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "条件值",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:false,
	            //onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	drawcell();
        	//初始化电子文件权限
        	grid_file_auth.set({
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "filescan",name:"filescan",type:"comboboxcolumn",autoShowPopup:true, width: 120, headerAlign: "center", align:"center",allowSort: false, header: "电子文件查看",vtype:"required" ,editor: { type: "combobox", data: [{"id":"0","text":"禁止"},{"id":"1","text":"允许"}]} },
      	                { field: "filedown",name:"filedown",type:"comboboxcolumn",autoShowPopup:true, width: 120, headerAlign: "center", align:"center",allowSort: false, header: "电子文件下载",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁止"},{"id":"1","text":"允许"}]} },
      	                { field: "fileprint",name:"fileprint",type:"comboboxcolumn",autoShowPopup:true, width: 120, headerAlign: "center", align:"center",allowSort: false, header: "电子文件打印",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁止"},{"id":"1","text":"允许"}]} },
      	                { field: "docauthvalue",name:"docauthvalue", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "电子文件权限范围",vtype:"required" }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	drawcell_file_auth();
	    })
	    
	    function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var uid = record._uid;
            var rowIndex = e.rowIndex;
            
       	 	var s = ' <a class="Edit_Button" href="javascript:delRow(\'' + uid + '\')" >删除</a>';
            return s;
        }
	    
	    function delRow(uid) {
        	var cf1 = "确定要删除选中的高级权限吗？";
        	
			var row = grid.getRowByUID(uid);
			
			if (typeof(row.id) == "undefined" || row.id == "") {
				grid.removeRow(row, false);
				return;
            }
			
			var node = tree.getNode(row.id);
       	 	
			grid.reject();
			grid.accept();
        	
          	if (confirm(cf1)) {
          		grid.removeRow(row, false);
   		 	}
        }
	    
	    function drawcell() {
       		grid.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
    	        if (field == "tableType") {
    	        	if (templettype == "A" || templettype == "P") {
    	        		if (value == "01") {
        		            e.cellHtml = '案卷级';
        	        	}
        	        	else if (value == "02"){
        	        		e.cellHtml = '文件级';
        	        	}
    	        	}
    	        	else if (templettype == "F") {
    	        		e.cellHtml = '文件级';
    	        	}
    	        	else {
    	        		alert(templettype);
    	        	}
    	        }
    	        
            });
        }
	    
	    function drawcell_file_auth() {
	    	grid_file_auth.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "filescan") {
   	        		if (value == 0) {
   	        			e.cellStyle = "color:red;text-align:center";
       	        	}
   	        		else {
   	        			e.cellStyle = "color:blue;text-align:center";
   	        		}
    	        }
    	        if (field == "filedown") {
   	        		if (value == 0) {
   	        			e.cellStyle = "color:red;text-align:center";
       	        	}
   	        		else {
   	        			e.cellStyle = "color:blue;text-align:center";
   	        		}
    	        }
    	        if (field == "fileprint") {
   	        		if (value == 0) {
   	        			e.cellStyle = "color:red;text-align:center";
       	        	}
   	        		else {
   	        			e.cellStyle = "color:blue;text-align:center";
   	        		}
    	        }
    	        
            });
        }
	    
	    function setAuth() {
            
        	if (confirm("确定要设置选中的["+showStr+"]的档案访问权限吗？")) {
        		var id = accountid;
        		var value = getCheckedNodes();
        		$.ajax({
	    			async : false,
	    			url : "${pageContext.request.contextPath}/account/setAuth.do",
	    			data: {id:id,value:value},
	    			type : 'post',
	    			dataType : 'text',
	    			success : function(data) {
	    				if (data != null) {
	    					if (data == "success") {
	    						alert("设置帐户的档案访问权限成功。");
	    						tree.selectNode(selectTreeid);
	    					}
	    					else {
	    						alert("设置帐户的档案访问权限失败，请退出重新登录再尝试，或与管理员联系。");
	    					}
	    				}
	    			}
	    		});
        	}
        }
	    
	    function onButtonEdit(e) {
	    	if (selectTempletid == "") {
	    		alert("请正确选择要设置高级权限的档案树节点。");
	    		return;
	    	}
	    	var buttonEdit = e.sender;
	    	//var row = grid.getSelected();
	    	var row = grid.getEditorOwnerRow(buttonEdit);
	    	
	    	mini.open({
	            url: bootPATH + "../common/dispatch.do?page=/view/field/selField",
	            title: "高级记录权限-档案著录属性选择", width: 600, height:500,
	            allowResize:true,
	            onload: function () {
	            	var iframe = this.getIFrameEl();
               	 	var data = {templetid:selectTempletid,tabletype:row.tableType,accountid:'SYSTEM'};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
	            },
	            ondestroy: function (action) {
	            	if (action == "ok") {
	            		var iframe = this.getIFrameEl();
	                    var field_data = iframe.contentWindow.GetData();
	                    field_data = mini.clone(field_data);    //必须
	                    if (field_data != "" || field_data.length > 0) {
	                    	//var row = grid.getEditorOwnerRow(buttonEdit);
	                        grid.cancelEdit();
	                        grid.updateRow(row, {
	                        	fieldname :field_data.chinesename,
	                        	selectField: field_data.englishname
	                        });
	                    }
	                }
	            }
	        });
	    }
	    
	    function checkAll() {
        	var value = getCheckedNodes();
        	var nodes = tree.getAllChildNodes(tree.getRootNode());
        	if (value != "") {
        		tree.uncheckNodes(nodes);
        	}
        	else {
        		tree.checkNodes(nodes);
        	}
        }
	    
	    function getCheckedNodes() {
            var value = tree.getValue(true);
            return value;
        }
	    
	    function addRow(tabletype) {
	    	if (selectTreeid == "") {
       			alert("请先选择左侧的档案类型，再创建高级权限。");
       			return;
       		}
	    	
	    	if (templettype == "") {
	    		alert("未获取到档案类型，请退出后，重新操作。");
	    		return;
	    	}
	    	var newRow = {
	    			tableType: "",
            		fieldname:"",
            		//dataAuthValue:"",
            		selectField:"",
            		oper:"like"
            		};
	    	
	    	if (templettype == "A" || templettype == "P") {
	    		newRow.tableType = tabletype;
	            grid.addRow(newRow, 0);
	            grid.beginEditCell(newRow, "fieldname");
	    	}
	    	else if (templettype == "F") {
	    		newRow.tableType = "01";
	    		grid.addRow(newRow, 0);
	            grid.beginEditCell(newRow, "fieldname");
	    	}
	    	else {
	    		alert("新增发生错误，请退出重新操作一次吧。");
	    		return;
	    	}
	    }
	    
	    function save() {
	    	if (selectTreeid == "") {
       			alert("请先选择左侧的档案类型，再保存高级权限。");
       			return;
       		}
	    	
	    	grid.validate();
	        if (grid.isValid() == false) {
	            alert("输入有误，请校验输入单元格内容");
	            var error = grid.getCellErrors()[0];
	            grid.beginEditCell(error.record, error.column);
	            return;
	        }
	        var objs = grid.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        
	        objs = grid.getData();
	        json = mini.encode(objs);
	        
	        grid.loading("保存中，请稍后......");
	        $.ajax({
	        	async : false,
	            url: "${pageContext.request.contextPath}/account/saveAccountAuth.do",
	            data: {'objs':json,'accountid':accountid,'treeid':selectTreeid},
	            type: "post",
	            success: function (text) {
	            	alert("保存完毕。");
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.responseText);
	            }
	        });
	        grid.unmask();
			grid.accept();
	    }
	    
	    //标准方法接口定义
		function SetData(data) {
	    	accountid = data.accountid;
	    	showStr = data.showStr;
	    	
	    	if (accountid != "") {
	    		var accountfun = "";
	    		//获取选中的角色的功能权限
	        	$.ajax({
	    			async : false,
	    			url : "${pageContext.request.contextPath}/account/getAccountFunTree.do",
	    			data:{accountid:accountid},
	    			type : 'post',
	    			dataType : 'text',
	    			success : function(data) {
	    				if (data != null) {
	    					accountfun = data;
	    				}
	    			}
	    		});
	        	tree.setCheckRecursive(false);
	        	tree.setValue(accountfun);
	        	tree.setCheckRecursive(true);
	    	}
			
		}
	    
	    function setAllOk(ok) {
	    	//更新电子文件权限
        	$.ajax({
    			async : false,
    			url : "${pageContext.request.contextPath}/account/saveAllDocFileAuth.do",
    			data:{isok:ok,accountid:accountid},
    			type : 'post',
    			dataType : 'text',
    			success : function(data) {
    				if (data != null) {
    					if (data == "success") {
    						alert("保存帐户全部电子文件权限成功。");
    					}
    					else {
    						alert("保存帐户全部电子文件权限失败。");
    					}
    				}
    			}
    		});
	    }
	    
	    function setOk() {
	    	var allData = grid_file_auth.getData();
	    	
	    	if (allData.length == 1) {
	    		var row = allData[0];
	    		grid_file_auth.updateRow(row, {
	    			filescan :1,
	    			filedown: 1,
	    			fileprint:1
                });
	    	}
	    }
	    
	    function setNo() {
	    	var allData = grid_file_auth.getData();
	    	
	    	if (allData.length == 1) {
	    		var row = allData[0];
	    		grid_file_auth.updateRow(row, {
	    			filescan :0,
	    			filedown: 0,
	    			fileprint:0
                });
	    	}
	    }
	    
	    function saveDocAuth() {
			var allData = grid_file_auth.getData();
	    	
	    	if (allData.length == 1) {
	    		var row = {};
	    		row.id = allData[0].id;
	    		row.filescan = allData[0].filescan;
	    		row.filedown = allData[0].filedown;
	    		row.fileprint = allData[0].fileprint;
	    		//row.docauth = allData[0].docauth;
	    		
	    		//更新电子文件权限
	        	$.ajax({
	    			async : false,
	    			url : "${pageContext.request.contextPath}/account/saveDocAuth.do",
	    			data:row,
	    			type : 'post',
	    			dataType : 'text',
	    			success : function(data) {
	    				if (data != null) {
	    					alert("保存电子文件权限成功。");
	    				}
	    			}
	    		});
	    	}
	    	grid_file_auth.accept();
	    }
	    
	    function setDocAuth() {
	       	mini.open({
                url: bootPATH + "../common/dispatch.do?page=/view/doc/setDocAuth",
                title: "设置帐户电子全文权限", width:600, height:500,
                allowResize:true,
                onload: function () {
               	 	var iframe = this.getIFrameEl();
               	 	var data = {single:false};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		var iframe = this.getIFrameEl();
	                    var data = iframe.contentWindow.GetData();
	                     
	                    data = mini.clone(data);    //必须
	                    if (data == "" || data.length > 0) {
	                    	var json = mini.encode(data);
	                        if (json.length == 2) {
	                        	return;
	                        }
	                    }
	                    
	                    var allData = grid_file_auth.getData();
	        	    	
	        	    	if (allData.length == 1) {
	        	    		var row = {};
	        	    		row.id = allData[0].id;
	        	    		
        	            	var ids = "";
        	            	var authValue = "";
        	                for (var i=0;i<data.length;i++) {
        	                	ids += data[i].id + ",";
        	                	authValue += data[i].columndata + ",";
        	                }
        	                ids = ids.substring(0,ids.length-1);
        	                authValue = authValue.substring(0,authValue.length-1);
        	                row.docauth = ids;
        	                row.docauthvalue = authValue;
	        	    		
	        	    		//row.filescan = allData[0].filescan;
	        	    		//row.filedown = allData[0].filedown;
	        	    		//row.fileprint = allData[0].fileprint;
	        	    		//row.docauth = allData[0].docauth;
	        	    		
	        	    		//更新电子文件权限
	        	        	$.ajax({
	        	    			async : false,
	        	    			url : "${pageContext.request.contextPath}/account/saveDocAuth.do",
	        	    			data:row,
	        	    			type : 'post',
	        	    			dataType : 'text',
	        	    			success : function(data) {
	        	    				if (data != null) {
	        	    					alert("保存电子文件权限成功。");//未显示出来
	        	    					grid_file_auth.updateRow(allData[0], { docauth: ids, docauthvalue: authValue });
	        	    					grid_file_auth.accept();
	        	    				}
	        	    			}
	        	    		});
	        	    	}
                	}
                }
            });
        }
	    
	    function setAllDocAuth() {
	       	mini.open({
                url: bootPATH + "../common/dispatch.do?page=/view/doc/setDocAuth",
                title: "设置帐户电子全文权限", width:600, height:500,
                allowResize:true,
                onload: function () {
               	 	var iframe = this.getIFrameEl();
               	 	var data = {single:false};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		var iframe = this.getIFrameEl();
	                    var data = iframe.contentWindow.GetData();
	                     
	                    data = mini.clone(data);    //必须
	                    if (data == "" || data.length > 0) {
	                    	var json = mini.encode(data);
	                        if (json.length == 2) {
	                        	return;
	                        }
	                    }
	                    
	                    var ids = "";
    	            	var authValue = "";
    	                for (var i=0;i<data.length;i++) {
    	                	ids += data[i].id + ",";
    	                	authValue += data[i].columndata + ",";
    	                }
    	                ids = ids.substring(0,ids.length-1);
    	                authValue = authValue.substring(0,authValue.length-1);
        	    		
        	    		//更新电子文件权限
        	        	$.ajax({
        	    			async : false,
        	    			url : "${pageContext.request.contextPath}/account/saveAllDocAuth.do",
        	    			data:{docAuthid:ids,docAuthvalue:authValue,accountid:accountid},
        	    			type : 'post',
        	    			dataType : 'text',
        	    			success : function(data) {
        	    				if (data != null) {
        	    					if (data == "success") {
        	    						alert("保存电子文件权限成功。");//未显示出来
        	    					}
        	    					else {
        	    						alert("保存电子文件权限失败。");//未显示出来
        	    					}
        	    				}
        	    			}
        	    		});
                	}
                }
            });
        }
	    
	    function GetData() {
	    	var tree = mini.get("tree1");
            var node = tree.getSelectedNode();
            return node;
	    }
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onOk() {
	    	CloseWindow("ok");
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	
	</script>
    
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
		<div size="360" showCollapseButton="true">
	        <div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
	            <table style="width:100%;">
	                <tbody>
		                <tr>
		                    <td style="width:100%;">
		                    	<span style="padding-left:5px;">档案访问权限</span>
		                    </td>
		                     <td style="white-space:nowrap;">
		                     	<a class="mini-menubutton" plain="true" menu="#all_doc_f">全文权限操作</a>
				                <span class="separator"></span>
			                  	<a class="mini-button" iconCls="icon-expand" plain="true" onclick="checkAll()">全选</a>
		            			<a class="mini-button" iconCls="icon-save" plain="true" onclick="setAuth()">保存</a>
			                 </td>
		                </tr>
		            </tbody>
	            </table>
	            
	        </div>
	        <div class="mini-fit">
	            <ul id="tree1" class="mini-tree" style="width:100%;height:100%"></ul>
	        </div>
	    </div>
		<div showCollapseButton="false" ><!-- style="border-top:0;border-left:0;border-right:0;border-bottom: 1;" -->
			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
	    		<div size="60%" showCollapseButton="false" style="border-width: 1;">
			    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				        <table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">高级权限-记录访问权限</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a id="ajAddbtn" class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('01')"  name="auth">新增案卷级记录权限</a>
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('02')" name="auth">新增文件级记录权限</a>
					                <span class="separator"></span>
					         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save()" name="auth">保存</a>
				                 </td>
				             </tr>
				         </tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>
				</div>
				<div showCollapseButton="true">
	    			<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
			            <table style="width:100%;">
			                <tbody>
				                <tr>
				                    <td style="width:100%;">
				                    	<span id="pid" style="padding-left:5px;">电子全文权限</span>
				                    </td>
				                    <td style="white-space:nowrap;">
				                    	<a class="mini-button" iconCls="icon-ok" plain="true" onclick="setOk()" name="auth">单树节点全部允许</a>
				                    	<a class="mini-button" iconCls="icon-ok" plain="true" onclick="setNo()" name="auth">单树节点全部禁止</a>
				                    	<a class="mini-button" iconCls="icon-save" plain="true" onclick="saveDocAuth()" name="auth">保存</a>
				                    	<span class="separator"></span>
				                    	<a id="downBtn" class="mini-button" iconCls="icon-tip" plain="true" onclick="setDocAuth()"  name="auth">设置权限</a>
				                    </td>
				                </tr>
				            </tbody>
			            </table>
			        </div>
			        <div class="mini-fit">
			            <div id="grid_file_auth" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
			        </div>
	    		</div>
			</div>
		</div>
	</div>
	
	<ul id="all_doc_f" class="mini-menu" style="display:none;">
    	<li onclick="setAllOk(true)" iconCls="icon-ok" >批量全部允许</li>
    	<li onclick="setAllOk(false)" iconCls="icon-ok" >批量全部禁止</li>
    	<li onclick="setAllDocAuth()" iconCls="icon-ok">批量设置权限</li>
    </ul>
</body>
</html>