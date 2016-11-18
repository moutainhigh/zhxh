<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

	<style type="text/css">
	    body{
	        margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
	    }    
    </style>
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/boot.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/view/system/bank/bankbill.js"></script>
    <script type="text/javascript">
	    //mini.parse();
	    
	    $(function(){
	    	mini.parse();
	    	grid_bill_details = mini.get("grid_bill_details");
	    	grid_bill_details.set({
        		//url:"${pageContext.request.contextPath}/userBank/showUserBank.htmls",
        		columns: [
	                { type: "indexcolumn",headerAlign:"center",header:"序号",width:30},
	                { field: "brandname",name:"brandname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "品牌" },
	        	    { field: "productname",name:"productname", width: 80, headerAlign: "center", align:"center",allowSort: false, header: "商品"},
	        	    { field: "productsize",name:"productsize", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "规格"},
	        	    { field: "price",name:"price", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "单价"},
	        	    { field: "productnum",name:"productnum", width: 60, headerAlign: "center", align:"center",allowSort: false, header: "数量"},
	        	    { field: "skey",name:"skey", width: 120, headerAlign: "center", align:"center",allowSort: false, header: "分润金额"}
	        	    ],
	            showFilterRow:false,
	            allowCellSelect:true,
	            allowCellEdit:false,
	            allowCellValid:true,
	            multiSelect:false,
	            allowUnselect:false,
	            //onselectionchanged:"onSelectionChanged",
	            showPager:false,
	            fitColumns:true,
	            editNextOnEnterKey:true,
	            showPageSize:false,
	            pageSize:2000
	        });
        	
	    })
	    
	  	//标准方法接口定义
		function SetData(data) {
			//跨页面传递的数据
			shareDetails(data.userid,data.pros);
			//grid_bill_details.load({ bankid: bankid });
		}
	  	
	  	//关闭窗体
	    function CloseWindow(action) {
	        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	        else window.close();
	    }
	    function onCancel() {
	        CloseWindow("cancel");
	    }
	    

		//平台售额-详细
		function shareDetails(uid,ids){
			$.ajax({
				async:false,
		        url: getRootPath_web() + "/userBank/shareBillDetails.htmls",
		        data: {'orderproductids':ids},
		        type: "post",
		        dataType:"json",
		        success: function (json) {
		        	var data = json.data;
		        	var mDataArr = [];
		        	for (i=0;i<data.length;i++) {
		        		var m = data[i];
		        		var mData = {};
		        		mData.brandname = m.brandname;
		        		mData.productname = m.productname;
		        		mData.productsize = m.productsize;
		        		mData.price = m.price;
		        		mData.productnum = m.productnum;
		        		var skey = "";
		        		var ms = JSON.parse(m.sharekey);
		        		for(var key	 in ms){
		        			for(var k in ms[key]){
		        				if(uid == "1"){ //平台查看所有机构分润情况
		        					skey += "["+ms[key][k].companyname+":"+ms[key][k].sharepay+"]";
		        				}else{
		        					if(uid == ms[key][k].userid){
		            					skey += ms[key][k].sharepay;
		            					break;
		            				}	
		        				}
		            		}
		        		}
		        		mData.skey = skey;
		        		mDataArr.push(mData);
		        	}
		        	grid_bill_details.setData(mDataArr);
					grid_bill_details.setTotalCount(0);
		        },
		        error: function (jqXHR, textStatus, errorThrown) {
		            alert(jqXHR.responseText);
		        }
		   });
		}
	</script>
    
</head>
<body>
    <div class="mini-fit">
        <div id="grid_bill_details" class="mini-datagrid" style="width:100%;height:100%;" borderStyle="border:0;"></div>
    </div>
	<div class="mini-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" borderStyle="border:1;">
        <a class="mini-button" style="width:60px;" onclick="onCancel()">关闭</a>
    </div>
</body>
</html>