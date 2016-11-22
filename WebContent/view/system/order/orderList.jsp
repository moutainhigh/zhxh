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
	    var orderstatus = "";
	   	$(function(){
	   		mini.parse();
	   		
	   		//订单
	   		grid_order = mini.get("grid_order");
	    	grid_order.set({
	    		url:"${pageContext.request.contextPath}/syspo/polist.htmls",
	    		columns: [
							{ type: "checkcolumn",headerAlign:"center",width: 30},
	      	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
	      	              	{ field: "ordernumber",name:"ordernumber", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "订单号"},
	      	                { field: "u_compname",name:"u_compname", width: '30%', headerAlign: "center", align:"left",allowSort: false, header: "采购机构"},
	      	              	{ field: "p_compname",name:"p_compname", width: '30%', headerAlign: "center", align:"left",allowSort: false, header: "上级机构"},
	      	                { field: "ordertotal",name:"ordertotal", width: 80, headerAlign: "center", align:"right",allowSort: false, header: "订单金额"},
	      	              	{ field: "ordertime",name:"ordertime",dateFormat:"yyyy-MM-dd HH:mm:ss",width: 120, headerAlign: "center", align:"center",allowSort: false, header: "订单时间"},
	      	              	{ field: "signtime",name:"signtime",dateFormat:"yyyy-MM-dd HH:mm:ss",width: 120, headerAlign: "center", align:"center",allowSort: false, header: "签收时间"},
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
		            pageSize:50
		            
	        });
	    	grid_order.load({type:ordertype});
	    	
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
	      	          		{ field: "subtotal",name:"subtotal", width: 80, headerAlign: "center", align:"right",allowSort: false, header: "小计"}
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
	    		url:"${pageContext.request.contextPath}/syspo/logistics.htmls",
	    		columns: [
							{ type: "indexcolumn",headerAlign:"center",header:"序号",width:40},
	      	              	{ field: "handletime",name:"handletime", width: 120,dateFormat:"yyyy-MM-dd HH:mm:ss", headerAlign: "center", align:"center",allowSort: false, header: "处理时间"},
	      	              	{ field: "handleresult",name:"handleresult", width: '60%', headerAlign: "center", align:"left",allowSort: false, header: "处理信息"}
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
                if(field == "ordertotal"){
                	e.cellHtml = "￥"+formatFloat(value,2);
                }else if (field == "orderstatus") {
   	        		if (value == "1") {
   	        			e.cellHtml = "待发货";
       	        	}else if(value == "2") {
   	        			e.cellHtml = "已发货";
   	        		}else if(value == "3") {
   	        			e.cellHtml = "已签收";
   	        		}
    	        }
            });
    		
    		grid_order_pro.on("drawcell", function (e) {
                var record = e.record,
	            field = e.field,
	            value = e.value;
                if (field == "subtotal") {
                	var quantity = record.productnum;
                	var price = record.price;
                	var buyerdis = record.buyerdis;
                	var subtotal = 0;
                	if(buyerdis > 0){
                		subtotal = formatFloat(quantity * price * buyerdis,2);
                	}else{
                		subtotal = formatFloat(quantity * price,2);
                	}
                	e.cellHtml = "￥"+subtotal;
    	        }
            });
        }
	   	
		//搜索
        function search() {
			var keyword = mini.get("keyword").getValue();
        	grid_order.load({type:ordertype,status:orderstatus,search:keyword});
		}
		function selStatus(v){
			orderstatus = v;
			var keyword = mini.get("keyword").getValue();
			grid_order.load({type:ordertype,status:v,search:keyword});
		}
       
      	//查看订单-订单商品
        function onSelectionChanged(e) {
            var grid = e.sender;
            var record = grid.getSelected();
            if (record) {
            	grid_order_pro.load({orderid: record.id});
            	grid_order_wl.load({orderid: record.id});
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
	                		grid_order.load({type:ordertype});
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
		                 <c:if test="${ordertype eq 'sub' }">
			                 <td style="white-space:nowrap;">
				         		<a class="mini-button" iconCls="icon-node" plain="true" onclick="sendOut()">确认发货</a>
				         		<span class="separator"></span>
			                 </td>
		                 </c:if>
		                 <td>
		                 	<select onchange="selStatus(this.value)"><option value="">--全部订单--</option>
		                 		<option value="0">待支付订单</option>
		                 		<option value="1">待发货订单</option>
		                 		<option value="2">已发货订单</option>
		                 		<option value="3">已签收订单</option>
		                 		<option value="-1">已取消订单</option>
		                 	</select>
		                 </td>
		                 <td style="white-space:nowrap;">
		                    <input id="keyword" class="mini-textbox" emptyText="订单号" style="width:250px;" onenter="onKeyEnter"/>
		                    <a class="mini-button" iconCls="icon-search" plain="true" onclick="search()">查询</a>
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