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
		var grid_brandlist;
		var grid_brandlist_lb_pic;
		var grid_brandlist_pic;
		var grid_brandlist_v;
		
		
		
       	$(function(){
       		//mini.parse();
       		
			grid_brand = mini.get("grid_brand");
			grid_brand.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 30},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
      	                { field: "brandlogo",name:"brandlogo", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌Logo",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onButtonEdit"} },
      	                { field: "brandname",name:"brandname", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "品牌名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "brandpath",name:"brandpath",type:"comboboxcolumn", autoEscape:true,width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌显示位置",vtype:"required",editor: { type: "combobox", data: [{"id":"1","text":"PC端展示"},{"id":"2","text":"移动商城展示"}] } },
      	                { field: "isshow",name:"isshow",type:"comboboxcolumn",autoEscape:true, width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
      	                { field: "brandcolor",name:"brandcolor", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "品牌颜色",vtype:"required",editor: {  type: "buttonedit",allowInput:false,onbuttonclick:"onBtnColorEdit"  } },
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
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            //fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			grid_brand.load({ listtype: 'brand' });
			//drawcell();
			
			grid_brandlist = mini.get("grid_brandlist");
			grid_brandlist.set({
        		url:"${pageContext.request.contextPath}/product/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	                { field: "pic",name:"pic", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "品牌系列主图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnBrandListEdit" } },
      	              	{ field: "listname",name:"listname", width: 250, headerAlign: "center", align:"center",allowSort: false, header: "系列页名称",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "picurl",name:"picurl", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "图片点击url",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "sort",name:"sort", width: 50, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
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
	            //fitColumns:false,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	
			grid_brandlist_lb_pic = mini.get("grid_brandlist_lb_pic");
			grid_brandlist_lb_pic.set({
        		url:"${pageContext.request.contextPath}/public/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	                { field: "pic_path",name:"pic_path", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "品牌系列页轮播图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnBrandListLBPicEdit" } },
      	              	{ field: "pic_active",name:"pic_active",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
      	              	{ field: "pic_url",name:"pic_url", width: 350, headerAlign: "center", align:"center",allowSort: false, header: "图片点击URL",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "pic_sort",name:"pic_sort", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "pic_memo",name:"pic_memo", width: 450, headerAlign: "center", align:"center",allowSort: false, header: "图片描述",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            //onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            //fitColumns:false,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
			grid_brandlist_v = mini.get("grid_brandlist_v");
			grid_brandlist_v.set({
        		url:"${pageContext.request.contextPath}/public/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	              	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	                { field: "videoshowpic",name:"videoshowpic", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "视频封面图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnVideoPicEdit" } },
      	              	{ field: "mp4oldname",name:"mp4oldname", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "本站视频mp4名称",editor: {  type:"buttonedit",allowInput:false,onbuttonclick:"onBtnMp4VideoEdit" } },
      	              	{ field: "webmoldname",name:"webmoldname", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "本站视频webm名称",editor: {  type:"buttonedit",allowInput:false,onbuttonclick:"onBtnWebmVideoEdit" } },
      	              	{ field: "videopath",name:"videopath", width: 280, headerAlign: "center", align:"center",allowSort: false, header: "外站视频地址",editor: {  type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "islocal",name:"islocal",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "视频来源",editor: { type: "combobox", data: [{"id":"0","text":"本站"},{"id":"1","text":"外站"}] } },
      	              	{ field: "sort",name:"sort", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } }
      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            //onselectionchanged:"onSelectionChanged",
	            //oncellbeginedit:"OnCellBeginEdit",
	            //oncellcommitedit:"onCellCommitEdit",
	            //fitColumns:false,
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
			
			grid_brandlist_pic = mini.get("grid_brandlist_pic");
			grid_brandlist_pic.set({
        		url:"${pageContext.request.contextPath}/public/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	                { field: "pic_path",name:"pic_path", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "品牌系列页图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnBrandListPicEdit" } },
      	              	{ field: "pic_active",name:"pic_active",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
      	              	{ field: "pic_url",name:"pic_url", width: 350, headerAlign: "center", align:"center",allowSort: false, header: "图片点击URL",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	              	{ field: "pic_sort",name:"pic_sort", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
      	                { field: "pic_memo",name:"pic_memo", width: 450, headerAlign: "center", align:"center",allowSort: false, header: "图片描述",editor: { type: "textarea",minWidth:"200",minHeight:"100", minValue: 0, maxValue: 500, value: 25} }
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
        
        function drawcell() {
       		grid_brand.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "brandlogo") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
   	        		}
    	        }
                if (field == "brandcolor") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "";
   	        		}
    	        }
         	});
       		
       		grid_brandlist.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "pic") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
   	        		}
    	        }
         	});
       		
       		grid_brandlist_v.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "videoshowpic") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
   	        		}
    	        }
         	});
       		
       		grid_brandlist_lb_pic.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "pic_path") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
   	        		}
    	        }
                
                if (field == "pic_active") {
                	if (value == 0){
   	        			e.cellStyle = "color:red;text-align:center";
   	        		}
   	        		else if (value == 1) {
   	        			e.cellStyle = "color:blue;text-align:center";
   	        		}
    	        }
         	});
       		grid_brandlist_pic.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "pic_path") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='60px' />";
   	        		}
    	        }
                
                if (field == "pic_active") {
                	if (value == 0){
   	        			e.cellStyle = "color:red;text-align:center";
   	        		}
   	        		else if (value == 1) {
   	        			e.cellStyle = "color:blue;text-align:center";
   	        		}
    	        }
         	});
       		
       	}
       	
       	function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var uid = record._uid;
            var id = record.id;
            var rowIndex = e.rowIndex;
            
            var videoshowpic = record.videoshowpic;
            var mp4path = record.mp4newname;
            var webmpath = record.webmnewname;
            if (typeof(mp4path) == "undefined" || mp4path == "" || typeof(webmpath) == "undefined" || webmpath == "" ) {
            	alert("请先上传mp4和webm视频文件，在播放视频。")
            	return;
            }

            var s = ' <a class="Edit_Button" href="javascript:showVideo(\'' + videoshowpic + '\',\'' + mp4path + '\',\'' + webmpath + '\')" >播放视频</a>'
            return s;
        }
       	
       	function showVideo(videoshowpic,mp4path,webmpath) {
       		//TODO 要判断是本站还是外站视频。处理方法会不一样。
       		mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/show_video",
                title: "播放系列页视频", width: 800, height:600,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {videoshowpic:videoshowpic,mp4path:mp4path,webmpath:webmpath};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                }
            });
       	}
       	
       	function onSelectionChanged(e) {
            var grid = e.sender;
	       	//处理对应
            var record = grid.getSelected();
	      	
            if (typeof(record.id) == "undefined" || record.id == "") {
            	if (grid.id == 'grid_brand') {
            		grid_brandlist.setData([]);
                	grid_brandlist.setTotalCount(0);
                	
                	grid_brandlist_lb_pic.setData([]);
                	grid_brandlist_lb_pic.setTotalCount(0);
                	grid_brandlist_v.setData([]);
                	grid_brandlist_v.setTotalCount(0);
                	grid_brandlist_pic.setData([]);
                	grid_brandlist_pic.setTotalCount(0);
            	}
            	else if (grid.id == "grid_brandlist") {
            		grid_brandlist_lb_pic.setData([]);
                	grid_brandlist_lb_pic.setTotalCount(0);
                	grid_brandlist_v.setData([]);
                	grid_brandlist_v.setTotalCount(0);
                	grid_brandlist_pic.setData([]);
                	grid_brandlist_pic.setTotalCount(0);
            	}
	      		return;
	      	}
            
            if (record) {
            	if (grid.id == 'grid_brand') {
            		grid_brandlist.load({listtype:'brandlist', parentid: record.id });
            	}
            	else if (grid.id == "grid_brandlist") {
            		grid_brandlist_lb_pic.load({act:'publicpic', parentid:record.id,parenttype:'brandlist_lb_pic' });
            		grid_brandlist_pic.load({act:'publicpic', parentid:record.id,parenttype:'brandlist_pic' });
            		grid_brandlist_v.load({act:'publicvideo', parentid:record.id,parenttype:'brandlist_video' });
            	}
            }
        }
       	
       	function upload_public_pic(gridtype) {
       		
       		var parenttype = "brandlist_lb_pic";
       		if (gridtype == "grid_brandlist_lb_pic") {
				tmpGrid = grid_brandlist_lb_pic;
			}
			else {
				tmpGrid = grid_brandlist_pic;
				parenttype = "brandlist_pic";
			}
       		
       		//获取系列
       		var record = grid_brandlist.getSelected();
	      	
            if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	alert("请先选择品牌系列，在上传品牌系列页图片.");
	      		return;
	      	}
	    	mini.open({
	    	    url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/upload_pic",
	    	    title: "上传品牌系列页图片", width: 600, height: 400,
	    	    onload: function () {
	    	        var iframe = this.getIFrameEl();
	    	        var data = { parentid: record.id,parenttype:parenttype};
	    	        iframe.contentWindow.SetData(data);
	    	    },
	    	    ondestroy: function (action) {
	    	    	tmpGrid.reload();
	    	    }
	    	});
		}
       	
		function addRow() {
			
			//获取品牌
       		var record = grid_brand.getSelected();
			
            if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	alert("请先选择品牌，再添加品牌系列页内容.");
	      		return;
	      	}
			
			var newRow = {};
			newRow.parentid = record.id;
			newRow.listname = "";
			newRow.sort = 1;
			newRow.pic = "";
			newRow.picurl = "";
			
			grid_brandlist.addRow(newRow, 0);
			grid_brandlist.beginEditCell(newRow, "listname");
        }
		
		function addVideoRow() {
			
			//获取品牌
       		var record = grid_brandlist.getSelected();
			
            if (null == record || typeof(record.id) == "undefined" || record.id == "") {
            	alert("请先选择系列，再添加视频内容.");
	      		return;
	      	}
			
			var newRow = {};
			newRow.parentid = record.id;
			newRow.parenttype = "brandlist_video";
			newRow.videoshowpic = "";
			newRow.videopath = "";
			newRow.mp4oldname = "";
			newRow.mp4newname = "";
			newRow.webmoldname = "";
			newRow.webmnewname = "";
			newRow.islocal = "0";
			newRow.sort = "1";
			newRow.isshow = "0";
			
			grid_brandlist_v.addRow(newRow, 0);
			grid_brandlist_v.beginEditCell(newRow, "videoshowpic");
        }
		
		function delRow(grid_type) {
			
			var cf1 = "确定要删除选中的数据吗？";
			var tmpGrid;
			if (grid_type == "grid_brandlist") {
				tmpGrid = grid_brandlist;
			}
			else if (grid_type == 'grid_brandlist_lb_pic'){
				tmpGrid = grid_brandlist_lb_pic;
			}
			else if (grid_type == 'grid_brandlist_pic') {
				tmpGrid = grid_brandlist_pic;
			}
			else if (grid_type == 'grid_brandlist_v') {
				tmpGrid = grid_brandlist_v;
			}
			
        	var rows = tmpGrid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		alert("请选择要删除的数据.");
       		 	return;
       	 	}
       	 	
       	 	mini.confirm("确定删除记录？", "确定？",
                 function (action) {
                     if (action == "ok") {
                    	 tmpGrid.removeRows(rows, false);
                     } else {
                         
                     }
                 }
             );
       	 
          	/* if (confirm(cf1)) {
          		tmpGrid.removeRows(rows, false);
   		 	} */
			
        }
       	
		function save(gridtype) {
			
			var url = "${pageContext.request.contextPath}/product/save.htmls";
			
			var tmpGrid;
			var pams = {};
			var savetype = "";
			if (gridtype == "grid_brandlist") {
				tmpGrid = grid_brandlist;
				pams.savetype = "brandlist";
				
			}
			else if (gridtype == "grid_brandlist_pic"){
				
				var record = grid_brandlist.getSelected();
		      	
	            if (typeof(record.id) == "undefined" || record.id == "") {
	            	alert("请先选择系列，再添加品牌系列页图片.");
		      		return;
		      	}

	            
				tmpGrid = grid_brandlist_pic;
				url = "${pageContext.request.contextPath}/public/save.htmls";
				pams.act = "publicpic";
				pams.parentid = record.id;
				pams.parenttype = "brandlist_pic"
			}
			else if (gridtype == "grid_brandlist_lb_pic") {
				var record = grid_brandlist.getSelected();
		      	
	            if (typeof(record.id) == "undefined" || record.id == "") {
	            	alert("请先选择系列，再添加品牌系列页轮播图片.");
		      		return;
		      	}
	            
				tmpGrid = grid_brandlist_lb_pic;
				url = "${pageContext.request.contextPath}/public/save.htmls";
				pams.act = "publicpic";
				pams.parentid = record.id;
				pams.parenttype = "brandlist_lb_pic"
			}
			else if (gridtype == "grid_brandlist_v") {
				var record = grid_brandlist.getSelected();
		      	
	            if (typeof(record.id) == "undefined" || record.id == "") {
	            	alert("请先选择系列，再添加品牌系列页视频.");
		      		return;
		      	}
	            
				tmpGrid = grid_brandlist_v;
				url = "${pageContext.request.contextPath}/public/save.htmls";
				pams.act = "publicvideo";
				pams.parentid = record.id;
				pams.parenttype = "brandlist_video"
			}
			
			tmpGrid.validate();
	        if (tmpGrid.isValid() == false) {
	            alert("输入有误，请校验输入单元格内容");
	            var error = tmpGrid.getCellErrors()[0];
	            tmpGrid.beginEditCell(error.record, error.column);
	            return;
	        }
	    	
	        var objs = tmpGrid.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        
	        pams.objs = json;
	        tmpGrid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: url,
	            data: pams,
/* 	            data: {'objs':json,'savetype':savetype}, */
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	alert("保存完毕。");
	            	tmpGrid.reload();
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
		
		function onBtnBrandListEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid_brandlist.getEditorOwnerRow(buttonEdit);
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传品牌系列页主图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"pic",forObj:"brandlist"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid_brandlist.cancelEdit();
                	grid_brandlist.reload();
                }
            });
        }
		function onBtnVideoPicEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid_brandlist_v.getEditorOwnerRow(buttonEdit);
        	
        	if (typeof(row.id) == "undefined" || row.id == "") {
        		alert("行记录还没有保存，请先保存后再上传.");
        		return;
        	}
        	
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传系列页视频主图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"pic",forObj:"video"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid_brandlist_v.cancelEdit();
                	grid_brandlist_v.reload();
                }
            });
        }
		
		//上传修改系列页轮播图片。单张修改
		function onBtnBrandListLBPicEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid_brandlist_lb_pic.getEditorOwnerRow(buttonEdit);
        	
        	if (typeof(row.id) == "undefined" || row.id == "") {
        		alert("行记录还没有保存，请先保存后再上传.");
        		return;
        	}
        	
        	mini.open({
                url:"${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传修改系列页轮播图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"upload",forObj:"publicpic"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid_brandlist_lb_pic.cancelEdit();
                	grid_brandlist_lb_pic.reload();
                }
            });
        }
		
		//上传修改系列页图片。单张修改
		function onBtnBrandListPicEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid_brandlist_pic.getEditorOwnerRow(buttonEdit);
        	
        	if (typeof(row.id) == "undefined" || row.id == "") {
        		alert("要系列页的行记录还没有保存，请先保存后再上传.");
        		return;
        	}
        	
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传修改系列页图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"upload",forObj:"publicpic"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid_brandlist_pic.cancelEdit();
                	grid_brandlist_pic.reload();
                }
            });
        }
		//上传Mp4文件
		function onBtnMp4VideoEdit(e) {
        	var buttonEdit = e.sender;
        	var record = grid_brandlist_v.getEditorOwnerRow(buttonEdit);
        	if (typeof(record.id) == "undefined" || record.id == "") {
        		alert("要上传视频的行记录还没有保存，请先保存后再上传视频.");
        		return;
        	}
        	
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/upload_video",
                title: "上传修改系列页视频", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:record.id,videotype:"mp4"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid_brandlist_v.cancelEdit();
                	grid_brandlist_v.reload();
                }
            });
        }
		//上传Mp4文件
		function onBtnWebmVideoEdit(e) {
        	var buttonEdit = e.sender;
        	var record = grid_brandlist_v.getEditorOwnerRow(buttonEdit);
        	if (typeof(record.id) == "undefined" || record.id == "") {
        		alert("要上传视频的行记录还没有保存，请先保存后再上传视频.");
        		return;
        	}
        	
        	mini.open({
                url: "${pageContext.request.contextPath}/common/dispatch.htmls?page=/view/system/content/upload_video",
                title: "上传修改系列页视频", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:record.id,videotype:"webm"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid_brandlist_v.cancelEdit();
                	grid_brandlist_v.reload();
                }
            });
        }
        
        
        //以下不确定要
        
        /* function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
            var uid = record._uid;
            var id = record.id;
            var rowIndex = e.rowIndex;
            var productname = record.productname;

            var s = ' <a class="Edit_Button" href="javascript:editRated(\'' + id + '\',\'' + productname + '\')" >评价</a>'
            s += '  <a class="Edit_Button" href="javascript:delete_book(\'' + uid + '\')" >详细</a>';
            return s;
        } */
        
       		/* grid_product.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "productpic") {
                	if (typeof(value) == "undefined" || value == "") {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' width='60px' />";
   	        		}
    	        }
            }); */
        
       	
       	
       	
       	function onBtnColorEdit(e) {
        	var buttonEdit = e.sender;
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/selectColor",
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
                        	var row = grid_brand.getEditorOwnerRow(buttonEdit);
                            //var row = grid_book.getSelecteds();
                            grid_brand.cancelEdit();
                            grid_brand.updateRow(row, {
                            	brandcolor:color_data
                            });
                        }
                    }
                }
            });
        }
       	
        function editRated(id,productname) {
        	
        	var title = "商品评价";
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/editRated",
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
        
		
		
</script>
</head>
<body>
<div class="mini-splitter" style="width:100%;height:100%;">
	<div size="300" showCollapseButton="true">
		<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
	        <table style="width:100%;">
	            <tbody>
	             <tr>
	                 <td style="width:100%;">
	                 	<span id="pid" style="padding-left:5px;">品牌列表</span>
	                 </td>
	                 <td style="white-space:nowrap;">
	                 	<!-- <a class="mini-button" iconCls="icon-tip" plain="true" onclick="addRow('grid_brand')">查看综合页效果</a>
	                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brand')">删除</a>
		                <span class="separator"></span>
		         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brand')">保存</a> -->
	                 </td>
	             </tr>
	         	</tbody>
	        </table>
	    </div>
	    <div class="mini-fit">
	        <div id="grid_brand" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
	    </div>
	</div>
	<div showCollapseButton="false" >
		<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;" vertical="true">
	   		<div size="50%" showCollapseButton="false" ><!-- style="border-width: 1;" -->
		    	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
			        <table style="width:100%;">
			            <tbody>
			             <tr>
			                 <td style="width:100%;">
			                 	<span id="pid" style="padding-left:5px;">系列列表</span>
			                 </td>
			                 <td style="white-space:nowrap;">
			                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow('grid_brandlist')">添加</a>
			                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandlist')">删除</a>
				                <span class="separator"></span>
				         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brandlist')">保存</a>
				         		<a class="mini-button" iconCls="icon-tip" plain="true" onclick="showRow('grid_brand')">查看系列页效果</a>
			                 </td>
			             </tr>
			         	</tbody>
			        </table>
			    </div>
			    <div class="mini-fit">
			        <div id="grid_brandlist" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div> 
			    </div>
			</div>
			<div showCollapseButton="true">
	   			<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" borderStyle="padding:0;border:0;">
		        	<div name="brandlistPic" title="系列页轮播图片">
		                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
				    		 <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="upload_public_pic('grid_brandlist_lb_pic')">上传</a>
					     	 <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandlist_lb_pic')">删除</a>
					     	 <span class="separator"></span>
					         <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brandlist_lb_pic')">保存</a>
					     </div>
				        <div class="mini-fit" >
					         <div id="grid_brandlist_lb_pic" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
					    </div>
		            </div>
		            <div name="brandlist_v" title="系列页视频">
		                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
					         <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="addVideoRow()">新增</a>
					         <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandlist_v')">删除</a>
					         <span class="separator"></span>
					         <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brandlist_v')">保存</a>
					         <span class="separator"></span>
					     </div>
				        <div class="mini-fit" >
					         <div id="grid_brandlist_v" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
					     </div>
		            </div>
		            <div name="brandlist" title="系列页图片">
		                <div class="mini-toolbar" style="padding:3px;border-top:0;border-left:0;border-right:0;border-bottom:1;">
		                	<a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="upload_public_pic('grid_brandlist_pic')">上传</a>
					         <!-- <a class="mini-button" plain="true" iconCls="icon-addfolder" onclick="addRow()">新增</a> -->
					         <a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow('grid_brandlist_pic')">删除</a>
					         <span class="separator"></span>
					         <a class="mini-button" iconCls="icon-save" plain="true" onclick="save('grid_brandlist_pic')">保存</a>
					         <span class="separator"></span>
					     </div>
				        <div class="mini-fit" >
					         <div id="grid_brandlist_pic" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
					     </div>
		            </div>
		        </div>
	   		</div>
		</div>
	</div>
	
</div>
</body>
</html>