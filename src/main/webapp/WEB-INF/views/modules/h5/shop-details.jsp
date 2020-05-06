<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,minimal-ui" name="viewport">
    <meta name="format-detection" content="telephone=no">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta name="x5-page-mode" content="app">
    <meta name="screen-orientation" content="portrait">
    <meta name="x5-orientation" content="portrait">
    <title>门店信息</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/shop-details.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });
        })
           function down (){
                location.href="${ctxweb}/download";

            }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/images/fanhui.png" alt="">
        <ul>
              <li><a href="${ctxweb}/ShopDetailsHtml/HomePage/${pmShopInfo.id}.html">首页</a></li>
              <li><a  href="${ctxweb}/ShopDetailsHtml/ShopDetailsList/${pmShopInfo.id}.html">在售</a></li>
              <li><a class="active" href="${ctxweb}/ShopDetailsHtml/Details/${pmShopInfo.id}.html">门店</a></li>
        </ul>
    </div>

    <div class="context">
        <div class="shop-msg">
        ${pmShopInfo.describeInfo}
          <!--   URBAN REVIVO，原名URBAN RENEWAL，系隶属于UR LIMITED（开曼）及UR HK LIMITED（香港）集团旗下的快时尚品牌，中国区的品牌运营通过集团子公司快尚时装（广州）有限公司进行负责。
       -->  </div>

        <ul class="shop-fen">
            <li><span>商品描述</span><b>${pmShopInfo.overallMerit}</b></li>
            <li><span>商家服务</span><b>${pmShopInfo.service}</b></li>
            <li><span>物流服务</span><b>${pmShopInfo.logiscore}</b></li>
        </ul>

        <ul class="shop-dizhi">
            <li>
                <img src="${ctxStatic}/h5/images/shop-phone.png" alt="">
                <span>${pmShopInfo.mobilePhone}</span>
            </li>
            <li>
                <img src="${ctxStatic}/h5/images/shop-dizhi.png" alt="">
                <span>${pmShopInfo.contactAddress}</span>
            </li>
        </ul>
    </div>

    <div class="download">
        <img class="down-logo" src="${ctxStatic}/h5/images/logo.png" alt="">
        <span>下载${fns:getProjectName()}</span>
        <a href="${ctxweb}/download">立即下载</a>
        <img class="d-del" src="${ctxStatic}/h5/images/d-del.png" alt="">
    </div>
</body>
</html>