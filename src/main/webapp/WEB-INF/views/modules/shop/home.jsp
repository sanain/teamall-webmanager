<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="robots" content="noarchive">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
	<title>${fns:getProjectName()}商家中心</title>
	<script src="${ctxStatic}/sbShop/js/jquery.min.js"
			type="text/javascript"></script>
	<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
	<script src="${ctxStatic}/sbShop/js/home.js"></script>
	<script src="${ctxStatic}/h5/js/jquery.qrcode.js"></script>
	<script src="${ctxStatic}/h5/js/qrcode.js"></script>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/home.css?v=1">
	<link rel="stylesheet" href="${ctxStatic}/h5/agent/css/layer.css">
	<script src="${ctxStatic}/h5/js/layer.js"></script>
	<script>
        $(window.parent.document).find('.list-ul').find('ul').slideUp();
        $(window.parent.document).find('.list-ul').find('a').removeClass('active');
	</script>
	<script>
        var shopId=${shopInfo.id};
        var content='{"id":"'+shopId+'","type":"100101","appType":"yingke","cartNum":"1"}';
        var shopLink="https://mb.yk-mall.com/ShopDetailsHtml/HomePage/"+shopId+".html?appType=yingke&id="+shopId+"&type=100101&cartNum=1";
        $(function(){
            jQuery('#twocode').qrcode({width:100,height:100,correctLevel:0,text:shopLink});  //生成二维码
            scrollHtml();
        });
        function scrollHtml(){
            $.ajax({
                type: "POST",
                url: "${ctxweb}/shop/saleDetail?shopId="+shopId,
                success: function(data){
                    var html="";
                    if(data!=null&&data.length>0){
                        var daylist=data[0].daylist;
                        var orderList=data[0].orderList
                        var priceList=data[0].priceList

                        //option.yAxis[0].max=Math.max.apply(null, orderList);//y轴左边最大值
                        //option.yAxis[0].interval=50;//y轴左边间隔
                        //option.yAxis[1].max=Math.max.apply(null, priceList);//y轴右边最大值
                        //option.yAxis[1].interval=500;//y轴右边间隔

                        //option.xAxis[0].data=daylist;//x轴数据
                        //option.series[0].data=orderList;//订单量数据
                        //option.series[1].data=priceList;//交易额数据
                        //myChart.setOption(option);

                        var mounthList=data[0].mounthList;
                        html="<ul><li>今天</li><li>"+orderList[0]+"</li><li>"+priceList[0]+"</li></ul><ul><li>昨天</li><li>"+orderList[1]+"</li><li>"+priceList[1]+"</li></ul><ul><li>本月</li><li>"+mounthList[1]+"</li><li>"+mounthList[0]+"</li></ul>";
                    }else{
                    }
                    $("#detailed").append(html);
                }
            });
        }
	</script>

	<script>
        $(function(){
            if('${advertising.messageInfo}' != 'null' && '${advertising.messageInfo.messageTitle}'!=""){
                showAdvertising();
            }
        })

        function showAdvertising() {

            //公告
            layer.open({
                type: 1
                ,title: false //不显示标题栏
                ,closeBtn: false
                ,area: '540px;'
                ,shade: 0.8
                ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                ,btn: ['查看', '取消']
                ,btnAlign: 'l'
                ,moveType: 1 //拖拽模式，0或者1
                ,content: '<div style="padding: 10px 30px; line-height: 22px;width:440px; background-color: #fff;  font-weight: 300;"><h3 style="font-size: 25px;text-align:center;line-height: 25px;padding:0px;margin:20px 0px 0px 0px">${fns:abbr(advertising.messageInfo.messageTitle,40)}</h3 ><div style="text-indent:2em;max-height:200px;overflow:auto;">${advertising.messageInfo.messageContent}</div><br></div>'
                ,yes: function (index, layero) {
                    var type = '${advertising.messageInfo.messageType}';
                    console.log("type="+type)
                    var messageType = 1;

                    if(type == '1' || type == '3' || type == '4'){
                        messageType = 1;
                    }else if(type == '7' || type == '2' || type == '6' || type == '8'){
                        messageType = 2;
                    }else if(type == '5' || type == '9'){
                        messageType = 3;
                    }

                    window.top.tager.location.href="${ctxweb}/shop/message/messageList?messageType="+messageType;

                }
            });
        }
	</script>
	<style type="text/css">
		#shop-set {
			background: #495572;
			outline: none;
			font-size: 14px;
		}
	</style>
