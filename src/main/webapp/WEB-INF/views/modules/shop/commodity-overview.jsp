<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品概览</title>
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/commodity-overview.css">
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/MxSlider.css">
    <script src="${ctxStatic}/commodity/js/jquery.min.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.js"></script>
    <script src="${ctxStatic}/commodity/js/MxSlider.js"></script>
    <script src="${ctxStatic}/commodity/js/base_form.js"></script>
    <script src="${ctxStatic}/commodity/js/commodity-overview.js"></script>
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
            var imgs="${ebProduct.prdouctImg}";
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
            $('.mySlider').css('min-height',computedStyle.width);
            $('.mx-slide').css('min-height',computedStyle.width);
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
        <li><a class="active" href="${ctxweb}/shop/ebproductshop/show?productId=${ebProduct.productId}">商品概览</a></li>
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
            <div class="mySlider-num">
                <span>1</span>/<b>3</b>
            </div>
            <div class="mySlider-bottom">
                ${ebProduct.productHtml}
            </div>


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
                        <b class="update-b"><span>¥</span><span id="oldSellPrice">${isMoreStandar ? ebShopProduct.sellPriceRange : ebShopProduct.sellPrice}</span></b>
                        <%--<c:if test="${!isMoreStandar}">--%>
                        <%--<button onclick="opendUpdatePriceModel()" class="btn btn-primary btn-lg update-btn">--%>
                        <%--修改--%>
                        <%--</button>--%>
                        <%--</c:if>--%>
                    </li>
                    <li>
                        <span>会员价格：</span>
                        <b  class="oldMemberPrice  update-b"><span>¥</span><span id="oldMemberPrice">${isMoreStandar ? ebShopProduct.memberPriceRange : ebShopProduct.memberPrice}</span></b>
                        <%--<c:if test="${!isMoreStandar}">--%>
                        <%--<button onclick="opendUpdatePriceModel()" class="btn btn-primary btn-lg update-btn">--%>
                        <%--修改--%>
                        <%--</button>--%>
                        <%--</c:if>--%>
                    </li>
                    <li style="display: none">
                        <span>结算价格：</span>
                        <b ><span>¥</span>${ebProduct.costPrice}</b>
                    </li>
                    <li>
                        <span>成本价：</span>
                        <b  class="update-b"><span>¥</span><span id="oldCost">${ebShopProduct.cost == null ? 0 : ebShopProduct.cost}</span></b>
                        <c:if test="${!isMoreStandar}">
                            <button onclick="opendUpdatePriceModel()" class="btn btn-primary btn-lg update-btn">
                                修改
                            </button>
                        </c:if>
                    </li>
                    <c:if test="${fns:isShowWeight()}">
                        <li>
                            <span>计量单位：</span>
                            <b style="width: auto">
                                    ${ebShopProduct.measuringType ==  null|| ebShopProduct.measuringType == 1 ? "件":"重量"}
                            </b>
                        </li>
                    </c:if>
                    <li>
                        <span>库存数量：</span>
                        <b  id="oldStoreNums" class="update-b">${fns:replaceStoreNum(ebShopProduct.measuringType,ebShopProduct.measuringUnit,ebShopProduct.storeNums)}</b>
                        <c:if test="${fns:isShowWeight()}">
                            <b style="width: auto">
                                <c:if test="${ebShopProduct.measuringType == 2 &&  ebShopProduct.measuringUnit==1 }">
                                    公斤
                                </c:if>
                                <c:if test="${ebShopProduct.measuringType == 2 &&  ebShopProduct.measuringUnit==2 }">
                                    克
                                </c:if>
                                <c:if test="${ebShopProduct.measuringType == 2 &&  ebShopProduct.measuringUnit==3 }">
                                    斤
                                </c:if>
                            </b>
                        </c:if>
                        <c:if test="${!isMoreStandar}">
                            <button onclick="opendUpdatePriceModel()" class="btn btn-primary btn-lg update-btn">
                                修改
                            </button>
                        </c:if>
                    </li>
                    <li style="display: none">
                        <span>商品编码：</span>
                        <b>${ebProduct.productNo}</b>
                    </li>
                    <li>
                        <span>商品条形码：</span>
                        <b>${ebProduct.barCode}</b>
                    </li>
                    <li style="display: none">
                        <span>所在地：</span>
                        <b>${ebProduct.countryName}>${ebProduct.provincesName}>${ebProduct.municipalName}</b>
                    </li>
                </ul>
                <ul class="right-box1" id="towef">
                    <li>
                        <span>品牌：</span>
                        <b>${ebProduct.brandName == null || "".equals(ebProduct.brandName) ? '无':ebProduct.brandName}</b>
                    </li>

                    <li>
                        <span>原产地：</span>
                        <b>美国</b>
                    </li>
                    <li>
                        <span>适用季节：</span>
                        <b>春季，夏季</b>
                    </li>
                    <li>
                        <span>包装单位：</span>
                        <b>盒装</b>
                    </li>
                    <li>
                        <span>包装单位：</span>
                        <b>盒装</b>
                    </li>
                </ul>
                <ul class="right-box1" style="display:none">
                    <li>
                        <span>运费设置：</span>
                        <b><c:if test="${ebProduct.freightType==1}">卖家承担运费</c:if><c:if test="${ebProduct.freightType==2}">买家承担运费</c:if></b>
                    </li>
                    <c:if test="${ebProduct.freightType==2}">
                        <c:if test="${ebProduct.userFreightTemp==1}">
                            <li>
                                <span>运费模板：</span>
                                <b>${pmShopFreightTem.templateName}</b>
                            </li>
                        </c:if>
                        <c:if test="${ebProduct.userFreightTemp==0}">
                            <li>
                                <span>运费模板：</span>
                                <b>${ebProduct.courier}</b>
                            </li>
                        </c:if>
                    </c:if>
                </ul>

                <!-- 修改价格的模态框（Modal） -->
                <div class="modal fade" id="updatePriceModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title">
                                    <%--修改价格和库存--%>
                                    库存
                                </h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <%--<div class="form-group row">--%>
                                    <%--<label for="sellPrice" class="col-sm-2 col-form-label" style="width: 15%">销售价</label>--%>
                                    <%--<div class="col-sm-10">--%>
                                    <%--<input type="number" class="form-control-plaintext form-control" id="sellPrice" placeholder="请输入销售价">--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="form-group row">--%>
                                    <%--<label for="memberPrice" style="width: 15%" class="col-sm-2 col-form-label">会员价</label>--%>
                                    <%--<div class="col-sm-10">--%>
                                    <%--<input type="number" class="form-control-plaintext  form-control" id="memberPrice" placeholder="请输入会员价">--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <div class="form-group row">
                                        <label for="storeNums" style="width: 15%" class="col-sm-2 col-form-label">成本价</label>
                                        <div class="col-sm-10">
                                            <input type="number" class="form-control-plaintext form-control" id="cost" placeholder="请输入成本价">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="storeNums" style="width: 15%" class="col-sm-2 col-form-label">库存</label>
                                        <div class="col-sm-10">
                                            <input type="number" class="form-control-plaintext form-control" id="storeNums" placeholder="请输入库存">
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" onclick="submitUpdatePrice()" class="btn btn-primary">
                                    提交
                                </button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                                </button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>

                <!-- 修改多规格的模态框（Modal） -->
                <div class="modal fade" id="updateStandardDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title">
                                    多规格修改
                                </h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <%--<div class="form-group row">--%>
                                    <%----%>
                                    <%--<label for="sellPrice" class="col-sm-2 col-form-label" style="width: 15%">销售价</label>--%>
                                    <%--<div class="col-sm-10">--%>
                                    <%--<input type="number" class="form-control-plaintext form-control" id="detailSellPrice" placeholder="请输入销售价">--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="form-group row">--%>
                                    <%--<label for="memberPrice" style="width: 15%" class="col-sm-2 col-form-label">会员价</label>--%>
                                    <%--<div class="col-sm-10">--%>
                                    <%--<input type="number" class="form-control-plaintext  form-control" id="detailMemberPrice" placeholder="请输入会员价">--%>
                                    <%--</div>--%>
                                    <%--</div>--%>

                                    <div class="form-group row">
                                        <label for="storeNums" style="width: 15%" class="col-sm-2 col-form-label">成本价</label>
                                        <div class="col-sm-10">
                                            <input type="number" class="form-control-plaintext form-control" id="detailCost" placeholder="请输入成本价">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="storeNums" style="width: 15%" class="col-sm-2 col-form-label">库存</label>
                                        <div class="col-sm-10">
                                            <input type="number" class="form-control-plaintext form-control" id="detailStoreNums" placeholder="请输入销售价">
                                        </div>
                                    </div>

                                    <input type="hidden" id="detailId">
                                    <input type="hidden" id="productShopId">
                                    <input type="hidden" id="productStandardId">
                                    <input type="hidden" id="productId">
                                    <input type="hidden" id="shopId">

                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                                </button>
                                <button type="button" onclick="submitUpdateDetail()" class="btn btn-primary">
                                    提交
                                </button>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal -->
                </div>


                <c:if test="${isMoreStandar}">
                    <div class="right-box2">
                        <ul class="list-top">
                            <li>规格</li>
                            <li style="display: none">市场价格(元)</li>
                            <li>本店价格(元)</li>
                            <li style="display: none">折扣比例(%)</li>
                            <li style="display: none">结算价格(元)</li>
                            <li>会员价格(元)</li>
                            <li>成本价(元)</li>
                            <li>库存数量</li>
                            <li>操作</li>
                        </ul>
                        <div class="list-body">
                            <c:forEach items="${detailList}" var="detail" varStatus="status">
                                <ul class="detail-ul">

                                    <li>${detail.standardValueStr}</li>
                                    <li>${detail.ebShopProductStandardDetail.detailPrices}</li>
                                    <li>${detail.ebShopProductStandardDetail.memberPrice}</li>
                                    <li>${detail.ebShopProductStandardDetail.cost == null ? 0 :detail.ebShopProductStandardDetail.cost}</li>
                                    <li>${detail.ebShopProductStandardDetail.detailInventory}</li>
                                    <li><a href="javascript:;" style="background:#393D49;border:1px solid #393D49; height: 20px;width: 50%;font-size: 12px;margin-right: 5px;padding: 2px 7px" class="btn btn-primary" onclick="opendUpdateStandardDetailModel(this)">修改</a>  </li>
                                    <input type="hidden" value="${detail.ebShopProductStandardDetail.id}" class="detailId">
                                    <input type="hidden" value="${detail.ebShopProductStandardDetail.productId}" class="productId">
                                    <input type="hidden" value="${detail.ebShopProductStandardDetail.shopId}" class="shopId">
                                    <input type="hidden" value="${ebShopProduct.id}" class="productShopId">
                                    <input type="hidden" value="${detail.id}" class="productStandardId">
                                </ul>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <div class="right-box2">
                    <ul class="list-body">
                        <li><a style="background-color: #393D49; border-color: #393D49;" href="${ctxweb}/shop/ebProductPriceApply/toPriceApplyInsert?productId=${ebProduct.productId}" class="btn btn-primary">价格申请</a> </li>

                    </ul>

                </div>

                <c:if test="${chargingList != null && chargingList.size() > 0}">
                    <div class="right-box2" style="margin-top: 50px">
                        <ul class="list-top">
                            <li>加料名称</li>
                            <li>标签名</li>
                            <li>价格</li>
                        </ul>
                        <div class="list-body">
                            <c:forEach items="${chargingList}" var="charging" >
                                <ul class="detail-ul">

                                    <li>${charging.cName}</li>
                                    <li>${charging.lable}</li>
                                    <li>${charging.sellPrice}</li>
                                </ul>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    //打开修改价格模态框
    function opendUpdatePriceModel(){
        $("#updatePriceModel").modal('show');
        $("#storeNums").val($("#oldStoreNums").text());
        $("#cost").val($("#oldCost").text());
        // $("#memberPrice").val($("#oldMemberPrice").text());
        // $("#sellPrice").val($("#oldSellPrice").text());
    }

    //提交价格和库存
    function submitUpdatePrice(){
        // 非法浮点型
        var reg = /^\d+(\.\d+)?$/;
        var reg2 = /^\d+$/;

        // var valueArr = [$("#sellPrice").val(), $("#memberPrice").val(),$("#storeNums").val()];
        var valueArr = [$("#cost").val(),$("#storeNums").val()];
        // var nullPromptArr = ["销售价不能为空" , "会员价不能为空" , "库存不能为空"];
        // var formatPromptArr = ["销售价必须为数字" , "会员价必须为数字" , "库存必须为整数"];
        var nullPromptArr = ["成本价不能为空","库存不能为空"];
        var formatPromptArr = ["成本价必须为数字","成本价必须为数字"];

        for(var i = 0 ; i < valueArr.length ; i++){
            if(valueArr[i] == undefined || valueArr[i] == ""){
                alert(nullPromptArr[i]);
                return false;
            }

                if(!reg.test(valueArr[i])){
                    alert(formatPromptArr[i]);
                    return false;
                }

        }

        $.ajax({
            //提交数据的类型 POST GET
            type:"POST",
            //提交的网址
            url:"${ctxweb}/shop/ebproductshop/updatePriceAndStoreNums",
            //提交的数据
            data:{
                "productId":${ebShopProduct.productId},
                "id":${ebShopProduct.id},
                "cost":$("#cost").val(),
                // "sellPrice":$("#sellPrice").val(),
                // "memberPrice":$("#memberPrice").val(),
                "newStoreNums":$("#storeNums").val()
            },
            //返回数据的格式
            dataType: "json",//"xml", "html", "script", "json", "jsonp", "text".
            //成功返回之后调用的函数
            success:function(data){
                alert(data.msg)
                if(data.code=="1"){
                    $("#oldStoreNums").text($("#storeNums").val());
                    $("#oldCost").text($("#cost").val());
                    // $("#oldMemberPrice").text($("#memberPrice").val());
                    // $("#oldSellPrice").text($("#sellPrice").val());
                }

                $("#updatePriceModel").modal('hide');
            },error: function(){
                alert("修改失败！");
                $("#updatePriceModel").modal('hide');
            }
        });
    }

    var detailSellPrice;
    var detailMemberPrice;
    var detailStoreNums;
    var detailCost;
    //打开修改多规格的模态框
    function  opendUpdateStandardDetailModel(clickElement){

        $("#updateStandardDetail").modal("show");
        var  detailUl = $(clickElement).parent().parent();
        // detailSellPrice = detailUl.find("li").eq(1);
        // detailMemberPrice = detailUl.find("li").eq(2);
        detailCost = detailUl.find("li").eq(3);
        detailStoreNums = detailUl.find("li").eq(4);
        var detailId = detailUl.find(".detailId");
        var productShopId = detailUl.find(".productShopId");
        var productStandardId = detailUl.find(".productStandardId");
        var shopId = detailUl.find(".shopId");
        var productId = detailUl.find(".productId");

        // $("#detailSellPrice").val(detailSellPrice.text().trim());
        // $("#detailMemberPrice").val(detailMemberPrice.text().trim());
        $("#detailCost").val(detailCost.text().trim());
        $("#detailStoreNums").val(detailStoreNums.text().trim());
        $("#detailId").val(detailId.val());
        $("#productShopId").val(productShopId.val());
        $("#productStandardId").val(productStandardId.val());
        $("#shopId").val(shopId.val());
        $("#productId").val(productId.val());
    }

    //提交修改多规格
    function submitUpdateDetail(){
        // 非法浮点型
        var reg = /^\d+(\.\d+)?$/;
        var reg2 = /^\d+$/;

        // var valueArr = [$("#detailSellPrice").val(), $("#detailMemberPrice").val(),$("#detailStoreNums").val()];
        var valueArr = [$("#detailCost").val(),$("#detailStoreNums").val()];
        // var nullPromptArr = ["销售价不能为空" , "会员价不能为空" , "库存不能为空"];
        var nullPromptArr = ["成本价不能为空","库存不能为空"];
        // var formatPromptArr = ["销售价必须为数字" , "会员价必须为数字" , "库存必须为整数"];
        var formatPromptArr = ["成本价必须为整数","库存必须为整数"];

        for(var i = 0 ; i < valueArr.length ; i++){
            if(valueArr[i] == undefined || valueArr[i] == ""){
                alert(nullPromptArr[i]);
                return false;
            }

            if(i == valueArr.length-1){
                if(!reg2.test(valueArr[i])){
                    alert(formatPromptArr[i]);
                    return false;
                }
            }else{
                if(!reg.test(valueArr[i])){
                    alert(formatPromptArr[i]);
                    return false;
                }
            }

        }

        $.ajax({
            //提交数据的类型 POST GET
            type:"POST",
            //提交的网址
            url:"${ctxweb}/shop/ebproductshop/updateStandardDetail",
            //提交的数据
            data:{
                "id":$("#detailId").val(),
                "productStandardId":$("#productStandardId").val(),
                "productShopId":$("#productShopId").val(),
                "productId":$("#productId").val(),
                "shopId":$("#shopId").val(),
                // "detailPrices":$("#detailSellPrice").val(),
                // "memberPrice":$("#detailMemberPrice").val(),
                "detailInventory":$("#detailStoreNums").val(),
                "cost":$("#detailCost").val()
            },
            //返回数据的格式
            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
            //成功返回之后调用的函数
            success:function(data){
                if(data.prompt=="success"){
                    alert("修改成功！")

                    //修改表格数据
                    // detailSellPrice.text($("#detailSellPrice").val());
                    // detailMemberPrice.text($("#detailMemberPrice").val());
                    detailStoreNums.text( $("#detailStoreNums").val());
                    detailCost.text( $("#detailCost").val());

                    // var arr = data.rangeArr.split(",");
                    var storeNum = data.storeNum;

                    // $("#oldMemberPrice").text(arr[0]);
                    // $("#oldSellPrice").text(arr[1]);
                    $("#oldStoreNums").text(storeNum);

                    $("#updateStandardDetail").modal('hide');
                }else{
                    alert("修改失败！");
                }

                $("#updateStandardDetail").modal('hide');
            },error: function(){
                alert("修改失败！");
                $("#updateStandardDetail").modal('hide');
            }
        });
    }
</script>
</body>
</html>