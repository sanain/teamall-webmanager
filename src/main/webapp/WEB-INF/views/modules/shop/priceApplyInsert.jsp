<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品价格申请</title>
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
            var imgs="${apply.prdouctPic}";
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
         #searchForm,#inputForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-horizontal{margin:0;}
       .breadcrumb{background:#fff;padding:0;}
    </style>
</head>
<body>
<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>商品管理 - </span><span style="color:#009688;">商品价格申请</span>
</div>
<div class="c-context">
     <ul class="nav nav-tabs">
        <li><a class="active" href="${ctxweb}/shop/ebProductPriceApply/toPriceApplyInsert?productId=${ebProduct.productId}">价格申请</a></li>
    </ul>
    <!--商品预览-->
    <div class="context-box">
        <div class="overview-left">
            <div class="mySlider">
                <div>
                    <img src="${ctxStatic}/commodity/images/slider-bg1.png" alt="" >
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
                <textarea class="form-control" rows="5" id="remark" onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0, 200)"></textarea>
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
                        <span>平台分类：</span>
                        <b>${productType.productTypeStr}</b>
                    </li>
                    <c:if test="${not empty pmShopProductType}">
                        <li>
                            <span>门店分类：</span>
                            <b>${pmShopProductType.productTypeNameStr}</b>
                        </li>
                    </c:if>
                    <li>
                        <span>商品名称：</span>
                        <b>${ebProduct.productName}</b>
                    </li>
                    <li style="display: none">
                        <span>市场价格：</span>
                        <b>¥${ebProduct.marketPrice}</b>
                    </li>
                    <li>
                        <span>本店价格：</span>
                        <b class="update-b"><span>¥</span>
                            <span id="oldSellPrice">${isMoreStandar ? ebShopProduct.sellPriceRange : ebShopProduct.sellPrice}</span>
                            <c:if test="${!isMoreStandar}">
                                <span style="color: red">------></span>
                                <input type="number" style="width: 50px" id="newPrice" value="${isMoreStandar ? ebShopProduct.sellPriceRange : ebShopProduct.sellPrice}"/>
                            </c:if>
                        </b>
                    </li>
                    <li>
                        <span>会员价格：</span>
                        <b  class="oldMemberPrice  update-b"><span>¥</span><span id="memberPrice">
                            <span id="oldMemberPrice">
                                ${isMoreStandar ? ebShopProduct.memberPriceRange : ebShopProduct.memberPrice}
                            </span>
                            <c:if test="${!isMoreStandar}">
                                <span style="color: red">------></span>
                                <input type="number" style="width: 50px" id="newMemberPrice" value="${isMoreStandar ? ebShopProduct.memberPriceRange : ebShopProduct.memberPrice}"/>
                            </c:if>
                        </span></b>
                    </li>
                    <li>
                        <span>成本价：</span>
                        <b  class="update-b"><span>¥</span><span id="oldCost">${ebShopProduct.cost == null ? 0 : ebShopProduct.cost}</span></b>
                    </li>
                </ul>

                <c:if test="${isMoreStandar}">
                    <div class="right-box2">
                        <ul class="list-top">
                            <li>规格</li>
                            <li>销售价(元)</li>
                            <li>新的销售价(元)</li>
                            <li>会员价(元)</li>
                            <li>新的会员价(元)</li>
                        </ul>
                        <div class="list-body">
                            <c:forEach items="${detailList}" var="detail" varStatus="status">
                                <ul class="detail-ul">
                                    <li class="detail-content">${detail.standardValueStr}</li>
                                    <li class="detail-old-price">${detail.ebShopProductStandardDetail.detailPrices}</li>
                                    <li>
                                        <input type="number" style="width: 50px;height: 30px" class="detail-new-price" value="${detail.ebShopProductStandardDetail.detailPrices}">
                                    </li>
                                    <li class="detail-old-member-price">${detail.ebShopProductStandardDetail.memberPrice}</li>
                                    <li>
                                        <input type="number" style="width: 50px;height: 30px" class="detail-new-member-price" value="${detail.ebShopProductStandardDetail.memberPrice}">
                                    </li>
                                    <input type="hidden" value="${detail.id}" class="detail-id">
                                </ul>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <div class="right-box2" style="margin-top: 50px">
                    <ul class="list-body">
                        <li><a href="javascript:;" style="background: #393D49" class="btn btn-primary"
                               <c:if test="${isMoreStandar}">
                                    onclick="submitDetailApply()"
                               </c:if>

                                <c:if test="${!isMoreStandar}">
                                    onclick="submitPriceApply()"
                                </c:if>
                        >提交</a></li>
                        <li><a href="javascript:history.go(-1)"  style="background: #393D49" class="btn btn-primary">返回</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    $(function(){
        if('${isChange}'=='0'){
            $(input).attr("readonly","readonly");
            $(textarea).attr("readonly","readonly");
        }
    })

    //提交单规格的商品
    function  submitPriceApply(){
        var oldSellPrice = $("#oldSellPrice").text().trim();
        var oldMemberPrice = $("#oldMemberPrice").text().trim();
        var newPrice = $("#newPrice").val().trim();
        var newMemberPrice = $("#newMemberPrice").val().trim();

        if(oldSellPrice == newPrice && oldMemberPrice == newMemberPrice){
            layer.msg("新价格不能和原价格相同！");
            return ;
        }

        var newPriceSubmitArr = new Array(); //应该提交的规格的新价格
        newPriceSubmitArr.push(newPrice);
        var newMemberPriceSubmitArr = new Array(); //应该提交的规格的新价格
        newMemberPriceSubmitArr.push(newMemberPrice);

        $.ajax({
            //提交数据的类型 POST GET
            type:"POST",
            //提交的网址
            url:"${ctxweb}/shop/ebProductPriceApply/insertPriceApply",

            //提交的数据
            data:{
                "newPriceArr":newPriceSubmitArr,
                "newMemberPriceArr":newMemberPriceSubmitArr,
                "applyRemark":$("#remark").val(),
                "productId":"${ebProduct.productId}",
                "productSellPrice":$("#oldSellPrice").text(),
                "productMemberPrice":$("#oldMemberPrice").text(),
                "isMoreDetail":${isMoreStandar?"1":"0"},
                "productTypeStr":"${productType.productTypeStr}"
            },
            //返回数据的格式
            datatype: "json",
            traditional:true,
            //成功返回之后调用的函数
            success:function(data){
                if(data.code=="1"){
                    layer.msg("提交申请成功！")
                    window.location.href="${ctxweb}/shop/ebProductPriceApply/applyList"
                }else{
                    layer.msg("提交申请失败！");
                }

            },error: function(){
                layer.msg("提交申请失败！");
            }
        });
    }


    //提交多规格的商品
    function submitDetailApply(){
        var oldPriceArr=$(".detail-old-price"); //所有的老价格
        var newPriceArr=$(".detail-new-price");    //所有的新价格
        var oldMemberPriceArr=$(".detail-old-member-price"); //所有的老会员价格
        var newMemberPriceArr=$(".detail-new-member-price");    //所有的新会员价格
        var detailIdArr=$(".detail-id");   //所有的规格id
        var detailContentArr=$(".detail-content");   //所有的规格id

        var oldPriceSubmitArr = new Array(); //应该提交的规格的旧价格
        var newPriceSubmitArr = new Array(); //应该提交的规格的新价格
        var oldMemberPriceSubmitArr = new Array(); //应该提交的规格的旧会员价格
        var newMemberPriceSubmitArr = new Array(); //应该提交的规格的新会员价格
        var detailIdSubmitArr = new Array(); //应该提交的规格的id
        var detailContentSubmitArr = new Array(); //应该提交的规格内容

        for(var i = 0 ; i < oldPriceArr.length ; i++){
            if($(newPriceArr[i]).val().trim()==undefined || $(newPriceArr[i]).val().trim() == ""){
                layer.msg("有数据为空！");
                $(newPriceArr[i]).css("border","1px solid red")
                return;
            }

            if($(newMemberPriceArr[i]).val().trim()==undefined || $(newMemberPriceArr[i]).val().trim() == ""){
                layer.msg("有数据为空！");
                $(newMemberPriceArr[i]).css("border","1px solid red")
                return;
            }

            var oldPrice = parseFloat($(oldPriceArr[i]).text().trim());
            var newPrice = parseFloat( $(newPriceArr[i]).val().trim());
            var oldMemberPrice = parseFloat($(oldMemberPriceArr[i]).text().trim());
            var newMemberPrice = parseFloat( $(newMemberPriceArr[i]).val().trim());
            if(oldPrice != newPrice || oldMemberPrice != newMemberPrice){
                oldPriceSubmitArr.push(oldPrice)
                newPriceSubmitArr.push(newPrice)
                oldMemberPriceSubmitArr.push(oldMemberPrice)
                newMemberPriceSubmitArr.push(newMemberPrice)
                detailIdSubmitArr.push($(detailIdArr[i]).val().trim())
                detailContentSubmitArr.push($(detailContentArr[i]).text().trim())
            }
        }

        if(detailIdSubmitArr.length == 0){
            layer.msg("请至少修改一种规格的价格！");
            return;
        }

        $.ajax({
            //提交数据的类型 POST GET
            type:"POST",
            //提交的网址
            url:"${ctxweb}/shop/ebProductPriceApply/insertPriceApply",
            //提交的数据
            data:{
                "detailIdArr":detailIdSubmitArr,
                "newPriceArr":newPriceSubmitArr,
                "oldPriceArr":oldPriceSubmitArr,
                "newMemberPriceArr":newMemberPriceSubmitArr,
                "oldMemberPriceArr":oldMemberPriceSubmitArr,
                "applyRemark":$("#remark").val(),
                "applyContent":detailContentSubmitArr,
                "productId":"${ebProduct.productId}",
                "productSellPrice":$("#oldSellPrice").text(),
                "productMemberPrice":$("#oldMemberPrice").text(),
                "isMoreDetail":${isMoreStandar?"1":"0"},
                "productTypeStr":"${productType.productTypeStr}"
            },
            //返回数据的格式
            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
            traditional:true,
            //成功返回之后调用的函数
            success:function(data){
                if(data.code=="1"){
                    layer.msg("提交申请成功！")
                    window.location.href="${ctxweb}/shop/ebProductPriceApply/applyList"
                }else{
                    layer.msg("提交申请失败！");
                }
            },error: function(){
                layer.msg("提交申请失败！");
            }
        });

    }



</script>
</body>
</html>