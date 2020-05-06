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

    <title>销售信息</title>
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>


    <script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/china.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />

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
        .info-div ul li {
            list-style: none;
            font-size: 12px;
            line-height: 38px;
            float: left;
            flex: 1;
            text-align: center;
            border: 1px solid #efefef;
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
            margin-top: 20px;
        }

        .type-div{
            width: 100%;
            /*background: #fff;*/
            margin-top: 50px;
            /*border:1px solid #000;*/
        }

        .info-div h5{
            text-align: left;
            font-size: 14px;
            background: #fff;
            padding: 10px 0px 10px 20px;
            margin-bottom: 0px;
        }

        .content{
            padding: 10px;
        }
    </style>

    <script type="text/javascript">
        layui.use('laydate', function() {
            var laydate = layui.laydate;

            //常规用法
            laydate.render({
                elem: '#test1'
            })
        })
    </script>


</head>

<body>
<div class="content">
    <div class="info-div">
        <div class="layui-inline">
            <form method="post" action="${ctxsys}/statement/businessDaily">
                <input type="hidden" value="${shopId}" id="chooseShopId" name="shopId">
                <div class="layui-input-inline">
                    <label class="layui-form-label">选择日期：</label>
                    <input name="specificTime" value="${specificTime}" readonly style="margin: 4px 0px" type="text" class="input-medium" id="test1" placeholder="yyyy-MM-dd">

                </div>


                <div class="layui-input-inline" style="line-height: 38px">
                    <label class="layui-form-label">显示方式：</label>
                    <input type="radio" name="isAll" value="1" onclick="chooseShop(1)" style="margin-bottom: 3px" <c:if test="${isAll == 1}">checked="checked"</c:if>>汇总
                    <input type="radio" onclick="chooseShop(0)" value="0" name="isAll" style="margin-bottom: 3px" <c:if test="${isAll == 0}">checked="checked"</c:if>>指定门店
                    </select>
                </div>

                <div class="layui-input-inline" style="margin-left: 20px">
                    <input type="submit" class="btn btn-primary" style="background: #69AC72" value="查询">
                </div>
            </form>
        </div>
    </div>
    <div class="ordersbox">
        <%--<div class="detail-mod" id="differentSource">--%>
        <%--<input type="text" id="stratDate" placeholder="开始时间" /> <input--%>
        <%--type="text" id="endDate" placeholder="结束时间" />--%>
        <%--<button id="sourceBtn">查询</button>--%>
        <%--<div id="differentSource-mod"></div>--%>
        <%--</div>--%>
        <div class="left item-mod">
            <p>销售总金额</p>
            <c:if test="${pmBusinessDaily==null || pmBusinessDaily.id == null}">
                <p> 暂无数据</p>
            </c:if>
            <c:if test="${pmBusinessDaily!=null && pmBusinessDaily.id != null}">
                <h5> ${pmBusinessDaily.payableAmount}</h5>
            </c:if>

        </div>
        <div class="left item-mod">
            <p>实收金额</p>
            <c:if test="${pmBusinessDaily==null || pmBusinessDaily.id == null}">
                <p> 暂无数据</p>
            </c:if>
            <c:if test="${pmBusinessDaily!=null && pmBusinessDaily.id != null}">
                <h5> ${pmBusinessDaily.realAmount}</h5>
            </c:if>
        </div>
        <div class="left item-mod">
            <p>优惠金额</p>
            <c:if test="${pmBusinessDaily==null || pmBusinessDaily.id == null}">
                <p> 暂无数据</p>
            </c:if>
            <c:if test="${pmBusinessDaily!=null && pmBusinessDaily.id != null}">
                <h5> ${pmBusinessDaily.certificateAmount}</h5>
            </c:if>
        </div>
        <div class="left item-mod">
            <p>总单数</p>
            <c:if test="${pmBusinessDaily==null || pmBusinessDaily.id == null}">
                <p> 暂无数据</p>
            </c:if>
            <c:if test="${pmBusinessDaily!=null && pmBusinessDaily.id != null}">
                <h5> ${pmBusinessDaily.orderAmount}</h5>
            </c:if>
        </div>
    </div>
    <div class="orderdetail">
        <c:forEach items="${itemList}" var="item" varStatus="vs">

            <div class="info-div type-div">
                <h5 class="head type-title" style="font-size: 16px">
                    <c:if test="${item.type == 1}">门店订单</c:if>
                    <c:if test="${item.type == 2}">自提订单（小程序）</c:if>
                    <c:if test="${item.type == 3}">外卖订单（小程序）</c:if>
                </h5>
                <div class="info-div item-base-info">
                    <h5>基础信息</h5>
                    <ul class="head">
                        <li>销售总金额</li>
                        <li>优惠金额</li>
                        <li>实收金额</li>
                        <li>菜品应收</li>
                        <li>服务费</li>
                        <li>账单数</li>
                        <li>单均消费</li>
                    </ul>

                    <ul class="highLight">
                        <li>${item.payableAmount}</li>
                        <li>${item.certificateAmount}</li>
                        <li>${item.realAmount}</li>
                        <li>${item.productPayableAmount}</li>
                        <li>${item.serviceCharge}</li>
                        <li>${item.orderAmount}</li>
                        <li>${item.averagingCharge}</li>
                    </ul>
                </div>

                <div class="info-div read-pay" style="text-align: center">
                    <h5>实付构成</h5>
                    <c:if test="${payList == null || payList.size() == 0}">
                        暂无数据
                    </c:if>
                    <c:if test="${payList != null && payList.size() != 0}">
                        <c:forEach items="${payList}" var="pays">
                            <c:if test="${pays!=null && pays.size() != 0 && pays[0].businessDailyItemId == item.id}">
                                <ul class="head" style="width: 100%">
                                    <c:forEach items="${pays}" var="pay">
                                        <li >${pay.payName}</li>
                                    </c:forEach>

                                </ul>
                                <ul class="highLight" style="width: 100%">
                                    <c:forEach items="${pays}" var="pay">
                                        <li>${pay.payAmount}</li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </c:forEach>

                    </c:if>

                </div>

                <div class="info-div ranking-info" style="text-align: center">
                    <h5>菜品销量排行（前10）</h5>
                    <ul class="head">
                        <li>排名</li>
                        <li>菜品名称</li>
                        <li>销售数量</li>
                        <li>菜品应收</li>
                    </ul>
                    <c:if test="${rankingList.get(vs.index) == null || rankingList.get(vs.index).size() == 0}">
                        <ul class="highLight">
                            <li style="text-align: center"> 暂无数据</li>
                        </ul>

                    </c:if>
                    <c:if test="${rankingList.get(vs.index) != null || rankingList.get(vs.index).size() != 0}">
                        <c:forEach items="${rankingList}" var="ranks">
                            <c:if test="${ranks!=null && ranks.size() != 0 && ranks[0].businessDailyItemId == item.id}">
                                <c:forEach items="${ranks}" var="rank">
                                    <ul class="highLight">
                                        <li>${rank.ranking}</li>
                                        <li>${rank.productName}</li>
                                        <li>${rank.sales}</li>
                                        <li>${rank.productPayableAmount}</li>
                                    </ul>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </c:if>

                    </ul>
                </div>

                <c:if test="${fns:isShowWeight()}">
                    <div class="info-div ranking-info" style="text-align: center">
                        <h5>斩料销量排行（前10）</h5>
                        <ul class="head">
                            <li>排名</li>
                            <li>菜品名称</li>
                            <li>销售数量</li>
                            <li>菜品应收</li>
                        </ul>
                        <c:if test="${weightRankingList.get(vs.index) == null || weightRankingList.get(vs.index).size() == 0}">
                            <ul class="highLight">
                                <li style="text-align: center"> 暂无数据</li>
                            </ul>
                        </c:if>
                        <c:if test="${weightRankingList.get(vs.index) != null || weightRankingList.get(vs.index).size() != 0}">
                            <c:forEach items="${weightRankingList}" var="ranks">
                                <c:if test="${ranks!=null && ranks.size() != 0 && ranks[0].businessDailyItemId == item.id}">
                                    <c:forEach items="${ranks}" var="rank">
                                        <ul class="highLight">
                                            <li>${rank.ranking}</li>
                                            <li>${rank.productName}</li>
                                            <li>${fns:replaceStoreNum(2,1,rank.sales)}公斤</li>
                                            <li>${rank.productPayableAmount}</li>
                                        </ul>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </c:if>

                        </ul>
                    </div>
                </c:if>

                <div class="info-div certificate-info">
                    <h5>优惠构成</h5>
                    <ul class="head">
                        <li>免单金额</li>
                        <li>赠菜金额</li>
                        <li>套餐折扣</li>
                        <li>会员折扣</li>
                        <li>红包抵现</li>
                        <li>优惠券优惠</li>
                        <li>团购券优惠</li>
                        <li>会员卡折扣</li>
                        <li>方案折扣</li>
                        <li>菜品折扣</li>
                        <li>全单折扣</li>
                        <li>会员积分抵现</li>
                        <li>会员赠送账户消费</li>
                        <li>系统抹零</li>
                        <li>手动抹零</li>
                    </ul>

                    <ul class="highLight">
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>${item.certificateDiscountAmount}</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                        <li>0</li>
                    </ul>
                </div>
            </div>


        </c:forEach>



    </div>
</div>
<script type="text/javascript">
    //选择指定门店或者汇总
    function chooseShop(value){
        if(value==0){
            layer.open({
                type: 2,
                title: '门店列表',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['880px', '450px'],
                content: '${ctxsys}/Product/chooseShops?shopIds='+ $("#chooseShopId").val(),
                btn: ['确定', '关闭'],
                yes: function(index, layero){ //或者使用btn1
                    content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                    if(content==""){
                        layer.msg("请选择一个门店");
                        $("#chooseShopId").val(content);
                    }else if (content.split(",").length > 1) {
                        layer.msg("只能选择一个门店");

                    }else{
                        $("#chooseShopId").val(content);
                        layer.close(index);
                    }


                }
            })
        }else{
            $("#chooseShopId").val("");
        }


    }
</script>
</body>

</html>