<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},退货管理"/>
	<meta name="Keywords" content="${fns:getProjectName()},退货管理"/>
    <title>退货管理</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/return-manage.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script src="${ctxStatic}/sbShop/js/return-manage.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/ReturnManagement/ReturnManagementList");
			$("#searchForm").submit();
		    return false;
		}
	</script>
	<style>
    	.house-list-body .list-right li:nth-child(1) div {
            line-height: normal;
            display: inline-block;
            position: relative;
            top: 11px;
        }

        #daochu,#btnSubmit{
            width: 50px;
            float:left;
            background-color: #393D49;
            border-color: #393D49;
            height: 30px;
            margin-left: 5px;
            padding-top: 4px;
            padding-left: 10px;
        }

        #btnSubmit{
            margin-left: 15px ;

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

        .house-list-body>p a:hover {
            color: #009688;
        }

        .house-list-body .list-right li:nth-child(3) div a {
            color: #009688;
        }
    </style>
</head>
<body>
<div class="house">
	<form class="form-horizontal" action="${ctxweb}/shop/ReturnManagement/ReturnManagementList" method="post" id="searchForm" name="form2">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="house-div">
            <ul>
                <li>退货单号：</li>
                <li><input id="saleNo" name="saleNo" value="${saleNo}" maxlength="20" type="text"></li>
            </ul>
            <ul>
                <li>申请时间：</li>
                <li>
                	<input class="startTime" name="startTime" value="${startTime}" pattern="yyyy-MM-dd" id="LAY_demorange_s" type="text">
                    <span>到</span>
					<input class="endTime" name="endTime" value="${endTime}" pattern="yyyy-MM-dd" id="LAY_demorange_e" type="text">
                </li>
            </ul>
            <ul>
                <li>订单编号：</li>
                <li>
                    <input id="orderNo" name="orderNo" maxlength="19" value="${orderNo}" type="text">
                </li>
            </ul>
            <ul>
                <li>买家：</li>
                <li>
                    <input id="mobileNo" name="mobileNo" maxlength="11" value="${mobileNo}" type="text">
                </li>
            </ul>
            <ul>
                <li>审核状态：</li>
                <li>
                    <select id="refundStatus" name=refundStatus>
                        <option value="0">全部</option>
                       	<option ${refundStatus=='1'?'selected':''} value="1">待卖家处理</option>
                        <option ${refundStatus=='2'?'selected':''} value="2">卖家已拒绝</option>
                        <option ${refundStatus=='3'?'selected':''} value="3">退款成功</option>
                        <option ${refundStatus=='4'?'selected':''} value="4">退款关闭</option>
                        <option ${refundStatus=='5'?'selected':''} value="5">待买家退货</option>
                        <option ${refundStatus=='6'?'selected':''} value="6">待卖家收货</option>
                        <option ${refundStatus=='7'?'selected':''} value="7">待买家收款</option>
                        <option ${refundStatus=='8'?'selected':''} value="8">待卖家退款</option>
                        <option ${refundStatus=='9'?'selected':''} value="9">平台已介入</option>
                    </select>
                </li>
            </ul>

            <ul class="sold-out two-btn-ul">
                <li style="width: 200px">
                    <a onclick="page()" id="btnSubmit" class="btn btn-primary" href="javascript:;">搜索</a>
                    <a class="chong btn btn-primary" id="daochu" href="javascript:;">重置</a>
                </li>
            </ul>

        </div>

        <ul class="house-list-top">
          <li>商品</li>
                <li>单价（元）</li>
                <li>数量</li>
                <li>买家</li>
                <li>是否收到货</li>
                <li>状态</li>
        </ul>
        <c:forEach items="${page.list}" var="list">
        <div class="list-box">
            <div class="house-list-body">
                <p>
                   <span>退货单编号：<a href="${ctxweb}/shop/ReturnManagement/ReturnManagementForm?id=${list.saleId}" target="tager">${list.saleNo}</a></span>
                   <span>订单编号：<a href="${ctxweb}/shop/PmShopOrders/orderDetail?orderId=${list.order.orderId}" target="tager">${list.order.orderNo}</a></span>
                   <span>申请时间：<fmt:formatDate value="${list.applicationTime}" type="both"/></span>
                </p>
                <ul class="list-left">
	                    <li>
	                        <ul>
	                            <li>
	                                <div class="img-kuang">
	                                <c:choose>
			        					<c:when test="${empty list.orderitem.productImg}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
			        					<c:when test="${list.orderitem.productImg=='null'}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
			        					<c:otherwise><img src="${list.orderitem.productImg}" alt=""></c:otherwise>
			        				</c:choose>
	                                </div>
	                                <u>${list.orderitem.productName}
	                                 <p><c:if test="${ not empty list.orderitem.standardName}">${list.orderitem.standardName}</c:if></p>
	                                </u>
	                            </li>
	                            <li>¥<b>${list.orderitem.realPrice}</b></li>
                            	<li>x${list.orderitem.goodsNums}</li>
	                        </ul>
	                    </li>
                </ul>
                <ul class="list-right">
                    <li>
                     <div>
		                    <span>${fns:getUser(list.order.userId).username}</span>
		                    <span>${list.order.mobile}</span>
	                    </div>
                    </li>
                    <li>
                    	<c:choose>
        					<c:when test="${list.takeStatus==0}">未发货</c:when>
        					<c:when test="${list.takeStatus==1}">未收货</c:when>
        					<c:when test="${list.takeStatus==2}">已收货</c:when>
        					<c:otherwise></c:otherwise>
        				</c:choose>
					</li>
                    <li>
                        <div>
                            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementForm?id=${list.saleId}" target="tager">详情</a>
                            <c:choose>
	        					<c:when test="${list.refundStatus==1}"><p>待卖家处理</p></c:when>
	        					<c:when test="${list.refundStatus==2}"><p>卖家已拒绝</p></c:when>
	        					<c:when test="${list.refundStatus==3}"><p>退款成功</p></c:when>
	        					<c:when test="${list.refundStatus==4}"><p>退款关闭</p></c:when>
	        					<c:when test="${list.refundStatus==5}"><p>待买家退货</p></c:when>
	        					<c:when test="${list.refundStatus==6}"><p>待卖家收货</p></c:when>
	        					<c:when test="${list.refundStatus==7}"><p>待买家收款</p></c:when>
	        					<c:when test="${list.refundStatus==8}"><p>待卖家退款</p></c:when>
	        					<c:when test="${list.refundStatus==9}"><p><font color=red>平台已介入</font></p></c:when>
	        					<c:otherwise></c:otherwise>
        					</c:choose>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
      </c:forEach>
	</form>
<div class="pagination">${page}</div>
</div>
</body>
</html>