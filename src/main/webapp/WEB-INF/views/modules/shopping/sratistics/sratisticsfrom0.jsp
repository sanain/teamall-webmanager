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
<title>销售信息</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	background: rgba(128, 133, 144, .06);
}

.content {
	width: 100%;
}

.ordersbox {
	overflow: hidden;
	margin: 0 auto;
	flex-direction: row;
	display: -webkit-flex;
}

.left {
	float: left;
}

.item-mod {
	background: #fff;
	padding: 32px 40px;
	margin: 10px;
	flex: 1;
	height: 150px;
	position: relative;
}

.item-mod p {
	font-size: 12px;
	margin-top: 40px;
}

.item-mod h5 {
	font-size: 30px;
	font-weight: normal;
	color: rgba(10, 18, 32, .64);
}

.item-mod p, .item-mod h5 {
	padding-left: 50px;
}

.orderdetail, .detail-mod {
	overflow: hidden;
}

.detail-mod {
	width: 48%;
	background: #fff;
	margin-right: 10px;
	float: left;
	margin-left: 7px;
	margin-top: 10px;
}

#dailyorder, #WeekNewOrders, #Conversion, #differentSource, #weekDailyavg, #startupTimes,
	#differentuserRegiter {
	height: 530px;
}

.second {
	margin-left: 20px;
}

#orderClick, #orderDevice, #skuSalesVolumes, #spuSalesVolumes1, #spuSalesVolumes2,
#spuSalesVolumes3,
#differentTermial {
	border: 1px solid #efefef;
	overflow: auto;
	height: 530px;
}

#differentSource-mod,#differentuserRegiter-mod {
	width: 100%;
	height: 450px;
}

.head {
	background: #E7EAEC;
	height: 38px;
	line-height: 38px;
}

.highLight {
	background: #f7f8f9;
}

#orderClick ul, #orderDevice ul, #skuSalesVolumes ul, #spuSalesVolumes1 ul,
	 #spuSalesVolumes2 ul, #spuSalesVolumes3 ul,
	#weekregistrNumber ul, #weekallproductSales ul, #differentTermial ul,
	#differentuserRegiter ul {
	height: 38px;
	overflow: hidden;
	display: flex;
}

#orderClick ul li, #orderDevice ul li, #skuSalesVolumes ul li,
	#differentTermial ul li, #spuSalesVolumes1 ul li, #spuSalesVolumes2 ul li,
#spuSalesVolumes3 ul li, #weekregistrNumber ul li,
	#weekallproductSales ul li, #differentuserRegiter ul li {
	list-style: none;
	line-height: 38px;
	float: left;
	flex: 1;
	text-align: center;
	border: 1px solid #efefef;
}

#differentSource {
	clear: both;
}

.detail-mod p {
	height: 38px;
	line-height: 38px;
	padding-left: 15px;
	background: #dfdfdf;
}
#stratDate,#regiterstratDate{margin-left:2rem;}
#regiterBtn,#sourceBtn{width:50px;height:30px;line-height:30px;}
#regiterstratDate,#regiterendDate,#endDate,#stratDate{width:150px;height:30px;line-height:30px;margin-right:30px;margin-top:20px;margin-bottom:20px;border-radius:5px;text-indent:10px;background:none;border:1px solid #999;}
</style>
</head>

