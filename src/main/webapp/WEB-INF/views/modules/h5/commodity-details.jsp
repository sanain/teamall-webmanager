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
    <title>商品详情</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/commodity-details.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
    <script>
        $(function(){
             var productTagsNames="${ebProduct.productTagsName}";
             var productTagsName=productTagsNames.split(",");
             var html="";
             for (var i=0;i<productTagsName.length;i++){
               html+=" <li>"+productTagsName[i]+"</li>";
             }
             $("#tag").html(html);
            $('html').css('font-size',$('body').width()/10+'px');

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });
 			$('.pic-list img').css({'width':'100%','height':'auto'});
        })
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/images/back-icon1.png" alt="" style="width: 6.33%;">
        <ul>
            <li><a href="${ctxweb}/ProductDetailsHtml/${ebProduct.productId}.html" style="color: #adadad;">商品</a></li>
            <li><a class="active" href="${ctxweb}/ProductDetailsHtml/ProductDetailsId/${ebProduct.productId}.html" style="color: #333333;
    border-bottom: 0px solid #ff0000;
    display: inline-block;">详情</a></li>
            <li><a href="${ctxweb}/ProductDetailsHtml/EbProductcomment/${ebProduct.productId}.html" style="color: #adadad;">评价</a></li>
        </ul>
    </div>

    <div class="context">
        <ul class="pic-list">
           ${ebProduct.productHtml}
        </ul>

        <div class="explain">
            <p>价格说明</p>
            <ul>
                <li><span>划线价格：</span><span>指商品的专柜价、吊牌价、正品零售价、产商指导价或改商品的曾经展示过的销售价为准，<b>并非原价</b>，仅供参考。</span></li>
                <li><span>未划线价格：</span><span>指商品的<b>实际标价</b>，不因表述的差异改变性质。具体成交价格根据商品参加活动，或会员使用优惠券、积分等发生变化最终已订单结算页为准。</span></li>
                <li>此说明仅当出现价格比较时有效，具体请参见《淘宝价格发布规范》。若商家单独对划线价格进行说明的，已商家的表述为准。</li>
            </ul>
        </div>

        <div class="related">
           <p>相关标签</p>
            <ul id="tag">
                <li>9.9包邮</li>
                <li>5月新品速递</li>
                <li>热卖</li>
                <li>${fns:getProjectName()}激励双宝</li>
            </ul>
        </div>
    </div>


    <div class="download">
        <img class="down-logo" src="${ctxStatic}/h5/images/logo.png" alt="">
        <span>下载${fns:getProjectName()}</span>
        <a href="${ctxweb}/download" style="background: #3BC969;">立即下载</a>
        <img class="d-del" src="${ctxStatic}/h5/images/d-del.png" alt="">
    </div>



</body>
</html>
