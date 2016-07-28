<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/pintuer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/pintuer/admin.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/boot.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/pintuer.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/respond.js"></script>
    <script src="${pageContext.request.contextPath}/js/pintuer/admin.js"></script>
    
    <script src="${pageContext.request.contextPath}/js/echarts/echarts.min.js"></script>
	<!-- 引入 vintage 主题 -->
	<script src="${pageContext.request.contextPath}/js/echarts/theme/shine.js"></script>
    
    <script type="text/javascript">
    	$(function(){
    		// 第二个参数可以指定前面引入的主题
    		var myChart = echarts.init(document.getElementById('main'), 'shine');
    		
    		var dataMap = {};
    		function dataFormatter(obj) {
    		    var pList = ['北京','天津','河北','山西','内蒙古','辽宁','吉林','黑龙江','上海','江苏','浙江','安徽','福建','江西','山东','河南','湖北','湖南','广东','广西','海南','重庆','四川','贵州','云南','西藏','陕西','甘肃','青海','宁夏','新疆'];
    		    var temp;
    		    for (var month = 1; month <= 7; month++) {
    		        var max = 0;
    		        var sum = 0;
    		        temp = obj[month];
    		        for (var i = 0, l = temp.length; i < l; i++) {
    		            max = Math.max(max, temp[i]);
    		            sum += temp[i];
    		            obj[month][i] = {
    		                name : pList[i],
    		                value : temp[i]
    		            }
    		        }
    		        obj[month + 'max'] = Math.floor(max / 100) * 100;
    		        obj[month + 'sum'] = sum;
    		    }
    		    return obj;
    		}
    		function dataFormatter2(obj) {
    		    var pList = ['北京','天津','河北','山西','内蒙古','辽宁','吉林','黑龙江','上海','江苏','浙江','安徽','福建','江西','山东','河南','湖北','湖南','广东','广西','海南','重庆','四川','贵州','云南','西藏','陕西','甘肃','青海','宁夏','新疆'];
    		    var temp;
    		    for (var year = 2002; year <= 2011; year++) {
    		        var max = 0;
    		        var sum = 0;
    		        temp = obj[year];
    		        for (var i = 0, l = temp.length; i < l; i++) {
    		            max = Math.max(max, temp[i]);
    		            sum += temp[i];
    		            obj[year][i] = {
    		                name : pList[i],
    		                value : temp[i]
    		            }
    		        }
    		        obj[year + 'max'] = Math.floor(max / 100) * 100;
    		        obj[year + 'sum'] = sum;
    		    }
    		    return obj;
    		}

    		dataMap.dataSMAD = dataFormatter({
    		    //max : 60000,
    		    7:[11115,6719.01,16011.97,7315.4,8496.2,13668.58,6426.1,8314.37,14069.87,30981.98,21462.69,8851.66,10823.01,6971.05,30933.28,18018.53,11328.92,11555,36796.71,7021,1503.06,5793.66,12601.23,3561.56,5692.12,394.85,7314.58,3166.82,1018.62,1203.92,4183.21],
    		    6:[9846.81,5252.76,13607.32,6024.45,6423.18,11164.3,5284.69,7104,12494.01,26018.48,18753.73,7360.92,9248.53,5800.25,25776.91,15012.46,9333.4,9439.6,31777.01,5823.41,1254.17,4676.13,10562.39,2884.11,4772.52,341.43,5757.29,2703.98,797.35,919.11,3523.16],
    		    5:[8117.78,4462.74,11467.6,4878.61,4944.25,9304.52,4275.12,6211.8,10572.24,21742.05,15718.47,6112.5,7583.85,4820.53,21900.19,12362.79,7617.47,7688.67,26587.76,4746.16,1065.67,3907.23,8690.24,2338.98,3988.14,290.76,4743.61,2277.35,648.5,725.9,3045.26],
    		    4:[6969.52,3905.64,10012.11,4230.53,3905.03,8047.26,3620.27,5513.7,9247.66,18598.69,13417.68,5350.17,6554.69,4056.76,18366.87,10587.42,6590.19,6596.1,22557.37,3984.1,918.75,3467.72,7385.1,2005.42,3462.73,248.8,3933.72,1933.98,543.32,612.61,2604.19],
    		    3:[6033.21,3110.97,8477.63,3571.37,3041.07,6672,3122.01,4750.6,8072.83,15003.6,11648.7,4759.3,5763.35,3456.7,15021.84,8553.79,5633.24,5641.94,18864.62,3433.5,819.66,3034.58,6379.63,1677.8,3081.91,220.34,3175.58,1688.49,466.1,537.11,2209.09],
    		    2:[5007.21,2578.03,6921.29,2855.23,2388.38,6002.54,2662.08,4057.4,6694.23,12442.87,9705.02,3923.11,4983.67,2807.41,12078.15,6867.7,4757.45,4659.99,15844.64,2821.11,713.96,2555.72,5333.09,1426.34,2556.02,185.09,2587.72,1399.83,390.2,445.36,1886.35],
    		    1:[4315,2150.76,6018.28,2324.8,1940.94,5458.22,2348.54,3637.2,5741.03,10606.85,8003.67,3519.72,4467.55,2450.48,10275.5,6035.48,4212.82,4151.54,13502.42,2523.73,642.73,2232.86,4725.01,1243.43,2312.82,162.04,2253.39,1232.03,340.65,377.16,1612.6]
    		});
    		dataMap.dataXM = dataFormatter({
    		    //max : 60000,
			    7:[112.83,122.58,2034.59,313.58,907.95,1302.02,916.72,1088.94,111.8,2100.11,1095.96,1418.09,1158.17,1060.38,3002.65,2658.78,1780,1892.4,1973.05,1453.75,436.04,575.4,2216.15,539.19,1020.56,60.62,753.72,462.27,105.57,118.94,691.07],
			    6:[101.26,110.19,1804.72,311.97,762.1,1133.42,783.8,915.38,101.84,1816.31,986.02,1200.18,1002.11,905.77,2509.14,2217.66,1378,1626.48,1695.57,1241.35,361.07,482.39,2032,446.38,837.35,54.89,592.63,387.55,83.41,97.89,628.72],
			    5:[88.8,103.35,1461.81,276.77,634.94,939.43,672.76,750.14,93.81,1545.05,925.1,1011.03,865.98,786.14,2138.9,1916.74,1140.41,1272.2,1532.17,1032.47,323.48,386.38,1595.48,382.06,724.4,50.9,484.81,334,67.55,79.54,527.8],
			    4:[88.68,112.38,1400,262.42,589.56,882.41,625.61,684.6,90.26,1461.51,892.83,966.5,827.36,727.37,1963.51,1892.01,1082.13,1100.65,1428.27,912.5,300.75,463.4,1481.14,368.94,661.69,48.04,435.77,308.06,65.34,72.07,509.99],
			    3:[87.36,105.28,1370.43,276.3,522.8,798.43,568.69,605.79,83.45,1367.58,814.1,950.5,786.84,664.5,1778.45,1649.29,1020.09,1022.45,1248.59,817.88,278.76,428.05,1379.93,334.5,607.75,44.3,387.88,286.78,60.7,65.33,461.26],
			    2:[84.11,89.91,1064.05,215.19,420.1,615.8,488.23,504.8,81.02,1162.45,717.85,749.4,692.94,560,1480.67,1198.7,798.35,886.47,1072.91,658.78,244.29,339.06,1128.61,298.69,494.6,40.7,302.66,237.91,48.47,55.63,412.9],
			    1:[82.44,84.21,956.84,197.8,374.69,590.2,446.17,474.2,79.68,1110.44,685.2,783.66,664.78,535.98,1390,1288.36,707,847.25,1015.08,601.99,222.89,317.87,1047.95,281.1,463.44,39.75,282.21,215.51,47.31,52.95,305]
    		});
    		dataMap.dataMY = dataFormatter({
    		    //max : 60000,
			    7:[2626.41,3709.78,8701.34,4242.36,4376.19,7158.84,3097.12,4319.75,6085.84,16993.34,11567.42,4198.93,5318.44,3554.81,17571.98,10259.99,5082.07,5028.93,18502.2,3037.74,423.55,3057.78,5823.39,1370.03,2452.75,115.56,3861.12,1470.34,557.12,609.98,2070.76],
			    6:[2509.4,2892.53,7201.88,3454.49,3193.67,5544.14,2475.45,3695.58,5571.06,14471.26,10154.25,3370.96,4476.42,2975.53,14647.53,8282.83,4143.06,3977.72,16004.61,2425.29,364.26,2368.53,4648.79,1124.79,2038.39,98.48,2986.46,1279.32,419.03,455.04,1647.55],
			    5:[2191.43,2457.08,6110.43,2755.66,2374.96,4566.83,1915.29,3365.31,4969.95,12282.89,8511.51,2711.18,3695.04,2419.74,12574.03,6724.61,3365.08,3187.05,13469.77,1878.56,308.62,1871.65,3775.14,967.54,1705.83,80.1,2452.44,1043.19,331.91,351.58,1459.3],
			    4:[2026.51,2135.07,5271.57,2357.04,1773.21,3869.4,1580.83,2971.68,4381.2,10524.96,7164.75,2245.9,3175.92,1917.47,10478.62,5514.14,2852.12,2612.57,11356.6,1510.68,240.83,1564,3067.23,821.16,1426.42,63.52,1951.36,838.56,264.61,281.05,1164.79],
			    3:[1853.58,1685.93,4301.73,1919.4,1248.27,3061.62,1329.68,2487.04,3892.12,8437.99,6250.38,1844.9,2770.49,1566.4,8478.69,4182.1,2320.6,2190.54,9280.73,1253.7,205.6,1376.91,2489.4,681.5,1281.63,52.74,1553.1,713.3,211.7,244.05,914.47],
			    2:[1487.15,1337.31,3417.56,1463.38,967.49,2898.89,1098.37,2084.7,3209.02,6787.11,5096.38,1535.29,2340.82,1204.33,6485.05,3310.14,1956.02,1777.74,7592.78,984.08,175.82,1135.31,2014.8,569.37,1047.66,47.64,1221.17,572.02,171.92,194.27,719.54],
			    1:[1249.99,1069.08,2911.69,1134.31,754.78,2609.85,943.49,1843.6,2622.45,5604.49,4090.48,1337.04,2036.97,941.77,5184.98,2768.75,1709.89,1523.5,6143.4,846.89,148.88,958.87,1733.38,481.96,934.88,32.72,1007.56,501.69,144.51,153.06,603.15]
    		});

    		option = {
    		    baseOption: {
    		        timeline: {
    		            // y: 0,
    		            axisType: 'category',
    		            // realtime: false,
    		            // loop: false,
    		            autoPlay: false,
    		            // currentIndex: 2,
    		            playInterval: 1500,
    		            // controlStyle: {
    		            //     position: 'left'
    		            // },
    		            data: [
    		                '2016-01','2016-02','2016-03','2016-04','2016-05','2016-06','2016-07','2016-08','2016-09','2016-10','2016-11','2016-12'
    		            ],
    		            label: {
    		                formatter : function(s) {
    		                	var date= new Date(s);
    		                	var year=date.getFullYear(); 
    		                	var month=date.getMonth()+1;
    		                	month =(month<10 ? "0"+month:month); 
    		                	var mydate = (year.toString() + "-" + month.toString());
    		                    return  mydate;
    		                }
    		            }
    		        },
    		        title: {
    		            subtext: '数据来自本站'
    		        },
    		        tooltip: {},
    		        legend: {
    		            x: 'right',
    		            data: ['诗蜜安黛', '夏目', '摩漾'],
    		            selected: {
    		                
    		            }
    		        },
    		        calculable : true,
    		        grid: {
    		            top: 80,
    		            bottom: 100
    		        },
    		        xAxis: [
    		            {
    		                'type':'category',
    		                'axisLabel':{'interval':0},
    		                'data':[
    		                    '北京','\n天津','河北','\n山西','内蒙古','\n辽宁','吉林','\n黑龙江',
    		                    '上海','\n江苏','浙江','\n安徽','福建','\n江西','山东','\n河南',
    		                    '湖北','\n湖南','广东','\n广西','海南','\n重庆','四川','\n贵州',
    		                    '云南','\n西藏','陕西','\n甘肃','青海','\n宁夏','新疆'
    		                ],
    		                splitLine: {show: false}
    		            }
    		        ],
    		        yAxis: [
    		            {
    		                type: 'value',
    		                name: '销量（个数）'
    		            }
    		        ],
    		        series: [
    		            /* {name: 'GDP', type: 'bar'},
    		            {name: '金融', type: 'bar'},
    		            {name: '房地产', type: 'bar'}, */
    		            {name: '诗蜜安黛', type: 'bar'},
    		            {name: '夏目', type: 'bar'},
    		            {name: '摩漾', type: 'bar'},
    		            {
    		                name: '销量占比',
    		                type: 'pie',
    		                center: ['75%', '35%'],
    		                radius: '28%'
    		            }
    		        ]
    		    },
    		    options: [
    		        {
    		            title: {text: '2016年1月品牌销量统计'},
    		            series: [
    		                {data: dataMap.dataSMAD['1']},
    		                {data: dataMap.dataXM['1']},
    		                {data: dataMap.dataMY['1']},
    		                {data: [
    		                    {name: '诗蜜安黛', value: dataMap.dataSMAD['1sum']},
    		                    {name: '夏目', value: dataMap.dataXM['1sum']},
    		                    {name: '摩漾', value: dataMap.dataMY['1sum']}
    		                ]}
    		            ]
    		        },
    		        {
    		            title : {text: '2016年2月品牌销量统计'},
    		            series : [
							{data: dataMap.dataSMAD['2']},
							{data: dataMap.dataXM['2']},
							{data: dataMap.dataMY['2']},
							{data: [
							    {name: '诗蜜安黛', value: dataMap.dataSMAD['2sum']},
							    {name: '夏目', value: dataMap.dataXM['2sum']},
							    {name: '摩漾', value: dataMap.dataMY['2sum']}
							]}
    		            ]
    		        },
    		        {
    		            title : {text: '2016年3月品牌销量统计'},
    		            series : [
							{data: dataMap.dataSMAD['3']},
							{data: dataMap.dataXM['3']},
							{data: dataMap.dataMY['3']},
							{data: [
							    {name: '诗蜜安黛', value: dataMap.dataSMAD['3sum']},
							    {name: '夏目', value: dataMap.dataXM['3sum']},
							    {name: '摩漾', value: dataMap.dataMY['3sum']}
							]}
    		            ]
    		        },
    		        {
    		            title : {text: '2016年4月品牌销量统计'},
    		            series : [
							{data: dataMap.dataSMAD['4']},
							{data: dataMap.dataXM['4']},
							{data: dataMap.dataMY['4']},
							{data: [
							    {name: '诗蜜安黛', value: dataMap.dataSMAD['4sum']},
							    {name: '夏目', value: dataMap.dataXM['4sum']},
							    {name: '摩漾', value: dataMap.dataMY['4sum']}
							]}
    		            ]
    		        },
    		        {
    		            title : {text: '2016年5月品牌销量统计'},
    		            series : [
							{data: dataMap.dataSMAD['5']},
							{data: dataMap.dataXM['5']},
							{data: dataMap.dataMY['5']},
							{data: [
							    {name: '诗蜜安黛', value: dataMap.dataSMAD['5sum']},
							    {name: '夏目', value: dataMap.dataXM['5sum']},
							    {name: '摩漾', value: dataMap.dataMY['5sum']}
							]}
    		            ]
    		        },
    		        {
    		            title : {text: '2016年6月品牌销量统计'},
    		            series : [
							{data: dataMap.dataSMAD['6']},
							{data: dataMap.dataXM['6']},
							{data: dataMap.dataMY['6']},
							{data: [
							    {name: '诗蜜安黛', value: dataMap.dataSMAD['6sum']},
							    {name: '夏目', value: dataMap.dataXM['6sum']},
							    {name: '摩漾', value: dataMap.dataMY['6sum']}
							]}
    		            ]
    		        },
    		        {
    		            title : {text: '2016年7月品牌销量统计'},
    		            series : [
    		                {data: dataMap.dataSMAD['7']},
    		                {data: dataMap.dataXM['7']},
    		                {data: dataMap.dataMY['7']},
    		                {data: [
    		                    {name: '诗蜜安黛', value: dataMap.dataSMAD['7sum']},
    		                    {name: '夏目', value: dataMap.dataXM['7sum']},
    		                    {name: '摩漾', value: dataMap.dataMY['7sum']}
    		                ]}
    		            ]
    		        },
    		        {
    		            title : {text: '2016年8月品牌销量统计'},
    		            series : [
    		                {data: 0},
    		                {data: 0},
    		                {data: 0},
    		                {data: [
    		                    {name: '诗蜜安黛', value: 0},
    		                    {name: '夏目', value: 0},
    		                    {name: '摩漾', value: 0}
    		                ]}
    		            ]
    		        }
    		        ,
    		        {
    		            title : {text: '2016年9月品牌销量统计'},
    		            series : [
    		                {data: 0},
    		                {data: 0},
    		                {data: 0},
    		                {data: [
    		                    {name: '诗蜜安黛', value: 0},
    		                    {name: '夏目', value: 0},
    		                    {name: '摩漾', value: 0}
    		                ]}
    		            ]
    		        }
    		        ,
    		        {
    		            title : {text: '2016年10月品牌销量统计'},
    		            series : [
    		                {data: 0},
    		                {data: 0},
    		                {data: 0},
    		                {data: [
    		                    {name: '诗蜜安黛', value: 0},
    		                    {name: '夏目', value: 0},
    		                    {name: '摩漾', value: 0}
    		                ]}
    		            ]
    		        }
    		        ,
    		        {
    		            title : {text: '2016年11月品牌销量统计'},
    		            series : [
    		                {data: 0},
    		                {data: 0},
    		                {data: 0},
    		                {data: [
    		                    {name: '诗蜜安黛', value: 0},
    		                    {name: '夏目', value: 0},
    		                    {name: '摩漾', value: 0}
    		                ]}
    		            ]
    		        }
    		        ,
    		        {
    		            title : {text: '2016年12月品牌销量统计'},
    		            series : [
    		                {data: 0},
    		                {data: 0},
    		                {data: 0},
    		                {data: [
    		                    {name: '诗蜜安黛', value: 0},
    		                    {name: '夏目', value: 0},
    		                    {name: '摩漾', value: 0}
    		                ]}
    		            ]
    		        }
    		    ]
    		};
    		
    		
    		
    		
    		// 指定图表的配置项和数据
            var option2 = {
                title: {
                    text: ''
                },
                tooltip: {},
                legend: {
                    data:['销量']
                },
                xAxis: {
                    data: ["诗蜜安黛","夏目","摩漾"]
                },
                yAxis: {},
                series: [{
                    name: '销量',
                    type: 'bar',
                    data: [5, 20, 36]
                }]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
            
            var myChart_pay = echarts.init(document.getElementById('main_pay'), 'shine');
            
            option_pay = {
            	    title: {
            	        text: '2016年度品牌销售金额'
            	    },
            	    tooltip: {
            	        trigger: 'axis'
            	    },
            	    legend: {
            	        data:['诗蜜安黛','夏目','摩漾']
            	    },
            	    grid: {
            	        left: '3%',
            	        right: '4%',
            	        bottom: '3%',
            	        containLabel: true
            	    },
            	    toolbox: {
            	        feature: {
            	            saveAsImage: {}
            	        }
            	    },
            	    xAxis: {
            	        type: 'category',
            	        boundaryGap: false,
            	        data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
            	    },
            	    yAxis: {
            	        type: 'value'
            	    },
            	    series: [
            	        {
            	            name:'诗蜜安黛',
            	            type:'line',
            	            stack: '金额',
            	            data:[120000, 132000, 101000, 134000, 90000, 230000, 210000]
            	        },
            	        {
            	            name:'夏目',
            	            type:'line',
            	            stack: '金额',
            	            data:[220000, 182000, 191000, 234000, 290000, 330000, 310000]
            	        },
            	        {
            	            name:'摩漾',
            	            type:'line',
            	            stack: '金额',
            	            data:[150000, 232000, 201000, 154000, 190000, 330000, 410000]
            	        }
            	    ]
            	};
            
            myChart_pay.setOption(option_pay);

    	})
	    function updatepass(id) {
			
			var url = "${pageContext.request.contextPath}/common/dispatch.do?page=/view/account/updateAccount";
			var title = "修改帐户信息";
	    	mini.open({
	            url: url,
	            title: title, width:500, height:400,
	            allowResize:true,
	            onload: function () {
	            	
	            },
	            ondestroy: function (action) {
	            }
	        });
			
		}
    </script>
    <style type="text/css">
    	body {
    		line-height: 15px;
    	}
    </style>
</head>
<body>
	<div class="admin">
		<div class="line-big">
			<div class="xm3">
				<div class="panel border-back">
					<div class="panel-body text-center">
						<img src="${pageContext.request.contextPath}/images/user_man.png" width="120" class="radius-circle">
						<br> <a href="#" title="点击修改帐户信息" style="color: #0ae;" onclick="updatepass('${sessionScope.CURRENT_USER_IN_SESSION.id }')">${sessionScope.CURRENT_USER_IN_SESSION.accountname == ""?sessionScope.CURRENT_USER_IN_SESSION.accountcode:sessionScope.CURRENT_USER_IN_SESSION.accountname  } </a>
					</div>
					<div class="panel-foot bg-back border-back">您好，${sessionScope.CURRENT_USER_IN_SESSION.accountname == ""?sessionScope.CURRENT_USER_IN_SESSION.accountcode:sessionScope.CURRENT_USER_IN_SESSION.accountname  }，欢迎使用后台管理系统。</div>
				</div>
				<br>
				<div class="panel">
					<div class="panel-head"><strong>站点统计</strong></div>
					<ul class="list-group">
						<li><span class="float-right badge bg-red">88</span><span class="icon-user-p"></span> 注册会员</li>
						<li><span class="float-right badge bg-red">88</span><span class="icon-user-p"></span> 仅关注人员</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-male"></span> 男性用户</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-female"></span> 女性用户</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-shopping-cart"></span> 订单总数</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-shopping-cart"></span> 未结束订单总数</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-file-text"></span> 品牌总数</li>
						<li><span class="float-right badge bg-main">828</span><span class="icon-database"></span> 商品总数</li>
					</ul>
				</div>
				<br>
			</div>
			<div class="xm9">
				<div class="alert alert-yellow"><span class="close"></span><strong>注意：</strong>您有5条未读信息，<a href="#">点击查看</a>。</div>
				<!-- <div class="alert">
					<h4>拼图前端框架介绍</h4>
					<p class="text-gray padding-top">拼图是优秀的响应式前端CSS框架，国内前端框架先驱及领导者，自动适应手机、平板、电脑等设备，让前端开发像游戏般快乐、简单、灵活、便捷。</p>
					<a target="_blank" class="button bg-dot icon-code" href="pintuer4.zip"> 下载示例代码</a>
					<a target="_blank" class="button bg-main icon-download" href="http://www.pintuer.com/download/pintuer.zip"> 下载拼图框架</a>
					<a target="_blank" class="button border-main icon-file" href="http://www.pintuer.com/"> 拼图使用教程</a>
				</div> -->
				<div class="panel">
					<div class="panel-head"><strong>2016年度品牌销量统计图</strong></div>
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    				<div id="main" style="width:100%;height:500px;margin-top: 20px"></div>
				</div>
				<div class="panel" style="margin-top: 20px">
					<div class="panel-head"><strong>2016年度品牌销售金额统计图</strong></div>
					<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    				<div id="main_pay" style="width:100%;height:500px;margin-top: 20px"></div>
				</div>
				<div class="panel" style="margin-top: 20px">
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
								<td><a href="http://www.pintuer.com" target="_blank">框架</a></td>
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
		<!-- <p class="text-right text-gray">基于<a class="text-gray" target="_blank" href="http://www.pintuer.com">框架</a>构建</p> -->
		
		<br>
	</div>
</body>
</html>