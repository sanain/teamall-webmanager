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
    <title>门店首页</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/shop-home.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/idangerous.swiper.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
    <script src="${ctxStatic}/h5/js/idangerous.swiper.js"></script>
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');
       
          $('.list-box a').height($('.list-box a').width());

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });
            
                    //            轮播
            var mySwiper = new Swiper('.swiper-container',{
                pagination: '.pagination',
                loop:true,
                grabCursor: true,
                paginationClickable: true,
                autoplay:2500,
//                autoplayDisableOnInteraction:false,
                height:200
            });
        })
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/images/fanhui.png" alt="">
        <ul>
            <li><a class="active" href="${ctxweb}/ShopDetailsHtml/HomePage/${pmShopInfo.id}.html">首页</a></li>
            <li><a  href="${ctxweb}/ShopDetailsHtml/ShopDetailsList/${pmShopInfo.id}.html">在售</a></li>
            <li><a href="${ctxweb}/ShopDetailsHtml/Details/${pmShopInfo.id}.html">门店</a></li>
        </ul>
    </div>

    <div class="shop-logo" style="position:relative;">
    	<!-- 背景图 -->
        <%-- <img src="${pmShopInfo.shopBanner}" alt=""> --%>
       <!--logo图 -->
        <%-- <img src="${pmShopInfo.shopLogo}" style="position:absolute;width:auto;bottom:0;left:0;"> --%>
    </div>

    <div class="context">
        <!--banner-->
        <div class="banner-box">
          <div class="device">
                <div class="swiper-container">
                    <div class="swiper-wrapper" id="swiper-wrapperTo">
                       <c:forEach items="${ebAdvertises}" var="ebAdvertises"> 
          					<div class='swiper-slide'><img src="${ebAdvertises.advertuseImg}" /></div>
          				 </c:forEach> 
                    </div>
                </div>
                <div class="pagination"></div>
            </div>
        </div>

        <!--商品列表-->
        <div class="shop-list">
        <c:forEach items="${ebProducts}" var="ebProducts">
            <div class="list-box">
                <a href="${ctxweb}/ProductDetailsHtml/${ebProducts.productId}.html">
                   <c:set value="${ fn:split(ebProducts.prdouctImg, '|') }" var="str1" />
                    <img src="${str1[0]}" alt="">
                </a>
                <div class="layer-box">
                    <p>${ebProducts.productName}</p>
                    <div>
                        <span>¥ ${ebProducts.reasonablePrice}</span>
                        <b><img src="${ctxStatic}/h5/images/shanbao.png" alt="">${ebProducts.rewardDeeds}</b>
                    </div>
                </div>
              </div>
			</c:forEach>
            <%-- <div class="list-box">
                <a href="javascript:;">
                    <img src="${ctxStatic}/h5/images/shop-list1.png" alt="">
                </a>
                <div class="layer-box">
                    <p>ur 春夏连衣裙</p>
                    <div>
                        <span>¥ 78</span>
                        <b><img src="${ctxStatic}/h5/images/shanbao.png" alt="">3</b>
                    </div>
                </div>
            </div>

            <div class="list-box">
                <a href="javascript:;">
                    <img src="${ctxStatic}/h5/images/shop-list1.png" alt="">
                </a>
                <div class="layer-box">
                    <p>ur 春夏连衣裙</p>
                    <div>
                        <span>¥ 78</span>
                        <b><img src="${ctxStatic}/h5/images/shanbao.png" alt="">3</b>
                    </div>
                </div>
            </div> --%>
        </div>
    </div>

    <div class="download">
        <img class="down-logo" src="${ctxStatic}/h5/images/logo.png" alt="">
        <span>下载${fns:getProjectName()}</span>
        <a href="${ctxweb}/download">立即下载</a>
        <img class="d-del" src="${ctxStatic}/h5/images/d-del.png" alt="">
    </div>
</body>
</html>