<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>${fns:getProjectName()}商家中心</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/index.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/issue-classification.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    </script>
    <script>
    	$(function(){
    		$('.list-ul li a').click(function(){
    			$(this).closest('.list-ul').find('a').removeClass('hove');
    			$(this).addClass('hove')
    		});
    	})
    </script>
</head>
<body style="background: #E3E4E5;">
    <!--头部固定-->
    <div class="head">
	<ul class="list-ul" style="padding-left: 10px">
                <li style="width: 200px;">
                  <span style="margin-left: 20px; font-size: 20px; color: #ffffff;">${fns:getProjectName()}-商家平台</span>
                </li>
                
    </ul>
    	<ul class="list-ul">
                <li>
                    <a href="javascript:;">交易管理</a>
                    <ul>
                        <li><a href="${ctxweb}/shop/PmShopOrders/list" target="tager" >线上订单列表</a></li>
                       <%--  <li><a href="${ctxweb}/shop/PmShopOrders/OrderListx" target="tager" >线下订单列表</a></li> --%>
                        <li><a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">售后管理</a></li>
                        <li><a href="${ctxweb}/shop/home" target="tager">门店账号</a></li>
                        <%--<li><a href="${ctxweb}/shop/shopAccount/myAccount" target="tager">我的账户</a></li>
                    --%></ul>
                </li>
                <li>
                    <a href="javascript:;">物流管理</a>
                    <ul>
                        <li><a href="${ctxweb}/shop/PmShopOrders/orderList" target="tager">订单发货</a></li>
                        <li><a href="${ctxweb}/shop/shopinfofeight/feightEdit" target="tager">配送费设置</a></li>

                    </ul>
                </li>

                <li>
                    <a href="javascript:;">商品管理</a>
                    <ul>
                        <li><a href="${ctxweb}/shop/ebProductApplyShop/list" target="tager">商品申请</a></li>
                        <li><a href="${ctxweb}/shop/product/list3?prdouctStatus=1"  target="tager">已上架商品</a></li>
                        <li><a href="${ctxweb}/shop/product/list" target="tager">待上架商品</a></li>
                        <li><a href="${ctxweb}/shop/product/shopCertificatelist" target="tager">优惠卷管理</a></li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;">门店管理</a>
                    <ul>
                        <li><a href="${ctxweb}/shop/shopInfo/companyMsgForm" target="tager">基本信息</a></li>
                        <li><a href="${ctxweb}/shop/shopInfo/storeSetForm" target="tager">基本设置</a></li>
                        <li><a href="${ctxweb}/shop/shop/user" target="tager">门店人员管理</a></li>
                         <!-- <li><a href="${ctxweb}/shop/ShopAdvertise/list" target="tager">装修模板</a></li>-->
                        <li><a href="${ctxweb}/shop/shopInfo/addressList" target="tager">收货地址管理</a></li>
                        <li><a href="${ctxweb}/shop/EbProductcomment/list" target="tager">商品评价</a></li>
                        <li><a href="${ctxweb}/shop/message/messageList?messageType=1" target="tager">消息通知</a></li>
                        <li><a href="${ctxweb}/shop/EbAdvertisement/list" target="tager">广告投放</a></li>
                    </ul>
                </li>
            </ul>

        <ul>
            <li><a class="index-a" href="${ctxweb}/shop">首页</a></li>
            <li><a class="msg-a" href="${ctxweb}/shop/message/messageList?messageType=1" target="tager">消息在线</a></li>
            <li>您好！<span>${shopUser.mobile}</span> 欢迎来到${fns:getProjectName()}商家平台</li>
          <!--   <li>
                <select>
                    <option value="">Language</option>
                    <option value="">English</option>
                    <option value="">Chinese</option>
                </select>
            </li> -->
            <li>
                <a class="quit-a" href="${ctxweb}/outLogin" style="height:100%;width:55px;background:#454B5F;">退出登录</a>
            </li>
        </ul>
    </div>
    <%--
    <!--左边固定-->
    <div class="left-div">
        
        <div class="list-div">
            
        </div>
    </div>

    --%><iframe name="tager" class="tager" src="${ctxweb}/shop/home" frameborder="0" style="width: 100%;padding: 80px 20px 0 20px;background: #E3E4E5;"></iframe>
</body>
</html>