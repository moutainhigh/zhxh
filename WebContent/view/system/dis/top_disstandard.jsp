<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title></title>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
	
	
	<style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }
	</style>
    
	<script type="text/javascript">
	
		var grid_user_a;
		var grid_brand_a;
		var grid_product_a;
		var grid_standard_a;
	
		$(function() {
			mini.parse();
			
			grid_user_a = mini.get("grid_user_a");
			grid_user_a.set({
        		url:"${pageContext.request.contextPath}/userManager2/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
      	                { field: "username",name:"username", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "真实姓名",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "phonenumber",name:"phonenumber", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "手机号码",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "birthday",name:"birthday",dateFormat:"yyyy-MM-dd",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "性别",vtype:"required",editor:{ type: "datepicker"} },
      	              	{ field: "sex",name:"sex",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "性别",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"女"},{"id":"1","text":"男"}] } },
      	              	{ field: "identitymemo",name:"identitymemo",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "身份" },
      	                { field: "companyname",name:"companyname",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构名称" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "companypath",name:"companypath",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构地址" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "companycode",name:"companycode",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构代码" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "wechar",name:"wechar",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "微信号码" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "rank",name:"rank",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构级别" ,vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25}},
      	                { field: "isopen",name:"isopen",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁用"},{"id":"1","text":"正常"}] } }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelectionChanged",
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			grid_user_a.load({ parentid: '1' ,identity:'A'});
			
			grid_brand_a = mini.get("grid_brand_a");
			grid_brand_a.set({
        		url:"${pageContext.request.contextPath}/userManager2/list_user_brand.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
      	                { field: "brandlogo",name:"brandlogo", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "品牌Logo(80*80)" },
      	                { field: "brandname",name:"brandname", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "品牌名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "brandpath",name:"brandpath",type:"comboboxcolumn", autoEscape:true,width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌显示位置",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"PC端展示"},{"id":"2","text":"移动商城展示"}] } },
      	                { field: "isshow",name:"isshow",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } },
      	                { field: "brandcolor",name:"brandcolor", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "品牌颜色",vtype:"required" },
      	                { field: "sort",name:"sort", width: 40, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelectionChanged",
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
			grid_product_a = mini.get("grid_product_a");
			grid_product_a.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "productname",name:"productname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "createdate",name:"update",dateFormat:"yyyy-MM-dd", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "创建日期",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "sort",name:"sort", width: 30, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            //fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
			grid_standard_a = mini.get("grid_standard_a");
			grid_standard_a.set({
        		url:"${pageContext.request.contextPath}/userManager2/listUserStandard.htmls",
        		columns: [
        		          { type: "checkcolumn",headerAlign:"center",width: 30},
      	                  { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	      	              { field: "productpic",name:"productpic", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "商品主图片"},
	      	              { field: "buyerdis",name:"buyerdis", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "采购折扣" ,vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	      	              { field: "rebatesdis",name:"rebatesdis", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "返利标准" ,vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	      	              { field: "bonusesdis",name:"bonusesdis", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "奖励标准" ,vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
	      	              { field: "state",name:"state",type:"comboboxcolumn", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "状态",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"禁止采购"},{"id":"1","text":"可采购"}] } },
	      	              { field: "parentname",name:"parentname", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "设置者" },
    	                  { field: "username",name:"username", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "被设置者" },
    	                  { field: "companyname",name:"companyname", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "机构名称" },
						  { field: "productname",name:"productname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品名称"},
						  { field: "productsize",name:"productsize", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "规格标准"},
						  { field: "price",name:"price",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "售价" },
						  //{ field: "saleprice",name:"saleprice", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "特价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25  } },
						  { field: "sizesort",name:"sizesort", width: 40, headerAlign: "center", align:"center",allowSort: false, header: "排序" }
						  //{ field: "productmemo",name:"productmemo", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品简介",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} },
						  //{ field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } }
					],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
			drawcell();
		})
		
		function onSelectionChanged(e) {
            var grid = e.sender;
            
          //处理角色对应的帐户
            var record = grid.getSelected();
            
            if (grid.id == 'grid_user_a') {
            	if (typeof(record.id) == "undefined" || record.id == "") {
            		grid_brand_a.setData([]);
            		grid_brand_a.setTotalCount(0);
            		grid_product_a.setData([]);
                	grid_product_a.setTotalCount(0);
            		grid_standard_a.setData([]);
            		grid_standard_a.setTotalCount(0);
    	      		return;
    	      	}
                
                if (record) {
                	grid_brand_a.load({parentid:'1', userid: record.id });
                	grid_product_a.setData([]);
                	grid_product_a.setTotalCount(0);
                	grid_standard_a.setData([]);
                	grid_standard_a.setTotalCount(0);
                }
            }
            else if (grid.id == 'grid_brand_a') {
    	      	
                if (typeof(record.id) == "undefined" || record.id == "") {
                	grid_product_a.setData([]);
                	grid_product_a.setTotalCount(0);
                	grid_standard_a.setData([]);
                	grid_standard_a.setTotalCount(0);
    	      		return;
    	      	}
                
                if (record) {
                	grid_product_a.load({listtype:'product', parentid: record.id });
                	grid_standard_a.setData([]);
                	grid_standard_a.setTotalCount(0);
                }
            }
            else if (grid.id == 'grid_product_a') {
    	      	
                if (typeof(record.id) == "undefined" || record.id == "") {
                	grid_standard_a.setData([]);
                	grid_standard_a.setTotalCount(0);
    	      		return;
    	      	}
                
                if (record) {
                	var user_row = grid_user_a.getSelected();
                	grid_standard_a.load({parentid:'1', userid: user_row.id ,productid:record.id});
                }
            }
        }
		
		function drawcell() {
			
       		grid_brand_a.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (typeof(record.id) != "undefined" && record.id != "") {
                	if (field == "brandlogo") {
       	        		if (typeof(value) == "undefined" || value == "") {
                    		e.cellHtml = '<a href="javascript:;" onclick="open_upload_pic(\'grid_brand\',\''+record.id+'\',\'logo\',\'brandlog\')" >选择图片</a>';
           	        	}
       	        		else {
       	        			e.cellHtml = '<a href="javascript:;" onclick="open_upload_pic(\'grid_brand\',\''+record.id+'\',\'logo\',\'brandlog\')" ><img src="${pageContext.request.contextPath}/' + value + '" height="30px" /></a>';
       	        		}
        	        }
                }
                
                if (field == "brandcolor") {
                	if (typeof(value) == "undefined" || value == "") {
                		e.cellHtml = '<a href="javascript:;" onclick="open_sel_color(\''+uid+'\')" >选择颜色</a>';
       	        	}
   	        		else {
   	        			e.cellHtml = '<a href="javascript:;" onclick="open_sel_color(\''+uid+'\')" ><span style="background-color:' + value + ';width:30px;height:30px;display:inline-block"></span></a>';
   	        		}
    	        }
                
                if (field == "isshow") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                	else {
                		e.cellStyle = "color:blue;text-align:center";
                	}
                }
            });
       		
       		grid_product_a.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "isshow") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                	else {
                		e.cellStyle = "color:blue;text-align:center";
                	}
                }
            });
       		
       		grid_standard_a.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field != "buyerdis" && field != "rebatesdis" && field != "bonusesdis" && field != "state") {
                	e.cellStyle = "background:#ecedef";
                }
                
                if (typeof(record.id) != "undefined" && record.id != "") {
                	if (field == "productpic") {
       	        		if (typeof(value) == "undefined" || value == "") {
                    		e.cellHtml = '<a href="javascript:;" onclick="open_upload_pic(\'grid_product_size\',\''+record.id+'\',\'pic\',\'productsize\')" >选择图片</a>';
           	        	}
       	        		else {
       	        			e.cellHtml = '<a href="javascript:;" onclick="open_upload_pic(\'grid_product_size\',\''+record.id+'\',\'pic\',\'productsize\')" ><img src="${pageContext.request.contextPath}/' + value + '" height="30px" /></a>';
       	        		}
        	        }
                }
                
                if (field == "state") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                	else {
                		e.cellStyle = "color:blue;text-align:center";
                	}
                }
            });
        }
		
		
		
		
		function openSelBrand(gridtype) {
			
			var record;
			var tmpgrid;
			if (gridtype == 'grid_brand_a') {
				record = grid_user_a.getSelected();
				tmpgrid = grid_brand_a;
			}
			else if (gridtype == 'grid_brand_z') {
				record = grid_user_z.getSelected();
				tmpgrid = grid_brand_z;
			}
	      	
            if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	parent.parent.layer.msg("请先选择机构，再添加品牌。",{icon:6});
	      		return;
	      	}
            
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/dis/selectBrand",
                title: "为机构添加能操作的品牌", width: 800, height:600,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {parentid:"1",userid:record.id};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		var iframe = this.getIFrameEl();
                        var rows = iframe.contentWindow.GetData();
                        
                        var ids = getSelectGridid(rows);
                        if (ids != "") {
                        	tmpgrid.loading("保存中，请稍后......");
                            $.ajax({
                            	url: "${pageContext.request.contextPath}/userManager2/saveUserBrand.htmls",
                                data: {'brandids':ids,'parentid':'1','userid':record.id},
                                type: "post",
                                dataType:"text",
                                success: function (text) {
                                	tmpgrid.reload();
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
                                }
                            });
                        }
                    }
                }
            });
        }
		
		function openSelSize(gridtype) {
			
			var record;
			var tmp;
			var userRow;
            var brandRow;
			if (gridtype == "grid_standard_a") {
				record = grid_product_a.getSelected();
				tmp = grid_standard_a;
				userRow = grid_user_a.getSelected();
	            brandRow = grid_brand_a.getSelected();
			}
			else if (gridtype == "grid_standard_z") {
				record = grid_product_z.getSelected();
				tmp = grid_standard_z;
				userRow = grid_user_z.getSelected();
	            brandRow = grid_brand_z.getSelected();
			}
			
            if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	parent.parent.layer.msg("请先选择商品，再添加规格采购标准。",{icon:6});
	      		return;
	      	}
            
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/dis/selectSize",
                title: "为机构添加商品规格采购标准", width: 800, height:600,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {parentid:"1",userid:userRow.id,productid:record.id};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		var iframe = this.getIFrameEl();
                        var rows = iframe.contentWindow.GetData();
                        
                        var ids = getSelectGridid(rows);
                        if (ids != "") {
                        	tmp.loading("保存中，请稍后......");
                            $.ajax({
                            	url: "${pageContext.request.contextPath}/userManager2/saveUserSizeStandard.htmls",
                                data: {'brandid':brandRow.id,'productid':record.id,'sizeids':ids,'parentid':'1','userid':userRow.id},
                                type: "post",
                                dataType:"text",
                                success: function (text) {
                                	tmp.reload();
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
                                }
                            });
                        }
                    }
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
		
		function save(gridtype) {
			
			var tmpGrid;
			var url = "${pageContext.request.contextPath}/userManager2/saveStandard.htmls";
			
			if (gridtype == "grid_standard_a") {
				tmpGrid = grid_standard_a;
			}
			else if (gridtype == "grid_standard_z") {
				tmpGrid = grid_standard_z;
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
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	parent.parent.layer.msg("没有发现修改的内容，请直接修改，然后再保存。",{icon:3});
	        	return;
	        }
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
	    }
		
		function delRowBrand() {
			
			var rows = grid_brand_a.getSelecteds();
			
			var userRow = userRow = grid_user_a.getSelected();
        	
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要删除的数据.",{icon:6});
       		 	return;
       	 	}
       	 	var url = "${pageContext.request.contextPath}/userManager2/delUserBrand.htmls";
       	 	var cf1 = "确认要删除选择的品牌吗？<br><span style='color:red'>注意：删除品牌，该机构将不能再采购该品牌下的商品。</span>";
			parent.parent.layer.msg(cf1, {
    	 		icon:3
    	 		,time: 0 //不自动关闭
    	  		,btn: ['确认删除', '取消']
    	  		,yes: function(index){
    	  			grid_brand_a.loading("保存中，请稍后......");
    		        
    		        $.ajax({
    		        	async:false,
    		            url: url,
    		            data: {'parentid':'1','userid':userRow.id,'brandid':rows[0].id},
    		            type: "post",
    		            dataType:"text",
    		            success: function (text) {
    		            	parent.parent.layer.msg("保存完毕。",{icon:6});
    		            	grid_brand_a.reload();
    		            	grid_product_a.setData([]);
    	                	grid_product_a.setTotalCount(0);
    	                	grid_standard_a.setData([]);
    	                	grid_standard_a.setTotalCount(0);
    		            },
    		            error: function (jqXHR, textStatus, errorThrown) {
    		            	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
    		            }
    		        });
    	    		parent.parent.layer.close(index);
    	  		}
    		});
		}
		
		function delRow(gridtype) {
			
			var cf1 = "确定要删除选中的数据吗？";
			var tmpGrid;
			if (gridtype == "grid_standard_a") {
				tmpGrid = grid_standard_a;
			}
			else if (gridtype == "grid_standard_z") {
				tmpGrid = grid_standard_z;
			}
			
        	var rows = tmpGrid.getSelecteds();
        	
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要删除的数据.",{icon:6});
       		 	return;
       	 	}
       	 	
       	 	parent.parent.layer.msg(cf1, {
    	 		icon:3
    	 		,time: 0 //不自动关闭
    	  		,btn: ['确认删除', '取消']
    	  		,yes: function(index){
    	  			tmpGrid.removeRows(rows, false);
    	    		parent.parent.layer.close(index);
    	  		}
    		});
       	 	
        }
		
		function updateRows(gridtype) {
			var tmpGrid;
			if (gridtype == "grid_standard_a") {
				tmpGrid = grid_standard_a;
			}
			else if (gridtype == "grid_standard_z") {
				tmpGrid = grid_standard_z;
			}
			
        	var rows = tmpGrid.getSelecteds();
        	
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要批量修改的数据.",{icon:6});
       		 	return;
       	 	}
       	 	
       	 mini.open({
             url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/dis/selectSize",
             title: "为机构添加商品规格采购标准", width: 800, height:600,
             allowResize:true,
             onload: function () {
             	var iframe = this.getIFrameEl();
            	 	var data = {parentid:"1",userid:userRow.id,productid:record.id};
                 iframe.contentWindow.SetData(data);
             },
             ondestroy: function (action) {
             	if (action == "ok") {
             		var iframe = this.getIFrameEl();
                     var rows = iframe.contentWindow.GetData();
                     
                     var ids = getSelectGridid(rows);
                     if (ids != "") {
                     	tmp.loading("保存中，请稍后......");
                         $.ajax({
                         	url: "${pageContext.request.contextPath}/userManager2/saveUserSizeStandard.htmls",
                             data: {'brandid':brandRow.id,'productid':record.id,'sizeids':ids,'parentid':'1','userid':userRow.id},
                             type: "post",
                             dataType:"text",
                             success: function (text) {
                             	tmp.reload();
                             },
                             error: function (jqXHR, textStatus, errorThrown) {
                             	parent.parent.layer.msg(jqXHR.responseText,{icon:5});
                             }
                         });
                     }
                 }
             }
         });
       	 	
		}
		
		
		//以下不确定要
		function saveT() {
            form.validate();
            if (form.isValid() == false) return;

            //提交数据
            var data = form.getData();      
            var json = mini.encode(data);
			
			$.ajax({
				async : false,
				url : "${pageContext.request.contextPath}/dis/saveDisStandard.htmls",
				data : {
					'objs' : json
				},
				type : "post",
				dataType : "text",
				success : function(text) {
					parent.parent.layer.msg("保存完毕。",{icon:6});
					inputModel();
				},
				error : function(jqXHR, textStatus, errorThrown) {
					mini.alert(jqXHR.responseText);
				}
			});
		}
	</script>
