<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>已卖出商品</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale-comm.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
    <script src="${ctxStatic}/sbShop/js/sale-comm.js"></script>
    <style>
        body {
            background: #f5f5f5;
        }

        .house-div {
            background: #fff;
        }

        #searchForm, #inputForm {
            background: #fff;
        }

        .form-search label {
            margin-left: 0;
            margin-right: 10px;
        }

        .form-search .ul-form li {
            margin-left: 10px;
        }

        ul-form {
            margin-top: 10px;
        }

        tr {
            height: 35px;
            padding: 0 10px;
        }

        .nav-tabs>li.active>a {
            border-top: 3px solid #009688;
            color: #009688;
        }

        .nav-tabs>li>a {
            color: #000;
        }

        .pagination {
            padding-bottom: 25px;
        }

        .ibox-content {
            margin: 0 30px;
        }

        body {
            background: #f5f5f5;
        }

        .house-list-body .list-right li:nth-child(1) div {
            line-height: normal;
            display: inline-block;
            position: relative;
            /* 	top: 11px; */
        }

        body .house-list-top li:nth-child(1) {
            width: 40%
        }

        a {
            color: #009688;
        }

        .house-list-body>p a:hover {
            color: #009688;
        }

        #daochu, #btnSubmit {
            width: 80px;
            float: left;
            background: #393D49;
            margin-right:10px;
        }

        #btnSubmit {
            margin-left: 20px;
        }

        .house {
            padding-top: 0px;
        }
        .house-list-body .list-left ul li:nth-child(3),.house-list-body .list-left ul li:nth-child(2),
        .house-list-body .list-left ul li:nth-child(4){
            width: 11%;
            padding-top: 15px;
        }
        body .house-list-top li:nth-child(1){
            width: 37%;
        }
        .house-list-top li:nth-child(4),.house-list-top li:nth-child(3) {
            width: 8%;
        }
        .house-list-top li:nth-child(2){
            width: 10%;
        }
    </style>
    <script>
        $(window.parent.document).find('.list-ul').find('ul').slideUp();
        $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
</head>
<script type="text/javascript">
    function page(n, s) {
        if (n) $("#pageNo").val(n);
        if (s) $("#pageSize").val(s);
        $("#searchForm").attr("action", "${ctxweb}/shop/PmShopOrders/list");
        $("#searchForm").submit();
        return false;
    }
    function shutSelTy() {
        var divid = $(".divid").val();
        var shutSel = $("#shutSel").val();
        $.ajax({
            type : "POST",
            url : "${ctxweb}/shop/PmShopOrders/coderc",
            data : {
                divid : divid,
                shutSel : shutSel
            },
            success : function(data) {
                if (data = '00') {
                    location.href = "${ctxweb}/shop/PmShopOrders/list";
                } else {
                    alert("关闭订单失败！");
                }
            }
        });
    }
    $(function() {
        $('body').on('click', '.chongzhi', function() {
            $('.house-div input').val('');
            $('.house-div select option:nth-child(1)').attr('selected', 'selected');
        });
        $('body').on('click', '#daochu', function() {
            $.ajax({
                type : "POST",
                data : $('#searchForm').serialize(),
                url : "${ctxweb}/shop/PmShopOrders/exselOrder",
                success : function(data) {
                    window.location.href = data;
                }
            });
        });
    })
</script>
<body>

<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
    <span>当前位置：</span><span>交易管理 - </span><span style="color:#009688;">订单列表</span>
</div>


