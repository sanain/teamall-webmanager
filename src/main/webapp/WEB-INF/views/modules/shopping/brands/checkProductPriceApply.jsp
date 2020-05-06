<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>申请审核</title>
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/commodity-overview.css">
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/MxSlider.css">
    <script src="${ctxStatic}/commodity/js/jquery.min.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.js"></script>
    <script src="${ctxStatic}/commodity/js/MxSlider.js"></script>
    <script src="${ctxStatic}/commodity/js/base_form.js"></script>
    <script src="${ctxStatic}/commodity/js/commodity-overview.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <style type="text/css">
        .update-btn{
            display: inline-block;
            margin-left: 20px;
            width: 55px;
            height: 25px;
            padding: 4px 15px;
            font-size: 14px;
            color: #fff;
            margin-bottom:2px;
            background-color: #393D49;
            border-color: #393D49;
        }
        .update-btn:hover{
            background-color: #393D49;
            color: rgb(120,120,120);
        }
        li .update-b{
            width: auto;
        }
        .form-group label{
            height: 32px;
            line-height: 32px;
            text-align: right;
        }


    </style>
    <script type="text/javascript">
        $(function(){
            //截取图片
            var imgs="${apply.productPic}";
            var img=imgs.split("|");
            var htmls="";
            for (var i=0;i<img.length;i++){
                htmls+="<div><img class='mx-slide-img' src='"+img[i]+"'  alt=''></div>";
            }
            $(".mySlider").html(htmls);
            var html2="";
            html2+="<li><span>品牌：</span><b>"+"${ebProduct.brandName == null || "".equals(ebProduct.brandName) ? '无':ebProduct.brandName}"+"</b></li>";
            var pmProductPropertyStandards="${pmProductPropertyStandard.propertyStandardValueStr}";
            var pmProductPropertyStandardsv=pmProductPropertyStandards.split(";");
            for (var i=0;i<pmProductPropertyStandardsv.length;i++){
                var val = pmProductPropertyStandardsv[i].split(":")[1];
                if(pmProductPropertyStandardsv[i]!=null&&pmProductPropertyStandardsv[i]!=undefined&&pmProductPropertyStandardsv[i]!=''){
                    html2+="<li><span>"+pmProductPropertyStandardsv[i].split(":")[0]+"：</span><b>"+(val == undefined || val=="null" ||val=="" ? "无" : val)+"</b></li>";
                }
            }
            $("#towef").html(html2);
            $('.num').cbNum();
            var myDiv = document.getElementsByClassName("mx-slide-img")[0];
            var computedStyle = document.defaultView.getComputedStyle(myDiv, null);
            var hhee=computedStyle.height;

            $('.mySlider').MxSlider({
                autoPlay: false,
                nav:  true     ,     //是否显示前后导航箭头，默认为true。
                dots:false  ,       //是否显示前后圆点导航按钮，默认为false。
                timeSlide:600    ,//动画的速度，默认为100毫秒。
                autoPlaySpeed:0   //自动播放的速度，默认为5000毫秒。
            });
            $('.mySlider').css('height',$('.mySlider>div').height());
            console.log($('.mx-slide').length)
            $('.mySlider-num b').text($('.mx-slide').length);
            $('.mx-prev').click(function(){
                var anum= parseInt($('.mySlider-num span').text());
                anum--;
                if(anum==0){
                    anum=$('.mx-slide').length;
                }
                $('.mySlider-num span').text(anum)
            });
            $('.mx-next').click(function(){
                var anum= parseInt($('.mySlider-num span').text());
                anum++;
                if(anum>$('.mx-slide').length){
                    anum=1;
                }
                $('.mySlider-num span').text(anum)
            });
            console.log(hhee);
            // $('.mySlider').css('min-height',computedStyle.width);
            // $('.mx-slide').css('min-height',computedStyle.width);
            $('.mySlider').css('min-height','340px');
        });
    </script>
    <style>
        .mySlider-bottom{clear:both;}
        .mySlider-bottom p{margin-bottom:0;}
    </style>
