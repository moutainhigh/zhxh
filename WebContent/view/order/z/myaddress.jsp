<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
	<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-jtemplates.js"></script>
     <script src="${pageContext.request.contextPath}/js/util.js" type="text/javascript"></script>
     <script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
    
    <style type="text/css">
		.admin {
		    padding: 20px 30px 10px 30px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 0px;
		    left: 0px;
		    overflow: auto;
		    width: 100%;
    	}
    	.table th{text-align: center}
    	.table-bordered th {border-bottom: 1px solid #ddd;}
    	
    	.form-x .form-group .label {
		    float: left;
		    width: 15%;
		    text-align: right;
		    padding: 7px 7px 7px 0;
		    white-space: nowrap;
		    text-overflow: ellipsis;
		    overflow: hidden;
		}
		
		.form-x .form-group .field {
		    float: left;
		    width: 85%;
		}
		
		.input {
    		font-size: 12px;
    	}
    </style>
    <script type="text/javascript">
    	$(function(){
    		addresslist();
    	});
    	
    	//提交表单
		function f_submit(){
			$("#f_address").ajaxSubmit(function() { 
				var formData = $("#f_address").serializeJson();
				var obj = new Array();
				obj.push(formData);
				var _objs = JSON.stringify(obj);
				$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/order/editaddress.htmls",
	                data: {objs:_objs},
	                type: "post",
	                dataType:"text",
	                success: function (json) {
	                	addresslist();
	                	$("#address_form").html("");
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    alert(jqXHR.responseText);
	                }
	           });
			});
		}
    	
    	//地址列表
    	function addresslist(){
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/order/address.htmls",
                //data: {parentid:'${parentid}',brandid:'${brandid}',keyword:keyword},
                type: "post",
                dataType:"json",
                success: function (json) {
               	 	$("#addressList").setTemplateElement("Template-List-user-show");
	                $("#addressList").processTemplate(json.data);
	                
	                bindTrClick();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                }
           });
    	}
    	
    	//新的地址
    	function newAddress(){
    		var data = new Array();
    		$("#address_form").setTemplateElement("address_form_show");
            $("#address_form").processTemplate(data);
    	}
    	//修改
    	function editAddress(id){
    		var tr = $('#'+id);
        	var tds = $(tr).find("td");
        	var objArr = new Array();
        	var _obj = {};
        	_obj.id = id;
        	_obj.username = $.trim($(tds[1]).text());
        	_obj.userphone = $.trim($(tds[2]).text());
        	_obj.postcode = $.trim($(tds[3]).text());
        	_obj.address = $.trim($(tds[4]).text());
        	$("#address_form").setTemplateElement("address_form_show");
            $("#address_form").processTemplate(_obj);
    	}
    	//删除
    	function delAddress(id){
    		var cf = "确定要删除选中的数据吗？<br><p style='font-size:12px; color:red'>注意：删除后，不可恢复，请谨慎操作.</p>";
			parent.layer.confirm(cf, {title:'系统提示',icon:3,
				btn: ['确定','取消'] //按钮
			}, function(index){
				$.ajax({
	    			async:false,
	                url: "${pageContext.request.contextPath}/order/deladdress.htmls",
	                data: {id:id},
	                type: "post",
	                dataType:"text",
	                success: function (text) {
	               	 	if(text == "success"){
	               	 		addresslist();
	               	 	}else{
	               	 		layer.msg("操作失败",{icon:6});
	               	 	}
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    alert(jqXHR.responseText);
	                }
	           });
   				parent.layer.close(index);
			}, function(){
			});
    		
    	}
    	
    	//获取数据
    	function getData(){
    		var objArr = new Array();
    		$("input[name='id']").each(function(index,element){
       	    	if(element.checked==true){
       	        	id = element.value;
       	        	var tr = $('#'+id);
       	        	var tds = $(tr).find("td");
       	        	var _obj = {};
       	        	_obj.id = id;
       	        	_obj.username = $.trim($(tds[1]).text());
       	        	_obj.userphone = $.trim($(tds[2]).text());
       	        	_obj.postcode = $.trim($(tds[3]).text());
       	        	_obj.address = $.trim($(tds[4]).text());
       	        	objArr.push(_obj);
       	        }
       	    });
    		return objArr;
    	}
    	
    	function bindTrClick() {
    		//除了表头（第一行）以外所有的行添加click事件.
            $("tr").first().nextAll().click(function (e) {
            	if (e.target.tagName == "TD") {
            		var firstInput = $(this).children("td:eq(0)").children("input:eq(0)");  // 第一个checkBox
                	firstInput.attr("checked",!firstInput.is(':checked'));
            	}
            });
    	}
    </script>
