<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title></title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />

    <script type="text/javascript">

        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/statement/getOrderPage");
            $("#searchForm").submit();
            return false;
        }
    </script>

    <style type="text/css">
        .title-tr span{
            padding: 0px;
            margin: 0px;
            float: none;
            text-align: center;
            cursor: pointer;
        }

        .sore-th:hover{
            color: #69AC72;
        }
        #contentTable td , #contentTable td{
            text-align: left;
        }

        #contentTable td,#contentTable th{
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        layui.use('laydate', function() {
            var laydate = layui.laydate;
            //日期范围
            laydate.render({
                elem: '#test6'
                ,type: 'datetime'
                , range: true
            });


            //年月范围
            laydate.render({
                elem: '#test8'
                , type: 'month'
                , range: true
            });
        })

        // function clearTimeRange(){
        //     $(".timeRange").val("");
        // }

        function clearQuickRange(){
            $("#emptyOption").attr("selected","selected")
        }
    </script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/sbShop/css/export.css">
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a>订单明细</a></li>
</ul>
<form:form id="searchForm" modelAttribute="ebOrder" action="${ctxsys}/statement/getOrderPage" method="post" class="breadcrumb form-search ">
    <input path="userId" type="hidden"/>
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="chooseShopId" name="shopIds" type="hidden" value="${shopIds}"/>
    <input id="payCodes" name="payCodes" type="hidden" value="${payCodes}"/>
    <input id="type" name="type" type="hidden" value="1"/>
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <div style="font-size: 13px;padding-left: 32px;padding-right: 10px;">
        指标说明：支付净额表示核减退款后您实际发生的交易总额；结算金额表示通过平台付款且扣除手续费后的商户可提现金额；非结算金额表示未通过平台付款的交易金额</br></br>
    </div>
    <ul class="ul-form">
        <li><label>时间范围:</label>  <input type="text" onclick="clearQuickRange()" class="timeRange" readonly name="timeRange" value="${timeRange}" id="test6" placeholder=" - " style=" width: 250px;"></li>
        <li><label>快捷选择:</label>
            <select name="quickTime">
                <option id="emptyOption" value="">---请选择---</option>
                <option value="0" <c:if test="${quickTime == 0}">selected</c:if>>今天</option>
                <option value="-1" <c:if test="${quickTime == -1}">selected</c:if>>昨天</option>
                <option value="-7" <c:if test="${quickTime == -7}">selected</c:if>>近七天</option>
                <option value="-30" <c:if test="${quickTime == -30}">selected</c:if>>近三十天</option>
            </select>
        </li>
        <li><label>订单状态:</label>
            <select name="orderStatus">
                <option id="emptyOption2" value="">---请选择---</option>
                <%--<option value="1" <c:if test="${orderStatus == 1}">selected</c:if>>等待买家付款</option>--%>
                <option value="2" <c:if test="${orderStatus == 2}">selected</c:if>>等待发货</option>
                <option value="3" <c:if test="${orderStatus == 3}">selected</c:if>>已发货,待收货</option>
                <option value="4" <c:if test="${orderStatus == 4}">selected</c:if>>已完成</option>
                <option value="6" <c:if test="${orderStatus == 6}">selected</c:if>>已退款</option>
                <%--<option value="5" <c:if test="${orderStatus == 5}">selected</c:if>>已关闭</option>--%>
            </select>
        </li>
        <li><label>显示方式:</label>
            <input class="form-check-input" type="radio" onclick="chooseShop(1)" style="padding: 10px 0px" name="isAll" value="1" <c:if test="${shopIds ==null||  ''.equals(shopIds)}">checked="checked"</c:if>>所有门店
            <input class="form-check-input" type="radio"  onclick="chooseShop(0)" style="padding: 10px 0px" name="isAll" value="0" <c:if test="${shopIds != null && !''.equals(shopIds)}">checked="checked"</c:if>>指定门店
        </li>
        <li id="shop-name-li"
                <c:if test="${shopNames == null || ''.equals(shopNames)}">
                    style="display: none"
                </c:if>
        ><label class="layui-form-label">当前门店:</label>  <input type="text" onclick="chooseShop(0)" class="input-medium" readonly id="shopName" name="shopNames" value="${shopNames}"  style=" width: 200px;margin: 4px 0px;"></li>
        </li>
        <li><label>支付方式:</label>
            <input class="form-check-input" type="radio" name="paytype" onclick="choosePayWay(1)" style="padding: 10px 0px"  value="1" <c:if test="${payCodes ==null||  ''.equals(payCodes)}">checked="checked"</c:if>>所有
            <input class="form-check-input" type="radio"  name="paytype" onclick="choosePayWay(0)" style="padding: 10px 0px" value="0" <c:if test="${payCodes != null && !''.equals(payCodes)}">checked="checked"</c:if>>指定
        </li>
        <li id="pay-li"
                <c:if test="${payRemarks == null || ''.equals(payRemarks)}">
                    style="display: none"
                </c:if>
        ><label class="layui-form-label" style="width: 90px">当前支付方式:</label>  <input type="text" onclick="choosePayWay(0)" class="input-medium" readonly id="payRemarks" name="payRemarks" value="${payRemarks}"  style=" width: 200px;margin: 4px 0px;"></li>
        </li>
        <li style="margin-left: 30px"> &nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
            <%--<li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>--%>
        <li style="margin-left:10px; "><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>

        <div class="check1">
            <div class="check-box">
                <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
                <ul class="mn1">
                    <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="门店名称,shopName"><label><i></i>门店名称</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="门店账号,shopCode"><label><i></i>门店账号</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="订单号,orderNo"><label><i></i>订单号</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="订单状态,statusName"><label><i></i>订单状态</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="支付金额,payAmount"><label><i></i>支付金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="支付净额,realAmount"><label><i></i>支付净额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="手续费,poundage"><label><i></i>手续费</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="可提现金额,extractAmout"><label><i></i>可提现金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="非结算金额,noExtractAmout"><label><i></i>非结算金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="支付渠道,payChannel"><label><i></i>支付渠道</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="支付方式,payTypeName"><label><i></i>支付方式</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="订单来源,sourceName"><label><i></i>订单来源</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="支付时间,payTime"><label><i></i>支付时间</label></li>

                </ul>
                <div class="check-btn">
                    <a href="javascript:;" id="fromNewActionSbM" >确定</a>
                    <a class="check-del1" href="javascript:;">取消</a>
                </div>
            </div>
        </div>
    </ul>
