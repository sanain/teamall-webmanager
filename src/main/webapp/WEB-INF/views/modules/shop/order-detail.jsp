<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>订单详情</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/order-detail1.css">
    <%--<link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css">--%>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/order-detail1.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>

    <script>
        $(window.parent.document).find('.list-ul').find('ul').slideUp();
        $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>

    <style type="text/css">
        #charging-div{
            padding: 10px;
        }
        .charging-title{
            padding-left: 10px;
            font-weight: bold;
        }

        #submit-button{
            background-color: #393D49;
        }

        #submit-button:hover{
            color: rgb(120,120,120);
        }

        a{
            color: #009688;
        }
        .house-list-body>p a:hover{ color: #009688;}
        .pic-five .active {
            color: #009688;
        }
        .shop-msg ul li:nth-child(4), .shop-msg ul li:nth-child(5),
        .shop-msg ul li:nth-child(6),.shop-msg ul li:nth-child(7){
            width: 9.75%;
        }
    </style>
</head>
<body>
<div class="order">
    <div class="crumbs-div">
        <span>您的位置：</span>
        <a href="javascript:;">首页</a>
        >
        <a href="${ctxweb}/shop/PmShopOrders/list">已卖出商品</a>
        >
        <span>订单详情</span>
    </div>
    <!--状态图-->
    <div class="pic-five">
        <div class="tijiao <c:if test="${ebOrder.status==1||ebOrder.status==2||ebOrder.status==3||ebOrder.status==4}"> active </c:if> "><%--
                <div class="tijiao-div">

                </div>
                --%><span>提交订单</span>
            <div>
                <fmt:formatDate value="${ebOrder.createTime}" pattern="yyyy-MM-dd"/>  <br/>
                <fmt:formatDate value="${ebOrder.createTime}" type="time" />
            </div>
        </div>

        <div class="xian <c:if test="${ebOrder.status==1||ebOrder.status==2||ebOrder.status==3||ebOrder.status==4}"> active2 </c:if> " > >> </div>

        <div class="fukuan <c:if test="${ebOrder.status==2||ebOrder.status==3||ebOrder.status==4}"> active </c:if>">
            <%--<div class="fukuan-div">

            </div>
            --%><span>付款成功</span>
            <div>
                <fmt:formatDate value="${ebOrder.payTime}" pattern="yyyy-MM-dd"/>  <br/>
                <fmt:formatDate value="${ebOrder.payTime}" type="time" />
            </div>
        </div>

        <div class="xian  <c:if test="${ebOrder.status==2||ebOrder.status==3||ebOrder.status==4}"> active2 </c:if> "> >> </div>

        <div class="fahuo <c:if test="${ebOrder.status==3||ebOrder.status==4}"> active </c:if> ">
            <%--<div class="fahuo-div">

            </div>
            --%><span>商家发货</span>
            <div>
                <fmt:formatDate value="${ebOrder.sendTime}" pattern="yyyy-MM-dd"/>  <br/>
                <fmt:formatDate value="${ebOrder.sendTime}" type="time" />
            </div>
        </div>

        <div class="xian  <c:if test="${ebOrder.status==4}"> active2 </c:if> "> >> </div>
        <div class="shouhuo <c:if test="${ebOrder.status==4}"> active </c:if>">
            <%--<div class="shouhuo-div">
            </div>
            --%><span>已收货</span>
            <div>
                <fmt:formatDate value="${ebOrder.completionTime}" pattern="yyyy-MM-dd"/>  <br/>
                <fmt:formatDate value="${ebOrder.completionTime}" type="time" />
            </div>
        </div>
        <div class="xian <c:if test="${ebOrder.status==4}"> active2 </c:if>"> >> </div>

        <div class="wancheng <c:if test="${ebOrder.status==4}"> active </c:if>">
            <%--<div class="wancheng-div">
            </div>
            --%><span>订单完成</span>
            <div>
                <fmt:formatDate value="${ebOrder.completionTime}" pattern="yyyy-MM-dd"/>  <br/>
                <fmt:formatDate value="${ebOrder.completionTime}" type="time" />
            </div>
        </div>
    </div>
    <!--订单状态-->
    <div class="order-state" style="padding: 0px;height: 70px">
        <div style="height: 70px;padding: 20px 0px 20px 20px;">
            <p style="font-size: 16px;line-height:30px;width: auto; height:30px;float: left;display: block">当前订单状态：
                <c:if test="${ebOrder.status==1}"> 待付款
                    <%--<span class="shut-show">关闭交易</span>--%>
                </c:if>
                <c:if test="${ebOrder.status==2}"> 待发货</c:if>
                <c:if test="${ebOrder.status==3}"> 待收货</c:if>
                <c:if test="${ebOrder.status==7}"> 待评价</c:if>
                <c:if test="${ebOrder.status==4}"> 交易成功</c:if>
                <c:if test="${ebOrder.status==5}"> 已关闭 (<span><c:if test="${ebOrder.status==5}">${ebOrder.cancelReason}</c:if><c:if test="${ebOrder.status==5&&ebOrder.isBusinessDel==1}">${ebOrder.businessDelReason}</c:if></span>)</c:if>

                <c:if test="${ebOrder.refundOrderNo != null && !''.equals(ebOrder.refundOrderNo)}">
                    <c:if test="${ebOrder.status!=null&&ebOrder.status==6}">
                        已退款
                    </c:if>
                    <c:if test="${ebOrder.status==null||ebOrder.status!=6}">
                        退款中
                    </c:if>
                </c:if>

                <%-- <c:if test="${ebOrder.status==9}"> 退换货</c:if> --%></p>
            <input style="width: auto; height:30px; float: left;margin-left: 30px" type="button" onclick="openAlert()" id="submit-button" class="btn btn-primary col-md-offset-5" value="确定">
        </div>
    </div>

    <!--订单跟踪-->
    <div class="order-tail">
        <p>订单进展</p>

        <ul>
            <li>处理信息</li>
            <li>处理时间</li>
        </ul>
        <c:if test="${not empty ebOrder.createTime}">
            <ul>
                <li>订单提交成功</li>
                <li><fmt:formatDate value="${ebOrder.createTime}" type="both"/></li>
            </ul>
        </c:if>
        <c:if test="${not empty ebOrder.payTime}">
            <ul>
                <li>订单支付成功</li>
                <li><fmt:formatDate value="${ebOrder.payTime}" type="both"/></li>
            </ul>
        </c:if>
        <c:if test="${not empty ebOrder.sendTime}">
            <ul>
                <li>订单发货成功</li>
                <li><fmt:formatDate value="${ebOrder.sendTime}" type="both"/></li>
            </ul>
        </c:if>
        <c:if test="${not empty ebOrder.completionTime}">
            <ul>
                <li>订单完成</li>
                <li><fmt:formatDate value="${ebOrder.completionTime}" type="both"/></li>
            </ul>
        </c:if>
        <c:if test="${ebOrder.status==5&&ebOrder.isUserDel==1}">
            <ul>
                <li>订单关闭</li>
                <li><fmt:formatDate value="${ebOrder.userDelDate}" type="both"/></li>
            </ul>
        </c:if>
        <c:if test="${ebOrder.status==5&&ebOrder.isBusinessDel==1}">
            <ul>
                <li>订单关闭</li>
                <li><fmt:formatDate value="${ebOrder.businessDelDate}" type="both"/></li>
            </ul>
        </c:if>

        <c:if test="${ebOrder.status!=null&&ebOrder.status==6}">
            <ul>
                <li>订单退款</li>
                <li><fmt:formatDate value="${ebOrder.refundTime}" type="both"/></li>
            </ul>
        </c:if>
    </div>


    <!--订单信息-->
    <div class="order-msg">
        <c:if test="${(ebOrder.acceptName != null&&!''.equals(ebOrder.acceptName)) ||
                    (ebOrder.deliveryAddress != null&&!''.equals(ebOrder.deliveryAddress) )
                    || (ebOrder.telphone != null&&!''.equals(ebOrder.telphone))
                     || (ebOrder.invoiceTitle !=  null&&!''.equals(ebOrder.invoiceTitle))}">
            <p>订单详情</p>
            <ul>
                <li>收货信息</li>
                <li><span>收货人：</span><span>${ebOrder.acceptName}</span></li>
                <li><span>地  &nbsp;&nbsp;址：</span><span>${ebOrder.deliveryAddress}</span></li>
                <li><span>手  &nbsp;&nbsp;机：</span><span>${ebOrder.telphone}</span></li>
                <c:if test="${ebOrder.isLnvoice==1}">
                    <li><span>发票抬头：</span><span>${ebOrder.invoiceTitle}</span></li>
                </c:if>

            </ul>
        </c:if>

        <c:if test="${ebOrder.shippingMethod == 4 || ebOrder.shippingMethod == 5}">
            <c:if test="${ebOrder.status==2 || ebOrder.status==3||ebOrder.status==4||ebOrder.status==7||ebOrder.status==9}">
                <ul>
                    <li>配送信息</li>
                    <li><span>配送方式：</span>
                        <span>
                        <c:if test="${ebOrder.shippingMethod == 4}">
                            自提
                        </c:if>

                        <c:if test="${ebOrder.shippingMethod == 5}">
                            外卖
                        </c:if>
                    </span>
                    </li>
                    <c:if test="${ebOrder.shippingMethod == 5}">
                        <li><span>配&nbsp;送&nbsp;费：</span><span>¥<fmt:formatNumber type="number" value="${ebOrder.realFreight}" pattern="0.00" maxFractionDigits="2"/></span></li>
                        <li>
                            <span>配送人员：</span><span id="assignedStorePeople">${ebOrder.assignedStorePeople}</span>

                        </li>
                        <li>
                            <span>联系方式：</span><span id="assignedStorePeoplePhone">${ebOrder.assignedStorePeoplePhone}</span>
                        </li>
                        <li <c:if test="${ebOrder.status != 2}">style="display: none"</c:if>><span>选择配送人员：</span><a class="btn btn-primary" style=" background-color: #393D49;" href="javascript:;" onclick="openAlert();">选择</a></li>
                    </c:if>

                        <%--<c:if test="${ebOrder.shippingMethod == 4}">--%>
                        <%--<li><span>收&nbsp货&nbsp人：</span><span>${ebOrder.acceptName}</span></li>--%>
                        <%--<li><span>联系方式：</span><span>${ebOrder.telphone}</span></li>--%>
                        <%--</c:if>--%>

                    <li><span>备  &nbsp;&nbsp;注：</span>
                        <span>
                                ${ebOrder.postscript == null || ''.equals(ebOrder.postscript) ? "无":ebOrder.postscript}
                        </span>
                    </li>
                        <%--用来提交配送人员信息--%>
                    <form id="delivery-staff-form" style="display: none" class="form-horizontal" action="${ctxweb}/shop/PmShopOrders/orderedit" method="post" name="form2">
                        <input type="hidden" name="orderId" value="${ebOrder.orderId}"/>
                        <spand id="chooseId" style="display: block"></spand>
                        <input type="hidden" name="assignedStorePeople" id="assignedStorePeople-input">
                        <input type="hidden" name="assignedStorePeoplePhone" id="assignedStorePeoplePhone-input">
                    </form>
                        <%--<li><span>承运公司：</span><span>${ebOrder.logisticsCompany }</span></li>--%>
                        <%--<li>--%>
                        <%--<span>运单编号：</span><span>${ebOrder.expressNumber}</span>--%>
                        <%--<!-- class="look-a" --> <a  href="http://www.kuaidi.com/chaxun?com=${ebOrder.logisticsComCode}&nu=${ebOrder.expressNumber}">查看物流</a>--%>
                        <%--</li>--%>
                </ul>
            </c:if>
        </c:if>

        <%--当订单来源是收银端和小程序才显示--%>
        <c:if test="${ebOrder.saleSource == 5 ||  ebOrder.saleSource == 6}">
            <ul>
                <li>订单来源信息</li>
                <li>
                    <span>来&nbsp;&nbsp;源：</span>
                    <span>
                        <c:if test="${ebOrder.saleSource == 5}">
                            收银端
                        </c:if>
						<c:if test="${ebOrder.saleSource == 6}">
                            小程序
                        </c:if>
                    </span>
                </li>
            </ul>
        </c:if>

        <ul>
            <li>付款信息</li>
            <c:if test="${ebOrder.payStatus==1}">
                <li><span>支付方式：</span><span>
                        ${openPayWayByCode.payRemark}
                </span></li>
            </c:if>
            <li><span>商品金额：</span><span>¥<fmt:formatNumber type="number" value="${ebOrder.realAmount}" pattern="0.00" maxFractionDigits="2"/></span></li>
            <li><span>运费金额：</span><span>¥<fmt:formatNumber type="number" value="${ebOrder.realFreight}" pattern="0.00" maxFractionDigits="2"/></span></li>
            <li><span>应付金额：</span><span>¥<fmt:formatNumber type="number" value="${ebOrder.orderAmount-ebOrder.lovePayAmount-ebOrder.frozenLovePayAmount}" pattern="0.00" maxFractionDigits="2"/></span></li>
            <c:if test="${ebOrder.certificateName != null && !''.equals(ebOrder.certificateName)}">
                <li><span>优惠券名称：</span><span>${ebOrder.certificateName}</span></li>
                <li><span>优惠券折扣后金额：</span><span>¥<fmt:formatNumber type="number" value="${ebOrder.orderRealAmount}" pattern="0.00" maxFractionDigits="2"/></span></li>
            </c:if>

            <c:if test="${ebOrder.payType == 6}">
            <li><span>实付现金：</span><span>¥${ebOrder.cashReceipt}</span>
            <li><span>找零：</span><span>¥${ebOrder.giveChangeAmount}</span>
                </c:if>
        </ul>
    </div>


    <!--商品信息-->
    <div class="shop-msg">
        <p>商品详情</p>
        <div class="list-div">
            <ul class="list-top">
                <li>商品ID</li>
                <li>商品图片</li>
                <li>商品名称</li>
                <li>价格</li>
                <li
                        <c:if test="${!fns:isShowWeight()}">
                            style="display: none"
                        </c:if>
                >计量类型</li>
                <li>商品数量</li>
                <li>状态</li>
            </ul>
            <c:forEach items="${ebOrder.ebOrderitems}" var="ebOrderitems" varStatus="status">
                <ul class="list-body">
                    <li>
                            ${ebOrderitems.orderitemId}
                    </li>
                    <li>
                        <div class="img-box">
                            <img src="${ebOrderitems.productImg}" alt="">
                        </div>
                    </li>
                    <li>
                            ${ebOrderitems.productName}-${ebOrderitems.standardName}
                    </li>
                    <li>
                        ¥<fmt:formatNumber type="number" value="${ebOrderitems.realPrice}" pattern="0.00" maxFractionDigits="2"/>
                    </li>
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
                                <%--${ebOrderitems.measuringUnit == null || .measuringUnit==1 ? "公斤":"克"}--%>
                            </c:if>
                        </c:if>
                    </li>
                        <%--<li>--%>
                        <%--${ebOrderitems.goodsNums}--%>
                        <%--</li>--%>
                    <li>
                        <c:if test="${ebOrderitems.isSend==0}">未发货</c:if>
                        <c:if test="${ebOrderitems.isSend==1}">已发货</c:if>
                        <c:if test="${ebOrderitems.isSend==2}">已收货</c:if>
                        <c:if test="${ebOrderitems.isSend==3}">已评价</c:if>
                        <c:if test="${ebOrderitems.isSend==4}">已退货</c:if>
                        <c:if test="${ebOrderitems.isSend==5}">退货中</c:if>
                    </li>
                </ul>

                <div id="charging-div">
                    <span class="charging-title">加料详情：</span>
                    <c:if test="${ebOrderitemChargingList[status.index] == null || ebOrderitemChargingList[status.index].size() == 0}">
                        无
                    </c:if>
                    <c:if test="${ebOrderitemChargingList[status.index] != null && ebOrderitemChargingList[status.index].size() >0}">
                        <c:forEach var="charging" items="${ebOrderitemChargingList[status.index]}">
                            <span style="padding-left: 30px">${charging.lable}/${charging.sellPrice}</span>
                        </c:forEach>
                    </c:if>
                </div>

            </c:forEach>
        </div>
    </div>


    <!-- 模态框（Modal） -->
    <div class="modal fade" id="user-info-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        配送人员信息
                    </h4>
                </div>
                <form style="margin-top: 20px">
                    <div class="form-group row">
                        <label style="text-align: right;padding-right: 0px" for="modal-muser-name" class="col-sm-2 col-form-label">名字</label>
                        <div class="col-sm-9">
                            <input style="height: 30px;margin-right: 50px" type="text" class="form-control" id="modal-muser-name" placeholder="配送人员名字">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label style="text-align: right;padding-right: 0px" for="modal-muser-mobile" class="col-sm-2 col-form-label">联系方式</label>
                        <div class="col-sm-9">
                            <input style="height: 30px"  type="text" class="form-control" id="modal-muser-mobile" placeholder="联系方式">
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="chooseDeliveryStaff()">打开列表
                    </button>
                    <button type="button" class="btn btn-primary" onclick="submitOrder()">
                        确定
                    </button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>

        <!-- 模态框（Modal） -->
        <%--<div class="modal fade" id="user-info-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--%>
        <%--<div class="modal-dialog">--%>
        <%--<h4 class="modal-title" id="myModalLabel">--%>
        <%--模态框（Modal）标题--%>
        <%--</h4>--%>
        <%--<div class="modal-content">--%>


        <%--<div class="modal-content">--%>
        <%--<form style="margin-top: 20px">--%>
        <%--<div class="form-group row">--%>
        <%--<label for="modal-muser-name" class="col-sm-2 col-form-label">配送人员名字</label>--%>
        <%--<div class="col-sm-10">--%>
        <%--<input type="text" class="form-control" id="modal-muser-name" placeholder="配送人员名字">--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--<div class="form-group row">--%>
        <%--<label for="modal-muser-mobile" class="col-sm-2 col-form-label">联系方式</label>--%>
        <%--<div class="col-sm-10">--%>
        <%--<input type="text" class="form-control" id="modal-muser-mobile" placeholder="联系方式">--%>
        <%--</div>--%>
        <%--</div>--%>
        <%--</form>--%>
        <%--<div class="modal-footer">--%>
        <%--<button type="button" class="btn btn-default" onclick="chooseDeliveryStaff()">打开列表--%>
        <%--</button>--%>
        <%--<button type="button" class="btn btn-primary" onclick="submitOrder()">--%>
        <%--确定--%>
        <%--</button>--%>
        <%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭--%>
        <%--</button>--%>
        <%--</div>--%>
        <%--</div><!-- /.modal-content -->--%>
        <%--</div><!-- /.modal -->--%>
        <%--</div>--%>


    </div>
    <!--关闭交易-->
    <div class="shut">
        <div class="shut-box">

            <div class="shut-sel">
                <span>请选择关闭该交易的理由：</span>
                <select>
                    <option value="">请选择关闭理由</option>
                    <option value="">未及时付款</option>
                    <option value="">买家联系不上</option>
                    <option value="">谢绝还价</option>
                    <option value="">商品瑕疵</option>
                    <option value="">协商不一致</option>
                    <option value="">买家不想买</option>
                    <option value="">与买家协商一致</option>
                </select>
            </div>

            <p>请您在与买家达成一致的前提下，使用关闭交易这个功能呦！</p>
            <ul>
                <li>温馨提示：</li>
                <li>
                    <div>
                        1.为提升买家购物体验，您可以赠送买家门店优惠券；
                    </div>
                    <div>
                        2.拍下后减库存的商品，在关闭交易后，系统会自动恢复商品库存，但不会影响已下架商品的状态。
                    </div>
                </li>
            </ul>
            <div class="shut-btn">
                <a href="javascript:;">确定</a>
                <a class="shut-del" href="javascript:;">关闭</a>
            </div>
        </div>
    </div>
    <div class="look">
        <div class="look-box">
            <p>查看物流<img class="look-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <ul>
                <li>时间</li>
                <li>信息</li>
            </ul>
            <div class="look-msg">
                <ul>
                    <li></li>
                    <li></li>
                </ul>
            </div>
        </div>
    </div>
    <%--<div style="margin-bottom: 50px">--%>

    <%--</div>--%>
