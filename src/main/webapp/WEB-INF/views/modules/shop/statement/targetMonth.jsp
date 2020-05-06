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
<title>营业指标月报</title>
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
				<li class="select1"><a href="${ctxweb}/shop/statement/indicatorList?type=2&isAll=0"><b></b>营收明细</a></li>
				<li class="select2"><b class="active"></b>营收趋势</li>
			</ul>
		</div>

		<div class="backcolor section1 clearfix">
			<ul class="clearfix">
				<li class="active li" type="1">
					<p>近三个月</p>
				</li>
				<li class="li" type="2">
					<p>近六个月</p>
				</li>
				<li class="li" type="3">
					<p>近十二个月</p>
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

		<div class="backcolor section2"></div>

		<div class="backcolor section3 section3-1">

			<div class="clearfix overp">
				<div class="selectpicker-box">
					<h5 class="mod-title mod-title-1">总量走势</h5>
					<select class="selectpicker" id="selectpicker">
						<option value="1">环比增长率</option>
						<option value="2">同比增长率</option>
					</select>
				</div>
				<div id="box1" class="common-mod"></div>
			</div>

		</div>
	</div>
	<script src="${ctxStatic}/sbShop/js/jquery.min1.js"></script>
	<script src="${ctxStatic}/sbShop/js/laydate.js"></script>
	<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1"
		type="text/javascript"></script>
	<script src="${ctxStatic}/sbShop/js/bootstrap.min.js"></script>
	<script src="${ctxStatic}/sbShop/js/bootstrap-select.min.js"></script>
	<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('.selectpicker').selectpicker('selectAll');
	
			$('.selectpicker').on("change", function() {
				var value = this.value;
				var customTime=$.trim($("#customTime").val());
				var type = $(".section1 .active").attr("type");
				getstatisticsList(value, customTime, type, "2");
			})
			
			laydate.render({
				elem : '#customTime',
				range : true,
				done : function(value, date, endDate) {
				 var selectValue = $(".selectpicker").find("option:selected").val();
				 var type = $(this).attr("type");
					getstatisticsList(selectValue, value, type,"2");
				}
			});
	
	
			$(".section1 .li").click(function() {
				var value = $(".selectpicker").find("option:selected").val();
				var customTime=$.trim($("#customTime").val());
				var type = $(this).attr("type");
				$(this).addClass("active").siblings().removeClass("active");
				getstatisticsList(value, customTime, type, "2");
			})
			var value = $(".selectpicker").find("option:selected").val();
			var type = $(".section1 .active").attr("type");
			var customTime=$.trim($("#customTime").val());
			getstatisticsList(value, customTime, type, "2");
		})
	
		// 获取营业汇总日报列表
		function getstatisticsList(growthType, timeRange, quickTime, type) {
			var msg = "查询成功";
			var msgerr = "操作异常，请刷新页面";
				var index="";
			var params = {
				growthType : growthType, //增长率类型  1环比增长率  2同比增长率
				timeRange : timeRange, // 分页条件查询营业指标列表（json） 
				quickTime : quickTime, //快捷时间，如昨天为1  2为前七天 3前三十天
				type : type //查询汇总的分类 1 日 2 月（固定是1）
			}
			$.ajax({
				url : "${ctxweb}/shop/statement/indicatorListJson",
				type : "post",
				data : params,
			    beforeSend: function () {
                   index = layer.load(2, {shade: false});
                 },
				success : function(data) {
				 layer.close(index);
					//code状态  01成功  02暂无数据
					if (data.code == '01') {
	
						var infoData = data.data;
						getinfoList(infoData);
	
					} else {
						layer.msg(data.msg);
					}
				}
			});
		}
	
	
		// 获取每日订单环比
		function getinfoList(seriesData) {
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('box1'));
			var data1 = [],
				data2 = [],
				data3 = [];
			for (var i = 0; i < seriesData.length; i++) {
				data1.push(seriesData[i].date);
				data2.push(seriesData[i].realAmount);
				data3.push(seriesData[i].growthRate);
			}
			var option = {
				backgroundColor : '#fff',
				tooltip : {
					trigger : 'axis',
					axisPointer : {
						type : 'cross',
						crossStyle : {
							color : '#999'
						}
					}
				},
	
				legend : {
					top : '3%',
					data : [ '实收金额', '环比增长率' ]
				},
				xAxis : [ {
					type : 'category',
					data : data1,
					axisPointer : {
						type : 'shadow'
					}
				} ],
				yAxis : [ {
					type : 'value',
					name : '实收金额',
				},
					{
						type : 'value',
						name : '百分比',
						axisLabel : {
							formatter : '{value}%'
						}
					}
				],
				series : [ {
					name : '实收金额',
					type : 'bar',
					data : data2,
					barMaxWidth:60,
					yAxisIndex : 0,
					itemStyle : {
						normal : {
							color : '#F08B7A'
						}
					}
				},
					{
						name : '环比增长率',
						type : 'line',
						yAxisIndex : 1,
						data : data3,
						itemStyle : {
							normal : {
								color : '#6EB7DC'
							}
						}
					}
				]
			};
	
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}
	</script>
</body>
</html>