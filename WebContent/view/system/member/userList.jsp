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
    

    	//性别
    	var Genders = [{ id: 1, text: '先生' }, { id: 2, text: '女士'}];
    	//身份
    	var userid = [{id:'A',text:'省代'},{id:'B',text:'市代'},{id:'C',text:'门店'},{id:'Z',text:'会员'}];
    	//接收分成
    	var Setreturn = [{id:0,text:'不接收'},{id:1,text:'接收'}];
    	
	    var grid;
	    var editWindow;
	   	$(function(){
	   		mini.parse();
	   		editWindow = mini.get("editWindow");
	   		
			grid = mini.get("grid");
	    	grid.set({
	    		url:"${pageContext.request.contextPath}/userManager/list.htmls",
	    		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
	  	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
	  	              	{ field: "phonenumber",name:"phonenumber", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "手机",vtype:"required" ,editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	                { field: "username",name:"username", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "真实姓名",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	              	{ field: "userid",name:"userid",type:"comboboxcolumn", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "身份",editor: { type: "combobox", data:"userid"} },
	  	            	{ field: "tuijianid",name:"tuijianid", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "推荐人",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	  	            
	  	            	{ field: "birthday",name:"birthday", width: 80, headerAlign: "center", align:"center",allowSort: false, dateFormat:"yyyy-MM-dd", header: "生日",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
	  	          		{ field: "sex",name:"sex",type:"comboboxcolumn",autoShowPopup:true, width: 80, headerAlign: "center", align:"center",allowSort: false, header: "性别",editor: { type: "combobox",data:"Genders"} },
	  	          	
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
	    	grid.load();
	    	drawcell();
	    });
	   	
	   	//绘制表格
	    function drawcell() {
       		grid.on("drawcell", function (e) {
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
	   	
	   	//添加
	    function add() {
	    	mini.open({
	    	    //url: "/view/system/member/EmployeeWindow.html",
	    	    url: "/common/dispatch.htmls?page=/view/system/member/userEdit",
	    	    title: "新增员工", width: 600, height: 400,
	    	    onload: function () {
	    	        var iframe = this.getIFrameEl();
	    	        var data = { action: "new"};
	    	        iframe.contentWindow.SetData(data);
	    	    },
	    	    ondestroy: function (action) {

	    	        grid.reload();
	    	    }
	    	});
		}
	    
	    //修改
        function edit() {
            var row = grid.getSelected();	//所选行 单行
            var rows = grid.getSelecteds();	//所选行数 多行
            if (rows.length == 1) {
                mini.open({
                	url: "/common/dispatch.htmls?page=/view/system/member/userEdit",
                    title: "编辑员工", width: 600, height: 400,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = { action: "edit", row: row };
                        iframe.contentWindow.SetData(data);
                        
                    },
                    ondestroy: function (action) {
                        grid.reload();
                        
                    }
                });
                
            } else {
                mini.alert("请选中一条记录");
            }
            
        }
        
        //删除
        function remove() {
            var rows = grid.getSelecteds();
            if (rows.length > 0) {
            	 mini.confirm("确定删除记录？", "系统消息",
          	     	function (action) {
	         	    	if (action == "ok") {
	         	    		var ids = [];
	                        for (var i = 0, l = rows.length; i < l; i++) {
	                            var r = rows[i];
	                            ids.push(r.id);
	                        }
	                        var id = ids.join(',');
	                        grid.loading("操作中，请稍后......");
	                        $.ajax({
	                        	url: "${pageContext.request.contextPath}/userManager/delete.htmls?id=" +id,
	                            dataType:"text",
	                            success: function (text) {
	                                grid.reload();
	                            },
	                            error: function () {
	                            }
	                        });
	          	       	}
          	    	}
         	    );
            } else {
                mini.alert("请选中一条记录");
            }
        }
        
        //搜索
        function search() {
            var key = mini.get("key").getValue();
            grid.load({ key: key });
        }
        function onKeyEnter(e) {
            search();
        }
        
        //查看推荐人
        function referrer(row_uid){
	        var row = grid.getRowByUID(row_uid);
	        if (row) {
	            editWindow.show();
	            var form = new mini.Form("#editform");
	            form.clear();
	
	            form.loading();
	            $.ajax({
	            	url: "${pageContext.request.contextPath}/userManager/getById.htmls?id=" + row.id,
	            	dataType:"text",
	                success: function (text) {
	                    form.unmask();
	                    var o = mini.decode(text);
	                    form.setData(o.data);
	                },
	                error: function () {
	                    mini.alert("表单加载错误");
	                    form.unmask();
	                }
	            });
	
	        }
	    }
    </script>
</head>
<body>
	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="mini-button" iconCls="icon-add" plain="true" onclick="add()">增加</a>
                    <a class="mini-button" iconCls="icon-add" plain="true" onclick="edit()">编辑</a>
                    <a class="mini-button" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>       
                </td>
                <td style="white-space:nowrap;">
                    <input id="key" class="mini-textbox" emptyText="请输入手机号" style="width:150px;" onenter="onKeyEnter"/>   
                    <a class="mini-button mini-button-plain" href="javascript:search()"><span class="mini-button-text  mini-button-icon-text "><span class="mini-button-icon mini-iconfont icon-search" style=""></span>查询</span></a>
                </td>
            </tr>
        </table>           
    </div>
	<div class="mini-fit" >
		<div id="grid" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;">
	        
	    </div>
	</div>
    
    <div id="editWindow" class="mini-window" title="推荐人信息" style="width:650px;" showModal="true" allowResize="true" allowDrag="true">
	    <div id="editform" class="form" >
	        <div style="padding-left:11px;padding-bottom:5px;">
	            <table style="table-layout:fixed;">
	                <tr>
	                    <td style="width:70px;">手机号：</td>
	                    <td style="width:150px;">    
	                        <input name="phonenumber" class="mini-textbox" required="true"  emptyText="请输入手机号"/>
	                    </td>
	                    <td style="width:70px;">身份：</td>
	                    <td style="width:150px;">
	                    	<select name="userid" class="mini-combobox" >
	                    		<option value="Z">会员</option>
		                        <option value="A">省代</option>
		                        <option value="B">市代</option>
		                        <option value="C">门店</option>
		                    </select>
	                    </td>
	                </tr>
	               <tr>
	                    <td style="width:70px;">推荐人：</td>
	                    <td style="width:150px;">
	                		<input textname="tuijianid" name="tuijianid" allowInput="false" property="editor" class="mini-buttonedit" onbuttonclick="onButtonEdit" />
	                    </td>
	                </tr>
	            </table>
	        </div>
	        <fieldset style="border:solid 1px #aaa;padding:3px;">
	            <legend >基本信息</legend>
	            <div style="padding:5px;">
	        <table>
	            <tr>
	                <td style="width:70px;">姓名</td>
	                <td style="width:150px;">    
	                    <input name="username" class="mini-textbox" />
	                </td>
	                <td style="width:70px;">性别：</td>
	                <td >                        
	                    <select name="sex" class="mini-radiobuttonlist">
	                        <option value="1">先生</option>
	                        <option value="2">女士</option>
	                    </select>
	                </td>
	                
	            </tr>
	            <tr>
	                <td >年龄：</td>
	                <td >    
	                    <input name="age" class="mini-spinner" value="25" minValue="1" maxValue="200" />
	                </td>
	                <td >出生日期：</td>
	                <td >    
	                    <input name="birthday" class="mini-datepicker" required="true" emptyText="请选择日期"/>
	                </td>
	            </tr>
	            <tr>
	            	<td >城市：</td>
	                <td >    
	                    <input name="city" class="mini-combobox"  />
	                </td>
	                <td ></td>
	                <td >    
	                </td>
	                
	            </tr>
	        </table>            
	            </div>
	        </fieldset>
	    </div>
	</div>

</body>
</html>