</body>
<script type="text/javascript">
    $(function(){
        //根据不同的订单状态显示不同的内容
        var orderStatus = '${ebOrder.status}';
        var shippingMethod = '${ebOrder.shippingMethod}';
        var isChang = false;

        //显示自提的未发货内容
        if(orderStatus == '2' && shippingMethod == '4'){
            $("#submit-button").val("确定");
            isChang = true;
        }
        //显示外卖的未发货内容
        if(orderStatus == '2' && shippingMethod == '5'){
            $("#submit-button").val("配送");
            isChang = true;
        }
        //显示自提的等待收货内容
        if(orderStatus == '3' && shippingMethod == '4'){
            $("#submit-button").val("已自提");
            isChang = true;
        }
        //显示外卖的等待收货内容
        if(orderStatus == '3' && shippingMethod == '5'){
            $("#submit-button").val("已送达");
            isChang = true;
        }

        if(!isChang){
            $("#submit-button").css("display","none")
        }


    });

    /**
     * 获得写入模态框
     */
    function getUserInfo(){
        $("#modal-muser-name").val($("#assignedStorePeople-input").val());
        $("#modal-muser-mobile").val($("#assignedStorePeoplePhone-input").val());
    }
    /*模态框的数据写回页面*/
    function writeUserInfoToForm(){
        $("#assignedStorePeople").val($("#modal-muser-name").val());
        $("#assignedStorePeople-input").val($("#modal-muser-name").val());
        $("#assignedStorePeoplePhone").val( $("#modal-muser-mobile").val());
        $("#assignedStorePeoplePhone-input").val( $("#modal-muser-mobile").val());
    }

    function openAlert(){
        if('${ebOrder.status}' == '2' && '${ebOrder.shippingMethod}' == '5'){
            if($("#assignedStorePeople-input").val() == ""){
                $("#user-info-modal").modal("show");
            }else{
                getUserInfo();
                $("#user-info-modal").modal("show");
                // submitOrder();
            }
        }else{
            submitOrder();
        }
    }


    function submitOrder(){

        if('${ebOrder.status}' == '2' && '${ebOrder.shippingMethod}' == '5'){
            if($("#modal-muser-name").val() == ""){
                alert("配送人员不能为空！");
                return false;
            }

            if(!(/^1[3456789]\d{9}$/.test($("#modal-muser-mobile").val()))){
                alert("联系方式有误，请重填");
                return false;
            }
        }

        $("#user-info-modal").modal("hide");
        writeUserInfoToForm();
        var prompt = "";

        var orderStatus = '${ebOrder.status}';
        var shippingMethod = '${ebOrder.shippingMethod}';
        var isChang = false;

        //显示自提的未发货提示
        if(orderStatus == '2' && shippingMethod == '4'){
            prompt="确定开始备货，等待客户自提！"
        }
        //显示外卖的未发货提示
        if(orderStatus == '2' && shippingMethod == '5'){
            prompt="确定开始配送！"
        }
        //显示自提的等待收货提示
        if(orderStatus == '3' && shippingMethod == '4'){
            prompt="确定客户已自提！"
        }
        //显示外卖的等待收货提示
        if(orderStatus == '3' && shippingMethod == '5'){
            prompt="确定已送达！";
        }

        var result = confirm(prompt);
        if(result){
            $("#delivery-staff-form").submit();
        }

    }
    //选择配送人员
    function chooseDeliveryStaff(){
        $("#user-info-modal").modal("hide");
        layer.open({
            type: 2,
            title: '配送人员列表',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['880px', '450px'],
            content: '${ctxweb}/shop/PmShopOrders/chooseDeliveryStaff?chooseShopUserId='+$("#chooseId").text()+"&shopId=${ebOrder.shopId}",
            btn: ['确定', '关闭'],
            yes: function(index, layero){ //或者使用btn1
                var shopUserId = layero.find("iframe")[0].contentWindow.$('#shopUserId').val();
                var username = layero.find("iframe")[0].contentWindow.$('#username').val();
                var phoneNumber = layero.find("iframe")[0].contentWindow.$('#phoneNumber').val();
                debugger;
                if(shopUserId==""){
                    layer.msg("请先选中一名配送人员");
                    // $("#productChargingIds").val(content);
                }else{
                    $("#chooseId").text(shopUserId);
                    $("#assignedStorePeople").text(username);
                    $("#assignedStorePeople-input").val(username);
                    $("#assignedStorePeoplePhone").text(phoneNumber);
                    $("#assignedStorePeoplePhone-input").val(phoneNumber);

                    layer.close(index);

                    //再次打开模态框
                    openAlert();
                }



            }
        });
    }
</script>
</html>