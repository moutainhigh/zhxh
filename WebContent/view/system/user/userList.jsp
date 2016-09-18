<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <style type="text/css">
	    html, body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    
    </style>
    
    <script type="text/javascript">

	    var grid_user_a; 	//代理
	    var grid_shop;		//店
	    var grid_memeber;	//普通会员
	    
	   	$(function(){
	   		mini.parse();
	   		
	   		grid_user_a = mini.get("grid_user_a");
			grid_user_a.set({
        		url:"${pageContext.request.contextPath}/userManager2/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
      	                { field: "username",name:"username", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "真实姓名",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "phonenumber",name:"phonenumber", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "手机号码",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "birthday",name:"birthday",dateFormat:"yyyy-MM-dd",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "生日",vtype:"required",editor:{ type: "datepicker"} },
      	              	{ field: "sex",name:"sex",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "性别",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"女"},{"id":"1","text":"男"}] } },
      	              	{ field: "identitymemo",name:"identitymemo",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "身份" },
      	                { field: "companyname",name:"companyname",width: 180, headerAlign: "center", align:"center",allowSort: false, header: "机构名称" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "companypath",name:"companypath",width: 180, headerAlign: "center", align:"center",allowSort: false, header: "机构地址" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "companycode",name:"companycode",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构代码" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "wechar",name:"wechar",width: 80, headerAlign: "center", align:"center",allowSort: false, header: "微信号码" ,editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "rank",name:"rank",width: 150, headerAlign: "center", align:"center",allowSort: false, header: "机构级别" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "isopen",name:"isopen",type:"comboboxcolumn",autoEscape:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁用"},{"id":"1","text":"正常"}] } },
      	                { field: "sort",name:"sort",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25 } }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelectionChanged",
	            //fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			grid_user_a.load({ parentid: '1' ,identity:'A'});
	    	
	    	//店
	    	grid_shop = mini.get("grid_shop");
	    	grid_shop.set({
	    		url:"${pageContext.request.contextPath}/userManager/list.htmls",
	    		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
	  	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
	  	              	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
	  	                { field: "phonenumber",name:"phonenumber", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "手机",vtype:"required" ,editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	                { field: "username",name:"username", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "真实姓名",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	              	{ field: "identity",name:"identity",type:"comboboxcolumn", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "身份",editor: { type: "combobox", data:"Userids"} },
	  	            	/* { field: "tuijianid",name:"tuijianid", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "推荐人",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }, */
	  	            	{ field: "companyname",name:"companyname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "机构名称",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	            	{ field: "companycode",name:"companycode", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "机构代码",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	            	{ field: "tuijianman",name:"tuijianman", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "推荐机构",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	            	
	  	            	/* { field: "birthday",name:"birthday", width: 80, headerAlign: "center", align:"center",allowSort: false, dateFormat:"yyyy-MM-dd", header: "生日",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
	  	          		{ field: "sex",name:"sex",type:"comboboxcolumn",autoShowPopup:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "性别",editor: { type: "combobox",data:"Genders"} }, */
	  	          	
	  	                { field: "setreturn",name:"setreturn", type:"comboboxcolumn",width: 80, headerAlign: "center", align:"center",allowSort: false, header: "接收分成",editor: { type: "combobox", data:"Setreturn"} }
	  	          		
	  	          	
	  	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            //onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            editNextOnEnterKey:false,
	            showPageSize:false,
	            pageSize:50
	        });
	    	
	    	//会员
	    	grid_member = mini.get("grid_member");
	    	grid_member.set({
	    		url:"${pageContext.request.contextPath}/userManager/list.htmls",
	    		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
	  	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
	  	              	{ field: "phonenumber",name:"phonenumber", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "手机",vtype:"required" ,editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	                { field: "username",name:"username", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "真实姓名",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	              	{ field: "identity",name:"identity",type:"comboboxcolumn", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "身份",editor: { type: "combobox", data:"Userids"} },
	  	            	/* { field: "tuijianid",name:"tuijianid", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "推荐人",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	            	{ field: "companyname",name:"companyname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "机构名称",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	            	{ field: "companycode",name:"companycode", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "机构代码",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	            	 */
	  	            	{ field: "birthday",name:"birthday", width: 80, headerAlign: "center", align:"center",allowSort: false, dateFormat:"yyyy-MM-dd", header: "生日",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
	  	          		{ field: "sex",name:"sex",type:"comboboxcolumn",autoShowPopup:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "性别",editor: { type: "combobox",data:"Genders"} }
	  	          	
	  	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            //onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            editNextOnEnterKey:false,
	            showPageSize:false,
	            pageSize:50
	        });
	    	
	    	drawcell();
	    });
	   	
	   	
	   	//绘制表格
	    function drawcell() {
       		grid_user_a.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "password") {
   	        		if (value == "") {
   	        			e.cellhtml = "";
       	        	}else {
   	        			e.cellStyle = "color:red;text-align:center";
   	        			e.cellHtml = "********";
   	        		}
    	        }else if(field == "tuijianid"){
    	        	if(value != "" && value != undefined){
    	        		e.cellHtml = "<a href='javascript:referrer("+uid+")'>查看推荐人</a>";
    	        	}
    	        }
            });
        }
	   	
	    function addRow(grid_type) {
			var tmpGrid;
			var newRow = {};
			newRow.username = "";
			newRow.phonenumber = "";
			newRow.setreturn = "0";
			newRow.isopen = "0";
			newRow.password = "123456";
			newRow.sex = "0";
			newRow.birthday = "1980-01-01";
			newRow.companyname = "";
			newRow.companypath = "";
			newRow.wechar = "";
			newRow.rank = "";
			
			if (grid_type == "grid_user_a") {
				tmpGrid = grid_user_a;
				newRow.identity = "A";
				newRow.identitymemo = "代理";
				newRow.companycode = "";
			}
			else if (grid_type == "grid_product") {
				tmpGrid = grid_product;
				
				var rows = grid_brand.getSelecteds();
				var brandid = "";
	       	 	if (rows.length == 0) {
	       	 		parent.parent.layer.msg("请选择要添加商品的所属品牌.",{icon:6});
	       		 	return;
	       	 	}
	       	 	else {
	       	 		if (typeof(rows[0].id) == "undefined" || rows[0].id == "") {
	       	 			parent.parent.layer.msg("当前品牌还没有保存。请先保存品牌后再创建商品.",{icon:6});
	       	 			return;
	       	 		}
	       	 		else {
	       	 			brandid = rows[0].id;
	       	 		}
	       	 	}
	       	 	
	       	 	newRow.productpic = "";
	       	 	newRow.brandid = brandid;
				newRow.productname = "新的商品";
				newRow.productcode = "";
				newRow.showtype = "1";
				newRow.isshow = "1";
				newRow.productmemo = "";
				
				newRow.ifdis = "0";
				newRow.sort = 1;
				
				var now = new Date();
	            var nowDate = now.getFullYear()+"-"+((now.getMonth()+1)<10?"0":"")+(now.getMonth()+1)+"-"+(now.getDate()<10?"0":"")+now.getDate();
		    	newRow.createdate = nowDate;
				
				editField = "productname";
			}
			else if (grid_type == "grid_product_size") {
				tmpGrid = grid_product_size;
				
				var rows = grid_product.getSelecteds();
				var productid = "";
				var brandid = "";
	       	 	if (rows.length == 0) {
	       	 		parent.parent.layer.msg("请选择要添加商品规格的所属商品.",{icon:6});
	       		 	return;
	       	 	}
	       	 	else {
	       	 		if (typeof(rows[0].id) == "undefined" || rows[0].id == "") {
	       	 			parent.parent.layer.msg("当前商品还没有保存。请先保存或刷新商品后再创建商品规格.",{icon:6});
	       	 			return;
	       	 		}
	       	 		else {
	       	 			productid = rows[0].id;
	       	 			brandid = rows[0].brandid;
	       	 		}
	       	 	}
	       	 	newRow.brandid = brandid;
				newRow.productid = productid;
				newRow.productsize = "新的商品规格";
				newRow.price = "0";
				newRow.saleprice = "0";
				newRow.isshow = "0";
				newRow.sizesort = "1";
				newRow.productpic = "";
				newRow.productname = rows[0].productname;
				newRow.showtype = "1";
				newRow.productmemo = "";
				newRow.linkids = "";
				
				editField = "productname";
			}
			
            tmpGrid.addRow(newRow, 0);
            tmpGrid.beginEditCell(newRow, "username");
        }
	   	
	   	//添加
	    function add() {
	    	mini.open({
	    	    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/userEdit",
	    	    title: "会员管理", width: 800, height: 500,
	    	    onload: function () {
	    	        var iframe = this.getIFrameEl();
	    	        var data = { action: "add",identity:"A"};
	    	        iframe.contentWindow.SetData(data);
	    	    },
	    	    ondestroy: function (action) {
	    	        grid_user_a.reload();
	    	    }
	    	});
		}
	    
	    //修改
        function edit() {
            var row = grid_user_a.getSelected();	//所选行 单行
            var rows = grid_user_a.getSelecteds();	//所选行数 多行
            if (rows.length == 1) {
                mini.open({
                	url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/userEdit",
                    title: "会员管理", width: 800, height: 560,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { action: "update", row: row };
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                        grid_user_a.reload();
                    }
                });
                
            } else {
                parent.parent.layer.msg("请选中一条记录",{icon:6});
            }
            
        }
        
        //删除
        function remove() {
            var rows = grid_user_a.getSelecteds();
            if (rows.length > 0) {
            	var cf1 = "确定要删除选中的数据吗？<br><p style='font-size:12px; color:red'>注意：删除后，不可恢复，请谨慎操作.</p>";
            	parent.parent.layer.msg(cf1, {
    	 	 		icon:3
    	 	 		,time: 0 //不自动关闭
    	 	  		,btn: ['确认删除', '取消']
    	 	  		,yes: function(index){
    	 	    		var ids = [];
                        for (var i = 0, l = rows.length; i < l; i++) {
                            var r = rows[i];
                            if(r.id != "1"){ //平台账户不允许删除
                            	ids.push(r.id);
                            }
                        }
                        var id = ids.join(',');
                        grid_user_a.loading("操作中，请稍后......");
                        $.ajax({
                        	url: "${pageContext.request.contextPath}/userManager/delete.htmls?id=" +id,
                            dataType:"text",
                            success: function (text) {
                                grid_user_a.reload();
                            },
                            error: function () {
                            }
                        });
                        
                        parent.parent.layer.close(index);
    	 	  		}
    	 		});
            } else {
            	parent.parent.layer.msg("请选中一条记录",{icon:6});
            }
        }
        
        //搜索
        function search() {
            var key = mini.get("key").getValue();
            grid_user_a.load({ identity:'A',mobile: key });
        }
        function onKeyEnter(e) {
            search();
        }
        
        //查看代理下的店、会员
        function onSelectionChanged(e) {
            var grid = e.sender;
	       	//处理角色对应的帐户
            var record = grid.getSelected();
            if (typeof(record.id) == "undefined" || record.id == "") {
            	grid_shop.setData([]);
            	grid_shop.setTotalCount(0);
            	grid_member.setData([]);
            	grid_member.setTotalCount(0);
	      		return;
	      	}
            if (record) {
            	grid_shop.load({identity:"A" , parentid: record.id });
            	grid_member.load({identity:"Z" , belongcode: record.companycode });
            }
        }
        
        //操作
        function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
           	var id = record.id;
           	var s = "";
           	if(grid.id == "grid_user_a"){
           		//s = ' <a class="Edit_Button" href="javascript:addShop(\''+id+'\')" >添加店</a>';
           	}else if(grid.id == "grid_shop"){
           		s = ' <a class="Edit_Button" href="javascript:move(\''+id+'\')" >移动</a>';
           		s += ' <a class="Edit_Button" href="javascript:addRecommendShop(\''+id+'\',\''+record.username+'\')" >推荐店</a>';
           	}
            
            return s;
        }
        
        //把店移动到其它代理或平台下面
        function move(id) {
        	var agent_row = grid_user_a.getSelected();	//代理
	        mini.open({
	        	url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/selectAgent",
	            title: "机构列表", width: 800, height: 500,
	            onload: function () {
	            },
	            ondestroy: function (action) {
	            	if(action == 'ok'){
	            		 var iframe = this.getIFrameEl();
	                     var row = iframe.contentWindow.GetData(); //选择的机构
	                     $.ajax({
	                         url: "${pageContext.request.contextPath}/userManager/upParent.htmls",
	                         data: {'userid':id,'oldparentid':agent_row.id,'newparentid':row.id},
	                         type: "post",
	                         dataType:"text",
	                         success: function (text) {
	                        	 if(text == 'success'){
	                        		 parent.parent.layer.msg("操作成功",{icon:6});
	                        		 grid_shop.reload();
	                        	 }else{
	                        		 parent.parent.layer.msg("操作失败,请重新操作或联系管理员",{icon:2});
	                        	 }
	                         },
	                         error: function (jqXHR, textStatus, errorThrown) {
	                             alert(jqXHR.responseText);
	                         }
	                     });
	            	}
	            }
	        });
        }
        
        //给代理添加店,建立关联关系和账户
        function setLink(){
        	var row = grid_user_a.getSelected();		//所选行 单行
        	var rows = grid_user_a.getSelecteds();	//所选行数 多行
            if (rows.length == 1) {
                mini.open({
                	url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/selectShop",
                    title: "查找店", width: 800, height: 500,
                    onload: function () {
                        /* var iframe = this.getIFrameEl();
                        var data = { action: "update", row: row };
                        iframe.contentWindow.SetData(data); */
                    },
                    ondestroy: function (action) {
                    	if (action == "ok") {
                            var iframe = this.getIFrameEl();
                            var data = iframe.contentWindow.GetData();
                            data = mini.clone(data);    //必须
    						if (data) {
    							$.ajax({
    				                url: "${pageContext.request.contextPath}/userManager/createlink.htmls",
    				                data: {'userid':data.id,'parentid':row.id},
    				                type: "post",
    				                dataType:"text",
    				                success: function (text) {
	    				               	if(text != 'error'){
	    				               		if(text == "1"){
	    				               			parent.parent.layer.msg("操作成功",{icon:6});
	    				               			grid_shop.reload();
	    				               		}else if(text == "0"){
	    				               			parent.parent.layer.msg("操作失败，请重新操作",{icon:6});
	    				               		}else{
	    				               			parent.parent.layer.msg("已存在关联关系",{icon:6});
	    				               		}
	    				               	}else{
	    				               		parent.parent.layer.msg("操作失败！",{icon:6});
	    				               	}
    				                },
    				                error: function (jqXHR, textStatus, errorThrown) {
    				                	parent.parent.layer.msg(jqXHR.responseText);
    				                }
    				            }); 
                            }
                        }
                    }
                });
                
            } else {
                parent.parent.layer.msg("请选中一条记录",{icon:6});
            }
        }
        
      	//给代理添加店
	    function addShop() {
	    	var row = grid_user_a.getSelected();		//所选行 单行
        	var rows = grid_user_a.getSelecteds();	//所选行数 多行
            if (rows.length == 1) {
            	mini.open({
    	    	    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/userEdit",
    	    	    title: "会员管理", width: 800, height: 560,
    	    	    onload: function () {
    	    	        var iframe = this.getIFrameEl();
    	    	        var data = { action: "add",method:"addshop",identity:"C",parentid:row.id,pname:row.username};
    	    	        iframe.contentWindow.SetData(data);
    	    	    },
    	    	    ondestroy: function (action) {
    	    	        grid_user_a.reload();
    	    	    }
    	    	});
            }else{
            	parent.parent.layer.msg("请选择一条记录",{icon:6});
            }
		}
		
		//添加推荐店 
		function addRecommendShop(tuijianid,tuijianman) {
			var agent_row = grid_user_a.getSelected();	//代理
	    	mini.open({
	    	    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/userEdit",
	    	    title: "会员管理", width: 800, height: 560,
	    	    onload: function () {
	    	        var iframe = this.getIFrameEl();
	    	        var data = { action: "add",method:"recommend",identity:"C",tuijianid:tuijianid,tuijianman:tuijianman,parentid:agent_row.id,pname:agent_row.username};
	    	        iframe.contentWindow.SetData(data);
	    	    },
	    	    ondestroy: function (action) {
	    	        grid_shop.reload();
	    	    }
	    	});
		}
    </script>
