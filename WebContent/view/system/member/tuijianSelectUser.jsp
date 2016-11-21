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
    

	    var grid;
	    var parentid = "";
	    var userid = "";
	    var identity = "";
	    var multiSelect = true;
	   	$(function(){
	   		mini.parse();
			grid = mini.get("grid");
	    	grid.set({
	    		url:"${pageContext.request.contextPath}/userManager/setTuijianList.htmls",
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
	      	                { field: "rank",name:"rank",width: 150, headerAlign: "center", align:"center",allowSort: false, header: "机构级别" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
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
	            editNextOnEnterKey:false,
	            showPageSize:false,
	            pageSize:2000
	        });
	    });
	   	
	   
        
        //搜索店-根据机构代码
        function search() {
            var key = mini.get("key").getValue();
            
            if (key != "") {
            	var searchmap = {};
                searchmap.username = key;
                searchmap.phonenumber = key;
                searchmap.companyname = key;
                searchmap.companypath = key;
                
                var mapObj = mini.encode(searchmap);
                grid.load({parentid:parentid,userid:userid,identity:identity,mapObj: mapObj });
            }
            else {
            	grid.load({parentid:parentid,userid:userid,identity:identity});
            }
            
        }
        function onKeyEnter(e) {
            search();
        }
        
      //标准方法接口定义
		function SetData(data) {
			data = mini.clone(data);    //必须
			//跨页面传递的数据
			identity = data.identity;
			parentid = data.parentid;
			userid = data.userid;
			multiSelect = data.multiSelect;
			grid.load({parentid:parentid,userid:userid,identity:identity});
			grid.setMultiSelect(multiSelect);
		}
        
        function GetData() {
        	var rows = grid.getSelecteds();
	        return rows;
        }
        
        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }

        function onOk() {
        	var row = GetData();
        	//判断是否已选择
	    	if (row == undefined) {
	    		parent.parent.layer.msg("请选择一条数据",{icon:6});
	    	}else {
	    		CloseWindow("ok");
	    	}
        }
        function onCancel() {
            CloseWindow("cancel");
        }
    </script>
</head>
<body>
	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <table style="width:100%;">
            <tr>
            	<td style="width:100%;">
                 	<span id="pid" style="padding-left:5px;"></span>
                 </td>
                <td style="white-space:nowrap;">
                    <input id="key" class="mini-textbox" emptyText="姓名/手机号/机构名称/地址" style="width:250px;" onenter="onKeyEnter"/>   
                    <a class="mini-button" onclick="search()">查询</a>
                </td>
            </tr>
        </table>           
    </div>
	<div class="mini-fit" >
		<div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;">
	        
	    </div>
	</div>
    <div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border-bottom: 0;border-top: 1;border-left:0;border-right:0;">
        <a class="mini-button" style="width:60px;" onclick="onOk()">确定</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class="mini-button" style="width:60px;" onclick="onCancel()">取消</a>
    </div>
</body>
</html>