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
		
       	$(function(){
       		//mini.parse();
       		
			grid = mini.get("grid");
        	grid.set({
        		url:"${pageContext.request.contextPath}/public/list.htmls",
        		columns: [
						{ type: "checkcolumn",headerAlign:"center",width: 50},
      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:50},
      	              	{ field: "action", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作",renderer:"onActionRenderer",cellStyle:"padding:0;"},
      	                { field: "videoshowpic",name:"videoshowpic", width: 150, headerAlign: "center", align:"center",allowSort: false, header: "视频封面图片",editor: { type:"buttonedit",allowInput:false,onbuttonclick:"onBtnVideoPicEdit" } },
      	              	{ field: "mp4oldname",name:"mp4oldname",id:"mp4", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "本站视频mp4名称",editor: {  type:"buttonedit",allowInput:false,onbuttonclick:"onBtnMp4VideoEdit" } },
      	              	{ field: "webmoldname",name:"webmoldname",id:"webm", width: 200, headerAlign: "center", align:"center",allowSort: false, header: "本站视频webm名称",editor: {  type:"buttonedit",allowInput:false,onbuttonclick:"onBtnWebmVideoEdit" } },
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
	            fitColumns:false,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	grid.load({act:'publicvideo',parentid:'video',parenttype:'edit_video'});
        	drawcell();
        })
        
        function drawcell() {
       		grid.on("drawcell", function (e) {
                var record = e.record,
	            column = e.column,
	            field = e.field,
	            uid = record._uid,
	            value = e.value;
                
                if (field == "videoshowpic") {
   	        		if (value == undefined) {
   	        			e.cellhtml = "";
       	        	}
   	        		else {
   	        			e.cellStyle = "background-color:"+value+";text-align:center";
   	        			e.cellHtml = "<img src='${pageContext.request.contextPath}/" + value + "' width='60px' />";
   	        		}
    	        }
                /* if(field == "videopath"){
                	var mp4 = record.mp4newname;
                	var webm = record.webmnewname;
                	var path = ''
                		+'&lt;video id="preview-player" class="video-js vjs-fluid placeholder vjs-big-play-centered" controls preload="auto" poster=""  data-setup="{}">'
        		    	+'<source src="'+mp4+'" type="video/mp4"></source>'
        		    	+'<source src="'+webm+'" type="video/webm"></source>'
        				+'</video>';
                	e.cellHtml = path;
                } */
            });
        }
       	
		function addRow() {
       		
            var newRow = {
            		accountcode: "",
            		accountname:""
            		};
            grid.addRow(newRow, 0);
            grid.beginEditCell(newRow, "accountcode");
        }
		
		function delRow() {
        	var cf1 = "确定要删除选中的帐户吗？<br>&nbsp;&nbsp;&nbsp;&nbsp;注意：不可恢复，请谨慎操作。";
        	
        	var rows = grid.getSelecteds();
          	 
       	 	if (rows.length == 0) {
       	 		mini.alert("请选择要删除的数据");
       		 	return;
       	 	}
       	 
       	 	mini.confirm(cf1, "系统提示",
                 function (action) {
                     if (action == "ok") {
                    	 grid.removeRows(rows, false);
                     }
                 }
             );
       	 
        }
       	
		function save() {
	    	grid.validate();
	        if (grid.isValid() == false) {
	            mini.alert("输入有误，请校验输入单元格内容","系统提示",
	            	function(action){
	            		//alert(action);
	            		var error = grid.getCellErrors()[0];
	            		grid.beginEditCell(error.record, error.column);
		            }
	            );
	            return;
	        }
	    	
	        var objs = grid.getChanges();
	        var json = mini.encode(objs);
	        if (json.length == 2) {
	        	mini.alert("没有发现修改的内容，请直接修改，然后再保存");
	        	return;
	        }
	        grid.loading("保存中，请稍后......");
	        
	        $.ajax({
	        	async:false,
	            url: "${pageContext.request.contextPath}/public/save.htmls",
	            data: {'objs':json,'act':'publicvideo','parentid':'video','parenttype':'edit_video'},
	            type: "post",
	            dataType:"text",
	            success: function (text) {
	            	mini.alert("保存完毕。");
	            	grid.reload();
	            },
	            error: function (jqXHR, textStatus, errorThrown) {
	                alert(jqXHR.responseText);
	            }
	        });
	    }
		
		function onActionRenderer(e) {
            var grid = e.sender;
            var record = e.record;
           	var id = record.id;
           	var mp4 = record.mp4newname.replace(/\\/g,'/');
        	var webm = record.webmnewname.replace(/\\/g,'/');
            var s = ' <a class="Edit_Button" href="javascript:copypath(\''+mp4+'\',\''+webm+'\')" >内容</a>';
            return s;
        }
		
		//复制视频地址标签
		function copypath(mp4,webm){

			var path = '&lt;video id="preview-player" class="video-js vjs-fluid placeholder vjs-big-play-centered" controls preload="auto" poster=""  data-setup="{}">'
		    	+ '&lt;source src="${pageContext.request.contextPath}/'+mp4+'" type="video/mp4"></source>'
		    	+ '&lt;source src="${pageContext.request.contextPath}/'+webm+'" type="video/webm"></source>'
				+ '&lt;/video>';
			
			$('#videopath').html(path);
			var html = $('#video').html();
			
			mini.showMessageBox({
	            width: 510,
	            height: 310,
	            title: "内部视频引用",
	            //buttons: ["ok", "cancel"],
	            //message: "自定义Html",
	            html: html,
	            showModal: false,
	            callback: function (action) {
	                //alert(action);
	            }
	        });
		}
		
		//上传视频封面图片
		function onBtnVideoPicEdit(e) {
        	var buttonEdit = e.sender;
        	var row = grid.getEditorOwnerRow(buttonEdit);
        	
        	if (null == row || typeof(row.id) == "undefined" || row.id == "") {
        		mini.alert("行记录还没有保存，请先保存后再上传.");
	      		return;
	      	}
        	
        	mini.open({
                url: bootPATH + "../common/dispatch.htmls?page=/view/system/product/upload_pic",
                title: "上传新闻图片", width: 600, height:500,
                allowResize:true,
                onload: function () {
                	var iframe = this.getIFrameEl();
               	 	var data = {id:row.id,saveFolder:"upload",forObj:"video"};
                    //var data = rows[0];
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	grid.cancelEdit();
            		grid.reload();
                }
            });
        }
        
		//上传Mp4文件
		function onBtnMp4VideoEdit(e) {
        	var buttonEdit = e.sender;
        	var record = grid.getEditorOwnerRow(buttonEdit);
        	if (typeof(record.id) == "undefined" || record.id == "") {
        		mini.alert("要上传视频的行记录还没有保存，请先保存后再上传视频.");
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
                	grid.cancelEdit();
                	grid.reload();
                }
            });
        }
		//上传webm文件
		function onBtnWebmVideoEdit(e) {
        	var buttonEdit = e.sender;
        	var record = grid.getEditorOwnerRow(buttonEdit);
        	if (typeof(record.id) == "undefined" || record.id == "") {
        		mini.alert("要上传视频的行记录还没有保存，请先保存后再上传视频.");
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
                 	<span id="pid" style="padding-left:5px;">行业新闻</span>
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
    <div id="video" style="display: none">
    	<textarea rows="16" cols="66" id="videopath"></textarea>
    </div>
</body>
</html>