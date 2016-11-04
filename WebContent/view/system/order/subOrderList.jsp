<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    	var ordertype = '${ordertype}';	//订单类型
	    var grid_order; 	//订单
	    var grid_order_pro;	//订单商品
	    var grid_order_wl;	//物流信息
	    
	   	$(function(){
	   		mini.parse();
	   		
	   		//订单
	   		grid_order = mini.get("grid_order");
	    	grid_order.set({
	    		url:"${pageContext.request.contextPath}/syspo/subpolist.htmls",
	    		columns: [
							{ type: "checkcolumn",headerAlign:"center",width: 30},
	      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
	      	              	{ field: "ordernumber",name:"ordernumber", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "订单号"},
	      	                { field: "u_companyname",name:"u_companyname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "客户名称"},
	      	              	{ field: "ordertotal",name:"ordertotal", width: 80, headerAlign: "center", align:"right",allowSort: false, header: "订单金额"},
	      	              	{ field: "ordertime",name:"ordertime",dateFormat:"yyyy-MM-dd HH:mm:ss",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "订单时间"},
	      	              	{ field: "signtime",name:"signtime",dateFormat:"yyyy-MM-dd HH:mm:ss",width: 100, headerAlign: "center", align:"center",allowSort: false, header: "签收时间"},
	      	              	{ field: "orderstatus",name:"orderstatus",width: 60, headerAlign: "center", align:"center",allowSort: false, header: "状态"}
	      	              	
	      	            ],
		            showFilterRow:false,
		            allowCellSelect:true,
		            allowCellEdit:true,
		            allowCellValid:true,
		            multiSelect:false,
		            allowUnselect:false,
		            showPager:true,
		            onselectionchanged:"onSelectionChanged",
		            //oncellvalidation:"onCellValidation", 
		            //oncellcommitedit:"OnCellCommitEdit",
		            //oncellendedit:"OnCellEndEdit",
		            //fitColumns:false,
		            editNextOnEnterKey:true,
		            showPageSize:false,
		            pageSize:2000
		            
	        });
	    	grid_order.load({orderType:ordertype});
	    	
	    	//订单商品
	    	grid_order_pro = mini.get("grid_order_pro");
	    	grid_order_pro.set({
	    		url:"${pageContext.request.contextPath}/syspo/podetails.htmls",
	    		columns: [
	      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	      	              	{ field: "brandname",name:"brandname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "品牌"},
	      	                { field: "productname",name:"productname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "商品名称"},
	      	              	{ field: "productsize",name:"productsize", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "规格"},
	      	            	{ field: "productnum",name:"productnum", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "数量"},
	      	          		{ field: "price",name:"price", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "单价"},
	      	          		{ field: "buyerdis",name:"buyerdis", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "折扣"},
	      	          		{ field: "u_companyname",name:"u_companyname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "小计"}
	      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            //oncellvalidation:"onCellValidation", 
	            //oncellcommitedit:"OnCellCommitEdit",
	            //oncellendedit:"OnCellEndEdit",
	            editNextOnEnterKey:false,
	            showPageSize:false,
	            pageSize:2000
	        });
	    	
	    	//物流信息
	    	grid_order_wl = mini.get("grid_order_wl");
	    	grid_order_wl.set({
	    		url:"${pageContext.request.contextPath}/userManager/list.htmls",
	    		columns: [
							{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	      	              	{ field: "brandname",name:"brandname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "处理时间"},
	      	                { field: "productname",name:"productname", width: 280, headerAlign: "center", align:"center",allowSort: false, header: "处理信息"},
	      	              	{ field: "productsize",name:"productsize", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "操作人"}
	      	            ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:true,
	            allowCellValid:true,
	            multiSelect:true,
	            allowUnselect:false,
	            showPager:true,
	            //oncellvalidation:"onCellValidation",
	            editNextOnEnterKey:false,
	            showPageSize:false,
	            pageSize:50
	        });
	    	
	    	drawcell();
	    });
	   	
	   	function drawcell() {
    		grid_order.on("drawcell", function (e) {
                var record = e.record,
	            field = e.field,
	            value = e.value;
                if (field == "orderstatus") {
   	        		if (value == "1") {
   	        			e.cellHtml = "待发货";
       	        	}else if(value == "2") {
   	        			e.cellHtml = "已发货";
   	        		}else if(value == "3") {
   	        			e.cellHtml = "已签收";
   	        		}
    	        }
            });
        }
	   	
		//搜索
        function search(gridtype) {
			alert(12);
		}
       
      	//查看订单-订单商品
        function onSelectionChanged(e) {
            var grid = e.sender;
            var record = grid.getSelected();
            if (record) {
            	grid_order_pro.load({orderid: record.id});
            	//grid_order_wl.load({parentid: record.id,identity:"Z"});
            }
        }
      
      	//确认发货
     	function sendOut(){
     		var rows = grid_order.getSelecteds();
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择一条数据.",{icon:6});
       		 	return;
       	 	}
       	 	var row = grid_order.getSelected();
       	 	if(row.orderstatus != "1"){
       	 		var sta = ["","","已发货","已签收"];
	       	 	parent.parent.layer.msg("该订单"+sta[row.orderstatus],{icon:6});
	   		 	return;
       	 	}
       	 	
       	 	parent.parent.layer.prompt({
				title: '请输入运单号，并确认',
				formType: 0 //prompt风格，支持0-2
			}, function(deliverynum){
				$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/syspo/sendout.htmls",
	                data: {orderid:row.id,deliverynum:deliverynum},
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	                	if(text == "1"){
	                		grid_order.load({orderType:ordertype});
	                		parent.parent.layer.msg("操作成功",{icon:6});
	                	}else{
	                		parent.parent.layer.msg("操作失败，请稍后再试！",{icon:6});
	                	}
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                	parent.parent.layer.msg("系统错误"+jqXHR.responseText);
	                }
	           	});
			});
     	}
      	
      	//分配利润
      	function onOrderShare(){
      		var rows = grid_order.getSelecteds();
       	 	if (rows.length == 0) {
       	 		parent.parent.layer.msg("请选择一条数据.",{icon:6});
       		 	return;
       	 	}
       	 	var row = grid_order.getSelected();
       	 	if(row.orderstatus != "1"){
       	 		var sta = ["","","已发货","已签收"];
	       	 	parent.parent.layer.msg("该订单"+sta[row.orderstatus],{icon:6});
	   		 	return;
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
		                 	<span id="pid" style="padding-left:5px;">订单列表</span>
		                 </td>
		                 <c:if test="${ordertype != 'a' }">
			                 <td style="white-space:nowrap;">
				         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="sendOut()">确认发货</a>
				         		<span class="separator"></span>
			                 </td>
		                 </c:if>
		                 <c:if test="${ordertype eq 'p' }">
			                 <td style="white-space:nowrap;">
				         		<a class="mini-button" iconCls="icon-save" plain="true" onclick="onOrderShare()">分配利润</a>
				         		<span class="separator"></span>
			                 </td>
		                 </c:if>
		                 <td style="white-space:nowrap;">
		                    <input id="key_user_a" class="mini-textbox" emptyText="姓名/手机号/机构名称/地址" style="width:250px;" onenter="onKeyEnter"/>
		                    <a class="mini-button" iconCls="icon-search" plain="true" onclick="search('grid_order')">查询</a>
		                </td>
		             </tr>
		         	</tbody>
		        </table>
		    </div>
		    <div class="mini-fit">
		        <div id="grid_order" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
		    </div>
		</div>
		<div showCollapseButton="true">
   			<div id="mainTabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" borderStyle="padding:0;border:0;">
	        	<div name="shop" title="订单商品-列表">
			        <div class="mini-fit" >
				         <div id="grid_order_pro" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				    </div>
	            </div>
	            <div name="member" title="物流信息">
			        <div class="mini-fit" >
				         <div id="grid_order_wl" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>  
				     </div>
	            </div>
	        </div>
   		</div>
	</div>

</body>
</html>