<input type="hidden" class="divid">
<div class="house">
    <form action="" id="searchForm" method="post">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
        <input id="pageSize" name="pageSize" type="hidden"
               value="${page.pageSize}" />
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
                        callback="page();" />
        <div class="house-div">
            <ul>
                <li>商品名称：</li>
                <li><input type="text" name="name" value="${name}"></li>
            </ul>
            <ul>
                <li>订单编号：</li>
                <li><input type="text" name="orderNo"
                           value="${ebOrder.orderNo}"></li>
            </ul>
            <ul>
                <li>成交时间：</li>
                <li><input id="LAY_demorange_s" type="text" name="startTime"
                           value="${startTime}"> <span>到</span> <input
                        id="LAY_demorange_e" type="text" name="stopTime"
                        value="${stopTime}"></li>
            </ul>
            <ul>
                <li>收货人手机：</li>
                <li><input type="text" name="telphone" id="telphone"
                           value="${fns:replaceMobile(ebOrder.telphone)}"></li>
            </ul>
            <ul>
                <li>订单状态：</li>
                <li><select name="status">
                    <option value=""<c:if test="${empty status}"> selected="selected"</c:if>>全部</option>
                    <option value="1" <c:if test="${status==1 }"> selected="selected"</c:if>>待付款</option>
                    <option value="2" <c:if test="${status==2 }"> selected="selected"</c:if>>待发货</option>
                    <option value="3" <c:if test="${status==3 }"> selected="selected"</c:if>>待收货</option>
                    <option value="4" <c:if test="${status==4 }"> selected="selected"</c:if>>交易成功</option>
                    <option value="5" <c:if test="${status==5 }"> selected="selected"</c:if>>已关闭</option>
                    <option value="6" <c:if test="${status==6 }"> selected="selected"</c:if>>已退款</option>
                </select>
                </li>
            </ul>

            <ul class="sold-out">
                <li>支付方式：</li>
                <li>
                    <select name="payType">
                        <option value="">全部</option>
                        <option <c:if test="${payType==1 }"> selected="selected"</c:if> value="7">余额支付</option>
                        <option <c:if test="${payType==2 }"> selected="selected"</c:if> value="57">微信支付</option>
                        <option <c:if test="${payType==3 }"> selected="selected"</c:if> value="56">扫码付 </option>
                        <option <c:if test="${payType==6 }"> selected="selected"</c:if> value="6">现场支付 </option>
                        <option <c:if test="${payType==7 }"> selected="selected"</c:if> value="55">收银扫码余额支付 </option>
                    </select>
                </li>

            </ul>
            <ul class="sold-out two-btn-ul">
                <li style="width: 200px">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>

                    <input type="button" id="daochu" value="导出" class="btn btn-primary daochu">
                </li>
            </ul>
        </div>

    </form>

    <div style="background:#fff;">
        <ul class="house-nav">
            <li <c:if test="${empty status}"> class="active" </c:if> ><a href="${ctxweb}/shop/PmShopOrders/list">全部订单</a></li>
            <li <c:if test="${status==1}"> class="active" </c:if> ><a href="${ctxweb}/shop/PmShopOrders/list?status=1">待付款</a></li>
            <li <c:if test="${status==2}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/list?status=2">待发货</a></li>
            <li <c:if test="${status==3}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/list?status=3">待收货</a></li>
            <%--<li <c:if test="${status==6}"> class="active" </c:if>> <a href="${ctxweb}/shop/PmShopOrders/list?status=6">退货中</a></li>--%>
            <%--<li <c:if test="${isEvaluation==0&&status==4&&iv==1}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/list?isEvaluation=0&status=4&iv=1">待评价</a></li>--%>
            <li <c:if test="${status==4&&iv==0}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/list?status=4&iv=0">交易成功</a></li>
            <li <c:if test="${status==5}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/list?status=5">已关闭</a></li>
            <li <c:if test="${status==6}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/list?status=6">已退款</a></li>
        </ul>
        <div style="margin-top:15px;padding:0 20px;">
            <ul class="house-list-top">
                <li>商品</li>
                <li>单价（元）</li>
                <li
                        <c:if test="${!fns:isShowWeight()}">
                            style="display: none"
                        </c:if>
                >计量类型</li>
                <li>数量</li>
                <li>买家</li>
                <li>交易状态</li>
                <li>实收款（应付款）（元）</li>
            </ul>

            <div class="list-box">
                <c:forEach items="${page.list}" var="orderList" varStatus="status">

                    <div class="house-list-body">
                        <input id="id" name="id" type="hidden" value="${orderList.orderId}"/>
                        <p>
                    <span class="checkbox1">
                        <input type="checkbox">
                        
                    </span>
                            <span>订单编号：<a href="${ctxweb}/shop/PmShopOrders/orderDetail?orderId=${orderList.orderId}">${orderList.orderNo}</a></span>
                            <span>成交时间：<fmt:formatDate value="${orderList.createTime}" type="both"/> </span>
                            <c:if test="${orderList.status!=null&&orderList.status==6}">
                                <span>退款时间：<fmt:formatDate value="${orderList.refundTime}" type="both"/> </span>
                            </c:if>
                        </p>
                        <ul class="list-left">
                            <c:forEach items="${orderList.ebOrderitems}" var="ebOrderitems" >
                                <li>
                                    <ul>
                                        <li>
                                            <div class="img-kuang">
                                                <img src="${ebOrderitems.productImg}" alt="">
                                            </div>
                                            <u>${ebOrderitems.productName}
                                                <p><c:if test="${ not empty ebOrderitems.standardName}">${ebOrderitems.standardName}</c:if></p>
                                            </u>
                                        </li>
                                        <li>¥<b><fmt:formatNumber type="number" value="${ebOrderitems.realPrice}" pattern="0.00" maxFractionDigits="2"/></b></li>
                                        <li
                                                <c:if test="${!fns:isShowWeight()}">
                                                    style="display: none"
                                                </c:if>
                                        >${ebOrderitems.measuringType == null || ebOrderitems.measuringType==1 ? "件":"重量"}</li>
                                        <li>
                                                ${fns:replaceStoreNum(ebOrderitems.measuringType,ebOrderitems.measuringUnit,ebOrderitems.goodsNums)}
                                            <c:if test="${fns:isShowWeight()}">
                                                <c:if test="${ebOrderitems.measuringType != null && ebOrderitems.measuringType==2}">
                                                    <c:if test="${ebOrderitems.measuringUnit == 1}">
                                                        公斤
                                                    </c:if>
                                                    <c:if test="${ebOrderitems.measuringUnit == 2}">
                                                        克
                                                    </c:if>
                                                    <c:if test="${ebOrderitems.measuringUnit == 3}">
                                                        斤
                                                    </c:if>
                                                    <%--${ebOrderitems.measuringUnit == null || ebOrderitems.measuringUnit==1 ? "公斤":"克"}--%>
                                                </c:if>
                                            </c:if>
                                        </li>
                                    </ul>
                                </li>
                            </c:forEach>
                        </ul>
                        <ul class="list-right">
                            <li>
                                <div>
                                    <span>${fns:getUser(orderList.userId).username}</span>
                                    <span>
                                <c:if test="${ebUserList[status.index].shopShoppingId != null}">
                                    ${fns:replaceMobile(orderList.mobile)}
                                </c:if>

                                <c:if test="${ebUserList[status.index].shopShoppingId == null}">
                                    ${orderList.mobile}
                                </c:if>

                            </span>
                                </div>
                            </li>
                            <li>

                                <c:choose>
                                <c:when test="${orderList.status==1}">
                                <div>
                                    </c:when>
                                    <c:otherwise>
                                    <div class="one">
                                        </c:otherwise>
                                        </c:choose>
                                        <span>
	                            <c:if test="${orderList.status==1}"> 待付款<br><a class="shut-show" href="javascript:;">关闭交易</a></c:if>
		                        <c:if test="${orderList.status==2}"> 待发货</c:if>
		                        <c:if test="${orderList.status==3}"> 待收货</c:if>
		                        <c:if test="${orderList.status==7}"> 待评价</c:if>
		                        <c:if test="${orderList.status==4}"> 交易成功</c:if>
		                        <c:if test="${orderList.status==5}"> 已关闭</c:if>
                                <c:if test="${orderList.refundOrderNo != null && !''.equals(orderList.refundOrderNo)}">
                                    <c:if test="${orderList.status!=null&&orderList.status==6}">
                                        已退款
                                    </c:if>
                                    <c:if test="${orderList.status==null||orderList.status!=6}">
                                        退款中
                                    </c:if>
                                </c:if>
		                        <c:if test="${orderList.status==9}"> 退换货</c:if>
		                     </span>
                                    </div>
                            </li>
                            <li>
                                <div>
                                    <span>¥<fmt:formatNumber type="number" value="${orderList.orderRealAmount}" pattern="0.00" maxFractionDigits="2"/>&nbsp;(<fmt:formatNumber type="number" value="${orderList.orderAmount}" pattern="0.00" maxFractionDigits="2"/>)</span>
                                    <p>（含配送费：¥${orderList.realFreight}）</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </c:forEach>
                <!-- <div class="house-list-body">
                    <p>
                        <span class="checkbox">
                            <input type="checkbox">
                            <label><i></i></label>
                        </span>
                        <span>订单编号：<a href="order-detail2.html">1648954654654546165</a></span>
                        <span>成交时间：2017-02-12 11:07:39</span>
                    </p>
                    <ul class="list-left">
                        <li>
                            <ul>
                                <li>
                                    <div class="img-kuang">
                                        <img src="images/logo.png" alt="">
                                    </div>
                                    <u>商品名称</u>
                                </li>
                                <li>¥<b>23.00</b></li>
                                <li>3</li>
                            </ul>
                        </li>

                    </ul>
                    <ul class="list-right">
                        <li>13566645559</li>
                        <li>
                                待发货
                        </li>
                        <li>
                            <div>
                                <span>¥600.00</span>
                                <p>（含快递：¥0.00）</p>
                            </div>
                        </li>
                    </ul>
                </div> -->

                <!-- <div class="house-list-body">
                    <p>
                        <span class="checkbox">
                            <input type="checkbox">
                            <label><i></i></label>
                        </span>
                        <span>订单编号：<a href="order-detail3.html">1648954654654546165</a></span>
                        <span>成交时间：2017-02-12 11:07:39</span>
                    </p>
                    <ul class="list-left">
                        <li>
                            <ul>
                                <li>
                                    <div class="img-kuang">
                                        <img src="images/logo.png" alt="">
                                    </div>
                                    <u>商品名称</u>
                                </li>
                                <li>¥<b>23.00</b></li>
                                <li>3</li>
                            </ul>
                        </li>

                    </ul>
                    <ul class="list-right">
                        <li>13566645559</li>
                        <li>
                                待收货
                        </li>
                        <li>
                            <div>
                                <span>¥600.00</span>
                                <p>（含快递：¥0.00）</p>
                            </div>
                        </li>
                    </ul>
                </div> -->

                <!--  <div class="house-list-body">
                     <p>
                         <span class="checkbox">
                             <input type="checkbox">
                             <label><i></i></label>
                         </span>
                         <span>订单编号：<a href="order-detail4.html">1648954654654546165</a></span>
                         <span>成交时间：2017-02-12 11:07:39</span>
                     </p>
                     <ul class="list-left">
                         <li>
                             <ul>
                                 <li>
                                     <div class="img-kuang">
                                         <img src="images/logo.png" alt="">
                                     </div>
                                     <u>商品名称</u>
                                 </li>
                                 <li>¥<b>23.00</b></li>
                                 <li>3</li>
                             </ul>
                         </li>

                     </ul>
                     <ul class="list-right">
                         <li>13566645559</li>
                         <li>
                                 待评价
                         </li>
                         <li>
                             <div>
                                 <span>¥600.00</span>
                                 <p>（含快递：¥0.00）</p>
                             </div>
                         </li>
                     </ul>
                 </div> -->

                <!--  <div class="house-list-body">
                     <p>
                         <span class="checkbox">
                             <input type="checkbox">
                             <label><i></i></label>
                         </span>
                         <span>订单编号：<a href="order-detail5.html">1648954654654546165</a></span>
                         <span>成交时间：2017-02-12 11:07:39</span>
                     </p>
                     <ul class="list-left">
                         <li>
                             <ul>
                                 <li>
                                     <div class="img-kuang">
                                         <img src="images/logo.png" alt="">
                                     </div>
                                     <u>商品名称</u>
                                 </li>
                                 <li>¥<b>23.00</b></li>
                                 <li>3</li>
                             </ul>
                         </li>

                     </ul>
                     <ul class="list-right">
                         <li>13566645559</li>
                         <li>
                                 交易成功
                         </li>
                         <li>
                             <div>
                                 <span>¥600.00</span>
                                 <p>（含快递：¥0.00）</p>
                             </div>
                         </li>
                     </ul>
                 </div> -->

                <!--  <div class="house-list-body">
                     <p>
                         <span class="checkbox">
                             <input type="checkbox">
                             <label><i></i></label>
                         </span>
                         <span>订单编号：<a href="order-detail6.html">1648954654654546165</a></span>
                         <span>成交时间：2017-02-12 11:07:39</span>
                     </p>
                     <ul class="list-left">
                         <li>
                             <ul>
                                 <li>
                                     <div class="img-kuang">
                                         <img src="images/logo.png" alt="">
                                     </div>
                                     <u>商品名称</u>
                                 </li>
                                 <li>¥<b>23.00</b></li>
                                 <li>3</li>
                             </ul>
                         </li>

                     </ul>
                     <ul class="list-right">
                         <li>13566645559</li>
                         <li>
                            已关闭
                         </li>
                         <li>
                             <div>
                                 <span>¥600.00</span>
                                 <p>（含快递：¥0.00）</p>
                             </div>
                         </li>
                     </ul>
                 </div> -->
            </div>
            <!--分页-->
            <div class="pagination">
                ${page}
            </div>
        </div>

        <!--关闭交易-->
        <div class="shut">
            <div class="shut-box">

                <div class="shut-sel">
                    <span>请选择关闭该交易的理由：</span>
                    <select id="shutSel">
                        <option value="请选择关闭理由">请选择关闭理由</option>
                        <option value="未及时付款">未及时付款</option>
                        <option value="买家联系不上">买家联系不上</option>
                        <option value="谢绝还价">谢绝还价</option>
                        <option value="商品瑕疵">商品瑕疵</option>
                        <option value="协商不一致">协商不一致</option>
                        <option value="买家不想买">买家不想买</option>
                        <option value="与买家协商一致">与买家协商一致</option>
                    </select>
                </div>
                <p>请您在与买家达成一致的前提下，使用关闭交易这个功能呦！</p>
                <ul>
                    <li>温馨提示：</li>
                    <li>
                        <div>1.为提升买家购物体验，您可以赠送买家门店优惠券；</div>
                        <div>2.拍下后减库存的商品，在关闭交易后，系统会自动恢复商品库存，但不会影响已下架商品的状态。</div>
                    </li>
                </ul>
                <div class="shut-btn">
                    <a href="javascript:;" onclick="shutSelTy()">确定</a> <a
                        class="shut-del" href="javascript:;">关闭</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>