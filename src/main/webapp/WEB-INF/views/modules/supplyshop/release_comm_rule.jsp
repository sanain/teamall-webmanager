<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <title>发布商品-规则</title>
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/release-comm-rule.css">
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/bootstrap.min.css">
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
</head>
<body style="background: #F6F6F6;">
    <div class="comm-rule">
        <p>上传商品</p>
        <div class="rule-list">
           ${addProductpmServiceProtocol.contentInfo}
        <div class="div-a">
            <a href="${ctxweb}/supplyshop/supplyShopproduct/addProduct">我已阅读平台规则，马上上传商品</a>
        </div>

    </div>
</body>
</html>