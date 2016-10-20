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
		
		.showMessage {
		    float: left;
		    height: 150px;
		    width: 650px;
		    overflow: hidden;
		    background: #5FB878;
		    padding: 20px;
		    white-space:normal;
		    display: none;
		}
		
		.showMessage span {
			display:block;
		}
		
    </style>
    
    <script type="text/javascript">
    
	    $(function(){
	    	
	    	//获取数据
	    	$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/order/getIndexInfo.htmls",
                data: {},
                type: "post",
                dataType:"json",
                success: function (json) {
                	if (json.userid != "1") {
                		$("#myOrder").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/index/myDate.tpl",null,{filter_data: true});
                		$("#myOrder").setParam('id', json.userid);
    	                $("#myOrder").processTemplate(json.my);
                	}
                	if (json.identity != "C") {
                		$("#userOrder").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/index/myDate.tpl",null,{filter_data: true});
                		$("#userOrder").setParam('id', json.userid);
    	                $("#userOrder").processTemplate(json.user);
    	                setChart(json);
                	}
                	
                	$("#infoM").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/index/myMess.tpl",null,{filter_data: true});
            		$("#infoM").setParam('rowCount', json.infoM.length);
	                $("#infoM").processTemplate(json.infoM);
	                
	                $("#sysM").setTemplateURL("${pageContext.request.contextPath}/view/order/tpl/index/myMess.tpl",null,{filter_data: true});
            		$("#sysM").setParam('rowCount', json.sysM.length);
	                $("#sysM").processTemplate(json.sysM);
                	
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
	    	
	    })
	    
	    function setChart(json) {
	    	parent.removeMenuCurrent();
	    	// 基于准备好的dom，初始化echarts实例
	    	var myChart = echarts.init(document.getElementById('main'));
	    	var option = {
		    	    title : {
		    	        text: '订单及销售额',
		    	        subtext: json.year+'年度'
		    	    },
		    	    tooltip : {
		    	        trigger: 'axis'
		    	    },
		    	    legend: {
		    	        data:['订单量[个数]','销售额[万元]']
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
		    	            data:[json.m['1m'].num, json.m['2m'].num, json.m['3m'].num,json.m['4m'].num,json.m['5m'].num,json.m['6m'].num,json.m['7m'].num,json.m['8m'].num,json.m['9m'].num,json.m['10m'].num,json.m['11m'].num,json.m['12m'].num],
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
		    	            name:'销售额[万元]',
		    	            type:'bar',
		    	            data:[json.m['1m'].total,json.m['2m'].total, json.m['3m'].total,json.m['4m'].total,json.m['5m'].total,json.m['6m'].total,json.m['7m'].total,json.m['8m'].total,json.m['9m'].total,json.m['10m'].total,json.m['11m'].total,json.m['12m'].total],
		    	            markPoint : {
		    	                data : [
									{type : 'max', name: '年最高'},
									{type : 'min', name: '年最低'}
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
	    }
	    
	    function showMessage(id) {
	    	$.ajax({
    			async:false,
                url: "${pageContext.request.contextPath}/orderMessage/showMessage.htmls",
                data: {id:id},
                type: "post",
                dataType:"json",
                success: function (json) {
                	$("#mTime").html(json.messagetime);
                	$("#mCon").html(json.messagetxt);
                	layer.open({
          	    	  type: 1,
          	    	  shade: false,
          	    	  area: '500px',
          	    	  title: false, //不显示标题
          	    	  content: $('.showMessage'), //捕获的元素
          	    	  cancel: function(index){
          	    	    layer.close(index);
          	    	    this.content.show();
          	    	  }
          	    	});
                },
                error: function (jqXHR, textStatus, errorThrown) {
                	layer.msg("提交出现错误，请退出重新登录，再尝试操作。错误代码："+jqXHR.responseText,{icon:6});
                }
           });
	    	
	    	parent.resetFunc("message");
	    }
 		
    </script>
</head>
<body>
	<%@ include file="/view/order/header.jsp" %>
	<!--内容-->
	<div class="layout" style="margin-bottom: 50px">
		<ul class="bread bg">
			<li><a href="#" class="icon-home">首页</a> </li>
			<li></li>
		</ul>
		<div class="admin" style="margin-bottom: 30px">
			<div class="line-big">
				<div class="x7">
					<c:if test="${sessionScope.pc_user_sessiion.id != '1'}">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>今日简报[我的采购单]</strong>
						</div>
						<div id="myOrder" class="panel-body">
						</div>
					</div>
					<br>
					</c:if>
					<c:if test="${sessionScope.pc_user_sessiion.identity != 'C'}">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>今日简报[客户订货单]</strong>
						</div>
						<div id="userOrder" class="panel-body">
						</div>
					</div>
					<br>
					
					<div class="panel border-sub" >
						<div class="panel-head">
							<strong>年度客户订单及销售额</strong>
						</div>
						<div class="panel-body" style="height:500px;">
							<div id="main" style="width: 100%;height:100%;"></div>
						</div>
					</div>
					</c:if>
					<br>
				</div>
				<div class="x5">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>未读业务消息</strong>
							<a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'1'}"><span class="float-right">更多</span></a>
						</div>
						<div id="infoM" class="panel-body">
							
						</div>
					</div>
					<br>
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>未读系统消息</strong>
							<a href="${pageContext.request.contextPath}/order/dispatch.htmls?page=/view/order/message/messageList&param={'radio_value':'0'}"><span class="float-right">更多</span></a>
						</div>
						<div id="sysM"  class="panel-body">
							
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
	<div class="showMessage" >
		<br>
		<span id="mTime" style="color:#fff">
	        2016-10-13 10:15:23
	    </span>
	    <br>
		<span id="mCon" style="color:#fff">
	        [代理A]:代理A提交了订单，请及时处理！订单号：PO16101018480001
	    </span>
	</div>
</body>
</html>