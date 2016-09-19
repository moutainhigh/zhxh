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
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-jtemplates.js"></script>
    <script src="${pageContext.request.contextPath}/js/layer2.4/layer.js" type="text/javascript"></script>
    <style type="text/css">
    	.doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		}
		.doc-header.fixed-top .doc-naver {
		    padding-top: 10px;
		    padding-bottom: 10px;
		    background-color: #fff;
		}
		.admin {
		    width: 100%;
		    padding: 20px;
		    background: #fff;
		    right: 0;
		    bottom: 0;
		    top: 87px;
		    overflow: auto;
		}
		
		.nav-inline li a {
			line-height: 22px;
		}
		
		.border-back {
    		border-color:#b5cfd9;
		}
		/* .panel-back {
			background-color: #f7f7f7;
		} */
		.table th{text-align: center}
    </style>
    <script type="text/javascript">
    	$(function(){
    		
    		//
    		$("#selPro").click(function(){
    			var comp = $("#f_comp").val();
    			if(comp == "0"){
    				layer.tips('请选择采购商家', '#f_comp', {
   					  tips: [2, '#FF9901'],
   					  time: 4000
   					});
    			}else{
    				parent.parent.layer.open({
    				    type: 2,
    				    title:'选择商品',
    				    area: ['720px', '520px'],
    				    fix: false, //不固定
    				    maxmin: true,
    				    content: "${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/order/selProducts&param={'parentid':'"+comp+"'}",
    				    btn: ['继续弹出', '全部关闭'] //只是为了演示
    				  ,yes: function(){
    				    alert(12); 
    				  }
    				  ,btn2: function(){
    				    layer.closeAll();
    				  },
    				    end: function(){
    				    	alert(123);
    				    }
    				});
    			}
    		});
    	});
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="#" class="icon-home">首页</a> </li>
			<li><a href="#" >采购单</a></li>
		</ul>
		<div class="admin" style="padding: 30px 60px;">
			<div class="x3" style="padding-bottom: 20px;">
				<form onsubmit="return false;" class="form-x"><div class="form-group" id="f_parent">
	                 <div class="label" style="width: 16%">
	                     <label for="f_class">采购商家：</label>
	                 </div>
	                 <div class="field" style="width: 84%">
	                     <select class="input" id="f_comp" name="f_class">
	                     	 <option value="0">请选择</option>
	                     	 <c:forEach var="item" items="${u_list }">
	                         	<option value="${item.id }">${item.username }</option>
	                         </c:forEach>
	                     </select>
	                 </div>
	             </div></form>
			</div>
			<div class="padding float-right">
				<button class="button bg-blue" id="selPro"><span class="icon-plus"></span> 选择商品</button>
			</div>
			<form method="post">
				<div class="admin-panel">
					<table class="table table-bordered table-hover text-small">
						<tbody>
							<tr class="panel-head">
								<th width="45" align="center"><input type="checkbox" value="1" name="id"></th>
								<!-- <th width="120"></th> -->
								<th width="*">商品名称</th>
								<th width="100">规格</th>
								<th width="100">数量</th>
								<th width="100">单价</th>
								<th width="100">折扣</th>
								<th width="180">小计</th>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="text-right" style="padding: 30px 50px;">
					<div>合计：<span>￥20,000.00</span></div>
					<br/>
					<div>应付总额：<span style="color: red !important">￥20,000.00</span></div>
				</div>
				<div class="form-inline" style="padding-top: 20px;">
					<div class="form-group">
						<div class="label">
							<label for="username">
								收货信息：</label>
						</div>
						<div class="field">
							收货人：张三，联系电话：15010780215，收货地址：北京市朝阳区望京悠乐汇A 2108
						</div>
					</div>
				</div>
				<div>
					<button class="button button-big bg-blue">提交订单</button>
				</div>
			</form>		
		</div>
	</div>
	<!--底部-->
	<div class="layout fixed-bottom bg-white">
		<div class="border-bottom padding-bottom">
			<div class="text-center height-big text-small">
				<strong>版权所有 亚普软件(北京)有限公司&copy; <a href="#"></a> All Rights Reserved.</strong>
			</div>
		</div>
	</div>
</body>
</html>