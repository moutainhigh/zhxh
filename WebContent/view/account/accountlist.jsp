<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }
    </style>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    
<script type="text/javascript">

		var grid;
		
		var parentid;
		
		var tree;
		var tree2;
		var selectTreeid="";
		var selectTreecode = "";
		
		var select_templet_type = "";
		
		var roleArr = [];
		//标准方法接口定义
		function SetData(data) {
			parentid = data.parentid;
		}
		
       	$(function(){
       		//mini.parse();
       		//获取角色对象组
       		var role = {};
       		role.id = "";
       		role.text = "";
       		roleArr.push(role);
       		$.ajax({
    			async : false,
    			url : "${pageContext.request.contextPath}/role/getRole.do",
    			//data: {obj:mini.encode(data)},
    			//data: data,
    			type : 'post',
    			dataType : 'text',
    			success : function(data) {
    				if (data != null) {
    					var myobj=eval(data);
	    				for(var i=0;i<myobj.length;i++){
	    					var role = {};
	    					role.id = myobj[i].id;
	    					role.text = myobj[i].rolename;
	    					roleArr.push(role);
	    				}
    				}
    			}
    		});
       		
       		tree = mini.get("tree1");
       		var url = "${pageContext.request.contextPath}/org/getOrgTree.do";
       		
       		tree.set({
       			expandOnLoad:0,
       			showTreeIcon:true,
       			textField:"text",
       			idField:"id",
       			parentField:"parentid",
       			resultAsTree:false,
       			imgPath:"${pageContext.request.contextPath}/images/tree/"
       		});
       		tree.load(url);
    		
    		tree.on("nodeselect", function (e) {
    			selectTreeid = e.node.id;
            	selectTreecode = e.node.text;
            	grid.load({ orgid: selectTreeid});
    	       	drawcell();
            });
    		
    		tree2 = mini.get("tree2");
       		var url = "${pageContext.request.contextPath}/tree/getTree.do";
       		
       		tree2.set({
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
       		tree2.load(url);
       		
			grid = mini.get("grid");
        	grid.set({
        		url:"${pageContext.request.contextPath}/account/list.do",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	              	{ field: "action", width: 140, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	                { field: "accountcode",name:"accountcode", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "帐户名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "accountname",name:"accountname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "帐户真实姓名",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "accountstate",name:"accountstate",type:"comboboxcolumn",autoShowPopup:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁用"},{"id":"1","text":"允许"}]} },
      	              	{ field: "roleid",name:"roleid",type:"comboboxcolumn",autoShowPopup:true,width: 150, headerAlign: "center", align:"center",allowSort: false, header: "帐户角色", editor: { type: "combobox", data: roleArr}},
      	              	{ field: "accountmemo",name:"accountmemo", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "备注",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	
        	//drawcell();
        	
        })
        
        function drawcell() {
       		grid.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "accountstate") {
   	        		if (value == 0) {
   	        			e.cellStyle = "color:red;text-align:center";
       	        	}
    	        }
                
            });
        }
       	
       	function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var uid = record._uid;
            var rowIndex = e.rowIndex;
            
            var s = "";
            
       	 	s += '<a class="Edit_Button" href="javascript:setRow(\'' + uid + '\')" >高级访问权限</a>';
            return s;
           
        }
       	
		function addRow() {
       		
       		if (selectTreeid == "") {
       			alert("请先选择左侧的组织结构，再创建帐户。");
       			return;
       		}
            var newRow = {
            		accountcode: "",
            		accountname:"",
            		accountstate:1,
            		accountmemo:'',
            		orgid:selectTreeid,
            		roleid:""
            		};
            grid.addRow(newRow, 0);
            grid.beginEditCell(newRow, "accountcode");
        }
		
		function delRow() {
        	var cf1 = "确定要删除选中的帐户吗？注意：不可恢复，请谨慎操作。";
        	
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		alert("请选择要删除的帐户.");
       		 	return;
       	 	}
       	 	var del_row = [];
       	 	for (var i=0;i<rows.length;i++) {
       	 		if (rows[i].id != 1) {
       	 			del_row.push(rows[i]);
       	 		}
       	 	}
       	 
          	if (confirm(cf1)) {
          		grid.removeRows(del_row, false);
   		 	}
			
        }
       	
		function save() {
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
	        
	        grid.loading("保存中，请稍后......");
	        $.ajax({
	            url: "${pageContext.request.contextPath}/account/save.do",
	            data: {'objs':json},
	            type: "post",
	            success: function (text) {
	            	alert("保存完毕。");
	            	grid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.responseText);
	            }
	        });
	    }
		
		function getSelectGridid(rows) {
        	var ids = "";
            for (var i=0;i<rows.length;i++) {
            	ids += rows[i].id + ",";
            }
            ids = ids.substring(0,ids.length-1);
            return ids;
        }
		
		function moveRow() {
			var rows = grid.getSelecteds();
         	 
       	 	if (rows.length == 0) {
       	 		alert("请选择要移动的帐户.");
       		 	return;
       	 	}
       	 	
       	 	var ids = getSelectGridid(rows);
       	 	
       	 	var pHeight = $(window.parent).height();
       		var pWidth = $(window.parent).width();
       	 	
			mini.open({
                url: bootPATH + "../common/dispatch.do?page=/view/org/selectOrg",
                title: "移动帐户", width:400, height:pHeight-100,
                allowResize:true,
                onload: function () {
               	 	var iframe = this.getIFrameEl();
               	 	var data = {action:"",isSelLeaf:true,ifNoSelParent:false,parentid:""};
                    //var data = rows[0];
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
	                    
	                    grid.loading("保存中，请稍后......");
	    		        $.ajax({
	    		            url: "${pageContext.request.contextPath}/account/movesave.do",
	    		            data: {'id':ids,'targetid':data.id},
	    		            type: "post",
	    		            success: function (text) {
	    		            	alert("移动完毕。");
	    		            	
	    		            	grid.reload();
	    		            },
	    		            error: function (jqXHR, textStatus, errorThrown) {
	    		                alert(jqXHR.responseText);
	    		            }
	    		        });
                	}
                }
            });
		}
		
		function onSelectionChanged(e) {
	        var tree2 = mini.get("tree2");
            var grid = e.sender;
            //var record = grid.getSelected();
	      	
            var rows = grid.getSelecteds();
            if (rows.length == 1) {
            	if (typeof(rows[0].id) == "undefined" || rows[0].id == "") {
                    tree2.setValue("");
    	      		return;
    	      	}
            	var showStr = rows[0].accountname;
            	if (typeof(showStr) == "undefined" || showStr == "") {
            		showStr = rows[0].accountcode;
            	}
            	setTreeValue(rows[0].id,showStr);
            }
            else {
                var nodes = tree2.getAllChildNodes(tree2.getRootNode());
                tree2.uncheckNodes(nodes);
                $("#pid2").html("档案访问权限");
            }
        }
		
		function setTreeValue(accountid,accountname) {
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
        	//checkNodes			
			tree2.setCheckRecursive(false);
        	tree2.setValue(accountfun);
        	tree2.setCheckRecursive(true);
        	if (accountname.length > 8) {
        		accountname = accountname.substring(0,8) + "..";
        	}
        	$("#pid2").html("[" + accountname + "]档案访问权限");
		}
		
		function getCheckedNodes() {
            var tree2 = mini.get("tree2");
            var value = tree2.getValue(true);
            return value;
        }
        
        function checkAll() {
        	var tree2 = mini.get("tree2");
        	var value = getCheckedNodes();
        	var nodes = tree2.getAllChildNodes(tree2.getRootNode());
        	if (value != "") {
        		tree2.uncheckNodes(nodes);
        	}
        	else {
        		tree2.checkNodes(nodes);
        	}
        }
        
        function getCheckedNodes() {
            var tree2 = mini.get("tree2");
            var value = tree2.getValue(true);
            return value;
        }
        
        function setAuth() {
        	var rows = grid.getSelecteds();
            if (rows.length != 1) {
                alert("需要选中一个帐户，再赋予档案访问的权限。")
                return;
            }
            var showStr = rows[0].accountname;
        	if (typeof(showStr) == "undefined" || showStr == "") {
        		showStr = rows[0].accountcode;
        	}
        	if (confirm("确定要设置选中的["+showStr+"]的档案访问权限吗？")) {
        		var id = rows[0].id;
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
	    					}
	    					else {
	    						alert("设置帐户的档案访问权限失败，请退出重新登录再尝试，或与管理员联系。");
	    					}
	    				}
	    			}
	    		});
        	}
        }
        
        function setRow(uid) {
			var row = grid.getRowByUID(uid);
       	 	//var node = tree.getNode(row.id);
       	 	
       	 	if (typeof(row.id) == "undefined" || row.id == "") {
				alert("当前要设置高级访问权限的帐户，还没有保存，请先保存或刷新。");
	        	return;
            }
       	 	
       	 	grid.reject();
			grid.accept();
			
			var showStr = row.accountname;
        	if (typeof(showStr) == "undefined" || showStr == "") {
        		showStr = row.accountcode;
        	}
       	 	
			var title = "设置[" + showStr + "]高级访问权限";
       	 	var pHeight = $(window.parent).height();
       		var pWidth = $(window.parent).width();
       	 	
			mini.open({
                url: bootPATH + "../common/dispatch.do?page=/view/account/setAuth",
                title: title, width:pWidth - 200, height:pHeight-100,
                allowResize:true,
                showMaxButton:true,
                onload: function () {
               	 	var iframe = this.getIFrameEl();
               	 	var data = {accountid:row.id,showStr:showStr};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	setTreeValue(row.id,showStr);
                }
            });
		}
