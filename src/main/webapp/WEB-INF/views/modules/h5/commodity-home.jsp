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
    <style>
    .swiper-slide img{width: 100%}
		body .pagination {
		    position: absolute;
		    left: 0;
		    bottom: 0;
		    text-align: center;
		    width: 100%;
		    margin-bottom: 10px;
		}
		.swiper-pagination-switch {
		    display: inline-block;
		    width: 10px;
		    height: 10px;
		    border-radius: 10px;
		    background: transparent;
		    margin: 0 3px;
		    cursor: pointer;
		    border: 1px solid #ffffff;
		}
		.swiper-active-switch {
		    background: #FF0000;
		
		}
		.swiper-container{width:100%}
		.swiper-slide{width:100%}
		.banner-box{overflow: hidden}
		.device{float: left;overflow: hidden;position: relative;width: 100%}
		.swiper-container{float: left;overflow: hidden}
		.pagination{z-index: 10000;width: 100%}
    </style>
    <title>商品主页</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/commodity-home.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
     <link rel="stylesheet" href="${ctxStatic}/h5/css/idangerous.swiper.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
    <script src="${ctxStatic}/h5/js/idangerous.swiper.js"></script>
    <script>
        $(function(){         
            $('.swiper-wrapper').css('width','100%');
            $('.swiper-slide').css('width','100%')
            //截取图片
            var imgs="${ebProduct.prdouctImg}";
            var img=imgs.split("|");
            var htmls="";
            for (var i=0;i<img.length;i++){
                htmls+="<div class='swiper-slide'> <img src='"+img[i]+"' alt=''> </div>";
             }
             $("#swiper-wrapperTo").html(htmls);
             console.log(img[0]);
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
            //$("#img").attr('src',"http://pmsc.5g88.com"+img[0]); 
            //截取属性
            var s="${ebProduct.pmProductPropertyStandard.propertyStandardValueStr}";
            var  a=s.split(";");
            var html="";
            console.log(a);
            for (var i=0;i<a.length;i++){
             if(a[i]!=undefined&&a[i]!=''&&a[i]!=null){
               html+=" <li><span>"+a[i].split(":")[0]+"</span><b>"+a[i].split(":")[1]+"</b></li>";
              }
            }
            $("#stan").html(html);
            $('html').css('font-size',$('body').width()/10+'px');

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });
            
     

            $('.box-del,.box-dell').click(function(){
                $('.size').hide();
                $('.parameter').hide();
            });
            $('.comm-xuan li').click(function(){
                var uli=$(this).index();
                if (uli==0){
                    $('.size').show();
                }else if (uli==1){
                    $('.parameter').show();
                }
            });
            $('.swiper-slide img').css('width','100%')
        })
        
                 function down (){
                location.href="${ctxweb}/download";

            }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/images/back-icon1.png" alt="" style="width: 6.33%;">
        <ul>
            <li><a class="active" href="${ctxweb}/ProductDetailsHtml/${ebProduct.productId}.html" style="color: #333333;
    border-bottom: 0px solid #ff0000;
    display: inline-block;">商品</a></li>
            <li><a href="${ctxweb}/ProductDetailsHtml/ProductDetailsId/${ebProduct.productId}.html" style="color: #adadad;">详情</a></li>
            <li><a href="${ctxweb}/ProductDetailsHtml/EbProductcomment/${ebProduct.productId}.html" style="color: #adadad;">评价</a></li>
        </ul>
    </div>

    <div class="context">
        <!--banner-->
        <div class="banner-box">
            <div class="device">
                <div class="swiper-container">
                    <div class="swiper-wrapper" id="swiper-wrapperTo">
                    </div>
                </div>
                <div class="pagination"></div>
            </div>
        </div>
        <div class="comm-msg">
           
            <p class="msg-jia"><span>¥<b>${ebProduct.reasonablePrice}</b></span> <b style="color:#FF0000">积分 ${ebProduct.rewardDeeds}</b></p>
            <span>市场价：<s>¥${ebProduct.marketPrice}</s></span>
			 <p class="msg-title">${ebProduct.productName}<!-- UR2017春夏新款女装修身显瘦一字肩短袖休闲T恤WB10B4HN2000 --></p>
            <div class="msg-div">
                <span style="display:none">快递：<c:if test="${ebProduct.courier==0}">免运费</c:if><c:if test="${ebProduct.courier!=0}">${ebProduct.courier}</c:if></span>
                <span>月销${ebProduct.monthSalesAmount}件</span>
                <span><!-- 广东广州 -->${ebProduct.provincesName}${ebProduct.municipalName}</span>
            </div>
        </div>

        <ul class="comm-xuan" style="display:none">
            <%-- <li><span>选择尺寸，颜色分类</span><img src="${ctxStatic}/h5/images/right-jiantou.png" alt=""></li> --%>
            <li><span>商品参数</span><img src="${ctxStatic}/h5/images/right-jiantou.png" alt=""></li>
        </ul>
        
        <!--评价-->
        <div class="comm-pin">
            <p>宝贝评价（<span>${ebProduct.comments}</span>）</p>
             <c:forEach items="${ebProduct.ebProductcomments}" var="ebProductcomments">
	            <div class="pin-box">
	                <p>
	                    <img src="${ctxStatic}/h5/images/comm-toux.png" alt="">
	                    <span>${ebProductcomments.username}</span>
	                </p>
	                <span>${ebProductcomments.contents}<!-- 超好看，身高175体重110斤，m码刚刚好，腰围有一点松腿型好看，亚麻色适合夏天。 --></span>
	                <div><fmt:formatDate value='${ebProductcomments.commentTime}' pattern='yyyy-MM-dd'/> ${ebProductcomments.productname}</div>
	            </div>
            </c:forEach>
            <div class="comm-btn">
                <a href="${ctxweb}/ProductDetailsHtml/EbProductcomment/${ebProduct.productId}.html" style="border: 1px solid #333333;border-radius: 10px;color:#333333">查看全部评价</a>
            </div>
        </div>

        <!--门店-->
        <div class="comm-gs" style="display:none">
            <p>
               <%--  <img src="${ctxStatic}/h5/images/comm-dp.png" alt=""> --%>
                <img src="${ebProduct.pmShopInfo.shopLogo}" alt="">
                <span>${ebProduct.pmShopInfo.shopName}</span>
            </p>
            <ul>
                <li>
                    <span>宝贝描述</span>
                    <i>${ebProduct.pmShopInfo.overallMerit}</i>
                    <c:if test="${ebProduct.pmShopInfo.overallMerit>4.5}"><u>高</u></c:if>
                </li>
                <li>
                    <span>卖家服务</span>
                    <i>${ebProduct.pmShopInfo.service}</i>
                    <c:if test="${ebProduct.pmShopInfo.service>4.5}"><u>高</u></c:if>
                </li>
                <li>
                    <span>物流服务</span>
                    <i>${ebProduct.pmShopInfo.logiscore}</i>
                    <c:if test="${ebProduct.pmShopInfo.logiscore>4.5}"><u>高</u></c:if>
                </li>
            </ul>
            <div class="gs-btn">
                <a href="${ctxweb}/ShopDetailsHtml/HomePage/${ebProduct.pmShopInfo.id}.html">进店看看</a>
            </div>
        </div>
    </div>


    <div class="download">
        <img class="down-logo" src="${ctxStatic}/h5/images/logo.png" alt="">
        <span>下载${fns:getProjectName()}</span>
        <a href="${ctxweb}/download" id="down" style="background: #3BC969;" >立即下载</a>
        <img class="d-del" src="${ctxStatic}/h5/images/d-del.png" alt="">
    </div>

    <!--尺寸，颜色框-->
    <div class="size">
        <div class="size-box">
            <img class="box-del" src="${ctxStatic}/h5/images/box-del.png" alt="">
            <div class="size-top">
                <img src="images/size-bg.png" alt="">
                <ul>
                    <li>¥396~469</li>
                    <li><img src="${ctxStatic}/h5/images/shanbao1.png" alt=""><span>3.986~4.986</span></li>
                    <li>库存8787件</li>
                    <li>请选择 尺码 颜色分类</li>
                </ul>
            </div>
            
            <div class="size-ul">
                <p>尺码</p>
                <ul>
                    <li>xs 32 (165/76A)</li>
                    <li>s 34 (165/76A)</li>
                    <li>M 36 (170/76A)</li>
                    <li>L 38 (170/76A)</li>
                </ul>
            </div>

            <div class="color-ul">
                <p>颜色分类</p>
                <ul>
                    <li>白色</li>
                    <li>红色</li>
                    <li>黑色</li>
                </ul>
            </div>

            <a class="box-dell" href="javascript:;">取消</a>
        </div>
    </div>
    <!--产品参数框-->
    <div class="parameter">
        <div class="parameter-box">
            <p>产品参数</p>
            <ul id="stan">
                <li><span>原产地</span><b>中国</b></li>
                <li><span>颜色分类</span><b>浅粉色 白色 黑色</b></li>
                <li><span>款号</span><b>656466684+5156565</b></li>
                <li><span>品牌</span><b>UR女装时尚服装</b></li>
                <li><span>上市时间</span><b>2017春季</b></li>
            </ul>
            <a class="box-dell" href="javascript:;">取消</a>
        </div>
    </div>
</body>
</html>