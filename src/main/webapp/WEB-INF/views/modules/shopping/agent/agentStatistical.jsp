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
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>


    <script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/china.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />

    <link href="${ctxStatic}/bootstrap/2.3.1/docs/assets/css/bootstrap.css" type="text/css" rel="stylesheet">

    <title>代理商销售信息</title>
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

        #dailyorder, #WeekNewOrders, #Conversion, #differentSource, #beforeSevenDaysOrder,#weekDailyavg, #startupTimes,
        #differentuserRegiter {
            height: 530px;
        }
        #beforeSevenDaysOrder,#thisWeekOrderMoney{
            width: 95%;
        }
        .second {
            margin-left: 20px;
        }

        #orderClick, #orderDevice, #skuSalesVolumes, #spuSalesVolumes1,#spuSalesVolumes2,
        #spuSalesVolumes3,#differentTermial {
            border: 1px solid #efefef;
            overflow: auto;
            height: 530px;
        }

        #differentSource-mod,#differentuserRegiter-mod {
            width: 100%;
            height: 450px;
        }

        .head {
            background: #E7EAEC;
            height: 38px;
            line-height: 38px;
        }

        .highLight {
            background: #f7f8f9;
        }

        #orderClick ul, #orderDevice ul, #skuSalesVolumes ul, #spuSalesVolumes1 ul,
        #spuSalesVolumes2 ul, #spuSalesVolumes3 ul,
        #weekregistrNumber ul, #weekallproductSales ul, #differentTermial ul,
        #differentuserRegiter ul , #thisWeekOrderMoney ul{
            height: 38px;
            overflow: hidden;
            display: flex;
        }

        #orderClick ul li, #orderDevice ul li, #skuSalesVolumes ul li,
        #spuSalesVolumes1 ul li,#spuSalesVolumes2 ul li,#spuSalesVolumes3 ul li,
        #differentTermial ul li, #spuSalesVolumes ul li, #weekregistrNumber ul li,
        #weekallproductSales ul li, #differentuserRegiter ul li , #thisWeekOrderMoney ul li{
            list-style: none;
            line-height: 38px;
            float: left;
            flex: 1;
            text-align: center;
            border: 1px solid #efefef;
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

        .detail-mod ul{
            margin-left: 0px;
        }
    </style>
</head>

