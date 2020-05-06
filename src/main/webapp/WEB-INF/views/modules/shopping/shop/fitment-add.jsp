<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},门店装修"/>
	<meta name="Keywords" content="${fns:getProjectName()},门店装修"/>
    <title>添加模块</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-fitment-add.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
</head>
<body>
    <div class="fitment">
        <ul class="nav-ul">
            <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${shopid}">门店信息</a></li>
            <li><a href="${ctxsys}/PmShopInfo/form?id=${shopid}">企业信息</a></li>
            <li><a class="active" href="${ctxsys}/PmShopInfo/shopAdvertise?shopid=${shopid}">门店装修</a></li>
        </ul>
        <div class="main-box">
            <div class="add-fit" id="main">
              <c:forEach items="${layouttypes}" var="layouttype">
                <a href="${ctxsys}/PmShopInfo/advertiselist?shopid=${shopid}&layouttypeId=${layouttype.id}" class="add-list img">
                    <p>${layouttype.moduleTitle}</p>
                    <div class="img-k">
                        <img src="${layouttype.moduleTitleDemoUrl}" alt="">
                    </div>
                </a>
              </c:forEach>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        (function(){
            var imgClassname = 'img';
            var pClassname = 'tip';
            var waterClassname = 'img';
            var imgWidth = 300;
            var parentIdName = 'main'
            var viewHeight = $(window).height();
            var viewWidth = $(window).width();
            var img_obj;
            var swidth,sheight,imgHeight;
            var img;//image objects which be clicked
            var columnHeight;//height of each waterfall column
            $('#img,#img-container').css({
                height: viewHeight,
                width: viewWidth
            });
            $('#img img,#btn-left,#btn-right').on('click',function(event){
                event.stopPropagation();
            })
            window.onload = function()
            {
                waterfall();
            }
            $(window).resize(function(event) {
                viewHeight = $(window).height();
                viewWidth = $(window).width();
                waterfall();
                var showWidth,showHeight;
                if(swidth>viewWidth)
                {
                    showWidth = viewWidth;
                    showHeight =(sheight/swidth)*showWidth;
                } else {
                    showWidth = swidth;
                }
                if(sheight>viewHeight)
                {
                    showHeight = viewHeight;
                    showWidth = (swidth/sheight)*showHeight
                } else {
                    showHeight = sheight;
                }
                $('#img,#img-container').css({
                    height: viewHeight,
                    width: viewWidth
                });
                $(img).stop(true,false).animate({
                    width:showWidth,
                    height:showHeight,
                    left:(parseInt(viewWidth) - parseInt(showWidth))/2,
                    top:(parseInt(viewHeight) - parseInt(showHeight))/2
                });
                $('#tip').stop(true, false).animate({
                    width:showWidth,
                    left:(parseInt(viewWidth) - parseInt(showWidth))/2+3,
                    top:(parseInt(viewHeight) + parseInt(showHeight))/2-32
                });
            });
            $('.'+imgClassname+' img').on('click',function(){

                $('#img').show().css('left', 0);
                $('#img-container').hide();
                getValue($(this));
                showImg($(this)[0]);
            })
            $('#img').on('click',function(){
                hideImg();
            })

            $('#btn-left').on('click',function(){
                preImg();
            })
            $('#btn-right').on('click',function(){
                nextImg();
            })
            function getValue(obj)
            {
                img_obj = obj[0];
                var size = obj.attr('size');
                swidth = size.split('*')[0];
                sheight = size.split('*')[1];
                imgWidth = obj.width();
                imgHeight = obj.height();
            }
            function preImg()
            {
                if($(img_obj).parent('.'+imgClassname).prev('.'+imgClassname))
                {
                    var preObj = $(img_obj).parent('.'+imgClassname).prev('.'+imgClassname).children('img');
                    preNext(preObj)
                }
            }
            function nextImg()
            {
                if($(img_obj).parent('.'+imgClassname).next('.'+imgClassname))
                {
                    //next .img is avaliable
                    var nextObj = $(img_obj).parent('.'+imgClassname).next('.'+imgClassname).children('img');
                    preNext(nextObj)
                }
            }
            function preNext(Obj)
            {
                var text = $(Obj).siblings('.'+pClassname)[0].innerHTML;
                document.getElementById('tip').innerHTML = text;
                //refresh global variable
                getValue(Obj);
                var showWidth,showHeight;
                if(swidth>viewWidth)
                {
                    showWidth = viewWidth;
                    showHeight =(sheight/swidth)*showWidth;
                } else {
                    showWidth = swidth;
                }
                if(sheight>viewHeight)
                {
                    showHeight = viewHeight;
                    showWidth = (swidth/sheight)*showHeight
                } else {
                    showHeight = sheight;
                }
                img.src = Obj[0].src;
                $(img).animate({
                    width:showWidth,
                    height:showHeight,
                    left:(parseInt(viewWidth) - parseInt(showWidth))/2,
                    top:(parseInt(viewHeight) - parseInt(showHeight))/2
                },300);
                $('#tip').animate({
                    width:showWidth,
                    left:(parseInt(viewWidth) - parseInt(showWidth))/2+3,
                    top:(parseInt(viewHeight) + parseInt(showHeight))/2-32
                },300);
            }
            function showImg(obj)
            {
                var poi = getPoi(obj);
                img = $('#img img')[0];
                var text = $(obj).siblings('.'+pClassname)[0].innerHTML;
                document.getElementById('tip').innerHTML = text;
                img.src = obj.src;
                $('#img img').css({
                    'height':imgHeight,
                    'width':imgWidth,
                    'left':poi.left,
                    'top':poi.top
                })
                $('#img-container').fadeIn(300);
                var showWidth,showHeight;
                if(swidth>viewWidth)
                {
                    showWidth = viewWidth;
                    showHeight =(sheight/swidth)*showWidth;
                } else {
                    showWidth = swidth;
                }
                if(sheight>viewHeight)
                {
                    showHeight = viewHeight;
                    showWidth = (swidth/sheight)*showHeight
                } else {
                    showHeight = sheight;
                }
                $(img).animate({
                    width:showWidth,
                    height:showHeight,
                    left:(parseInt(viewWidth) - parseInt(showWidth))/2,
                    top:(parseInt(viewHeight) - parseInt(showHeight))/2
                },300,function(){
                    $('#tip').css({
                        width:showWidth,
                        left:(parseInt(viewWidth) - parseInt(showWidth))/2+3,
                        top:(parseInt(viewHeight) + parseInt(showHeight))/2-32
                    });
                    console.log('end');
                    $('#tip').fadeIn(200);
                })
            }
            function hideImg()
            {
                var poi = getPoi(img_obj);
                var img = $('#img img')[0];
                $(img).stop(true, false).animate({
                    'height':imgHeight,
                    'width':imgWidth,
                    left:poi.left,
                    top:poi.top
                },300,function(){
                    $("#img").hide();
                })
                $('#img-container').fadeOut(300);
                $('#tip').hide();
            }
            function getPoi(obj)
            {
                var left = 0;
                var top = 0;
                var poi;
                while(obj&&obj!='#document')
                {
                    left += obj.offsetLeft;
                    top += obj.offsetTop;
                    obj = obj.offsetParent;
                }
                var scrolltop = $('body').scrollTop();
                var scrollleft = $('body').scrollLeft();
                return {
                    left:parseInt(left) - parseInt(scrollleft),
                    top:parseInt(top) - parseInt(scrolltop)
                }
            }
            function waterfall()
            {
                var marginleft = 10,margintop = 10;
                columnHeight = [];
                var columnNum = Math.floor(($('#'+parentIdName).width())/($('.img').width()));
                //initialize columnHeight
                for( var i=0; i<columnNum; i++)
                {
                    columnHeight[i] = 0;
                }
                var imgTotle = $('.'+waterClassname).length;
                for( var imgNow = 0;imgNow<imgTotle; imgNow++)
                {
                    var columnIndex = watermin();
                    if($('.'+waterClassname).eq(imgNow))
                    {
                        $('.'+waterClassname).eq(imgNow).delay(300).stop(true, false).animate({
                            left: columnIndex*(imgWidth+marginleft),//take care of the initialize of imgWidth
                            top: columnHeight[columnIndex]+margintop
                        },500);
                        columnHeight[columnIndex] += ($('.'+waterClassname).eq(imgNow).height() + margintop);
                    }
                }
            }
            function watermin()
            {
                var length = columnHeight.length;
                var tmp=[];
                tmp[0] = columnHeight[0];
                tmp[1] = 0;
                for(var i=1; i<length;i++)
                {
                    if(columnHeight[i]<tmp[0])
                    {
                        tmp[0] = columnHeight[i];
                        tmp[1] = i;
                    }
                }
                return tmp[1];
            }
        }())
    </script>
</body>
</html>