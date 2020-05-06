<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>订单详情</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <style>
    	body p{margin-top:0;}
        ul{list-style: none}
        .order{padding: 20px}
        .order-state{padding: 20px;border: 1px solid #DCDCDC;}
        .order-state>p{font-size: 16px}
        .order-state span{color: #666666;cursor: pointer}
        .order-state .shi{color: #FF6600}
        .order-tail{border: 1px solid #DCDCDC;overflow: hidden;margin-top: 20px}
        .order-tail>p{height: 35px;line-height: 35px;font-size: 16px;background: #f0f0f0;padding-left: 20px}
        .order-tail ul{overflow:hidden;padding-left: 20px;color: #666666}
        .order-tail ul li{float:left;width:40%}
        .order-tail ul li:nth-child(1){color: #333333;margin-bottom: 10px}
        .order-msg{border: 1px solid #DCDCDC;margin-top: 20px}
        .order-msg>p{height: 35px;line-height: 35px;font-size: 16px;background: #f0f0f0;padding-left: 20px}
        .order-msg ul{color: #666666;border-bottom: 1px solid #DCDCDC;padding-bottom: 5px;margin: 0 20px 10px;}
        .order-msg ul:last-child{border-bottom: none}
        .order-msg ul li{line-height: 30px}
        .order-msg ul li:nth-child(1){color: #333333;margin-bottom: 10px}
        .look-a{display: inline-block;height: 30px;line-height: 30px;width: 90px;text-align: center;color: #ffffff;background: #78A7FF;border-radius: 5px;margin-left: 5px}
        .shop-msg{border: 1px solid #DCDCDC;margin-top: 20px}
        .shop-msg>p{height: 35px;line-height: 35px;font-size: 16px;background: #f0f0f0;padding-left: 20px}
        .list-div{margin: 20px;border: 1px solid #DCDCDC}
        .shop-msg ul{overflow: hidden;text-align: center;margin-bottom: 0;border-bottom: 1px solid #DCDCDC;margin-top:0;padding-left:0}
        .list-div ul:last-child{border-bottom: none}
        .shop-msg ul li{float: left;    box-sizing: border-box;}
        .shop-msg ul li:nth-child(1){width:9% }
        .shop-msg ul li:nth-child(2){width:17% }
        .shop-msg ul li:nth-child(3){width:34% }
        .shop-msg ul li:nth-child(4){width:10% }
        .shop-msg ul li:nth-child(5){width:10% }
        .shop-msg ul li:nth-child(6){width:10% }
         .shop-msg ul li:nth-child(7){width:10% }
        .list-top{height: 30px;line-height: 30px;background: #f0f0f0}
        .img-box{width: 80px;height: 70px;overflow: hidden;border: 1px solid #DCDCDC;margin:10px auto 0;}
        .list-body li{border-left: 1px solid #DCDCDC;line-height: 90px;height: 90px}
        .list-body li:first-child{border-left: none}
        .list-body li:nth-child(4){color: #FF6600}
        .shut{display:none;position: fixed;top: 0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 100}
        .shut-box{width: 450px;height: 275px;padding: 20px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-top: -137px;margin-left: -200px}
        .shut-box>p{background: #f0f0f0;text-align: center;height: 30px;line-height: 30px;}
        .shut-box select{width: 160px;height: 30px;border: 1px solid #DCDCDC;border-radius: 3px;padding-left: 10px;outline: none}
        .shut-sel{padding-left: 15px}
        .shut-btn{text-align: center;margin-top: 20px}
        .shut-btn a{display: inline-block;height: 30px;width: 80px;background: #78A7FF;color: #ffffff;border-radius: 5px;line-height: 30px}
        .shut-btn a:nth-child(1){margin-right: 10px}
        .shut-btn a:nth-child(2){margin-left: 10px}
        .shut ul{padding-left: 15px;margin-top: 20px}
        .shut ul li:nth-child(1){color: #ff6600}
        .look{display:none;position: fixed;top: 0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 100}
        .look-box{width: 550px;height: 310px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-top: -155px;margin-left: -225px;overflow: hidden}
        .look-box>p{height: 35px;line-height: 35px;background: #f0f0f0;text-align: center;position: relative}
        .look-box>p img{position: absolute;right: 15px;top: 12px;cursor: pointer}
        .look-msg{height: 235px;overflow-y: auto}
        .look-box ul{overflow: hidden}
        .look-box ul li{float: left;width: 50%;text-align: center}
        .look-msg ul li:nth-child(2){text-align: left}
    </style>
    <script>
        $(function(){
            $('.shut-show').click(function(){
                $('.shut').show();
            });
            $('.shut-del').click(function(){
                $('.shut').hide();
            });

            $('.look-a').click(function(){
                $('.look').show()
            });
            $('.look-del').click(function(){
                $('.look').hide()
            });
        })
    </script>
</head>
<body>
    <div class="order">

        <!--订单状态-->
        <div class="order-state">
            <p>当前订单状态：
                <c:if test="${ebOrder.status==null}">等待买家付款</c:if>
                <c:if test="${ebOrder.status==1}">等待买家付款</c:if>
                <c:if test="${ebOrder.status==2}">等待发货</c:if>
                <c:if test="${ebOrder.status==3}">已发货,待收货</c:if>
                <c:if test="${ebOrder.status==4}">交易成功，已完成</c:if>
                <c:if test="${ebOrder.status==5}">已关闭</c:if>
                <c:if test="${not empty ebOrder.refundOrderNo}">
                    <c:if test="${ebOrder.status!=null&&ebOrder.status==6}">
                        已退款
                    </c:if>
                    <c:if test="${ebOrder.status==null||ebOrder.status!=6}">
                        退款中
                    </c:if>
                </c:if>
            </p>
        </div>
        <!--订单跟踪-->
         <div class="order-tail">
            <p>订单跟踪</p>
            <ul>
                <li>处理信息</li>
                <li>处理时间</li>
            </ul>
            <c:if test="${not empty ebOrder.createTime}">
            <ul>
                <li>订单提交成功</li>
                <li>${ebOrder.createTime}</li>
            </ul>
            </c:if>
            <c:if test="${not empty ebOrder.payTime}">
            <ul>
                <li>订单支付成功</li>
                <li>${ebOrder.payTime}</li>
            </ul>
            </c:if>
            <c:if test="${not empty ebOrder.sendTime}">
            <ul>
                <li>订单发货成功</li>
                <li>${ebOrder.sendTime}</li>
            </ul>
            </c:if>
            <c:if test="${not empty ebOrder.completionTime}">
            <ul>
                <li>订单完成</li>
                <li>${ebOrder.completionTime}</li>
            </ul>
            </c:if>

             <c:if test="${not empty ebOrder.refundTime}">
                 <ul>
                     <li>订单退款</li>
                     <li>${ebOrder.refundTime}</li>
                 </ul>
             </c:if>
        </div>
          <!--订单信息-->
        <div class="order-msg">
            <p>订单信息</p>
            <c:if test="${ebOrder.onoffLineStatus==1||ebOrder.onoffLineStatus==4}">
            <ul>
                <li>收货信息</li>
                <li><span>收货人：</span><span>${ebOrder.acceptName}</span></li>
                <li><span>地  &nbsp;&nbsp;址：</span><span>${ebOrder.deliveryAddress}</span></li>
                <li><span>手  &nbsp;&nbsp;机：</span><span>${ebOrder.telphone}</span></li>
            </ul>
            <c:if test="${ebOrder.status==3||ebOrder.status==4||ebOrder.status==7||ebOrder.status==9}">
             <ul>
                <li>配送信息</li>
                <li><span>配送方式：</span><span>快递</span></li>
                <li><span>运&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;费：</span><span>¥${ebOrder.realFreight}</span></li>
                <li><span>承运公司：</span><span>${ebOrder.logisticsCompany }</span></li>
                <li>
                    <span>运单编号：</span><span>${ebOrder.expressNumber }</span>
                  <!-- class="look-a" --> <a  href="http://www.kuaidi.com/chaxun?com=${ebOrder.logisticsComCode}&nu=${ebOrder.expressNumber}">查看物流</a>
                </li>
            </ul>
            </c:if>
            </c:if>
             <c:if test="${ebOrder.isLnvoice == 1 }">
				     <ul>
		                <li>发票信息</li>
		                <li><span>发票抬头：</span><span>${ebOrder.invoiceTitle}</span></li>
		                <li><span>开具类型：</span><span><c:if test="${ebOrder.invoiceStatus == 1 }"></c:if>个人及事业单位<c:if test="${ebOrder.invoiceStatus == 2 }">企业</c:if> </span></li>
		                <li><span>发送邮箱：</span><span>${ebOrder.invoicePostEmail }</span></li>
		                <li><span>发送状态：</span><span><c:if test="${ebOrder.invoiceStatus == 0 }"></c:if>未发送<c:if test="${ebOrder.invoiceStatus == 1 }">已发送</c:if> </span></li>
		                <li><span>纳税人识别号：</span><span>${ebOrder.invoicePeopleNo }</span></li>
		            </ul>
            	</c:if>
            <ul>
                <li>付款信息</li>
                 <c:if test="${ebOrder.payStatus==1}">
                <li><span>支付方式：</span><span>
                    ${fns:getSimplePayRemark(ebOrder.payType)}
                <%--<c:if test="${ebOrder.payType==1}">货到付款</c:if>--%>
                <%--<c:if test="${ebOrder.payType==2}">支付宝支付</c:if>--%>
                <%--<c:if test="${ebOrder.payType==3}">快钱支付</c:if>--%>
                <%--<c:if test="${ebOrder.payType==4}">银联支付</c:if>--%>
                <%--<c:if test="${ebOrder.payType==5}">微信支付</c:if>--%>
                <%--<c:if test="${ebOrder.payType==6}">现场支付</c:if>--%>
                <%--<c:if test="${ebOrder.payType==7}">余额支付</c:if>--%>
                <%--<c:if test="${ebOrder.payType==8}">汇卡支付</c:if>--%>
                <%--<c:if test="${ebOrder.payType==9}">易联支付 </c:if>--%>
				<%--<c:if test="${ebOrder.payType==10}">通联支付 </c:if>--%>
				<%--<c:if test="${ebOrder.payType==52}">H5微信支付</c:if>--%>

                 </span></li>
                 </c:if>
                <c:if test="${ebOrder.onoffLineStatus==1||ebOrder.onoffLineStatus==4}">
                <li><span>商品金额：</span><span>¥${ebOrder.realAmount}</span></li>
                <li><span>运费金额：</span><span>¥${ebOrder.realFreight}</span></li>
                </c:if>
                <li><span>应付金额：</span><span>¥
                <fmt:formatNumber type="number" value="${ebOrder.orderAmount-ebOrder.certificateAmount}" pattern="0.00" maxFractionDigits="2"/> 
			   
			    </span></li>
			        <li><span>优惠金额：</span><span>¥ ${ebOrder.certificateAmount }</span></li>
			     <c:if test="${ebOrder.lovePayGain==1}"><%-- ${fns:getDictLabel(value, type, defaultValue)} --%>
                   <li><span>流向：</span><span>${frozenLoveLog.objName}<%-- ${fns:getDictValue('pointsMallLoveAccount', 'gyconfig', '')} --%></span></li>
                 </c:if>
                 <c:if test="${ebOrder.lovePayGain==2}">
                   <li><span>流向：</span><span>${fns:getShopUser(ebOrder.shopId).mobile}</span></li>
                 </c:if>
                 <c:if test="${ebOrder.type==4}">
                  <li><span>消耗积分：</span><span>${ebOrder.lovePayCount}</span></li>
                  <li><span>消耗冻结积分：</span><span>${ebOrder.frozenLovePayCount}</span></li>
                 </c:if>
            </ul>

        </div>
          <c:if test="${ebOrder.onoffLineStatus==1||ebOrder.onoffLineStatus==4}">
        <!--商品信息-->
        <div class="shop-msg">
            <p>商品信息</p>
            <div class="list-div">
                <ul class="list-top">
                    <li>明细</li>
                    <li>商品图片</li>
                    <li>商品名称</li>
                    <li>规格</li>
                    <li>价格</li>
                    <li>商品数量</li>
                    <li>让利比</li>
                </ul>
                <c:forEach items="${ebOrder.ebOrderitems}" var="ebOrderitems">
                <ul class="list-body">
                    <li>
                       ${ebOrderitems.orderitemId}
                    </li>
                    <li>
                        <div class="img-box">
                            <img src="${ebOrderitems.productImg}" alt="" style="width: 83px;height: 67px;">
                        </div>
                    </li>
                    <li>
                        	${ebOrderitems.productName}
                    </li>
                    <li>${ebOrderitems.standardName}</li>
                    <li>
                        ¥${ebOrderitems.realPrice}
                    </li>
                    <li>
                        ${ebOrderitems.goodsNums}
                    </li>
                    <li>${ebOrderitems.returnRatio}%</li>
                </ul>
                </c:forEach>
            </div>
        </div>
        </c:if>
  </div>
    <!--关闭交易-->
    <div class="shut">
        <div class="shut-box">
            <p>请您在与买家达成一致的前提下，使用关闭交易这个功能呦！</p>
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
            <div class="shut-btn">
                <a href="javascript:;">确定</a>
                <a class="shut-del" href="javascript:;">关闭</a>
            </div>
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
        </div>
    </div>
    <!--查看物流-->
    <div class="look">
        <div class="look-box">
            <p>查看物流<img class="look-del" src="images/xxx-rzt.png" alt=""></p>
            <ul>
                <li>时间</li>
                <li>信息</li>
            </ul>
            <div class="look-msg">

                <ul>
                    <li>2017-02-08 13:07:23</li>
                    <li>【富仕办事处】的收件员【富仕办13173799123】已收件</li>
                </ul>
                <ul>
                    <li>2017-02-08 17:38:16</li>
                    <li>快件已到达【椒江路桥】 扫描员是【张仙玉】上一站是【富仕办事处】</li>
                </ul>
                <ul>
                    <li>2017-02-08 18:04:33</li>
                    <li>【椒江路桥】已进行装袋扫描</li>
                </ul>
                <ul>
                    <li>2017-02-08 18:04:34</li>
                    <li>由【椒江路桥】发往【 临海分拨中心】</li>
                </ul>
                <ul>
                    <li>2017-02-08 20:52:56</li>
                    <li>由【临海分拨陆运】发往【 广州分拨中心】</li>
                </ul>
                <ul>
                    <li>2017-02-10 01:13:30</li>
                    <li>由【广州分拨中心】发往【 增城永宁分部】</li>
                </ul>
                <ul>
                    <li>2017-02-10 08:39:15</li>
                    <li>快件已到达【增城永宁分部】 扫描员是【肖桂雄18566188784】上一站是【广州分拨中心】</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