</head>
<body>
	<!--内容-->
	<div class="admin">
		<div id="addressList" class="admin-panel">
		</div>
		<div id="address_form" class="x7" style="padding-top: 10px;">
		</div>
	</div>
	<textarea id="Template-List-user-show" rows="0" cols="0" style="display:none">
		<!--
		<table class="table table-hover text-small">
			<tbody>
				<tr></tr>
				{#foreach $T as row}
				<tr class="tr" id="{$T.row.id}">
					<td width="10" align="center"><input type="radio" value="{$T.row.id}" name="id"></td>
					<td>{$T.row.username}</td>
					<td>{$T.row.userphone}</td>
					<td>{$T.row.postcode}</td>
					<td>{$T.row.userpath}</td>
					<td><a href="javascript:;" onclick="editAddress('{$T.row.id}')">修改</a> &nbsp;|&nbsp; <a href="javascript:;" onclick="delAddress('{$T.row.id}')">删除</a></td>
				</tr>
				{#/for}
				<tr>
					<td colspan="6"><a href="javascript:;" onclick="newAddress()">添加新地址</a></td>
				</tr>
			</tbody>
		</table>
	    -->
	</textarea>
	<textarea id="address_form_show" style="display: none;">
		<!-- 
		<script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
		<form id="f_address" class="form-x" onsubmit="return false;">
			<input type="hidden" id="id" name="id" value="{$T.id}" />
			<div class="form-group" id="f_1474450082433">
			    <div class="label">
			        <label for="f_chinesename_txt">联系人</label>
			    </div>
			    <div class="field">
			        <input class="input" id="username" name="username" maxlength="15" value="{$T.username}" data-validate="required:请填写联系人,chinesename:请输入2-15个汉字" placeholder="输入汉字" type="text">
			    </div>
			</div>
			<div class="form-group" id="f_1474450087967">
			    <div class="label">
			        <label for="f_mobile_txt">手机号</label>
			    </div>
			    <div class="field">
			        <input class="input" id="userphone" name="userphone" maxlength="11" value="{$T.userphone}" data-validate="required:请填写内容,mobile:请输入手机号码" placeholder="输入手机号码" type="text">
			    </div>
			</div>
			<div class="form-group" id="f_1474450096312">
			    <div class="label">
			        <label for="f_zipcode_txt">邮政编码</label>
			    </div>
			    <div class="field">
			        <input class="input" id="postcode" name="postcode" maxlength="6" value="{$T.postcode}" data-validate="required:请填写邮政编码,zipcode:请输入邮政编码" placeholder="请输入邮编" type="text">
			    </div>
			</div>
			<div class="form-group" id="f_1474450453390">
		           <div class="label">
		               <label for="f_address_txt">常用地址</label>
		           </div>
		           <div class="field">
		               &lt;textarea type="text" class="input" id="userpath" name="userpath" maxlength="500" data-validate="required:请填写常用地址" placeholder="请输入常用地址"&gt;{$T.address}&lt;/textarea&gt;
		           </div>
		    </div>
          	<div class="form-group" id="f_1474450918646">
          		<div class="label">
	               <label for=""></label>
	           </div>
	           <div class="field">
	               <button class="button" onclick="f_submit()">保存</button>
	           </div>
         	</div>
		</form>
		 -->
	</textarea>
</body>
</html>