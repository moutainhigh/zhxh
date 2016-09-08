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
	    $(function(){
	    	// 基于准备好的dom，初始化echarts实例
	    	var myChart = echarts.init(document.getElementById('main'));
	    	var option = {
		    	    title : {
		    	        text: '某地区蒸发量和降水量',
		    	        subtext: '纯属虚构'
		    	    },
		    	    tooltip : {
		    	        trigger: 'axis'
		    	    },
		    	    legend: {
		    	        data:['蒸发量','降水量']
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
		    	            name:'蒸发量',
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
		    	            name:'降水量',
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
	    })
 		
    </script>
</head>
<body>
	<div class="layout doc-header fixed box-shadow-small" style="z-index: 9;">
		<div class="container-layout doc-naver">
			<div class="line">
				<div class="x3 doc-logo" >
					<!-- <button class="button icon-navicon margin-top float-right" data-target="#doc-header-pintuer">
					</button>
					<a href="/">
						<img src="images/logo.png" width="180" height="40" alt="拼图" class="ring-hover">
					</a> -->
					<p class="text-sub text-big" style="margin-left:30px; line-height: 40px;margin-bottom: 0px;">众恒信和采购分销平台</p>
				</div>
				<div class="x9 doc-nav " style="text-align: right;">
					<ul class="nav nav-inline nav-navicon padding-small-top nav-menu" id="doc-header-pintuer" style="margin-right: 50px">
						<li>
							<a class="" href="javascript:;">
								<span><img src="${pageContext.request.contextPath}/images/user_man.png" width="22" class="radius-circle"></span>
								我
								<span class="downward"></span>
							</a>
							<ul class="drop-menu">
								<li><a class="icon-user" target="_blank" href="javascript:;"> 修改资料</a></li>
								<li><a class="icon-key" target="_blank" href="javascript:;"> 修改密码</a></li>
							</ul>
						</li>
						<li class="active">
							<a class="" href="javascript:;">
								<span class="icon-envelope-o"></span>&nbsp;
								<span class="badge bg-blue">5+</span>
								<span class="downward"></span>
							</a>
							<ul class="drop-menu">
								<li><a class="" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;您有16封邮件</a></li>
								<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;查阅更多...</a></li>
							</ul>
						</li>
						<li>
							<a class="" href="javascript:;">
								<span class="icon-bell-o"></span>&nbsp;
								<span class="badge bg-green">99+</span>
								<span class="downward"></span>
							</a>
							<ul class="drop-menu">
								<li><a class="" target="_blank" href="javascript:;"><span class="icon-comment"></span>&nbsp;您有26条未读消息</a></li>
								<li><a class="" target="_blank" href="javascript:;"><span class="icon-comments"></span>&nbsp;您有13条回复消息</a></li>
								<li><a class="bg-gray" target="_blank" href="javascript:;"><span class="icon-envelope"></span>&nbsp;查看更多...</a></li>
							</ul>
						</li>
						<li>
							<a href="javascript:;"><span class="icon-comment-o"></span>&nbsp;客服<span class="downward"></span></a>
							<ul class="drop-menu">
								<li><a href="/react.html">在线客服</a></li>
								<li><a href="/weixin/index.html">意见反馈</a></li>
								<li><a href="javascript:;" style="background-color: #00a7e4;color: #fff;">400-400-4000</a></li>
								<li><a href="javascript:;" style="background-color: #00a7e4;color: #fff;">7*24小时服务</a></li>
							</ul>
						</li>
						<li><a class="" target="_blank" href="login.html"><span class="icon-sign-out"></span>注销</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!--内容-->
	<div class="layout" style="height:2000px">
		<ul class="bread bg">
			<li><a href="#" class="icon-home">首页</a> </li>
			<li></li>
		</ul>
		<div class="admin">
			<div class="line-big">
				<div class="x7">
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>今日简报[我的采购单]</strong>
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
					<div class="panel border-sub">
						<div class="panel-head">
							<strong>今日简报[客户订货单]</strong>
						</div>
						<div class="panel-body">
							<div id="main" style="width: 100%;height:400px;"></div>
						</div>
					</div>
					<br>
				</div>
				<div class="x5">
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
					<div class="alert">
						<h4>拼图前端框架介绍</h4>
						<p class="text-gray padding-top">拼图是优秀的响应式前端CSS框架，国内前端框架先驱及领导者，自动适应手机、平板、电脑等设备，让前端开发像游戏般快乐、简单、灵活、便捷。</p>
						<a target="_blank" class="button bg-dot icon-code" href="pintuer4.zip"> 下载示例代码</a>
						<a target="_blank" class="button bg-main icon-download" href="http://www.pintuer.com/download/pintuer.zip"> 下载拼图框架</a>
						<a target="_blank" class="button border-main icon-file" href="http://www.pintuer.com/"> 拼图使用教程</a>
					</div>
					<div class="panel">
						<div class="panel-head"><strong>系统信息</strong></div>
						<table class="table">
							<tbody>
								<tr>
									<th colspan="2">服务器信息</th>
									<th colspan="2">系统信息</th>
								</tr>
								<tr>
									<td width="110" align="right">操作系统：</td>
									<td>Windows 2008</td>
									<td width="90" align="right">系统开发：</td>
									<td><a href="http://www.pintuer.com" target="_blank">拼图前端框架</a></td>
								</tr>
								<tr>
									<td align="right">Web服务器：</td>
									<td>Apache</td>
									<td align="right">主页：</td>
									<td><a href="http://www.pintuer.com" target="_blank">http://www.pintuer.com</a></td>
								</tr>
								<tr>
									<td align="right">程序语言：</td>
									<td>PHP</td>
									<td align="right">演示：</td>
									<td><a href="http://www.pintuer.com/demo/" target="_blank">demo/</a></td>
								</tr>
								<tr>
									<td align="right">数据库：</td>
									<td>MySQL</td>
									<td align="right">群交流：</td>
									<td><a href="http://shang.qq.com/wpa/qunwpa?idkey=a08e4d729d15d32cec493212f7672a6a312c7e59884a959c47ae7a846c3fadc1" target="_blank">201916085</a> (点击加入)</td>
								</tr>
							</tbody>
						</table>
					</div>
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