<body>
	<div class="content">
		<div class="ordersbox">
			<div class="left item-mod">
				<p>本周订单总量</p>
				<h5>${orderCount}</h5>
			</div>
			<div class="left item-mod">
				<p>本周支付订单总量</p>
				<h5>${payOrderCount}</h5>
			</div>
			<div class="left item-mod">
				<p>本周取消订单量</p>
				<h5>${closeOrderCount}</h5>
			</div>
			<div class="left item-mod">
				<p>本周申请退款订单量</p>
				<h5>${afterSaleCount}</h5>
			</div>
		</div>
		<div class="orderdetail">
			<div class="detail-mod" id="dailyorder"></div>
			<div class="detail-mod second" id="WeekNewOrders"></div>
			<div class="detail-mod" id="Conversion"></div>
			<div class="detail-mod second" id="weekDailyavg"></div>
			<div class="detail-mod" id="orderClick">
				<h5 class="head">首页各栏目点击量</h5>
			</div>

			<div class="detail-mod" id="skuSalesVolumes"></div>
			<div class="detail-mod" id="spuSalesVolumes1"></div>
			<c:if test="${fns:isShowWeight()}">
			<div class="detail-mod" id="spuSalesVolumes2"></div>
			</c:if>
				<%--<div class="detail-mod" id="spuSalesVolumes3"></div>--%>
			<div class="detail-mod" id="startupTimes"></div>

			<div class="detail-mod" id="differentSource">
				<input type="text" id="stratDate" placeholder="开始时间" /> <input
					type="text" id="endDate" placeholder="结束时间" />
				<button id="sourceBtn">查询</button>
				<div id="differentSource-mod"></div>
			</div>
			<div class="detail-mod" id="differentuserRegiter">
				<input type="text" id="regiterstratDate" placeholder="开始时间" /> <input
					type="text" id="regiterendDate" placeholder="结束时间" />
				<button id="regiterBtn">查询</button>
				<div id="differentuserRegiter-mod"></div>
			</div>
			<!-- 商品订单价格图标（非批发） -->
			<div class="detail-mod" id="weekregistrNumber"></div>
			<div class="detail-mod second" id="weekallproductSales"></div>
			<div class="detail-mod" id="orderDevice"></div>
			<div class="detail-mod" id="differentTermial"></div>
		</div>
	</div>

	<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	<script src="${ctxStatic}/sbShop/js/laydate.js"></script>
	<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
	<script src="${ctxStatic}/sbShop/js/china.js"></script>
	<script type="text/javascript">
		$(function() {
			obj.Init();
			laydate.render({
				elem : '#stratDate'
			});
			laydate.render({
				elem : '#endDate'
			});
			laydate.render({
				elem : '#regiterstratDate'
			});
			laydate.render({
				elem : '#regiterendDate'
			});
		})

        function sratisticsOrderitemByProduct(element , type){
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            $.ajax({
                url : "${ctxsys}/Sratistics/sratisticsorderitembyproduct",
                type : "post",
				data:{type:type},
                cache : false,
                success : function(data) {
                    if (data.code == '00') {
                        var str = "";
                        if(type == 1){
                            str += "<p>Spu数(计量类型：件)（商品总数量 多规格算一个）</p>"
						}else if(type ==2){
                            str += "<p>Spu数(计量类型：重量，计量单位：公斤)（商品总数量 多规格算一个）</p>"
						}

                        str += "<ul class='head'>";
                        str += "<li>商品ID</li>";
                        str += "<li>商品名称</li>";
                        str += "<li>销售数量</li>";
                        str += "</ul>";

                        if(data.sratisticsOrderItemByProductList.length == 0){
                            str += "<ul><li style='winth:100%;text-align: centor'>暂无数据</li></ul>"
						}else{
                            $.each(data.sratisticsOrderItemByProductList, function(index, item) {
                                str += "<ul  class='" + (index % 2 == 0 ? "highLight" : "") + "'><li>" + item[0] + "</li>";
                                str += "<li>" + item[1] + "</li>"
                                str += "<li>" + item[2] + "</li></ul>";
                            });
						}

                        $(element).html(str);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            })
        }

		var obj = {
			Init : function() {
				obj.sratisticsdayorder(); // 每日订单环比
				obj.sratisticsbyordermap(); // 不同终端订单转化量
				obj.sratisticsbyorderdevice(); // 不同来源注册用户订单转化量
				obj.sratisticsorderbyuserregiter();
				// 本周新增订单分布
				// 本周与上周订单数据分析
				obj.sratisticsdayorderzh(); // 各节点转化率分析 
				obj.sratisticsdayorderclick(); // 首页点击量
				obj.sratisticsorderitembyproduct1(); // spu  计量类型：件
				obj.sratisticsorderitembyproduct2(); // spu  计量类型：重量 计量单位：公斤
				obj.sratisticsorderitembyproduct3(); // spu  计量类型：重量 计量单位：克
				obj.sratisticsorderitembyproperty();
				obj.sratisticsbyregiteruser();
				obj.sratisticsbyopenapp();
				obj.sratisticsbyregiteruseravg();
				obj.sratisticsorderitembyproductsum();
				obj.sratisticsbyordernotwholesale();	
				obj.differeceuserReigter();
				// 不同来源注册用户订单转化量
				$("#sourceBtn").click(function() {
					obj.sratisticsorderbyuserregiter();
				})
	
				// 不同来源注册用户量
				$("#regiterBtn").click(function() {
					obj.differeceuserReigter();
				})
			},
	
			sratisticsdayorder : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsdayorder",
					type : "post",
					cache : false,
					success : function(data) {
						//console.log(data.code);
						if (data.code == '00') {
							obj.Dailyorder(data.orderList);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				});
			},
			// 各节点转化率分析
			sratisticsdayorderzh : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsdayorderzh",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var data1 = [],
								data2 = [],
								data3 = [],
								data4 = [],
								data5 = [],
								data6 = [],
								data7 = [];
							data2.push(data.liHashMaps[0].ebConversion_1['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_2['conversionTypeName'],
								data.liHashMaps[0].ebConversion_2['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_3['conversionTypeName'],
								data.liHashMaps[0].ebConversion_3['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_4['conversionTypeName'],
								data.liHashMaps[0].ebConversion_4['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_5['conversionTypeName'],
								data.liHashMaps[0].ebConversion_5['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_6['conversionTypeName']); //类型				
							for (var i = 0; i < data.liHashMaps.length; i++) {
								data1.push(data.list[i]); // 创建日期																	
								data3.push(data.liHashMaps[i].ebConversion_2['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_1['conversionCount'] - data.liHashMaps[i].ebConversion_2['conversionCount']) / data.liHashMaps[i].ebConversion_1['conversionCount']);
								data4.push(data.liHashMaps[i].ebConversion_3['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_2['conversionCount'] - data.liHashMaps[i].ebConversion_3['conversionCount']) / data.liHashMaps[i].ebConversion_1['conversionCount']);
								data5.push(data.liHashMaps[i].ebConversion_4['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_1['conversionCount'] - data.liHashMaps[i].ebConversion_2['conversionCount']) / data.liHashMaps[i].ebConversion_1['conversionCount']);
								data6.push(data.liHashMaps[i].ebConversion_5['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_1['conversionCount'] - data.liHashMaps[i].ebConversion_2['conversionCount']) / data.liHashMaps[i].ebConversion_1['conversionCount']);
								data7.push(data.liHashMaps[i].ebConversion_5['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_6['conversionCount'] - data.liHashMaps[i].ebConversion_5['conversionCount']) / data.liHashMaps[i].ebConversion_6['conversionCount']);
							}
							var myChart = echarts.init(document.getElementById('Conversion'));
							var option = {
								backgroundColor : '#fff',
								title : {
									text : '各节点转化率分析',
									top : '10',
									left : '3%',
								},
								tooltip : {
									trigger : 'axis'
								},
								legend : {
									top : '10%',
									data : data2
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
									name : data2[0],
									type : 'line',
									stack : '总量',
									data : data3
								},
									{
										name : data2[1],
										type : 'line',
										stack : '总量',
										data : data4
									},
									{
										name : data2[2],
										type : 'line',
										stack : '总量',
										data : data5
									},
									{
										name : data2[3],
										type : 'line',
										stack : '总量',
										data : data6
									},
									{
										name : data2[4],
										type : 'line',
										stack : '总量',
										data : data7
									}
								]
							};
							// 使用刚指定的配置项和数据显示图表。
							myChart.setOption(option);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				});
			},
			// 获取每日订单环比
			Dailyorder : function(seriesData) {
				// 基于准备好的dom，初始化echarts实例
				var myChart = echarts.init(document.getElementById('dailyorder'));
				var data1 = [],
					data2 = [],
					data3 = [];
				for (var i = 0; i < seriesData.length; i++) {
					data1.push(seriesData[i].daytime);
					data2.push(seriesData[i].orderCount);
					data3.push(seriesData[i].orderHb);
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
						data : [ '订单量', '每日订单环比' ]
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
						name : '新增订单量',
					},
						{
							type : 'value',
							name : '百分比',
							min : 0,
							max : 10000,
							axisLabel : {
								formatter : '{value}%'
							}
						}
					],
					series : [ {
						name : '订单量',
						type : 'bar',
						data : data2,
						yAxisIndex : 0,
						itemStyle : {
							normal : {
								color : '#787B98'
							}
						}
					},
						{
							name : '每日订单环比',
							type : 'line',
							yAxisIndex : 1,
							data : data3,
							itemStyle : {
								normal : {
									color : '#CB605D'
								}
							}
						}
					]
				};
	
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
			},
			sratisticsorderbyuserregiter : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				params = {
					startTime : $("#startDate").val(),
					endTime : $("#endDate").val()
				}
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsorderbyuserregiter",
					type : "post",
					cache : false,
					data : params,
					success : function(data) {
						if (data.code == '00') {
							obj.userSource(data.sratisticsOrderByUserRegiterList);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				});
			},
			// 不同来源注册用户订单转化量
			userSource : function(obj) {
				var myChart = echarts.init(document.getElementById('differentSource-mod'));
				var data1 = [],
					data2 = [],
					data3 = [],
					data4 = [],
					data5 = [],
					data6 = [],
					data7 = [];
				for (var i = 0; i < obj.length; i++) {
					var type = obj[i][0];
					switch (type) {
					case 1:
						data1.push(obj[i][2])
						break;
					case 2:
						data2.push(obj[i][2])
						break;
					case 3:
	
						data3.push(obj[i][2])
						break;
					case 4:
	
						data4.push(obj[i][2])
						break;
					case 5:
						data5.push(obj[i][2])
						break;
					case 6:
						data6.push(obj[i][2])
						break;
					default:
						break;
					}
				}
	
				var itemStyle = {
					normal : {
						opacity : 0.7,
						borderWidth : 1,
						borderColor : '#235894'
					}
				};
				var option = {
					backgroundColor : "#fff",
					title : {
						text : '不同来源注册用户订单转化量',
						top : '10%',
						left : '3%',
						textStyle : {
							color : '#333'
						}
					},
					tooltip : {},
					series : [ {
						name : '不同来源注册用户订单转化量',
						type : 'pie',
						selectedMode : 'single',
						selectedOffset : 30,
						clockwise : true,
						radius : '45%',
						center : [ '50%', '60%' ],
						label : {
							normal : {
								textStyle : {
									fontSize : 18,
									color : '#333'
								}
							}
						},
						labelLine : {
							normal : {
								lineStyle : {
									color : '#666'
								}
							}
						},
						data : [ {
							value : data1,
							name : 'Android'
						},
							{
								value : data2,
								name : 'IOS'
							},
							{
								value : data3,
								name : '分享H5注册'
							},
							{
								value : data4,
								name : '递推二维码H5'
							},
							{
								value : data5,
								name : '广告二维码'
							},
							{
								value : data6,
								name : '后台供应商添加'
							}
						],
						itemStyle : itemStyle
					} ]
				};
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
			},
			sratisticsbyordermap : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsbyordermap",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							obj.getWeekNeworders(data.sratisticsOrderByUserAreaList);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				});
			},
			// 本周新增订单分布
			getWeekNeworders : function(obj) {
				var jsonstr = "[]"; //定义一个数组形式的JSON字符串
				var items = eval('(' + jsonstr + ')'); //转换为JSON
				var json = {};
				// 基于准备好的dom，初始化echarts实例
				var myChart = echarts.init(document.getElementById('WeekNewOrders'));
				for (var i = 0; i < obj.length; i++) {
					json = {
						name : obj[i][1],
						value : obj[i][2]
					};
					items.push(json);
				}
				var option = {
					backgroundColor : '#fff',
					title : {
						text : '本周新增订单分布',
						top : '3%',
						left : '3%',
						x : 'left',
						"textStyle" : {
							"fontWeight" : "normal"
						}
					},
					tooltip : {
						trigger : 'item'
					},
	
					dataRange : {
						x : 'left',
						y : 'bottom',
						splitList : [ {
							start : 1500
						},
							{
								start : 900,
								end : 1500
							},
							{
								start : 310,
								end : 1000
							},
							{
								start : 200,
								end : 300
							},
							{
								start : 10,
								end : 200,
								label : '10 到 200'
							},
							{
								start : 0,
								end : 10,
								label : '<10',
								color : '#E6E8EA'
							}
						],
						color : [ '#E0022B', '#E09107', '#A3E00B' ]
					},
					toolbox : {
						show : true,
						orient : 'vertical',
						x : 'right',
						y : 'center',
						feature : {
							mark : {
								show : true
							},
							dataView : {
								show : true,
								readOnly : false
							},
							restore : {
								show : true
							},
							saveAsImage : {
								show : true
							}
						}
					},
					roamController : {
						show : true,
						x : 'right',
						mapTypeControl : {
							'china' : true
						}
					},
					series : [ {
						name : '订单量',
						type : 'map',
						mapType : 'china',
						roam : false,
						itemStyle : {
							normal : {
								label : {
									show : true,
									textStyle : {
										color : "rgb(249, 249, 249)"
									}
								}
							},
							emphasis : { // 选中样式
								borderWidth : 1,
								borderColor : '#fff',
								color : '#23da32',
								label : {
									show : true,
									textStyle : {
										color : '#fff'
									}
								}
							}
						},
						data : items
					} ]
				};
	
				// 使用刚指定的配置项和数据显示图表。
				myChart.setOption(option);
			},
	
			// 首页栏目点击量
			sratisticsdayorderclick : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsdayorderclick",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var str = "";
							str += "<p>首页各栏目点击量</p>";
							str += "<ul class='head'>";
							str += "<li>时间</li>";
							str += "<li>栏目名称</li>";
							str += "<li>点击量</li>";
							str += "</ul>";
							$.each(data.liHashMaps, function(index, item) {
								str += "<ul class='" + (index % 2 == 0 ? "highLight" : "") + "'><li>" + item.createDate + "</li>";
								str += "<li>" + item.ebBannerClickName + "</li>"
								str += "<li>" + item.ebBannerClickCount + "</li></ul>";
							});
							$("#orderClick").html(str);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				});
			},
			// 不同终端订单量
			sratisticsbyorderdevice : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsbyorderdevice",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var str = "";
							str = "<p>各终端订单量（柱状）</p>"
							str += "<ul class='head'>";
							str += "<li>注册类型</li>";
							str += "<li>注册名字</li>";
							str += "<li>注册数量</li>";
							str += "</ul>";
							$.each(data.sratisticsOrderByUserAreaList, function(index, item) {
								str += "<ul><li>" + (item[0] == 1 ? "自主" : "其他") + "</li>";
								str += "<li>" + (item[1] == 1 ? 'android' : (item[1] == 2 ? 'IOS' : item[1] == 3 ? 'H5' : "其他")) + "</li>"
								str += "<li>" + item[2] + "</li></ul>";
							});
							$("#orderDevice").html(str);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				});
			},
	
			// spu数(计量单位为件)
			sratisticsorderitembyproduct1 : function() {
				sratisticsOrderitemByProduct("#spuSalesVolumes1",1);
			},

			<c:if test="${fns:isShowWeight()}">
			// spu数(计量单位为件，重量为千克)
            sratisticsorderitembyproduct2 : function() {
                sratisticsOrderitemByProduct("#spuSalesVolumes2",2);
            },
            </c:if>
			// Sku数
			sratisticsorderitembyproperty : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsorderitembyproperty",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var str = "";
							str += "<p>Sku数（商品总数量 每个规格算一个）</p>"
							str += "<ul class='head'>";
							str += "<li>商品ID</li>";
							str += "<li>商品名称</li>";
							str += "<li>规格ID</li>";
							str += "<li>规格名称</li>";
							str += "<li>销售数量</li>";
							str += "</ul>";
							$.each(data.sratisticsOrderItemByPropertyList, function(index, item) {
								str += "<ul  class='" + (index % 2 == 0 ? "highLight" : "") + "'><li>" + item[0] + "</li>";
								str += "<li>" + item[1] + "</li>"
								str += "<li>" + item[2] + "</li>";
								str += "<li>" + item[3] + "</li>";
								str += "<li>" + item[4] + "</li></ul>";
							});
							$("#skuSalesVolumes").html(str);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				})
			},
			// 过去一周日均注册用户数
			sratisticsbyregiteruser : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsbyregiteruser",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var data1 = [],
								data2 = [];
							for (var i = 0; i < data.sratisticsbyregiteruserList.length; i++) {
								data1.push(data.sratisticsbyregiteruserList[i][0]);
								data2.push(data.sratisticsbyregiteruserList[i][1]);
							}
	
							var myChart = echarts.init(document.getElementById('weekDailyavg'));
							var option = {
								backgroundColor : '#fff',
								title : {
									text : '过去一周每日注册用户数',
									left : '3%',
									top : '10'
								},
								xAxis : {
									type : 'category',
									data : data1
								},
								yAxis : {
									type : 'value'
								},
								series : [ {
									data : data2,
									type : 'line'
								} ]
							};
							myChart.setOption(option);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				})
			},
			sratisticsbyopenapp : function() {
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsbyopenapp",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var data1 = [],
								data2 = [],
								data3 = [];
							for (var i = 0; i < data.ebConversionlist.length; i++) {
								if (i != 0) {
									data1.push(data.ebConversionlist[i][0]);
									data2.push(data.ebConversionlist[i][2]);
									data3.push(data.ebConversionlist[i - 1][2] == 0 ? 0 : (data.ebConversionlist[i][2] - data.ebConversionlist[i - 1][2] / data.ebConversionlist[i][2]));
								}
							}
							var myChart = echarts.init(document.getElementById('startupTimes'));
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
									data : [ '启动次数', '环比增长率' ]
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
									name : '启动次数',
								},
									{
										type : 'value',
										name : '百分比',
										min : 0,
										max : 1000,
										axisLabel : {
											formatter : '{value}%'
										}
									}
								],
								series : [ {
									name : '启动次数',
									type : 'bar',
									data : data2,
									yAxisIndex : 0,
									itemStyle : {
										normal : {
											color : '#787B98'
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
												color : '#CB605D'
											}
										}
									}
								]
							};
							myChart.setOption(option);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				})
			},
			sratisticsbyregiteruseravg : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsbyregiteruseravg",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var str = "";
							str += "<p>过去一周日均注册用户数</p>"
							str += "<ul class='head'>";
							str += "<li>开始日期</li>";
							str += "<li>结束日期</li>";
							str += "<li>平均注册次数</li>";
							str += "</ul>";
							$.each(data.sratisticsbyregiteruserAvgList, function(index, item) {
								str += "<ul><li>" + item[0] + "</li>";
								str += "<li>" + item[1] + "</li>"
								str += "<li>" + item[2] + "</li></ul>";
							});
							$("#weekregistrNumber").html(str);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				})
			},
			sratisticsorderitembyproductsum : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsorderitembyproductsum",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var str = "";
							str += "<p>过去一周全站商品销售总量</p>";
							str += "<ul class='head'>";
							str += "<li>开始日期</li>";
							str += "<li>结束日期</li>";
							str += "<li>销售数量</li>";
							str += "</ul>";
							$.each(data.sratisticsOrderitemByProductSum, function(index, item) {
								str += "<ul><li>" + item[0] + "</li>";
								str += "<li>" + item[1] + "</li>"
								str += "<li>" + item[2] + "</li></ul>";
							});
							$("#weekallproductSales").html(str);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				})
			},
			sratisticsbyordernotwholesale : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsbyordernotwholesale",
					type : "post",
					cache : false,
					success : function(data) {
						if (data.code == '00') {
							var str = "";
							str += "<p>商品订单价格图标(非批发)</p>";
							str += "<ul class='head'>";
							str += "<li>日期</li>";
							str += "<li>订单数</li>";
							str += "<li>总金额</li>";
							str += "<li>订单均价</li>";
							str += "<li>订单均让利额</li>";
							str += "</ul>";
							$.each(data.SratisticsOrderNotWholesaleList, function(index, item) {
								str += "<ul><li>" + item[0] + "</li>";
								str += "<li>" + item[1] + "</li>"
								str += "<li>" + item[2] + "</li>";
								str += "<li>" + item[3] + "</li>"
								str += "<li>" + item[4] + "</li></ul>";
							});
							$("#differentTermial").html(str);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				})
			},
			// 不同来源用户注册量
			differeceuserReigter : function() {
				var msg = "查询成功";
				var msgerr = "操作异常，请刷新页面";
				params = {
					startTime : $("#regiterstratDate").val(),
					endTime : $("#regiterendDate").val()
				}
				// 提交保存
				$.ajax({
					url : "${ctxsys}/Sratistics/sratisticsbyuserregiter",
					type : "post",
					cache : false,
					data:params,
					success : function(data) {
						if (data.code == '00') {
							var str = "";
							str += "<p>不同来源注册用户量</p>";
							str += "<ul class='head'>";
							str += "<li>注册类型</li>";
							str += "<li>注册名字</li>";
							str += "<li>注册数量</li>";
							str += "</ul>";
							$.each(data.getSratisticsByUserRegiterList, function(index, item) {
								var name = item[1].length > 12 ? item[1].substring(0, 12) + "..." : item[1];
								str += "<ul><li>" + item[0] + "</li>";
								str += "<li title=" + item[1] + ">" + name + "</li>"
								str += "<li>" + item[2] + "</li></ul>";
							});
							$("#differentuserRegiter-mod").html(str);
						} else {
							top.$.jBox.tip(msgerr, 'info');
						}
					}
				})
	
			}
		}
	</script>
</body>

</html>