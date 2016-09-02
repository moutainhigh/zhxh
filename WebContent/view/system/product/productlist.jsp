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

		var grid_brand;
		var grid_product;
		var grid_product_size;
		
       	$(function(){
       		mini.parse();
       		
			grid_brand = mini.get("grid_brand");
			grid_brand.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
      	              	{ field: "action", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	                { field: "brandlogo",name:"brandlogo", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "品牌Logo(80*80)" },
      	                //{ field: "brandlogo",name:"brandlogo", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "品牌Logo",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onButtonEdit"} },
      	                { field: "brandname",name:"brandname", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "品牌名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "brandpath",name:"brandpath",type:"comboboxcolumn", autoEscape:true,width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌显示位置",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"PC端展示"},{"id":"2","text":"移动商城展示"}] } },
      	                { field: "isshow",name:"isshow",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } },
      	                { field: "brandcolor",name:"brandcolor", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "品牌颜色",vtype:"required" },
      	                //{ field: "brandcolor",name:"brandcolor", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "品牌颜色",vtype:"required",editor: {  type: "buttonedit",allowInput:false,onbuttonclick:"onBtnColorEdit"  } },
      	                { field: "sort",name:"sort", width: 40, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			grid_brand.load({ listtype: 'brand' });
			//drawcell();
        	
			grid_product = mini.get("grid_product");
			grid_product.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	              	{ field: "action", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	                //{ field: "productpic",name:"productpic", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "商品主图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnProductEdit" } },
      	                //{ field: "productpic",name:"productpic", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "商品主图片"},
      	                { field: "productname",name:"productname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                //{ field: "productcode",name:"productcode", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "商品型号",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                //{ field: "showtype",name:"showtype",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "商品显示类型",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"富文本"},{"id":"2","text":"仅图片"}] } },
      	                //{ field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } },
      	                //{ field: "productmemo",name:"productmemo", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品简介",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "createdate",name:"update",dateFormat:"yyyy-MM-dd", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "创建日期",editor: { type: "datepicker", minValue: 0, maxValue: 500, value: 25} },
      	                //{ field: "ifdis",name:"ifdis",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "三级分销",editor: { type: "combobox", data: [{"id":"0","text":"否"},{"id":"1","text":"是"}] } },
      	                { field: "sort",name:"sort", width: 30, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            showPager:true,
	            onselectionchanged:"onSelProductChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            //fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
			grid_product_size = mini.get("grid_product_size");
			grid_product_size.set({
	    		url:"${pageContext.request.contextPath}/product/list.htmls",
	            columns: [
	                  { type: "checkcolumn",headerAlign:"center",width: 30},
					  { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
					  { field: "action", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
					  { field: "productpic",name:"productpic", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "商品主图片(200*200)"},
					  { field: "productname",name:"productname", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
					  { field: "showtype",name:"showtype",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "商品显示类型",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"富文本"},{"id":"2","text":"仅图片"}] } },
					  { field: "productsize",name:"productsize", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "规格标准",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
					  { field: "price",name:"price",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "售价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25 } },
					  { field: "saleprice",name:"saleprice", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "特价",vtype:"required;float",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25  } },
					  { field: "sizesort",name:"sizesort", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: {type: "textbox", minValue: 0, maxValue: 500, value: 25 } },
					  { field: "productmemo",name:"productmemo", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "商品简介",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} },
					  { field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否上架",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"下架"},{"id":"1","text":"上架"}] } }
				],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            //onselectionchanged:"onSelectionChanged",
	            allowUnselect:false,
	            showPager:true,
	            showPageSize:false,
	            pageSize:1000
	        });
			
        	drawcell();
        })
        
        function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var uid = record._uid;
            var id = record.id;
            var rowIndex = e.rowIndex;
			
            if (typeof(id) == "undefined" || id == "") {
            	return;
            }
            if (grid.id == "grid_brand") {
            	var brandname = record.brandname;
            	var s = ' <a class="Edit_Button" href="javascript:editBrandStory(\'' + id + '\',\'' + brandname + '\')" >品牌故事</a>'
            }
            else if (grid.id == "grid_product") {
            	var productname = record.productname;
                var showtype = record.showtype;
                
                var s = ' <a class="Edit_Button" href="javascript:editRated(\'' + id + '\',\'' + productname + '\')" >评价</a>';
                //s += '  <a class="Edit_Button" href="javascript:editSize(\'' + id + '\',\'' + productname + '\')" >售价</a> | ';
                //s += '  <a class="Edit_Button" href="javascript:edit(\'' + id + '\',\'' + showtype + '\')" >详细</a>';
                //s += '  <a class="Edit_Button" href="javascript:getUrl(\'' + id + '\')" >获取地址</a>';
            }
            else if (grid.id == "grid_product_size") {
            	var productname = record.productname;
                var showtype = record.showtype;
                
                var s = '  <a class="Edit_Button" href="javascript:edit(\'' + id + '\',\'' + showtype + '\')" title="编辑商品详细信息">详细</a>';
                s += '  <a class="Edit_Button" href="javascript:setLinkids(\'' + id + '\')" title="设置该商品详细页的推荐商品">设置推荐商品</a>';
                s += '  <a class="Edit_Button" href="javascript:getUrl(\'' + id + '\')" >获取地址</a>';
            }
            
            return s;
        }
       	
       	function getUrl(id) {
       		var serv_path = "${pageContext.request.contextPath}";
       		parent.parent.layer.msg(serv_path + "/pcMain/product_c.htmls?id=" + id,{icon:6,time:5000});
       	}
        
        function drawcell() {
       		grid_brand.on("drawcell", function (e) {
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
       		
       		grid_product.on("drawcell", function (e) {
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
       		
       		grid_product_size.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
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
                
                if (field == "isshow") {
                	if (value == 0) {
                		e.cellStyle = "color:red;text-align:center";
                	}
                	else {
                		e.cellStyle = "color:blue;text-align:center";
                	}
                }
            });
        }
       	
       	function open_upload_pic(grid_type,rowid,saveFolder,forObj) {
       		var tmpGrid;
       		
       		if (grid_type == "grid_brand") {
				tmpGrid = grid_brand;
			}
			else if (grid_type == "grid_product_size"){
				tmpGrid = grid_product_size;
			}
       		
       		var objs = tmpGrid.getChanges();
       		if (objs != "") {
       			parent.parent.layer.msg("发现列表中有未保存的数据。请先保存数据或刷新后再上传图片。",{icon:6});
   	 			return;
       		}
       		else {
       			mini.open({
                    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/upload_pic",
                    title: "上传图片", width: 600, height:500,
                    allowResize:true,
                    onload: function () {
                    	var iframe = this.getIFrameEl();
                   	 	var data = {id:rowid,saveFolder:saveFolder,forObj:forObj};
                        //var data = rows[0];
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                    	if (action == "ok") {
                    		tmpGrid.cancelEdit();
                    		tmpGrid.reload();
                        }
                    }
                });
       		}
       		
       	}
       	
       	function open_sel_color(uid) {
       		mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/selectColor",
                title: "选择颜色", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		var iframe = this.getIFrameEl();
                        var color_data = iframe.contentWindow.GetData();
                        color_data = mini.clone(color_data);    //必须
                        if (color_data != "") {
                            var row = grid_brand.getRowByUID(uid);
                            grid_brand.cancelEdit();
                            grid_brand.updateRow(row, {
                            	brandcolor:color_data
                            });
                        }
                    }
                }
            });
       	}
       	
        function onSelectionChanged(e) {
            var grid = e.sender;
	       	//处理角色对应的帐户
            var record = grid.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	grid_product.setData([]);
            	grid_product.setTotalCount(0);
            	grid_product_size.setData([]);
            	grid_product_size.setTotalCount(0);
	      		return;
	      	}
            
            if (record) {
            	grid_product.load({listtype:'product', parentid: record.id });
            	grid_product_size.setData([]);
            	grid_product_size.setTotalCount(0);
            }
        }
        
        function onSelProductChanged(e) {
            var grid = e.sender;
	       	//处理角色对应的帐户
            var record = grid.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	grid_product_size.setData([]);
            	grid_product_size.setTotalCount(0);
	      		return;
	      	}
            
            if (record) {
            	grid_product_size.load({ listtype:'productsize',parentid: record.id });
            }
        }
        
        function editBrandStory(id,brandname) {
        	if(id == 'undefined'){
        		parent.parent.layer.msg("请先保存信息，再添加内容。",{icon:6});
				return;
			}
			var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	   		
        	var title = "["+brandname+"]品牌故事";
        	mini.open({
	             url: "${pageContext.request.contextPath}/public/edit_o.htmls?parentid="+id +"&parenttype=brandstory",
	             title: title, width: pWidth-300, height:pHeight-100,
	             allowResize:true,
	             showMaxButton:true,
	             onload: function () {
	            	 
	             },
	             ondestroy: function (action) {
	            	 
	             }
	        });
        }
        function editRated(id,productname) {
        	
        	if(id == 'undefined'){
        		parent.parent.layer.msg("请先保存信息，再添加内容。",{icon:6});
				return;
			}
        	
        	var title = "商品评价";
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/editRated",
                title: title, width: 800, height:600,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {productid:id,productname:productname};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		
                    }
                }
            });
        }
        
        function editSize(id,productname) {
        	
        	var title = "商品售价";
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/editSize",
                title: title, width: 800, height:600,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {productid:id,productname:productname};
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if (action == "ok") {
                		
                    }
                }
            });
        }
        
		function addRow(grid_type) {
			var tmpGrid;
			var editField;
			var newRow = {};
			if (grid_type == "grid_brand") {
				tmpGrid = grid_brand;
				newRow.brandname = "新的品牌";
				newRow.sort = 1;
				newRow.brandpath = "1";
				newRow.isshow = "0";
				newRow.brandcolor = "black";
				
				editField = "brandname";
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
	       	 		}
	       	 	}
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
            tmpGrid.beginEditCell(newRow, editField);
        }
		
		function addCopyRow() {
			var rows = grid_product_size.getSelecteds();
			var cloneid = "";
			if (rows.length > 1) {
				parent.parent.layer.msg("只能选择一个商品规格进行克隆新增。",{icon:6});
				return;
			}
			else if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择一个商品规格进行克隆新增.",{icon:6});
       		 	return;
       	 	}
       	 	else {
       	 		if (typeof(rows[0].id) == "undefined" || rows[0].id == "") {
       	 			parent.parent.layer.msg("当前商品还没有保存。请先保存或刷新商品后再克隆创建商品规格.",{icon:6});
       	 			return;
       	 		}
       	 		else {
       	 			cloneid = rows[0].id;
       	 		}
       	 	}
			
			parent.parent.layer.msg("确定克隆该商品规格吗？", {
    	 		icon:3
    	 		,time: 0 //不自动关闭
    	  		,btn: ['确认', '取消']
    	  		,yes: function(index){
    	  			grid_product_size.loading("保存中，请稍后......");
    		        
    		        $.ajax({
    		        	async:false,
    		            url: "${pageContext.request.contextPath}/product/clonesave.htmls",
    		            data: {'cloneid':cloneid},
    		            type: "post",
    		            dataType:"text",
    		            success: function (text) {
    		            	parent.parent.layer.msg("克隆完毕。",{icon:6});
    		            	grid_product_size.reload();
    		            },
    		            error: function (jqXHR, textStatus, errorThrown) {
    		                mini.alert(jqXHR.responseText);
    		            }
    		        });
    	  		}
    		});
        }
		
		function delRow(grid_type) {
			
			var cf1 = "确定要删除选中的数据吗？";
			var tmpGrid;
			if (grid_type == "grid_brand") {
				tmpGrid = grid_brand;
				cf1 += "<br><p style='font-size:12px; color:red'>注意：删除品牌，将同时删除所属的商品，并删除该品牌下的所有设置。不可恢复，请谨慎操作。</p>";
			}
			else if (grid_type == "grid_product") {
				tmpGrid = grid_product;
				cf1 += "<br><p style='font-size:12px; color:red'>注意：删除商品，将同时删除该商品下的规格及其他所有设置,不可恢复，请谨慎操作.</p>";
			}
			else if (grid_type == "grid_product_size") {
				tmpGrid = grid_product_size;
				cf1 += "<br><p style='font-size:12px; color:red'>注意：删除商品规格，不可恢复，请谨慎操作.</p>";
			}
			
        	var rows = tmpGrid.getSelecteds();
        	
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要删除的数据.",{icon:6});
       		 	return;
       	 	}
       	 	
       	 	if (grid_type == "grid_brand") {
				//删除品牌时，判断是否有下级商品
				var tmpData = grid_product.getData();
				if (tmpData.length > 0) {
					parent.parent.layer.msg("要删除的品牌下包含商品，只有空的品牌才可以删除。请先删除商品.",{icon:6});
					return;
				}
			}
			else if (grid_type == "grid_product") {
				//删除品牌时，判断是否有下级商品
				var tmpData = grid_product_size.getData();
				if (tmpData.length > 0) {
					parent.parent.layer.msg("要删除的商品下包含规格，只有空的商品才可以删除。请先删除商品规格.",{icon:6});
					return;
				}
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
       	
		function save(grid_type) {
			
			var tmpGrid;
			var url = "${pageContext.request.contextPath}/product/save.htmls";
			var savetype = "brand";
			if (grid_type == "grid_brand") {
				tmpGrid = grid_brand;
			}
			else if (grid_type == "grid_product") {
				tmpGrid = grid_product;
				savetype = "product";
			}
			else if (grid_type == "grid_product_size") {
				tmpGrid = grid_product_size;
				savetype = "productsize";
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
	            data: {'objs':json,'savetype':savetype},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	parent.parent.layer.msg("保存完毕。",{icon:6});
	            	tmpGrid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                mini.alert(jqXHR.responseText);
	            }
	        });
	    }
		
		function edit(id,showtype){
			if(id == 'undefined'){
				parent.parent.layer.msg("请先保存信息，再添加内容。",{icon:6});
				return;
			}
			var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	   		
	   		if (showtype == 1) {
		   		 mini.open({
		             url: "${pageContext.request.contextPath}/public/edit_o.htmls?parentid="+id +"&parenttype=productrich",
		             title: "内容编辑", width: pWidth-300, height:pHeight-100,
		             allowResize:true,
		             showMaxButton:true,
		             onload: function () {
		            	 
		             },
		             ondestroy: function (action) {
		            	 
		             }
		         });
	   		}
	   		else {
	   			mini.open({
	   				url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/productContentPic",
		            title: "内容编辑-图片", width: 600, height:pHeight-100,
		            allowResize:true,
		            showMaxButton:true,
		            onload: function () {
		            	var iframe = this.getIFrameEl();
		    	        var data = { parentid: id,parenttype:"productContentPic"};
		    	        iframe.contentWindow.SetData(data);
		            },
		            ondestroy: function (action) {
		            	 
		            }
		        });
	   		}
	        
		}
		
		function setLinkids(id) {
			if(id == 'undefined' || id == ""){
				parent.parent.layer.msg("请先保存信息，再添加内容。",{icon:6});
				return;
			}
			
			var row = grid_product_size.getRow(id);
			
			var pWidth = $(window.parent).width();
			var pHeight = $(window.parent).height();
			mini.open({
   				url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/setProductLinkids",
	            title: "设置商品详细页推荐商品", width: pWidth - 300, height:pHeight-100,
	            allowResize:true,
	            showMaxButton:true,
	            onload: function () {
	            	var iframe = this.getIFrameEl();
	    	        var data = { id: id,linkids:row.linkids};
	    	        iframe.contentWindow.SetData(data);
	            },
	            ondestroy: function (action) {
	            	grid_product_size.reload();
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
		
</script>
</head>
<body>
	<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
   		<div size="50%" showCollapseButton="false" style="border-width: 1;">
   			<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
   				<div size="50%" showCollapseButton="false" style="border-width: 1;">
			    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
				        <table style="width:100%;">
				            <tbody>
				             <tr>
				                 <td style="width:100%;">
				                 	<span id="pid" style="padding-left:5px;">品牌列表</span>
				                 </td>
				                 <td style="white-space:nowrap;">
				                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_brand')">新增</a>
				                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brand')">删除</a>
					                <span class="separator"></span>
					         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brand')">保存</a>
				                 </td>
				             </tr>
				         </tbody>
				        </table>
				    </div>
				    <div class="mini-fit">
				        <div id="grid_brand" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
				    </div>
				</div>
				<div showCollapseButton="true">
					<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
			            <table style="width:100%;">
			                <tbody>
				                <tr>
				                    <td style="width:100%;">
				                    	<span id="pid" style="padding-left:5px;">商品列表</span>
				                    </td>
				                    <td style="white-space:nowrap;">
				                    	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_product')">新增</a>
				                 		<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_product')">删除</a>
						                <span class="separator"></span>
						         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_product')">保存</a>
				                    </td>
				                </tr>
				            </tbody>
			            </table>
			        </div>
			        <div class="mini-fit">
			            <div id="grid_product" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
			        </div>
				</div>
			</div>
		</div>
		<div showCollapseButton="true">
   			<div class="mini-toolbar" borderStyle="border:0;">
		        <table style="width:100%;">
		            <tbody>
		             <tr>
		                 <td style="width:100%;">
		                 	<span id="pid" style="padding-left:5px;">商品规格</span>
		                 </td>
		                 <td style="white-space:nowrap;">
		                  	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_product_size')">新增</a>
		                  	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addCopyRow()">新增[克隆]</a>
		                	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_product_size')">删除</a>
			                <span class="separator"></span>
			         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_product_size')">保存</a>
		                 </td>
		             </tr>
		         </tbody>
		        </table>
		    </div>
		    <div class="mini-fit"><!-- border-bottom: 1;border-top: 0;border-left:0;broder-right:0" -->
		        <div id="grid_product_size" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border-bottom: 1;border-top: 1;border-left:0;border-right:0;"></div>
		    </div>
   		</div>
	</div>
</body>
</html>