</head>
<body>
<div class="c-context">
    <ul class="nav-ul">
        <li><a class="active" href="${ctxsys}/productPriceChargingApply/toCheckApply?applyId=${apply.id}">价格申请</a></li>
    </ul>
    <!--商品预览-->
    <div class="context-box">
        <div class="overview-left">
            <div class="mySlider">
                <div>
                    <img src="${ctxStatic}/commodity/images/slider-bg1.png" alt="">
                </div>
                <div>
                    <img src="${ctxStatic}/commodity/images/slider-bg1.png" alt="">
                </div>
                <div>
                    <img src="${ctxStatic}/commodity/images/slider-bg1.png" alt="">
                </div>

            </div>
            <div class="form-group" style="z-index: 1;">
                <label for="name" >申请理由</label>
                <textarea readonly="readonly" class="form-control" rows="5" onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0, 200)">${apply.applyRemark}</textarea>
            </div>
            <%--<div class="mySlider-num">--%>
            <%--<span>1</span>/<b>3</b>--%>
            <%--</div>--%>
            <%--<div class="mySlider-bottom">--%>
            <%--${ebProduct.productHtml}--%>
            <%--</div>--%>


        </div>
        <div class="overview-right">
            <div class="overview-right-box">
                <ul class="right-box1">
                    <li>
                        <span>门店名称：</span>
                        <b>${apply.shopName}</b>
                    </li>

                    <li>
                        <span>平台分类：</span>
                        <b>${apply.productTypeStr}</b>
                    </li>


                    <li>
                        <span>商品名称：</span>
                        <b>${apply.productName}</b>
                    </li>

                    <li>
                        <span>销售价：</span>
                        <b class="update-b"><span>¥</span>
                            <span id="oldSellPrice">${apply.productSellPrice}</span>
                            <c:if test="${apply.isMoreDetail == 0}">
                                <span style="color: red;">------></span>
                                <span id="oldSellPrice">${apply.newPrice}</span>
                            </c:if>
                        </b>
                    </li>
                    <li>
                        <span>会员价格：</span>
                        <b class="update-b"><span>¥</span>
                            <span id="oldMemberPrice">${apply.productMemberPrice}</span>
                            <c:if test="${apply.isMoreDetail == 0}">
                                <span style="color: red;">------></span>
                                <span id="oldMemberPrice">${apply.newMemberPrice}</span>
                            </c:if>
                        </b>
                    </li>
                </ul>



                <c:if test="${apply.isMoreDetail == 1}">
                    <div class="right-box2">
                        <ul class="list-top">
                            <li>规格</li>
                            <li>销售价(元)</li>
                            <li>新的销售价(元)</li>
                            <li>会员价(元)</li>
                            <li>新会员价(元)</li>
                        </ul>
                        <div class="list-body">
                            <c:forEach items="${itemList}" var="item" varStatus="status">
                                <ul class="detail-ul">
                                    <li class="detail-content">${item.applyContent}</li>
                                    <li class="detail-old-price">${item.oldPrice}</li>
                                    <li class="detail-new-price">${item.newPrice}</li>
                                    <li class="detail-old-member-price">${item.oldMemberPrice}</li>
                                    <li class="detail-new-member-price">${item.newMemberPrice}</li>
                                    <input type="hidden" value="${item.id}" class="detail-id">
                                </ul>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                <div class="right-box2">
                    <c:if test="${remarkList != null && remarkList.size() > 0}">
                    <c:forEach var="remark" items="${remarkList}" varStatus="status">
                        <div class="form-group" style="z-index: 1;">
                            <label for="name" >回复${status.index+1}</label>
                            <textarea  readonly="readonly" class="form-control" rows="5" onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0, 200)">${remark.remark}</textarea>
                        </div>
                    </c:forEach>
                    </c:if>

                    <c:if test="${apply.isApply == 0}">
                        <div class="form-group" style="z-index: 1;">
                            <label for="name" >回复</label>
                            <textarea  class="form-control" rows="5" id="apply-remark" onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0, 200)"></textarea>
                        </div>
                    </c:if>
                </div>


                <c:if test="${apply.isApply == 0}">
                    <div class="right-box2" style="margin-top: 50px">
                        <ul class="list-body">
                            <li><a href="javascript:;" style="background-color: #69AC72;border:1px solid #69AC72" onclick="checkApply(1)"  class="btn btn-primary">通过</a></li>
                            <li><a href="javascript:;" style="background-color: #69AC72;border:1px solid #69AC72" onclick="checkApply(2)" class="btn btn-primary">拒绝</a></li>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <form style="display: none" id="check-apply-form" method="post">
        <input type="hidden" name="id" id="apply-id" value="${apply.id}">
        <input type="hidden" name="applyStatus" id="apply-status">
        <textarea name="remark" id="remark"></textarea>
    </form>
</div>

<script type="text/javascript">
    $(function(){
        if('${prompt}'!=""){
            layer.confirm('${prompt}')
        }
    })
    function checkApply(status){
        var prompt;
        var path="${ctxsys}/productPriceApply/checkApply";
        if(status == 1){
            prompt="确定通过该申请";
        }else{
            prompt="确定拒绝该申请";
        }

        layer.confirm(prompt,function(){
            $("#apply-status").val(status);
            if($("#apply-remark").val() != undefined && $("#apply-remark").val() != ""){
                $("#remark").val($("#apply-remark").val());
            }

            $("#check-apply-form").attr("action",path);
            $("#check-apply-form").submit();
        })
    }
</script>
</body>
</html>