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
		//页面分类
		var ptype = '${ptype}';
		var grid;
		var columns = [];
       	$(function(){
       		//
       		columns= [
 						{ type: "checkcolumn",headerAlign:"center",width: 50},
       	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
       	              	{ field: "action", width: 160, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
       	              	{ field: "title",name:"title", width: 380, headerAlign: "center", align:"center",allowSort: false, header: "标题",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
       	              	{ field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
       	              	{ field: "sort",name:"sort", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
       	            ];

       		//
       		if(ptype == "subject"){
    			$("#ptitle").html("专题制作");
       		}else if(ptype == "faq"){
    			$("#ptitle").html("FAQ");
    		}else if(ptype == "lxwm"){
    			$("#ptitle").html("联系我们");
    		}else if(ptype == "job"){
    			$("#ptitle").html("工作招聘");
    		}else if(ptype == "join"){
    			$("#ptitle").html("区域合作");
    		}else if(ptype == "policy"){
    			$("#ptitle").html("隐私政策 ");
    		}else if(ptype == "partner"){
    			$("#ptitle").html("合作伙伴 ");
    		}else if(ptype == "law"){
    			$("#ptitle").html("法律声明 ");
    		}else if(ptype == "mrwz" || ptype == "case" || ptype == "news_hy" || ptype == "news_qy" || ptype == "news_sp"){
    			if(ptype == "mrwz")
    				$("#ptitle").html("美容文章 ");
    			else if(ptype == "case")
    				$("#ptitle").html("案例库");
    			else if(ptype == "news_hy")
    				$("#ptitle").html("行业新闻");
    			else if(ptype == "news_hy")
    				$("#ptitle").html("企业新闻");
    			else if(ptype == "news_hy")
    				$("#ptitle").html("商品新闻");
    			columns =[
  							{ type: "checkcolumn",headerAlign:"center",width: 50},
        	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
        	              	{ field: "action", width: 160, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
        	                { field: "pic_url",name:"pic_url", width: 100, headerAlign: "center", align:"center",allowSort: false, header: "图片(300*200)",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnNewsPicEdit"} },
        	              	{ field: "title",name:"title", width: 380, headerAlign: "center", align:"center",allowSort: false, header: "标题",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
        	              	{ field: "brief",name:"brief", width: 380, headerAlign: "center", align:"center",allowSort: false, header: "简介",vtype:"required",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} },
        	              	{ field: "isshow",name:"isshow",type:"comboboxcolumn", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "是否显示",vtype:"required",editor: { type: "combobox", data: [{"id":"0","text":"隐藏"},{"id":"1","text":"显示"}] } },
        	              	{ field: "sort",name:"sort", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "排序",vtype:"required;int",editor: { type: "textbox", minValue: 0, maxValue: 500, value: 25} }
        	            ];
    		}
       		
    		//初始化
       		mini.parse();
			grid = mini.get("grid");
        	grid.set({
        		url:"${pageContext.request.contextPath}/public/list.htmls",
        		columns: columns,
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
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	grid.load({act:'public_content',parentid:'content',parenttype:ptype});
        	drawcell();
        })
        
        function drawcell() {
       		grid.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "pic_path") {
   	        		if (value == "") {
   	        			e.cellhtml = "";
       	        	}else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' width='60px' />";
   	        		}
    	        }
                if (field == "pic_url") {
   	        		if (value == undefined) {
   	        			e.cellhtml = "";
       	        	}else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' height='30px' />";
   	        		}
    	        }
            });
        }
       	
      	//表格渲染
		function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
           	var id = record.id;
           	var s = ' <a class="Edit_Button" href="javascript:edit(\'' + id + '\')" >内容</a>'
           	if(ptype == "subject" || ptype == "mrwz" || ptype == "case" || ptype == "news_hy" || ptype == "news_qy" || ptype == "news_sp"){
                s += '  <a class="Edit_Button" href="javascript:getUrl(\'' + id + '\')" >获取地址</a>';
           	}
            return s;
        }
      
       	//添加行
		function addRow() {
            var newRow = {
            		sort: 1,
            		isshow:0
            		};
            grid.addRow(newRow, 0);
            grid.beginEditCell(newRow, "title");
        }
		//删除行
		function delRow() {
			var cf1 = "确定要删除选中的数据吗？<br><p style='font-size:12px; color:red'>注意：删除后，不可恢复，请谨慎操作.</p>";
        	var rows = grid.getSelecteds();
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择要删除的数据.",{icon:6});
       		 	return;
       	 	}
       	 
	       	parent.parent.layer.msg(cf1, {
	 	 		icon:3
	 	 		,time: 0 //不自动关闭
	 	  		,btn: ['确认删除', '取消']
	 	  		,yes: function(index){
	 	  			grid.removeRows(rows, false);
	 	    		parent.parent.layer.close(index);
	 	  		}
	 		});
        }
       	//保存
		function save() {
	    	grid.validate();
	        if (grid.isValid() == false) {
	        	parent.parent.layer.msg('输入有误，请校验输入单元格内容', {
	        		  icon: 5,
	        		  time: 2000 //2秒关闭（如果不配置，默认是3秒）
	        		}, function(){
	        			var error = grid.getCellErrors()[0];
	            		grid.beginEditCell(error.record, error.column);
	        		}
	        	);
	            return;
	        }
	    	
	        var objs = grid.getChanges();
	        var json = mini.encode(objs,"yyyy-MM-dd HH:mm:ss");
	        if (json.length == 2) {
	        	parent.parent.layer.msg("没有发现修改的内容，请直接修改，然后再保存",{icon:6});
	        	return;
	        }
	        grid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: "${pageContext.request.contextPath}/public/save.htmls",
	            data: {'objs':json,'act':'public_content','parentid':'content','parenttype':ptype},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	parent.parent.layer.msg("保存完毕",{icon:6});
	            	grid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	            	parent.parent.layer.msg(jqXHR.responseText,{icon:6});
	            }
	        });
	    }
		
		//富文本-编辑内容
		function edit(id){
			if(id == 'undefined'){
				parent.parent.layer.msg("请先保存数据，再操作!",{icon:6});
				return;
			}
			var pHeight = $(window.parent).height();
	   		var pWidth = $(window.parent).width();
	         mini.open({
	             url: "${pageContext.request.contextPath}/public/edit.htmls?id="+id,
	             title: "内容编辑", width: pWidth-200, height:pHeight-100,
	             allowResize:true,
	             showMaxButton:true,
	             onload: function () {
	            	 var iframe = this.getIFrameEl();
	            	 var data = { 'id': id };
	                 
	                 //iframe.contentWindow.SetData(data);
	             },
	             ondestroy: function (action) {
	            	 //grid.reload();
	             }
	         });
		}
		
		//获取URL
		function getUrl(id) {
       		var serv_path = "${pageContext.request.contextPath}/pcMain/";
       		//if(ptype == "subject" || ptype == "mrwz" || ptype == "case" || ptype == "news_hy" || ptype == "news_qy" || ptype == "news_sp"){
       		if (ptype == "subject") {
       			//如果是专题
       			serv_path += "subject.htmls";
       		}
       		else if (ptype == "mrwz") {
       			//如果是美容文章
       			serv_path += "article-c.htmls";
       		}
       		else if (ptype == "case") {
       			//如果是案例库
       			serv_path += "cases-c.htmls";
       		}
       		else if (ptype == "news_hy" || ptype == "news_qy" || ptype == "news_sp") {
       			serv_path += "news-c.htmls";
       		}
       		else {
       			parent.parent.layer.msg("获取错误。请与开发商联系。",{icon:6});
       			return;
       			//这里不应该获取商品详情       			
       			//serv_path += "product_c.htmls";
       		}
       		parent.parent.layer.msg(serv_path + "?id=" + id,{icon:6,time:5000});
       	}
		
		//上传文章图片
		function onBtnNewsPicEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid.getEditorOwnerRow(buttonEdit);
        	
        	if (null == row || typeof(row.id) == "undefined" || row.id == "") {
        		parent.parent.layer.msg("行记录还没有保存，请先保存后再上传.",{icon:6});
	      		return;
	      	}
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传文章图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"upload",forObj:"public_content_pic"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid.cancelEdit();
            		grid.reload();
                }
            });
        }
</script>
</head>
<body>
	<div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <table style="width:100%;">
            <tbody>
             <tr>
                 <td style="width:100%;">
                 	<span id="ptitle" style="padding-left:5px;"></span>
                 </td>
                 <td style="white-space:nowrap;">
                 	<a class="mini-button" iconCls="icon-add" plain="true" onclick="addRow()">新增</a>
                 	<a class="mini-button" iconCls="icon-remove" plain="true" onclick="delRow()">删除</a>
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
</body>
</html>