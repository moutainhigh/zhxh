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
    
	    var grid_user_a; 			//代理
	    var grid_user_a_bank;		//代理自身资金帐户
	    var grid_user_c_bank;		//代理商下级门店资金帐户
	    
	    var sel_a ="";
	    
	    var columns_1=[
					{ type: "checkcolumn",headerAlign:"center",width: 30},
					{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
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
            var taken_1_btns = mini.getsbyName("taken_1_btn");
   			for(var i=0;i<taken_1_btns.length;i++) {
   				taken_1_btns[i].setVisible(false);
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
	      	                { field: "username",name:"username", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "真实姓名",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	      	                { field: "phonenumber",name:"phonenumber", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "手机号码",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	      	              	{ field: "birthday",name:"birthday",dateFormat:"yyyy-MM-dd",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "生日",vtype:"required",editor:{ type: "datepicker"} },
	      	              	{ field: "sex",name:"sex",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "性别",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"女"},{"id":"1","text":"男"}] } },
	      	              	{ field: "identitymemo",name:"identitymemo",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "身份" },
	      	                { field: "belongcode",name:"belongcode",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "所属门店代码"},
	      	                { field: "wechar",name:"wechar",width: 80, headerAlign: "center", align:"center",allowSort: false, header: "微信号码" ,editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
	      	                { field: "isopen",name:"isopen",type:"comboboxcolumn",autoEscape:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁用"},{"id":"1","text":"正常"}] } },
	      	                { field: "sort",name:"sort",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25 } }
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
            var taken_1_btns = mini.getsbyName("taken_1_btn");
   			for(var i=0;i<taken_1_btns.length;i++) {
   				taken_1_btns[i].setVisible(false);
   			}
            
            if (record) {
            	sel_a = record.id;
            	if (sel_a == "1") {
            		grid_user_a_bank.set({
            	        columns: columns_1
            	    });
            		
            		//打开功能按钮
        	    	var taken_1_btns = mini.getsbyName("taken_1_btn");
           			for(var i=0;i<taken_1_btns.length;i++) {
           				taken_1_btns[i].setVisible(true);
           			}
            		
            	}
            	else {
            		grid_user_a_bank.set({
            	        columns: columns_a
            	    });
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
        //平台充值或提现
        function takenbank_1(taken_type) {
        	
        }
		
		
		
	   	
	   	/*----------------以下不确定要--------------*/
	   	
	   	
	   	
	   	
	   	
	   	
	   	
	    function onButtonEdit(e) {
            var buttonEdit = e.sender;
        	var record = grid_user_c.getEditorOwnerRow(buttonEdit);
        	
        	var rows = grid_user_a.getSelecteds();
			var parentid = "";
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择代理.",{icon:6});
       		 	return;
       	 	}
       	 	parentid = rows[0].id;
       	 	
            mini.open({
            	url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/selectUser",
                title: "选择推荐人", width: 800, height: 500,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {parentid:parentid,identity: "C",multiSelect:false};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                        var iframe = this.getIFrameEl();
                        var rows = iframe.contentWindow.GetData();
                        
                        if (rows != null && rows.length == 1) {
                        	if (record.id == rows[0].id) {
                        		parent.parent.layer.msg("不允许自己推荐自己，如有疑问请与开发商联系。",{icon:6});
                        		return;
                        	}
                        	var tuijianid = rows[0].id;
                        	var tuijianman = rows[0].companyname;
                        	grid_user_c.updateRow(record, { tuijianid: tuijianid,tuijianman:tuijianman});
                        	grid_user_c.cancelEdit();
                        }
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
			newRow.sort = 1;
			newRow.repaystate = 0;
			
			if (grid_type == "grid_user_a") {
				tmpGrid = grid_user_a;
				newRow.identity = "A";
				newRow.identitymemo = "代理";
				newRow.companycode = "";
				newRow.parentid = "1";
			}
			else if (grid_type == "grid_user_c") {
				tmpGrid = grid_user_c;
				
				var rows = grid_user_a.getSelecteds();
				var parentid = "";
	       	 	if (rows.length == 0) {
	       	 		parent.parent.layer.msg("请选择要添加门店的所属代理.",{icon:6});
	       		 	return;
	       	 	}
	       	 	else {
	       	 		if (typeof(rows[0].id) == "undefined" || rows[0].id == "") {
	       	 			parent.parent.layer.msg("当前代理还没有保存。请先保存后再创建.",{icon:6});
	       	 			return;
	       	 		}
	       	 		else {
	       	 			parentid = rows[0].id;
	       	 		}
	       	 	}
	       	 	newRow.identity = "C";
				newRow.identitymemo = "门店";
				newRow.companycode = "";
				newRow.parentid = parentid;
				newRow.setreturn = 0;
	       	 	
			}
			else if (grid_type == "grid_user_z") {
				tmpGrid = grid_user_z;
				
				var rows = grid_user_a.getSelecteds();
				var companycode = "";
	       	 	if (rows.length == 0) {
	       	 		parent.parent.layer.msg("请选择要添加普通会员的所属代理.",{icon:6});
	       		 	return;
	       	 	}
	       	 	else {
	       	 		if (typeof(rows[0].id) == "undefined" || rows[0].id == "") {
	       	 			parent.parent.layer.msg("当前代理还没有保存。请先保存后再创建.",{icon:6});
	       	 			return;
	       	 		}
	       	 		else {
	       	 		companycode = rows[0].companycode;
	       	 		}
	       	 	}
	       	 	newRow.identity = "Z";
				newRow.identitymemo = "普通会员";
				newRow.belongcode = companycode;
				
			}
			
            tmpGrid.addRow(newRow, 0);
            tmpGrid.beginEditCell(newRow, "username");
        }
	    
	    function trim(str){
			//删除字符串2端空格
			return str.replace(/(^\s*)|(\s*$)/g, "");
		}
	    
	    function validatemobile(mobile) {
			if (trim(mobile) == "") {
		        return false; 
		    }     
		    if(mobile.length!=11) {
		    	return false; 
		    } 
		    var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
		    if(!myreg.test(mobile)) {
		        return false; 
		    }
		    return true;
		}
	    
	    function onCellValidation(e) {
	    	var record = e.record;
            if (e.field == "phonenumber") {
            	if (!validatemobile(e.value) ) {
        			e.isValid = false;
        			e.errorText = "请正确输入手机号码";
        		}
            	else {
            		var checkType = "";
            		var userid = "";
            		if (record.id == undefined) {
            			checkType = "insert";
            		}
            		else {
            			userid = record.id;
            		}
            		var url = "${pageContext.request.contextPath}/userManager/checkPhoneNum.htmls";
            		$.ajax({
        	        	async:false,
        	            url: url,
        	            data: {'userid':userid,'phoneNum':e.value,'checkType':checkType},
        	            type: "get",
        	            dataType:"text",
        	            success: function (text) {
       	            		if (text != "success") {
           	            		e.isValid = false;
           	        			e.errorText = "手机号码已存在，不能重复，请正确填写。";
           	            	}
        	            },
        	            error: function (jqXHR, textStatus, errorThrown) {
        	            	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
        	            }
        	        });
            	}
            }
        }
	    
		function save(grid_type) {
			
			var tmpGrid;
			var url = "${pageContext.request.contextPath}/userManager/save.htmls";
			
			var cf1 = "确定要保存数据吗？<br><p style='font-size:12px; color:red'>注意：如果有修改了手机号码，如果该机构下包含普通会员，将同时修改普通会员的门店代码，请谨慎操作.</p>";
			if (grid_type == "grid_user_a") {
				tmpGrid = grid_user_a;
			}
			else if (grid_type == "grid_user_c") {
				tmpGrid = grid_user_c;
			}
			else if (grid_type == "grid_user_z") {
				tmpGrid = grid_user_z;
				cf1 = "确定要保存数据吗？";
			}
			tmpGrid.validate();
	        if (tmpGrid.isValid() == false) {
	        	parent.parent.layer.msg('输入有误，请校验输入单元格内容', {
	        		  icon: 5,
	        		  time: 2000 //2秒关闭（如果不配置，默认是3秒）
	        		}, function(){
	        			var error = tmpGrid.getCellErrors()[0];
	            		tmpGrid.beginEditCell(error.record, error.column);
	        		}
	        	);
	            return;
	        }
	    	
	        var objs = tmpGrid.getChanges();
	        var json = mini.encode(objs,"yyyy-MM-dd");
	        if (json.length == 2) {
	        	parent.parent.layer.msg("没有发现修改的内容，请直接修改，然后再保存。",{icon:3});
	        	return;
	        }
			
        	parent.parent.layer.msg(cf1, {
	 	 		icon:3
	 	 		,time: 0 //不自动关闭
	 	  		,btn: ['确认', '取消']
	 	  		,yes: function(index){
	 	  			tmpGrid.loading("保存中，请稍后......");
	 		        
	 		        $.ajax({
	 		        	async:false,
	 		            url: url,
	 		            data: {'objs':json},
	 		            type: "post",
	 		            dataType:"text",
	 		            success: function (text) {
	 		            	parent.parent.layer.msg("保存完毕。",{icon:6});
	 		            	tmpGrid.reload();
	 		            },
	 		            error: function (jqXHR, textStatus, errorThrown) {
	 		            	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
	 		            }
	 		        });
                    
                    parent.parent.layer.close(index);
	 	  		}
	 		});
	        
	    }
		
      	//删除
        function remove(gridtype) {
      		
      		var tmpGrid;
      		if (gridtype == "grid_user_a") {
      			tmpGrid = grid_user_a;
      		}
      		else if (gridtype == "grid_user_c") {
      			tmpGrid = grid_user_c;
      		}
      		else if (gridtype == "grid_user_z") {
      			tmpGrid = grid_user_z;
      		}
      		else {
      			parent.parent.layer.msg("不确定你点击了什么。",{icon:5});
      			return;
      		}
      		var rows = tmpGrid.getSelecteds();
            if (rows.length > 0) {
            	if (gridtype == "grid_user_a") {
            		if (rows[0].id == "1") {
            			parent.parent.layer.msg("亲，你要删除自己吗？我不允许删除。",{icon:6,time:3000});
            			return;
            		}
            	}
            	
            	var cf1 = "确定要删除选中的数据吗？<br><p style='font-size:12px; color:red'>注意：删除的机构如果有下级，系统将移除关联，并将下级设置为[待关联机构]，请谨慎操作.</p>";
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
                        tmpGrid.loading("操作中，请稍后......");
                        
                        $.ajax({
            	        	async:false,
            	        	url: "${pageContext.request.contextPath}/userManager/delete.htmls",
            	            data: {'id':id},
            	            type: "post",
            	            dataType:"text",
            	            success: function (text) {
            	            	if (text == "success") {
            	            		tmpGrid.reload();
            	            		parent.parent.layer.msg("保存完毕。",{icon:6});
            	            	}
            	            	else {
            	            		parent.parent.layer.msg("失败。请重新登录再尝试或与开发人员联系。",{icon:5});
            	            	}
            	            },
            	            error: function (jqXHR, textStatus, errorThrown) {
            	            	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
            	            }
            	        });
                        
                        parent.parent.layer.close(index);
    	 	  		}
    	 		});
            } else {
            	parent.parent.layer.msg("请选中一条记录",{icon:6});
            }
        }
      	
        
        
      	//给代理添加店,建立关联关系和账户
        function setLink(){
        	//var row = grid_user_a.getSelected();		//所选行 单行
        	var rows_a = grid_user_a.getSelecteds();	//所选行数 多行
            if (rows_a.length == 1) {
                mini.open({
                	url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/selectUser",
                    title: "将已存在的门店关联到新的代理下[同时不解除门店与原代理的关系]", width: 800, height: 500,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { identity: "C",multiSelect:true};
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                    	if (action == "ok") {
                            var iframe = this.getIFrameEl();
                            var rows = iframe.contentWindow.GetData();
                            
                            var ids = getSelectGridid(rows);
                            
    						if (ids != "") {
    							$.ajax({
    				                url: "${pageContext.request.contextPath}/userManager/createlink.htmls",
    				                data: {'userids':ids,'parentid':rows_a[0].id},
    				                type: "post",
    				                dataType:"text",
    				                success: function (text) {
	    				               	if(text != 'error'){
	    				               		if(text == "1"){
	    				               			parent.parent.layer.msg("操作成功",{icon:6});
	    				               			grid_user_c.reload();
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
      	//解除关联关系
      	function outLink(gridtype) {
      		
			var tmpGrid;
			var cf1 = "确定要解除店与代理的关系吗？<br><p style='font-size:12px; color:red'>注意：解除关系后，如果店没有与任何其他代理有关联，将进入[待关联机构]查看，请谨慎操作.</p>";
      		if (gridtype == "grid_user_a") {
      			tmpGrid = grid_user_a;
      		}
      		else if (gridtype == "grid_user_c") {
      			tmpGrid = grid_user_c;
      		}
      		else if (gridtype == "grid_user_z") {
      			tmpGrid = grid_user_z;
      			cf1 = "确定要解除普通会员与代理的关系吗？<br><p style='font-size:12px; color:red'>注意：解除关系后，普通会员将进入[待关联机构]查看，请谨慎操作.</p>";
      		}
      		
      		var rows = tmpGrid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要解除关系的机构。",{icon:6});
       		 	return;
       	 	}
       	 	
       	 	var rows_a = grid_user_a.getSelecteds();
       	 	var ids = getSelectGridid(rows);
       	 	parent.parent.layer.msg(cf1, {
    	 		icon:3
    	 		,time: 0 //不自动关闭
    	  		,btn: ['确认', '取消']
    	  		,yes: function(index){
    	  			//tmpGrid.loading("初始化密码中，请稍后......");
        	        
        	        $.ajax({
        	        	async:false,
        	            url: "${pageContext.request.contextPath}/userManager/outLink.htmls",
        	            data: {'parentid':rows_a[0].id,'userids':ids},
        	            type: "post",
        	            dataType:"text",
        	            success: function (text) {
        	            	if (text == "success") {
        	            		parent.parent.layer.msg("保存完毕。",{icon:6});
        	            		tmpGrid.reload();
        	            	}
        	            	else {
        	            		parent.parent.layer.msg("失败。请重新登录再尝试或与开发人员联系。",{icon:5});
        	            	}
        	            	
        	            },
        	            error: function (jqXHR, textStatus, errorThrown) {
        	            	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
        	            }
        	        });
    	  		}
    		});
      	}
      	
      	function move(gridtype){
      		var tmpGrid;
      		var identity = "";
      		if (gridtype == "grid_user_c") {
      			tmpGrid = grid_user_c;
      			identity = "A";
      		}
      		else if (gridtype == "grid_user_z") {
      			tmpGrid = grid_user_z;
      			identity = "A,C";
      		}
      		
      		var rows = tmpGrid.getSelecteds();
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要移动的机构。",{icon:6});
       		 	return;
       	 	}
       	 	
        	var rows_a = grid_user_a.getSelecteds();	//所选行数 多行
            if (rows_a.length == 1) {
            	var oldParentid = rows_a[0].id;
            	var newParentid = "";
                mini.open({
                	url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/member/selectUser",
                    title: "将选择的机构移动到新的上级机构下[同时解除与原机构的关系]", width: 800, height: 500,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { identity: identity,multiSelect:false};
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                    	if (action == "ok") {
                            var iframe = this.getIFrameEl();
                            var newParentRows = iframe.contentWindow.GetData();
                            
                            if (newParentRows.length != 1) {
                            	return;
                            }
                            
                            newParentid = newParentRows[0].id;
                            
                            var ids = getSelectGridid(rows);
                            
    						if (ids != "") {
    							$.ajax({
    		                         url: "${pageContext.request.contextPath}/userManager/userMove.htmls",
    		                         data: {'userids':ids,'oldParentid':oldParentid,'newParentid':newParentid},
    		                         type: "post",
    		                         dataType:"text",
    		                         success: function (text) {
    		                        	 if(text == 'success'){
    		                        		 parent.parent.layer.msg("操作成功",{icon:6});
    		                        		 tmpGrid.reload();
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
                    }
                });
                
            } else {
                parent.parent.layer.msg("请选中代理",{icon:6});
            }
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
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="takenbank_1('up')" name="taken_1_btn">可提现帐户充值</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="takenbank_1('down')" name="taken_1_btn">提现</a>
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
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_user_z')" name="">增加</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="remove('grid_user_z')">删除</a>
					                <span class="separator"></span>
					                <a class="mini-button" iconCls="icon-reload" plain="true" onclick="initUpdatePass('grid_user_z')">初始化密码</a>
					                <a class="mini-button" plain="true" iconCls="icon-close" onclick="outLink('grid_user_z')">解除关联</a>
					                <a class="mini-button" iconCls="icon-reload" plain="true" onclick="move('grid_user_z')">移动</a>
					                <span class="separator"></span>
					         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_user_z')">保存</a>
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