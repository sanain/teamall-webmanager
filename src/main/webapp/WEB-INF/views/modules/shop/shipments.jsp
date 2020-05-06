<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},发货"/>
	<meta name="Keywords" content="${fns:getProjectName()},发货"/>
    <title>发货管理</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/shipments.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script src="${ctxStatic}/sbShop/js/shipments.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/PmShopOrders/orderList");
			$("#searchForm").submit();
		    return false;
		}
	</script>

    <style type="text/css">
        .search-a,.excel,.send-a{
            background-color: #393D49;
            border: 1px solid #393D49;
            height: 30px;
            margin-left: 5px;
            padding: 4px 10px;
        }
        .search-a,.excel{
            float:left;

        }

        .search-a{
            margin-left: 20px;
        }
        .send-a:hover,.search-a:hover,.excel:hover{
            background-color: #393D49;
            color: rgb(120,120,120);

        }
        .house{
            padding-top:0px;
            margin-top: -30px;
        }
        a{
            color: #009688;
        }
        a:hover{
            color: #009688;
        }
        .house-list-body>p a:hover{ color: #009688;}
    </style>
</head>
<body>
	<input class="ctxweb" id="ctxweb" name="ctxweb" type="hidden" value="${ctxweb}"/>
    <div class="house">
	<form class="form-horizontal" action="${ctxweb}/shop/PmShopOrders/orderList" method="post" id="searchForm" name="form2">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="house-div">
            <ul>
                <li>订单编号：</li>
                <li>
                    <input id="orderNo" name="orderNo" value="${orderNo }"  onkeyup="value=value.replace(/[^\d]/g,'')" beforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  type="text">
                </li>
            </ul>
            <ul>
                <li>创建时间：</li>
                <li>
                	<input class="startTime" name="startTime" value="${startTime}" pattern="yyyy-MM-dd" id="LAY_demorange_s" type="text">
                    <span>到</span>
					<input class="stopTime" name="stopTime" value="${stopTime}" pattern="yyyy-MM-dd" id="LAY_demorange_e" type="text">
                </li>
            </ul>

            <ul class="sold-out two-btn-ul">
                <li style="width: 300px">
                    <a class="search-a btn btn-primary" href="javascript:;" onclick="page()">搜索</a>
                    <a class="excel btn btn-primary" href="javascript:;">导出买家收货信息</a>
                </li>
            </ul>
        </div>
        <div class="two-btn">

        </div>
            <ul class="house-list-top">
                <li>商品信息</li>
                <li>买家收货信息</li>
            </ul>
        <div class="list-box">
        <c:forEach items="${page.list}" var="list">
            <div class="house-list-body">
                <p>
                    <span>订单编号：<a href="${ctxweb}/shop/PmShopOrders/orderDetail?orderId=${list.orderId}" target="tager">${list.orderNo}</a></span>
                    <span>创建时间：<span><fmt:formatDate value="${list.createTime}" type="both"/></span></span>
                    <span>买家：${list.mobile}</span>
                </p>
                <ul class="list-left">
                <c:forEach items="${list.ebOrderitems}" var="items">
	                    <li>
	                	<input id="standardName" name="standardName" type="hidden" value="${items.standardName}"/>
	                        <div class="img-kuang">
	                        	<c:choose>
				        			<c:when test="${empty items.productImg}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
				        			<c:when test="${items.productImg=='null'}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
				        			<c:otherwise><img src="${items.productImg}" alt=""></c:otherwise>
				        		</c:choose>
	                        </div>
	                        <ul>
	                            <li><span>${items.productName}</span> <b>¥${items.realPrice}
								
								<c:if test="${items.isSend==0 }">
								<font color="blue">(未发货)</font>
								</c:if>
								<c:if test="${items.isSend==1 }">
								<font color="green">(已发货)</font>
								</c:if>
								<c:if test="${items.isSend==2 }">
								(已收货)
								</c:if>
								<c:if test="${items.isSend==3 }">
								(已评价)
								</c:if>
								<c:if test="${items.isSend==4 }">
								<font color="red">(已退货)</font>
								</c:if>
								<c:if test="${items.isSend==5 }">
								<font color="red">(退货中)</font>
								</c:if>
								</b></li>
	                            <li><span >${items.standardName}</span> <b class="goodsNum">x${items.goodsNums}</b></li>
	                        </ul>
	                    </li>
				</c:forEach>
                </ul>
                <ul class="list-right">
                    <li>收货人：${list.acceptName}</li>
                    <li>手机：${fns:replaceMobile(list.telphone)}</li>
                    <li>收货地址：${list.deliveryAddress}</li>
                </ul>
                <div class="body-btn">
                    <span class="goodsNums"></span>
                    <c:if test="${list.status==2}">
                    <a class="btn btn-primary send-a" href="${ctxweb}/shop/PmShopOrders/orderfrom?orderId=${list.orderId}">发货</a>
                    </c:if>
                </div>
            </div>
		</c:forEach>
       </div>
       <div class="pagination">${page}</div>
     </form>
   </div>
</body>
</html>