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
    <script src="${pageContext.request.contextPath}/js/echarts/echarts.min.js"></script>
	<!-- 引入 vintage 主题 -->
	<script src="${pageContext.request.contextPath}/js/echarts/theme/shine.js"></script>
    
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
    </style>
    
    <script type="text/javascript">
    	var userid = '${sessionScope.pc_user_sessiion.id}';
	    $(function(){
	    	// 基于准备好的dom，初始化echarts实例
	    	var myChart = echarts.init(document.getElementById('main'));
	    	var option = {
		    	    title : {
		    	        text: '订单及销售额',
		    	        subtext: '2016年度'
		    	    },
		    	    tooltip : {
		    	        trigger: 'axis'
		    	    },
		    	    legend: {
		    	        data:['订单量[个数]','销售额[元]']
		    	    },
		    	    toolbox: {
		    	        show : true,
		    	        feature : {
		    	            dataView : {show: true, readOnly: false},
		    	            magicType : {show: true, type: ['line', 'bar']},
		    	            restore : {show: true},
		    	            saveAsImage : {show: true}
		    	        }
		    	    },
		    	    calculable : true,
		    	    xAxis : [
		    	        {
		    	            type : 'category',
		    	            data : ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
		    	        }
		    	    ],
		    	    yAxis : [
		    	        {
		    	            type : 'value'
		    	        }
		    	    ],
		    	    series : [
		    	        {
		    	            name:'订单量[个数]',
		    	            type:'bar',
		    	            data:[2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3],
		    	            markPoint : {
		    	                data : [
		    	                    {type : 'max', name: '最大值'},
		    	                    {type : 'min', name: '最小值'}
		    	                ]
		    	            },
		    	            markLine : {
		    	                data : [
		    	                    {type : 'average', name: '平均值'}
		    	                ]
		    	            }
		    	        },
		    	        {
		    	            name:'销售额[元]',
		    	            type:'bar',
		    	            data:[2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3],
		    	            markPoint : {
		    	                data : [
		    	                    {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183},
		    	                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
		    	                ]
		    	            },
		    	            markLine : {
		    	                data : [
		    	                    {type : 'average', name : '平均值'}
		    	                ]
		    	            }
		    	        }
		    	    ]
		    	};
	    	
	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);
	        window.onresize = myChart.resize; 
	        
	        getUserBank();
	    })
	    
	    function getUserBank() {
    		
    		var par = {};
    		par.userid = userid;
    		
    		$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderUserBank/listUserBank.htmls",
                data: par,
                type: "post",
                dataType:"json",
                success: function (json) {
                	$(".x5").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/bank/bankList.tpl");
                    $(".x5").processTemplate(json.data);
                    
                    
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
    	}
 		
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/index" class="icon-home">首页</a> </li>
			<li><a href="javascript:;" >资金帐户</a></li>
		</ul>
		<div class="admin">
			<div class="line-big">
				<div class="x5">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>我的帐户[众恒信和]</strong>
						</div>
						<div class="panel-body">
							<table class="table">
								<tbody>
									<tr>
										<td style="border-top: 0px solid #ddd;" width="200"></td>
										<td style="border-top: 0px solid #ddd;">订货单</td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">订货金额</td>
									</tr>
									<tr>
										<td align="center">今日</td>
										<td>0笔</td>
										<td align="right">￥0</td>
									</tr>
									<tr>
										<td align="center">本月</td>
										<td>0笔</td>
										<td align="right">￥0</td>
									</tr>
									<tr>
										<td align="center">本年</td>
										<td>0笔</td>
										<td align="right">￥0</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<br>
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>今日简报[客户订货单]</strong>
						</div>
						<div class="panel-body">
							<table class="table">
								<tbody>
									<tr>
										<td style="border-top: 0px solid #ddd;" width="200"></td>
										<td style="border-top: 0px solid #ddd;">订货单</td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">订货金额</td>
									</tr>
									<tr>
										<td align="center">今日</td>
										<td>0笔</td>
										<td align="right">￥0</td>
									</tr>
									<tr>
										<td align="center">本月</td>
										<td>0笔</td>
										<td align="right">￥0</td>
									</tr>
									<tr>
										<td align="center">本年</td>
										<td>0笔</td>
										<td align="right">￥0</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<br>
					<div class="panel border-sub" >
						<div class="panel-head">
							<strong>年度订单及销售额</strong>
						</div>
						<div class="panel-body" style="height:500px;">
							<div id="main" style="width: 100%;height:100%;"></div>
						</div>
					</div>
					<br>
				</div>
				<div class="x7">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>待处理订单</strong>
						</div>
						<div class="panel-body">
							<table class="table">
								<tbody>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">我的采购单:4笔</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">￥66645</td>
									</tr>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">客户订货单:4笔</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">￥66645</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<br>
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>最新消息</strong>
							<a href="javascript:;"><span class="float-right">更多</span></a>
						</div>
						<div class="panel-body">
							<table class="table">
								<tbody>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">[浙江丽美美容院]充值成功..</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">2016-04-05</td>
									</tr>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">[浙江丽美美容院]充值成功..</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">2016-04-05</td>
									</tr>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">[浙江丽美美容院]充值成功..</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">2016-04-05</td>
									</tr>
									<tr>
										<td style="border-top: 0px solid #ddd;"><a href="javascript:;">[浙江丽美美容院]充值成功..</a></td>
										<td style="border-top: 0px solid #ddd;" width="200" align="right">2016-04-05</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<br>
				</div>
			</div>
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