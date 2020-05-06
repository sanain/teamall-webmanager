<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>${fns:getProjectName()}商家中心</title>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css?v=1">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"
	type="text/javascript"></script>
   <style>
.activelogin{color:#000;height:100%;background:#454B5F;padding:0;text-align:center;}
.layui-nav-item12 {
	margin-right: 20px;
}
.layui-layout-admin .layui-logo{border-bottom:1px solid #23262E;}
.layui-layout-admin .layui-header{border-bottom:1px solid #f5f5f5;}
.layui-nav .layui-nav-mored {
	margin-top: -3px;
}

.layui-nav-item12 .layui-nav-more {
	border-color: #000 transparent transparent;
	border-top-color: #000;
}

.section {
	float: left;
	width: 15px;
	height: 45px;
	margin-right: 8px;
}

.nav-left-treelist  li:first-child a .section {
	background: url(${ctxStatic}/sbShop/images/l-icon1.png) no-repeat center
		center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(2) a .section {
	background: url(${ctxStatic}/sbShop/images/l-icon2.png) no-repeat center
		center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(3) a .section {
	background: url(${ctxStatic}/sbShop/images/l-icon3.png) no-repeat center
		center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(4) a .section {
	background: url(${ctxStatic}/sbShop/images/l-icon4.png) no-repeat center
		center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(5) a .section {
	background: url(${ctxStatic}/sbShop/images/l-icon5.png) no-repeat center
		center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(6) a .section {
	background: url(${ctxStatic}/sbShop/images/l-icon6.png) no-repeat center
		center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(7) a .section {
	background: url(${ctxStatic}/sbShop/images/l-icon7.png) no-repeat center
		center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(8) a .section {
	background: url(${ctxStatic}/sbShop/images/l-icon8.png) no-repeat center
		center;
	background-size: 100%;
}

.img1 {
	display: none;
}

.nav-left-treelist  li a .active {
	float: left;
	width: 15px;
	height: 45px;
	margin-right: 8px;
}

.nav-left-treelist  li:first-child a .active {
	background: url(${ctxStatic}/sbShop/images/l1-icon1.png) no-repeat
		center center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(2) a .active {
	background: url(${ctxStatic}/sbShop/images/l1-icon2.png) no-repeat
		center center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(3) a .active {
	background: url(${ctxStatic}/sbShop/images/l1-icon3.png) no-repeat
		center center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(4) a .active {
	background: url(${ctxStatic}/sbShop/images/l1-icon4.png) no-repeat
		center center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(5) a .active {
	background: url(${ctxStatic}/sbShop/images/l1-icon5.png) no-repeat
		center center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(6) a .active {
	background: url(${ctxStatic}/sbShop/images/l1-icon6.png) no-repeat
		center center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(7) a .active {
	background: url(${ctxStatic}/sbShop/images/l1-icon7.png) no-repeat
		center center;
	background-size: 100%;
}

.nav-left-treelist  li:nth-child(8) a .active {
	background: url(${ctxStatic}/sbShop/images/l1-icon8.png) no-repeat
		center center;
	background-size: 100%;
}
</style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header" style="background:#fff;">
        <%--<div class="layui-logo" style="background:#23262E;"><img src="${ctxStatic}/sbShop/images/left-logo.png" style="width:80%;"/></div>--%>
        <div class="layui-logo" style="background:#23262E;">
          <div style="width:80%;margin:0 auto;">
             <img src="${pmShopInfo.shopLogo}" style="width:38px;height:38px;float:left;margin-top:12px;"/>
             <label style="    font-size: 13px;color: white;">${fns:getSysSource(24)}</label>
          </div>
        </div>

            <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="" style="color:#000;">控制台</a></li>
            <li class="layui-nav-item" style="display:none;"><a href="">商品管理</a></li>
            <li class="layui-nav-item" style="display:none;"><a href="">用户</a></li>
            <li class="layui-nav-item" style="display:none;">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-nav-item12">
                <a href="javascript:;" style="color:#000;">
                    <%--邮箱--%>
                    <%--<img src="http://t.cn/RCzsdCq" class="layui-nav-img">--%>
               <%--      <img src="
                        <c:if test="${shopUser.avataraddress == null}">
                            ${ctxStatic}/sbShop/images/logo.jpg?v=1
                        </c:if>

                        <c:if test="${shopUser.avataraddress != null}">
                            ${shopUser.avataraddress}
                        </c:if>

                        <c:if test="${shopUser.avataraddress != null && shopUser.avataraddress.indexOf('h') != 0}">
                            ${ctxStatic}${shopUser.avataraddress}
                        </c:if>

                    " class="layui-nav-img"> --%>
                    <%--${shopUser.username}--%>
                    ${shopUser.shopName}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="${ctxweb}/shop/shopInfo/companyMsgForm"  target="tager">基本资料</a></dd>
                    <dd><a href="${ctxweb}/shop/shopInfo/storeSetForm"  target="tager">基本设置</a></dd>
                </dl>
            </li>
           	<li class="layui-nav-item outlogin"><a
					href="${ctxweb}/outLogin"> <img
						src="${ctxStatic}/sbShop/images/colse.png" style="width:15px;"
						class="img1" /> <img src="${ctxStatic}/sbShop/images/colse1.png"
						style="width:15px;" class="img2" />
				</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree nav-left-treelist"  lay-filter="test">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;"><b class="section1 active"></b>交易管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${ctxweb}/shop/PmShopOrders/list" target="tager" >订单列表</a></dd>
                        <dd style="display: none"><a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">售后管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"><b class="section2 section"></b>物流管理</a>
                    <dl class="layui-nav-child">
                        <%--<dd><a href="${ctxweb}/shop/PmShopOrders/orderList" target="tager">订单发货</a></dd>--%>
                        <dd><a href="${ctxweb}/shop/shopinfofeight/feightEdit" target="tager">配送费设置</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"><b class="section3 section"></b>商品管理</a>
                    <dl class="layui-nav-child">
                        <c:if test="${pmShopInfo.isProductType==1}">
                          <dd><a href="${ctxweb}/shop/PmProductType/show"  target="tager">分类管理</a></dd>
                           <dd><a href="${ctxweb}/shop/PmProductTypeSpertAttr/show"  target="tager">规格管理</a></dd>
                        </c:if>
                            <c:if test="${pmShopInfo.isProduct==1}">
                            <dd><a href="${ctxweb}/shop/product/list"  target="tager">门店商品管理</a></dd>
                            </c:if>
                        <dd><a href="${ctxweb}/shop/ebProductApplyShop/list" target="tager">平台商品申请</a></dd>
                       <%-- <dd><a href="${ctxweb}/shop/product/list3?prdouctStatus=1"  target="tager">商品列表</a></dd>--%>
                        <dd><a href="${ctxweb}/shop/ebProductPriceApply/applyList"  target="tager">商品价格申请</a></dd>
                        <%--<dd><a href="${ctxweb}/shop/ebProductChargingApply"  target="tager">加料申请</a></dd>--%>

                        <dd><a href="${ctxweb}/shop/ebproductshop/index"  target="tager">平台商品列表</a></dd>
                        <dd><a href="${ctxweb}/shop/shopPmProductType/list"  target="tager">加料管理</a></dd>
                        <%--<dd><a href="${ctxweb}/shop/ebProductPriceApply/applyList"  target="tager">商家加料申请</a></dd>--%>
                        <%--<dd><a href="${ctxweb}/shop/EbProductcomment/list" target="tager">商品评价</a></dd>--%>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;"><b class="section4 section"></b>门店管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${ctxweb}/shop/shopInfo/companyMsgForm" target="tager">基本信息</a></dd>
                        <dd><a href="${ctxweb}/shop/shopInfo/storeSetForm" target="tager">基本设置</a></dd>
                        <dd><a href="${ctxweb}/shop/product/shopCertificatelist" target="tager">优惠券管理</a></dd>
                        <dd><a href="${ctxweb}/shop/product/promotionlist" target="tager">促销活动</a></dd>
                        <dd><a href="${ctxweb}/shop/EbAdvertisement/list" target="tager">收银端广告</a></dd>
                        <dd><a href="${ctxweb}/shop/ebShopAdvertise/advertiseList" target="tager">小程序广告</a></dd>
                        <dd style="display: none"><a href="${ctxweb}/shop/ticket/ticketList" target="tager">小票模板</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"><b class="section5 section"></b>收益管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${ctxweb}/shop/pmUserBank/list" target="tager">银行卡管理</a></dd>
                        <dd><a href="${ctxweb}/shop/shopPmAmtLog/index"  target="tager">资金提现</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;"><b class="section6 section"></b>人员设置</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${ctxweb}/shop/shop/user" target="tager">门店人员管理</a></dd>
                        <dd><a href="${ctxweb}/shop//shop/user/performanceList?shopId=${shopuser.shopId}" target="tager">业绩查看</a></dd>
                    </dl>
                </li>

                <li class="layui-nav-item">
                    <a href="javascript:;"><b class="section"></b>报表管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${ctxweb}/shop/statement/statisticsList?type=1&isAll=0&shopId=${shopuser.shopId}" target="tager">营业汇总日报</a></dd>
                        <dd><a href="${ctxweb}/shop/statement/statisticsList?type=2&isAll=0&shopId=${shopuser.shopId}" target="tager">营业汇总月报</a></dd>
                        <dd><a href="${ctxweb}/shop/statement/indicatorList?type=1&isAll=0&shopId=${shopuser.shopId}" target="tager">营业指标日报</a></dd>
                        <dd><a href="${ctxweb}/shop/statement/indicatorList?type=2&isAll=0&shopId=${shopuser.shopId}" target="tager">营业指标月报</a></dd>
                        <dd><a href="${ctxweb}/shop/statement/businessDaily?shopId=${shopuser.shopId}" target="tager">营业日报</a></dd>
                        <dd><a href="${ctxweb}/shop/statement/reportbusinessAnalysis" target="tager">菜单营业分析</a></dd>
                        <dd style="display:none;"><a href="${ctxweb}/shop/shop/user/amtList" target="tager">人员提成列表</a></dd>
                    </dl>
                </li>


                <li class="layui-nav-item"><a href="${ctxweb}/shop/message/messageList?messageType=1" target="tager"><b class="section"></b>消息通知</a></li>
                <li style="display: none" class="layui-nav-item"><a href="${ctxweb}/shop/EbProductcomment/list" target="tager">商品评价</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="height: 100%;"><iframe name="tager" class="tager" src="${ctxweb}/shop/home" frameborder="0" style="width: 100%;padding:0px 0px 0px 0px;background: #E3E4E5;height: 100%;"></iframe></div>
    </div>

    <div class="layui-footer" style="background:#f5f5f5;text-align:center;">
        <!-- 底部固定区域 -->
        <%--© xiruikk.com - 御可贡茶商家中心--%>
        ${fns:getSysSource(16)}
    </div>
</div>
<script src="${ctxStatic}/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
    
    $(".nav-left-treelist  li a").click(function(){
    if(  $(this).find("b").hasClass("active")){
      $(this).find("b").addClass("section").removeClass("active");
    }
    else{
      $(this).find("b").addClass("active").removeClass("section");
    }
    })
    
    	$(".outlogin").hover(function() {
	
			if ($(this).find("a").hasClass("activelogin")) {
				$(this).find("a").removeClass("activelogin");
				$(this).find(".img2").show();
				$(this).find(".img1").hide();
			} else {
				$(this).find("a").addClass("activelogin");
				$(this).find(".img1").show();
				$(this).find(".img2").hide();
			}
		})
</script>
</body>
</html>