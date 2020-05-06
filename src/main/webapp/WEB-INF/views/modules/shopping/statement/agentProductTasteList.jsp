<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="Description" content="${fns:getProjectName()},销售信息" />
    <meta name="Keywords" content="${fns:getProjectName()},销售信息" />
    <link href="${ctxStatic}/sbShop/css/laydate.css" rel="stylesheet"
          type="text/css" />

    <title>菜品营业分析</title>
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />

    <script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/china.js"></script>

    <link href="${ctxStatic}/bootstrap/2.3.1/docs/assets/css/bootstrap.css" type="text/css" rel="stylesheet">
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        body {
            background: rgba(128, 133, 144, .06);
        }

        .content {
            width: 100%;
        }

        .ordersbox {
            overflow: hidden;
            margin: 0 auto;
            flex-direction: row;
            display: -webkit-flex;
        }

        .left {
            float: left;
        }

        .item-mod {
            background: #fff;
            padding: 32px 40px;
            margin: 10px;
            flex: 1;
            height: 150px;
            position: relative;
        }

        .item-mod p {
            font-size: 12px;
            margin-top: 40px;
        }

        .item-mod h5 {
            font-size: 30px;
            font-weight: normal;
            color: rgba(10, 18, 32, .64);
        }

        .item-mod p, .item-mod h5 {
            padding-left: 50px;
        }

        .orderdetail, .detail-mod {
            overflow: hidden;

        }

        .detail-mod {
            width: 48%;
            background: #fff;
            margin-right: 10px;
            float: left;
            margin-left: 7px;
            margin-top: 10px;
        }


        .second {
            margin-left: 20px;
        }

        #orderClick, #orderDevice, #skuSalesVolumes, #spuSalesVolumes,#differentTermial {
            border: 1px solid #efefef;
            overflow: auto;
            max-height: 530px;
        }

        #differentSource-mod,#differentuserRegiter-mod {
            width: 100%;
            height: 450px;
        }

        .head {
            background: #fff;
            height: 38px;
            line-height: 38px;
        }

        .highLight {
            background: #f7f8f9;
        }
        ul{
            margin: 0px;
        }
        .info-div ul {
            height: 38px;
            overflow: hidden;
            display: flex;
        }

        .info-div{
            width: 100%;
        }
        .info-div>ul>li, #noChargingData li ,#chargingData li,#weightData li{
            list-style: none;
            font-size: 12px;
            line-height: 38px;
            float: left;
            flex: 1;
            text-align: center;
            border: 1px solid #efefef;
        }
        {

        }
        .highLight  li {
            background: #fff;
        }

        #differentSource {
            clear: both;
        }

        .detail-mod p {
            height: 38px;
            line-height: 38px;
            padding-left: 15px;
            background: #dfdfdf;
        }
        #stratDate,#regiterstratDate{margin-left:2rem;}
        #regiterBtn,#sourceBtn{width:50px;height:30px;line-height:30px;}
        #regiterstratDate,#regiterendDate,#endDate,#stratDate{width:150px;height:30px;line-height:30px;margin-right:30px;margin-top:20px;margin-bottom:20px;border-radius:5px;text-indent:10px;background:none;border:1px solid #999;}

        .type-title{
            padding-left: 20px;
            width: 100%;
            color: #69AC72;
            text-align: left;
        }

        .info-div{
            margin-top: 50px;
        }

        .type-div{
            width: 100%;
            /*background: #fff;*/
            margin-top: 50px;
            /*border:1px solid #000;*/
        }

        .info-div h5{
            text-align: center;
            color: #69AC72;
            font-size: 14px;
            background: #fff;
            padding: 10px 0px 10px 20px;
            margin-bottom: 0px;
        }

        .content{
            padding: 10px;
        }

        #searchForm{
            width:100%;
        }

        #searchForm ul li{
            float: left;
        }

        .pagination input{
            width: 50px;
            margin: 0px;
            padding: 0px;
            height: 16px;
        }

        #noChargingForm,#chargingForm{
            background: #fff;
            height: 38px;
        }
        #noChargingForm label,#chargingForm label{
            line-height: 38px;
        }
        .ul-form li{
            margin-left: 20px;
            line-height: 38px;
        }
    </style>

    <script type="text/javascript">
        layui.use('laydate', function() {
            var laydate = layui.laydate;

            //日期范围
            laydate.render({
                elem: '#test6'
                , range: true
            });
        })

        function page(){}

        // $(function(){
        //     $("#test6").change(function (){
        //         $(".rangkingTimeRange").val($(this).val())
        //     })
        //
        //     $("#quickTime").change(function () {
        //         $(".rangkingQuickTime").val($(this).val())
        //     })
        // })

        function clearTimeRange(){
            $(".timeRange").val("");
        }

        function clearQuickRange(){
            $("#emptyOption").attr("selected","selected")
        }

    </script>