<body>
<div class="content">
    <div class="info-div" style="margin-top:10px;">
        <div class="layui-inline">
            <form method="post" action="${ctxsys}/agentStatistical/statistical">
                <input type="hidden" value="${pmAgent.id}" name="id" id="agentId" >
                <div class="layui-input-inline"><label class="layui-form-label">当前代理商:</label>
                    <input type="text"  class="input-medium" <c:if test="${!isAgent}"> onclick="chooseAgent()"</c:if> readonly id="agentName" name="agentName" value="${pmAgent.agentName}"  style=" width: 200px;margin: 4px 0px;"></li>
                </div>
                <div class="layui-input-inline" style="margin-left: 20px">
                    <input type="submit" class="btn btn-primary" style="background: #69AC72" value="查询">
                </div>
            </form>
        </div>
    </div>
    <div class="ordersbox">
        <div class="left item-mod" style="padding: 0px 40px">
            <p>今天订单总量</p>

            <c:if test="${todayOrderCount == null}">
                <p>暂无数据</p>
            </c:if>

            <c:if test="${todayOrderCount != null}">
                <h5> ${todayOrderCount}</h5>
            </c:if>


        </div>
        <div class="left item-mod" style="padding: 0px 40px">
            <p>今天支付订单总量</p>

            <c:if test="${todayPayOrderCount == null}">
                <p>暂无数据</p>
            </c:if>

            <c:if test="${todayPayOrderCount != null}">
                <h5>${todayPayOrderCount} </h5>
            </c:if>

        </div>
        <div class="left item-mod" style="padding: 0px 40px">
            <p>今天营业额</p>

            <c:if test="${todayPayOrderMoneyCount == null}">
                <p>暂无数据</p>
            </c:if>

            <c:if test="${todayPayOrderMoneyCount != null}">
                <h5>${todayPayOrderMoneyCount} </h5>
            </c:if>

        </div>
        <div class="left item-mod" style="padding: 0px 40px">
            <p>今天平均客单价</p>

            <c:if test="${todayOrderAverage == null}">
                <p>暂无数据</p>
            </c:if>

            <c:if test="${todayOrderAverage != null}">
                <h5>${todayOrderAverage}</h5>
            </c:if>

        </div>
    </div>

    <div class="ordersbox">
        <div class="left item-mod" style="padding: 0px 40px">
            <p>本周订单总量</p>

            <c:if test="${orderCount == null}">
                <p>暂无数据</p>
            </c:if>

            <c:if test="${orderCount != null}">
                <h5>${orderCount}  </h5>
            </c:if>


        </div>
        <div class="left item-mod" style="padding: 0px 40px">
            <p>本周支付订单总量</p>

            <c:if test="${payOrderCount == null}">
                <p>暂无数据</p>
            </c:if>

            <c:if test="${payOrderCount != null}">
                <h5>${payOrderCount}  </h5>
            </c:if>

        </div>
        <div class="left item-mod" style="padding: 0px 40px">
            <p>本周营业额</p>

            <c:if test="${payOrderMoneyCount == null}">
                <p>暂无数据</p>
            </c:if>

            <c:if test="${payOrderMoneyCount != null}">
                <h5> ${payOrderMoneyCount}</h5>
            </c:if>

        </div>
        <div class="left item-mod" style="padding: 0px 40px">
            <p>本周平均客单价</p>

            <c:if test="${orderAverage == null}">
                <p>暂无数据</p>
            </c:if>

            <c:if test="${orderAverage != null}">
                <h5>${orderAverage} </h5>
            </c:if>

        </div>
    </div>
    <div class="orderdetail">
        <%--本周订单及其环比--%>
        <div class="detail-mod" id="dailyorder"></div>
        <%--各节点转化率--%>
        <div class="detail-mod" id="Conversion"></div>
        <%--//最近7天每日订单类型分布（订单类型：1、门店自取 2、线下门店 3、外卖订单）--%>
        <div class="detail-mod second" id="beforeSevenDaysOrder"></div>
        <%--sku--%>
        <div class="detail-mod" id="skuSalesVolumes"></div>
        <%--spu(计量类型：件)--%>
        <div class="detail-mod" id="spuSalesVolumes1"></div>
        <c:if test="${fns:isShowWeight()}">
            <%--spu(计量类型：重量 ， 计量单位：公斤)--%>
            <div class="detail-mod" id="spuSalesVolumes2"></div>
        </c:if>
        <%--spu(计量类型：重量 ， 计量单位：克）--%>
        <%--<div class="detail-mod" id="spuSalesVolumes3"></div>--%>
        <%--商品订单价格--%>
        <div class="detail-mod" id="thisWeekOrderMoney"></div>

    </div>
</div>

<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
<script src="${ctxStatic}/sbShop/js/laydate.js"></script>
<script src="${ctxStatic}/sbShop/js/echarts.min.js"></script>
<script src="${ctxStatic}/sbShop/js/china.js"></script>
<script type="text/javascript">
    $(function() {
        obj.Init();
        laydate.render({
            elem : '#stratDate'
        });
        laydate.render({
            elem : '#endDate'
        });
        laydate.render({
            elem : '#regiterstratDate'
        });
        laydate.render({
            elem : '#regiterendDate'
        });
    })

    function statisticalOrderItemByProduct(element,type){
        var msg = "查询成功";
        var msgerr = "操作异常，请刷新页面";
        $.ajax({
            url : "${ctxsys}/agentStatistical/statisticalOrderItemByProduct?agentId=${pmAgent.id}&type="+type,
            type : "post",
            cache : false,
            success : function(data) {
                if (data.code == '00') {
                    var str = "";
                    if(type ==1){
                        str += "<p>Spu数（计量类型：件）（商品总数量 多规格只算一个）</p>"
                    }else if(type==2){
                        str += "<p>Spu数（计量类型：重量，计量单位：公斤）（商品总数量 多规格只算一个）</p>"
                    }

                    str += "<ul class='head'>";
                    str += "<li>商品ID</li>";
                    str += "<li>商品名称</li>";
                    str += "<li>销售数量</li>";
                    str += "</ul>";
                    if(data.resultList.length == 0){
                        str += "<ul><li style='width:100%;text-align:center'>暂无数据</li></ul>"
                    }else {
                        $.each(data.resultList, function (index, item) {
                            str += "<ul  class='" + (index % 2 == 0 ? "highLight" : "") + "'><li>" + item[0] + "</li>";
                            str += "<li>" + item[1] + "</li>"
                            str += "<li>" + item[2] + "</li></ul>";
                        });
                    }
                    $(element).html(str);
                } else {
                    top.$.jBox.tip(msgerr, 'info');
                }
            }
        })
    }
    var obj = {
        Init : function() {
            obj.statisticalDayOrder(); // 每日订单环比
            obj.statisticalBeforeSevenDayOrder(); // 最近7天每日订单类型分布（订单类型：1、门店自取 2、线下门店 3、外卖订单）
            obj.statisticalDayOrderZh(); // 各节点转化率分析
            obj.statisticalOrderItemByProperty(); // Spu数量
            obj.statisticalOrderItemByProduct1();// Spu数量(计量类型为重量)
            <c:if test="${fns:isShowWeight()}">
            obj.statisticalOrderItemByProduct2();// Spu数量（计量类型为重量，计量单位为公斤）
            </c:if>
            // obj.statisticalOrderItemByProduct3();// Spu数量（计量类型为重量，计量单位为克）
            obj.statisticalThisWeekOrderMoney();// 商品订单价格
        },

        // 每日订单环比
        statisticalDayOrder: function() {
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/agentStatistical/statisticalDayOrder?agentId=${pmAgent.id}",
                type : "post",
                cache : false,
                success : function(data) {
                    //console.log(data.code);
                    if (data.code == '00') {
                        obj.Dailyorder(data.orderList);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        },
        // 获取每日订单环比
        Dailyorder : function(seriesData) {
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('dailyorder'));
            var data1 = [],
                data2 = [],
                data3 = [];
            for (var i = 0; i < seriesData.length; i++) {
                data1.push(seriesData[i].daytime);
                data2.push(seriesData[i].orderCount);
                data3.push(seriesData[i].orderHb);
            }

            console.log(data1)
            console.log(data2)
            console.log(data3)
            var option = {
                backgroundColor : '#fff',
                tooltip : {
                    trigger : 'axis',
                    axisPointer : {
                        type : 'cross',
                        crossStyle : {
                            color : '#999'
                        }
                    }
                },

                legend : {
                    top : '3%',
                    data : [ '订单量', '每日订单环比' ]
                },
                xAxis : [ {
                    type : 'category',
                    data : data1,
                    axisPointer : {
                        type : 'shadow'
                    }
                } ],
                yAxis : [ {
                    type : 'value',
                    name : '新增订单量',
                },
                    {
                        type : 'value',
                        name : '百分比',
                        min : 0,
                        max : 10000,
                        axisLabel : {
                            formatter : '{value}%'
                        }
                    }
                ],
                series : [ {
                    name : '订单量',
                    type : 'bar',
                    data : data2,
                    yAxisIndex : 0,
                    itemStyle : {
                        normal : {
                            color : '#787B98'
                        }
                    }
                },
                    {
                        name : '每日订单环比',
                        type : 'line',
                        yAxisIndex : 1,
                        data : data3,
                        itemStyle : {
                            normal : {
                                color : '#CB605D'
                            }
                        }
                    }
                ]
            };

            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        },
        //最近7天每日订单类型分布（订单类型：1、门店自取 2、线下门店 3、外卖订单）
        statisticalBeforeSevenDayOrder: function() {
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            $.ajax({
                url : "${ctxsys}/agentStatistical/statisticalBeforeSevenDayOrder?agentId=${pmAgent.id}",
                type : "post",
                cache : false,
                success : function(data) {
                    if (data.code == '00') {
                        var data1 = new Array(),
                            data2 = new Array(),
                            data3 = new Array(),
                            data4 = new Array();
                        for (var i = 0; i < data.resultList.length; i++) {
                            data1.push(data.resultList[i][0]);
                            data2.push(data.resultList[i][1]);
                            data3.push(data.resultList[i][2]);
                            data4.push(data.resultList[i][3]);
                        }

                        var myChart = echarts.init(document.getElementById('beforeSevenDaysOrder'));
                        var option = {
                            title: {
                                text : '最近7天每日订单类型分布',
                                left : '3%',
                                top : '10'
                            },
                            tooltip: {
                                trigger: 'axis'
                            },
                            legend: {
                                data:['门店订单','自提订单','外卖订单']
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            toolbox: {
                                feature: {
                                    saveAsImage: {}
                                }
                            },
                            xAxis: {
                                type: 'category',
                                boundaryGap: false,
                                data: data1
                            },
                            yAxis: {
                                type: 'value'
                            },
                            series: [
                                {
                                    name:'门店订单',
                                    type:'line',
                                    data:data2
                                },
                                {
                                    name:'自提订单',
                                    type:'line',
                                    data:data3
                                },
                                {
                                    name:'外卖订单',
                                    type:'line',
                                    data:data4
                                }
                            ]
                        };

                        myChart.setOption(option);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            })
        },
        // 各节点转化率分析
        statisticalDayOrderZh : function() {
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/agentStatistical/statisticalDayOrderZh?agentId=${pmAgent.id}",
                type : "post",
                cache : false,
                success : function(data) {
                    if (data.code == '00') {
                        var data1 = [],
                            data2 = [],
                            data3 = [],
                            data4 = [],
                            data5 = [],
                            data6 = [],
                            data7 = [];
                        data2.push(data.liHashMaps[0].ebConversion_2['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_4['conversionTypeName'],
                            data.liHashMaps[0].ebConversion_4['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_5['conversionTypeName'],
                            data.liHashMaps[0].ebConversion_4['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_8['conversionTypeName'],
                            data.liHashMaps[0].ebConversion_8['conversionTypeName'] + "-" + data.liHashMaps[0].ebConversion_5['conversionTypeName']); //类型
                        for (var i = 0; i < data.liHashMaps.length; i++) {
                            data1.push(data.list[i]); // 创建日期
                            data3.push(data.liHashMaps[i].ebConversion_2['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_2['conversionCount'] - data.liHashMaps[i].ebConversion_4['conversionCount']) / data.liHashMaps[i].ebConversion_2['conversionCount']);
                            data4.push(data.liHashMaps[i].ebConversion_4['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_4['conversionCount'] - data.liHashMaps[i].ebConversion_5['conversionCount']) / data.liHashMaps[i].ebConversion_4['conversionCount']);
                            data5.push(data.liHashMaps[i].ebConversion_4['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_4['conversionCount'] - data.liHashMaps[i].ebConversion_8['conversionCount']) / data.liHashMaps[i].ebConversion_4['conversionCount']);
                            data6.push(data.liHashMaps[i].ebConversion_8['conversionCount'] == 0 ? 0 : (data.liHashMaps[i].ebConversion_8['conversionCount'] - data.liHashMaps[i].ebConversion_5['conversionCount']) / data.liHashMaps[i].ebConversion_8['conversionCount']);
                        }
                        var myChart = echarts.init(document.getElementById('Conversion'));
                        var option = {
                            backgroundColor : '#fff',
                            title : {
                                text : '各节点转化率分析',
                                top : '10',
                                left : '3%',
                            },
                            tooltip : {
                                trigger : 'axis'
                            },
                            legend : {
                                top : '10%',
                                data : data2
                            },
                            grid : {
                                left : '3%',
                                top : '20%',
                                right : '4%',
                                bottom : '3%',
                                containLabel : true
                            },
                            toolbox : {
                                feature : {
                                    saveAsImage : {}
                                }
                            },
                            xAxis : {
                                type : 'category',
                                boundaryGap : false,
                                data : data1
                            },
                            yAxis : {
                                type : 'value'
                            },
                            series : [ {
                                name : data2[0],
                                type : 'line',
                                stack : '总量',
                                data : data3
                            },
                                {
                                    name : data2[1],
                                    type : 'line',
                                    stack : '总量',
                                    data : data4
                                },
                                {
                                    name : data2[2],
                                    type : 'line',
                                    stack : '总量',
                                    data : data5
                                },
                                {
                                    name : data2[3],
                                    type : 'line',
                                    stack : '总量',
                                    data : data6
                                },
                            ]
                        };
                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        },

        // sku数
        statisticalOrderItemByProperty : function() {
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            $.ajax({
                url : "${ctxsys}/agentStatistical/statisticalOrderItemByProperty?agentId=${pmAgent.id}",
                type : "post",
                cache : false,
                success : function(data) {
                    if (data.code == '00') {
                        var str = "";
                        str += "<p>Sku数（商品总数量 多规格每个规格算一个）</p>"
                        str += "<ul class='head'>";
                        str += "<li>商品ID</li>";
                        str += "<li>商品名称</li>";
                        str += "<li>规格ID</li>";
                        str += "<li>规格名称</li>";
                        str += "<li>销售数量</li>";
                        str += "</ul>";

                        if(data.resultList.length == 0){
                            str += "<ul><li style='width:100%;text-align:center'>暂无数据</li></ul>"
                        }else {
                            $.each(data.resultList, function (index, item) {
                                str += "<ul  class='" + (index % 2 == 0 ? "highLight" : "") + "'><li>" + item[0] + "</li>";
                                str += "<li>" + item[1] + "</li>"
                                str += "<li>" + item[2] + "</li>";
                                str += "<li>" + item[3] + "</li>";
                                str += "<li>" + item[4] + "</li></ul>";
                            });
                        }
                        $("#skuSalesVolumes").html(str);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            })
        },
        // Spu数(计量类型：件)
        statisticalOrderItemByProduct1 : function() {
            statisticalOrderItemByProduct("#spuSalesVolumes1",1);
        },
        <c:if test="${fns:isShowWeight()}">
        // Spu数(计量类型：重量，计量单位：公斤)
        statisticalOrderItemByProduct2 : function() {
            statisticalOrderItemByProduct("#spuSalesVolumes2",2);
        },
        </c:if>
        // Spu数(计量类型：重量，计量单位：克)
        // statisticalOrderItemByProduct3 : function() {
        //     statisticalOrderItemByProduct("#spuSalesVolumes3",3);
        // },
        // 商品订单价格
        statisticalThisWeekOrderMoney : function() {
            var msg = "查询成功";
            var msgerr = "操作异常，请刷新页面";
            $.ajax({
                url : "${ctxsys}/agentStatistical/statisticalThisWeekOrderMoney?agentId=${pmAgent.id}",
                type : "post",
                cache : false,
                success : function(data) {
                    if (data.code == '00') {
                        var str = "";
                        str += "<p>商品订单价格</p>"
                        str += "<ul class='head'>";
                        str += "<li>日期</li>";
                        str += "<li>订单数</li>";
                        str += "<li>总金额</li>";
                        str += "<li>订单均价</li>";
                        str += "</ul>";
                        $.each(data.resultList, function(index, item) {
                            str += "<ul  class='" + (index % 2 == 0 ? "highLight" : "") + "'><li>" + item[0] + "</li>";
                            str += "<li>" + item[1] + "</li>"
                            str += "<li>" + item[2] + "</li>";
                            str += "<li>" + item[3] + "</li></ul>";
                        });
                        $("#thisWeekOrderMoney").html(str);
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            })
        }
    }


    //查询代理商
    function chooseAgent(){
        $("#shopId").val("");
        $("#shopName").val("");
        $(".shop-name-div").css("display","none");
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