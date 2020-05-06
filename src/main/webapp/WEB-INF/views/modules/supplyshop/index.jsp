<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>${fns:getProjectName()}供应商中心</title>
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/index.css">
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/bootstrap.min.css">
    <script src="${ctxStatic}/supplyshop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/supplyshop/js/issue-classification.js"></script>
</head>
<body style="background: #E3E4E5;">
    <!--头部固定-->
    <div class="head">
    	<ul class="list-ul" style="padding-left: 10px">
               
                <li>
                    <a href="${ctxweb}/supplyshop/supplyShopproduct/addShow" target="tager">商品上传</a>
                </li>
                <li>
                    <a href="${ctxweb}/supplyshop/supplyShopproduct/list3?prdouctStatus=1"  target="tager">商品管理</a>
                </li>
            </ul>
    
        <ul>
            <li>您好！<span>${supplyshopuser.mobile} 供应商</span> 欢迎来到${fns:getProjectName()}</li>
            <li>
                <a class="quit-a" href="${ctxweb}/supplyShop/outLogin">退出登录</a>
            </li>
        </ul>
    </div>
		
		<iframe name="tager" src="${ctxweb}/supplyshop/supplyShopproduct/addShow" frameborder="0" style="width: 100%;padding: 80px 20px 0 20px;background: #E3E4E5;"></iframe>
</body>
</html>