</script>
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
		<div size="100%" showCollapseButton="false">
			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
				<div size="260" showCollapseButton="true">
			        <div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
			            <table style="width:100%;">
			                <tbody>
				                <tr>
				                    <td style="width:100%;">
				                    	<span style="padding-left:5px;">组织机构树</span>
				                    </td>
				                </tr>
				            </tbody>
			            </table>
			            
			        </div>
			        <div class="mini-fit">
			            <ul id="tree1" class="mini-tree" style="width:100%;height:100%"></ul>
		<!-- 	            <ul id="tree1" class="mini-tree" style="width:100%;height:100%"
			                expandOnLoad="0" showTreeIcon="true" textField="text" idField="id" parentField="parentid" resultAsTree="false">
			            </ul> -->
			        </div>
			    </div>
				<div showCollapseButton="false" >
			    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				        <table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">帐户列表</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow()">新增</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow()">删除</a>
				                 	<a class="mini-button" iconCls="icon-reload" plain="true" onclick="moveRow()">移动</a>
					                <span class="separator"></span>
					         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save()">保存</a>
				                 </td>
				             </tr>
				         </tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>
				</div>
			</div>
		</div>
		<div size="300" showCollapseButton="true" >
	    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
		        <table style="width:100%;">
		            <tbody>
		             <tr>
		                 <td style="width:100%;">
		                 	<span id="pid2" style="padding-left:5px;">档案访问权限</span>
		                 </td>
		                 <td style="white-space:nowrap;">
			                  <a class="mini-button" iconCls="icon-expand" plain="true" onclick="checkAll()">全选</a> 
	            			<a class="mini-button" iconCls="icon-save" plain="true" onclick="setAuth()">保存</a>
		                 </td>
		             </tr>
		         </tbody>
		        </table>
		    </div>
		    <div class="mini-fit">
		        <ul id="tree2" class="mini-tree" style="width:100%;height:100%"></ul>
		    </div>
		</div>
	</div>
	
</body>
</html>