</head>

<body>
<div class="content">
    <div class="">
        <li class="layui-inline">
            <form:form id="searchForm" modelAttribute="pmBusinessStatistics" action="${ctxsys}/agentStatement/productTasteList" method="post" class="breadcrumb form-search ">
            <ul class="ul-form">
                <input type="hidden" value="${shopId}" name="shopId" class="shopId" id="shopId">
                <input type="hidden" value="${agentId}" name="agentId" id="agentId" >
                <li><label>时间范围:</label>  <input type="text" onclick="clearQuickRange()" class="timeRange" readonly name="timeRange" value="${timeRange}" id="test6" placeholder=" - " style=" width: 200px;"></li>
                <li><label>快捷选择:</label>
                    <select name="quickTime" onchange="clearTimeRange()" id="quickTime">
                        <option value="" id="emptyOption">---请选择---</option>
                        <option value="1" <c:if test="${quickTime == 1}">selected</c:if>>昨天</option>
                        <option value="2" <c:if test="${quickTime == 2}">selected</c:if>>前七天</option>
                        <option value="3" <c:if test="${quickTime == 3}">selected</c:if>>前三十天</option>
                    </select>
                </li>

                <li>
                        <%--<input type="radio" onclick="chooseAgent()" style="margin-bottom: 3px" checked="checked">选择代理商--%>
                </li>
                <li><label>当前代理商:</label>  <input type="text"  <c:if test="${!isAgent}"> onclick="chooseAgent()"</c:if> readonly id="agentName" name="agentName" value="${agentName}"  style=" width: 200px;"></li>

                <li>
                    <label>显示方式：</label>
                    <input type="radio" id="all" name="isAll" onclick="chooseShop(1)" value="1" style="margin-bottom: 3px" <c:if test="${isAll == 1}">checked="checked"</c:if>>汇总
                    <input type="radio" id="byshop" onclick="chooseShop(0)" value="0" name="isAll" style="margin-bottom: 3px" <c:if test="${isAll == 0}">checked="checked"</c:if>>指定门店
                    </select>
                </li>
                <li class="shop-name-li"
                        <c:if test="${shopName == null || ''.equals(shopName)}">
                            style="display: none"
                        </c:if>
                ><label>当前门店:</label>  <input type="text" onclick="chooseShop(0)" class="input-medium" readonly id="shopName" name="shopName" value="${shopName}"  style=" width: 200px;margin: 4px 0px;"></li>
                </li>
                <li> &nbsp;&nbsp;<input style="background: #69AC72;" id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
                <li><input style="margin-left:5px;background: #69AC72" class="btn btn-primary check-a1" type="reset" value="重置"/></li>
            </ul>
            </form:form>
    </div>
