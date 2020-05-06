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
<title>菜单营业分析</title>
<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"
	media="all">
<link
	href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1"
	type="text/css" rel="stylesheet" />
<link href="${ctxStatic}/sbShop/css/bootstrap.min.css" rel="stylesheet" />
<link href="${ctxStatic}/sbShop/css/bootstrap-select.min.css"
	rel="stylesheet" />
<link href="${ctxStatic}/sbShop/css/statistics.css?v=2" type="text/css"
	rel="stylesheet">
	<style>
	body .analyze-box1 ul li:nth-child(3),body .analyze-box1 ul li:nth-child(2){width:19%;}
	body .analyze-box3 ul li:nth-child(3),body .analyze-box3 ul li:nth-child(2){width:19%;}
	body .analyze-box1 ul li,body .analyze-box3 ul li{overflow:hidden;}
	body .analyze-box1 ul li:last-child,body .analyze-box3 ul li:last-child{width:11%;}
	.bootstrap-select .dropdown-menu li a span.text{line-height:30px;}
	.analyze-box2-mod .fast{border:0;}
	.analyze-box1 ul li,.analyze-box3 ul li{font-size:13px;}
	
	</style>
</head>
<body>

	<div class="overp backcolor">
		<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
			<span>当前位置：</span><span>报表管理 - </span><span style="color:#009688;">菜单营业分析</span>
		</div>

		<div class="clearfix">
			<div class="left clearfix  analyze-box2-mod">
				<span class="left">时间范围：</span>
				<div class="clearfix left timebox">
					<input type="text" id="time" /> <b></b>
				</div>
			</div>

			<div class="left clearfix  analyze-box2-mod">
				<span class="left">快捷选择：</span>
				 <select class="selectpicker fast"
					id="logisticsComCode">
					<option value="1">昨天</option>
					<option value="2">前七天</option>
					<option value="3">前30天</option>
				</select>
			</div>

			<input type="button" class="left" id="search" value="查询" />
			<!-- 	<input	type="button" class="left" id="reset" value="重置" /> -->

		</div>
	</div>
	</div>


	<div class="overp backcolor">
		<div class="analyze-box1 overp">
			<div class="analyze-box1-mod1"></div>

			<div class="analyze-box1-mod2"></div>
		</div>

		<div class="analyze-box3 overp"
				<c:if test="${!fns:isShowWeight()}">
					style="display: none;"
				</c:if>
		>
			<div class="analyze-box3-mod1"></div>

			<div class="analyze-box3-mod2"></div>
		</div>

		<div class="clearfix analyze-box2">
			<div class="left">
				<h5>菜品应收</h5>
				<div id="box1"></div>
			</div>
			<div class="right">
				<h5>菜品销售数量</h5>
				<div id="box2"></div>
			</div>
		</div>

		<div class="clearfix analyze-box4"
				<c:if test="${!fns:isShowWeight()}">
					style="display: none;"
				</c:if>
		>
			<div class="left">
				<h5>菜品应收</h5>
				<div id="box3"></div>
			</div>
			<div class="right">
				<h5>斩料销售数量</h5>
				<div id="box4"></div>
			</div>
		</div>

	</div>
	<script src="${ctxStatic}/sbShop/js/jquery.min1.js"></script>
	<script src="${ctxStatic}/sbShop/js/laydate.js"></script>
	<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
	<script src="${ctxStatic}/sbShop/js/bootstrap.min.js"></script>
	<script src="${ctxStatic}/sbShop/js/bootstrap-select.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1"
		type="text/javascript"></script>
	<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('.selectpicker').selectpicker('selectAll');
			laydate.render({
				elem : '#time',
				range : true
			});
	
			$("#search").click(function() {
				var time = $.trim($("#time").val());
				var value = $(".selectpicker").find("option:selected").val();
				getstatisticsList(time, value);
			})
			getstatisticsList("", "");
		})
	
	
		// 获取营业汇总日报列表
		function getstatisticsList(timeRange, quickTime) {
			var msg = "查询成功";
			var msgerr = "操作异常，请刷新页面";
			var params = {
				timeRange : timeRange, // 分页条件查询营业指标列表（json） 
				quickTime : quickTime, //快捷时间，如昨天为1  2为前七天 3前三十天
			}
	
			$.ajax({
				url : "${ctxweb}/shop/statement/productTasteListJson",
				type : "post",
				data : params,
				success : function(data) {
					//code状态  01成功  02暂无数据
					if (data.code == '01') {
						var salesProportion = data.salesProportion; // 销售数量
						var moneyProportion = data.moneyProportion; // 菜品应收
						var weightSalesProportion = data.weightSalesProportion; // 斩料销售数量
						var weightMoneyProportion = data.weightMoneyProportion; // 斩料菜品应收
						userSource(salesProportion, "box2", '销售数量');
						userSource(moneyProportion, "box1", '菜品应收');
						userSource(weightSalesProportion, "box4", '斩料数量');
						userSource(weightMoneyProportion, "box3", '斩料应收');
						var data = data.data;
						var str = "",
							str1 = "";
							str2 = "";
							str3 = "";

							debugger;
						str += "<h5>菜品应收</h5>\
					               <ul class='head clearfix'>\
						             <li>名称</li>\
						             <li>门店订单（金额／占比）</li>\
						             <li>门店自取（金额／占比）</li>\
						             <li>外卖（金额／占比）</li>\
						             <li>总计</li>\
						             <li>统计日期</li>\
					               </ul>"
						str1 += "<h5>菜品销售数量</h5>\
					               <ul class='head clearfix'>\
						             <li>名称</li>\
						             <li>门店订单（销售量／占比）</li>\
						             <li>门店自取（销售量／占比）</li>\
						             <li>外卖（销售量／占比）</li>\
						             <li>总计</li>\
						             <li>统计日期</li>\
					               </ul>"

                        str2 += "<h5>斩料应收</h5>\
					               <ul class='head clearfix'>\
						             <li>名称</li>\
						             <li>门店订单（金额／占比）</li>\
						             <li>门店自取（金额／占比）</li>\
						             <li>外卖（金额／占比）</li>\
						             <li>总计</li>\
						             <li>统计日期</li>\
					               </ul>"
                        str3 += "<h5>斩料销售数量</h5>\
					               <ul class='head clearfix'>\
						             <li>名称</li>\
						             <li>门店订单（销售量／占比）</li>\
						             <li>门店自取（销售量／占比）</li>\
						             <li>外卖（销售量／占比）</li>\
						             <li>总计</li>\
						             <li>统计日期</li>\
					               </ul>"

						for (var i = 0; i < data.length; i++) {
							str += "<ul class='content clearfix'>\
							              <li>" + data[i].shopName + "</li>\
							              <li>" + data[i].storeMoney + "/" + data[i].storeMoneyProportion + "</li>\
							              <li>" + data[i].selfMoney + "/" + data[i].selfMoneyProportion + "</li>\
							              <li>" + data[i].onlineMoney + "／" + data[i].onlineMoneyProportion + "</li>\
							              <li>" + data[i].moneyCount + "</li>\
							              <li>" + data[i].totalTimeStr + "</li>\
						                </ul>";
							str1 += "<ul class='content clearfix'>\
							              <li>" + data[i].shopName + "</li>\
							              <li>" + data[i].storeSales + "/" + data[i].storeSalesProportion + "</li>\
							              <li>" + data[i].selfSales + "/" + data[i].selfSalesProportion + "</li>\
							              <li>" + data[i].onlineSales + "／" + data[i].onlineSalesProportion + "</li>\
							              <li>" + data[i].salesCount + "</li>\
							              <li>" + data[i].totalTimeStr + "</li>\
						                </ul>";

                            str2 += "<ul class='content clearfix'>\
							              <li>" + data[i].shopName + "</li>\
							              <li>" + data[i].weightStoreMoney + "/" + data[i].weightStoreMoneyProportion + "</li>\
							              <li>" + data[i].weightSelfMoney + "/" + data[i].weightSelfMoneyProportion + "</li>\
							              <li>" + data[i].weightOnlineMoney + "／" + data[i].weightOnlineMoneyProportion + "</li>\
							              <li>" + data[i].weightMoneyCount + "</li>\
							              <li>" + data[i].totalTimeStr + "</li>\
						                </ul>";
                            str3 += "<ul class='content clearfix'>\
							              <li>" + data[i].shopName + "</li>\
							              <li>" + data[i].weightStoreSales/1000 + "公斤/" + data[i].weightStoreSalesProportion + "</li>\
							              <li>" + data[i].weightSelfSales/1000 + "公斤/" + data[i].weightSelfSalesProportion + "</li>\
							              <li>" + data[i].weightOnlineSales/1000 + "公斤／" + data[i].weightOnlineSalesProportion + "</li>\
							              <li>" + data[i].weightSalesCount/1000 + "公斤</li>\
							              <li>" + data[i].totalTimeStr + "</li>\
						                </ul>";
						}
						$(".analyze-box1-mod1").html(str);
						$(".analyze-box1-mod2").html(str1);
                        $(".analyze-box3-mod1").html(str2);
                        $(".analyze-box3-mod2").html(str3);
					} else {
						layer.msg(data.msg);
					}
				}
			});
		}
	
	
	
		// 不同来源注册用户订单转化量
		function userSource(obj, box, title) {
			var myChart = echarts.init(document.getElementById(box));
			var data1 = [],
				data2 = [],
				data3 = [];
			data1.push(obj.self); //自提
			data2.push(obj.online); // 线上
			data3.push(obj.store); // 门店
	
			var itemStyle = {
				normal : {
					opacity : 1,
					borderWidth : 0
				}
			};
			var option = {
				legend : {
					orient : 'vertical',
					x : 'left',
					top : "45%",
					left : "5%",
					data : [ '自提', '外卖', '门店' ]
				},
				backgroundColor : "#fff",
				/* 	title : {
						text : title,
						top : '5%',
						left : '43%',
						textStyle : {
							color : '#3E9388'
						}
					}, */
				tooltip : {},
				series : [ {
					name : '菜品应收',
					type : 'pie',
					selectedMode : 'single',
					selectedOffset : 30,
					clockwise : true,
					radius : '45%',
					center : [ '50%', '60%' ],
					label : {
						normal : {
							position : 'inner'
						}
					},
					labelLine : {
						normal : {
							show : false
						}
					},
					data : [ {
						value : data1,
						name : '自提',
						itemStyle : {
							normal : {
								color : '#F1AF63'
							}
						}
					},
						{
							value : data2,
							name : '外卖',
							itemStyle : {
								normal : {
									color : '#F08B7A'
								}
							}
						},
						{
							value : data3,
							name : '门店',
							itemStyle : {
								normal : {
									color : '#6EB7DC'
								}
							}
						}
					],
					itemStyle : itemStyle
				} ]
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}
	</script>


</body>
</html>