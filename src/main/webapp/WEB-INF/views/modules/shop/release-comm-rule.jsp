<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
	
    <title>发布商品-规则</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/release-comm-rule.css?v=1">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
	<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
</head>
<body style="background: #F6F6F6;">
    <div class="comm-rule">
        <p>上传商品</p>
        <div class="rule-list">
           ${pmServiceProtocol.contentInfo}
        <div class="div-a">
            <a href="${ctxweb}/shop/product/addProduct">我已阅读平台规则，马上上传商品</a>
        </div>

    </div>
    </div>
</body>
</html>