</div>
<div class="orderdetail">
    <div class="info-div">
        <h5>菜品应收</h5>
        <ul class="head">
            <li>名称</li>
            <li>门店订单（金额/占比）</li>
            <li>门店自取（金额/占比）</li>
            <li>外卖（金额/占比）</li>
            <li>总计</li>
            <li>统计日期</li>
        </ul>
        <c:if test="${tasteList == null || tasteList.size() == 0}">
            <ul class="highLight">
                <li style="text-align: center">暂无数据</li>
            </ul>
        </c:if>
        <c:if test="${tasteList != null && tasteList.size() > 0}">
            <c:forEach items="${tasteList}" var="taste">
                <ul class="highLight">
                    <li>${taste.isAll == 1 ? "汇总":taste.shopName}</li>
                    <li>${taste.storeMoney}  /  ${taste.storeMoneyProportion}</li>
                    <li>${taste.selfMoney}  /  ${taste.selfMoneyProportion}</li>
                    <li>${taste.onlineMoney}  /  ${taste.onlineMoneyProportion}</li>
                    <li>${taste.moneyCount}</li>
                    <li><fmt:formatDate value='${taste.totalTime}' pattern='yyyy-MM-dd'/></li>
                </ul>
            </c:forEach>
        </c:if>


        <div class="info-div">
            <h5>菜品销售量</h5>

            <ul class="head">
                <li>名称</li>
                <li>门店订单（销售量/占比）</li>
                <li>门店自取（销售量/占比）</li>
                <li>外卖（销售量/占比）</li>
                <li>总计</li>
                <li>统计日期</li>
            </ul>

            <c:if test="${tasteList == null || tasteList.size() == 0}">
                <ul class="highLight">
                    <li style="text-align: center">暂无数据</li>
                </ul>
            </c:if>
            <c:if test="${tasteList != null && tasteList.size() > 0}">
                <c:forEach items="${tasteList}" var="taste">
                    <ul class="highLight">
                        <li>${taste.isAll == 1 ? "汇总":taste.shopName}</li>
                        <li>${taste.storeSales}  /  ${taste.storeSalesProportion}</li>
                        <li>${taste.selfSales}  /  ${taste.selfSalesProportion}</li>
                        <li>${taste.onlineSales}  /  ${taste.onlineSalesProportion}</li>
                        <li>${taste.salesCount}</li>
                        <li><fmt:formatDate value='${taste.totalTime}' pattern='yyyy-MM-dd'/></li>
                    </ul>
                </c:forEach>
            </c:if>

        </div>


        <div class="info-div" style="text-align: center">
            <h5>菜品排行（以商品为单位）</h5>

            <c:if test="${rankingPage1.list == null || rankingPage1.list.size() == 0}">
                暂无数据
            </c:if>
            <c:if test="${rankingPage1.list != null && rankingPage1.list.size() != 0}">
                <form id="noChargingForm" action="${ctxsys}/agentStatement/productTasteCharging" method="post" class="breadcrumb form-search ">
                    <input type="hidden" name="pageNo" id="noChargingNo">
                    <input type="hidden" name="pageSize" id="noChargingSize">
                    <input type="hidden" value="1" name="type">
                    <input type="hidden" value="${isAll}" name="isAll" class="isAll">
                    <input type="hidden" value="${shopId}" name="shopId" class="shopId">
                    <input type="hidden" class="rangkingTimeRange" value="${timeRange}" name="timeRange">
                    <input type="hidden" class="rangkingQuickTime" value="${quickTime}" name="quickTime">
                    <ul class="ul-form">
                        <li><label>订单类型:</label>
                            <select name="sortType" onclick="clearTimeRange">
                                <option value="0">门店订单</option>
                                <option value="1">自提订单</option>
                                <option value="2" >外卖订单</option>
                            </select>
                        </li>
                        <li><label style="margin-left: 50px;">排序依据:</label>
                            <input checked="checked" type="radio" value="0" style="margin-left: 10px;margin-bottom: 5px" name="sortBy">销售量
                            <input type="radio" value="1" style="margin-left: 20px; margin-bottom: 5px" name="sortBy">金额
                        </li>

                        <li> &nbsp;&nbsp;<input style="background: #69AC72;margin-left:25px;margin-top:6px;height: 25px;width: 50px;padding-top: 2px" class="btn btn-primary" type="button" value="确定" onclick="return onChargingSumbit();"/></li>
                        <li><input style="background: #69AC72;height: 25px;margin-left:10px;margin-top:6px;width: 50px;padding-top: 2px" class="btn btn-primary check-a1" type="reset" value="重置"/></li>
                    </ul>
                </form>
                <ul class="head">
                    <li>排名</li>
                    <li>菜品分类</li>
                    <li>销售数量</li>
                    <li>菜品应收</li>
                    <li>门店订单（销售量/金额）</li>
                    <li>门店自取（销售量/金额）</li>
                    <li>外卖（销售量/金额）</li>
                </ul>
                <div id="noChargingData">
                    <c:forEach items="${rankingPage1.list}" var="noCharging" varStatus="status">
                        <ul class="highLight" style="width: 100%">
                            <li>${(rankingPage1.pageNo-1)*rankingPage1.pageSize+status.index+1}</li>
                            <li>${noCharging.productAnalyze}</li>
                            <li>${noCharging.sales}</li>
                            <li>${noCharging.realAmount}</li>
                            <li>${noCharging.storeSales}  /  ${noCharging.storeRealAmount}</li>
                            <li>${noCharging.selfSales}  /  ${noCharging.selfRealAmount}</li>
                            <li>${noCharging.onlineSales}  /  ${noCharging.onlineRealAmount}</li>
                        </ul>
                    </c:forEach>
                </div>
                <div class="pagination" id="noChargingPage">${rankingPage1}</div>
            </c:if>
        </div>

        <div class="info-div" style="text-align: center">
            <h5>菜品排行（以规格为单位）</h5>
            <c:if test="${rankingPage2.list == null || rankingPage2.list.size() == 0}">
                暂无数据
            </c:if>
            <c:if test="${rankingPage2.list != null && rankingPage2.list.size() != 0}">
                <form id="chargingForm" action="${ctxsys}/agentStatement/productTasteCharging" method="post" class="breadcrumb form-search ">
                    <input type="hidden" name="pageNo" id="chargingNo">
                    <input type="hidden" name="pageSize" id="chargingSize">
                    <input type="hidden" value="2" name="type">
                    <input type="hidden" value="${isAll}" name="isAll" class="isAll">
                    <input type="hidden" value="${shopId}" name="shopId" class="shopId">
                    <input type="hidden" class="rankingTimeRange" value="${timeRange}" name="timeRange">
                    <input type="hidden" class="rangkingQuickTime" value="${quickTime}" name="quickTime">

                    <ul class="ul-form">
                        <li><label>订单类型:</label>
                            <select name="sortType" onclick="clearTimeRange">
                                <option value="0">门店订单</option>
                                <option value="1">自提订单</option>
                                <option value="2" >外卖订单</option>
                            </select>
                        </li>
                        <li><label style="margin-left: 50px;">排序依据:</label>
                            <input type="radio" value="0" checked="checked" style="margin-left: 10px;margin-bottom: 5px" name="sortBy">销售量
                            <input type="radio" value="1" style="margin-left: 20px; margin-bottom: 5px" name="sortBy">金额
                        </li>

                        <li> &nbsp;&nbsp;<input style="background: #69AC72;margin-left:25px;margin-top:6px;height: 25px;width: 50px;padding-top: 2px;vertical-align:middle;" class="btn btn-primary" type="button" value="确定" onclick="return chargingSumbit();"/></li>
                        <li><input style="background: #69AC72;margin-left:10px;height: 25px;margin-top:6px;width: 50px;padding-top: 2px;vertical-align:middle;" class="btn btn-primary check-a1" type="reset" value="重置"/></li>

                    </ul>

                </form>

                <ul class="head">
                    <li>排名</li>
                    <li>菜品分类</li>
                    <li>销售数量</li>
                    <li>菜品应收</li>
                    <li>门店订单（销售量/金额）</li>
                    <li>门店自取（销售量/金额）</li>
                    <li>外卖（销售量/金额）</li>
                </ul>
                <div id="chargingData" style="width: 100%">
                    <c:forEach items="${rankingPage2.list}" var="charging" varStatus="status2">
                        <ul class="highLight" style="width: 100%">
                            <li>${(rankingPage2.pageNo-1)*rankingPage2.pageSize+status2.index+1}</li>
                            <li>${charging.productAnalyze}</li>
                            <li>${charging.sales}</li>
                            <li>${charging.realAmount}</li>
                            <li>${charging.storeSales}  /  ${charging.storeRealAmount}</li>
                            <li>${charging.selfSales}  /  ${charging.selfRealAmount}</li>
                            <li>${charging.onlineSales}  /  ${charging.onlineRealAmount}</li>
                        </ul>
                    </c:forEach>
                </div>
                <div class="pagination" id="chargingPage" >${rankingPage2}</div>
            </c:if>
        </div>

        <c:if test="${fns:isShowWeight()}">
            <div class="info-div" style="text-align: center">
                <h5>斩料排行</h5>
                <c:if test="${rankingPage3.list == null || rankingPage3.list.size() == 0}">
                    暂无数据
                </c:if>
                <c:if test="${rankingPage3.list != null && rankingPage3.list.size() != 0}">
                    <form id="weightForm" action="${ctxsys}/agentStatement/productTasteCharging" method="post" class="breadcrumb form-search ">
                        <input type="hidden" name="pageNo" id="weightNo">
                        <input type="hidden" name="pageSize" id="weightSize">
                        <input type="hidden" value="3" name="type">
                        <input type="hidden" value="${isAll}" name="isAll" class="isAll">
                        <input type="hidden" value="${shopId}" name="shopId" class="shopId">
                        <input type="hidden" class="rankingTimeRange" value="${timeRange}" name="timeRange">
                        <input type="hidden" class="rangkingQuickTime" value="${quickTime}" name="quickTime">

                        <ul class="ul-form">
                            <li><label>订单类型:</label>
                                <select name="sortType" onclick="clearTimeRange">
                                    <option value="0">门店订单</option>
                                    <option value="1">自提订单</option>
                                    <option value="2" >外卖订单</option>
                                </select>
                            </li>
                            <li><label style="margin-left: 50px;">排序依据:</label>
                                <input type="radio" value="0" checked="checked" style="margin-left: 10px;margin-bottom: 5px" name="sortBy">销售量
                                <input type="radio" value="1" style="margin-left: 20px; margin-bottom: 5px" name="sortBy">金额
                            </li>

                            <li> &nbsp;&nbsp;<input style="background: #69AC72;margin-left:25px;margin-top:6px;height: 25px;width: 50px;padding-top: 2px;vertical-align:middle;" class="btn btn-primary" type="button" value="确定" onclick="return weightSumbit();"/></li>
                            <li><input style="background: #69AC72;margin-left:10px;height: 25px;margin-top:6px;width: 50px;padding-top: 2px;vertical-align:middle;" class="btn btn-primary check-a1" type="reset" value="重置"/></li>

                        </ul>

                    </form>

                    <ul class="head">
                        <li>排名</li>
                        <li>菜品分类</li>
                        <li>销售数量</li>
                        <li>菜品应收</li>
                        <li>门店订单（销售量/金额）</li>
                        <li>门店自取（销售量/金额）</li>
                        <li>外卖（销售量/金额）</li>
                    </ul>
                    <div id="weightData" style="width: 100%">
                        <c:forEach items="${rankingPage3.list}" var="charging" varStatus="status3">
                            <ul class="highLight" style="width: 100%">
                                <li>${(rankingPage3.pageNo-1)*rankingPage3.pageSize+status3.index+1}</li>
                                <li>${charging.productAnalyze}</li>
                                <li>${fns:replaceStoreNum(2,1,charging.sales)}公斤</li>
                                <li>${charging.realAmount}</li>
                                <li>${fns:replaceStoreNum(2,1,charging.storeSales)}公斤  /  ${charging.storeRealAmount}</li>
                                <li>${fns:replaceStoreNum(2,1,charging.selfSales)}公斤   /  ${charging.selfRealAmount}</li>
                                <li>${fns:replaceStoreNum(2,1,charging.onlineSales)}公斤   /  ${charging.onlineRealAmount}</li>
                            </ul>
                        </c:forEach>
                    </div>
                    <div class="pagination" id="weightPage" >${rankingPage3}</div>
                </c:if>
            </div>

            <%--</div>--%>
        </c:if>

    </div>

    <c:if test="${fns:isShowWeight()}">
        <div class="info-div">
            <h5>斩料应收</h5>
            <ul class="head">
                <li>名称</li>
                <li>门店订单（金额/占比）</li>
                <li>门店自取（金额/占比）</li>
                <li>外卖（金额/占比）</li>
                <li>总计</li>
                <li>统计日期</li>
            </ul>
            <c:if test="${tasteList == null || tasteList.size() == 0}">
                <ul class="highLight">
                    <li style="text-align: center">暂无数据</li>
                </ul>
            </c:if>
            <c:if test="${tasteList != null && tasteList.size() > 0}">
                <c:forEach items="${tasteList}" var="taste">
                    <ul class="highLight">
                        <li>${taste.isAll == 1 ? "汇总":taste.shopName}</li>
                        <li>${taste.weightStoreMoney}  /  ${taste.weightStoreMoneyProportion}</li>
                        <li>${taste.weightSelfMoney}  /  ${taste.weightSelfMoneyProportion}</li>
                        <li>${taste.weightOnlineMoney}  /  ${taste.weightOnlineMoneyProportion}</li>
                        <li>${taste.weightMoneyCount}</li>
                        <li><fmt:formatDate value='${taste.totalTime}' pattern='yyyy-MM-dd'/></li>
                    </ul>
                </c:forEach>
            </c:if>

        </div>
        <div class="info-div">
            <h5>斩料销售量</h5>

            <ul class="head">
                <li>名称</li>
                <li>门店订单（销售量/占比）</li>
                <li>门店自取（销售量/占比）</li>
                <li>外卖（销售量/占比）</li>
                <li>总计</li>
                <li>统计日期</li>
            </ul>

            <c:if test="${tasteList == null || tasteList.size() == 0}">
                <ul class="highLight">
                    <li style="text-align: center">暂无数据</li>
                </ul>
            </c:if>
            <c:if test="${tasteList != null && tasteList.size() > 0}">
                <c:forEach items="${tasteList}" var="taste">
                    <ul class="highLight">
                        <li>${taste.isAll == 1 ? "汇总":taste.shopName}</li>
                        <li>${fns:replaceStoreNum(2,1,taste.weightStoreSales)}公斤  /  ${taste.weightStoreSalesProportion}</li>
                        <li>${fns:replaceStoreNum(2,1,taste.weightSelfSales)}公斤  /  ${taste.weightSelfSalesProportion}</li>
                        <li>${fns:replaceStoreNum(2,1,taste.weightOnlineSales)}公斤  /  ${taste.weightOnlineSalesProportion}</li>
                        <li>${fns:replaceStoreNum(2,1,taste.weightSalesCount)}公斤</li>
                        <li><fmt:formatDate value='${taste.totalTime}' pattern='yyyy-MM-dd'/></li>
                    </ul>
                </c:forEach>
            </c:if>

        </div>
    </c:if>