</form:form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed" >
    <tr class="title-tr" style="text-align: center">
        <th>序号</th>
        <th>门店名称</th>
        <th>门店账号</th>
        <th>订单编号</th>
        <th>订单状态</th>
        <th>支付金额</th>
        <th>支付净额</th>
        <th>手续费</th>
        <th>可提现金额</th>
        <th>非结算金额</th>
        <th>支付渠道</th>
        <th>支付方式</th>
        <th>订单来源</th>
        <th>支付时间</th>
        <th>退款时间</th>
        <th>操作</th>

    </tr>

    <c:if test="${page.list == null || page.list.size() == 0}">
        <tr class="data-tr">
            <td colspan="15" style="text-align: center">暂无数据</td>
        </tr>
    </c:if>
    <c:if test="${page.list != null && page.list.size() != 0}">
        <c:forEach items="${page.list}" var="order" varStatus="status">
            <tr  class="data-tr" style="text-align: center">
                <td> ${status.index+1}</td>
                <td> <a href="${ctxsys}/PmShopInfo/shopinfo?id=${order.shopId}">${order.pmShopInfo.shopName}</a></td>
                <td>
                        ${order.pmShopInfo.shopCode}
                </td>
                <%--订单编号--%>
                <td>
                        ${order.orderNo}

                </td>
                <%--订单状态--%>
                <td>
                    <%--<c:if test="${order.status!=null&&order.status==1}">--%>
                        <%--等待买家付款--%>
                    <%--</c:if>--%>
                    <c:if test="${order.status!=null&&order.status==2}">
                        等待发货
                    </c:if>
                    <c:if test="${order.status!=null&&order.status==3}">
                        已发货
                    </c:if>
                    <c:if test="${order.status!=null&&order.status==4}">
                        已完成
                    </c:if>
                        <label style="color: red">
                        <c:if test="${order.refundOrderNo != null && !''.equals(order.refundOrderNo)}">
                            <c:if test="${order.status!=null&&order.status==6}">
                                已退款
                            </c:if>
                            <c:if test="${order.status==null||order.status!=6}">
                                退款中
                            </c:if>

                        </c:if>
                        </label>
                    <%--<c:if test="${order.status!=null&&order.status==5}">--%>
                        <%--已关闭--%>
                    <%--</c:if>--%>
                </td>


                <%--支付金额--%>
                <td>
                    <c:if test="${order.payType==6 || (order.payType>=60 && order.payType<=70)}">
                        --
                    </c:if>

                    <c:if test="${order.payType!=6 && (order.payType<60 || order.payType>70)}">
                        ${order.orderRealAmount}
                    </c:if>
                </td>
                <%--支付净额--%>
                <td>
                    <c:if test="${order.payType==6 || (order.payType>=60 && order.payType<=70)}">
                        --
                    </c:if>

                    <c:if test="${order.payType!=6 && (order.payType<60 || order.payType>70)}">
                        ${order.orderRealAmount}
                    </c:if>
                </td>
                    <%--手续费--%>
                <td>
                    <c:if test="${order.payType==6 || (order.payType>=60 && order.payType<=70)}">
                        --
                    </c:if>

                    <c:if test="${order.payType!=6 && (order.payType<60 || order.payType>70)}">
                        ${order.poundage}
                    </c:if>
                </td>
                <%--可提现金额--%>
                <td>
                    <c:if test="${order.payType==6 || (order.payType>=60 && order.payType<=70)}">
                        --
                    </c:if>

                    <c:if test="${order.payType!=6 && (order.payType<60 || order.payType>70)}">
                        ${order.extractAmount}
                    </c:if>
                </td>
                    <%--不可提现金额--%>
                <td>
                    <c:if test="${order.payType==6 || (order.payType>=60 && order.payType<=70)}">
                        ${order.orderRealAmount}
                    </c:if>

                    <c:if test="${order.payType!=6 && (order.payType<60 || order.payType>70)}">
                        --
                    </c:if>
                </td>
                <%--支付渠道--%>
                <td>
                    ${order.pmOpenPayWay.payWayName}
                </td>
                <%--支付方式--%>
                <td>
                        ${order.pmOpenPayWay.payRemark}
                    <c:if test="${order.payType == 56}">
                        <c:if test="${'ALIPAY'==order.isvScanType}">
                            （支付宝）
                        </c:if>
                        <c:if test="${'WXPAY'==order.isvScanType}">
                            （微信）
                        </c:if>
                        <c:if test="${'UNIONPAY'==order.isvScanType}">
                            （银联）
                        </c:if>
                        <c:if test="${'JDPAY'==order.isvScanType}">
                            （京东钱包）
                        </c:if>
                        <c:if test="${'QQPAY'==order.isvScanType}">
                            （QQ钱包）
                        </c:if>
                    </c:if>

                </td>
                <%--订单来源--%>
                <td>
                        ${fns:getSaleSourceByCode(order.saleSource)}
                    <%--<c:if test="${order.saleSource==5}">--%>
                            <%--收银端--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${order.saleSource == 6}">--%>
                        <%--微信小程序--%>
                    <%--</c:if>--%>

                </td>
                <td> <fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                <td>
                    <c:if test="${order.status!=null&&order.status==6}">
                        <fmt:formatDate value="${order.refundTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                    </c:if>
                </td>

                <td>
                     <a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${order.orderId}">明细</a>
                </td>
            </tr>
        </c:forEach>
    </c:if>
