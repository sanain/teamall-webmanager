<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>商品评论</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/evaluate-details.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <style type="text/css">
    	.lx-mag ul li div img{width:30%;}
    </style>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
</head>
<body>
<form action="">
    <div class="company">
        <div class="jb-msg">
            <p>基本信息</p>
            <ul>
                <li>商品名称：</li>
                <li>${ebProductcomment.productname} ${ebProductcomment.standName}</li>
            </ul>
            <ul>
                <li>订单编号：</li>
                <li>${ebProductcomment.ebOrder.orderNo}</li>
            </ul>
            <ul>
                <li>评价人：</li>
                <li>${ebProductcomment.username}</li>
            </ul>
            <ul>
                <li>评价时间：</li>
                <li>${ebProductcomment.commentTime}</li>
            </ul>
        </div>

        <div class="lx-mag">
            <p>评价详情</p>
            <ul>
            	<li>评价：</li>
                <c:if test="${ebProductcomment.overallMerit==1}"><li>差评</li></c:if>
               	<c:if test="${ebProductcomment.overallMerit==5}"><li>好评</li></c:if>
               	<c:if test="${ebProductcomment.overallMerit>=2&&ebProductcomment.overallMerit<=4}"><li>中评</li></c:if>
            </ul>
            <ul>
                <li>评价内容：</li>
                <li>
                    <span>${ebProductcomment.contents}</span>
                    <div>
                    <c:forEach var="bean" items="${fn:split(ebProductcomment.picture,'|')}">
						 <img src="${bean}" alt="">
						</c:forEach>
                       <!-- 
                        <img src="images/lishi.png" alt="">
                        <img src="images/lishi.png" alt=""> -->
                    </div>
                </li>
            </ul>
        </div>
    </div>
</form>



</body>
</html>