</div>
</div>

<script type="text/javascript">
    $(function(){
        //以商品为单位的点击某一页
        $("#noChargingPage").on("click","a",function(){
            var pageNo;
            var pageSize;

            if($(this).parent().hasClass("disabled")){
                return;
            }

            if($(this).text().toString().indexOf("上一页") >=0){
                pageNo = parseInt($("#noChargingPage .active a").text())-1;
            }else if($(this).text().toString().indexOf("下一页") >=0){
                pageNo = parseInt($("#noChargingPage .active a").text())+1;
            }else{
                pageNo = $(this).text();
            }

            pageSize = $($("#noChargingPage input")[1]).val();

            noChargingPage(pageNo ,pageSize);
        })

        //以商品为单位的输入当前页面或者页面大小
        $("#noChargingPage").on("keyup","input",function(){
            //点击回车
            if(event.keyCode ==13) {
                //查看当前元素在父元素中的下标  0  页数  1  页面大小
                var index = $(this).index();

                if (index == 0) {
                    noChargingPage($(this).val(), $($("#noChargingPage input")[1]).val());
                }

                if (index == 1) {
                    noChargingPage($($("#noChargingPage input")[0]).val(), $(this).val());
                }
            }

        })



        //以规格为单位的点击某一页
        $("#chargingPage").on("click","a",function(){
            var pageNo;
            var pageSize;

            //检查是否为不可用按钮
            if($(this).parent().hasClass("disabled")){
                return;
            }

            if($(this).text().toString().indexOf("上一页") >=0){
                pageNo = parseInt($("#chargingPage .active a").text())-1;
            }else if($(this).text().toString().indexOf("下一页") >=0){
                pageNo = parseInt($("#chargingPage .active a").text())+1;
            }else{
                pageNo = $(this).text();
            }

            pageSize = $($("#chargingPage input")[1]).val();

            chargingPage(pageNo ,pageSize);
        })


        //以规格为单位的输入当前页面或者页面大小
        $("#chargingPage").on("keyup","input",function(){
            //点击回车
            if(event.keyCode ==13) {
                //查看当前元素在父元素中的下标  0  页数  1  页面大小
                var index = $(this).index();

                if (index == 0) {
                    chargingPage($(this).val(), $($("#chargingPage input")[1]).val());
                }

                if (index == 1) {
                    chargingPage($($("#chargingPage input")[0]).val(), $(this).val());
                }
            }

        })


        //以斩料点击某一页
        $("#weightPage").on("click","a",function(){
            var pageNo;
            var pageSize;

            //检查是否为不可用按钮
            if($(this).parent().hasClass("disabled")){
                return;
            }

            if($(this).text().toString().indexOf("上一页") >=0){
                pageNo = parseInt($("#weightPage .active a").text())-1;
            }else if($(this).text().toString().indexOf("下一页") >=0){
                pageNo = parseInt($("#weightPage .active a").text())+1;
            }else{
                pageNo = $(this).text();
            }

            pageSize = $($("#weightPage input")[1]).val();

            weightPage(pageNo ,pageSize);
        })


        //以斩料输入当前页面或者页面大小
        $("#weightPage").on("keyup","input",function(){
            //点击回车
            if(event.keyCode ==13) {
                //查看当前元素在父元素中的下标  0  页数  1  页面大小
                var index = $(this).index();

                if (index == 0) {
                    weightPage($(this).val(), $($("#weightPage input")[1]).val());
                }

                if (index == 1) {
                    weightPage($($("#weightPage input")[0]).val(), $(this).val());
                }
            }

        })
    })


    //给以商品为单位排行必要的参数赋值
    function noChargingPage(pageNo , pageSize){
        if(pageNo == undefined || pageNo == ""){
            return false;
        }

        if(pageSize == undefined || pageSize == ""){
            return false;
        }

        $("#noChargingNo").val(pageNo);
        $("#noChargingSize").val(pageSize);

        onChargingSumbit();
    }

    //提交以商品为单位商品排行分页请求
    function onChargingSumbit(){
        $.ajax({
            //提交数据的类型 POST GET
            type:"POST",
            //提交的网址
            url:$("#noChargingForm").attr("action"),
            //提交的数据
            data:$("#noChargingForm").serialize(),
            //返回数据的格式
            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
            //成功返回之后调用的函数
            success:function(result){
                if(result.data == null){
                    return;
                }

                $("#noChargingNo").val(result.data.pageNo);
                $("#noChargingSize").val(result.data.pageSize);

                $("#noChargingPage").html(result.data.html)

                //数据列表
                var list =  result.data.list;
                //page对象
                var page = result.data;

                $("#noChargingData").empty();

                if(list == 0 || list.size==0){
                    $("#noChargingData").text("暂无数据")
                }else {
                    for (var i = 0; i < list.length; i++) {
                        var e = list[i];
                        var str = " <ul class='highLight' style='width: 100%'>";
                        str += "<li>" + ((page.pageNo - 1) * page.pageSize + i + 1)+"</li>"
                        str += "<li>" + e.productAnalyze + "</li>";
                        str += "<li>" + e.sales + "</li>";
                        str += "<li>" + e.realAmount + "</li>";
                        str += "<li>" + e.storeSales + "  /  " + e.storeRealAmount + "</li>";
                        str += "<li>" + e.selfSales + "  /  " + e.selfRealAmount + "</li>";
                        str += "<li>" + e.onlineSales + "  /  " + e.onlineRealAmount + "</li>";
                        str += "</ul>";
                        $("#noChargingData").append(str);
                    }
                }
            } ,error: function(){

            }
        })
    }





    //给以规格为单位商品排行分页必要的参数赋值
    function chargingPage(pageNo , pageSize){
        if(pageNo == undefined || pageNo == ""){
            return false;
        }

        if(pageSize == undefined || pageSize == ""){
            return false;
        }

        $("#chargingNo").val(pageNo);
        $("#chargingSize").val(pageSize);

        chargingSumbit();
    }

    //以规格为单位提交分页请求
    function chargingSumbit(){
        $.ajax({
            //提交数据的类型 POST GET
            type:"POST",
            //提交的网址
            url:$("#chargingForm").attr("action"),
            //提交的数据
            data:$("#chargingForm").serialize(),
            //返回数据的格式
            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
            //成功返回之后调用的函数
            success:function(result){
                if(result.data == null){
                    return;
                }

                $("#chargingNo").val(result.data.pageNo);
                $("#chargingSize").val(result.data.pageSize);

                $("#chargingPage").html(result.data.html)

                //数据列表
                var list =  result.data.list;
                //page对象
                var page = result.data;

                $("#chargingData").empty();

                if(list == 0 || list.size==0){
                    $("#chargingData").text("暂无数据")
                }else {
                    for (var i = 0; i < list.length; i++) {
                        var e = list[i];
                        var str = " <ul class='highLight' style='width: 100%'>";
                        str += "<li>" + ((page.pageNo - 1) * page.pageSize + i + 1)+"</li>"
                        str += "<li>" + e.productAnalyze + "</li>";
                        str += "<li>" + e.sales + "</li>";
                        str += "<li>" + e.realAmount + "</li>";
                        str += "<li>" + e.storeSales + "  /  " + e.storeRealAmount + "</li>";
                        str += "<li>" + e.selfSales + "  /  " + e.selfRealAmount + "</li>";
                        str += "<li>" + e.onlineSales + "  /  " + e.onlineRealAmount + "</li>";
                        str += "</ul>";
                        $("#chargingData").append(str);
                    }
                }
            } ,error: function(){

            }
        })
    }

    //给斩料商品排行分页必要的参数赋值
    function weightPage(pageNo , pageSize){
        if(pageNo == undefined || pageNo == ""){
            return false;
        }

        if(pageSize == undefined || pageSize == ""){
            return false;
        }

        $("#weightNo").val(pageNo);
        $("#weightSize").val(pageSize);

        weightSumbit();
    }

    //斩料提交分页请求
    function weightSumbit(){
        $.ajax({
            //提交数据的类型 POST GET
            type:"POST",
            //提交的网址
            url:$("#weightForm").attr("action"),
            //提交的数据
            data:$("#weightForm").serialize(),
            //返回数据的格式
            datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
            //成功返回之后调用的函数
            success:function(result){
                if(result.data == null){
                    return;
                }

                $("#weightNo").val(result.data.pageNo);
                $("#weightSize").val(result.data.pageSize);

                $("#weightPage").html(result.data.html)

                //数据列表
                var list =  result.data.list;
                //page对象
                var page = result.data;

                $("#weightData").empty();

                if(list == 0 || list.size==0){
                    $("#weightData").text("暂无数据")
                }else {
                    for (var i = 0; i < list.length; i++) {
                        var e = list[i];
                        var str = " <ul class='highLight' style='width: 100%'>";
                        str += "<li>" + ((page.pageNo - 1) * page.pageSize + i + 1)+"</li>"
                        str += "<li>" + e.productAnalyze + "</li>";
                        str += "<li>" + e.sales/1000 + "公斤</li>";
                        str += "<li>" + e.realAmount + "</li>";
                        str += "<li>" + (e.storeSales/1000) + "公斤  /  " + e.storeRealAmount + "</li>";
                        str += "<li>" + (e.selfSales/1000) + "公斤  /  " + e.selfRealAmount + "</li>";
                        str += "<li>" + (e.onlineSales/1000) + "公斤  /  " + e.onlineRealAmount + "</li>";
                        str += "</ul>";
                        $("#weightData").append(str);
                    }
                }
            } ,error: function(){

            }
        })
    }
