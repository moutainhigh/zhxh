<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <script src="${pageContext.request.contextPath}/js/js.validate.js" type="text/javascript"></script>
    <style type="text/css">
	    html, body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    
    </style>
    
    <script type="text/javascript">
    
	    var grid_user_a; 			//代理
	    var grid_user_a_bank;		//代理自身资金帐户
	    var grid_user_c_bank;		//代理商下级门店资金帐户
	    
	    var sel_a ="";
	    
	    var columns_1=[
					{ type: "checkcolumn",headerAlign:"center",width: 30},
					{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
					{ field: "action", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
					{ field: "p_companyname",name:"p_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "上级",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "u_companyname",name:"u_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "帐户所有人",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "incomebank",name:"incomebank", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "收入总计(元)",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "costbank",name:"costbank", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "支出总计(元)",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "takenbank",name:"takenbank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "可提现帐户(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "sellbank",name:"sellbank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "平台销售额总计(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "bankstate",name:"bankstate",type:"comboboxcolumn",autoEscape:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"冻结"},{"id":"1","text":"正常"}] } }
     	    ];
	    var columns_a=[
					{ type: "checkcolumn",headerAlign:"center",width: 30},
					{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
					{ field: "action", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer_a",cellStyle:"padding:0;"},
					{ field: "p_companyname",name:"p_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "上级",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "u_companyname",name:"u_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "帐户所有人",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "incomebank",name:"incomebank", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "收入总计(元)",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "costbank",name:"costbank", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "支出总计(元)",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "takenbank",name:"takenbank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "可提现帐户(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "havebank",name:"havebank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "可支配帐户(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "sellbank",name:"sellbank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "平台销售额总计(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "quotabank",name:"quotabank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "配额总计(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "depositbank",name:"depositbank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "充值总计(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "bankstate",name:"bankstate",type:"comboboxcolumn",autoEscape:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"冻结"},{"id":"1","text":"正常"}] } }
     	    ];
	    var columns_c=[
					{ type: "checkcolumn",headerAlign:"center",width: 30},
					{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
					{ field: "action", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer_c",cellStyle:"padding:0;"},
					{ field: "p_companyname",name:"p_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "上级",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "u_companyname",name:"u_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "帐户所有人",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "depositbank",name:"depositbank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "充值总计(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "quotabank",name:"quotabank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "配额总计(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "sellbank",name:"sellbank", width: 130, headerAlign: "center", align:"center",allowSort: false, header: "平台销售额总计(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "selltakenbank",name:"selltakenbank", width: 130, headerAlign: "center", align:"center",allowSort: false, header: "平台销售额可提现(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "havebank",name:"havebank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "可支配帐户(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "rebatesbank",name:"rebatesbank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "返利帐户(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "bonusesbank",name:"bonusesbank", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "奖励帐户(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "bonusestakenbank",name:"bonusestakenbank", width: 130, headerAlign: "center", align:"center",allowSort: false, header: "奖励可提现帐户(元)",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	              { field: "bankstate",name:"bankstate",type:"comboboxcolumn",autoEscape:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"冻结"},{"id":"1","text":"正常"}] } }
     	    ];
	    
	   	$(function(){
	   		mini.parse();
	   		
	   		//隐藏所有按钮
            var j_btns = mini.getsbyName("j_btn");
   			for(var i=0;i<j_btns.length;i++) {
   				j_btns[i].setVisible(false);
   			}
	   		//隐藏所有按钮
            var a_btns = mini.getsbyName("a_btn");
   			for(var i=0;i<a_btns.length;i++) {
   				a_btns[i].setVisible(false);
   			}
	   		
	   		//代理商
	   		grid_user_a = mini.get("grid_user_a");
	    	grid_user_a.set({
	    		url:"${pageContext.request.contextPath}/userManager/list.htmls",
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
	      	                { field: "companycode",name:"companycode",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构代码"},
	      	                { field: "wechar",name:"wechar",width: 80, headerAlign: "center", align:"center",allowSort: false, header: "微信号码" ,editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
	      	                { field: "rank",name:"rank",width: 150, headerAlign: "center", align:"center",allowSort: false, header: "机构级别",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
	      	                { field: "isopen",name:"isopen",type:"comboboxcolumn",autoEscape:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁用"},{"id":"1","text":"正常"}] } },
	      	                { field: "repaystate",name:"repaystate",type:"comboboxcolumn",autoEscape:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "分期状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁用"},{"id":"1","text":"允许"}] } },
	      	                { field: "sort",name:"sort",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25 } }
	      	            ],
		            showFilterRow:false,
		            allowCellSelect:true,
		            allowCellEdit:false,
		            allowCellValid:true,
		            multiSelect:false,
		            allowUnselect:false,
		            showPager:true,
		            onselectionchanged:"onSelectionChanged",
		            oncellvalidation:"onCellValidation", 
		            //oncellcommitedit:"OnCellCommitEdit",
		            //fitColumns:false,
		            editNextOnEnterKey:true,
		            showPageSize:false,
		            pageSize:2000
	        });
	    	grid_user_a.load({parentid:'1',identity:'A'});
	    	
	    	//代理自身资金帐户
	    	grid_user_a_bank = mini.get("grid_user_a_bank");
	    	grid_user_a_bank.set({
	    		url:"${pageContext.request.contextPath}/userBank/listUserBank.htmls",
	    		columns: [
							{ type: "checkcolumn",headerAlign:"center",width: 30},
	      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	      	                { field: "u_companyname",name:"u_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "帐户所有人",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
	      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            oncellvalidation:"onCellValidation", 
	            //oncellcommitedit:"OnCellCommitEdit",
	            editNextOnEnterKey:false,
	            showPageSize:false,
	            pageSize:2000
	        });
	    	
	    	//会员
	    	grid_user_c_bank = mini.get("grid_user_c_bank");
	    	grid_user_c_bank.set({
	    		url:"${pageContext.request.contextPath}/userBank/listUserBank.htmls",
	    		columns: [
							{ type: "checkcolumn",headerAlign:"center",width: 30},
	      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	      	              	{ field: "u_companyname",name:"u_companyname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "帐户所有人",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
	      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            oncellvalidation:"onCellValidation",
	            editNextOnEnterKey:false,
	            showPageSize:false,
	            pageSize:50
	        });
	    	
	    	drawcell();
	    });
	   	
	   	function onActionRenderer(e) {
	   		//alert(e.sender.id);
            var record = e.record;
            var id = record.id;
            var u_companyname = record.u_companyname;
            var s = "";
            s = '  <a class="Edit_Button" href="javascript:showBill(\'' + id + '\',\'' + record.parentid + '\',\'' + record.userid + '\',\'' + u_companyname + '\',\'A1\')" >查看交易流水</a>';
            return s;
        }
	   	function onActionRenderer_a(e) {
	   		//alert(e.sender.id);
            var record = e.record;
            var id = record.id;
            var u_companyname = record.u_companyname;
            var s = "";
            s = '  <a class="Edit_Button" href="javascript:showBill(\'' + id + '\',\'' + record.parentid + '\',\'' + record.userid + '\',\'' + u_companyname + '\',\'A\')" >查看交易流水</a>';
            return s;
        }
	   	function onActionRenderer_c(e) {
	   		//alert(e.sender.id);
            var record = e.record;
            var id = record.id;
            var u_companyname = record.u_companyname;
            var s = "";
            s = '  <a class="Edit_Button" href="javascript:showBill(\'' + id + '\',\'' + record.parentid + '\',\'' + record.userid + '\',\'' + u_companyname + '\',\'C\')" >查看交易流水</a>';
            return s;
        }
	   	
	   	function showBill(id,parentid,userid,username,identity) {
	   		if(id == 'undefined'){
        		parent.parent.layer.msg("未获取到id，请退出重新登录，再尝试。",{icon:6});
				return;
			}
	   		
	   		//获取parentid 和userid
	   		
			var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	   		
	   		var title = "["+username+"]资金帐户流水";
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/bank/showBill",
                title: title, width:pWidth-300, height:pHeight-200,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {bankid:id,parentid:parentid,userid:userid,identity:identity};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		
                    }
                }
            });
	   	}
	   	
	   	
	   	//绘制表格
	    function drawcell() {
       		grid_user_a.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "isopen") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                }
                if (field == "repaystate") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                }
                
            });
       		grid_user_a_bank.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "bankstate") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                }
                
            });
       		grid_user_c_bank.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "bankstate") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                }
                
            });
        }
	   	
	  //查看代理下的本身帐户、下级帐户
        function onSelectionChanged(e) {
            var grid = e.sender;
	       	//处理角色对应的帐户
            var record = grid.getSelected();
            if (typeof(record.id) == "undefined" || record.id == "") {
            	grid_user_a_bank.setData([]);
            	grid_user_a_bank.setTotalCount(0);
            	grid_user_c_bank.setData([]);
            	grid_user_c_bank.setTotalCount(0);
	      		return;
	      	}
            //隐藏所有按钮
            var j_btns = mini.getsbyName("j_btn");
   			for(var i=0;i<j_btns.length;i++) {
   				j_btns[i].setVisible(false);
   			}
            var a_btns = mini.getsbyName("a_btn");
   			for(var i=0;i<a_btns.length;i++) {
   				a_btns[i].setVisible(false);
   			}
            
            if (record) {
            	sel_a = record.id;
            	if (sel_a == "1") {
            		grid_user_a_bank.set({
            	        columns: columns_1
            	    });
            		
            		//打开功能按钮
        	    	var j_btns = mini.getsbyName("j_btn");
           			for(var i=0;i<j_btns.length;i++) {
           				j_btns[i].setVisible(true);
           			}
            		
            	}
            	else {
            		grid_user_a_bank.set({
            	        columns: columns_a
            	    });
            		
            		var a_btns = mini.getsbyName("a_btn");
           			for(var i=0;i<a_btns.length;i++) {
           				a_btns[i].setVisible(true);
           			}
            	}
            	
            	grid_user_c_bank.set({
        	        columns: columns_c
        	    });
            	
            	grid_user_a_bank.load({userid: record.id});
            	grid_user_c_bank.load({parentid: record.id,identity:"C"});
            }
        }
        function onKeyEnter(e) {
        	var sender = e.sender;
        	var gridtype = "";
        	if (sender.id == "key_user_a") {
        		gridtype = "grid_user_a";
        	}
        	else if (sender.id == "key_user_c_bank") {
        		gridtype = "grid_user_c_bank";
        	}
        	else if (sender.id == "key_user_z") {
        		gridtype = "grid_user_z";
        	}
            search(gridtype);
        }

		//搜索
        function search(gridtype) {
        	var tmpGrid;
        	var key;
        	var parentid = "";
        	var identity = "";
      		if (gridtype == "grid_user_a") {
      			tmpGrid = grid_user_a;
      			key = mini.get("key_user_a").getValue();
      			parentid = "1";
      			identity = "A";
      			
      			if (key != "") {
                	var searchmap = {};
                    searchmap.username = key;
                    searchmap.phonenumber = key;
                    searchmap.companyname = key;
                    searchmap.companypath = key;
                    
                    var mapObj = mini.encode(searchmap);
                    tmpGrid.load({parentid:parentid,identity:identity,mapObj: mapObj });
                }
                else {
                	tmpGrid.load({parentid:parentid,identity:identity });
                }
      		}
      		else if (gridtype == "grid_user_c_bank") {
      			tmpGrid = grid_user_c_bank;
      			key = mini.get("key_user_c_bank").getValue();
      			parentid = sel_a;
      			identity = "C";
      			
      			if (key != "") {
                    tmpGrid.load({parentid:parentid,identity:identity,searchKey: key });
                }
                else {
                	tmpGrid.load({parentid:parentid,identity:identity });
                }
      		}
      		else if (gridtype == "grid_user_z") {
      			tmpGrid = grid_user_z;
      			key = mini.get("key_user_z").getValue();
      			parentid = sel_a;
      			identity = "Z";
      		}
            
            if (gridtype == "grid_user_a") {
            	grid_user_a_bank.setData([]);
            	grid_user_a_bank.setTotalCount(0);
            	grid_user_c_bank.setData([]);
            	grid_user_c_bank.setTotalCount(0);
            }
        }
		
        function getSelectGridid(rows) {
        	var ids = "";
            for (var i=0;i<rows.length;i++) {
            	ids += rows[i].id + ",";
            }
            ids = ids.substring(0,ids.length-1);
            return ids;
        }
      	
        function multiple_update(gridtype,field,value) {
			var cf1 = "确定要将选中机构的资金帐户进行批量修改吗?<br><p style='font-size:12px; color:red'>注意：请谨慎操作。</p>";
			
			var tmpGrid = "";
			if (gridtype == "grid_user_a_bank") {
				tmpGrid = grid_user_a_bank;
			}
			else if (gridtype == "grid_user_c_bank") {
				tmpGrid = grid_user_c_bank;
			}
      		
      		var rows = tmpGrid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要批量修改的机构。",{icon:6});
       		 	return;
       	 	}
       	 	
       	 	var ids = getSelectGridid(rows);
       	 	parent.parent.layer.msg(cf1, {
    	 		icon:3
    	 		,time: 0 //不自动关闭
    	  		,btn: ['确认', '取消']
    	  		,yes: function(index){
        	        $.ajax({
        	        	async:false,
        	            url: "${pageContext.request.contextPath}/userBank/multiple_update.htmls",
        	            data: {'ids':ids,"field":field,"value":value},
        	            type: "post",
        	            dataType:"text",
        	            success: function (text) {
        	            	if (text == "success") {
        	            		parent.parent.layer.msg("保存完毕。",{icon:6});
        	            		tmpGrid.reload();
        	            	}
        	            	else {
        	            		parent.parent.layer.msg("批量修改失败。请重新登录再尝试或与开发人员联系。",{icon:5});
        	            	}
        	            	
        	            },
        	            error: function (jqXHR, textStatus, errorThrown) {
        	            	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
        	            }
        	        });
    	  		}
    		});
		}
      //获取利益标准
        function getDisConfig(){
        	var disConfig;
            $.ajax({
        		async:false,
                url:"${pageContext.request.contextPath}/dis/disConfig.htmls",
                //data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	disConfig = json;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           	});
        	return disConfig;
        }
        
        
        function setQuota(gridtype){
        	
        	var tmpGrid = "";
			if (gridtype == "grid_user_a_bank") {
				tmpGrid = grid_user_a_bank;
			}
			else if (gridtype == "grid_user_c_bank") {
				tmpGrid = grid_user_c_bank;
			}
      		
      		var rows = tmpGrid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要配额的机构。",{icon:6});
       		 	return;
       	 	}
       	 	
       	 	if (rows.length > 1) {
       	 		parent.parent.layer.msg("只能选择一家机构进行配额，请重新选择。",{icon:6});
       		 	return;
       	 	}
       	 	var userid = rows[0].userid;
       	 	
       	 	parent.parent.layer.prompt({
   				title: '请输入配额金额，并确认',
   				formType: 0 //prompt风格，支持0-2
   			}, function(amount){
   				
   				if (amount == "") {
   					parent.parent.layer.msg("请输入值。",{icon:5});
   		   			return false;
   				}
   				else if (!isNumber(amount)) {
   					parent.parent.layer.msg("请输入数字。",{icon:5});
   		   			return false;
   				}
   				
   				if (amount < 0) {
   					parent.parent.layer.msg("请输入大约0的数字。",{icon:5});
   		   			return false;
   				}
   				
   				var config = getDisConfig();
   				if(config.quota_up > 0){
   					if(amount > config.quota_up){
   						parent.parent.layer.msg("您设置的配额超过上限，请重新输入",{icon:6});
   						return;
   					}
   				}
   				if(config.quota_down > 0){
   					if(amount < config.quota_down){
   						parent.parent.layer.msg("您设置的配额低于下限，请重新输入",{icon:6});
   						return;
   					}
   				}
   				$.ajax({
   	    			async:false,
   	                url: "${pageContext.request.contextPath}/userBank/setQuota.htmls",
   	                data: {userid:userid,amount:amount},
   	                type: "post",
   	                dataType:"text",
   	                success: function (text) {
   	                	if(text == "success"){
   	                		parent.parent.layer.msg("配额添加成功",{icon:6});
   	                		tmpGrid.reload();
   	                	}else{
   	                		parent.parent.layer.msg("操作失败，请稍后再试！",{icon:6});
   	                	}
   	                },
   	                error: function (jqXHR, textStatus, errorThrown) {
   	                    alert(jqXHR.responseText);
   	                }
   	           	});
   			});
	    }
		
	 	
    </script>
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
   		<div size="50%" showCollapseButton="false" ><!-- style="border-width: 1;" -->
	    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
		        <table style="width:100%;">
		            <tbody>
		             <tr>
		                 <td style="width:100%;">
		                 	<span id="pid" style="padding-left:5px;">代理商列表[点击代理商，显示代理商资金帐户及下级机构的资金帐户]</span>
		                 </td>
		                 <!-- <td style="white-space:nowrap;">
		                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_user_a')">增加</a>
		                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="remove('grid_user_a')">删除</a>
			                <span class="separator"></span>
			                <a class="mini-button" iconCls="icon-reload" plain="true" onclick="initUpdatePass('grid_user_a')">初始化密码</a>
			                <span class="separator"></span>
			         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_user_a')">保存</a>
			         		<span class="separator"></span>
		                 </td> -->
		                 <td style="white-space:nowrap;">
		                    <input id="key_user_a" class="mini-textbox" emptyText="姓名/手机号/机构名称/地址" style="width:250px;" onenter="onKeyEnter"/>
		                    <a class="mini-button" iconCls="icon-search" plain="true" onclick="search('grid_user_a')">查询</a>
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
	        	<div name="shop" title="代理商资金帐户">
	                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
	                	<table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">代理商资金帐户[代理自身的帐户]</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="setQuota('grid_user_a_bank')" name="a_btn">配额</a>
				                 	<a class="mini-button" iconCls="icon-edit" plain="true" onclick="taken()" name="j_btn">提现</a>
					                <!-- <span class="separator"></span>
					                <a class="mini-button" iconCls="icon-reload" plain="true" onclick="initUpdatePass('grid_user_c')">初始化密码</a>
					                <a class="mini-button" plain="true" iconCls="icon-addnew" onclick="setLink()">关联</a>
					                <a class="mini-button" plain="true" iconCls="icon-close" onclick="outLink('grid_user_c')">解除关联</a>
					                <a class="mini-button" iconCls="icon-reload" plain="true" onclick="move('grid_user_c')">移动</a>
					                <span class="separator"></span>
					         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_user_c')">保存</a> -->
					         		<span class="separator"></span>
					         		<a class="mini-menubutton" plain="true" menu="#popupMenu">批量</a>
				                 </td>
				             </tr>
				         	</tbody>
				        </table>
				    </div>
			        <div class="mini-fit" >
				         <div id="grid_user_a_bank" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				    </div>
	            </div>
	            <div name="member" title="代理商下级资金帐户">
	                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
	                	<table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">代理商下级资金帐户</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="setQuota('grid_user_c_bank')" name="j_btn">配额</a>
				                 	<!-- <a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_user_z')" name="">增加</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="remove('grid_user_z')">删除</a>
					                <span class="separator"></span>
					                <a class="mini-button" iconCls="icon-reload" plain="true" onclick="initUpdatePass('grid_user_z')">初始化密码</a>
					                <a class="mini-button" plain="true" iconCls="icon-close" onclick="outLink('grid_user_z')">解除关联</a>
					                <a class="mini-button" iconCls="icon-reload" plain="true" onclick="move('grid_user_z')">移动</a>
					                <span class="separator"></span>
					         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_user_z')">保存</a> -->
					         		<span class="separator"></span>
					         		<a class="mini-menubutton" plain="true" menu="#popupMenu_c">批量</a>
				                 </td>
				                 <td style="white-space:nowrap;">
				                    <input id="key_user_c_bank" class="mini-textbox" emptyText="帐户所有人" style="width:250px;" onenter="onKeyEnter"/>  
				                    <a class="mini-button" iconCls="icon-search" plain="true" onclick="search('grid_user_c_bank')">查询</a>
				                </td>
				             </tr>
				         	</tbody>
				        </table>
				    </div>
			        <div class="mini-fit" >
				         <div id="grid_user_c_bank" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				     </div>
	            </div>
	        </div>
   		</div>
	</div>
	<!--menu-->
    <ul id="popupMenu" class="mini-menu" style="display:none;">
	    <li iconCls="icon-open" onclick="multiple_update('grid_user_a_bank','bankstate','1')">资金帐户[正常]</li>
	    <li class="separator"></li>
	    <li iconCls="icon-remove" onclick="multiple_update('grid_user_a_bank','bankstate','0')">资金帐户[<span style="color:red">冻结</span>]</li>

    </ul>
	<!--menu-->
    <ul id="popupMenu_c" class="mini-menu" style="display:none;">
	    <li iconCls="icon-open" onclick="multiple_update('grid_user_c_bank','bankstate','1')">资金帐户[正常]</li>
	    <li class="separator"></li>
	    <li iconCls="icon-remove" onclick="multiple_update('grid_user_c_bank','bankstate','0')">资金帐户[<span style="color:red">冻结</span>]</li>

    </ul>
</body>
</html>