</head>
<body>
<div class="home">
	<div class="deal-right">
		<div class="shop-logo clearfix">
			<div class="left" style="width:70%;">
				<div class="shop-box1 clearfix">
					<img src="${shopInfo.shopLogo}" alt=""> <span>${shopInfo.shopName}</span>
				</div>
				<div class="shop-box2">
					<div class="shop-name">
						<ul>
							<li><span>门店名称：</span> <b>${shopInfo.shopName}</b></li>
							<%--<li style="margin-top:5px">
                        <span>线下买单：</span>
                        <b>${shopInfo.isLineShop==1?'已开通':'未开通'}</b>
                    </li>--%>
							<%--      <li style="margin-top:5px">
                        <span>默认折扣比：</span>
                        <b>${shopInfo.returnRatio}%</b>
                    </li>--%>
							<li><span>客服电话：</span> <b>${shopInfo.customerPhone}</b></li>
							<li><a id="shop-set" class="btn btn-primary"
								   href="${ctxweb}/shop/shopInfo/storeSetForm">门店设置</a></li>
						</ul>

					</div>
				</div>
			</div>
			<div class="right" style="width:30%;text-align:center;margin-top:10px;">
				<img src="${shopInfo.miniCode}" alt="" style="width:115px;height:115px;"/>
			</div>

		</div>
		<div class="deal-left">
			<div class="deal-left-box" style="padding:0px 20px;">
				<h5>
					<b
							style="float:left;width:5px;height:16px;border-right:3px solid #358FE6;margin-right:10px;margin-top:14px;"></b>订单详情
				</h5>
				<!--订单-->
				<ul>

					<li class="clearfix">
						<div class="left">
							<img src="${ctxStatic}/sbShop/images/select5-img.png" />
						</div>
						<div class="right">
							<p>
								<a href="${ctxweb}/shop/PmShopOrders/list?status=1">${waitPayCount}</a>
							</p>
							<span>待付款</span>
						</div>
					</li>
					<li class="clearfix">
						<div class="left">
							<img src="${ctxStatic}/sbShop/images/select1-img.png" />
						</div>
						<div class="right">
							<p>
								<a href="${ctxweb}/shop/PmShopOrders/list?status=2">${waitSendCount}</a>
							</p>
							<span>待发货</span>
						</div>
					</li>
					<li class="clearfix">
						<div class="left">
							<img src="${ctxStatic}/sbShop/images/select2-img.png" />
						</div>
						<div class="right">
							<p>
								<a href="${ctxweb}/shop/PmShopOrders/list?status=3">${waitTakeCount}</a>
							</p>
							<span>待收货</span>
						</div>
					</li>
					<li class="clearfix">
						<div class="left">
							<img src="${ctxStatic}/sbShop/images/select3-img.png" />
						</div>
						<div class="right">
							<p>
								<a href="${ctxweb}/shop/PmShopOrders/list?status=4">${endCount}</a>
							</p>
							<span>已完成</span>
						</div>
					</li>
					<li class="clearfix">
						<div class="left">
							<img src="${ctxStatic}/sbShop/images/select4-img.png" />
						</div>
						<div class="right">
							<p>
								<a href="${ctxweb}/shop/PmShopOrders/list">${orderAllCount}</a>
							</p>
							<span>全部订单</span>
						</div>
					</li>
				</ul>
				<!--退款-->
				<ul style="display: none">
					<li>退款详情</li>
					<li>
						<div>
							<p>
								<a
										href="${ctxweb}/shop/ReturnManagement/ReturnManagementList?refundStatus=1">${waitVerifyCount}</a>
							</p>
							<span>待审核</span>
						</div>
					</li>
					<li>
						<div>
							<p>
								<a
										href="${ctxweb}/shop/ReturnManagement/ReturnManagementList?refundStatus=5">${waitReturnGoodsCount}</a>
							</p>
							<span>待退货</span>
						</div>
					</li>
					<li>
						<div>
							<p>
								<a
										href="${ctxweb}/shop/ReturnManagement/ReturnManagementList?refundStatus=6">${waitTakeGoodsCount}</a>
							</p>
							<span>待收货</span>
						</div>
					</li>
					<li>
						<div>
							<p>
								<a
										href="${ctxweb}/shop/ReturnManagement/ReturnManagementList?refundStatus=8">${waitRefundCount}</a>
							</p>
							<span>待退款</span>
						</div>
					</li>
					<li>
						<div>
							<p>
								<a
										href="${ctxweb}/shop/ReturnManagement/ReturnManagementList?refundStatus=9">${platformInterventionCount}</a>
							</p>
							<span>平台介入</span>
						</div>
					</li>
				</ul>
			</div>
		</div>


		<div class="sb-right-top" style="display:none">
			<div class="twocode">
				<div id="twocode" style="padding-top: 13%;"></div>
			</div>
			<span>门店付款码</span>
		</div>

		<ul class="hao-pin" style="display: none">
			<li><span>${point}%</span>
				<p>好评率</p></li>
			<li><span>${color}%</span>
				<p>商品描述</p></li>
			<li><span>${service}%</span>
				<p>商家服务</p></li>
			<li><span>${logistics}%</span>
				<p>物流服务</p></li>
		</ul>
	</div>




	<!--销售情况-->
	<div class="market">
		<div class="market-box"style="padding:0px 20px;background:#fff;">
			<h5>
				<b
						style="float:left;width:5px;height:16px;border-right:3px solid #358FE6;margin-right:10px;margin-top:14px;"></b>销售详情
			</h5>
			<!--订单商品数-->
			<ul class="order order-box clearfix">
				<li>
					<div>
						<span><a href="${ctxweb}/shop/ebproductshop/index">在售商品</a></span>
					</div>
				</li>
				<li>
					<div>
						<span><a href="${ctxweb}/shop/ebProductApplyShop/list">申请商品</a></span>
					</div>
				</li>
				<li>
					<div>
						<span><a href="${ctxweb}/shop/PmShopOrders/list">查看订单</a></span>
					</div>
				</li>
				<li>
					<div style="display: none">
						<span><a href="${ctxweb}/shop/PmShopOrders/list?status=6">${cancelOrderCount}</a></span>
						<p>三个月内退货</p>
					</div>
				</li>
			</ul>
		</div>
		<!--订单列表-->
		<div class="market-list" style="margin-top:20px;">
			<ul class="list-top">
				<li>订单</li>
				<li>订单量</li>
				<li>交易额</li>
			</ul>
			<div class="list-body" id="detailed">
				<%--<ul>
                    <li>今天</li>
                    <li>8</li>
                    <li>15255.02</li>
                </ul>
                <ul>
                    <li>昨天</li>
                    <li>8</li>
                    <li>15255.02</li>
                </ul>
                <ul>
                    <li>本月</li>
                    <li>8</li>
                    <li>15255.02</li>
                </ul>
            --%>
			</div>
		</div>
	</div>

	<!--御可贡茶-->
	<div class="sb" style="display: none">
		<div class="sb-right">

			<div class="sb-right-bottom">
				<p>平台信息</p>
				<ul>
					<li>工作时间：周一至周五 9:00-18:00</li>
					<li>热线电话：020-81205238</li>
					<li>微信公众号：${fns:getProjectName()}电商商城</li>
				</ul>
			</div>
		</div>

		<div class="sb-left">
			<div class="sb-left-box">
				<div class="today-sb">
					<p>
						<%--<a href="${ctxweb}/shop/shopAccount/mylove"></a>--%>
						<fmt:formatNumber type="number" value="${ebUser.todayAddLove}"
										  pattern="0.0000" maxFractionDigits="4" />
					</p>
					<span>今日积分</span>
				</div>
				<ul>
					<li>
						<p>
							<%--<a href="${ctxweb}/shop/shopAccount/mybill"></a>--%>
							<fmt:formatNumber type="number" value="${ebUser.currentAmt}"
											  pattern="0.00" maxFractionDigits="2" />
						</p> <span>当前余额</span>
					</li>
					<li>
						<p>
							<%--<a href="${ctxweb}/shop/shopAccount/mybill?amt=0"></a>--%>${ebUser.frozenAmt==0.0?0.0:-ebUser.frozenAmt}</p>
						<span>冻结金额</span>
					</li>
					<li>
						<p>
							<%--<a href="${ctxweb}/shop/shopAccount/mybill?amtType=7"></a>--%>
							<fmt:formatNumber type="number" value="${ebUser.usableLove}"
											  pattern="0.0000" maxFractionDigits="4" />
						</p> <span>可激励积分</span>
					</li>
					<li>
						<p>
							<%--<a href="${ctxweb}/shop/shopAccount/mylove"></a>--%>${ebUser.currentLove}</p>
						<span>当前积分</span>
					</li>
					<li>
						<p>
							<%--<a href="${ctxweb}/shop/shopAccount/mybill"></a>--%>${ebUser.todayChangeLove}</p>
						<span>今日激励</span>
					</li>
					<li>
						<p>
							<%--<a href="${ctxweb}/shop/shopAccount/mybill"></a>--%>${ebUser.haveChangeLove}</p>
						<span>累计激励</span>
					</li>
					<li>
						<p>
							<%--<a href="${ctxweb}/shop/shopAccount/mybill"></a>--%>${ebUser.frozenLove}</p>
						<span>冻结积分数</span>
					</li>
					<li>
						<p>
							<%--<a href="${ctxweb}/shop/shopAccount/mylove"></a>--%>${ebUser.totalLove}</p>
						<span>累计积分</span>
					</li>
				</ul>
			</div>
		</div>


	</div>
</div>
</body>
</html>