</head>
<body>
	<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" borderStyle="padding:0;border:0;">
		<div name="user_a" title="代理商列表">
			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
		   		<div size="50%" showCollapseButton="false" ><!-- style="border-width: 1;" -->
			    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
				        <table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">代理商列表</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_user_a')">增加</a>
		                    		<a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
					                <span class="separator"></span>
					         		<!-- <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brand')">保存</a> -->
				                 </td>
				                 <td style="white-space:nowrap;">
				                    <input id="key" class="mini-textbox" emptyText="请输入手机号" style="width:150px;" onenter="onKeyEnter"/>   
				                    <a class="mini-button mini-button-plain" href="javascript:search()"><span class="mini-button-text  mini-button-icon-text "><span class="mini-button-icon mini-iconfont icon-search" style=""></span>查询</span></a>
				                </td>
				             </tr>
				         	</tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid_user_a" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>
				</div>
				<div showCollapseButton="true">
		   			<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" borderStyle="padding:0;border:0;">
			        	<div name="shop" title="店-美容院">
			                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
					    		 <a class="mini-button" plain="true" iconCls="icon-addnew" onclick="setLink()">关联</a>
					    		 <a class="mini-button" plain="true" iconCls="icon-add" onclick="addShop()">添加店</a>
						     </div>
					        <div class="mini-fit" >
						         <div id="grid_shop" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
						    </div>
			            </div>
			            <div name="member" title="普通会员">
			                <!-- <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
						         <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="addRow()">新增</a>
						         <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandfirst')">删除</a>
						         <span class="separator"></span>
						         <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('meter')">保存</a>
						         <span class="separator"></span>
						     </div> -->
					        <div class="mini-fit" >
						         <div id="grid_member" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
						     </div>
			            </div>
			        </div>
		   		</div>
			</div>
		</div>
		<div name="user_c" title="代理商列表">
			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
		   		<div size="50%" showCollapseButton="false" ><!-- style="border-width: 1;" -->
			    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
				        <table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">直营店列表</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="add()">增加</a>
		                    		<a class="mini-button" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
					                <span class="separator"></span>
					         		<!-- <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brand')">保存</a> -->
				                 </td>
				                 <td style="white-space:nowrap;">
				                    <input id="key" class="mini-textbox" emptyText="请输入手机号" style="width:150px;" onenter="onKeyEnter"/>   
				                    <a class="mini-button mini-button-plain" href="javascript:search()"><span class="mini-button-text  mini-button-icon-text "><span class="mini-button-icon mini-iconfont icon-search" style=""></span>查询</span></a>
				                </td>
				             </tr>
				         	</tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid_shop" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>
				</div>
				<div showCollapseButton="true">
		   			<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" borderStyle="padding:0;border:0;">
			            <div name="member" title="会员">
			                <!-- <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
						         <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="addRow()">新增</a>
						         <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandfirst')">删除</a>
						         <span class="separator"></span>
						         <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('meter')">保存</a>
						         <span class="separator"></span>
						     </div> -->
					        <div class="mini-fit" >
						         <div id="grid_member" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
						     </div>
			            </div>
			        </div>
		   		</div>
			</div>
		</div>
	</div>

</body>
</html>