</script>


<script type="text/javascript">
    //选择指定门店或者汇总
    function chooseShop(isAll){
        $(".isAll").val(isAll);

        if(isAll == 0){
            layer.open({
                type: 2,
                title: '门店列表',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['880px', '450px'],
                content: '${ctxsys}/agentStatement/chooseShopByAgent?chooseIds='+ $("#shopId").val()+"&agentId="+$("#agentId").val() ,
                btn: ['确定', '关闭'],
                yes: function(index, layero){ //或者使用btn1
                    content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                    var chooseNames = layero.find("iframe")[0].contentWindow.$('#chooseNames').val();
                    if(content==""){
                        layer.msg("请选择一个门店");
                    }else{
                        $(".shopId").val(content);
                        $("#shopName").val(chooseNames);
                        $(".shop-name-li").css("display","inline-block");
                        layer.close(index);
                    }


                }
            })
        }else{
            $("#shopId").val("");
            $("#shopName").val("");
            $(".shop-name-li").css("display","none");
        }
    }


    //查询代理商
    function chooseAgent(isAll){
        $("#shopId").val("");
        $("#shopName").val("");
        $(".shop-name-li").css("display","none");
        $("#all").attr("checked",true)
        $("#byshop").attr("checked",false)

        layer.open({
            type: 2,
            title: '代理商列表',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['880px', '450px'],
            content: '${ctxsys}/agentStatement/chooseAgent?agentId='+ $("#agentId").val(),
            btn: ['确定', '关闭'],
            yes: function(index, layero){ //或者使用btn1
                content = layero.find("iframe")[0].contentWindow.$('#chooseId').val();
                var chooseName = layero.find("iframe")[0].contentWindow.$('#chooseName').val();
                if(content==""){
                    layer.msg("请选择一个代理商");
                }else{
                    $("#agentId").val(content);
                    $("#agentName").val(chooseName);
                    layer.close(index);
                }
            }
        })
    }
</script>
</body>

</html>