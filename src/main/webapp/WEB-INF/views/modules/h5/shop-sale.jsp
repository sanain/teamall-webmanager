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
    <title>门店在售</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/shop-sale.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
     <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />
    <script>
	    var salesVolume="${salesVolume}";
	    var priceTrue="${priceTrue}";
	    var update="";
	    var range = 50; //距下边界长度/单位px
	    var elemt = '500px'; //插入元素高度/单位px  
	    var totalheight = 0;
	    var tttz=0;
	    var endRow="0";
	    var id="${pmShopInfo.id}";
        $(function(){
        	$('.list-box a').height($('.list-box a').width());
            $(".loading-fixed").hide();
            $('html').css('font-size',$('body').width()/10+'px');

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });
//            列表切换
            $('.shop-nav li:last-child span').click(function(){
                if($(this).hasClass('active')){
                    $(this).removeClass('active');
                    $('.shop-list1').show();
                    $('.shop-list2').hide();
                }else {
                    $(this).addClass('active');
                    $('.shop-list1').hide();
                    $('.shop-list2').show();
                }
            });
            var jia=0;
            $('.shop-nav li a').click(function(){
                if (!$(this).hasClass('jia-ge')){
                    jia=0;
                    $('.jia-ge').removeClass('jia-ge1').removeClass('jia-ge2')
                }
                $(this).addClass('active').parent().siblings().children('a').removeClass('active');
            });
            $('.jia-ge').click(function(){
                if (jia<2){
                    jia++;
                    if (jia==1){
                        $(this).addClass('jia-ge1').removeClass('jia-ge2')
                          salesVolume="";
                          priceTrue="0";
                          endRow="0";
                          update="";
                          ajke()
                    }
                    if (jia==2){
                        $(this).addClass('jia-ge2').removeClass('jia-ge1')
                          salesVolume="";
                          priceTrue="1";
                           endRow="0";
                           update="";
                          ajke()
                    }
                }else {
                    jia=1;
                    if (jia==1){
                        $(this).addClass('jia-ge1').removeClass('jia-ge2')
                        salesVolume="";
                         endRow="0";
                          priceTrue="0";
                          ajke()
                    }
                    if (jia==2){
                        $(this).addClass('jia-ge2').removeClass('jia-ge1')
                          salesVolume="";
                           endRow="0";
                          priceTrue="1";
                          ajke()
                    }
                }
            });
            ajke();
            $(window).scroll(function(){
            var shoplist1 = $(".shop-list1"); //主体元素
	        var list2ul = $(".list2-ul"); //主体元素
                var srollPos = $(window).scrollTop(); //滚动条距顶部距离(页面超出窗口的高度)
                totalheight = parseFloat($(window).height()) + parseFloat(srollPos);
                if(($(document).height()) <= totalheight&&tttz==0) {
                    $.ajax({
		             type: "POST",
		             url: "${ctxweb}/ShopDetailsHtml/ShopDetailsList/jsonTo",
		             data: {id:id,salesVolume:salesVolume,priceTrue:priceTrue,endRow:(parseInt(endRow)+10),stateRow:endRow},
		             beforeSend:function(){
	    		     $(".loading-fixed").show();
	    	         },success: function(data){
	    	          $(".loading-fixed").hide();
		             console.log(data);
		             endRow=data.endRow;
		             salesVolume=data.salesVolume;
		             priceTrue=data.priceTrue;
		             update=data.update;
		             var html="";
		             var html2="";
		             if(data.objlist!=null&&data.objlist.length>0){ 
		               tttz=0;
		               $('.over').hide();
		                  for (var i=0;i<data.objlist.length;i++){
		                       html+="<div class='list-box'><a href='${ctxweb}/ProductDetailsHtml/"+data.objlist[i].productId+".html'> <img src='"+data.objlist[i].prdouctImg.split("|")[0]+"' alt=''></a><div class='layer-box'><p>"+data.objlist[i].productName+"</p><div><span>"+data.objlist[i].reasonablePrice+"</span><b><img src='${ctxStatic}/h5/images/shanbao.png' alt=''>3</b> </div></div></div>";
		                     html2+="<li><a class='ul-div1' href='${ctxweb}/ProductDetailsHtml/"+data.objlist[i].productId+".html'><img src='"+data.objlist[i].prdouctImg.split("|")[0]+"' alt=''></a><div class='ul-div2'><a href='javascript:;''>"+data.objlist[i].productName+"</a><div><span><i>¥</i>"+data.objlist[i].reasonablePrice+"</span><b><img src='${ctxStatic}/h5/images/shanbao1.png' alt=''>3</b></div></div></li>";
		                   }
		               }else{
		               	$('.over').show();
		                 tttz=1;
		              }
		             shoplist1.append(html);
		             list2ul.append(html2);
		            }
			     });
                }
            });
        })
        function fak(type){
         if(type=='1'){
           salesVolume="";
           priceTrue="";
           endRow="0";
           update="";
           ajke();
         }else if(type=='2'){
           salesVolume="1";
            endRow="0";
           priceTrue="";
            update="";
           ajke();
         }else if(type=='3'){
           salesVolume="";
           endRow="0";
           priceTrue="";
           update="1";
           ajke();
         }
        }
        function ajke(){
        var shoplist1 = $(".shop-list1"); //主体元素
	    var list2ul = $(".list2-ul"); //主体元素
        $.ajax({
             type: "POST",
             url: "${ctxweb}/ShopDetailsHtml/ShopDetailsList/jsonTo",
             data: {id:id,salesVolume:salesVolume,priceTrue:priceTrue,endRow:(parseInt(endRow)+10),stateRow:endRow},
             beforeSend:function(){
   		     $(".loading-fixed").show();
   	         },success: function(data){
   	          $(".loading-fixed").hide();
             console.log(data);
             endRow=data.endRow;
             salesVolume=data.salesVolume;
             priceTrue=data.priceTrue;
             update=data.update;
             var html="";
             var html2="";
             if(data.objlist!=null&&data.objlist.length>0){ 
                tttz=0;
                $('.over').hide();
                  for (var i=0;i<data.objlist.length;i++){
                     html+="<div class='list-box'><a href='${ctxweb}/ProductDetailsHtml/"+data.objlist[i].productId+".html' style='height: 182px;'> <img src='"+data.objlist[i].prdouctImg.split("|")[0]+"' alt=''></a><div class='layer-box'><p>"+data.objlist[i].productName+"</p><div><span>"+data.objlist[i].reasonablePrice+"</span><b><img src='${ctxStatic}/h5/images/shanbao.png' alt=''>3</b> </div></div></div>";
                     html2+="<li><a class='ul-div1' href='${ctxweb}/ProductDetailsHtml/"+data.objlist[i].productId+".html' style='height: 182px;'><img src='"+data.objlist[i].prdouctImg.split("|")[0]+"' alt=''></a><div class='ul-div2'><a href='javascript:;''>"+data.objlist[i].productName+"</a><div><span><i>¥</i>"+data.objlist[i].reasonablePrice+"</span><b><img src='${ctxStatic}/h5/images/shanbao1.png' alt=''>3</b></div></div></li>";
                   }
               }else{
               	$('.over').show();
                 tttz=1;
              }
              if(endRow=='10'){
              shoplist1.html(html);
              list2ul.html(html2);
              }else{
              shoplist1.append(html);
              list2ul.append(html2);
              }
           }
	     });
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/images/fanhui.png" alt="">
        <ul>
             <li><a href="${ctxweb}/ShopDetailsHtml/HomePage/${pmShopInfo.id}.html">首页</a></li>
              <li><a  class="active" href="${ctxweb}/ShopDetailsHtml/ShopDetailsList/${pmShopInfo.id}.html">在售</a></li>
              <li><a href="${ctxweb}/ShopDetailsHtml/Details/${pmShopInfo.id}.html">门店</a></li>
        </ul>
    </div>



    <div class="context">
        <ul class="shop-nav">
            <li><a class="active"  href="javascript:;" onclick="fak('1')">综合</a></li>
            <li><a href="javascript:;" onclick="fak('2')">销量</a></li>
            <li><a href="javascript:;" onclick="fak('3')">上新</a></li>
            <li><a class="jia-ge" href="javascript:;">价格</a></li>
            <li><span></span></li>
        </ul>

        <!--商品列表1-->
         <div class="shop-list1">
       <%--  <c:forEach items="${objlist}" var="objlist">
       
            <div class="list-box">
                <a href="javascript:;">
                    <img src="${ctxStatic}/h5/images/shop-list1.png" alt="">
                </a>
                <div class="layer-box">
                    <p>${objlist.productName }</p>
                    <div>
                        <span>¥ ${objlist.reasonablePrice}</span>
                        <b><img src="${ctxStatic}/h5/images/shanbao.png" alt="">3</b>
                    </div>
                </div>
            </div>
         </c:forEach> --%>
           <%--  <div class="list-box">
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
                    <img src="images/shop-list1.png" alt="">
                </a>
                <div class="layer-box">
                    <p>ur 春夏连衣裙</p>
                    <div>
                        <span>¥ 78</span>
                        <b><img src="${ctxStatic}/h5/images/shanbao.png" alt="">3</b>
                    </div>
                </div>
            </div>
         --%>
         </div>
        <!--商品列表2-->
        <div class="shop-list2">
            <ul class="list2-ul">
       <%--    <c:forEach items="${objlist}" var="objlist">
                <li>
                    <a class="ul-div1" href="javascript:;">
                        <img src="${ctxStatic}/h5/images/shop-list2.png" alt="">
                    </a>
                    <div class="ul-div2">
                        <a href="javascript:;">${objlist.productName }</a>
                        <div>
                            <span><i>¥</i>${objlist.reasonablePrice}</span>
                            <b><img src="${ctxStatic}/h5/images/shanbao1.png" alt="">3</b>
                        </div>
                    </div>
                </li>
                </c:forEach> --%>
               <%--  <li>
                    <a class="ul-div1" href="javascript:;">
                        <img src="${ctxStatic}/h5/images/shop-list2.png" alt="">
                    </a>
                    <div class="ul-div2">
                        <a href="javascript:;">UR2017春夏新款魅力女装V领短袖简约百搭T恤WB10B4DN200</a>
                        <div>
                            <span><i>¥</i> 78</span>
                            <b><img src="${ctxStatic}/h5/images/shanbao1.png" alt="">3</b>
                        </div>
                    </div>
                </li>
                <li>
                    <a class="ul-div1" href="javascript:;">
                        <img src="${ctxStatic}/h5/images/shop-list2.png" alt="">
                    </a>
                    <div class="ul-div2">
                        <a href="javascript:;">UR2017春夏新款魅力女装V领短袖简约百搭T恤WB10B4DN200</a>
                        <div>
                            <span><i>¥</i> 78</span>
                            <b><img src="${ctxStatic}/h5/images/shanbao1.png" alt="">3</b>
                        </div>
                    </div>
                </li>
                <li>
                    <a class="ul-div1" href="javascript:;">
                        <img src="${ctxStatic}/h5/images/shop-list2.png" alt="">
                    </a>
                    <div class="ul-div2">
                        <a href="javascript:;">UR2017春夏新款魅力女装V领短袖简约百搭T恤WB10B4DN200</a>
                        <div>
                            <span><i>¥</i> 78</span>
                            <b><img src="${ctxStatic}/h5/images/shanbao1.png" alt="">3</b>
                        </div>
                    </div>
                </li> --%>
            </ul>
        </div>
        <div class='over' style='display:none;width: 30%;margin: 0 auto;background: #CCCCCC;border-radius: 38px;text-align: center;height: 0.8rem;line-height: 0.8rem;margin-top: 20px;color: #fff;font-size: 0.35rem'>已经没有啦！</div>
    </div>
    <div class="loading-fixed">
		<div class="load-container load" >
			<div class="loader">Loading...</div>
		</div>
	</div>
    <div class="download">
        <img class="down-logo" src="${ctxStatic}/h5/images/logo.png" alt="">
        <span>下载${fns:getProjectName()}</span>
        <a href="javascript:;">立即下载</a>
        <img class="d-del" src="${ctxStatic}/h5/images/d-del.png" alt="">
    </div>
</body>
</html>