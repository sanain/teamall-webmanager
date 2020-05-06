<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},退货明细"/>
	<meta name="Keywords" content="${fns:getProjectName()},退货明细"/>
    <title>退货明细</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/return-particulars.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/barter-particulars.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
</head>
<body>
<input type="hidden" name="aftersaleid" id="aftersaleid" value="${aftersale.saleId}"/>
<input type="hidden" name="path" id="path" value="${ctxweb}"/>
    <div class="particulars">
        <div class="particulars-top">
            <span>您的位置：</span><a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">首页</a>>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">退货管理</a>><span>退货明细</span>
        </div>
        <div class="particulars-body">
            <p>当前退货单状态：<span>待审核</span></p>
            <a class="consent-a btn btn-primary" href="javascript:;">同意</a>
            <c:choose>
				<c:when test="${aftersale.takeStatus==2||aftersale.takeStatus==3||aftersale.takeStatus==4||aftersale.takeStatus==9}"></c:when>
			    <c:otherwise><a class="refuse-a btn btn-default" href="javascript:;">拒绝</a></c:otherwise>
			</c:choose>
        </div>
        <div class="particulars-foot">
            <p>退货人信息</p>
            <ul class="ren-ul">
                <li>联系人：<span>${aftersale.consigneeName}</span></li>
                <li>联系电话：<span>${aftersale.consigneePhone}</span></li>
                <li>买家物流公司：<span>${aftersale.logisticsCompany}</span></li>
                <li>买家发货运单号码：<span>${aftersale.trackCode}</span></li>
                <li>买家发货时间：
	                <span>
	                <c:choose>
			        	<c:when test="${aftersale.takeStatus==6}"><fmt:formatDate value="${aftersale.updateTime}" type="both"/></c:when>
			        	<c:otherwise></c:otherwise>
			        </c:choose>
				    </span>
                </li>
            </ul>
            <div class="dan-hao">
                <ul>
                    <li>售后编号：</li>
                    <li>${aftersale.saleNo}</li>
                </ul>
                <ul>
                    <li>买家是否已收到货：</li>
                    <li>
                    	<c:choose>
				        	<c:when test="${aftersale.refundEvidencePicUrl==0}">未发货</c:when>
				        	<c:when test="${aftersale.refundEvidencePicUrl==1}">未收货</c:when>
				        	<c:when test="${aftersale.refundEvidencePicUrl==2}">已收货</c:when>
				        	<c:otherwise></c:otherwise>
				        </c:choose>
					</li>
                </ul>
                <ul>
                    <li>退款/退货原因：</li>
                    <li>${aftersale.travelingApplicants}</li>
                </ul>
                <ul>
                    <li>退款说明：</li>
                    <li>${aftersale.refundExplain}</li>
                </ul>
                <ul>
                    <li>退款金额：</li>
                    <li>${aftersale.deposit}</li>
                </ul>
                <ul>
                    <li>申请时间：</li>
                    <li><fmt:formatDate value="${aftersale.applicationTime}" type="both"/></li>
                </ul>
            </div>
            
            <div class="shop-box">
                <ul class="shop-top">
                    <li>商品</li>
                    <li>商品属性</li>
                    <li>单价（元）</li>
                    <li>数量</li>
                </ul>
                <ul class="shop-list">
                    <li>
                        <div class="img-box">
	                        <c:choose>
				        		<c:when test="${empty aftersale.orderitem.productImg}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
				        		<c:otherwise><img src="${aftersale.orderitem.productImg}" alt=""></c:otherwise>
				        	</c:choose>
                        </div>
                        <span>${aftersale.orderitem.productName}</span>
                    </li>
                    <li>规格：${aftersale.orderitem.goodsWeight}</li>
                    <li>¥${aftersale.orderitem.goodsPrice}</li>
                    <li>${aftersale.orderitem.goodsNums}</li>
                </ul>
            </div>
            
        </div>
    </div>
    <div class="refuse">
        <div class="refuse-box">
            <p>拒绝说明<img class="refuse-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div class="refuse-div">
                <textarea id="recordContent" name="recordContent"></textarea>
                <br>
                <a class="store-as" href="javascript:;">提交</a>
            </div>
        </div>
    </div>
    <div class="consent">
        <div class="consent-box">
            <p>提示<img class="consent-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div class="consent-div">
                <span>是否要确认退款？退款金额¥<b>${aftersale.deposit}</b>元</span>
                <br>
                <a class="store-bc" href="javascript:;">确定</a>
                <a class="consent-del" href="javascript:;">取消</a>
            </div>
        </div>
    </div>
</body>
</html>