</head>
<body>
	<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width: 100%; height: 100%;" borderStyle="padding:0;border:0;">
		<div name="" title="代理采购标准">
			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
		   		<div size="50%" showCollapseButton="false" style="border-width: 1;">
		   			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
		   				<div size="50%" showCollapseButton="false" style="border-width: 1;">
					    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
						        <table style="width:100%;">
						            <tbody>
						             <tr>
						                 <td style="width:100%;">
						                 	<span id="pid" style="padding-left:5px;">代理列表</span>
						                 </td>
						                 <td style="white-space:nowrap;">
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
							<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
					            <table style="width:100%;">
					                <tbody>
						                <tr>
						                    <td style="width:100%;">
						                    	<span id="pid" style="padding-left:5px;">品牌列表</span>
						                    </td>
						                    <td style="white-space:nowrap;">
						                    	<a class="mini-button" iconCls="icon-add" plain="true" onclick="openSelBrand('grid_brand_a')">新增</a>
						                 		<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRowBrand()">删除</a>
						                    </td>
						                </tr>
						            </tbody>
					            </table>
					        </div>
					        <div class="mini-fit">
					            <div id="grid_brand_a" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
					        </div>
						</div>
					</div>
				</div>
				<div showCollapseButton="true">
					<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
		   				<div size="30%" showCollapseButton="false" style="border-width: 1;">
					    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
						        <table style="width:100%;">
						            <tbody>
						             <tr>
						                 <td style="width:100%;">
						                 	<span id="pid" style="padding-left:5px;">商品列表</span>
						                 </td>
						                 <td style="white-space:nowrap;">
						                 </td>
						             </tr>
						         </tbody>
						        </table>
						    </div>
						    <div class="mini-fit">
						        <div id="grid_product_a" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
						    </div>
						</div>
						<div showCollapseButton="true">
							<div class="mini-toolbar" borderStyle="border:0;">
						        <table style="width:100%;">
						            <tbody>
						             <tr>
						                 <td style="width:100%;">
						                 	<span id="pid" style="padding-left:5px;">商品规格采购利益标准</span>
						                 </td>
						                 <td style="white-space:nowrap;">
						                  	<a class="mini-button" iconCls="icon-add" plain="true" onclick="openSelSize('grid_standard_a')">新增</a>
						                	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_standard_a')">删除</a>
							                <span class="separator"></span>
							                <a class="mini-button" iconCls="icon-remove" plain="true" onclick="updateRows('grid_standard_a')">批量修改</a>
							                <span class="separator"></span>
							         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_standard_a')">保存</a>
						                 </td>
						             </tr>
						         </tbody>
						        </table>
						    </div>
						    <div class="mini-fit"><!-- border-bottom: 1;border-top: 0;border-left:0;broder-right:0" -->
						        <div id="grid_standard_a" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border-bottom: 1;border-top: 1;border-left:0;border-right:0;"></div>
						    </div>
						</div>
					</div>
		   		</div>
			</div>
		</div>
		<div name="brandFirst" title="直营店采购标准">
			<div class="mini-toolbar" style="padding: 3px; border-top: 0; border-left: 0; border-right: 0; border-bottom: 1;">
				<a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="addRow()">新增</a>
				<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandfirst')">删除</a>
				<span class="separator"></span>
				<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('meter')">保存</a> <span class="separator"></span>
			</div>
			<div class="mini-fit">
				<div id="grid_c_standard" class="mini-datagrid" style="width: 100%; height: 100%;" borderStyle="border:0;"></div>
			</div>
		</div>
	</div>

</body>
</html>