<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="Description" content="${fns:getProjectName()},销售信息" />
<meta name="Keywords" content="${fns:getProjectName()},销售信息" />
<link href="${ctxStatic}/sbShop/css/laydate.css" rel="stylesheet"
	type="text/css" />
<title>营业汇总日报</title>
<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"
	media="all">
<link
	href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1"
	type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/sbShop/css/bootstrap.min.css" rel="stylesheet" />
<link href="${ctxStatic}/sbShop/css/bootstrap-select.min.css"
	rel="stylesheet" />
<link href="${ctxStatic}/sbShop/css/statistics.css" type="text/css"
	rel="stylesheet">

</head>
<body>
	<div class="overp">
		<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
			<span>当前位置：</span><span>报表管理 - </span><span style="color:#009688;">营业趋势</span>
		</div>

		<div class="backcolor commontitle">
			<ul class="clearfix overp">
				<li class="select1"><a
					href="${ctxweb}/shop/statement/statisticsList?type=1&isAll=0"><b></b>营收明细</a></li>
				<li class="select2"><b class="active"></b>营收趋势</li>
			</ul>
		</div>

		<div class="backcolor section1 clearfix">
			<ul class="clearfix">
				<li class="active li" type="2">
					<p>近七天</p>
				</li>
				<li class="li" type="3">
					<p>近三十天</p>
				</li>
				<li>
					<div class="customtime-box clearfix">
						<span class="left">自定义时间段</span>
						<div class="left customtime-box">
							<input id="customTime" type="text" /><b></b>
						</div>
					</div>
				</li>
			</ul>
		</div>

		<div class="backcolor section2">
			<!-- 	<ul class="clearfix">
				<li><span>应收金额：145.00元</span> <span><i></i>门店下单：145.00元</span>
					<span><i></i>门店自取：145.00元</span> <span><i></i>线上外卖：145.00元</span></li>
				<li><span>应收金额：145.00元</span> <span><i></i>门店下单：145.00元</span>
					<span><i></i>门店自取：145.00元</span> <span><i></i>线上外卖：145.00元</span></li>
				<li><span>应收金额：145.00元</span> <span><i></i>门店下单：145.00元</span>
					<span><i></i>门店自取：145.00元</span> <span><i></i>线上外卖：145.00元</span></li>
				<li class="clearfix"><span class="left title">应收金额：</span>
					<div class="left">
						<i>30%</i><i>20%</i><i>10%</i>
					</div></li>
				<li><span class="left title">应收金额：</span>
					<div class="left">
						<i>30%</i><i>20%</i><i>10%</i>
					</div></li>
				<li><span class="left title">应收金额：</span>
					<div class="left">
						<i>30%</i><i>20%</i><i>10%</i>
					</div></li>
			</ul> -->
		</div>

		<div class="backcolor section3">
			<div class="clearfix overp">

				<div class="left">
					<h5 class="mod-title">总量走势</h5>
					<div id="box1" class="common-mod"></div>
				</div>
				<div class="left">
					<h5 class="mod-title mod-title1">会员充值</h5>
					<div id="box2" class="common-mod"></div>
				</div>
			</div>

		</div>
	</div>
	<script src="${ctxStatic}/sbShop/js/jquery.min1.js"></script>
	<script src="${ctxStatic}/sbShop/js/laydate.js"></script>
	<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1"
		type="text/javascript"></script>
	<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
	<script type="text/javascript">
		$(function() {
			laydate.render({
				elem : '#customTime',
				range : true,
				done : function(value, date, endDate) {
					var type = $(".section1 .active").attr("type");
					getstatisticsList(value, type, "1");
				}
			});
			$(".section1 .li").click(function() {
				var type = $(this).attr("type");
				var customTime = $.trim($("#customTime").val());
				$(this).addClass("active").siblings().removeClass("active");
				getstatisticsList(customTime, type, "1");
			})
			var customTime = $.trim($("#customTime").val());
			getstatisticsList(customTime, "2", "1");
		})
	
		// 获取营业汇总日报列表
		function getstatisticsList(timeRange, quickTime, type) {
			var msg = "查询成功";
			var index = "";
			var msgerr = "操作异常，请刷新页面";
			var params = {
				timeRange : timeRange,
				quickTime : quickTime, //快捷选择时间，1  昨天    2前七天  3前三十天
				type : type //查询汇总的分类 1 日 2 月
			}
			$.ajax({
				url : "${ctxweb}/shop/statement/statisticsListJson",
				type : "post",
				data : params,
				beforeSend : function() {
					index = layer.load(2, {
						shade : false
					});
				},
				success : function(data) {
					layer.close(index);
					//code状态  01成功  02暂无数据
					if (data.code == '01') {
						var str = "";
						var allOrderInfo = data.allOrderInfo;
						var proportion = data.proportion;
						str = "<ul class='clearfix overp'>\
											            <li><span>销售总金额：" + allOrderInfo.payableMoneyMap.allPayableMoney + "元</span>\
											                 <span><i></i>门店下单：" + allOrderInfo.payableMoneyMap.storePayableMoney + "元</span>\
												             <span><i></i>门店自取：" + allOrderInfo.payableMoneyMap.selfPayableMoney + "元</span>\
												             <span><i></i>线上外卖：" + allOrderInfo.payableMoneyMap.onlinePayableMoney + "元</span>\
												        </li>\
											            <li><span>实收金额：" + allOrderInfo.realMoneyMap.allRealMoney + "元</span>\
											                <span><i></i>门店下单：" + allOrderInfo.realMoneyMap.storeRealMoney + "元</span>\
												            <span><i></i>门店自取：" + allOrderInfo.realMoneyMap.selfRealMoney + "元</span>\
												            <span><i></i>线上外卖：" + allOrderInfo.realMoneyMap.onlineRealMoney + "元</span>\
												        </li>\
											           <li><span>订单总数：" + allOrderInfo.orderCountMap.allOrderCount + "元</span>\
											                <span><i></i>门店下单：" + allOrderInfo.orderCountMap.storeOrderCount + "元</span>\
												            <span><i></i>门店自取：" + allOrderInfo.orderCountMap.selfOrderCount + "元</span>\
												            <span><i></i>线上外卖：" + allOrderInfo.orderCountMap.onlineOrderCount + "元</span>\
												        </li>\
											            <li class='clearfix'><span class='left title'>销售总金额：</span>\
												             <div class='left'>\
													             <i style='width:" + proportion.payable.store + "%'>" + proportion.payable.store + "%</i>\
													             <i style='width:" + proportion.payable.online + "%'>" + proportion.payable.online + "%</i>\
													             <i style='width:" + proportion.payable.self + "%'>" + proportion.payable.self + "%</i>\
												             </div>\
												       </li>\
											            <li><span class='left title'>订单总数：</span>\
												         <div class='left'>\
													             <i style='width:" + proportion.order.store + "%'>" + proportion.order.store + "%</i>\
													             <i style='width:" + proportion.order.online + "%'>" + proportion.order.online + "%</i>\
													             <i style='width:" + proportion.order.self + "%'>" + proportion.order.self + "%</i>\
												             </div>\
												       </li>\
											          <li><span class='left title'>实付金额：</span>\
												            <div class='left'>\
													             <i style='width:" + proportion.real.store + "%'>" + proportion.real.store + "%</i>\
													             <i style='width:" + proportion.real.online + "%'>" + proportion.real.online + "%</i>\
													             <i style='width:" + proportion.real.self + "%'>" + proportion.real.self + "%</i>\
												             </div>\
												      </li>\
										           </ul>"
						$(".section2").html(str);
	
						var orderInfoByDayList = data.orderInfoByDayList;
						var rechargeInfo = data.memberTopupByDayList;
						getorderInfoByDayList(orderInfoByDayList);
						getRechargeList(rechargeInfo);
	
					} else {
						layer.msg(data.msg);
					}
				}
			});
		}
	
		// 获取总量走势
		function getorderInfoByDayList(orderInfoByDayList) {
			var data1 = [], // 创建日期
				data2 = [], // 数据
				data3 = [],
				data4 = []; // 数据	
			for (var i = 0; i < orderInfoByDayList.length; i++) {
				data1.push(orderInfoByDayList[i].date);
				data2.push(orderInfoByDayList[i].payableMoney);
				data3.push(orderInfoByDayList[i].orderCount);
				data4.push(orderInfoByDayList[i].realMoney);
			}
			var myChart = echarts.init(document.getElementById('box1'));
			var option = {
				backgroundColor : '#fff',
				title : {
					/* 	text : '总量走势', */
					/* 	top : '10', */
					left : '3%',
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					top : '3%',
					data : [ '销售总金额', '订单总数', '实收金额' ]
				},
				grid : {
					left : '3%',
					top : '20%',
					right : '4%',
					bottom : '3%',
					containLabel : true
				},
				toolbox : {
					feature : {
						saveAsImage : {}
					}
				},
				xAxis : {
					type : 'category',
					boundaryGap : false,
					data : data1
				},
				yAxis : {
					type : 'value'
				},
				series : [ {
					name : "销售总金额",
					type : 'line',
					stack : '销售总金额',
					symbol : 'circle', //折点设定为实心点
					symbolSize : 7, //设定实心点的大小
					itemStyle : {
						normal : {
							color : '#6F89BB', //折点颜色
							lineStyle : {
								color : '#6F89BB'
							}
						}
					},
					data : data2
				},
					{
						name : "实收金额",
						type : 'line',
						stack : '实收金额',
						symbol : 'circle', //折点设定为实心点
						symbolSize : 7, //设定实心点的大小
						itemStyle : {
							normal : {
								color : '#F08B7A', //折点颜色
								lineStyle : {
									color : '#F08B7A'
								}
							}
						},
						data : data4
					},
					{
						name : "订单总数",
						type : 'line',
						stack : '订单总数',
						symbol : 'circle', //折点设定为实心点
						symbolSize : 7, //设定实心点的大小
						itemStyle : {
							normal : {
								color : '#6EB7DC', //折点颜色
								lineStyle : {
									color : '#6EB7DC'
								}
							}
						},
						data : data3
					}
				]
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}
	
		// 获取会员充值图表
		function getRechargeList(rechargeInfo) {
			var data1 = [], // 创建日期
				data2 = []; // 数据	
			for (var i = 0; i < rechargeInfo.length; i++) {
				data1.push(rechargeInfo[i].date);
				data2.push(rechargeInfo[i].proportion);
			}
			var myChart = echarts.init(document.getElementById('box2'));
			var option = {
				backgroundColor : '#fff',
				title : {
					/* 	text : '总量走势', */
					/* 	top : '10', */
					left : '3%',
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					top : '3%',
					data : [ '充值金额' ]
				},
				grid : {
					left : '3%',
					top : '20%',
					right : '4%',
					bottom : '3%',
					containLabel : true
				},
				toolbox : {
					feature : {
						saveAsImage : {}
					}
				},
				xAxis : {
					type : 'category',
					boundaryGap : false,
					data : data1
				},
				yAxis : {
					type : 'value'
				},
				series : [ {
					name : "充值金额",
					type : 'line',
					stack : '充值金额',
					symbol : 'circle', //折点设定为实心点
					symbolSize : 7, //设定实心点的大小
					itemStyle : {
						normal : {
							color : '#F08B7A', //折点颜色
							lineStyle : {
								color : '#F08B7A'
							}
						}
					},
					data : data2
				}
				]
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
	
	
		}
	</script>
</body>
</html>