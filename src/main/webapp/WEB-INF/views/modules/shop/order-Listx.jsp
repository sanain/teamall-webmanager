<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>已卖出商品</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale-comm.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
    <script src="${ctxStatic}/sbShop/js/sale-comm.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <style>
    .list-uu{width:100%}
    .list-uu li{height:35px;line-height:35px;}
    .list-uu li:nth-child(1){width:28%}
    	.list-uu li:nth-child(2){width:24%}
    	.list-uu li:nth-child(3){width:12%}
    	.list-uu li:nth-child(4){width:12%}
    	.list-uu li:nth-child(5){width:12%}
 	    .list-uu li:nth-child(6){width:12%}
    	body .house-list-top li:nth-child(2){width:24%}
    </style>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
</head>
<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/PmShopOrders/OrderListx");
			$("#searchForm").submit();
	    	return false;
	     }
	     $(function(){
	  		$('body').on('click','.chongzhi',function(){
	  			$('.house-div input').val('');
	  			$('.house-div select option:nth-child(1)').attr('selected','selected');
	  		});
	    })
</script>
<body>
    <div class="house">
       <form action="" id="searchForm" method="post" >
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="house-div">
            <ul>
                <li>订单编号：</li>
                <li>
                    <input  type="text" name="orderNo" value="${ebOrder.orderNo}">
                </li>
            </ul>
            <ul>
                <li>成交时间：</li>
                <li>
                    <input id="LAY_demorange_s" type="text" name="startTime" value="${startTime}">
                    <span>到</span>
                    <input id="LAY_demorange_e" type="text" name="stopTime" value="${stopTime}">
                </li>
            </ul>
            <ul>
                <li>买家：</li>
                <li>
                    <input type="number" name="mobile" value="${ebOrder.mobile}">
                </li>
            </ul>
           <ul>
                <li>订单状态：</li>
                <li>
                    <select name="status">
                         <option value="" <c:if test="${empty status}"> selected="selected"</c:if>>全部</option>
                        <option value="1" <c:if test="${status==1 }"> selected="selected"</c:if>>待付款</option>
                        <option value="2" <c:if test="${status==2 }"> selected="selected"</c:if>>待发货</option>
                        <option value="3" <c:if test="${status==3 }"> selected="selected"</c:if>>待收货</option>
                        <option value="4" <c:if test="${status==4 }"> selected="selected"</c:if>>交易成功</option>
                        <option value="5" <c:if test="${status==5 }"> selected="selected"</c:if>>已关闭</option>
                    </select>
                </li>
            </ul> 
            <ul class="sold-out">
                <li>支付方式：</li>
                <li>
                   <select name="payType">
                       <option value="">全部</option>  
                       <option <c:if test="${payType==1 }"> selected="selected"</c:if> value="1">货到付款</option>  
	                   <option <c:if test="${payType==2 }"> selected="selected"</c:if> value="2">支付宝支付</option>
	                   <option <c:if test="${payType==3 }"> selected="selected"</c:if> value="3">快钱支付 </option>
	                   <option <c:if test="${payType==4 }"> selected="selected"</c:if> value="4">银联支付 </option>
	                   <option <c:if test="${payType==5 }"> selected="selected"</c:if> value="5">微信支付</option>
	                   <option <c:if test="${payType==6 }"> selected="selected"</c:if> value="6">现场支付 </option>
	                   <option <c:if test="${payType==7 }"> selected="selected"</c:if> value="7">余额支付</option>
	                   <option <c:if test="${payType==8 }"> selected="selected"</c:if> value="8">汇卡支付</option>
					   <option <c:if test="${payType==52 }"> selected="selected"</c:if> value="52">H5微信支付</option>
                   </select>
                </li>
            </ul>
        </div>
        <div class="two-btn">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
            <input type="button"  value="重置" class="btn btn-primary chongzhi">
        </div>
        </form>
        <ul class="house-nav">
            <li <c:if test="${empty status}"> class="active" </c:if> ><a href="${ctxweb}/shop/PmShopOrders/OrderListx">近三个月订单</a></li>
            <li <c:if test="${status==1}"> class="active" </c:if> ><a href="${ctxweb}/shop/PmShopOrders/OrderListx?status=1">待付款</a></li>
            <li <c:if test="${status==4&&iv==0}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/OrderListx?status=4&iv=0">交易成功</a></li>
            <li <c:if test="${isEvaluation==0&&status==4&&iv==1}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/OrderListx?isEvaluation=0&status=4&iv=1">待评价</a></li>
            <li <c:if test="${status==5}"> class="active" </c:if>><a href="${ctxweb}/shop/PmShopOrders/OrderListx?status=5">已关闭</a></li>
        </ul>

            <ul class="house-list-top">
               <li>订单号</li>
                <li>创建时间</li>
                <li>买家</li>
                <li>交易状态</li>
                <li>实收款（元）</li>
                <li>操作</li>
            </ul>
        <div class="list-box">
          <c:forEach items="${page.list}" var="orderList">
            <div class="house-list-body">
                <ul class="list-uu">
                    <li>${orderList.orderNo}</li>
                    <li><fmt:formatDate value="${orderList.createTime}" type="both"/></li>
                    <li>
                      <span>(${fns:getUser(orderList.userId).username})</span>
                      <span>${orderList.mobile}</span>
                    </li>
                    <li><c:if test="${orderList.status==1}">等待买家付款</c:if><c:if test="${orderList.status==4}">交易成功，已完成</c:if><c:if test="${orderList.status==5}">已关闭</c:if></li>
                    <li>￥<fmt:formatNumber type="number" value="${orderList.orderAmount}" pattern="0.00" maxFractionDigits="2"/></li>
                    <li><a>不可操作</a></li>
                </ul>
            </div>
           </c:forEach>
       <div class="pagination">
         ${page}
        </div>
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
</body>
</html>