</table>

<div class="pagination">${page}</div>


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
                content: '${ctxsys}/Product/chooseShops?shopIds='+ $("#chooseShopId").val() ,
                btn: ['确定', '关闭'],
                yes: function(index, layero){ //或者使用btn1
                    debugger;
                    var content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                    var chooseNames = layero.find("iframe")[0].contentWindow.$('#shopNames').val();
                    if(content==""){
                        layer.msg("请选择一个门店");
                    }else{
                        $("#chooseShopId").val(content);
                        $("#shopName").val(chooseNames);
                        $("#shop-name-li").css("display","inline-block");
                        layer.close(index);
                    }
                }
            })
        }else{
            $("#chooseShopId").val("");
            $("#shopName").val("");
            $("#shop-name-li").css("display","none");
        }
    }

    //选择支付方式
    function choosePayWay(isAll){
        $(".isAll").val(isAll);

        if(isAll == 0){
            layer.open({
                type: 2,
                title: '支付方式列表',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['880px', '450px'],
                content: '${ctxsys}/Product/choosePayWay?chooseCodes='+ $("#payCodes").val() ,
                btn: ['确定', '关闭'],
                yes: function(index, layero){ //或者使用btn1
                    debugger;
                    var content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                    var chooseNames = layero.find("iframe")[0].contentWindow.$('#chooseNames').val();
                    if(content==""){
                        layer.msg("请选择一个门店");
                    }else{
                        $("#payCodes").val(content);
                        $("#payRemarks").val(chooseNames);
                        $("#pay-li").css("display","inline-block");
                        layer.close(index);
                    }
                }
            })
        }else{
            $("#payCodes").val("");
            $("#payRemarks").val("");
            $("#pay-li").css("display","none");
        }
    }


    $('#fromNewActionSbM').click(function(){
        $.ajax({
            type : "post",
            data:$('#searchForm').serialize(),
            url : "${ctxsys}/statement/orderExcel",
            success : function (data) {
                window.location.href=data;
                console.log(data)
                $('.check1').hide();
            }
        });
    });

    $('#all').click(function(){
        if($(this).is(':checked')){
            $('.kl').prop('checked',true).attr('checked',true);
            $('#all').prop('checked',true).attr('checked',true);
        }else {
            $('.kl').removeAttr('checked');
            $('#all').removeAttr('checked');
        }
    });

    $('body').on('click','.kl',function(){
        if ($('.kl').length==$('.kl[type=checkbox]:checked').length){
            $('#all').prop('checked',true).attr('checked',true);
        }else {
            $('#all').removeAttr('checked');
        }
    })


    $(function(){
        $('.check1').hide();
        $('body').on('click','.check-a1',function(){
            $('.check1').show();
        });

        $('body').on('click','.check-del1',function(){
            $('.check1').hide();
        });
    });
</script>


</body>
</html>